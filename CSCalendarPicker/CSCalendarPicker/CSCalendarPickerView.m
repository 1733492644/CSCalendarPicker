//
//  CSCalendarPickerView.m
//  XHHospital
//
//  Created by 徐呈赛 on 16/3/10.
//  Copyright © 2016年 XuhuiCompany. All rights reserved.
//

#import "CSCalendarPickerView.h"
#import "UIView+Extension.h"
#import "yearsChooseCell.h"
#import "CSCollectionLayout.h"
#import "InChoosing.h"
#import "dateOfView.h"
#import "SpecificDate.h"

@interface CSCalendarPickerView ()<UICollectionViewDataSource,UICollectionViewDelegate>

//上面的年份选择器
@property (nonatomic,weak) UICollectionView *yearsChonnse;
//存放上面年份选择器数据的数组
@property (nonatomic,strong) NSMutableArray *yearsArray;

//中间的月份选择View
@property (nonatomic,weak) InChoosing *inChossingView;

//月份选择View下面的日期View
@property (nonatomic,weak) dateOfView *dateofView;

//日期View下面的具体日历View
@property (nonatomic,weak) SpecificDate *specificDate;


@property (nonatomic,assign) BOOL temporary;



@end

@implementation CSCalendarPickerView


-(NSMutableArray *)yearsArray
{
    if (_yearsArray == nil) {
        _yearsArray = [[NSMutableArray alloc]init];
        
        for (int i = 1900; i < 2100; i ++) {
            
            [_yearsArray addObject:[NSString stringWithFormat:@"%d年",i]];
        }
        
    }
    return _yearsArray;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        CSCollectionLayout *flowLayout = [[CSCollectionLayout alloc]init];
        
        //添加左边的年份选择器
        UICollectionView *yearsChoose = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
        yearsChoose.backgroundColor = [UIColor whiteColor];
        self.yearsChonnse = yearsChoose;
        [self addSubview:yearsChoose];
        yearsChoose.showsHorizontalScrollIndicator = NO;
        //去除垂直方向的滚动条
        yearsChoose.showsVerticalScrollIndicator = NO;
        yearsChoose.delegate = self;
        yearsChoose.dataSource = self;
        
        //用init注册一个可循环引用的cell
        [yearsChoose registerClass:[yearsChooseCell class] forCellWithReuseIdentifier:@"yearsChooseCell"];
        
        
        //月份选择View下面的日期View
        dateOfView *dataofView = [[dateOfView alloc]init];
        self.dateofView = dataofView;
        [self addSubview:dataofView];
        
        
        //日期Viw下面的具体日期View
        SpecificDate *specificDate = [[SpecificDate alloc]init];
        specificDate.startCalendar = self.startCalendar;
        self.specificDate = specificDate;
        [self addSubview:specificDate];
        
        
        //添加中间的月份选择View
        InChoosing *inChossingView = [[InChoosing alloc]init];
        //inChossingView.backgroundColor = [UIColor orangeColor];
        self.inChossingView = inChossingView;
        [self addSubview:inChossingView];
        
        
        
        //添加轻扫手势
        //左和上 轻扫
        UISwipeGestureRecognizer *LeftGest = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(onGest)];
        LeftGest.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:LeftGest];
        
        UISwipeGestureRecognizer *UpGest = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(onGest)];
        UpGest.direction = UISwipeGestureRecognizerDirectionUp;
        [self addGestureRecognizer:UpGest];
        
        
        
        //右和下 轻扫
        UISwipeGestureRecognizer *RightGest = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(underGest)];
        RightGest.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:RightGest];
        
        UISwipeGestureRecognizer *DownGest = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(underGest)];
        DownGest.direction = UISwipeGestureRecognizerDirectionDown;
        [self addGestureRecognizer:DownGest];
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        
        
        
        
        

    }
  
    
    return self;
}





//左和上 轻扫
-(void)onGest
{
    //通知InChossing 点击下个月按钮 , YES代表下一页，NO代表上一页
    [[NSNotificationCenter defaultCenter]postNotificationName:@"FlipEffect" object:nil userInfo:@{@"state" : @(YES)}];
}

//右和上 轻扫
-(void)underGest
{
    //通知InChossing 点击下个月按钮 , YES代表下一页，NO代表上一页
    [[NSNotificationCenter defaultCenter]postNotificationName:@"FlipEffect" object:nil userInfo:@{@"state" : @(NO)}];
}

//改变自身的hidde值，并且通过hidde来决定是否接收通知
-(void)setCalendarPickerHidde:(BOOL)hidde
{
    if (hidde == NO) {
        
        self.hidden = NO;
        //通知，改变年份
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeYearsValue:) name:@"changeYearsValue" object:nil];
        
        
        //通知日历出现翻页效果,YES代表上一页，NO代表下一页
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(EffectOfBooks:) name:@"EffectOfBooks" object:nil];
        
       
    }else{
        
        self.hidden = YES;
    
        [[NSNotificationCenter defaultCenter]removeObserver:self];
        
    }
    
    //通过自身的hidde值来决定控件是否要接收通知
    [self.inChossingView setInChoosingNotificaion:!hidde];
    [self.specificDate setSpecificDateNotificaion:!hidde];
    
}


