//
//  TestWebViewController.m
//  LearnDemo
//
//  Created by 王雪剑 on 2022/9/30.
//  Copyright © 2022 wangxj. All rights reserved.
//

#import "TestWebViewController.h"
#import "TestURLProtocol.h"

@interface TestWebViewController ()
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation TestWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createView];
}

- (void)createView {
    [NSURLProtocol registerClass:[TestURLProtocol class]];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 375, 667)];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    [self.view addSubview:_webView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
