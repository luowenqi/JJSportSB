//
//  JJSportSupportVC.m
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/10.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "JJSportSupportVC.h"

@interface JJSportSupportVC ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation JJSportSupportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - 设置界面
-(void)setupUI{
    
    
    
    //创建地图控制器,并且使用父子控制器的方式加进去
    JJSportMapVC* mapVC = (JJSportMapVC*)self.containerView.subviews[0].nextResponder;
    

    //设置mapVC里面的运动追踪模型;
    mapVC.trackingModel = [[JJSportTrackingModel alloc]initWithSportModel:self.sportType];

}



@end
