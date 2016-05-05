//
//  SpecificDate.h
//  XHHospital
//
//  Created by 徐呈赛 on 16/3/14.
//  Copyright © 2016年 XuhuiCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecificDate : UIView




//标记，YES代表起始时间日历,NO代表结束时间日历
@property (nonatomic,assign) BOOL startCalendar;

//是否要接收通知
-(void)setSpecificDateNotificaion:(BOOL)determine;



@end
