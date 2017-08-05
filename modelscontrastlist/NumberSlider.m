//
//  NumberSlider.m
//  modelscontrastlist
//
//  Created by zhang_qing on 2017/6/30.
//  Copyright © 2017年 ty. All rights reserved.
//

#import "NumberSlider.h"

@implementation NumberSlider

/**
 重新UISlider方法 设置值时，将值显示在滑块中
 
 @param value 值
 @param animated 是否动画
 */
- (void)setValue:(float)value animated:(BOOL)animated
{
    [super setValue:value animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%", value];
    
    // 生成文字图片
    UIImage *image = [self imageWithText:text
                                fontSize:10
                                    size:CGSizeMake(30, 30)
                               textColor:[UIColor whiteColor]
                         backgroundColor:[UIColor orangeColor]
                                  radius:15];
    
    // 设置滑块部分图片
    [self setThumbImage:image forState:UIControlStateNormal];
}
/**
 生成文字图片
 
 @param text 文字
 @param fontSize 字体大小
 @param size 图片大小
 @param backgroundColor 背景颜色
 @param radius 圆角弧度
 @return 图片对象
 */
- (UIImage *)imageWithText:(NSString *)text
                  fontSize:(CGFloat)fontSize
                      size:(CGSize)size
                 textColor:(UIColor *)textColor
           backgroundColor:(UIColor *)backgroundColor
                    radius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, textColor.CGColor);
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGFloat yOffset = (rect.size.height - font.pointSize) / 2.0 - 1.25;
    CGRect textRect = CGRectMake(0, yOffset, rect.size.width, rect.size.height - yOffset);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [text drawInRect:textRect withAttributes:@{NSFontAttributeName: font, NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}













/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
