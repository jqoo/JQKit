//
//  JQIMCProtoHandlerFactory.h
//  JQKit
//
//  Created by zhangjinquan on 2019/11/27.
//

#import <Foundation/Foundation.h>

@interface JQIMCProtoHandlerFactory : NSObject

+ (void)registerHandler:(id)handler withProtocol:(Protocol *)protocol;

+ (id)handlerForProtocol:(Protocol *)protocol;

@end
