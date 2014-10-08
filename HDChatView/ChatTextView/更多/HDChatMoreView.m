//
//  HDChatMoreView.m
//  MyPosition
//
//  Created by 张达棣 on 14-7-15.
//  Copyright (c) 2014年 ganzf. All rights reserved.
//

#import "HDChatMoreView.h"
#import "HDChatMoreItemView.h"


//const NSInteger item

@implementation HDChatMoreView


- (void)setTitleArray:(NSArray *)titleArray AndImageNameArray:(NSArray *)imageNameArray {
    self.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
    lineView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:lineView];

    for (int i = 0, j = 0; i < titleArray.count && i < imageNameArray.count; i++) {
        if (i >= 4) {
            i = 0;
            j++;
        }
        HDChatMoreItemView *view = [[HDChatMoreItemView alloc] initWithFrame:CGRectMake(16 + (16 + 59)*i, 10 + (10 + 83)*j, 59, 83)];
        view.title = titleArray[i];
        view.image = [UIImage imageNamed:imageNameArray[i]];
        
        __weak HDChatMoreView *weakSelf = self;
        [view setBlock:^{
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(HDChatMoreView:selectindex:)]) {
                [weakSelf.delegate HDChatMoreView:self selectindex:i];
            }
        }];
        [self addSubview:view];
    }
}


@end
