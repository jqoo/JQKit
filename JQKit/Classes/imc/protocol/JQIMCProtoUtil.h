//
//  JQIMCProtoUtil.h
//  JQKit
//
//  Created by zhangjinquan on 2019/11/27.
//

#import <Foundation/Foundation.h>

#import "JQMacro.h"
#import "JQIMCProtoHandlerFactory.h"

// bind
#define JQK_BIND_PROTOCOL(protoname, classname) \
    JQK_BIND_CLASS(protocol, protoname, classname)

// get
#define JQK_IMC_HANDLER(protoname) \
    ((id<protoname>)[JQIMCProtoHandlerFactory handlerForProtocol:@protocol(protoname)])

@interface JQIMCProtoUtil : NSObject

@end
