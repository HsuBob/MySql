//
//  MySQLdb.m
//  MySql 0.1
//
//  Created by xbo on 16/8/3.
//  Copyright © 2016年 xbo. All rights reserved.
//

#import "MySQLdb.h"

@implementation MySQLdb
-(id)init
{
    self=[super init];
    return self;
}

-(void)connectHost:(NSString *)host connectPort:(NSInteger)port connectUser:(NSString *)user connectPassword:(NSString *)password connectDbName:(NSString *)name
{
    myconnect = mysql_init(myconnect);
    myconnect = mysql_real_connect(myconnect,[host UTF8String],[user UTF8String],[password UTF8String],[name UTF8String],(int)port,NULL,0);
    if(!myconnect)
    {
        printf("error code=%i",mysql_errno(myconnect));
        return;
    }
    if (!mysql_set_character_set(myconnect, "utf8"))
    {
        printf("New client character set: %s\n", mysql_character_set_name(myconnect));
    }
    
    NSLog(@"connected to Mysql");
}

//查询数据库中数据，参数sql既为SQL查询语句（@"select name from table1"），返回SQL语句查询到的结果，我理解的是recordArr中存放的是每组数据（每个column）中查询到的结果，而recordsArray中存放的是recordArr,即有几个column就有几个recorder。
-(NSMutableArray*)query:(NSString *)sql
{
    if(!myconnect)
    {
        NSLog(@"Please connect first");
        return nil;
    }
    NSMutableArray *recordsArray = [[NSMutableArray alloc] init] ;
    
    mysql_query(myconnect, [sql UTF8String]);
    MYSQL_RES* result = mysql_store_result(myconnect);
    int num_rows = (int)mysql_num_rows(result);
    int num_fields = mysql_num_fields(result);
    
    for(int i=0;i<num_rows;i++)
    {
        MYSQL_ROW row = mysql_fetch_row(result);
        NSMutableArray *recordArr = [[NSMutableArray alloc] init];
        
        for(int j=0;j<num_fields;j++)
        {
            //最新修改，解决中文乱码问题
            //中文简体编码：CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingDOSChineseSimplif)
            //NSString* value= [NSString stringWithUTF8String:row[j]];
            NSString* value= [ NSString stringWithFormat:@"%@",[[NSString alloc] initWithCString:row[j] encoding:NSUTF8StringEncoding] ];
            [recordArr addObject:value];
        }
        
        [recordsArray addObject:recordArr];
           }
    return recordsArray;
}
-(void)disconnect
{
    mysql_close(myconnect);
    NSLog(@"Close From Mysql");
}


//修改数据库中的数据（无返回值）。删除、增加数据都可以调用此方法。
-(void)update:(NSString *)sql
{
    if(myconnect)
    {
        mysql_query(myconnect, [sql UTF8String]);
        NSLog(@"Update successed to DB first");
    }
    else
    {
        NSLog(@"Please connect to DB first");
        return;
    }
}

//-(int)query:(NSString *)sql
//{
//    return mysql_query(myconnect, [sql UTF8String]);
//}
//
//-(MYSQL_RES *)store_result
//{
//    return mysql_store_result(myconnect);
//}
//
//-(NSMutableArray *)fetchRow:(MYSQL_RES *)result
//{
//    MYSQL_ROW row;
//    NSMutableArray *rowArray = [[NSMutableArray alloc] init];
//    int fieldCount = mysql_field_count(myconnect);
//    if(row = mysql_fetch_row(result))
//    {
//        for(int i = 0; i < fieldCount; i++)
//        {
//            /*
//             NSString *tmpStr = [[NSString alloc] initWithUTF8String:row[i]];
//             [rowArray addObject:tmpStr];
//             [tmpStr autorelease];
//             */
//            [rowArray addObject:[NSString stringWithUTF8String:row[i]]];
//        }
//    }
//    row = NULL;
//    
//    return rowArray;
//}
//
//-(NSMutableArray *)fetchAllRows:(MYSQL_RES *)result
//{
//    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
//    int rowCount = mysql_num_rows(result);
//    for(int i = 0; i < rowCount; i++)
//    {
//        //printf("%d\n",i);
//        [resultArray addObject:[self fetchRow:result]];
//    }
//    
//    return resultArray;
//}
@end
