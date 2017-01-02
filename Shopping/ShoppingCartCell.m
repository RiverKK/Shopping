//
//  Shopping Cart Cell.m
//  Shopping
//
//  Created by NiceMatter on 23/12/2016.
//  Copyright © 2016 NiceMatter. All rights reserved.
//

#import "ShoppingCartCell.h"
#import "GoodsBuy.h"
@implementation ShoppingCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (IBAction)minusAmount:(id)sender {
    int amount=[self.goodsAmount.text intValue];
    if (amount>1) {
        amount--;
        double tmpPrice;
        self.goodsAmount.text=[NSString stringWithFormat:@"%d", amount];
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        NSData *takeData=[user objectForKey:@"shoppingCart"];
        NSMutableArray *tmpShoppingCart=[NSKeyedUnarchiver unarchiveObjectWithData:takeData];
        if (tmpShoppingCart==nil) {
            tmpShoppingCart=[[NSMutableArray alloc]init];
        }
        for (int i=0; i<tmpShoppingCart.count; i++) {
            GoodsBuy *goodsBuy=(GoodsBuy*)[tmpShoppingCart objectAtIndex:i];
            if (goodsBuy.goodsId==self.goodsId) {
                goodsBuy.amount=amount;
                tmpPrice=goodsBuy.price;
                NSData *data=[NSKeyedArchiver archivedDataWithRootObject:tmpShoppingCart];
                [user setObject:data forKey:@"shoppingCart"];
                [user synchronize];
                break;
            }
        }
        NSNotification *notification =[NSNotification notificationWithName:@"tongzhi1" object:@(tmpPrice) userInfo: nil];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
    else{
        UIAlertController *alter=[UIAlertController alertControllerWithTitle:@"商品数量至少为1" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alter addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
//        [self UITableViewCell:alertController animated:YES completion:nil];
    }
}
- (IBAction)addAmount:(id)sender {
    int amount=[self.goodsAmount.text intValue];
    amount++;
    double tmpPrice;
    self.goodsAmount.text=[NSString stringWithFormat:@"%d", amount];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSData *takeData=[user objectForKey:@"shoppingCart"];
    NSMutableArray *tmpShoppingCart=[NSKeyedUnarchiver unarchiveObjectWithData:takeData];
    if (tmpShoppingCart==nil) {
        tmpShoppingCart=[[NSMutableArray alloc]init];
    }
    for (int i=0; i<tmpShoppingCart.count; i++) {

        GoodsBuy *goodsBuy=(GoodsBuy*)[tmpShoppingCart objectAtIndex:i];
        if (goodsBuy.goodsId==self.goodsId) {
            goodsBuy.amount=amount;
            tmpPrice=goodsBuy.price;
            NSData *data=[NSKeyedArchiver archivedDataWithRootObject:tmpShoppingCart];
            [user setObject:data forKey:@"shoppingCart"];
            [user synchronize];
            break;
        }
    }
    NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:@(tmpPrice) userInfo: nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
@end
