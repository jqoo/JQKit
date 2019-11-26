//
//  JQErrorReporter.m
//  JQKit
//
//  Created by zhangjinquan on 2019/11/26.
//

#import "JQErrorReporter.h"

@implementation JQErrorReporter
{
    NSMutableArray *_handlers;
}

+ (instancetype)sharedReporter {
    static JQErrorReporter *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JQErrorReporter alloc] init];
    });
    return instance;
}

- (NSMutableArray *)handlers {
    if (!_handlers) {
        _handlers = [NSMutableArray array];
    }
    return _handlers;
}

+ (void)addHandler:(id<JQErrorReportHandlerProtocol>)handler {
    [[[self sharedReporter] handlers] addObject:handler];
}

+ (void)reportError:(NSError *)error {
    for (id<BFErrorReportHandler> handler in [[self sharedReporter] handlers]) {
        [handler handleError:error];
    }
}

+ (void)reportException:(NSException *)exception {
    for (id<BFErrorReportHandler> handler in [[self sharedReporter] handlers]) {
        [handler handleException:exception];
    }
}

+ (void)reportErrorWithReason:(NSString *)reason desc:(NSString *)desc code:(NSInteger)code domain:(NSString * _Nullable)domain {
    if (!domain) {
        domain = @"JQUnknownDomain";
    }
    [self reportError:[NSError errorWithDomain:domain code:code
                                      userInfo:@{
                                                 NSLocalizedFailureReasonErrorKey: reason ?: @"Unknown reason",
                                                 NSLocalizedDescriptionKey: desc ?: @""
                                                 }]];
}

+ (void)reportErrorWithReason:(NSString *)reason desc:(NSString *)desc code:(NSInteger)code {
    [self reportErrorWithReason:reason desc:desc code:code domain:nil];
}

+ (void)reportErrorWithReason:(NSString *)reason desc:(NSString *)desc {
    [self reportErrorWithReason:reason desc:desc code:-1 domain:nil];
}

@end
