//
//  ViewController.m
//  Shopping
//
//  Created by River on 21/12/2016.
//  Copyright © 2016 River. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userInfo = [[user dictionaryForKey:@"userInfo"] mutableCopy];
//    NSMutableArray *goodsList=[[user arrayForKey:@"goodsList"] mutableCopy];
    if (userInfo == nil){
        userInfo = [NSMutableDictionary dictionaryWithObjects:@[@"admin",@"123456"] forKeys:@[@"userName",@"userPassword"]];
        [user setObject:userInfo forKey:@"userInfo"];
        [user synchronize];
    }
}

@end
