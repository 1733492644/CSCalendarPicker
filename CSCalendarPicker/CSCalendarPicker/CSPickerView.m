//
//  CSPickerView.m
//  XHHospital
//
//  Created by 徐呈赛 on 16/3/10.
//  Copyright © 2016年 XuhuiCompany. All rights reserved.
//

#import "CSPickerView.h"
#import "CSCalendarPickerView.h"

@interface CSPickerView ()

//起始时间日历
@property (nonatomic,weak) CSCalendarPickerView *startView;

//结束时间日历
@property (nonatomic,weak) CSCalendarPickerView *endView;

@end


@implementation CSPickerView



-(void)awakeFromNib
{
    
    
    //起始时间日历
    CSCalendarPickerView *startView = [[CSCalendarPickerView alloc]init];
    startView.startCalendar = YES;
    //startView.backgroundColor = [UIColor redColor];
    self.startView = startView;
    [self addSubview:startView];
    
    //结束时间日历
    CSCalendarPickerView *endView = [[CSCalendarPickerView alloc]init];
    endView.startCalendar = NO;
    //endView.backgroundColor = [UIColor orangeColor];
    self.endView = endView;
    [self addSubview:endView];
    endView.hidden = YES;
    
    //通知，变化两个collectionView的Hidden属性
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeUnderlineViewX:) name:@"changeUnderlineViewX" object:nil];
    
    
    //PickerView加载完毕，通知HeaderView点击一下起始时间按钮
    [[NSNotificationCenter defaultCenter]postNotificationName:@"PickerViewLoad" object:nil];
    
}


//通知，变化两个collectionView的Hidden属性
-(void)changeUnderlineViewX:(NSNotification *)notification
{
    
    int btnTag = [notification.userInfo[@"btnTag"] intValue];
    
    if (btnTag == 0) {
        
        [self.startView setCalendarPickerHidde:NO];
        [self.endView setCalendarPickerHidde:YES];

    }else{
    
        [self.startView setCalendarPickerHidde:YES];
        [self.endView setCalendarPickerHidde:NO];

    }
    
    
    
    
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.startView.frame = self.bounds;
    self.endView.frame = self.bounds;
}


@end
