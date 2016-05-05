//
//  yearsChooseCell.m
//  XHHospital
//
//  Created by 徐呈赛 on 16/3/10.
//  Copyright © 2016年 XuhuiCompany. All rights reserved.
//

#import "yearsChooseCell.h"

@interface yearsChooseCell ()

//显示年份的Label
@property (nonatomic,weak) UILabel *dateLabel;

@end


@implementation yearsChooseCell



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UILabel *dateLabel = [[UILabel alloc]init];
        //文字居中对齐
        dateLabel.textAlignment=NSTextAlignmentCenter;
        self.dateLabel = dateLabel;
        [self.contentView addSubview:dateLabel];
        dateLabel.font = [UIFont systemFontOfSize:13];
        
        
       
        
        
    }
    return self;
}

-(void)setDate:(NSString *)date
{
    _date = date;
    
    self.dateLabel.text = date;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.dateLabel.frame = self.contentView.bounds;
    
   
}


@end
