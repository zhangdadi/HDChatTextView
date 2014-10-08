//
//  HDChatTextView.m
//  TextViewDemo
//
//  Created by zhangdadi on 14-5-16.
//  Copyright (c) 2014年 zhangdadi. All rights reserved.
//
//  若发现bug请致电:z_dadi@163.com,在此感谢你的支持。
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


#define KRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define KRGB(r, g, b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(1.0)]
NSInteger const chatTextHeight = 51;

#import "HDChatTextView.h"
#import <QuartzCore/QuartzCore.h>
#import "HDChatMoreView.h"

@interface HDChatTextView ()<UITextViewDelegate, HDChatMoreViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    CGRect _statFrame;
    int _lastNumber;
    BOOL _isShowMore;
    NSInteger _showHeight; //当前显示到界面的高度
    BOOL _isFirstGo; //是否第一次进来
    HDChatMoreView *_moreView;
}

@property (nonatomic, strong) UIButton *soundButton;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *recordButton;
@property (nonatomic, weak)  UITableView *chatTableView;
@property (nonatomic, assign) CGRect firstChatTableFrame;

@end

@implementation HDChatTextView

- (id)initWithFrame:(CGRect)frame
{
    frame.size.height = chatTextHeight + 216;
    self = [super initWithFrame:frame];
    if (self) {
     [self creatInterface];
    }
    return self;
}

+ (instancetype)creatInTableView:(UITableView *)tableView {
    CGRect frame = tableView.frame;
    frame.size.height -= chatTextHeight;
    tableView.frame = frame;
    
    frame.origin.y = frame.origin.y + frame.size.height;
    frame.size.height = chatTextHeight;
    HDChatTextView *chatText = [[HDChatTextView alloc] initWithFrame:frame];
    chatText.chatTableView = tableView;
    chatText.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    return chatText;
}


