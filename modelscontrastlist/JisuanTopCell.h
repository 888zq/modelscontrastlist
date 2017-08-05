//
//  JisuanTopCell.h
//  modelscontrastlist
//
//  Created by zhang_qing on 2017/6/30.
//  Copyright © 2017年 ty. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseTypeButtonDelegate <NSObject>

-(void)buttonClick:(UIButton *)button buttonArray:(NSArray *)buttonArray;

@end

@interface JisuanTopCell : UITableViewCell

@property (nonatomic ,assign)CGFloat labelFont;

@property (nonatomic ,strong)UIScrollView * scrollView;

@property (nonatomic ,strong)NSMutableArray * buttonArray;

@property (nonatomic, strong)UIView * lineView;

//代理
@property (nonatomic,weak)id<ChooseTypeButtonDelegate>delegate;

@end
