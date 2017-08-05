//
//  TYContentTableView.m
//  modelscontrastlist
//
//  Created by zhang_qing on 2017/6/29.
//  Copyright © 2017年 ty. All rights reserved.
//

#import "TYContentTableView.h"
#import "headerViewModel.h"
#import "HeaderView.h"
#import "Macro.h"
#import <UIKit/UIKit.h>
#import "TYContentTableViewCell.h"
#import "TableCollectionViewCell.h"
#import "ModelContrast.h"
#import "JisuanTopCell.h"
#import "JisuanContentCell.h"
#import "UIImageView+AutoImage.h"

@interface TYContentTableView ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,ChooseTypeButtonDelegate>

@property (nonatomic, strong)NSArray * leftTitleArray;

@property (nonatomic, assign)CGFloat nowContentOffSet;

@property (nonatomic, strong)NSMutableArray * dataArray;

@property (nonatomic, assign) float baifenbi;

@property (nonatomic, assign) int styleInt;//CollectionViewCell的样式

@property (nonatomic, assign) int algorithmType;//算法的种类 例如：分期 对应1

@property (nonatomic, strong)NSMutableArray * deleteIndexPaths;//删除相同的数据位置

@property (nonatomic, strong)NSMutableArray * insertIndexPaths;//插入相同的数据位置

@property (nonatomic, strong)NSMutableDictionary * sameDataDict;

@end

@implementation TYContentTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.backgroundColor = [UIColor whiteColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addModel) name:@"addModel" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deleteModel:) name:@"deleteData" object:nil];
         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(yinCanSameData) name:@"hiden" object:nil];
         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showSameData) name:@"show" object:nil];
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[TYContentTableViewCell class] forCellReuseIdentifier:@"TYContentTableViewCell"];
        [self registerClass:[JisuanTopCell class] forCellReuseIdentifier:@"JisuanTopCell"];
        [self registerClass:[JisuanContentCell class] forCellReuseIdentifier:@"JisuanContentCell"];
        self.nowContentOffSet = 0;
        self.baifenbi = 0.0;
        //默认是全款
        self.algorithmType = 4;
        [self createData];
    }
    return self;
}

/**
 创建假数据
 */
- (void)createData
{
    self.dataArray = [NSMutableArray array];
    NSString * value1 = [NSString stringWithFormat:@"%.0f",self.baifenbi * 11000000];
    NSString * value2 = [NSString stringWithFormat:@"%.0f",self.baifenbi * 7400000];
 
    NSString * value3 = [NSString stringWithFormat:@"%.0f",11000000 - self.baifenbi * 11000000];
    NSString * value4 = [NSString stringWithFormat:@"%.0f",7400000 - self.baifenbi * 7400000];
    //里面多少大项 每个大项里面多少小项
    
    NSMutableArray * arrayOne0 = [NSMutableArray array];
    NSMutableArray * arrayOne1 = [NSMutableArray array];
    NSMutableArray * arrayOne2 = [NSMutableArray arrayWithObjects:value1,value2,@"", nil];
    NSMutableArray * arrayOne3 = [NSMutableArray arrayWithObjects:value3,value4,@"", nil];
    NSMutableArray * arrayOne4 = [NSMutableArray arrayWithObjects:@"11000000",@"7400000",@"", nil];
    
    NSMutableArray * arrayTwo0 = [NSMutableArray arrayWithObjects:@"komatus",@"liugong",@"", nil];
    NSMutableArray * arrayTwo1 = [NSMutableArray arrayWithObjects:@"20.9t",@"21.5t",@"", nil];
    NSMutableArray * arrayTwo2 = [NSMutableArray arrayWithObjects:@"履带式",@"履带式",@"", nil];
    NSMutableArray * arrayTwo3 = [NSMutableArray arrayWithObjects:@"反铲",@"反铲",@"", nil];
    NSMutableArray * arrayTwo4 = [NSMutableArray arrayWithObjects:@"矿山型",@"通用型",@"", nil];
    
    NSMutableArray * arrayOne = [NSMutableArray arrayWithObjects:arrayOne0,arrayOne1,arrayOne2,arrayOne3,arrayOne4, nil];
    NSMutableArray * arrayTwo = [NSMutableArray arrayWithObjects:arrayTwo0,arrayTwo1,arrayTwo2,arrayTwo3,arrayTwo4, nil];
    [self.dataArray addObject:arrayOne];
    [self.dataArray addObject:arrayTwo];
}

