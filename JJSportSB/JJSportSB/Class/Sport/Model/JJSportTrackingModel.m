//
//  JJSportTrackingModel.m
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/10.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "JJSportTrackingModel.h"

@interface JJSportTrackingModel ()


/**
 上一次的位置
 */
@property(nonatomic , strong) CLLocation * lastLoaction;


/**
 运动起始位置
 */
@property(nonatomic , strong ) CLLocation * startLoaction;


@end

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



#pragma mark - 绘制多线条
-(MAPolyline*)drawPolylineWithLocatin:(CLLocation*)userLocation{
    
    if (self.startLoaction == nil) {
        _startLoaction = userLocation;
        self.lastLoaction = userLocation;
    }
    
    //根据官方文档,构造折线对象
    CLLocationCoordinate2D commonPolylineCoords[2];
    commonPolylineCoords[0].latitude = self.lastLoaction.coordinate.latitude;
    commonPolylineCoords[0].longitude = self.lastLoaction.coordinate.longitude;
    
    commonPolylineCoords[1].latitude = userLocation.coordinate.latitude;
    commonPolylineCoords[1].longitude = userLocation.coordinate.longitude;
    
    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:2];
 
    self.lastLoaction = userLocation;

    return commonPolyline;
    
}


@end
