//
//  ShoppingCart.m
//  Shopping
//
//  Created by NiceMatter on 22/12/2016.
//  Copyright © 2016 NiceMatter. All rights reserved.
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi1:) name:@"tongzhi1" object:nil];

    double sumAmount=0;
    for (int i=0; i<self.shoppingList.count; i++) {
        GoodsBuy *goodsBuy=(GoodsBuy*)[self.shoppingList objectAtIndex:i];
        sumAmount+=goodsBuy.price*goodsBuy.amount;
    }
    self.totalMoney.text=[NSString stringWithFormat:@"%.2f", sumAmount];
    // Do any additional setup after loading the view.
}

- (void)tongzhi1:(NSNotification *)text{
    NSLog(@"－－－－－接收到通知------");
    double tmpPrice=[self.totalMoney.text doubleValue];
    tmpPrice-=[text.object doubleValue];
    self.totalMoney.text=[NSString stringWithFormat:@"%.2f",tmpPrice] ;
    [self.goodsListTableView reloadData];
}

- (void)tongzhi:(NSNotification *)text{
    NSLog(@"－－－－－接收到通知------");
    double tmpPrice=[self.totalMoney.text doubleValue];
    tmpPrice+=[text.object doubleValue];
    self.totalMoney.text=[NSString stringWithFormat:@"%.2f",tmpPrice] ;
    [self.goodsListTableView reloadData];
}


- (void)viewDidAppear:(BOOL)animated{
    [self.goodsListTableView reloadData];
    double sumAmount=0;
    for (int i=0; i<self.shoppingList.count; i++) {
        GoodsBuy *goodsBuy=(GoodsBuy*)[self.shoppingList objectAtIndex:i];
        sumAmount+=goodsBuy.price*goodsBuy.amount;
    }
    self.totalMoney.text=[NSString stringWithFormat:@"%.2f", sumAmount];
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
    cell.goodsId=goodsBuy.goodsId;
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
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSData *takeData=[user objectForKey:@"shoppingCart"];
    NSMutableArray *tmpShoppingCart=[NSKeyedUnarchiver unarchiveObjectWithData:takeData];
    takeData=[user objectForKey:@"goodsList"];
    NSMutableArray *tmpGoodsList=[NSKeyedUnarchiver unarchiveObjectWithData:takeData];
    if (tmpShoppingCart==nil) {
        tmpShoppingCart=[[NSMutableArray alloc]init];
    }
    if (tmpGoodsList==nil) {
        tmpGoodsList=[[NSMutableArray alloc]init];
    }
    for (int i=0; i<tmpShoppingCart.count; i++) {
        GoodsBuy *goodsBuy=(GoodsBuy*)[tmpShoppingCart objectAtIndex:i];
        
        for (int j=0; j<tmpGoodsList.count; j++) {
            Goods *goods=(Goods*)[tmpGoodsList objectAtIndex:j];
            if (goodsBuy.goodsId==goods.goodsId) {
                goods.sales+=goodsBuy.amount;
                break;
            }
        }
    }
    [user removeObjectForKey:@"shoppingCart"];
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:tmpGoodsList];
    [user setObject:data forKey:@"goodsList"];
    [user synchronize];
    [self.goodsListTableView reloadData];
    self.totalMoney.text=@"0";
}
@end