/**
 通知响应方法 - 添加数据
 */
- (void)addModel
{
    NSLog(@"我要添加一个数据");
    for (NSMutableArray * array in self.dataArray) {
        for (NSMutableArray * subArray in array) {
            if (subArray.count > 0) {
                [subArray insertObject:@"1" atIndex:subArray.count-1];
            }
        }
    }
    for (TYContentTableViewCell* cell in self.visibleCells) {
        for (UIView *view in cell.contentView.subviews) {
            if ([view isKindOfClass:[UICollectionView class]]) {
                UICollectionView *collectionView = (UICollectionView *)view;
                [collectionView reloadData];
            }
        }
    }
}
/**
 删除数据
 */
- (void)deleteModel:(NSNotification *)noti
{
    //使用object处理数据
    NSIndexPath * deletePath = [noti object];
    NSLog(@"CollectionView~~~~~~~~删除%ld数据",(long)deletePath.row);
    //1.先把数组里面的元素删除
    for (NSMutableArray * array in self.dataArray) {
        if (array) {
            for (NSMutableArray * subArray in array) {
                if (subArray.count > 0) {
                    [subArray removeObjectAtIndex:deletePath.row];
                }
            }
        }
    }
    //2.再删除界面的元素
   
    for (TYContentTableViewCell* cell in self.visibleCells) {
        for (UIView *view in cell.contentView.subviews) {
            if ([view isKindOfClass:[UICollectionView class]]) {
                UICollectionView *collectionView = (UICollectionView *)view;
                [collectionView performBatchUpdates:^{
                    [collectionView deleteItemsAtIndexPaths:@[deletePath]];
                } completion:^(BOOL finished) {
                    [collectionView reloadData];
                }];
            }
        }
    }
}


- (NSArray *)numArr
{
    if (!_numArr) {
        _numArr = [NSArray arrayWithObjects:@"计算器",@"常规参数",@"发动机系统",@"性能参数",@"整机尺寸",@"作业范围",@"油类容量",@"液压系统",@"口碑案例", nil];    }
    return _numArr;
}

- (NSArray *)leftTitleArray
{
    if (!_leftTitleArray) {
        _leftTitleArray = @[@"品牌",@"挖掘机吨位",@"行走方式",@"铲斗形式",@"工况用途"];
    }
    return _leftTitleArray;
}

