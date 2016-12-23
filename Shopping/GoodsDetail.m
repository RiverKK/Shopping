//
//  GoodsDetail.m
//  Shopping
//
//  Created by River on 23/12/2016.
//  Copyright © 2016 River. All rights reserved.
//

#import "GoodsDetail.h"

@interface GoodsDetail ()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UITextField *goodsName;
@property (weak, nonatomic) IBOutlet UITextField *goodsKind;
@property (weak, nonatomic) IBOutlet UITextField *goodsPrice;
@property (weak, nonatomic) IBOutlet UITextView *goodsDesc;
@property (weak, nonatomic) IBOutlet UILabel *goodsSales;
- (IBAction)saveInfo:(id)sender;

@end

@implementation GoodsDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.goodsImage.image=[UIImage imageWithData:self.goods.imgName];
    self.goodsName.text=self.goods.name;
    self.goodsKind.text=self.goods.kind;
    self.goodsPrice.text=[NSString stringWithFormat:@"%.2f", self.goods.price];
    self.goodsDesc.text=self.goods.desc;
    self.goodsSales.text=[NSString stringWithFormat:@"%d", self.goods.sales];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveInfo:(id)sender {
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSData *takeData=[user objectForKey:@"goodsList"];
    NSMutableArray *tmpGoodsList=[NSKeyedUnarchiver unarchiveObjectWithData:takeData];
    for (int i=0; i<tmpGoodsList.count; i++) {
        Goods *tmpGoods=(Goods*)[tmpGoodsList objectAtIndex:i];
        if(tmpGoods.goodsId==self.goods.goodsId){
            tmpGoods.name=self.goodsName.text;
            tmpGoods.kind=self.goodsKind.text;
            tmpGoods.imgName=(NSData*)UIImageJPEGRepresentation(self.goodsImage.image, 1.0);
            tmpGoods.price=[self.goodsPrice.text doubleValue];
            tmpGoods.sales=[self.goodsSales.text intValue];
            tmpGoods.desc=self.goodsDesc.text;
            break;
        }
    }
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:tmpGoodsList];
    [user setObject:data forKey:@"goodsList"];
    [user synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
