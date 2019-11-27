//
//  JQIMCProtoHandlerFactory.m
//  JQKit
//
//  Created by zhangjinquan on 2019/11/27.
//

#import "JQIMCProtoHandlerFactory.h"

@implementation JQIMCProtoHandlerFactory

+ (void)run:(void (^)(NSMutableDictionary *map))blk {
    if (blk) {
        static NSMutableDictionary *map;
        @synchronized (self) {
            if (map == nil) {
                map = [NSMutableDictionary dictionary];
            }
            blk(map);
        }
    }
}

+ (void)registerHandler:(id)handler withProtocol:(Protocol *)protocol {
    if (!protocol || !handler) {
        return;
    }
    [self run:^(NSMutableDictionary *map) {
        [map setObject:handler forKey:NSStringFromProtocol(protocol)];
    }];
}

+ (id)handlerForProtocol:(Protocol *)protocol {
    __block id handler = nil;
    [self run:^(NSMutableDictionary *map) {
        handler = [map objectForKey:NSStringFromProtocol(protocol)];
    }];
    return handler;
}

@end
