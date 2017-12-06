//
//  UIWeb_VC.m
//  TestHybriod
//
//  Created by pangpangpig-Mac on 2017/11/27.
//  Copyright © 2017年 _Doctor. All rights reserved.
//

#import "UIWeb_VC.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JS_OCModle.h"
#import "UIViewController+AddDict.h"
#import "UIViewController+AddDictionry.h"

@protocol JS_OCCOnnectProtocolInWeb <JSExport>
- (void)testLog:(NSDictionary*)dict;
@end

@interface UIWeb_VC () <UIWebViewDelegate,JS_OCCOnnectProtocolInWeb>
@property UIWebView * webView;
@end

@implementation UIWeb_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView =[[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
//    NSString *ustr = @"http://192.168.3.134:7080/toCompanyTouch";
//    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:ustr]];
//    [self.webView loadRequest:request];
    /**
     *  加载本地html 
     */
    NSURL * url =[[NSBundle mainBundle] URLForResource:@"testH5" withExtension:@"html"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testH5" ofType:@"html"];
    NSString * htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:url];
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    JSContext * context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    [context setObject:self forKeyedSubscript:@"VC"];
//    [webView stringByEvaluatingJavaScriptFromString:@"VC"];
//    JS_OCModle * modle = [JS_OCModle new];
//    modle.delegate = self;
    [context setObject:(^(NSDictionary * dict) {
        NSLog(@"dict=[%@]",dict);
    }) forKeyedSubscript:@"ocModthLog"];
//    [webView stringByEvaluatingJavaScriptFromString:@"ocModthLog"];

}

- (void)testLog:(NSDictionary*)dict
{
    NSLog(@"---testLog--");
    NSLog(@"dict=[%@]",dict);
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
