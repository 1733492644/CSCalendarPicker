//
//  CalendarBtn.m
//  XHHospital
//
//  Created by 徐呈赛 on 16/3/14.
//  Copyright © 2016年 XuhuiCompany. All rights reserved.
//

#import "CalendarBtn.h"

@interface CalendarBtn ()

@property (nonatomic,strong) UIColor *color;


//选中状态颜色
@property (nonatomic,strong) UIColor *setBackgroundColor;


@end


@implementation CalendarBtn

-(instancetype)init
{
    if (self = [super init]) {
        
        self.color = [[UIColor alloc]initWithRed:0 / 255.0 green:188 / 255.0 blue:212 / 255.0 alpha:1.0];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        
        
        
        //通知修改主题颜色
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ThemeColor:) name:@"ThemeColor" object:nil];
        
        
    }
    return self;
}


//通知修改主题颜色
-(void)ThemeColor:(NSNotification *)notification
{
    self.setBackgroundColor = notification.userInfo[@"color"];
    
    if (self.selected == YES) {
        
        [self setSelected:YES];
    }
    
}



-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        
        [self setBackgroundColor:self.setBackgroundColor ? self.setBackgroundColor : self.color];
        
    }else{
    
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    
    
    
}

-(void)setHighlighted:(BOOL)highlighted{}
@end
