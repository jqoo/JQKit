//
//  JQMachOUtil.h
//  JQKit
//
//  Created by zhangjinquan on 2019/11/27.
//

#import <Foundation/Foundation.h>

@interface JQMachOUtil : NSObject

+ (void)enumerateSectionData:(NSString *)sectname usingBlock:(void (^)(const char *segment, BOOL *stop))block;

+ (void)enumerateSectionData:(NSString *)sectname category:(NSString *)category usingBlock:(void (^)(NSString *key, NSString *className, BOOL *stop))block;

@end
