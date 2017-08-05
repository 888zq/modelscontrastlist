//
//  AddTopCollectionViewCell.m
//  modelscontrastlist
//
//  Created by zhang_qing on 2017/7/3.
//  Copyright © 2017年 ty. All rights reserved.
//

#import "AddTopCollectionViewCell.h"

@implementation AddTopCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 1.0f;
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self makeUI];
    }
    return  self;
}

- (void)makeUI
{
    _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(40, 35, 30, 30)];
    _imageV.image = [UIImage imageNamed:@"加号.png"];
    [self.contentView addSubview:_imageV];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_imageV.frame)+10, 80, 30)];
    _titleLabel.text = @"添加机型";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [self.contentView addSubview:_titleLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

}

@end
