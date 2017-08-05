//
//  TopCollectionCell.h
//  modelscontrastlist
//
//  Created by zhang_qing on 2017/6/29.
//  Copyright © 2017年 ty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopCollectionCellModel.h"

@interface TopCollectionCell : UICollectionViewCell

@property (nonatomic, strong)UIImageView * imageView;

@property (nonatomic, strong)UILabel * typeLabel;

@property (nonatomic, strong)UILabel * priceLabel;

@property (nonatomic, assign)CGFloat labelFont;

@property (nonatomic, strong)UIButton * deleteBtn;

@property (nonatomic, strong)TopCollectionCellModel * model;

@end
