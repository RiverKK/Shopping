//
//  ShoppingCart.h
//  Shopping
//
//  Created by NiceMatter on 22/12/2016.
//  Copyright © 2016 NiceMatter. All rights reserved.
//

#import "ViewController.h"
#import "Goods.h"

@class ShoppingCart;
@protocol ShoppingCartDelegate <NSObject>

- (void)afterJiesuan:(NSMutableArray*)shoppingListJiesuan Sender:(ShoppingCart*)sender;

@end
@interface ShoppingCart : ViewController
@property (nonatomic,retain) NSMutableArray *shoppingList;
@property (nonatomic, retain) id <ShoppingCartDelegate> delegate;

@end
