//
//  JQHigherOrderFunctions.m
//  JQKit
//
//  Created by zhangjinquan on 2019/11/27.
//

#import "JQHigherOrderFunctions.h"

@implementation NSArray (JQHigherOrderFunctions)

- (NSArray *)jqk_map:(id (^)(id obj))block {
    if (!block) {
        return [self copy];
    }
    NSMutableArray *arr = [NSMutableArray array];
    for (id obj in self) {
        id result = block(obj);
        if (result) {
            [arr addObject:result];
        }
    }
    return [arr copy];
}

- (NSArray *)jqk_filter:(BOOL (^)(id obj))block {
    if (!block) {
        return [self copy];
    }
    NSMutableArray *arr = [NSMutableArray array];
    for (id obj in self) {
        if (block(obj)) {
            [arr addObject:obj];
        }
    }
    return [arr copy];
}

- (id)jqk_reduce:(id)initial combine:(id (^)(id accumulator, id obj))combine {
    if (!combine) {
        return initial;
    }
    for (id obj in self) {
        initial = combine(initial, obj);
    }
    return initial;
}

- (BOOL)jqk_contains:(BOOL(^)(id obj))block {
    if (!block) {
        return NO;
    }
    for (id obj in self) {
        if (block(obj)) {
            return YES;
        }
    }
    return NO;
}

- (void)jqk_forEach:(void (^)(id obj))block {
    if (!block) {
        return;
    }
    for (id obj in self) {
        block(obj);
    }
}

@end

@implementation NSDictionary (JQHigherOrderFunctions)

- (NSDictionary *)jqk_map:(id (^)(id key, id obj))block {
    if (!block) {
        return [self copy];
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        id result = block(key, obj);
        if (result) {
            [dict setObject:result forKey:key];
        }
    }];
    return [dict copy];
}

- (NSDictionary *)jqk_filter:(BOOL (^)(id key, id obj))block {
    if (!block) {
        return [self copy];
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (block(key, obj)) {
            [dict setObject:obj forKey:key];
        }
    }];
    return [dict copy];
}

- (id)jqk_reduce:(id)initial combine:(id (^)(id accumulator, id key, id obj))combine {
    if (!combine) {
        return initial;
    }
    __block id result = initial;
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        result = combine(result, key, obj);
    }];
    return result;
}

- (BOOL)jqk_contains:(BOOL(^)(id key, id obj))block {
    if (!block) {
        return NO;
    }
    __block BOOL result = NO;
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        result = block(key, obj);
        if (result) {
            *stop = YES;
        }
    }];
    return result;
}

- (void)jqk_forEach:(void (^)(id key, id obj))block {
    if (!block) {
        return;
    }
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        block(key, obj);
    }];
}

@end
