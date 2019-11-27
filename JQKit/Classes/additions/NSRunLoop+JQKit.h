//
//  NSRunLoop+JQKit.h
//  JQKit
//
//  Created by zhangjinquan on 2019/11/27.
//

#import <Foundation/Foundation.h>

@interface NSRunLoop (JQKit)

/**
 将异步任务模态化
 在不阻塞当前线程的前提下，等待异步操作完成后，再继续执行。异步操作完成后
 异步任务在block中执行，并在任务完成后，调用 finish() 即可不再等待。
 
 与信号量操作dispatch_semaphore_wait不同，本函数不会阻塞当前线程
 如：
 __block PHAuthorizationStatus resultStatus = [PHPhotoLibrary authorizationStatus];
 [[NSRunLoop mainRunLoop] jqk_modalifyAsyncTask:^(dispatch_block_t finish){
     [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
         resultStatus = status;
         finish();
     }];
 }];
 主线程虽然在等待异步任务完成，但主线程的事件依然能够得到及时的响应
 */
- (void)jqk_modalifyAsyncTask:(void (^)(dispatch_block_t finish))block;
- (void)jqk_modalifyAsyncTask:(void (^)(dispatch_block_t finish))block timeout:(NSTimeInterval)timeout;
- (void)jqk_modalifyAsyncTask:(void (^)(dispatch_block_t finish))block untilDate:(NSDate *)untilDate;

@end