- (void)creatInterface {
    _isFirstGo = YES;
    self.backgroundColor =  KRGB(250, 250, 250);
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    lineView.backgroundColor = KRGB(191, 191, 191);
    lineView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:lineView];
    
    //语音按钮
    CGRect frame = CGRectMake(-10, 0, 77, 49);
    self.soundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_soundButton setImage:[UIImage imageNamed:@"chat_voice"] forState:UIControlStateNormal];
    _soundButton.frame = frame;
    _soundButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [_soundButton addTarget:self action:@selector(swiftRecord:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_soundButton];
    
    //更多按钮
    frame.origin.y = 5;
    frame.size.width = 50;
    frame.origin.x = self.frame.size.width - frame.size.width - 5;
    frame.size.height = 40;
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendButton.frame = frame;
    _sendButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [_sendButton setImage:[UIImage imageNamed:@"chat_more"] forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(moreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sendButton];
    
    //表情按钮
    frame.origin.y = 5;
    frame.size.width = 50;
    frame.origin.x = self.frame.size.width - frame.size.width - 5;
    frame.size.height = 40;
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendButton.frame = frame;
    _sendButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [_sendButton setImage:[UIImage imageNamed:@"face"] forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(faceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sendButton];
    
    //输入框
    frame.size.height = 30;
    frame.origin.x = _soundButton.frame.origin.x + _soundButton.frame.size.width - 10;
    frame.origin.y = 10;
    frame.size.width = self.frame.size.width - frame.origin.x - _sendButton.frame.size.width - 20;
    self.textView = [[UITextView alloc] initWithFrame:frame];
    _textView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    _textView.showsVerticalScrollIndicator = YES;
    _textView.showsHorizontalScrollIndicator = YES;
    _textView.delegate = self;
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.returnKeyType = UIReturnKeySend;
    _statFrame = self.frame;
    _lastNumber = 1;
    _textView.layer.cornerRadius = 6;
    _textView.layer.masksToBounds = YES;
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor = [[UIColor colorWithRed:170/255.0 green:170/255.0  blue:170/255.0  alpha:1] CGColor];
    [self addSubview:_textView];
    
    _recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _recordButton.frame = _textView.frame;
    _recordButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    _recordButton.backgroundColor = [UIColor clearColor];
    [_recordButton setTitle:@"按住 说话" forState:UIControlStateNormal];
    [_recordButton setTitle:@"松开 结束" forState:UIControlStateHighlighted];
    [_recordButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_recordButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_recordButton addTarget:self action:@selector(beginRecord:) forControlEvents:UIControlEventTouchDown];
    [_recordButton addTarget:self action:@selector(endRecord:) forControlEvents:UIControlEventTouchUpInside];
    _recordButton.hidden = YES;
    [self addSubview:_recordButton];

    //更多view
    _moreView = [[HDChatMoreView alloc] initWithFrame:CGRectMake(0, 50, self.frame.size.width, 216)];
    _moreView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [_moreView setTitleArray:@[@"照片", @"拍照"] AndImageNameArray:@[@"chat_image", @"chat_photograph"]];
    _moreView.delegate = self;
    
    [self addSubview:_moreView];
    
}

- (void)viewWillAppear {
    if (_isFirstGo) {
        _isFirstGo = NO;
        _firstChatTableFrame = _chatTableView.frame;
        _showHeight = chatTextHeight;
        _firstChatTableFrame.size.height += _showHeight;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)viewWillDisappear {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -

- (void)setIsHideRecord:(BOOL)isHideRecord {
    if (_isHideRecord != isHideRecord) {
        _isHideRecord = isHideRecord;
        float width = _soundButton.frame.size.width - 28;
        if (_isHideRecord) {
            _soundButton.hidden = YES;
            CGRect frame = _textView.frame;
            frame.origin.x -= width;
            frame.size.width += width;
            _textView.frame = frame;
        } else {
            _soundButton.hidden = NO;
            CGRect frame = _textView.frame;
            frame.origin.x += width;
            frame.size.width -= width;
            _textView.frame = frame;
        }
    }
}

- (void)setIsHideMore:(BOOL)isHideMore {
    if (_isHideMore != isHideMore) {
        _isHideMore = isHideMore;
        
        float width = _sendButton.frame.size.width + 10;
        if (_isHideRecord) {
            _sendButton.hidden = YES;
            CGRect frame = _textView.frame;
            frame.size.width += width;
            _textView.frame = frame;
        } else {
            _sendButton.hidden = NO;
            CGRect frame = _textView.frame;
            frame.size.width -= width;
            _textView.frame = frame;
        }

    }
}

- (void)hideKey {
    if ([_textView isFirstResponder]) {
        [_textView resignFirstResponder];
    } else if (_isShowMore) {
         [_textView becomeFirstResponder];
        [_textView resignFirstResponder];
    }
}

#pragma mark - Notification

-(void)keyboardWillShow:(NSNotification *)aNotification {
    NSInteger keyHeight =[aNotification.userInfo[@"UIKeyboardBoundsUserInfoKey"] CGRectValue].size.height;
    [self changKeyboardHeight:keyHeight];
}

-(void)keyboardWillHide:(NSNotification *)aNotification {
    if (_isShowMore) {
        return;
    }
    NSInteger keyHeight =[aNotification.userInfo[@"UIKeyboardBoundsUserInfoKey"] CGRectValue].size.height;
    [self changKeyboardHeight:-keyHeight];
}

- (void)changKeyboardHeight:(CGFloat)keyHeight {
    CGRect endTableViewFrame;
    if (keyHeight > 0) {
        keyHeight += 4;
        endTableViewFrame = _firstChatTableFrame;
        endTableViewFrame.size.height -= (keyHeight + _showHeight);
    } else {
        endTableViewFrame = _firstChatTableFrame;
        endTableViewFrame.size.height -= (chatTextHeight + 4);
    }
    [UIView animateWithDuration:0.3 animations:^{
        _chatTableView.frame = endTableViewFrame;
        CGRect chatFrame = self.frame;
        chatFrame.origin.y = endTableViewFrame.origin.y + endTableViewFrame.size.height;
        self.frame = chatFrame;
    } completion:^(BOOL finished) {
        if (keyHeight > 0) {
            NSIndexPath *indexPaht = [NSIndexPath indexPathForRow:[_chatTableView numberOfRowsInSection:0] - 1 inSection:0];
            if (indexPaht.row > 0) {
                [_chatTableView scrollToRowAtIndexPath:indexPaht atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            }
        }
    }];
}


#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    _isShowMore = NO;
    NSIndexPath *indexPaht = [NSIndexPath indexPathForRow:[_chatTableView numberOfRowsInSection:0] - 1 inSection:0];
    if (indexPaht.row > 0) {
        [_chatTableView scrollToRowAtIndexPath:indexPaht atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (!_isShowMore) {
        textView.text = @"";
        [self setPostionForTextNumber:1 oneTextHeight:14];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"] ) {
        [self sendMessage];
        return NO;
    }
    return YES;
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    [self checkTextViewDidChange:textView];
}

#pragma mark -

//chatTextView隐藏
-(void)chatTextViewHideMoreNotification:(NSNotification*)notification {
    _isShowMore = NO;
    _textView.text = @"";
    [self setPostionForTextNumber:1 oneTextHeight:14];
}


- (void)checkTextViewDidChange:(UITextView *)textView {
    self.text = textView.text;
    
    int addNum = 1;
    NSString *tempText = textView.text;
    
    //计算回车换行符的个数
    while (true) {
        NSRange range = [tempText rangeOfString:@"\n"];
        if (range.length > 0) {
            addNum++;
            
            //计算换行符间字符串的高度
            NSString *toIndexText = [tempText substringToIndex:range.location];
            CGSize toIndexSize = [toIndexText sizeWithFont:[textView font]];
            addNum += toIndexSize.width / 188; //每一行内容的宽度为188
            tempText = [tempText substringFromIndex:range.location + range.length];
        } else {
            break;
        }
    }
    CGSize size = [tempText sizeWithFont:[textView font]];
//    int oneTextHeight = size.height; //在IOS6上当tempText为@""时，计算的高度为0，弃用
    int textNumber = size.width / 188 + addNum;
    [self setPostionForTextNumber:textNumber oneTextHeight:14];
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

- (void)swiftRecord:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self hideKey];
        _recordButton.hidden = NO;
    } else {
        [_textView becomeFirstResponder];
        _recordButton.hidden = YES;
    }
}

- (void)moreButtonClick:(id)sender {
    _soundButton.selected = NO;
    _recordButton.hidden = YES;
    _isShowMore = !_isShowMore;
    if (_isShowMore) {
        if (_textView.isFirstResponder) {
            [_textView resignFirstResponder];
        }
        [self changKeyboardHeight:216];
    } else {
        [_textView becomeFirstResponder];
    }
}

- (void)faceButtonClick:(id)sender {
    
}

- (void)sendMessage {
    if ([_textView.text isEqualToString:@""]) {
        return;
    }
    
    if ([_delegate respondsToSelector:@selector(chatTextView:sendMessage:)]) {
        [_delegate chatTextView:self sendMessage:_textView.text];
    }
    _textView.text = nil;
    [self setPostionForTextNumber:1 oneTextHeight:14];
}

//textView变高
- (void)setPostionForTextNumber:(int)number oneTextHeight:(int)oneTextHeight {
    if (number <= 0 || number > 4) {
        return;
    }
    if (number == _lastNumber)
        return;
    CGFloat changeHeight = oneTextHeight * (number - _lastNumber);
    _lastNumber = number;
    
    CGRect frame = self.frame;
    frame.origin.y -= changeHeight;
    frame.size.height += changeHeight;
    self.frame = frame;
    
    _showHeight += changeHeight;
    
    frame = _textView.frame;
    frame.size.height += changeHeight;
    _textView.frame = frame;
}

#pragma mark - HDChatMoreViewDelegate

- (void)HDChatMoreView:(HDChatMoreView *)chatMoreView selectindex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            [self picker:0];
            break;
        }
        case 1:
        {
            [self picker:1];
            break;
        }
            
        default:
            break;
    }
}

- (void)picker:(NSInteger)index {
    UIImagePickerController *imagePickerController=[[UIImagePickerController alloc]init];
    imagePickerController.delegate=self;
    
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        switch (index)
        {
            case 0://拍照
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 1://相册选择
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            default:
                return;
                break;
        }
    }
    else{
        if(index==0){
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
        else{
            return;
        }
    }
    [[self viewControllerFormView] presentViewController:imagePickerController animated:YES completion:nil];
}

- (UIViewController *)viewControllerFormView {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

#pragma  mark - UIImagePickerControllerDelegate

-(void)imagePickerController:( UIImagePickerController *) picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (_delegate && [_delegate respondsToSelector:@selector(chatTextView:sengImage:)]) {
        [_delegate chatTextView:self sengImage:image];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

@end
