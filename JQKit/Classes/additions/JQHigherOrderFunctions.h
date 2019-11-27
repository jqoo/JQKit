//
//  JQHigherOrderFunctions.h
//  JQKit
//
//  Created by zhangjinquan on 2019/11/27.
//

#import <Foundation/Foundation.h>

@interface NSArray<ObjectType> (JQHigherOrderFunctions)

- (NSArray *)jqk_map:(ObjectType (^)(ObjectType obj))block;

- (NSArray *)jqk_filter:(BOOL (^)(ObjectType obj))block;

- (id)jqk_reduce:(id)initial combine:(id (^)(id accumulator, ObjectType obj))combine;

- (BOOL)jqk_contains:(BOOL(^)(ObjectType obj))block;

- (void)jqk_forEach:(void (^)(ObjectType obj))block;

@end

@interface NSDictionary <KeyType, ObjectType> (JQHigherOrderFunctions)

- (NSDictionary *)jqk_map:(ObjectType (^)(KeyType key, ObjectType obj))block;

- (NSDictionary *)jqk_filter:(BOOL (^)(KeyType key, ObjectType obj))block;

- (id)jqk_reduce:(id)initial combine:(id (^)(id accumulator, KeyType key, ObjectType obj))combine;

- (BOOL)jqk_contains:(BOOL(^)(KeyType key, ObjectType obj))block;

- (void)jqk_forEach:(void (^)(KeyType key, ObjectType obj))block;

@end
