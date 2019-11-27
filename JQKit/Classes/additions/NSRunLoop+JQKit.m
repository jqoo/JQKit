//
//  NSRunLoop+JQKit.m
//  JQKit
//
//  Created by zhangjinquan on 2019/11/27.
//

#import "NSRunLoop+JQKit.h"

@implementation NSRunLoop (JQKit)

- (void)jqk_modalifyAsyncTask:(void (^)(dispatch_block_t finish))block {
    [self jqk_modalifyAsyncTask:block untilDate:nil];
}

- (void)jqk_modalifyAsyncTask:(void (^)(dispatch_block_t finish))block timeout:(NSTimeInterval)timeout {
    [self jqk_modalifyAsyncTask:block untilDate:[NSDate dateWithTimeInterval:timeout sinceDate:[NSDate date]]];
}

- (void)jqk_modalifyAsyncTask:(void (^)(dispatch_block_t finish))block untilDate:(NSDate *)untilDate {
    if (!block) {
        return;
    }
    if (untilDate == nil) {
        untilDate = [NSDate distantFuture];
    }
    __block BOOL finish = NO;
    block(^{
        finish = YES;
    });
    while(!finish) {
        [self runMode:NSDefaultRunLoopMode beforeDate:untilDate];
    }
}

@end
