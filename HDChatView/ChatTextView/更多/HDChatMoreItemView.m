//
//  HDChatMoreItemView.m
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


#import "HDChatMoreItemView.h"
#import <QuartzCore/QuartzCore.h>

@interface HDChatMoreItemView ()

@property (weak, nonatomic) IBOutlet UIControl *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation HDChatMoreItemView

- (id)initWithFrame:(CGRect)frame {
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"HDChatMoreItemView" owner:self options:nil];
    if ([array.lastObject isKindOfClass:[self class]]) {
        self = array.lastObject;
        frame.size.height = self.frame.size.height;
        frame.size.width = self.frame.size.width;
        self.frame = frame;
    } else {
        self = [super initWithFrame:frame];
    }
    return self;
}

- (void)awakeFromNib {
    [self creatView];
}

- (void)creatView {
    _bgView.layer.cornerRadius = 8;
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.borderWidth = 1;
    _bgView.layer.borderColor = [[UIColor colorWithRed:153/255.0 green:153/255.0  blue:153/255.0  alpha:1] CGColor];
}

- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
        _imageView.image = image;
    }
}

- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
        _titleLabel.text = title;
    }
}


- (IBAction)selectAction:(id)sender {
    if (_block) {
        _block();
    }
}

@end