//张庆添加
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.numArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return numArr.count;
    if (section == 0) {
        return [self.dataArray[0] count];
    }
    if (section == 1) {
        return [self.dataArray[1] count];
    }
    if (section == 2) {
      
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAKSELF
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            JisuanTopCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JisuanTopCell"];
            cell.delegate = self;
            return cell;
        }
        if (indexPath.row == 1){
            JisuanContentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JisuanContentCell"];
            cell.sliderBlock = ^(float value){
                NSLog(@"%f",value);
                weakSelf.baifenbi = value / 100.0;
                //数据更新一下
                [weakSelf reloadDataWithAlgorithmType];
                [weakSelf beginUpdates];
                [weakSelf reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:2 inSection:0],[NSIndexPath indexPathForRow:3 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
                [weakSelf endUpdates];
            };
            return cell;
        }
    }
    
    TYContentTableViewCell *cell = (TYContentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TYContentTableViewCell"];
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            cell.leftTextLabel.text = @"首付车款";
            self.styleInt = 0;
        }
        if (indexPath.row == 3) {
            cell.leftTextLabel.text = @"尾款";
            self.styleInt = 0;
        }
        if (indexPath.row == 4) {
            cell.leftTextLabel.text = @"设备总造价";
            self.styleInt = 0;
        }
    }
    if (indexPath.section == 1) {
        cell.leftTextLabel.text = self.leftTitleArray[indexPath.row];
        if (indexPath.row == 0) {
            self.styleInt = 1;
        }
        if (indexPath.row == 1) {
            self.styleInt = 0;
        }
        if (indexPath.row == 2) {
            self.styleInt = 0;
        }
        if (indexPath.row == 3) {
            self.styleInt = 0;
        }
        if (indexPath.row == 4) {
            self.styleInt = 0;
        }
    }
    //必须有这句话防止添加多个对象 （注：不能用一个对象 数据出乱）
    [cell.contentCollectionView removeFromSuperview];
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewFlowLayout.minimumInteritemSpacing = 0;
    collectionViewFlowLayout.minimumLineSpacing = 0;
    [collectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    UICollectionView *contentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(120, 0, SIZE.width-120, 44) collectionViewLayout:collectionViewFlowLayout];
    contentCollectionView.showsHorizontalScrollIndicator = NO;
    contentCollectionView.backgroundColor = [UIColor whiteColor];
    contentCollectionView.delegate = self;
    contentCollectionView.dataSource = self;
    contentCollectionView.bounces = NO;
    [contentCollectionView registerClass:[TableCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    //必须给当前所有UICollectionView的便宜量
    contentCollectionView.contentOffset = CGPointMake(self.nowContentOffSet, 0);
    cell.contentCollectionView = contentCollectionView;
    [cell.contentView addSubview:cell.contentCollectionView];
    cell.contentCollectionView.tag = indexPath.section * 100 + indexPath.row;
    
    return cell;
}

#pragma mark - tabelView的代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

//张庆添加
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 42.0f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeaderView * headerView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, 42)];
    headerView.titleLabel.text = _numArr[section];
    return headerView;
}

#pragma mark - collectionView的代理方法

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = collectionView.tag / 100;
    NSInteger row = collectionView.tag % 100;
    
    TableCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
   
//    if (self.styleInt == 0) {
//        cell.styleInt = 0;
//        cell.textLabel.text = self.dataArray[section][row][indexPath.row];
//    }
//    if (self.styleInt == 1) {
//        cell.styleInt = 1;
//        cell.imageV.image = [UIImage imageNamed:self.dataArray[section][row][indexPath.row]];
//        [cell.imageV autoImage];
//    }
    if (section == 1 && row == 0) {//品牌
        cell.styleInt = 1;
        cell.imageV.image = [UIImage imageNamed:self.dataArray[section][row][indexPath.row]];
        [cell.imageV autoImage];
    }else {
        cell.styleInt = 0;
        cell.textLabel.text = self.dataArray[section][row][indexPath.row];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath{
    return CGSizeMake(120, 44);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataArray[0][3] count];//这可以根据数组中的不变的个数来添加
}

#pragma mark - scrollView 的代理方法

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        
        if (scrollView.contentOffset.y != 0) {
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
            return;
        }
        for (TYContentTableViewCell* cell in self.visibleCells) {
            for (UIView *view in cell.contentView.subviews) {
                if ([view isKindOfClass:[UICollectionView class]]) {
                    UICollectionView *collectionView = (UICollectionView *)view;
                    collectionView.contentOffset = scrollView.contentOffset;
                }
            }
        }
        self.nowContentOffSet = scrollView.contentOffset.x;
        [self setValue:[NSValue valueWithCGPoint:scrollView.contentOffset] forKey:TYContentTableCellCollectionViewObserver];
    }
}

