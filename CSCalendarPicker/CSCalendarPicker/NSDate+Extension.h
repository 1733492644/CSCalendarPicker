

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear;
/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday;

/**
 字符串时间转换为date
 
 title           :需要转换成时间的字符串
 dateFormat      :时间格式,比如   @"yyyy-MM-dd"
 locale          :这个是哪里的时间，比如@"en_US" 是欧美的时间
 */
+(NSDate *)dateWithTitle:(NSString *)title dateFormat:(NSString *)dateFormat locale:(NSString *)locale;

/**
 把date转换为想要的格式，返回date
 dateFormat :时间格式,比如 @"yyyy-MM-dd"
 */
-(NSDate *)dateWithDateFormat:(NSString *)dateFormat;
/**
 把date转换为想要的格式，返回NSString
 dateFormat :时间格式,比如 @"yyyy-MM-dd"
 */
-(NSString *)stringWithDateFormat:(NSString *)dateFormat;


//上个月
- (NSDate *)lastMonth;

//下个月
- (NSDate*)nextMonth;

//这个月有几天
- (NSInteger)totaldaysInThisMonth;

//这个月的第一天是周几
- (NSInteger)firstWeekdayInThisMonth;
@end
