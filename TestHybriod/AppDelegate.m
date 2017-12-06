//
//  AppDelegate.m
//  TestHybriod
//
//  Created by pangpangpig-Mac on 2017/11/24.
//  Copyright © 2017年 _Doctor. All rights reserved.
//

#import "AppDelegate.h"
#import "Invite_VC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    NSLog(@"---- %@",url.absoluteString);
    if (!url) {  return NO; }
    
    NSArray * strArr = [url.query componentsSeparatedByString:@"&"];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    for (NSString *str in strArr) {
        NSString * key = [[str componentsSeparatedByString:@"="] firstObject];
        NSString * value =[[str componentsSeparatedByString:@"="] lastObject];
        [dict setValue:value forKey:key];
    }
    if ([[dict objectForKey:@"page"] isEqualToString:@"loanDetail"]) {
        Invite_VC *vc = [[Invite_VC alloc] init];
        vc.page = [NSString stringWithFormat:@"url：[%@]\n page= [%@]",url.absoluteString ,[dict objectForKey:@"page"]];
        [[(UINavigationController*)[self currentViewController] visibleViewController].navigationController pushViewController:vc animated:YES];
    } else if ([[dict objectForKey:@"page"] isEqualToString:@"invite"]) {
        Invite_VC *vc = [[Invite_VC alloc] init];
        vc.page = [NSString stringWithFormat:@"url：[%@]\n page= [%@]",url.absoluteString ,[dict objectForKey:@"page"]];
        [[(UINavigationController*)[self currentViewController] visibleViewController].navigationController pushViewController:vc animated:YES];
    }
    
    return YES;
}

#pragma mark - 表层控制器

- (UIViewController *)currentViewController {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
        
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = [(UINavigationController *)vc visibleViewController];
        } else if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = [(UITabBarController *)vc selectedViewController];
        }
    }
    return vc;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
