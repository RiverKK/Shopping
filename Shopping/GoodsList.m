//
//  GoodsList.m
//  Shopping
//
//  Created by River on 21/12/2016.
//  Copyright © 2016 River. All rights reserved.
//

#import "GoodsList.h"
#import "Goods.h"
#import "GoodsListCell.h"
#import "GoodsDetail.h"
@interface GoodsList ()<UITableViewDataSource, UITableViewDelegate,GoodsDetailDelegate>
@property (nonatomic,retain) NSMutableArray *goodsList;
@property (weak, nonatomic) IBOutlet UITableView *goodsListTableView;

@end

@implementation GoodsList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated{
    [self.goodsListTableView reloadData];
}

+ (NSString *)changeFloat:(NSString *)stringFloat{
    
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    long i = length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0'/*0x30*/) {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
}

- (NSMutableArray*)goodsList{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
//    [user removeObjectForKey:@"goodsList"];
    NSData *takeData=[user objectForKey:@"goodsList"];
    _goodsList=[[NSKeyedUnarchiver unarchiveObjectWithData:takeData]mutableCopy];
    if(_goodsList==nil){
        _goodsList=[NSMutableArray array];
//        Goods *test=[[Goods alloc] init];
//        test.name=@"name";
//        test.imgName=(NSData*)UIImageJPEGRepresentation([UIImage imageNamed:@"me.jpg"], 1.0);
//        test.kind=@"kind";
//        test.price=10;
//        test.sales=10;
//        test.desc=@"this is me";
//        [_goodsList addObject:test];
//        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:_goodsList];
//        [user setObject:data forKey:@"goodsList"];
//        [user synchronize];
    }
    return _goodsList;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Goods List Cell"];
    Goods *goods=(Goods*)[self.goodsList objectAtIndex:indexPath.row];
    cell.goodsName.text=goods.name;
    cell.goodsKind.text=goods.kind;
    cell.goodsImg.image=[UIImage imageWithData:goods.imgName];
    cell.goodsPrice.text=[NSString stringWithFormat:@"%@%@",@"¥",[NSString stringWithFormat:@"%.2f",goods.price]];
    cell.goodsSales.text=[NSString stringWithFormat:@"%@%d",@"已售",goods.sales];
    cell.goodsDesc.text=goods.desc;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"Show Goods Detail"]){
        GoodsDetail *vc = (GoodsDetail *)segue.destinationViewController;
        vc.goods  = (Goods *)sender;
        vc.delegate = self;
    }
}

- (void)goodsInfoSave:(Goods *)goods Sender:(GoodsDetail*)sender{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    Goods *goods = (Goods *)[self.goodsList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"Show Goods Detail" sender:goods];

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
//        [self.goodsList removeObjectAtIndex:indexPath.row];
//        NSLog(@"%lu", (unsigned long)self.goodsList.count);
//        NSLog(@"%lu", (unsigned long)indexPath.row);
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        NSData *takeData=[user objectForKey:@"goodsList"];
        NSMutableArray *tmpGoodsList=[NSKeyedUnarchiver unarchiveObjectWithData:takeData];
        [tmpGoodsList removeObjectAtIndex:indexPath.row];
        for (int i=0; i<tmpGoodsList.count; i++) {
            Goods *tmpGoods=(Goods*)[tmpGoodsList objectAtIndex:i];
            tmpGoods.goodsId=i;
        }
        
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:tmpGoodsList];
        [user setObject:data forKey:@"goodsList"];
        [user synchronize];
        [self.goodsListTableView reloadData];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
