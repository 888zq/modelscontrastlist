//
//  headerViewModel.m
//  tylist
//
//  Created by zhang_qing on 2017/6/20.
//  Copyright © 2017年 ty. All rights reserved.
//

#import "headerViewModel.h"

@implementation headerViewModel

- (instancetype)init
{
    if (self = [super init]) {
        
        _title = @"";
        _content = @"";
        _kaiOrHe = NO;
    }
    return self;
}

@end
