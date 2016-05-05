# CSCalendarPicker
选择起始时间和结束时间的日历

![image](https://raw.githubusercontent.com/1733492644/CSCalendarPicker/master/Untitled.gif)
# 使用说明
    #import "CSCalendarPicker.h"
    @interface ViewController ()<CSCalendarPickerDelegate>
    @property (nonatomic,strong) CSCalendarPicker *calendarPicker;
    @end

    @implementation ViewController

    - (void)viewDidLoad {
    [super viewDidLoad];
    
    _calendarPicker = [CSCalendarPicker calendarPicker];
    _calendarPicker.delegate = self;
    //设置主题颜色
    _calendarPicker.color = [UIColor orangeColor];
    }

    - (IBAction)appearBtnClick:(UIButton *)sender {
      //显示日历
      [self.calendarPicker show];
    }
    //代理方法
    -(void)calendarPicker:(CSCalendarPicker *)calendarPicker didSelectStartingDate:(NSDate *)startingDate endDate:(NSDate *)endDate
    {
       NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
       fmt.dateFormat = @"yyyy-MM-dd";
    
       //开始时间
       NSString *startTime = [fmt stringFromDate:startingDate];
       //结束时间
       NSString *endTime = [fmt stringFromDate:endDate];
    }
