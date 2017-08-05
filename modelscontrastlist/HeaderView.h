//
//  HeaderView.h
//  tylist
//
//  Created by zhang_qing on 2017/6/20.
//  Copyright © 2017年 ty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "headerViewModel.h"

@interface HeaderView : UIView

@property (nonatomic, strong)UILabel * shuLabel;

@property (nonatomic, strong)UILabel * pointLabel;

@property (nonatomic, strong)UILabel * titleLabel;

@property (nonatomic, strong)UILabel * contentLabel;

@property (nonatomic, strong)UIView * lineView;

@property (nonatomic ,strong)headerViewModel * model;

@property (nonatomic, copy)void(^headerBlock)(headerViewModel * model);//点击header的事件


@end