// 不做容错处理crash
- (id)valueForUndefinedKey:(NSString *)key{
    return TYContentTableCellCollectionViewObserver;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
#pragma mark - JisuanTopCell的代理方法
- (void)buttonClick:(UIButton *)button buttonArray:(NSArray *)buttonArray
{
    for (UIButton * button in buttonArray) {
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [button setBackgroundColor:[UIColor blueColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.algorithmType = (int)button.tag - 800;
}

- (void)reloadDataWithAlgorithmType
{
    switch (self.algorithmType) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
//        case后的第一句话不能定义变量，如果非要定义变量，需要加{}。
        {
            NSMutableArray * array3 = self.dataArray[0][4];
            NSMutableArray * tiArray1 = [NSMutableArray array];
            NSMutableArray * tiArray2 = [NSMutableArray array];
            for (NSString * str in array3) {
                if ([str isEqualToString:@""]) {
                    [tiArray1 addObject:@""];
                }else {
                    int i = [str intValue] * self.baifenbi;
                    [tiArray1 addObject:[NSString stringWithFormat:@"%d",i]];
                }
            }
            for (NSString * str in array3) {
                if ([str isEqualToString:@""]) {
                    [tiArray2 addObject:@""];
                }else {
                    int i = [str intValue] - [str intValue] * self.baifenbi;
                    [tiArray2 addObject:[NSString stringWithFormat:@"%d",i]];
                }
            }
            [self.dataArray[0] replaceObjectAtIndex:2 withObject:tiArray1];
            [self.dataArray[0] replaceObjectAtIndex:3 withObject:tiArray2];
        }
            break;
        case 5:
            
            break;
        case 6:
            
            break;
        default:
            break;
    }
}

/**
 隐藏相同的数据
 */
- (void)yinCanSameData
{
    self.deleteIndexPaths = [NSMutableArray array];
    self.insertIndexPaths = [NSMutableArray array];
    self.sameDataDict = [[NSMutableDictionary alloc]init];
    NSLog(@"隐藏相同的数据");
    //1.先查找数组中相同的数据 删除数据
    for (int k = 1; k < self.dataArray.count; k ++) {
        NSMutableArray * dataArray = self.dataArray[k];
        for (int j = 0; j < dataArray.count;j++) {
            NSMutableArray * subDataArray = dataArray[j];
            if (subDataArray.count > 0) {
                for (int i = 0; i < subDataArray.count - 1; i++) {//最后一个为空
                    if ([subDataArray[i] isEqual:subDataArray[0]]) {
                
                    }else {
                        break;
                    }
                    if (i == (int)subDataArray.count - 2) {
                        [self.sameDataDict setObject:subDataArray forKey:[NSIndexPath indexPathForRow:j inSection:k]];
                        [self.deleteIndexPaths addObject:[NSIndexPath indexPathForRow:j inSection:k]];
                    }
                }
            }
        }
    }
     for (int k = 1; k < self.dataArray.count; k ++) {
         NSMutableArray * array = self.dataArray[k];
         NSMutableIndexSet * indexs = [[NSMutableIndexSet alloc]init];
         for (NSIndexPath * index in self.deleteIndexPaths) {
             if (k == (int)index.section) {
                 [indexs addIndex:index.row];
             }
         }
         [array removeObjectsAtIndexes:indexs];
     }
    //2.再根据数组中相同数据的位置更新画面
    [self beginUpdates];
    [self deleteRowsAtIndexPaths:self.deleteIndexPaths withRowAnimation:UITableViewRowAnimationBottom];
    [self endUpdates];
}

/**
 显示相同的数据
 */
- (void)showSameData
{
    NSLog(@"展示相同的数据");
    self.insertIndexPaths = [NSMutableArray arrayWithArray:self.deleteIndexPaths];
    for (int k = 1; k < self.dataArray.count; k ++) {
        NSMutableArray * array = self.dataArray[k];
        NSMutableIndexSet * indexs = [[NSMutableIndexSet alloc]init];
        NSMutableArray * sameArray = [NSMutableArray array];
        for (NSIndexPath * index in self.insertIndexPaths) {
            if (k == (int)index.section) {
                [sameArray addObject:self.sameDataDict[index]];
                [indexs addIndex:index.row];
            }
        }
        [array insertObjects:sameArray atIndexes:indexs];
    }
    //2.再根据数组中相同数据的位置更新画面
    [self beginUpdates];
    [self insertRowsAtIndexPaths:self.insertIndexPaths withRowAnimation:UITableViewRowAnimationTop];
    [self endUpdates];
}

/**
 移除通知
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
