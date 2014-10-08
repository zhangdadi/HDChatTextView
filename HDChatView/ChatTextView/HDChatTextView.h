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
@optional

//======功能相关==========

//开始录音，按住录音按钮时回调
- (void)chatTextViewStartRecord:(HDChatTextView *)chatTextView;

//结束录音，松开录音按钮时回调
- (void)chatTextViewStopRecord:(HDChatTextView *)chatTextView;

//发送消息，点击发送按时时回调
- (void)chatTextView:(HDChatTextView *)chatTextView sendMessage:(NSString *)message;

//发送图片
- (void)chatTextView:(HDChatTextView *)chatTextView sengImage:(UIImage *)image;

@end

@interface HDChatTextView : UIView

/**
 *  创建方法
 *
 *  @param tableView 聊天窗口的tableView
 *
 *  @return 本对象
 */
+ (instancetype)creatInTableView:(UITableView *)tableView;

//委托
@property (nonatomic, weak) id<HDChatTextViewDelegate> delegate;

//输入框内容
@property (nonatomic, strong) NSString *text;

@property (nonatomic, assign) BOOL isHideRecord; //是否隐藏语音按钮，默认为NO。

@property (nonatomic, assign) BOOL isHideMore; //是否隐藏更多按钮，默认为NO;

//即将被显式的时候调用
- (void)viewWillAppear;
//即将被隐藏的时候调用
- (void)viewWillDisappear;
//需要隐藏键盘时调用
- (void)hideKey;

@end
