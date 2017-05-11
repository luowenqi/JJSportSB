//
//  JJSportTrackingModel.m
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/10.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "JJSportTrackingModel.h"

@implementation JJSportTrackingModel

-(instancetype)initWithSportModel:(JJSportType)sportType{

    if (self = [super init]) {
       _sportType = sportType;
    }

    return self;
}



#pragma mark - 运动图标
-(UIImage*)sportImage{

    UIImage* image = [[UIImage alloc]init];
    switch (self.sportType) {
        case JJSportTypeRun:
            image = [UIImage imageNamed:@"ic_history_run_normal_54x54_"];
            break;
        case JJSJJSportWalk:
             image = [UIImage imageNamed:@"ic_history_walk_normal_54x54_"];
            break;
        case JJSJJSportRiding:
            image = [UIImage imageNamed:@"ic_history_riding_normal_54x54_"];

            break;
            
        default:
            break;
    }
    return  image;

}



@end
