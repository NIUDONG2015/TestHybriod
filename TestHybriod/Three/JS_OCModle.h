//
//  JS_OCModle.h
//  TestHybriod
//
//  Created by pangpangpig-Mac on 2017/11/27.
//  Copyright © 2017年 _Doctor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JS_OCConnectProtocol <JSExport>
-(void)ocModthWithAgrs:(NSDictionary *)dict;
@end

@protocol JSCallBackProtocol <NSObject>
-(void)ocModthCallBack:(NSDictionary *)dict;
@end

@interface JS_OCModle : NSObject <JS_OCConnectProtocol>

-(void)ocModthWithAgrs:(NSDictionary *)dict;
@property(nonatomic, assign) id<JSCallBackProtocol> delegate;
@end
