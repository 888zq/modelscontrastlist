//
//  ModelContrastViewController.m
//  modelscontrastlist
//
//  Created by zhang_qing on 2017/6/28.
//  Copyright © 2017年 ty. All rights reserved.
//

#import "ModelContrastViewController.h"
#import "Macro.h"
#import "TopCollectionView.h"
#import "TYContentTableView.h"
#import "ModelContrast.h"
#import "TopCollectionCell.h"
#import "TYContentTableViewCell.h"
#import "YBPopupMenu.h"

@interface ModelContrastViewController ()<YBPopupMenuDelegate>

@property (nonatomic ,strong)UIButton * topButton;//隐藏相同

@property (nonatomic ,strong)TopCollectionView * topCollView;

@property (nonatomic ,strong)TYContentTableView * contentTabelView;

@end

@implementation ModelContrastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = IWColor(20.0, 125.0, 212.0);
     self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"机型对比";
    [self addRightButton];
    [self.view addSubview:self.topButton];
    [self.view addSubview:self.topCollView];
    [self.view addSubview:self.contentTabelView];
    
    [self.topCollView addObserver:self forKeyPath:TopCollectionViewObserver options:NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld context:nil];
    [self.contentTabelView addObserver:self forKeyPath:TYContentTableCellCollectionViewObserver options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)addRightButton
{
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 50, 50);
    [rightButton setTitle:@"分类" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -8;//这个值可以根据自己需要自己调整
    self.navigationItem.rightBarButtonItems = @[nagetiveSpacer, rightItem];
}

- (void)rightButtonClick:(UIButton *)sender
{
    [YBPopupMenu showRelyOnView:sender titles:@[@"计算器",@"常规参数",@"发动机系统",@"性能参数",@"整机尺寸",@"作业范围",@"油类容量",@"液压系统",@"口碑案例"] icons:nil menuWidth:120.0f delegate:self];
}


- (UIButton *)topButton
{
    if (!_topButton) {
        _topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _topButton.frame = CGRectMake(10,64 + 20, 100, 100);
        _topButton.layer.borderWidth = 1.0f;
        _topButton.layer.cornerRadius = 50.0f;
        _topButton.layer.masksToBounds = YES;
        _topButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [_topButton addTarget:self action:@selector(topBUttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(26, 15, 48, 48)];
        imageV.image = [UIImage imageNamed:@"手.png"];
        self.imageView = imageV;
        [_topButton addSubview:imageV];
        
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageV.frame), 80, 30)];
        titleLabel.text = @"隐藏相同";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:17.0f];
        self.label = titleLabel;
        [_topButton addSubview:titleLabel];
        
    }
    return _topButton;
}

- (void)topBUttonClick:(UIButton *)sender
{
    NSLog(@"我被点击了");
    sender.selected = !sender.selected;
    if (sender.selected) {
        
        NSLog(@"1");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hiden" object:nil];
        
        //更改按钮
        self.imageView.image = [UIImage imageNamed:@"隐藏"];
        self.label.text = @"取消隐藏";
        
    }else {
        NSLog(@"2");
         [[NSNotificationCenter defaultCenter] postNotificationName:@"show" object:nil];
        //更改按钮
        self.imageView.image = [UIImage imageNamed:@"手"];
        self.label.text = @"隐藏相同";
    }
}

/**
 懒加载
 */
- (TopCollectionView *)topCollView
{
    if (!_topCollView) {
//        UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
//        [collectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//        _topCollView = [[TopCollectionView alloc] initWithFrame:CGRectMake(120,64 + 10, SIZE.width - 120, 120) collectionViewLayout:collectionViewFlowLayout];
//        _topCollView.showsHorizontalScrollIndicator = NO;
        _topCollView = [[TopCollectionView alloc]initWithFrame:CGRectMake(120,64 + 10, SIZE.width - 120, 120)];
    }
    return _topCollView;
}

- (TYContentTableView *)contentTabelView
{
    if (!_contentTabelView) {
        _contentTabelView = [[TYContentTableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topCollView.frame)+ 5, SIZE.width, SIZE.height - CGRectGetMaxY(self.topCollView.frame) - 5) style:UITableViewStylePlain];
    }
    return _contentTabelView;
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context{
    
    if ([keyPath isEqualToString:TopCollectionViewObserver]) {
        for (TYContentTableViewCell * cell in self.contentTabelView.visibleCells) {
            for (UIView *view in cell.contentView.subviews) {
                if ([view isKindOfClass:[UICollectionView class]]) {
                    UICollectionView *collectionView = (UICollectionView *)view;
                    collectionView.contentOffset = self.topCollView.collectionView.contentOffset;
                }
            }
        }
    }
    
    if ([keyPath isEqualToString:TYContentTableCellCollectionViewObserver]) {
        for (TYContentTableViewCell *cell in self.contentTabelView.visibleCells) {
            for (UIView *view in cell.contentView.subviews) {
                if ([view isKindOfClass:[UICollectionView class]]) {
                    UICollectionView *collectionView = (UICollectionView *)view;
                    self.topCollView.collectionView.contentOffset = collectionView.contentOffset;
                }
            }
        }
    }
}

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{WEAKSELF
    CGRect frame =  [self.contentTabelView rectForSection:index];
    [UIView animateWithDuration:0.35 animations:^{
        
        weakSelf.contentTabelView.contentOffset = CGPointMake(0, CGRectGetMinY(frame));
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.topCollView removeObserver:self forKeyPath:TopCollectionViewObserver];
    [self.contentTabelView removeObserver:self forKeyPath:TYContentTableCellCollectionViewObserver];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
