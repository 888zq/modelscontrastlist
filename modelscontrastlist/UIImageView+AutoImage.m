//
//  UIImageView+AutoImage.m
//  AutoImageView
//
//  Created by lsj on 2017/6/13.
//  Copyright © 2017年 lsj. All rights reserved.
//

#import "UIImageView+AutoImage.h"

@implementation UIImageView (AutoImage)

-(void)autoImage
{
    if(self == nil
       || self.image == nil
       || self.frame.size.width < 1.0f
       || self.frame.size.height < 1.0f
       || self.image.size.width < 1.0f
       || self.image.size.height < 1.0f) return;
    
    UIImage* normalImage = [self normalizedImage:self.image];//纠正方向后的图片
    CGFloat vW = self.frame.size.width; //视图宽
    CGFloat vH = self.frame.size.height; //视图高
    
    int xishu = 2;//默认系数是2

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    if(width > 412.0f && width < 416.0f)
    {
        xishu = 3;//5.5吋屏幕系数是3
    }
    CGFloat iW = normalImage.size.width / xishu; //图片宽
    CGFloat iH = normalImage.size.height / xishu; //图片高
   
    UIImage* newImage;//裁剪后的新图片
    
    if(vW/vH  == iW/iH)//比率相等
    {
        //将图片缩小到视图尺寸
        CGSize size = CGSizeMake(vW*xishu, vH*xishu);
        newImage = [self zoomWithImage:normalImage scaledToSize:size];
    }
    else if(vW/vH  > iW/iH)//大于，说明实际图片要长，也就是实际图片的高要大些
    {
        //步骤一: 缩小
        UIImage* zoomImage;
        CGFloat w_zoom = vW;
        CGFloat h_zoom = iH / (iW/vW);
            
        CGSize size = CGSizeMake(w_zoom*xishu, h_zoom*xishu);
        zoomImage = [self zoomWithImage:normalImage scaledToSize:size];
            
        //步骤二：裁剪
        CGFloat x_crop = 0.0f;
        CGFloat y_crop = (h_zoom - vH)/2;
        CGFloat w_crop = vW;
        CGFloat h_crop = vH;
        CGRect rect = CGRectMake(x_crop*xishu, y_crop*xishu, w_crop*xishu, h_crop*xishu);
        newImage = [self croppedImage:zoomImage rect:rect];
    }
    else //小于，说明实际图片要短
    {
        //步骤一: 放大
        UIImage* zoomImage;
        CGFloat h_zoom = vH;
        CGFloat w_zoom = iW / (iH/vH);
        CGSize size = CGSizeMake(w_zoom*xishu, h_zoom*xishu);
        zoomImage = [self zoomWithImage:normalImage scaledToSize:size];
        //步骤二：裁剪
        CGFloat x_crop = (w_zoom - vW)/2;
        CGFloat y_crop = 0.0f;
        CGFloat w_crop = vW;
        CGFloat h_crop = vH;
        CGRect rect = CGRectMake(x_crop*xishu, y_crop*xishu, w_crop*xishu, h_crop*xishu);
        newImage = [self croppedImage:zoomImage rect:rect];
    }
    
    self.image = newImage;
}

//旋转图片为正方向
//转换图片方向，有些图片方向不是Up
- (UIImage *)normalizedImage:(UIImage*)originalImage
{
    if(originalImage)
    {
        if (originalImage.imageOrientation == UIImageOrientationUp) return originalImage;
        UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, originalImage.scale);
        [originalImage drawInRect:(CGRect){0, 0, originalImage.size}];
        UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return normalizedImage;
    }
    
    return nil;
}
//裁剪图片
//返回裁剪区域图片,返回裁剪区域大小图片
- (UIImage *)croppedImage:(UIImage *)image rect:(CGRect)rectMAX
{
    if (image)
    {
        CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rectMAX);
        
        UIGraphicsBeginImageContext(rectMAX.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextDrawImage(context, rectMAX, subImageRef);
        UIImage *viewImage = [UIImage imageWithCGImage:subImageRef];
        UIGraphicsEndImageContext();
        CGImageRelease(subImageRef);
        return viewImage;
    }
    return nil;
}
//缩放图片
-(UIImage*)zoomWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    if(image)
    {
        UIGraphicsBeginImageContext(newSize);
        [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage;
    }
    return nil;
}
@end
