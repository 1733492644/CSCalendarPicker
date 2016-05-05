//
//  InChoosing.m
//  XHHospital
//
//  Created by 徐呈赛 on 16/3/11.
//  Copyright © 2016年 XuhuiCompany. All rights reserved.
//

#import "InChoosing.h"
#import "NSDate+Extension.h"
#import "UIView+Extension.h"

@interface InChoosing ()

//中间的显示年份和月份的Label
@property (nonatomic,weak) UILabel *inLabel;

//左边的上个月按钮
@property (nonatomic,weak) UIButton *lastMonthBtn;

//右边的下个月按钮
@property (nonatomic,weak) UIButton *nextMonthBtn;


//当前选择的年份
@property (nonatomic,assign) int years;

//当前选择的月份
@property (nonatomic,assign) int month;

@end


@implementation InChoosing


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor alloc]initWithRed:0 / 255.0 green:188 / 255.0 blue:212 / 255.0 alpha:1.0];
        
        UILabel *inLabel = [[UILabel alloc]init];
        inLabel.textColor = [UIColor whiteColor];
        inLabel.textAlignment=NSTextAlignmentCenter;
        inLabel.font = [UIFont systemFontOfSize:18];
        self.inLabel = inLabel;
        [self addSubview:inLabel];
        //当前的时间
        NSDate *date = [NSDate date];
        //日期转换类
        NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
        //设置日期的格式（声明字符串里面每个数字和单词的含义）
        fmt.dateFormat = @"yyyy";
        
        self.years = [[fmt stringFromDate:date] intValue];
        
        fmt.dateFormat = @"MM";
        self.month = [[fmt stringFromDate:date] intValue];
        
        inLabel.text = [NSString stringWithFormat:@"%.2d-%d",self.month,self.years];
        

        [self calendarRefresh];
        
        
        
        UIButton *lastMonthBtn = [[UIButton alloc]init];
        [lastMonthBtn setTitle:@"上月" forState:UIControlStateNormal];
        lastMonthBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [lastMonthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        lastMonthBtn.tag = 0;
        [lastMonthBtn addTarget:self action:@selector(MonthBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.lastMonthBtn = lastMonthBtn;
        [self addSubview:lastMonthBtn];
        
        UIButton *nextMonthBtn = [[UIButton alloc]init];
        [nextMonthBtn setTitle:@"下月" forState:UIControlStateNormal];
        nextMonthBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [nextMonthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        nextMonthBtn.tag = 1;
        [nextMonthBtn addTarget:self action:@selector(MonthBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.nextMonthBtn = nextMonthBtn;
        [self addSubview:nextMonthBtn];
        
        
      
        
        
        
       
        
    }
    
    return self;
}


//通知修改主题颜色
-(void)ThemeColor:(NSNotification *)notification
{
    self.backgroundColor = notification.userInfo[@"color"];
}


-(void)setInChoosingNotificaion:(BOOL)determine
{
    if (determine == YES) {
        
        //通知,年份改变
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(yearsChange:) name:@"yearsChange" object:nil];
        
        //通知InChossing 点击下个月按钮
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(FlipEffect:) name:@"FlipEffect" object:nil];
        
    }else{
        
        [[NSNotificationCenter defaultCenter]removeObserver:self];
        
    
    }
    
    
    //通知修改主题颜色
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ThemeColor:) name:@"ThemeColor" object:nil];
}
//通知,年份改变
-(void)yearsChange:(NSNotification *)notification
{
    NSString *years = notification.userInfo[@"years"];
    years = [years stringByReplacingOccurrencesOfString:@"年" withString:@""];
    
    self.years = [years intValue];
    
    //当前的时间
    NSDate *date = [NSDate date];
    //日期转换类
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    //设置日期的格式（声明字符串里面每个数字和单词的含义）
    fmt.dateFormat = @"yyyy";
    
    
  
    if ([[fmt stringFromDate:date] isEqualToString:years]) {
        
      
        fmt.dateFormat = @"MM";
        
        self.month = [[fmt stringFromDate:date] intValue];
        
    }else{
    
        self.month = 6;
    }
    
    
    self.inLabel.text = [NSString stringWithFormat:@"%.2d-%d",self.month,self.years];
    [self calendarRefresh];
}


//通知InChossing 点击下个月按钮
-(void)FlipEffect:(NSNotification *)notification
{
    if ([notification.userInfo[@"state"] boolValue] == YES) {
        
        [self MonthBtnClick:self.nextMonthBtn];
    }else{
        [self MonthBtnClick:self.lastMonthBtn];
    
    }
}
//上个月和下个月按钮被点击
-(void)MonthBtnClick:(UIButton *)btn
{
 
    if (btn.tag == 0) {//上个月
        
        if (self.month == 1) {
            self.month = 12;
            self.years--;
            //通知，改变年份
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeYearsValue" object:nil userInfo:@{@"state" : @"0"}];
        }else{
        
            self.month--;
        }
        
        
        //通知日历出现翻页效果,YES代表上一页，NO代表下一页
        [[NSNotificationCenter defaultCenter]postNotificationName:@"EffectOfBooks" object:nil userInfo:@{@"state" : @(YES)}];
        
    }else{//下个月
    
        if (self.month == 12) {
            self.month = 1;
            self.years++;
            //通知，改变年份
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeYearsValue" object:nil userInfo:@{@"state" : @"1"}];
        }else{
        
            self.month++;
        }
        
        //通知日历出现翻页效果,YES代表上一页，NO代表下一页
        [[NSNotificationCenter defaultCenter]postNotificationName:@"EffectOfBooks" object:nil userInfo:@{@"state" : @(NO)}];
    }
    
    
    
    self.inLabel.text = [NSString stringWithFormat:@"%.2d-%d",self.month,self.years];
    [self calendarRefresh];
    
}


//刷新日历
-(void)calendarRefresh
{
   
   
    //通知，刷新日历
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshTheCalendar" object:nil userInfo:@{@"years" : @(self.years),@"month" : @(self.month)}];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    self.lastMonthBtn.width = 50;
    self.lastMonthBtn.height = 20;
    self.lastMonthBtn.y = (self.height - self.lastMonthBtn.height) * 0.5;
    self.lastMonthBtn.x = 10;
    
    self.nextMonthBtn.width = self.lastMonthBtn.width;
    self.nextMonthBtn.height = self.lastMonthBtn.height;
    self.nextMonthBtn.y = self.lastMonthBtn.x;
    self.nextMonthBtn.x = self.width - self.nextMonthBtn.width - 10;
    
    
    self.inLabel.width = self.nextMonthBtn.x - CGRectGetMaxX(self.lastMonthBtn.frame);
    self.inLabel.height = self.height;
    self.inLabel.y = 0;
    self.inLabel.x = CGRectGetMaxX(self.lastMonthBtn.frame);
    
    
}

@end
