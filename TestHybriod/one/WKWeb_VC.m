//
//  WKWeb_VC.m
//  TestHybriod
//
//  Created by pangpangpig-Mac on 2017/11/24.
//  Copyright © 2017年 _Doctor. All rights reserved.
//

#import "WKWeb_VC.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WKUserContentController.h>
#import <WebKit/WKUserScript.h>
#import <WebKit/WebKit.h>
@interface WKWeb_VC ()<WKScriptMessageHandler>

@end

@implementation WKWeb_VC

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.wkwebView == nil) {
        [JSContext currentContext];

        WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
        config.userContentController =[[WKUserContentController alloc]init];
//        window.webkit.messageHandlers.ocWkModth.postMessage({"page":"testVC"}
        [config.userContentController addScriptMessageHandler:self name:@"ocWkModth"];
        self.wkwebView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:config];
        //    [self.wkwebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
        //        self.wkwebView.allowsBackForwardNavigationGestures = YES;
        self.wkwebView.navigationDelegate = self;
        self.wkwebView.UIDelegate = self;
        [self.view addSubview:self.wkwebView];
        if (@available(iOS 9.0, *)) {
            NSSet * set = [NSSet setWithArray:@[WKWebsiteDataTypeLocalStorage]];
            [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:set modifiedSince:[NSDate dateWithTimeIntervalSince1970:0] completionHandler:^{
                
            }];
        }
        
        if (@available(iOS 11.0, *)) {
            _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame),3)];
            //            self.wkwebView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
            
        }else
        {
            _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame),3)];
            
        }
        _progressView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_progressView];
        [self.wkwebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    }
    
//    /**
//     *  1,加载网络html
//     */
//    NSString * surl = @"http://192.168.3.134:7080/toCompanyTouch";
//    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:surl]];
//    [self.wkwebView loadRequest:request];
    
    /**
     *  2,加载本地html 资源（内容）
     */
    NSURL * url =[[NSBundle mainBundle] URLForResource:@"testH5" withExtension:@"html"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testH5" ofType:@"html"];
    NSString * htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.wkwebView loadHTMLString:htmlString baseURL:url];
    
//    /**
//     *  3,加载本地html url
//     */
//
//    NSURL * url2 =[[NSBundle mainBundle] URLForResource:@"testH5" withExtension:@"html"];
//    [self.wkwebView loadFileURL:url2 allowingReadAccessToURL:url2];
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ([keyPath isEqual: @"estimatedProgress"] && object == self.wkwebView) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:self.wkwebView.estimatedProgress animated:YES];
        [self.progressView setTintColor:[UIColor cyanColor]];
        if(self.wkwebView.estimatedProgress >= 1.0f)
        {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


// 第四步
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"**********%s",__FUNCTION__);
}
// 第五步
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"**********%s",__FUNCTION__);

}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"**********%s",__FUNCTION__);
}

// 第二步
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"**********%s",__FUNCTION__);
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"**********%s",__FUNCTION__);
}
// 第一步
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSLog(@"**********%s",__FUNCTION__);
    decisionHandler(WKNavigationActionPolicyAllow);
}
// 第三步
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSLog(@"**********%s",__FUNCTION__);
    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    
    NSLog(@"**********%s",__FUNCTION__);
    
}

//- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo
//{
//    return  YES;
//}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"body=[%@]",message.body);
    NSLog(@"name=[%@]",message.name);
    NSLog(@"frameInfo.absoluteString=[%@]",message.frameInfo.request.URL.absoluteString);
    
}

- (void)dealloc {
    [self.wkwebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkwebView setNavigationDelegate:nil];
    [self.wkwebView setUIDelegate:nil];
    [self.wkwebView removeFromSuperview];
    NSLog(@"\n self.wkwebView disappear ...\n");
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