//通知日历出现翻页效果,YES代表上一页，NO代表下一页
-(void)EffectOfBooks:(NSNotification *)notification
{
    BOOL state = [notification.userInfo[@"state"] boolValue];
    
    if (state == YES) {//上一页
        
        [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^(void) {
            
        } completion:nil];
        
        
    }else{//下一页
    
        [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^(void) {
            
            
        } completion:nil];
    
    }
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
 
    if (collectionView == self.yearsChonnse) {
        
        if (self.temporary == NO) {
            
            //设置默认的年份
            [self setDefaultYears];
            self.temporary = YES;
        }
     
        return self.yearsArray.count;
        
    }
    
    
    return 0;
    
}

//设置默认的年份
-(void)setDefaultYears
{
    //当前的时间
    NSDate *date = [NSDate date];
    //日期转换类
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    //设置日期的格式（声明字符串里面每个数字和单词的含义）
    fmt.dateFormat = @"yyyy";
    //转换为字符串
    NSString *dateString = [fmt stringFromDate:date];
    dateString = [NSString stringWithFormat:@"%@年",dateString];
  
    
    
    //遍历数组，找出当前年份所在数组里对应的Index
    for (int i = 0; i < self.yearsArray.count; i++) {
        
        if ([dateString isEqualToString:self.yearsArray[i]]) {
          
           
            
            CGFloat aaa = (self.yearsChonnse.frame.size.width - self.yearsChonnse.width / 3) * 0.5;
            

                [self.yearsChonnse setContentOffset:CGPointMake(self.yearsChonnse.width / 3 * (i - 1) + aaa, 0)];
          
            
            
           
            
        }
    }
    
    
    
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.yearsChonnse) {
        
        yearsChooseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"yearsChooseCell" forIndexPath:indexPath];
        cell.date = self.yearsArray[indexPath.item];
        return cell;
    }
    
    
    return nil;
}






//拖拽结束调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat cellW = scrollView.frame.size.width / 3;
    int index = (scrollView.contentOffset.x + cellW * 0.5 ) / cellW;
    
    
    if (index > self.yearsArray.count - 1) return;
    
    
    CGFloat aaa = (self.yearsChonnse.frame.size.width - self.yearsChonnse.width / 3) * 0.5;
    
    //[UIView animateWithDuration:0.5 animations:^{
        
        [self.yearsChonnse setContentOffset:CGPointMake(self.yearsChonnse.width / 3 * (index - 1) + aaa, 0)];
    //}];
    
    
    //通知，月份选择器,改变年份和月份
    [[NSNotificationCenter defaultCenter]postNotificationName:@"yearsChange" object:nil userInfo:@{@"years" : self.yearsArray[index]}];
    
    
    
}


//cell被点击
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    
    CGFloat aaa = (self.yearsChonnse.frame.size.width - self.yearsChonnse.width / 3) * 0.5;
    
    
    
    
    
   
    
    
    
        
        [self.yearsChonnse setContentOffset:CGPointMake(self.yearsChonnse.width / 3 * (indexPath.item - 1) + aaa, 0)];
    

    

        
        [self scrollViewDidEndDecelerating:self.yearsChonnse];

    
}

//通知，改变年份
-(void)changeYearsValue:(NSNotification *)notification
{
    
    
    
    if ([notification.userInfo[@"state"] isEqualToString:@"0"]) {
        

            
            [self.yearsChonnse setContentOffset:CGPointMake(self.yearsChonnse.contentOffset.x - self.yearsChonnse.width / 3, 0)];
            

        
        
    }else{
    

            
            [self.yearsChonnse setContentOffset:CGPointMake(self.yearsChonnse.contentOffset.x + self.yearsChonnse.width / 3, 0)];
            

        
    }
}


-(void)setStartCalendar:(BOOL)startCalendar
{
    _startCalendar = startCalendar;
    
    self.specificDate.startCalendar = startCalendar;
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    self.yearsChonnse.x = 5;
    self.yearsChonnse.width = self.width - self.yearsChonnse.x * 2;
    self.yearsChonnse.height = 30;
    self.yearsChonnse.y = 5;
    
    
    
    self.inChossingView.x = 0;
    self.inChossingView.width = self.width;
    self.inChossingView.y = CGRectGetMaxY(self.yearsChonnse.frame) + 5;
    self.inChossingView.height = 40;
    
    
    self.dateofView.height = 30;
    self.dateofView.width = self.width;
    self.dateofView.y = CGRectGetMaxY(self.inChossingView.frame);
    self.dateofView.x = 0;
    
    
    self.specificDate.width = self.width;
    self.specificDate.x = 0;
    self.specificDate.y = CGRectGetMaxY(self.dateofView.frame);
    self.specificDate.height = self.height - self.specificDate.y - 5;
    
    
}
@end
