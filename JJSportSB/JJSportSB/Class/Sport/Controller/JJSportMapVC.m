//
//  JJSportMapVC.m
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/10.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "JJSportMapVC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface JJSportMapVC ()<MAMapViewDelegate>


@property(nonatomic,weak)IBOutlet UIView *containerView;


/**
 起点位置
 */
@property(nonatomic , strong) CLLocation * startLocation;


/**
 地图
 */
@property(nonatomic , strong) MAMapView *mapView;
@end

@implementation JJSportMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
//
    
    
    [self creatMapView];
    


}


#pragma mark - 创建地图视图
-(void)creatMapView{

    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    ///把地图添加至view
    [self.view addSubview:_mapView];
    
    //设置mapView的一些属性
    //设置跟踪模式
    _mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    
    //设置交通状况
    _mapView.showTraffic = YES;
    
    //设置代理
    _mapView.delegate = self;
    
    //设置是不是可以后台定位
    _mapView.pausesLocationUpdatesAutomatically = NO;
    /**
     //     * 是否允许后台定位。默认为NO。只在iOS 9.0之后起作用。
     //     * 设置为YES的时候必须保证 Background Modes 中的 Location updates处于选中状态，否则会抛出异常。
     //     */
     _mapView.allowsBackgroundLocationUpdates = YES;
}





#pragma mark - 更新位置
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
//    NSLog(@"%.f-----%.f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    //三次滤波算法,接触初期定位不准问题
    static NSInteger flage = 0;
    
    if (flage <= 3) {
        flage++;
        return;
    }
    
    
    //判断是不是正在更新位置
    if (updatingLocation) {
        if (!self.startLocation && _mapView.showsUserLocation == YES) {  //如果起始位置不存在,并且已经定位成功
            //记录起始位置
            self.startLocation = userLocation.location;
            //添加大头针
            MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
            pointAnnotation.coordinate = userLocation.location.coordinate;
            pointAnnotation.title = userLocation.title;
            pointAnnotation.subtitle = userLocation.subtitle;
            [mapView addAnnotation:pointAnnotation];
            
            
            NSLog(@"起始位置%f----%f",self.startLocation.coordinate.latitude,self.startLocation.coordinate.longitude);
            
        }
    }
    
    //让用户位置始终处于屏幕中心
    [mapView setCenterCoordinate:userLocation.coordinate animated:YES];
    
    
}



/**
 * @brief 单击地图回调，返回经纬度
 * @param mapView 地图View
 * @param coordinate 经纬度
 */
#pragma mark - 单击地图返回位置
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate{


    //根据官方文档,构造折线对象
    
    CLLocationCoordinate2D commonPolylineCoords[4];
    commonPolylineCoords[0].latitude = self.startLocation.coordinate.latitude;
    commonPolylineCoords[0].longitude = self.startLocation.coordinate.longitude;
    
    commonPolylineCoords[1].latitude = coordinate.latitude;
    commonPolylineCoords[1].longitude = coordinate.longitude;
    
   
    
    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:2];
    
    //在地图上添加折线对象
    [_mapView addOverlay: commonPolyline];
    

}


/**
 * @brief 根据overlay生成对应的Renderer
 * @param mapView 地图View
 * @param overlay 指定的overlay
 * @return 生成的覆盖物Renderer
 */

#pragma mark - 在mapView上添加线条之后会进行调用设置线条的样式
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        
        return polylineRenderer;
    }
    return nil;
}




/**
 * @brief 根据anntation生成对应的View
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView* annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
  
        UIImage *image= self.trackingModel.sportImage;
        annotationView.image = image;
        
        //改变大头针位置偏移量,大头针往上移动图片一半的高度，让大头针下方的尖角处于默认大头针的中心点
        /**
         *  默认情况下, annotation view的中心位于annotation的坐标位置，可以设置centerOffset改变view的位置，正的偏移使view朝右下方移动，负的朝左上方，单位是像素
         */
        annotationView.centerOffset = CGPointMake(0, -image.size.height/2);
        return annotationView;
    }
    return nil;
}


@end
