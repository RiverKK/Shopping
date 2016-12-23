//
//  AddGoods.m
//  Shopping
//
//  Created by River on 21/12/2016.
//  Copyright © 2016 River. All rights reserved.
//

#import "AddGoods.h"
#import "Goods.h"
@interface AddGoods ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *saveImage;
- (IBAction)save:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *saveName;
@property (weak, nonatomic) IBOutlet UITextField *saveKind;
@property (weak, nonatomic) IBOutlet UITextField *savePrice;
@property (weak, nonatomic) IBOutlet UITextView *saveDesc;

@end

@implementation AddGoods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"添加商品";
    self.saveDesc.layer.borderColor=UIColor.grayColor.CGColor;
    self.saveDesc.layer.borderWidth=1;
    self.saveImage.image=[UIImage imageNamed:@"me.jpg"];
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alertHeadPortrait:)];
    [self.saveImage addGestureRecognizer:g];
    self.saveImage.userInteractionEnabled = YES;
    
    // Do any additional setup after loading the view.
}
- (void)alertHeadPortrait:(UIGestureRecognizer *)g{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        UIImagePickerController *pickImage =[[UIImagePickerController alloc]init];
        pickImage.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        pickImage.allowsEditing=YES;
        pickImage.delegate=self;
        [self presentViewController:pickImage animated:YES completion:nil];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        UIImagePickerController *pickImage =[[UIImagePickerController alloc]init];
        pickImage.sourceType=UIImagePickerControllerSourceTypeCamera;
        pickImage.allowsEditing=YES;
        pickImage.delegate=self;
        [self presentViewController:pickImage animated:YES completion:nil];
        }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *newPhoto=[info objectForKey:@"UIImagePickerControllerEditedImage"];
    self.saveImage.image=newPhoto;
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)save:(id)sender {
    if([self.saveName.text isEqualToString:@""] ||[self.saveKind.text isEqualToString:@""]||[self.savePrice.text isEqualToString:@""]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"输入信息不完整" message:@"请重新输入。" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if ([self.savePrice.text doubleValue]==0){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"输入错误" message:@"请重新输入价格。" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        Goods *goods=[[Goods alloc]init];
        goods.name=self.saveName.text;
        goods.kind=self.saveKind.text;
        goods.imgName=(NSData*)UIImageJPEGRepresentation(self.saveImage.image, 1.0);
        goods.desc=self.saveDesc.text;
        goods.price=[self.savePrice.text doubleValue];
        goods.sales=0;
        
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        NSData *takeData=[user objectForKey:@"goodsList"];
        NSMutableArray *goodsList=[NSKeyedUnarchiver unarchiveObjectWithData:takeData];
        if(goodsList==nil){
            goodsList=[NSMutableArray array];
        }
        [goodsList addObject:goods];
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:goodsList];
        [user setObject:data forKey:@"goodsList"];
        [user synchronize];
        [[self navigationController]popViewControllerAnimated:YES];

    }
}
@end
