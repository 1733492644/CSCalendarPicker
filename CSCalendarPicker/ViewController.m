//
//  ViewController.m
//  CSCalendarPicker
//
//  Created by 徐呈赛 on 16/5/5.
//  Copyright © 2016年 XuChengSai. All rights reserved.
//

#import "ViewController.h"
#import "CSCalendarPicker.h"

@interface ViewController ()<CSCalendarPickerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *startTime;
@property (weak, nonatomic) IBOutlet UITextField *endTime;

@property (nonatomic,strong) CSCalendarPicker *calendarPicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _calendarPicker = [CSCalendarPicker calendarPicker];
    _calendarPicker.delegate = self;
    
    
    
}

- (IBAction)appearBtnClick:(UIButton *)sender {
    
    [self.calendarPicker show];
}

-(void)calendarPicker:(CSCalendarPicker *)calendarPicker didSelectStartingDate:(NSDate *)startingDate endDate:(NSDate *)endDate
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    //开始时间
    self.startTime.text = [fmt stringFromDate:startingDate];
    //结束时间
    self.endTime.text = [fmt stringFromDate:endDate];
}
@end
