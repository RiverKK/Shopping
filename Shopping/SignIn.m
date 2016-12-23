//
//  SignIn.m
//  Shopping
//
//  Created by River on 21/12/2016.
//  Copyright © 2016 River. All rights reserved.
//

#import "SignIn.h"
#import "GoodsList.h"
#import "ViewController.h"

@interface SignIn ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;
- (IBAction)signIn:(id)sender;

@end

@implementation SignIn

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signIn:(id)sender {
//    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
//    NSMutableDictionary *userInfo = [[user dictionaryForKey:@"userInfo"] mutableCopy];
////    NSLog(@"%@", [userInfo objectForKey:@"userName"]);
////    NSLog(@"%@", [userInfo objectForKey:@"userPassword"]);
//    
//    if ([[userInfo objectForKey:@"userName"]isEqualToString:self.userName.text] && [[userInfo objectForKey:@"userPassword"]isEqualToString:self.userPassword.text]) {
//        [self performSegueWithIdentifier:@"sign in successfully" sender:self];
//    }
//    else{
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"用户名或密码错误。" preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
//        [alertController addAction:cancelAction];
//        
//        [self presentViewController:alertController animated:YES completion:nil];
//    }
    [self performSegueWithIdentifier:@"sign in successfully" sender:self];
}
@end
