//
//  Invite_VC.m
//  TestHybriod
//
//  Created by pangpangpig-Mac on 2017/11/24.
//  Copyright © 2017年 _Doctor. All rights reserved.
//

#import "Invite_VC.h"
#import "UIViewController+AddDict.h"
#import "UIViewController+AddDictionry.h"
@interface Invite_VC ()
@property (weak, nonatomic) IBOutlet UILabel *content;

@end

@implementation Invite_VC

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.dict) {
        self.content.text =[self.dict objectForKey:@"content"];
    }else
    {
        self.content.text =self.page;
    }
    
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
