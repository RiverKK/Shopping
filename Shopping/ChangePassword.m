//
//  ChangePassword.m
//  Shopping
//
//  Created by 卢享 on 23/12/2016.
//  Copyright © 2016 LX. All rights reserved.
//

#import "ChangePassword.h"

@interface ChangePassword ()
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;
@property (weak, nonatomic) IBOutlet UITextField *theNewPassword;
@property (weak, nonatomic) IBOutlet UITextField *theNewPasswordConfirm;
- (IBAction)confirm:(id)sender;

@end

@implementation ChangePassword

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)confirm:(id)sender {
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userInfo = [[user dictionaryForKey:@"userInfo"] mutableCopy];
    //    NSLog(@"%@", [userInfo objectForKey:@"userName"]);
    //    NSLog(@"%@", [userInfo objectForKey:@"userPassword"]);
    
    if (![[userInfo objectForKey:@"userPassword"]isEqualToString:self.oldPassword.text]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"密码错误" message:@"请重新输入。" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if(![self.theNewPassword.text isEqualToString:self.theNewPasswordConfirm.text]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"两次密码输入不一致" message:@"请重新输入。" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if([self.theNewPassword.text isEqualToString:@""]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"新密码为空" message:@"请重新输入。" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        userInfo=[NSMutableDictionary dictionaryWithObjects:@[@"admin",self.theNewPassword.text] forKeys:@[@"userName",@"userPassword"]];
        [user setObject:userInfo forKey:@"userInfo"];
        [user synchronize];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}
@end
