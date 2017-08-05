//
//  JisuanContentCell.h
//  modelscontrastlist
//
//  Created by zhang_qing on 2017/6/30.
//  Copyright © 2017年 ty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberSlider.h"
#import "TYContentTableView.h"

@interface JisuanContentCell : UITableViewCell

@property (nonatomic, strong)NumberSlider * progress;

@property (nonatomic, strong) UILabel * leftLabel;

@property (nonatomic, copy) void (^sliderBlock) (float  value);

@end
