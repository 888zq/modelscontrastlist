//
//  NSString+Extension.m
//  KOFACS
//
//  Created by 董天文 on 16/8/11.
//  Copyright © 2016年  apple. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+(CGFloat)widthOfTheString:(NSString *)string withFont:(CGFloat)font
{
    CGSize size = [string sizeWithAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName: [UIFont systemFontOfSize:font]}];
    
    return size.width;
}
-(NSString *)saveSpecialWord
{
    return [self stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
}
-(NSInteger)validContentLength
{
    NSString *noWithespaceString = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return noWithespaceString.length;
}
@end
