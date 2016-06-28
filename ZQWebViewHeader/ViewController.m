//
//  ViewController.m
//  ZQWebViewHeader
//
//  Created by zhang on 16/6/27.
//  Copyright © 2016年 zhangqq.com. All rights reserved.
//

#import "ViewController.h"
#import "ZQWebViewHeader.h"
@interface ViewController ()

@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)ZQWebViewHeader *webView;
@property (nonatomic,assign)BOOL change;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [[ZQWebViewHeader alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width ,self.view.frame.size.height)];
    [self.view addSubview:_webView];
    
    _header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _webView.frame.size.width, 100)];
    _header.backgroundColor = [UIColor redColor];
    _webView.header = _header;
    
    
    UIView *fooder = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _webView.frame.size.width, 100)];
    fooder.backgroundColor = [UIColor greenColor];
    _webView.footder = fooder;
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [actionButton addTarget:self action:@selector(changeWebViewHeaderHight:) forControlEvents:UIControlEventTouchUpInside];
    actionButton.backgroundColor = [UIColor greenColor];
    actionButton.frame = CGRectMake(CGRectGetMaxX(self.view.frame) - 50, 50, 40, 40);
    [self.view addSubview:actionButton];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com/"]]];
    // Do any additional setup after loading the view, typically from a nib.
}

//action
- (void)changeWebViewHeaderHight:(UIButton *)sender {
    
    CGFloat h = _change?200:100;
    [_webView setHeaderHight:h animate:YES];
    _change = !_change;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
