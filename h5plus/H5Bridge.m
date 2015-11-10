//
//  H5Bridge.m
//  h5plus
//
//  Created by zhugan on 15/11/10.
//  Copyright © 2015年 zhugan. All rights reserved.
//

#import "H5Bridge.h"


@implementation H5Bridge

-(void)back{
    NSLog(@"back call.");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notfiy_of_back" object:nil];
}

-(void)somethingelse:(NSString*)arg1 arg2:(NSString*)arg2{
    NSLog(@"somethingelse call with %@,%@.",arg1,arg2);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notfiy_of_somethingelse" object:@{@"arg1":arg1,@"arg2":arg2}];
    
}
@end
