//
//  HDChatTextView.m
//  TextViewDemo
//
//  Created by zhangdadi on 14-5-16.
//  Copyright (c) 2014年 zhangdadi. All rights reserved.
//

#define KRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define KRGB(r, g, b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(1.0)]

#import "HDChatTextView.h"
#import <QuartzCore/QuartzCore.h>

@interface HDChatTextView () <UITextViewDelegate>

@property (nonatomic, strong) UIButton *soundButton;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation HDChatTextView

- (id)initWithFrame:(CGRect)frame
{
    frame.size.height = 50;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self creatInterface];
    }
    return self;
}

- (void)creatInterface {
    self.backgroundColor = KRGB(21, 135, 221);
    
    //语音按钮
    CGRect frame = CGRectMake(-10, 0, 77, 49);
    self.soundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_soundButton setImage:[UIImage imageNamed:@"dh_btn_mic"] forState:UIControlStateNormal];
    [_soundButton setImage:[UIImage imageNamed:@"dh_btn_micOver"] forState:UIControlStateHighlighted];
    _soundButton.frame = frame;
    [_soundButton addTarget:self action:@selector(beginRecord:) forControlEvents:UIControlEventTouchDown];
    [_soundButton addTarget:self action:@selector(endRecord:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_soundButton];
    
    //发送按钮
    frame.origin.y = 10;
    frame.size.width = 60;
    frame.origin.x = self.frame.size.width - frame.size.width - 10;
    frame.size.height = 30;
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendButton.frame = frame;
    _sendButton.enabled = NO;
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [_sendButton setTitleColor:KRGB(33, 33, 33) forState:UIControlStateNormal];
    [_sendButton setBackgroundImage:[UIImage imageNamed:@"dh_btn_send.png"] forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:_sendButton];
    
    //输入框
    frame.origin.x = _soundButton.frame.origin.x + _soundButton.frame.size.width - 10;
    frame.origin.y = 10;
    frame.size.width = self.frame.size.width - frame.origin.x - _sendButton.frame.size.width - 20;
    self.textView = [[UITextView alloc] initWithFrame:frame];
    _textView.showsVerticalScrollIndicator = YES;
    _textView.showsHorizontalScrollIndicator = YES;
    _textView.layer.cornerRadius = 6;
    _textView.layer.masksToBounds = YES;
    _textView.delegate = self;
    [self addSubview:_textView];
    
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([_delegate respondsToSelector:@selector(chatTextViewStartEditing:)]) {
        [_delegate chatTextViewStartEditing:self];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([_delegate respondsToSelector:@selector(chatTextViewEndEditing:)]) {
        [_delegate chatTextViewEndEditing:self];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    self.text = textView.text;
    if ([_text isEqualToString:@""]) {
        _sendButton.enabled = NO;
    } else {
        _sendButton.enabled = YES;
    }

    int addNum = 1;
    NSString *tempText = _text;
    
    //计算回车换行符的个数
    while (true) {
        NSRange range = [tempText rangeOfString:@"\n"];
        if (range.length > 0) {
            addNum++;
            
            //计算换行符间字符串的高度
            NSString *toIndexText = [tempText substringToIndex:range.location];
            CGSize toIndexSize = [toIndexText sizeWithFont:[textView font]];
            addNum += toIndexSize.width / 188;
            tempText = [tempText substringFromIndex:range.location + range.length];
        } else {
            break;
        }
    }
    
    CGSize size = [tempText sizeWithFont:[textView font]];
    int oneTextHeight = size.height;
    int textNumber = size.width / 188 + addNum;
    [self setPostionForTextNumber:textNumber oneTextHeight:oneTextHeight];
}

#pragma mark -

- (void)beginRecord:(id)sender {
    if ([_delegate respondsToSelector:@selector(chatTextViewStartRecord:)]) {
        [_delegate chatTextViewStartRecord:self];
    }
}

- (void)endRecord:(id)sender {
    if ([_delegate respondsToSelector:@selector(chatTextViewStopRecord:)]) {
        [_delegate chatTextViewStopRecord:self];
    }
}

- (void)sendButtonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(chatTextView:sendMessage:)]) {
        [_delegate chatTextView:self sendMessage:_textView.text];
    }
    _textView.text = nil;
}

- (void)setPostionForTextNumber:(int)number oneTextHeight:(int)oneTextHeight {
    if (number <= 0 || number > 4) {
        return;
    }
    static int lastNumber = 1;
    if (number == lastNumber)
        return;
    
    NSInteger changeHeight = oneTextHeight * (number - lastNumber);
    lastNumber = number;
    
    CGRect frame = self.frame;
    frame.origin.y -= changeHeight;
    frame.size.height += changeHeight;
    self.frame = frame;
    
    frame = _textView.frame;
    frame.size.height += changeHeight;
    _textView.frame = frame;
    
    frame = _soundButton.frame;
    frame.origin.y += changeHeight;
    _soundButton.frame = frame;
    
    frame = _sendButton.frame;
    frame.origin.y += changeHeight;
    _sendButton.frame = frame;
    
    if ([_delegate respondsToSelector:@selector(chatTextView:heightChange:)]) {
        [_delegate chatTextView:self heightChange:changeHeight];
    }
}

@end
