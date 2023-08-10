//
//  ViewController.m
//  LearnDemo
//
//  Created by 王雪剑 on 2020/9/23.
//  Copyright © 2020 wangxj. All rights reserved.
//

#import "ViewController.h"
#import "YYText.h"
#import "TestWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"LearnDemo";
    //[self floatString];
    
//    NSString *methodStr = @"/api1/mobile";
//    BOOL isNeedSecretApi = [self getIsNeedSecretWithHttpMethod:methodStr];
//    NSLog(@"当前接口：%@   %@",methodStr,isNeedSecretApi?@"需要加密":@"不需要加密");
      
//    NSDictionary *dic = @{
//        @"newsId":@"8d17455123e04fb29a11b651ca6b249b",
//        @"name":@"12255",
//        @"commentText":@"zkml",
//        @"parentId":@"你  好"
//    };
//    NSDictionary *dic = @{@"a":@"d",@"i":@"C",@"I":@"a",@"B":@"c"
//    };
//    NSString *sortStr = [self getSignStringWithParams:dic];
//    NSLog(@"排序后结果：%@ 长度为：%lu",sortStr,(unsigned long)sortStr.length);
//    [self enterTestController];
    
    [self createView];
 
    // NSLog(@"过滤后的车牌号未：%@",[self removeWordWithCarNo:@"[征]"]);
    
    // [self getFilePath];
}

- (void)getFilePath{
    NSArray *folderArray = @[@"static",@"uni_modules"];
    NSString *localFileName = @"";
    //NSString *originStr = @"http://easycar-h5.luoex.xin:50006/static/car_easy_select_down_ico.svg";
    NSString *originStr = @"http://easycar-h5.luoex.xin:50006/config.js";
    for (NSString *str in folderArray) {
        NSString *containStr = [NSString stringWithFormat:@"/%@/",str];//举例： @"/static/"
        if ([originStr containsString:containStr]) {
            NSRange range = [originStr rangeOfString:containStr];
            localFileName = [originStr substringFromIndex:range.location];
            break;
        }
    }
    NSString *currentIp = @"http://easycar-h5.luoex.xin:50006/";
    if(localFileName == @""  && [originStr containsString:currentIp]){
        NSRange range = [originStr rangeOfString:currentIp];
        localFileName = [originStr substringFromIndex:range.location+range.length-1];
    }
    
    NSLog(@"截取到的文件路径为：%@",localFileName);
}


-(NSString *)removeWordWithCarNo:(NSString *)carNo{
    if (!notNull(carNo)) {
        return @"";
    }
    if ([carNo hasPrefix:@"[征]"]) {
        return [carNo substringFromIndex:3];
    }else{
        return carNo;
    }
}

- (void)createView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 335, 400)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor grayColor];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    NSString *isProduction = [NSString stringWithFormat:@"是否为线上环境：%@", IS_PRODUCTION?@"是":@"否"];
    NSString *apiUrl = [NSString stringWithFormat:@"当前API_URL为：%@", API_URL];
    NSString *allStr = [NSString stringWithFormat:@"%@\n%@",isProduction,apiUrl];
    label.text = allStr;
}

