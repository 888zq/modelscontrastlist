//
//  JisuanContentCell.m
//  modelscontrastlist
//
//  Created by zhang_qing on 2017/6/30.
//  Copyright © 2017年 ty. All rights reserved.
//

#import "JisuanContentCell.h"
#import "Macro.h"

@implementation JisuanContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self makeUI];
    }
    return self;
}

- (void)makeUI
{
    self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
    self.leftLabel.textAlignment = NSTextAlignmentCenter;
    self.leftLabel.text = @"首付比例";
    [self.contentView addSubview:self.leftLabel];
    
    UIImageView * leftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(125, 10, 24, 24)];
    leftImageV.image = [UIImage imageNamed:@"goldCoin"];
    [self.contentView addSubview:leftImageV];
    
    self.progress = [[NumberSlider alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftImageV.frame) + 6, 7, SIZE.width - 148 - 6 - 30 - 6, 30)];
    self.progress.minimumTrackTintColor = [UIColor orangeColor];//设置滑轮左边的颜色
    self.progress.maximumTrackTintColor = [UIColor grayColor]; //设置滑轮右边的颜色
    self.progress.minimumValue = 0.0;
    self.progress.maximumValue = 100.0;
    [self.progress setValue:0 animated:NO];
    [self.contentView addSubview:self.progress];
    [self.progress addTarget:self action:@selector(progressClick:) forControlEvents:UIControlEventValueChanged];
    
    UIImageView * rightImageV = [[UIImageView alloc]initWithFrame:CGRectMake(SIZE.width - 30, 10, 24, 24)];
    rightImageV.image = [UIImage imageNamed:@"goldCoin1"];
    [self.contentView addSubview:rightImageV];
    
    UIView *vLineView = [[UIView alloc] initWithFrame:CGRectMake(self.leftLabel.frame.size.width-1, 0, 1, self.leftLabel.frame.size.height)];
    vLineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:vLineView];
    
    UIView *hLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.leftLabel.frame.size.height-1,SIZE.width, 1)];
    hLineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:hLineView];
}

- (void)progressClick:(NumberSlider *)slider
{
    NSString * intValue = [NSString stringWithFormat:@"%.0f",slider.value];
    self.sliderBlock([intValue floatValue]);
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
