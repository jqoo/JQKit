//
//  NSString+JQKit.h
//  JQKit
//
//  Created by zhangjinquan on 2019/11/26.
//

#import <Foundation/Foundation.h>

@interface NSString (JQKit)

/// 字符串中的参数替换
/// 如 '/api/publish/{userId}/{fileId}', 指定参数模式 '\\{(.+?)\\}' 和 映射块，即可得到需要的字符串
/// @param pattern 参数模式
/// @param mappingBlock 映射块
- (NSString *)jqk_stringByReplacingArgumentsWithPattern:(NSString *)pattern mappingBlock:(NSString * (^)(NSString *key))mappingBlock;

/// 字符串中的参数替换
/// @param args 参数:值 的映射表
/// @param pattern 参数模式
- (NSString *)jqk_stringByReplacingArguments:(NSDictionary *)args pattern:(NSString *)pattern;

/// 字符串中的参数替换

/// 字符串中的参数替换，默认以 '\\{(.+?)\\}' 作为参数模式
/// @param args 参数:值 的映射表
- (NSString *)jqk_stringByReplacingArguments:(NSDictionary *)args;

/// 字符串中的参数替换，默认以 '\\{(.+?)\\}' 作为参数模式
/// @param mappingBlock 映射块
- (NSString *)jqk_stringByReplacingArgumentsWithMappingBlock:(NSString * (^)(NSString *key))mappingBlock;

@end