- (void)enterTestController {
    TestWebViewController *vc = [[TestWebViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)floatString {
    NSString *floatStr = @"0.29982";
    //NSString *str = [NSString stringWithFormat:@"%.4f",[floatStr floatValue]];
    NSString *precentStr = [NSString stringWithFormat:@"%.2f",[floatStr doubleValue] * 100];
    NSLog(@"==%@==",precentStr);
    
    CGFloat a = 0.299982;
    NSString *precentStr2 = [NSString stringWithFormat:@"%.2f",(CGFloat)(a * 100)];
    NSLog(@"==%@==",precentStr2);
    
}

//补80
- (void)bu80Str {
    NSString *hexPlaintext = @"112233445566778899";
    if (hexPlaintext.length % 32 != 0) {
        int buCount = hexPlaintext.length % 32;
        NSMutableString *mutableStr = [NSMutableString stringWithString:hexPlaintext];
        for (int i = 0; i < 32-buCount; i=i+2) {
            if (i == 0){
                [mutableStr appendString:@"80"];
            }else{
                [mutableStr appendString:@"00"];
            }
        }
        hexPlaintext = mutableStr;
    }
    NSLog(@"%@ 长度：%ld",hexPlaintext,hexPlaintext.length);
}

//删除80
- (void)delete80Str {
    NSMutableString *str = [NSMutableString stringWithString:@"80"];
    NSLog(@"长度：%ld",str.length);
    for (NSInteger i = str.length-1; i >= 0; i = i-2) { //0-29
        NSString *subStr = [str substringWithRange:NSMakeRange(i-1, 2)];
        if ([subStr isEqualToString:@"80"]) {
            [str replaceCharactersInRange:NSMakeRange(i-1, 2) withString:@"00"];
            break;
        }
    }
    NSLog(@"%@",str);
}

- (void)s {
    NSString *num=@"\"abcd\"";
    NSError *error;
    NSData *createdData = [num dataUsingEncoding:NSUTF8StringEncoding];
    id response=[NSJSONSerialization JSONObjectWithData:createdData options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"Response= %@",response);
}

- (NSString *)getSignStringWithParams:(NSDictionary *)params {
    NSString *jsonStr = [self convertToJsonData:params];
    NSLog(@"转json字符串：%@",jsonStr);
    
    NSMutableArray *strArray = [NSMutableArray new];
    for (int i = 0; i<jsonStr.length; i++) {
        NSString *str = [jsonStr substringWithRange:NSMakeRange(i, 1)];
        [strArray addObject:str];
    }
    //NSLog(@"字符串数组：%@",strArray);
    
    NSStringCompareOptions comparisonOptions = NSLiteralSearch |
                                                       NSNumericSearch |
                                              NSWidthInsensitiveSearch |
                                                NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range = NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSArray *sortArray = [strArray sortedArrayUsingComparator:sort];
    
    NSMutableString *mutableStr = [NSMutableString new];
    for (int i = 0; i<sortArray.count; i++) {
        [mutableStr appendFormat:@"%@", sortArray[i]];
    }
    return mutableStr;
    
    
    
    /*
    //params = @{@"name":@"wxj",@"age":@"2",@"code":@"fafa",@"address":@"皖水公寓",@"file":@"单独的文件夹"};
    // 第一步：取出所有的key，放在一个数组中，然后对数组进行升序排序
    NSArray *keyArray = params.allKeys;
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch |
                                               NSNumericSearch |
                                               NSWidthInsensitiveSearch |
                                               NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range = NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSArray *sortArray = [keyArray sortedArrayUsingComparator:sort];
    NSLog(@"字符串数组排序结果%@",sortArray);
   
    // 第二步：根据升序的数组，取出key对应字典中的value，拼接在一个字符串中
    NSMutableString *mutableStr = [NSMutableString new];
    for (int i = 0; i < sortArray.count; i++) {
        NSString *keyStr = sortArray[i];
        [mutableStr appendString:[NSString stringWithFormat:@"%@",[params objectForKey:keyStr]]];
    }
    
    return mutableStr;
     */
}

-(NSString *)convertToJsonData:(NSDictionary *)dict{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingFragmentsAllowed error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
  
//    NSRange range = {0,jsonString.length};
//    //去掉字符串中的空格
//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
//    NSRange range2 = {0,mutStr.length};
//    //去掉字符串中的换行符
//    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
//    NSRange range3 = {0,mutStr.length};
//    //去掉字符串中的引号
//    [mutStr replaceOccurrencesOfString:@"\"" withString:@"" options:NSLiteralSearch range:range3];
    
    return mutStr;
}


// 判断当前接口是否需要加密处理
- (BOOL)getIsNeedSecretWithHttpMethod:(NSString *)methodString {
    NSArray *array = @[@{
                           @"keyIdentification":@"api1",
                           @"filterIncludePatterns":@"/api1/mobile/**,/api1/test/11",
                           @"filterExcludePatterns":@"/api1/mobile/1, /api1/mobile/10,/api1/mobile/test/**"
                        },
                       @{
                          @"keyIdentification":@"api2",
                          @"filterIncludePatterns":@"/api2/mobile/**, /api2/test/11",
                          @"filterExcludePatterns":@"/api2/mobile/1, /api2/mobile/10,/api2/mobile/test/**"
                       },
                       @{
                          @"keyIdentification":@"api3",
                          @"filterIncludePatterns":@"/api3/mobile/**, /api3/test/11",
                          @"filterExcludePatterns":@"/api3/mobile/1, /api3/mobile/10,/api3/mobile/test/**"
                       },
                       @{
                          @"keyIdentification":@"api4",
                          @"filterIncludePatterns":@"/**, /api4/test/11",
                          @"filterExcludePatterns":@"/api4/mobile/1, /api4/mobile/10, /api4/mobile/test/**"
                       }
    ];
    BOOL isNeedSecret = NO;
    for (NSDictionary *dic in array) {
        NSString *keyIdentificationStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"keyIdentification"]];
        if ([methodString containsString:keyIdentificationStr]) {
            NSString *filterIncludePatterns = [dic objectForKey:@"filterIncludePatterns"];
            NSString *filterExcludePatterns = [dic objectForKey:@"filterExcludePatterns"];
            isNeedSecret = [self judgeBoolWithInclude:filterIncludePatterns withEninclude:filterExcludePatterns withMethod:methodString];
            break;
        }
    }
    return isNeedSecret;
}

