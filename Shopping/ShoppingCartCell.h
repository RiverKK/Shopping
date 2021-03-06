//
//  Shopping Cart Cell.h
//  Shopping
//
//  Created by NiceMatter on 23/12/2016.
//  Copyright © 2016 NiceMatter. All rights reserved.
//

#import "ViewController.h"

@interface ShoppingCartCell : UITableViewCell
@property (nonatomic,assign) int goodsId;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsKind;
@property (weak, nonatomic) IBOutlet UILabel *goodsDesc;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsSales;
@property (weak, nonatomic) IBOutlet UITextField *goodsAmount;
- (IBAction)minusAmount:(id)sender;
- (IBAction)addAmount:(id)sender;

@end
