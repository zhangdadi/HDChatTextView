//
//  HDChatMoreView.m
//  MyPosition
//
//  Created by 张达棣 on 14-7-15.
//  Copyright (c) 2014年 ganzf. All rights reserved.
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
