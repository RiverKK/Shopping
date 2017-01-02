//
//  GoodsDetail.h
//  Shopping
//
//  Created by 王 鸿锴 on 23/12/2016.
//  Copyright © 2016 WHK. All rights reserved.
//

#import "ViewController.h"
#import "Goods.h"

@class GoodsDetail;
@protocol GoodsDetailDelegate <NSObject>

- (void)goodsInfoSave:(Goods *)goods Sender:(GoodsDetail*)sender;

@end
@interface GoodsDetail : ViewController
@property (nonatomic, retain) Goods *goods;
@property (nonatomic, retain) id <GoodsDetailDelegate> delegate;
@end
