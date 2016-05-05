//
//  dateOfView.m
//  XHHospital
//
//  Created by 徐呈赛 on 16/3/14.
//  Copyright © 2016年 XuhuiCompany. All rights reserved.
//

#import "dateOfView.h"
#import "UIView+Extension.h"
@implementation dateOfView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        for (int i = 0; i < 7; i++) {
            
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            label.tag = i;
            [self addSubview:label];
            label.textColor = [[UIColor alloc]initWithRed:0 / 255.0 green:188 / 255.0 blue:212 / 255.0 alpha:1.0];
            
            
            switch (i) {
                case 0:
                    label.text = @"日";
                    
                    break;
                case 1:
                    label.text = @"一";
                    
                    break;
                case 2:
                    label.text = @"二";
                    
                    break;
                case 3:
                    label.text = @"三";
                    
                    break;
                case 4:
                    label.text = @"四";
                    
                    break;
                case 5:
                    label.text = @"五";
                    
                    break;
                case 6:
                    label.text = @"六";
                    
                    break;
                    
                default:
                    break;
            }
        }
        
        
        //通知修改主题颜色
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ThemeColor:) name:@"ThemeColor" object:nil];
        
        
        
    }
    return self;
}


//通知修改主题颜色
-(void)ThemeColor:(NSNotification *)notification
{
    
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[UILabel class]]) {
            
            UILabel *label = (UILabel *)view;
            label.textColor = notification.userInfo[@"color"];
        }
    }
   
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView *label in self.subviews) {
        
        label.width  = self.width / self.subviews.count;
        label.height = self.height;
        label.y = 0;
        label.x = label.width * label.tag;
    }
}
@end
