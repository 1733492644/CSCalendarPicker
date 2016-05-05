

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 获得某个时间的年月日时分秒
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return dateCmps.year == nowCmps.year;
}

/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday
{
    NSDate *now = [NSDate date];
    
    // date ==  2014-04-30 10:05:28 --> 2014-04-30 00:00:00
    // now == 2014-05-01 09:22:10 --> 2014-05-01 00:00:00
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 2014-04-30
    NSString *dateStr = [fmt stringFromDate:self];
    // 2014-10-18
    NSString *nowStr = [fmt stringFromDate:now];
    
    // 2014-10-30 00:00:00
    NSDate *date = [fmt dateFromString:dateStr];
    // 2014-10-18 00:00:00
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}

/**
 字符串时间转换为date
 title           :需要转换成时间的字符串
 dateFormat      :时间格式,比如   @"yyyy-MM-dd"
 locale          :这个是哪里的时间，比如@"en_US" 是欧美的时间
 */

+(NSDate *)dateWithTitle:(NSString *)title dateFormat:(NSString *)dateFormat locale:(NSString *)locale
{
    //日期转换类
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    //如果是真机运行的话，转换这种欧美的时间，需要设置locale，告诉它这种格式是哪里的时间
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:locale];
    
    //设置日期的格式（声明字符串里面每个数字和单词的含义）
    fmt.dateFormat = dateFormat;
    //转换为时间对象
    NSDate *createDate = [fmt dateFromString:title];
    return createDate;
}


/**
 把date转换为想要的格式，返回date
 dateFormat :时间格式,比如 @"yyyy-MM-dd"
 */
-(NSDate *)dateWithDateFormat:(NSString *)dateFormat
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = dateFormat;
    NSString *strDate = [fmt stringFromDate:self];
    
    return [fmt dateFromString:strDate];
}
/**
 把date转换为想要的格式，返回NSString
 dateFormat :时间格式,比如 @"yyyy-MM-dd"
 */
-(NSString *)stringWithDateFormat:(NSString *)dateFormat
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = dateFormat;
    
    return  [fmt stringFromDate:self];
    
    
    
}

//上个月
- (NSDate *)lastMonth
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

//下个月
- (NSDate*)nextMonth
{
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

//这个月有几天
- (NSInteger)totaldaysInThisMonth
{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return totaldaysInMonth.length;
}

//这个月第一天是周几
- (NSInteger)firstWeekdayInThisMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

@end
