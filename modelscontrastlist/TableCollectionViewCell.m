//
//  TableCollectionViewCell.m
//  modelscontrastlist
//
//  Created by zhang_qing on 2017/6/29.
//  Copyright © 2017年 ty. All rights reserved.
//

#import "TableCollectionViewCell.h"

@implementation TableCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
      
        //可以删除
//        UIView *vLineView0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, self.contentView.frame.size.height)];
//        vLineView0.backgroundColor = [UIColor lightGrayColor];
//        [self.contentView addSubview:vLineView0];
        
        UIView *vLineView = [[UIView alloc] initWithFrame:CGRectMake(_textLabel.frame.size.width-1, 0, 1, self.contentView.frame.size.height)];
        vLineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:vLineView];
        
        UIView *hLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height-1, self.contentView.frame.size.width, 1)];
        hLineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:hLineView];
        
    }
    return self;
}

- (void)setStyleInt:(int)styleInt
{
    _styleInt = styleInt;
    if (styleInt == 0) {
        if (!self.textLabel) {
            _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
            _textLabel.backgroundColor = [UIColor clearColor];
            _textLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:_textLabel];
        }
        _textLabel.text = @"";
    }
    if (styleInt == 1) {
        if (!self.imageV) {
            _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10,  self.contentView.frame.size.width - 40,  self.contentView.frame.size.height-20)];
            [self.contentView addSubview:_imageV];
        }
        _imageV.image = nil;
    }
}

@end
