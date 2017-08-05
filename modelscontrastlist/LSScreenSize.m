//
//  LSScreenSize.m
//  KOFACS
//
//  Created by  apple on 16/6/16.
//  Copyright © 2016年  apple. All rights reserved.
//

#import "LSScreenSize.h"

@implementation LSScreenSize
/**
 *  获取本类的单例对象
 *
 *  @return 单例对象
 */
+(LSScreenSize*)getInstance
{
    static LSScreenSize* instance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        
        instance = [[self alloc]init];
    });
    
    return instance;
}
/**
 *  根据不同尺寸来进行尺寸设计
 *
 *  @param block4  4寸屏
 *  @param block47 4.7吋屏
 *  @param block55 5.5吋屏
 */
-(void)iPhoneScreenSizeIs4inch:(SetViewSizeBlock)block4 isInch47:(SetViewSizeBlock)block47 isInch55:(SetViewSizeBlock)block55  common:(SetViewSizeBlock)commonblock
{

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    if(commonblock)
    {
        commonblock(width);
    }
    if(width < 322.0f)
    {
        if(block4)
        {
            block4(width);
        }
    }
    else if(width > 373.0f && width < 377.0f)
    {
        if(block47)
        {
            block47(width);
        }
    }
    else if(width > 412.0f && width < 416.0f)
    {
        if(block55)
        {
            block55(width);
        }
    }
    else
    {
        NSLog(@"这是一台还没有上市的iPhone!!!");
        if(block55)
        {
            block55(width);
        }
    }
}
@end
