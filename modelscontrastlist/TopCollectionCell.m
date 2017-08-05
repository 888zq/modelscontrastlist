//
//  TopCollectionCell.m
//  modelscontrastlist
//
//  Created by zhang_qing on 2017/6/29.
//  Copyright © 2017年 ty. All rights reserved.
//

#import "TopCollectionCell.h"
#import "LSScreenSize.h"
#import "UIImageView+AutoImage.h"

@implementation TopCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [[LSScreenSize getInstance] iPhoneScreenSizeIs4inch:^(CGFloat width) {
            
            self.labelFont = 8;
        } isInch47:^(CGFloat width) {
            self.labelFont = 10;
        } isInch55:^(CGFloat width) {
            self.labelFont = 12;
        } common:^(CGFloat width) {
            
        }];
        [self makeUI];
    }
    return self;
}

- (void)makeUI
{
    _imageView = [[UIImageView alloc]init];
    _imageView.layer.borderWidth = 1.0f;
    _imageView.layer.cornerRadius = 5.0f;
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.contentView addSubview:_imageView];
    
    _typeLabel = [[UILabel alloc]init];
    _typeLabel.backgroundColor = [UIColor clearColor];
    _typeLabel.font = [UIFont systemFontOfSize:self.labelFont];
    _typeLabel.text = @"PC210LC-8";
    _typeLabel.textAlignment = NSTextAlignmentCenter;
    [_imageView addSubview:_typeLabel];
    
    _priceLabel = [[UILabel alloc]init];
    [_priceLabel setTextColor:[UIColor redColor]];
    _priceLabel.backgroundColor = [UIColor clearColor];
    _priceLabel.font = [UIFont systemFontOfSize:self.labelFont];
    _priceLabel.text = @"110万";
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    [_imageView addSubview:_priceLabel];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"圆形差号"] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deleteOneModel:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteBtn];
    _deleteBtn.layer.borderWidth = 0.1f;
    _deleteBtn.layer.cornerRadius = 10.0f;
    _deleteBtn.layer.masksToBounds = YES;
    _deleteBtn.layer.borderColor = [UIColor clearColor].CGColor;
    
}

- (void)deleteOneModel:(UIButton *)button
{
    NSLog(@"删除%ld数据",(long)_model.deletePath.row);
    //发送删除的通知 先用视图的方法删除当前显示数据 然后删除数组里面的第几个元素
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteData" object:_model.deletePath];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.height-10);
    _typeLabel.frame = CGRectMake(0,80, _imageView.frame.size.width, 15);
    _priceLabel.frame = CGRectMake(0, CGRectGetMaxY(_typeLabel.frame)+ 2,  _imageView.frame.size.width , 13);
    _deleteBtn.frame = CGRectMake(_imageView.frame.size.width - 5.0f, 0.0f, 20.0f, 20.0f);
}

- (void)setModel:(TopCollectionCellModel *)model
{
    _model = model;
    _typeLabel.text = model.type;
    _priceLabel.text = model.price;
    _imageView.image = [UIImage imageNamed:model.image];
    [_imageView autoImage];
}

@end
