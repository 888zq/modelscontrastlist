//
//  Macro.h
//  KOFACS
//
//  Created by 王亚坤 on 16/6/4.
//  Copyright © 2016年  apple. All rights reserved.
//

#ifndef Macro_h
#define Macro_h
//#import "UIView+Extension.h"
//#import "NSString+Extension.h"
//#import "ToolsHong.h"
//#import "LoginInfo.h"
//#import "DataMgerSuperLS.h"
//#import "UIViewController+HUD.h"
//#import "KCCommonAlertBlock.h"
//#import "YYModel.h"
//#import "MBProgressHUD+MJ.h"
//#import "UIImageView+WebCache.h"
//#import "UIViewController+BackButtonHandler.h"
//#import "BackBarButton.h"
//// 朱泽龙添加
//#import "TAFaultObject.h"//用于判断 是否是 “时间轴”仅用于查看数据，添加判断点击图片仅放大；
//手势通知
#define GestureCVAction @"gotoGestureControllerViewAction"
#define GESTURE_Notification [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(gotoGestureControllerViewAction) name:GestureCVAction object:nil];
#define GESTURE_PostNotifi    [[NSNotificationCenter defaultCenter]postNotificationName:GestureCVAction object:nil];
//点击显示textView通知－－－朱泽龙
#define ChangeCellHeightName @"changecellheightname"
//刷新消息BadgeViewNum显示－－－朱泽龙
#define NOTIFIREFRESHBadgeNum   @"refreshBadgeViewNum"
#define SIZE [[UIScreen mainScreen] bounds].size
//时间轴frame
#define TimeLineCellSpacX 10
#define TimeLineCellSpacY 18
#define TimeLineSpacH 7
#define TimeLineSpacW 15

#define NAVCOLOR self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.0/255.0 green:173/255.0 blue:176/255.0 alpha:1.0];
#define APPCOLOR [UIColor colorWithRed:0.0/255.0 green:173/255.0 blue:176/255.0 alpha:1.0]

#define WEAKSELF __weak typeof(self) weakSelf = self;

#define FORMBLUE [UIColor colorWithRed:39/255.0 green:136/255.0 blue:248/255.0 alpha:1.0] //报表表格第一行蓝色 赵帅

#define FORMGRAY [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0] //报表表格第一列灰色 赵帅
#define IWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define LIGHTBLUE IWColor(232, 244, 255)
#define ZBLUECOLOR IWColor(20, 125, 212)
//添加Iphone6手机判断，剪切图适配不同设备 - 王亚坤
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define IS_IPHONE_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.width == 414.0)



#define UIIMAGENAMED(name) IS_IPHONE_6?[UIImage imageNamed:[NSString stringWithFormat:@"%@_750",name]]:[UIImage imageNamed:name]



#define SYSTEM_VERSION   [[UIDevice currentDevice].systemVersion floatValue]

#define NET_VERSION  @"1.1"//网络请求版本号

#define kSTARWIDTH 8
#define kCellHeight 50.0
#define kMAGRINTOLEFT 15
#define Padding 12
#define kMAGRIN 0
#define kPadding 6
#define kLimitWords 100

#define kCELLSELECTEDNOTIFICATION  @"historyCellSelectedNotification"

#define kSTATEVIEWWIDTH  [UIScreen mainScreen].bounds.size.width / 8

#define ZZKeyWindow [[UIApplication sharedApplication] keyWindow]
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define kWIDTHSCALE   ([UIScreen mainScreen].bounds.size.width / 320.0)

// RGB颜色
#define HWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#ifdef DEBUG // 处于开发阶段
#define ZZLog(...) NSLog(__VA_ARGS__)

#else // 处于发布阶段
#define ZZLog(...)


#endif

#ifdef DEBUG//解决xcode8在ios10手机上打印json不全的问题

#define TYLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);

#else

#define TYLog(FORMAT, ...) nil

#endif


#endif 

/* Macro_h */
#define macro 2

//用户版本

#if macro == 1

#define MAIN_DEVICE MainDeviceViewController

#define SETTINGCONTROLLER MainSettingController


#endif

//服务版本

#if macro == 2

#define MAIN_DEVICE DLD_MainDeviceViewController

#define SETTINGCONTROLLER DLD_MainSettingController



#endif




