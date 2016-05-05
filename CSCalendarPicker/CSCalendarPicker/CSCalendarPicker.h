//
//  CSCalendarPicker.h
//  XHHospital
//
//  Created by 徐呈赛 on 16/3/10.
//  Copyright © 2016年 XuhuiCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSCalendarPicker.h"

@class CSCalendarPicker;


@protocol CSCalendarPickerDelegate <NSObject>

@optional

//代理方法，返回选中的起始时间和结束时间
-(void)calendarPicker:(CSCalendarPicker *)calendarPicker didSelectStartingDate:(NSDate *)startingDate endDate:(NSDate *)endDate;

@end


@interface CSCalendarPicker : UIView

@property (nonatomic ,weak)id <CSCalendarPickerDelegate>delegate;

//初始化日历
+(CSCalendarPicker *)calendarPicker;
//主题颜色
@property (nonatomic,strong) UIColor *color;

//显示日历
-(void)show;

@end
