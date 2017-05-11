//
//  JJSportTrackingModel.h
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/10.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>


typedef enum : NSUInteger {
    JJSportTypeRun = 1,
    JJSJJSportWalk,
    JJSJJSportRiding,
} JJSportType;

@interface JJSportTrackingModel : NSObject


/**
 运动类型
 */
@property(nonatomic , assign , readonly) JJSportType  sportType;



/**
 运动图标
 */
@property(nonatomic , strong) UIImage * sportImage;

/**
运动追踪指定初始化方法
 */
-(instancetype)initWithSportModel:(JJSportType)sportType;


-(MAPolyline*)drawPolylineWithLocatin:(CLLocation*)userLocation;







@end
