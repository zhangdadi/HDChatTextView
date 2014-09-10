//
//  HDChatMoreItemView.h
//  MyPosition
//
//  Created by 张达棣 on 14-7-15.
//  Copyright (c) 2014年 ganzf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDChatMoreItemView;

typedef void (^HDChatMoreItemSelectBlock)();

@interface HDChatMoreItemView : UIView
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, copy) HDChatMoreItemSelectBlock block;

@end
