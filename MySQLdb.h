//
//  MySQLdb.h
//  MySql 0.1
//
//  Created by xbo on 16/8/3.
//  Copyright © 2016年 xbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mysql.h"
@interface MySQLdb : NSObject

{
    MYSQL *myconnect;
}
// 连接mysql
-(void)connectHost:(NSString *)host connectPort:(NSInteger)port connectUser:(NSString *)user connectPassword:(NSString *)password connectDbName:(NSString *)name;
// 关闭连接
-(void)disconnect;

//查看数据库的数据
-(NSMutableArray*)query:(NSString *)sql;

//修改数据库中的数据（无返回值）。删除、增加数据都可以调用此方法。
-(void)update:(NSString *)sql;

@end
