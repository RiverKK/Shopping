//
//  Goods.h
//  Shopping
//
//  Created by River on 22/12/2016.
//  Copyright © 2016 River. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goods : NSObject<NSCoding>
@property (nonatomic,assign) int goodsId;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,assign) double price;
@property (nonatomic,assign) int sales;
@property (nonatomic,retain) NSString *kind;
@property (nonatomic,retain) NSString *desc;
@property (nonatomic,retain) NSData *imgName;
@end
