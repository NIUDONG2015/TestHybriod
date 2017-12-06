//
//  WKWeb_VC.h
//  TestHybriod
//
//  Created by pangpangpig-Mac on 2017/11/24.
//  Copyright © 2017年 _Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <WebKit/WKWebView.h>
#import <WebKit/WKWebViewConfiguration.h>
#import <WebKit/WKNavigationDelegate.h>
#import <WebKit/WKUIDelegate.h>
#import <WebKit/WKNavigationAction.h>
#import <WebKit/WKWebsiteDataStore.h>


@interface WKWeb_VC : UIViewController <WKNavigationDelegate,WKUIDelegate>

@property (strong, nonatomic) WKWebView *wkwebView;
@property (strong, nonatomic) UIProgressView *progressView;

@end
