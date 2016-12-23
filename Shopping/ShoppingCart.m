//
//  ShoppingCart.m
//  Shopping
//
//  Created by River on 22/12/2016.
//  Copyright © 2016 River. All rights reserved.
//

#import "ShoppingCart.h"
#import "ShoppingCartCell.h"
#import "GoodsBuy.h"

@interface ShoppingCart ()
@property (weak, nonatomic) IBOutlet UITableView *goodsListTableView;
- (IBAction)jiesuan:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;

@end

@implementation ShoppingCart

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [self.goodsListTableView reloadData];
}

- (NSMutableArray*)shoppingList{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
//    [user removeObjectForKey:@"shoppingCart"];
    NSData *takeData=[user objectForKey:@"shoppingCart"];
    _shoppingList=[NSKeyedUnarchiver unarchiveObjectWithData:takeData];
    if(_shoppingList==nil){
        _shoppingList=[NSMutableArray array];
    }
    return _shoppingList;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shoppingList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Shopping Cart Cell"];
//    NSMutableDictionary *tmpDic=(NSMutableDictionary*)[self.shoppingList objectAtIndex:indexPath.row];
    GoodsBuy *goodsBuy=(GoodsBuy*)[self.shoppingList objectAtIndex:indexPath.row];
    cell.goodsName.text=goodsBuy.name;
    cell.goodsKind.text=goodsBuy.kind;
    cell.goodsImage.image=[UIImage imageWithData:goodsBuy.imgName];
    cell.goodsPrice.text=[NSString stringWithFormat:@"%@%@",@"¥",[NSString stringWithFormat:@"%.2f",goodsBuy.price]];
    cell.goodsSales.text=[NSString stringWithFormat:@"%@%d",@"已售",goodsBuy.sales];
    cell.goodsDesc.text=goodsBuy.desc;
    cell.goodsAmount.text=[NSString stringWithFormat:@"%d", goodsBuy.amount];
    return cell;
}

- (IBAction)jiesuan:(id)sender {
}
@end
