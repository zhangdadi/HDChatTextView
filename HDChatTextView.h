//
//  HDChatTextView.h
//  TextViewDemo
//
//  Created by zhangdadi on 14-5-16.
//  Copyright (c) 2014年 zhangdadi. All rights reserved.
//
//  版本号：V1.0

#import <UIKit/UIKit.h>
@class HDChatTextView;

@protocol HDChatTextViewDelegate <NSObject>

//开始录音
- (void)chatTextViewStartRecord:(HDChatTextView *)chatTextView;

//结束录音
- (void)chatTextViewStopRecord:(HDChatTextView *)chatTextView;

//发送消息
- (void)chatTextView:(HDChatTextView *)chatTextView sendMessage:(NSString *)message;

//高度变化
- (void)chatTextView:(HDChatTextView *)chatTextView heightChange:(NSInteger)changeHeight;

@end

@interface HDChatTextView : UIView

//委托
@property (nonatomic, weak) id<HDChatTextViewDelegate> delegate;

//输入框内容
@property (nonatomic, strong) NSString *text;

@end
