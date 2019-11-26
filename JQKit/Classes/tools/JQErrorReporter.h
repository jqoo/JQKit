//
//  JQErrorReporter.h
//  JQKit
//
//  Created by zhangjinquan on 2019/11/26.
//

#import <Foundation/Foundation.h>

@protocol JQErrorReportHandlerProtocol <NSObject>

- (void)handleError:(NSError *)error;
- (void)handleException:(NSException *)exception;

@end

@interface JQErrorReporter : NSObject

+ (void)addHandler:(id<JQErrorReportHandlerProtocol>)handler;

+ (void)reportError:(NSError *)error;
+ (void)reportException:(NSException *)exception;

+ (void)reportErrorWithReason:(NSString *)reason desc:(NSString *)desc code:(NSInteger)code domain:(NSString * _Nullable)domain;
+ (void)reportErrorWithReason:(NSString *)reason desc:(NSString *)desc code:(NSInteger)code;
+ (void)reportErrorWithReason:(NSString *)reason desc:(NSString *)desc;

@end
