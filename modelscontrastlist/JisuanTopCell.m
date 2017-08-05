//
//  JisuanTopCell.m
//  modelscontrastlist
//
//  Created by zhang_qing on 2017/6/30.
//  Copyright © 2017年 ty. All rights reserved.
//

#import "JisuanTopCell.h"
#import "Macro.h"
#import "NSString+Extension.h"
#import "LSScreenSize.h"

@interface JisuanTopCell ()<UIScrollViewDelegate>

@property (nonatomic, strong)NSArray * typeArray;

@end

@implementation JisuanTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [[LSScreenSize getInstance]iPhoneScreenSizeIs4inch:^(CGFloat width) {
            
            self.labelFont = 11.0f;
            
        } isInch47:^(CGFloat width) {
            
            self.labelFont = 13.0f;
        } isInch55:^(CGFloat width) {
            
            self.labelFont = 15.0f;
        } common:^(CGFloat width) {
            
        }];
        
        self.buttonArray = [NSMutableArray array];
        self.typeArray = @[@"融资",@"按揭",@"新机分期",@"二手机分期",@"全款",@"质保金",@"以租代售"];
        [self addSubview:self.scrollView];
        
        self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 43.0, SIZE.width, 1.0f)];
        self.lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width,44.0f)];
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        for (int i = 0; i < self.typeArray.count; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.layer.borderWidth = 1.0f;
            btn.layer.cornerRadius = 3.0f;
            btn.layer.masksToBounds = YES;
            btn.layer.borderColor = [UIColor blackColor].CGColor;
            [btn setTitle:self.typeArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:self.labelFont];
            [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 800 + i;
            [self.scrollView addSubview:btn];
            [self.buttonArray addObject:btn];
        }
        //融资
        UIButton * btn1 = (UIButton *)self.buttonArray[0];
        CGFloat width1 = [NSString widthOfTheString:self.typeArray[0] withFont:self.labelFont];
        btn1.frame = CGRectMake(5, 5, width1+8, 34);
        //按揭
        UIButton * btn2 = (UIButton *)self.buttonArray[1];
        CGFloat width2 = [NSString widthOfTheString:self.typeArray[1] withFont:self.labelFont];
        btn2.frame = CGRectMake(CGRectGetMaxX(btn1.frame)+5, 5, width2+8, 34);
        //新机分期
        UIButton * btn3 = (UIButton *)self.buttonArray[2];
        CGFloat width3 = [NSString widthOfTheString:self.typeArray[2] withFont:self.labelFont];
        btn3.frame = CGRectMake(CGRectGetMaxX(btn2.frame)+5, 5, width3+8, 34);
        //二手机分期
        UIButton * btn4 = (UIButton *)self.buttonArray[3];
        CGFloat width4 = [NSString widthOfTheString:self.typeArray[3] withFont:self.labelFont];
        btn4.frame = CGRectMake(CGRectGetMaxX(btn3.frame)+5, 5, width4+8, 34);
        //全款
        UIButton * btn5 = (UIButton *)self.buttonArray[4];
        CGFloat width5 = [NSString widthOfTheString:self.typeArray[4] withFont:self.labelFont];
        btn5.frame = CGRectMake(CGRectGetMaxX(btn4.frame)+5, 5, width5+8, 34);
        [btn5 setBackgroundColor:[UIColor blueColor]];
        [btn5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //质保金
        UIButton * btn6 = (UIButton *)self.buttonArray[5];
        CGFloat width6 = [NSString widthOfTheString:self.typeArray[5] withFont:self.labelFont];
        btn6.frame = CGRectMake(CGRectGetMaxX(btn5.frame)+5, 5, width6+8, 34);
        //以租代售
        UIButton * btn7 = (UIButton *)self.buttonArray[6];
        CGFloat width7 = [NSString widthOfTheString:self.typeArray[6] withFont:self.labelFont];
        btn7.frame = CGRectMake(CGRectGetMaxX(btn6.frame)+5, 5, width7+8, 34);
        
        _scrollView.contentSize = CGSizeMake(CGRectGetMaxX(btn7.frame) + 5, 0);
    }
    return _scrollView;
}

- (void)clickButton:(UIButton *)button
{
    [_delegate buttonClick:button buttonArray:self.buttonArray];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