- (BOOL)judgeBoolWithInclude:(NSString *)includeStr withEninclude:(NSString *)enIncludeStr withMethod:(NSString *)methodString {
    BOOL isNeedSecret = NO;
    NSArray *secretApiArray = [includeStr componentsSeparatedByString:@","];
    for (int i = 0; i<secretApiArray.count; i++) {
        NSString *secretApiStr = secretApiArray[i];
        //当前含有通配符
        if ([secretApiStr hasSuffix:@"**"]) {
            secretApiStr = [secretApiStr substringWithRange:NSMakeRange(0, secretApiStr.length-3)];
            //通配符匹配成功后，还需要去非加密数组排查，才能最终确定是否需要加密
            if ([methodString hasPrefix:secretApiStr] || !notNull(secretApiStr)) {
                isNeedSecret = YES;
                isNeedSecret = [self judgeBoolWithUnInclude:enIncludeStr withMethod:methodString];
                break;
            }
        }
        //不含通配符
        else {
            //全称匹配成功的话，则不需要再去非加密数组排查
            if ([methodString isEqualToString:secretApiStr]){
                isNeedSecret = YES;
                break;
            }
        }
    }
    return isNeedSecret;
}

- (BOOL)judgeBoolWithUnInclude:(NSString *)unIncludeStr withMethod:(NSString *)methodString {
    BOOL isNeedSecret = YES;
    NSArray *unSecretApiArray = [unIncludeStr componentsSeparatedByString:@","];
    for (int i = 0; i<unSecretApiArray.count; i++) {
        NSString *unSecretApiStr = unSecretApiArray[i];
        //当前含有通配符
        if ([unSecretApiStr hasSuffix:@"**"]) {
            unSecretApiStr = [unSecretApiStr substringWithRange:NSMakeRange(0, unSecretApiStr.length-3)];
            //排除加密接口的通配符匹配成功后，则表示该接口不需要加密
            if ([methodString hasPrefix:unSecretApiStr] || !notNull(unSecretApiStr)) {
                isNeedSecret = NO;
                break;
            }
        }
        //不含通配符
        else {
            //全称匹配成功的话，则不需要再去非加密数组排查
            if ([methodString isEqualToString:unSecretApiStr]){
                isNeedSecret = NO;
                break;
            }
        }
    }
    return isNeedSecret;
}

BOOL notNull(id val) {
    if (val == nil || [val isEqual:[NSNull null]]) {
        return NO;
    }
    if ([val isKindOfClass:[NSString class]]) {
        if ([val isEqualToString:@""] || [val isEqualToString:@"null"] || [val isEqualToString:@"<null>"]||[val isEqualToString:@"(null)"]) {
            return NO;
        }
    }
    if ([val isKindOfClass:[NSArray class]]) {
        if ([val count] == 0) {
            return NO;
        }
    }
    if ([val isKindOfClass:[NSDictionary class]]) {
        if ([[val allKeys] count] == 0) {
            return NO;
        }
    }
    return YES;
}

