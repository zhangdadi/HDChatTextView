#聊天工具栏

发现很多聊天工具栏封装的不够，使用起来比较麻烦，比如：当这个输入文字变多行时或者键盘隐藏显示等情况时，使用这个聊天框的调用者还要自己实时设置工具栏的坐标和高度。

有感于心，自己写的HDChatView，这些工作都封装进来了，外面主要初始化出来使用，就不用再管什么坐标什么高度了。

viewController使用：

```
- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    _chatTextView = [HDChatTextView creatInTableView:_tableView]; _chatTextView.delegate = self;
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

```
这样使用就行了，其它当键盘隐藏、显示，输入的文字多行等变化都不用你来处理，由HDChatView帮你处理。