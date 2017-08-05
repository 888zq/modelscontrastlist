//
//  HeaderView.m
//  tylist
//
//  Created by zhang_qing on 2017/6/20.
//  Copyright © 2017年 ty. All rights reserved.
//

#import "HeaderView.h"
#import "NSString+Extension.h"
#import "Macro.h"

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = HWColor(248.0, 248.0, 248.0);
        [self makeUI];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeader)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)makeUI
{
    _shuLabel = [[UILabel alloc]init];
    _shuLabel.backgroundColor = HWColor(12.0, 93.0, 254.0);
    [self addSubview:_shuLabel];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor blackColor];
    [self addSubview:_titleLabel];
    
//    CGFloat userLabelW = [NSString widthOfTheString:self.userLabel.text withFont:self.labelFont];
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_contentLabel];
    
    _pointLabel = [[UILabel alloc]init];
    _pointLabel.backgroundColor = [UIColor greenColor];
    _pointLabel.layer.masksToBounds = YES;
    _pointLabel.layer.cornerRadius = 4.0f;
    [self addSubview:_pointLabel];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_lineView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _shuLabel.frame = CGRectMake(5.0f,10.0f, 4.0f, 20.0f);
    CGFloat titleLabelW = [NSString widthOfTheString:@"客户名称" withFont:17];
    _titleLabel.frame = CGRectMake(20.0f, 10.0f, titleLabelW, 20.0f);
    _contentLabel.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame), 10.0f, self.frame.size.width - CGRectGetMaxX(_titleLabel.frame) - 30.0f, 20.0f);
    _pointLabel.frame = CGRectMake(CGRectGetMaxX(_contentLabel.frame) + 10.0f, 16.0f, 8.0, 8.0);
    _lineView.frame = CGRectMake(0, 40.0f, self.frame.size.width, 2.0f);
}

- (void)setModel:(headerViewModel *)model
{
    _model = model;
    _titleLabel.text = model.title;
    _contentLabel.text = model.content;
}

- (void)clickHeader
{
    WEAKSELF
    NSLog(@"开关~~~~~%u",weakSelf.model.kaiOrHe);
   //把model传过去
//    self.headerBlock(weakSelf.model);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
