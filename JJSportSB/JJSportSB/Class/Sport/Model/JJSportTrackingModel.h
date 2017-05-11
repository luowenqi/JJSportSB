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


//运动总距离
@property(nonatomic,assign,readonly)float totalDistance;

//运动总时间
@property(nonatomic,assign,readonly)float totalTime;

//运动总时间字符串
@property(nonatomic,strong,readonly)NSString *totalTimeStr;

//运动平均速度
@property(nonatomic,assign,readonly)float avgSpeed;


//运动最大速度
@property(nonatomic,assign,readonly)float maxSpeed;



/**
运动追踪指定初始化方法
 */
-(instancetype)initWithSportModel:(JJSportType)sportType;


-(MAPolyline*)drawPolylineWithLocatin:(CLLocation*)userLocation;



/**
 当前线条颜色
 */
@property(nonatomic , strong ,readonly) UIColor * currentLineColor;





@end
