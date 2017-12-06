//
//  JS_OCModle.m
//  TestHybriod
//
//  Created by pangpangpig-Mac on 2017/11/27.
//  Copyright © 2017年 _Doctor. All rights reserved.
//

#import "JS_OCModle.h"

@implementation JS_OCModle

-(void)ocModthWithAgrs:(NSDictionary *)dict
{
    
    NSLog(@"从Model中输出的：[%@]",dict);
//    UIViewController * vc =  (UIViewController*)NSClassFromString([dict objectForKey:@"pushVC"]);
    if (self.delegate && [self.delegate respondsToSelector:@selector(ocModthCallBack:)]) {
        [self.delegate ocModthCallBack:dict];
    }
}

@end
