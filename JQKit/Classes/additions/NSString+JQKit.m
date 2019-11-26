//
//  NSString+JQKit.m
//  JQKit
//
//  Created by zhangjinquan on 2019/11/26.
//

#import "NSString+JQKit.h"

@implementation NSString (JQKit)

- (NSString *)jqk_stringByReplacingArgumentsWithPattern:(NSString *)pattern mappingBlock:(NSString * (^)(NSString *key))mappingBlock {
    if (pattern == nil || mappingBlock == nil) {
        return self;
    }
    NSMutableString *resultText = [NSMutableString string];
    NSUInteger totalLength = [self length];
    NSRange range = NSMakeRange(0, totalLength);
    NSError *error = nil;
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:&error];
    while (range.length > 0) {
        NSTextCheckingResult *result = [regex firstMatchInString:self options:0 range:range];
        
        if (result.numberOfRanges > 0) {
            [resultText appendString:[self substringWithRange:NSMakeRange(range.location, result.range.location - range.location)]];
            BOOL replaced = NO;
            if (result.numberOfRanges > 1) {
                NSRange r = [result rangeAtIndex:1];
                NSString *key = [self substringWithRange:r];
                id value = mappingBlock(key);
                if (value) {
                    if ([value isKindOfClass:[NSString class]]) {
                        [resultText appendString:value];
                    }
                    else {
                        [resultText appendFormat:@"%@", value];
                    }
                    replaced = YES;
                }
            }
            if (!replaced) {
                [resultText appendString:[self substringWithRange:result.range]];
            }
            range.location = NSMaxRange(result.range);
        }
        else {
            [resultText appendString:[self substringWithRange:range]];
            range.location = NSMaxRange(range);
        }
        range.length = totalLength - range.location;
    }
    return resultText;
}

- (NSString *)jqk_stringByReplacingArguments:(NSDictionary *)args pattern:(NSString *)pattern {
    return [self jqk_stringByReplacingArgumentsWithPattern:pattern mappingBlock:^NSString *(NSString *key) {
        return args[key];
    }];
}

- (NSString *)jqk_stringByReplacingArguments:(NSDictionary *)args {
    return [self jqk_stringByReplacingArguments:args pattern:@"\\{(.+?)\\}"];
}

- (NSString *)jqk_stringByReplacingArgumentsWithMappingBlock:(NSString * (^)(NSString *key))mappingBlock {
    return [self jqk_stringByReplacingArgumentsWithPattern:@"\\{(.+?)\\}" mappingBlock:mappingBlock];
}

@end