- (void)aaa {
    NSString *formatString = @"name【birthday】";
    NSRange circleRange = [formatString rangeOfString:@"("];
    NSRange squareCircleRange = [formatString rangeOfString:@"【"];
    NSString *key1;
    NSString *key2;
    NSString *key3;
    NSRange lineRange = [formatString rangeOfString:@"/"];
    //有括号"("
    if (circleRange.length != 0) {
        key1 = [formatString substringToIndex:circleRange.location];
        //有"/"
        if (lineRange.length != 0) {
            key2 = [formatString substringWithRange:NSMakeRange(circleRange.location+circleRange.length, lineRange.location-circleRange.location-1)];
            key3 = [formatString substringWithRange:NSMakeRange(lineRange.location+lineRange.length, formatString.length-lineRange.location-2)];
        }else {
            key2 = [formatString substringWithRange:NSMakeRange(circleRange.location+circleRange.length, formatString.length-circleRange.location-2)];
        }
    }
    //有括号"【"
    else if (squareCircleRange.length != 0) {
        key1 = [formatString substringToIndex:squareCircleRange.location];
        //有"/"
        if (lineRange.length != 0) {
            key2 = [formatString substringWithRange:NSMakeRange(squareCircleRange.location+squareCircleRange.length, lineRange.location-squareCircleRange.location-1)];
            key3 = [formatString substringWithRange:NSMakeRange(lineRange.location+lineRange.length, formatString.length-lineRange.location-2)];
        }else {
            key2 = [formatString substringWithRange:NSMakeRange(squareCircleRange.location+squareCircleRange.length, formatString.length-squareCircleRange.location-2)];
        }
    }
    //无括号
    else {
        key1 = formatString;
    }
    
    
    NSLog(@"\n key1：%@\n key2：%@\n key3：%@\n",key1,key2,key3);
}

- (void)sss {
    NSArray *array = @[@"张三(商务部部长 18855582584)",@"李四(安徽中科美络信息技术有限公司 18842324322)",@"王五(中科大先进技术研究院院长 19933442222)"];
    CGFloat labelHeight = 0;
    for (int i = 0; i<array.count; i++) {
        YYLabel *label = [[YYLabel alloc] initWithFrame:CGRectMake(0, labelHeight+60, 375, 0)];
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 0;
        if (i == 0) {
            label.backgroundColor = [UIColor cyanColor];
        }else if (i == 1) {
            label.backgroundColor = [UIColor purpleColor];
        }else if (i == 2) {
            label.backgroundColor = [UIColor blueColor];
        }
        [self.view addSubview:label];
        
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:array[i]];
        UIImage *image = [UIImage imageNamed:@"car_easy_list_icon_dh_normal"];
        NSMutableAttributedString *attachment = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeScaleToFill attachmentSize:CGSizeMake(14, 14) alignToFont:[UIFont systemFontOfSize:14] alignment:YYTextVerticalAlignmentCenter];
        [attachment insertAttributedString:text atIndex:0];
        label.attributedText = attachment;
        CGSize size = [YYTextLayout layoutWithContainerSize:CGSizeMake(375, CGFLOAT_MAX) text:attachment].textBoundingSize;
        NSLog(@"%lf",size.height);
        label.frame = CGRectMake(0, labelHeight+60, 375, size.height+5);
        labelHeight  += label.frame.size.height;
    }
    
    NSLog(@"%lf",labelHeight);
//    NSString *string = @"123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843 123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843948123141412423412342341241234413431843";
////    label.text = string;
////    CGFloat labelMaxHeight = stringSize(label.text, 14, 375).height;
////    label.frame = CGRectMake(0, 60, 375, labelMaxHeight);
//
//    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
//    UIImage *image = [UIImage imageNamed:@"car_easy_list_icon_dh_normal"];
//    NSMutableAttributedString *attachment = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeScaleToFill attachmentSize:CGSizeMake(14, 14) alignToFont:[UIFont systemFontOfSize:14] alignment:YYTextVerticalAlignmentCenter];
//    [attachment insertAttributedString:text atIndex:0];
//    label.attributedText = attachment;
//    CGSize size = [YYTextLayout layoutWithContainerSize:CGSizeMake(375, CGFLOAT_MAX) text:attachment].textBoundingSize;
//    NSLog(@"%lf",size.height);
//    label.frame = CGRectMake(0, 60, 375, size.height+5);
    
}


CGSize stringSize(NSString *str,CGFloat font,CGFloat maxWidth){
    //kSelfWidth-kSize(48+44+16+48)
    CGSize content;
    
 
        content = [str boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                    options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]}
                                    context:nil].size;
        return content;
 
}

@end
