//
//  CSHeaderView.m
//  XHHospital
//
//  Created by 徐呈赛 on 16/3/10.
//  Copyright © 2016年 XuhuiCompany. All rights reserved.
//

#import "CSHeaderView.h"
#import "UnderlineView.h"
#import "UIView+Extension.h"

@interface CSHeaderView ()

//起始时间下面的那条横线
@property (nonatomic,weak) UnderlineView *underlineView;

//起始时间按钮
@property (nonatomic,weak) UIButton *startBtn;
//结束时间按钮
@property (nonatomic,weak) UIButton *endBtn;


@end

@implementation CSHeaderView

-(void)awakeFromNib
{
    
    //起始时间按钮
    UIButton *startBtn = [[UIButton alloc]init];
    startBtn.tag = 0;
    [startBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [startBtn setTitle:@"起始时间" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.startBtn = startBtn;
    [self addSubview:startBtn];
    
    
    //结束时间按钮
    UIButton *endBtn = [[UIButton alloc]init];
    endBtn.tag = 1;
    [endBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [endBtn setTitle:@"结束时间" forState:UIControlStateNormal];
    [endBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.endBtn = endBtn;
    [self addSubview:endBtn];
    
    
    UnderlineView *underlineView = [[UnderlineView alloc]init];
    self.underlineView = underlineView;
    underlineView.backgroundColor = [[UIColor alloc]initWithRed:0 / 255.0 green:188 / 255.0 blue:212 / 255.0 alpha:1];
    [self addSubview:underlineView];
    
    
    //PickerView加载完毕，点击一下起始时间按钮
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PickerViewLoad) name:@"PickerViewLoad" object:nil];
    
    
    //通知修改主题颜色
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ThemeColor:) name:@"ThemeColor" object:nil];

    
    
}

//通知修改主题颜色
-(void)ThemeColor:(NSNotification *)notification
{
    self.underlineView.backgroundColor = notification.userInfo[@"color"];
}



//PickerView加载完毕
-(void)PickerViewLoad
{
    
    
    //通知两个日历变化hidden
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeUnderlineViewX" object:nil userInfo:@{@"btnTag" : [NSString stringWithFormat:@"%d",0]}];
    
    
}


//按钮被点击
-(void)btnClick:(UIButton *)btn
{
   
    
    //通知两个日历变化hidden
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeUnderlineViewX" object:nil userInfo:@{@"btnTag" : [NSString stringWithFormat:@"%ld",(long)btn.tag]}];
    
    
 
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        if (btn.tag == 0) {//左移
            if (self.underlineView.x == 5) return;
            
            self.underlineView.x = 5;
            
        }else{//右移
            
            if (self.underlineView.x == self.width * 0.5)return;
            
            self.underlineView.x = self.width * 0.5;
            
        }
        
        
    }];
    
    
    
    
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //起始时间按钮
    self.startBtn.x = 0;
    self.startBtn.y = 0;
    self.startBtn.height = self.height;
    self.startBtn.width = self.width * 0.5;
    
    
    //结束时间按钮
    self.endBtn.x = self.startBtn.width;
    self.endBtn.y = 0;
    self.endBtn.width = self.startBtn.width;
    self.endBtn.height = self.startBtn.height;
    
    
    
    
    //self.underlineView.x = 5;
    self.underlineView.height = 5;
    self.underlineView.width = self.width * 0.5 - 5;
    self.underlineView.y = self.height - self.underlineView.height;
}

    


    
    
    

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
