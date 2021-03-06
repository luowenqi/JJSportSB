//
//  JJSportTrackingModel.m
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/10.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "JJSportTrackingModel.h"
#import "JJSportTrackingLineModel.h"

@interface JJSportTrackingModel ()


/**
 上一次的位置
 */
@property(nonatomic , strong) CLLocation * lastLoaction;


/**
 运动起始位置
 */
@property(nonatomic , strong ) CLLocation * startLoaction;


@property(nonatomic , strong) NSMutableArray * trackingLineModelArray;

@end

@implementation JJSportTrackingModel

-(instancetype)initWithSportModel:(JJSportType)sportType{

    if (self = [super init]) {
       _sportType = sportType;
        self.trackingLineModelArray = [NSMutableArray array];
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
    
    //时间优化算法
    if ([[NSDate date] timeIntervalSinceDate:userLocation.timestamp] >= 2.0) {
        return nil;
    }
    
    
    //速度优化算法
    if (userLocation.speed <= 0) {   //如果速度小于等于0则表示用户是静止状态返回-1，不需要绘制轨迹（大大提高APP的性能损耗)
        NSLog(@"%.f",userLocation.speed);
        return nil;
    }
    
    
    
    
    //现在因为担心运动追踪模型里面代码太多,所以把这一块的代码分出来一个独立的模型,去处理线条绘制,计算线条颜色,最大速度等.

    JJSportTrackingLineModel* trackingLineModel = [[JJSportTrackingLineModel alloc]initWithStartLocation:self.lastLoaction endLocation:userLocation];
    
    [self.trackingLineModelArray addObject:trackingLineModel];
    
    _currentLineColor = trackingLineModel.color;

    self.lastLoaction = userLocation;

    return trackingLineModel.polyLine;
}




-(float)totalDistance{

    return [[self.trackingLineModelArray valueForKeyPath:@"@sum.distance"] floatValue];

}

-(float)totalTime{

    return [[self.trackingLineModelArray valueForKeyPath:@"@sum.time"] floatValue];
}

//运动总时间字符串
-(NSString *)totalTimeStr
{
    int hour = self.totalTime/3600;
    int minute = (int)self.totalTime%3600/60;
    int second = (int)self.totalTime%60;
    return [NSString stringWithFormat:@"%02zd：%02zd：%02zd",hour,minute,second];
}

//运动平均速度
-(float)avgSpeed
{
    return [[self.trackingLineModelArray valueForKeyPath:@"@avg.speed"] floatValue];
}


//运动最大速度
-(float)maxSpeed
{
    return [[self.trackingLineModelArray valueForKeyPath:@"@max.speed"] floatValue];
}





@end
