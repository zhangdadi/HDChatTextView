//
//  HDChatTextView.h
//  TextViewDemo
//
//  Created by zhangdadi on 14-5-16.
//  Copyright (c) 2014年 zhangdadi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDChatTextView;

@protocol HDChatTextViewDelegate <NSObject>

//开始录音，按住录音按钮时回调
- (void)chatTextViewStartRecord:(HDChatTextView *)chatTextView;

//结束录音，松开录音按钮时回调
- (void)chatTextViewStopRecord:(HDChatTextView *)chatTextView;

//发送消息，点击发送按时时回调
- (void)chatTextView:(HDChatTextView *)chatTextView sendMessage:(NSString *)message;

//chatTextView的高度变化时回调
- (void)chatTextView:(HDChatTextView *)chatTextView heightChange:(NSInteger)changeHeight;

//进入编辑，键盘显示时回调
- (void)chatTextViewStartEditing:(HDChatTextView *)chatTextView;

//结束编辑，键盘隐藏时回调
- (void)chatTextViewEndEditing:(HDChatTextView *)chatTextView;

@end

@interface HDChatTextView : UIView

//委托
@property (nonatomic, weak) id<HDChatTextViewDelegate> delegate;

//输入框内容
@property (nonatomic, strong) NSString *text;

@end
