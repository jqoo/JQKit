//
//  JQMachOUtil.m
//  JQKit
//
//  Created by zhangjinquan on 2019/11/27.
//

#import "JQMachOUtil.h"

#import <mach-o/getsect.h>
#import <mach-o/dyld.h>

#ifndef __LP64__
    #define mach_header_ mach_header
#else
    #define mach_header_ mach_header_64
#endif

static BOOL jq_start_with(const char *str, const char *sub) {
    while (*str && *sub && *str == *sub) {
        str++;
        sub++;
    }
    return *sub == 0;
}

@implementation JQMachOUtil

#ifdef DEBUG

+ (void)load {
    NSMutableDictionary *map = [NSMutableDictionary dictionary];
    [self enumerateSectionData:@"__jqkit" usingBlock:^(const char *segment, BOOL *stop) {
        NSString *line = [NSString stringWithUTF8String:segment];
        NSArray *comps = [line componentsSeparatedByString:@"&"];
        NSString *category = [comps count] > 0 ? comps[0] : nil;
        NSString *key = [comps count] > 1 ? comps[1] : nil;;
        NSString *className = [comps count] > 2 ? comps[2] : nil;;
        if (category && key) {
            NSString *k = [NSString stringWithFormat:@"%@:%@", category, key];
            NSAssert(map[k] == nil, @"category: %@, key: %@, mapping to multi classnames: %@ and %@", category, key, map[k], className);
            map[k] = className;
        }
    }];
}

#endif

+ (void)enumerateSectionData:(NSString *)sectname usingBlock:(void (^)(const char *segment, BOOL *stop))block {
    if (!block) {
        return;
    }
    const char *appPath = [[[NSBundle mainBundle] bundlePath] UTF8String];
    uint32_t count = _dyld_image_count();
    BOOL stop = NO;
    for (uint32_t i = 0 ; i < count && !stop; i ++) {
        const struct mach_header_* header = (void*)_dyld_get_image_header(i);
        const char *path = _dyld_get_image_name(i);
        if (jq_start_with(path, appPath)) {
            unsigned long size = 0;
            uint8_t *data = getsectiondata(header, "__DATA", [sectname UTF8String], &size);
            if (data && size > 0) {
                void **pointers = (void **)data;
                uint32_t count = (uint32_t)(size / sizeof(void*));
                for (uint32_t i = 0 ; i < count && !stop ; i ++) {
                    block((const char *)pointers[i], &stop);
                }
            }
        }
    }
}

+ (void)enumerateSectionData:(NSString *)sectname category:(NSString *)category usingBlock:(void (^)(NSString *key, NSString *className, BOOL *stop))block {
    if (!block) {
        return;
    }
    char buf[256] = {0};
    const char *prefix = buf;
    
    strcpy(buf, [category UTF8String]);
    strcat(buf, "&");
    
    [self enumerateSectionData:sectname usingBlock:^(const char *segment, BOOL *stop) {
        if (jq_start_with(segment, prefix)) {
            NSString *line = [NSString stringWithUTF8String:segment];
            NSArray *comps = [line componentsSeparatedByString:@"&"];
            NSString *key = [comps count] > 1 ? comps[1] : nil;;
            NSString *className = [comps count] > 2 ? comps[2] : nil;;
            block(key, className, stop);
        }
    }];
}

@end
