//
//  HDChatMoreView.h
//  MyPosition
//
//  Created by 张达棣 on 14-7-15.
//  Copyright (c) 2014年 ganzf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDChatMoreView;

@protocol HDChatMoreViewDelegate <NSObject>
@optional
- (void)HDChatMoreView:(HDChatMoreView *)chatMoreView selectindex:(NSInteger)index;

@end

@interface HDChatMoreView : UIView

@property (nonatomic, weak) id<HDChatMoreViewDelegate> delegate;

- (void)setTitleArray:(NSArray *)titleArray AndImageNameArray:(NSArray *)imageNameArray;

@end
