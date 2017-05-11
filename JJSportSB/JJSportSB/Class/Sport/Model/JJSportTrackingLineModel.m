//
//  JJSportTrackingLineModel.m
//  JJSportSB
//
//  Created by 罗文琦 on 2017/5/11.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "JJSportTrackingLineModel.h"

@implementation JJSportTrackingLineModel




-(instancetype)initWithStartLocation:(CLLocation*)startLocation endLocation:(CLLocation*)endLocation{
    if (self = [super init]) {
        self.startLoaction = startLocation;
        self.endLoaction = endLocation;
    }
    return self;
}


-(MAPolyline*)polyLine{
    //根据官方文档,构造折线对象
    CLLocationCoordinate2D commonPolylineCoords[2];
    commonPolylineCoords[0].latitude = self.startLoaction.coordinate.latitude;
    commonPolylineCoords[0].longitude = self.startLoaction.coordinate.longitude;
    
    commonPolylineCoords[1].latitude = self.endLoaction.coordinate.latitude;
    commonPolylineCoords[1].longitude = self.endLoaction.coordinate.longitude;
    
    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:2];
    
    return commonPolyline;
}


-(CGFloat)speed{
     //返回km/h
    return (self.startLoaction.speed + self.endLoaction.speed) / 2 * 3.6 ;
    
//    return (self.distance / self.time);

}


-(CGFloat)distance{
    return [self.startLoaction distanceFromLocation:self.endLoaction];
}

-(CGFloat)time{
    return [self.endLoaction.timestamp timeIntervalSinceDate:self.startLoaction.timestamp];
}


-(UIColor*)color{
    return [UIColor colorWithRed:(self.speed * 8/ 255.0) green:1 blue:0 alpha:1];
}




@end
