//
//  headerViewModel.h
//  tylist
//
//  Created by zhang_qing on 2017/6/20.
//  Copyright © 2017年 ty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface headerViewModel : NSObject

@property (nonatomic, copy)NSString * title;

@property (nonatomic, copy)NSString * content;

@property (nonatomic, assign)long section;

@property (nonatomic, assign)BOOL kaiOrHe;//YES 是打开 NO 是关闭

@end
