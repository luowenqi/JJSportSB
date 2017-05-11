//
//  JJSportVC.m
//  JJSport
//
//  Created by 罗文琦 on 2017/5/10.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "JJSportVC.h"
#import "JJSportSupportVC.h"

#define BASETAG 50
#define MarginTop 20
#define MarginLeft 20



@interface JJSportVC ()


@end

@implementation JJSportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setupUI];
}


- (IBAction)sportTypeClicked:(UIButton *)sender {
    
    //创建运动支持控制器
    JJSportSupportVC* supportVC = [[UIStoryboard storyboardWithName:@"Sport" bundle:nil]instantiateViewControllerWithIdentifier:@"JJSportSupportVC"];
    
    //根据点击的按钮,确定运动类型
    supportVC.sportType = sender.tag;
    [self presentViewController:supportVC animated:YES completion:nil];
}






@end
