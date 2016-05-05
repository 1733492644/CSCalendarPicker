//
//  SpecificDate.m
//  XHHospital
//
//  Created by 徐呈赛 on 16/3/14.
//  Copyright © 2016年 XuhuiCompany. All rights reserved.
//

#import "SpecificDate.h"
#import "CalendarBtn.h"
#import "NSDate+Extension.h"
#import "UIView+Extension.h"


@interface SpecificDate ()

//保存临时按钮
@property (nonatomic,strong) CalendarBtn *btn;

//当前选中月份有几天
@property (nonatomic,assign) NSInteger currentMonthLength;

//当前选中月份第一天是周几
@property (nonatomic,assign) NSInteger whatDay;

//当前选中年份
@property (nonatomic ,assign) NSInteger selectedYears;
//当前选中的月份
@property (nonatomic,assign) NSInteger selectedMonth;

//当前选中是哪一天
@property (nonatomic,assign) NSInteger selectedDay;

@end

@implementation SpecificDate


-(instancetype)init
{

    if (self = [super init]) {
        
        for (int i = 0; i < 42; i++) {
            
            CalendarBtn *btn = [[CalendarBtn alloc]init];

            btn.tag = i;
            
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
           
            
            [self addSubview:btn];
            
            
            
            
            
        }
        
        
        
        //通知，刷新日历
       [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(RefreshTheCalendar:) name:@"RefreshTheCalendar" object:nil];
        
        //[self selectedDate];
  
        
    }
    
   
    
    
    return self;
}



//是否要接收通知
-(void)setSpecificDateNotificaion:(BOOL)determine
{
    if (determine == YES) {
        //通知，刷新日历
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(RefreshTheCalendar:) name:@"RefreshTheCalendar" object:nil];
    }else{
    
        [[NSNotificationCenter defaultCenter]removeObserver:self];
    }
}


//日期按钮被点击
-(void)btnClick:(CalendarBtn *)btn
{
    if (btn.tag >= self.whatDay && btn.tag + 1 - self.whatDay <= self.currentMonthLength) {
        
    self.btn.selected = NO;
    btn.selected = YES;
    self.btn = btn;
        
    }
    
    self.selectedDay = btn.tag + 1 - self.whatDay;
    
   
    [self selectedDate];
    
  
    
    
}

//通知，刷新日历
-(void)RefreshTheCalendar:(NSNotification *)notification
{
   
    int years = [notification.userInfo[@"years"] intValue];
    int month = [notification.userInfo[@"month"] intValue];
    
    self.selectedYears = years;
    self.selectedMonth = month;
    
    //转化为NSDate
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM"];
    
    NSDate *date = [dateFormat dateFromString:[NSString stringWithFormat:@"%d-%d",years,month]];
    
    //当前选中月份有几天
    NSInteger currentMonthLength = [date totaldaysInThisMonth];
    self.currentMonthLength = currentMonthLength;
    //当前选中月份第一天是周几
    NSInteger whatDay = [date firstWeekdayInThisMonth];
    self.whatDay = whatDay;
    
    
    self.btn.selected = NO;
   
    
    
    BOOL temporary = NO;
    
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[CalendarBtn class]]) {
            
            CalendarBtn *btn = (CalendarBtn *)view;
            
            [btn setTitle:@"" forState:UIControlStateNormal];
            
            if (btn.tag >= whatDay && btn.tag + 1 - whatDay <= currentMonthLength) {
                
                [btn setTitle:[NSString stringWithFormat:@"%ld",btn.tag + 1 - whatDay] forState:UIControlStateNormal];
                
                
                if ([btn.titleLabel.text isEqualToString:[NSString stringWithFormat:@"%ld",self.selectedDay]]) {
                    
                    
                  
                    self.selectedDay = btn.tag + 1 - self.whatDay;
                    
                    btn.selected = YES;
                    self.btn = btn;
                    
                    
                    
                    temporary = YES;
                    
                    
                    
                }
                
                
            }
            
            
        }
        
    }
    
   
    
    if (temporary == NO) {
        
        
        //当前的时间
        NSDate *date = [NSDate date];
        NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
        fmt.dateFormat = @"yyyy";
        
        //现在的年份
        NSInteger years = [[fmt stringFromDate:date] integerValue];
        //现在的月份
        fmt.dateFormat = @"MM";
        NSInteger month = [[fmt stringFromDate:date] integerValue];
        
        //如果当前的年和月和选中的年和月相同的话，就默认选中当前的日期。否则默认选中1号
        if (years == self.selectedYears && month == self.selectedMonth) {
            
            
            fmt.dateFormat = @"dd";
            NSString *day = [fmt stringFromDate:date];
            self.selectedDay = [day integerValue];
            
            for (UIView *view in self.subviews) {
                
                if ([view isKindOfClass:[CalendarBtn class]]) {
                    
                    
                    CalendarBtn *btn = (CalendarBtn *)view;
                    
                    if (btn.tag >= whatDay && btn.tag + 1 - whatDay <= currentMonthLength) {
                        
                        
                        
                        if (btn.tag == self.selectedDay + self.whatDay - 1) {
                            
                            
                            btn.selected = YES;
                            self.btn = btn;
                            return;
                        }
                        
                    }
                }
            }
            
            
        }else{
            
            
            self.selectedDay = 1;
            
            for (UIView *view in self.subviews) {
                
                if ([view isKindOfClass:[CalendarBtn class]]) {
                    
                    
                    CalendarBtn *btn = (CalendarBtn *)view;
                    
                    if (btn.tag >= whatDay && btn.tag + 1 - whatDay <= currentMonthLength) {
                        
                        btn.selected = YES;
                        self.btn = btn;
                        return;
                    }
                }
            }

        
        }
        
        
            }
   
    
    

    [self selectedDate];
    
    
    
    
}





//选中了某个时间
-(void)selectedDate
{
    
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式,要注意跟下面的dateString匹配，否则日起将无效
    
    NSDate *date =[dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",self.selectedYears,self.selectedMonth,self.selectedDay]];
    
    if (self.startCalendar == YES) {//起始时间日历选中了某个时间
        
        //通知，把选中的时间告诉日历，通过标记来区分是起始时间还是结束时间
        [[NSNotificationCenter defaultCenter]postNotificationName:@"selectedTime" object:nil userInfo:@{@"selectedTime" : date,@"startCalendar" : @(YES)}];
        
    }else{//结束时间日历选中了某个时间
        
        //通知，把选中的时间告诉日历，通过标记来区分是起始时间还是结束时间
        [[NSNotificationCenter defaultCenter]postNotificationName:@"selectedTime" object:nil userInfo:@{@"selectedTime" : date,@"startCalendar" : @(NO)}];
        
    }
}
//这个月有几天
- (NSInteger)totaldaysInThisMonth:(NSDate *)date{
    
    
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    return totaldaysInMonth.length;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView *view in self.subviews) {
        
        
        if ([view isKindOfClass:[CalendarBtn class]]) {//按钮
            
            //行
            int line = 6;
            //列
            int column = 7;
            
            view.width = self.width / column;
            view.height = self.height / line;
            view.x = view.tag % column * view.width;
            view.y = view.tag / column * view.height;
            
            
        }
    }
}

@end
