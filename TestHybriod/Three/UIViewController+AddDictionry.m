//
//  UIViewController+AddDictionry.m
//  TestHybriod
//
//  Created by pangpangpig-Mac on 2017/11/27.
//  Copyright © 2017年 _Doctor. All rights reserved.
//

#import "UIViewController+AddDictionry.h"
#import <objc/runtime.h>
@implementation UIViewController (AddDictionry)
static char const * pKey = "pKey";
- (void)setDict:(NSDictionary*)dict
{
    objc_setAssociatedObject(self, pKey, dict, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSDictionary*)dict
{
    return  (NSDictionary*)objc_getAssociatedObject(self, pKey);
}

@end
