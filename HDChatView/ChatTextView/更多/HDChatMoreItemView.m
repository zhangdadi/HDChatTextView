//
//  HDChatMoreItemView.m
//  MyPosition
//
//  Created by 张达棣 on 14-7-15.
//  Copyright (c) 2014年 ganzf. All rights reserved.
//

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
