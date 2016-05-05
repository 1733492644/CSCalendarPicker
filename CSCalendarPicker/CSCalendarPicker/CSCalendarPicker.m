//
//  CSCalendarPicker.m
//  XHHospital
//
//  Created by 徐呈赛 on 16/3/10.
//  Copyright © 2016年 XuhuiCompany. All rights reserved.
//

#import "CSCalendarPicker.h"
#import "CSHeaderView.h"
#import "CSPickerView.h"

@interface CSCalendarPicker ()

//头部View
@property (weak, nonatomic) IBOutlet CSHeaderView *headerView;

//确认按钮
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

//选中的起始时间
@property (nonatomic,strong) NSDate *startingDate;

//选中的结束时间
@property (nonatomic,strong) NSDate *endDate;

//底部的横线
@property (weak, nonatomic) IBOutlet UIView *horizontalLine;



@end


@implementation CSCalendarPicker


//初始化日历
+(CSCalendarPicker *)calendarPicker
{
    return [[[NSBundle mainBundle]loadNibNamed:@"CSCalendarPicker" owner:nil options:nil]lastObject];
}


//显示日历
-(void)show
{
    
    UIWindow *lastWindow = [[UIApplication sharedApplication].windows lastObject];
    self.frame = lastWindow.bounds;
    
    [lastWindow addSubview:self];
   
}

//背景灰色遮盖点击
- (IBAction)CoverClick:(UIButton *)sender {
    
    //移除日期选择器
    [self removeFromSuperview];
}

//确认按钮点击，调用代理方法传值
- (IBAction)determineBtnClick:(UIButton *)sender {
    
    
    [self.delegate calendarPicker:self didSelectStartingDate:self.startingDate endDate:self.endDate];
    
    //移除日历
    [self removeFromSuperview];
    
}




-(void)awakeFromNib
{
    //通知，把选中的时间告诉日历，通过标记来区分是起始时间还是结束时间
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedTime:) name:@"selectedTime" object:nil];
}

//设置自定义颜色
-(void)setColor:(UIColor *)color
{
    _color = color;
    
    self.horizontalLine.backgroundColor = color;
    
    [self.confirmBtn setBackgroundColor:color];
    
    //通知修改主题颜色
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ThemeColor" object:nil userInfo:@{@"color" : color}];
}



-(void)selectedTime:(NSNotification *)notificaion
{
    //选中时间
    NSDate *selectedDate = notificaion.userInfo[@"selectedTime"];
    

    //是否是起始时间
    BOOL startTime = [notificaion.userInfo[@"startCalendar"] boolValue];
    if (startTime == YES) {
        
        self.startingDate = selectedDate;
    }else{
    
        self.endDate = selectedDate;
    }
    
    
    if (self.endDate == nil) {
        
        self.endDate = self.startingDate;
    }
    
    
}



@end
