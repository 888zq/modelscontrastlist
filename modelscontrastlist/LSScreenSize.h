//
//  LSScreenSize.h
//  KOFACS
//
//  Created by  apple on 16/6/16.
//  Copyright © 2016年  apple. All rights reserved.
//

/*!
 @class         LSScreenSize
 @author        刘圣杰
 @version       1.0
 @discussion	用户判断屏幕尺寸
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^SetViewSizeBlock)(CGFloat width);
@interface LSScreenSize : NSObject
/**
 *  获取本类的单例对象
 *
 *  @return 单例对象
 */
+(LSScreenSize*)getInstance;
/**
 *  根据不同尺寸来进行尺寸设计
 *
 *  @param block4  4寸屏
 *  @param block47 4.7吋屏
 *  @param block55 5.5吋屏
 */
-(void)iPhoneScreenSizeIs4inch:(SetViewSizeBlock)block4 isInch47:(SetViewSizeBlock)block47 isInch55:(SetViewSizeBlock)block55 common:(SetViewSizeBlock)commonblock;
@end
