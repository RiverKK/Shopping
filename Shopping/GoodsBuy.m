//
//  GoodsBuy.m
//  Shopping
//
//  Created by River on 24/12/2016.
//  Copyright © 2016 River. All rights reserved.
//

#import "GoodsBuy.h"

@implementation GoodsBuy
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:self.goodsId forKey:@"id"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.kind forKey:@"kind"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
    [aCoder encodeObject:self.imgName forKey:@"imgName"];
    [aCoder encodeDouble:self.price forKey:@"price"];
    [aCoder encodeInt:self.sales forKey:@"sales"];
    [aCoder encodeInt:self.amount forKey:@"amount"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){
        if(aDecoder ==nil){
            return self;
        }
        self.goodsId=[aDecoder decodeIntForKey:@"id"];
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.kind=[aDecoder decodeObjectForKey:@"kind"];
        self.desc=[aDecoder decodeObjectForKey:@"desc"];
        self.imgName=[aDecoder decodeObjectForKey:@"imgName"];
        self.price=[aDecoder decodeDoubleForKey:@"price"];
        self.sales=[aDecoder decodeIntForKey:@"sales"];
        self.amount=[aDecoder decodeIntForKey:@"amount"];
    }
    return self;
}
@end
