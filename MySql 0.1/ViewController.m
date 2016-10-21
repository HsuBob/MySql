//
//  ViewController.m
//  MySql 0.1
//
//  Created by xbo on 16/8/3.
//  Copyright © 2016年 xbo. All rights reserved.
//

#import "ViewController.h"
#import "MySQLdb.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // show tables
    
    MySQLdb *db=[[MySQLdb alloc]init];
    [db connectHost:@"192.168.1.25" connectPort:3356 connectUser:@"test1" connectPassword:@"123" connectDbName:@"test"];
    NSMutableArray *arry=[db query:@"select * from unitygrade;"];
    
    [db update:@"delete from unitygrade where score=79;"];
    
    NSLog(@"%@",arry);
    
    
    [db disconnect];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
