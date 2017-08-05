//
//  TopCollectionCellModel.m
//  modelscontrastlist
//
//  Created by zhang_qing on 2017/7/1.
//  Copyright © 2017年 ty. All rights reserved.
//

#import "TopCollectionCellModel.h"

@implementation TopCollectionCellModel

 - (instancetype)init
{
    if (self = [super init]) {
        _type = @"";
        _price = @"";
        _image = @"";
        _deletePath = nil;
    }
    return self;
}
@end
