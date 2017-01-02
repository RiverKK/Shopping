//
//  GoodsDetailFrontier.h
//  Shopping
//
//  Created by 尹皇 on 23/12/2016.
//  Copyright © 2016 YH. All rights reserved.
//

#import "ViewController.h"
#import "Goods.h"

@class GoodsDetailFrontier;
@protocol GoodsDetailDelegate <NSObject>

//- (void)addGoodsToShoppingCart:(Goods *)goods Sender:(GoodsDetailFrontier*)sender;

@end
@interface GoodsDetailFrontier : ViewController
@property (nonatomic, retain) Goods *goods;
@property (nonatomic, retain) id <GoodsDetailDelegate> delegate;
@end
