//
//  GoodsListCell.h
//  Shopping
//
//  Created by River on 21/12/2016.
//  Copyright © 2016 River. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImg;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsKind;
@property (weak, nonatomic) IBOutlet UILabel *goodsDesc;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsSales;

@end
