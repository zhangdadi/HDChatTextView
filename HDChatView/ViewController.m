//
//  ViewController.m
//  HDChatView
//
//  Created by 张达棣 on 14-10-8.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

UIColor *RGBA(int r, int g, int b, float a) {
    return [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)];
}

UIColor *RGB(int r, int g, int b) {
    return RGBA(r, g, b, 1.0);
}


static NSString *KCellIdef = @"zcell";


#import "ViewController.h"
#import "HDChatTextView.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, HDChatTextViewDelegate>
{
    HDChatTextView *_chatTextView;
    UITableView *_tableView;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)creatView {
    self.view.backgroundColor = RGB(237, 237, 237);
    
    CGRect viewFrame = self.view.bounds;
    _tableView = [[UITableView alloc] initWithFrame:viewFrame style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth
    |UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight;
    _tableView.backgroundColor  = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:KCellIdef];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _chatTextView = [HDChatTextView creatInTableView:_tableView];
    _chatTextView.delegate = self;
    [self.view addSubview:_chatTextView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_chatTextView viewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_chatTextView viewWillDisappear];
}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdef forIndexPath:indexPath];
    
    return cell;
}

@end


