//
//  TYContentTableViewCell.h
//  modelscontrastlist
//
//  Created by zhang_qing on 2017/6/29.
//  Copyright © 2017年 ty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYContentTableView.h"

@interface TYContentTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * leftTextLabel;

@property (nonatomic, assign)CGFloat labelFont;

@property (nonatomic, strong) UICollectionView *contentCollectionView;

//@property (nonatomic, strong) TYContentTableView * contentTabel;

@end
