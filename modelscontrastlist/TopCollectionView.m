//
//  TopCollectionView.m
//  modelscontrastlist
//
//  Created by zhang_qing on 2017/6/28.
//  Copyright © 2017年 ty. All rights reserved.
//

#import "TopCollectionView.h"
#import "Macro.h"
#import "TopCollectionCell.h"
#import "ModelContrast.h"
#import "TopCollectionCellModel.h"
#import "AddTopCollectionViewCell.h"

@interface TopCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)NSMutableArray * dataArray;

@end

@implementation TopCollectionView

//- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
//{
//    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
//        self.backgroundColor = [UIColor whiteColor];
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addModel) name:@"addModel" object:nil];
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deleteModel:) name:@"deleteData" object:nil];
//        self.delegate = self;
//        self.dataSource = self;
//        [self registerClass:[TopCollectionCell class] forCellWithReuseIdentifier:@"TopCollectionCell"];
//        [self registerClass:[AddTopCollectionViewCell class] forCellWithReuseIdentifier:@"AddTopCollectionViewCell"];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addModel) name:@"addModel" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deleteModel:) name:@"deleteData" object:nil];
        UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        [collectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:collectionViewFlowLayout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self.collectionView registerClass:[TopCollectionCell class] forCellWithReuseIdentifier:@"TopCollectionCell"];
        [self.collectionView registerClass:[AddTopCollectionViewCell class] forCellWithReuseIdentifier:@"AddTopCollectionViewCell"];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
      NSArray * data = [NSArray  arrayWithObjects:@{@"type":@"PC210LC-8",@"price":@"110万",@"image":@"wajueji1.jpg"},@{@"type":@"CLG920D",@"price":@"74万",@"image":@"wajueji2.jpg"}, nil];
        for (int i = 0; i < data.count; i++) {
            TopCollectionCellModel * model = [[TopCollectionCellModel alloc]init];
            model.type = data[i][@"type"];
            model.price = data[i][@"price"];
            model.image = data[i][@"image"];
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}

/**
 添加数据
 */
- (void)addModel
{
    TopCollectionCellModel * model = [[TopCollectionCellModel alloc]init];
    model.type = @"1";
    model.price = @"1";
    model.image = @"wajueji1.jpg";
    [_dataArray addObject:model];
    
    [self.collectionView reloadData];
}

/**
 删除数据
 */
- (void)deleteModel:(NSNotification *)noti
{
     //使用object处理数据
    NSIndexPath * deletePath = [noti object];
    NSLog(@"~~~~~~~~~~~~~~删除%ld数据",(long)deletePath.row);
    //1.先把数组里面的元素删除
    //row 不更新
    [_dataArray removeObjectAtIndex:deletePath.row];
    //2.再删除界面的元素 否则会奔溃
    [self.collectionView performBatchUpdates:^{
        [self.collectionView deleteItemsAtIndexPaths:@[deletePath]];
    } completion:^(BOOL finished) {
        //必须添加这句话让其执行代理方法
        [self.collectionView reloadData];
    }];
}

#pragma mark --collectionViewDataSource&&collectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataArray.count) {
        AddTopCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddTopCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }
    
    TopCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopCollectionCell" forIndexPath:indexPath];
    if (indexPath.row < self.dataArray.count) {
        
        TopCollectionCellModel * model = self.dataArray[indexPath.row];
        model.deletePath = indexPath;
        [cell setModel:model];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath{
    
    return CGSizeMake(110, 120);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataArray.count) {
        
        NSLog(@"点击我添加一个！！！！！！！！");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addModel" object:nil];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self setValue:[NSValue valueWithCGPoint:scrollView.contentOffset] forKey:TopCollectionViewObserver];
}

- (id)valueForUndefinedKey:(NSString *)key{
    return TopCollectionViewObserver;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
