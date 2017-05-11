//
//  JJSportTrackingLineModel.h
//  JJSportSB
//
//  Created by 罗文琦 on 2017/5/11.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJSportTrackingLineModel : NSObject




/**
指定初始化方法
 */
-(instancetype)initWithStartLocation:(CLLocation*)startLocation endLocation:(CLLocation*)endLocation;


/**
结束位置
 */
@property(nonatomic , strong) CLLocation * endLoaction;


/**
起始位置
 */
@property(nonatomic , strong ) CLLocation * startLoaction;


/**
 多线条属性
 */
@property(nonatomic , strong) MAPolyline * polyLine;


/**
 单次划线的速度,用来计算最大速度
 */
@property(nonatomic , assign) CGFloat  speed;


/**
 单次画线的距离
 */
@property(nonatomic , assign) CGFloat  distance;


/**
 单次画线的时间
 */
@property(nonatomic , assign) CGFloat  time;


/**
 单词画线的线条颜色
 */
@property(nonatomic , strong) UIColor * color;

@end
