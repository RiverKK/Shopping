//
//  Goods.m
//  Shopping
//
//  Created by River on 22/12/2016.
//  Copyright © 2016 River. All rights reserved.
//

#import "Goods.h"

@implementation Goods
//- (NSString*)name{
//    return _name;
//}
//- (NSString*)kind{
//    return _kind;
//}
//- (NSString*)desc{
//    return _desc;
//}
//- (NSString*)imgName{
//    return _imgName;
//}
//- (double)price{
//    return _price;
//}
//- (int)sales{
//    return _sales;
//}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.kind forKey:@"kind"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
    [aCoder encodeObject:self.imgName forKey:@"imgName"];
    [aCoder encodeDouble:self.price forKey:@"price"];
    [aCoder encodeInt:self.sales forKey:@"sales"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){
        if(aDecoder ==nil){
            return self;
        }
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.kind=[aDecoder decodeObjectForKey:@"kind"];
        self.desc=[aDecoder decodeObjectForKey:@"desc"];
        self.imgName=[aDecoder decodeObjectForKey:@"imgName"];
        self.price=[aDecoder decodeDoubleForKey:@"price"];
        self.sales=[aDecoder decodeIntForKey:@"sales"];

    }
    return self;
}
@end
