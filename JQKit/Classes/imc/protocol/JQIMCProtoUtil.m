//
//  JQIMCProtoUtil.m
//  JQKit
//
//  Created by zhangjinquan on 2019/11/27.
//

#import "JQIMCProtoUtil.h"
#import "JQMachOUtil.h"

@implementation JQIMCProtoUtil

+ (void)load {
    [JQMachOUtil enumerateSectionData:@"__jqkit" category:@"protocol" usingBlock:^(NSString *key, NSString *className, BOOL *stop) {
        id handler = [[NSClassFromString(className) alloc] init];
        Protocol *proto = NSProtocolFromString(key);
        
        NSAssert(handler != nil, @"handler not found for class: %@", className);
        NSAssert(proto != nil, @"protocol not found for name: %@", key);
        
        [JQIMCProtoHandlerFactory registerHandler:handler withProtocol:proto];
    }];
}

@end
