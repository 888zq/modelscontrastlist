//
//  TYContentTableViewCell.m
//  modelscontrastlist
//
//  Created by zhang_qing on 2017/6/29.
//  Copyright © 2017年 ty. All rights reserved.
//

#import "TYContentTableViewCell.h"
#import "LSScreenSize.h"
#import "Macro.h"
#import "TableCollectionViewCell.h"
#import "ModelContrast.h"

@interface TYContentTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation TYContentTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self makeUI];
    }
    return self;
}

- (void)makeUI
{
    _leftTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 44)];
    _leftTextLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_leftTextLabel];
    
    UIView *vLineView = [[UIView alloc] initWithFrame:CGRectMake(120 - 1, 0, 1, 44)];
    vLineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:vLineView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44-1, SIZE.width, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineView];
    
//    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
//    collectionViewFlowLayout.minimumInteritemSpacing = 0;
//    collectionViewFlowLayout.minimumLineSpacing = 0;
//    [collectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//    UICollectionView *contentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(120, 0, SIZE.width-120, 44) collectionViewLayout:collectionViewFlowLayout];
//    contentCollectionView.showsHorizontalScrollIndicator = NO;
//    contentCollectionView.backgroundColor = [UIColor whiteColor];
//    contentCollectionView.delegate = self;
//    contentCollectionView.dataSource = self;
//    contentCollectionView.bounces = NO;
//    [self.contentView addSubview:contentCollectionView];
//    [contentCollectionView registerClass:[TableCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
//    self.contentCollectionView = contentCollectionView;
    
}

#pragma mark - collectionView的代理方法

//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    TableCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//  
//    return cell;
//}
//
//- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath{
//    return CGSizeMake(120, 44);
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 3;
//}

#pragma mark - scrollView 的代理方法

//- (void)scrollViewDidScroll:(UIScrollView*)scrollView
//{
//    if ([scrollView isKindOfClass:[UICollectionView class]]) {
//        
//        if (scrollView.contentOffset.y != 0) {
//            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
//            return;
//        }
//        for (TYContentTableViewCell* cell in self.contentTabel.visibleCells) {
//            for (UIView *view in cell.contentView.subviews) {
//                if ([view isKindOfClass:[UICollectionView class]]) {
//                    UICollectionView *collectionView = (UICollectionView *)view;
//                    collectionView.contentOffset = scrollView.contentOffset;
//                }
//            }
//        }
//        self.nowContentOffSet = scrollView.contentOffset.x;
//        [self setValue:[NSValue valueWithCGPoint:scrollView.contentOffset] forKey:TYContentTableCellCollectionViewObserver];
//    }
//}

// 不做容错处理crash
//- (id)valueForUndefinedKey:(NSString *)key{
//    return TYContentTableCellCollectionViewObserver;
//}
//
//- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
//    
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
