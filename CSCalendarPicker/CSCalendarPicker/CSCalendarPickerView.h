//
//  CSCalendarPickerView.h
//  XHHospital
//
//  Created by 徐呈赛 on 16/3/10.
//  Copyright © 2016年 XuhuiCompany. All rights reserved.
//  日历

#import <UIKit/UIKit.h>

@interface CSCalendarPickerView : UIView


//标记，YES代表起始时间日历,NO代表结束时间日历
@property (nonatomic,assign) BOOL startCalendar;

//改变自身的hidde值，并且通过hidde来决定是否接收通知
-(void)setCalendarPickerHidde:(BOOL)hidde;

@end
