//
//  GoodsDetailFrontier.m
//  Shopping
//
//  Created by 尹皇 on 23/12/2016.
//  Copyright © 2016 YH. All rights reserved.
//

#import "GoodsDetailFrontier.h"
#import "GoodsBuy.h"
#import "Goods.h"
@interface GoodsDetailFrontier ()
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsKind;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsSales;
@property (weak, nonatomic) IBOutlet UITextView *goodsDesc;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (nonatomic,retain) NSMutableArray *shoppingList;
- (IBAction)addToShoppingCart:(id)sender;

@end

@implementation GoodsDetailFrontier

- (NSMutableArray*)shoppingList{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSData *takeData=[user objectForKey:@"shoppingCart"];
    _shoppingList=[NSKeyedUnarchiver unarchiveObjectWithData:takeData];
    if(_shoppingList==nil){
        _shoppingList=[NSMutableArray array];
    }
    return _shoppingList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.goodsImage.image=[UIImage imageWithData:self.goods.imgName];
    self.goodsName.text=self.goods.name;
    self.goodsKind.text=self.goods.kind;
    self.goodsPrice.text=[NSString stringWithFormat:@"%.2f", self.goods.price];
    self.goodsDesc.text=self.goods.desc;
    self.goodsSales.text=[NSString stringWithFormat:@"%d", self.goods.sales];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addToShoppingCart:(id)sender {
    NSLog(@"商品加入购物车");
    BOOL flag=NO;
    for (int i=0; i<self.shoppingList.count; i++) {
        GoodsBuy *goodsBuy=(GoodsBuy*)[self.shoppingList objectAtIndex:i];
        if (self.goods.goodsId==goodsBuy.goodsId) {
            flag=YES;
            break;
        }
    }
    if(flag==NO){
        GoodsBuy *goodsBUy=[[GoodsBuy alloc]init];
        goodsBUy.name=self.goods.name;
        goodsBUy.kind=self.goods.kind;
        goodsBUy.desc=self.goods.desc;
        goodsBUy.price=self.goods.price;
        goodsBUy.sales=self.goods.sales;
        goodsBUy.goodsId=self.goods.goodsId;
        goodsBUy.amount=1;
        goodsBUy.imgName=self.goods.imgName;
        
        //        [self.shoppingList addObject:goodsBUy];
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        NSData *takeData=[user objectForKey:@"shoppingCart"];
        NSMutableArray *tmpShoppingCart=[NSKeyedUnarchiver unarchiveObjectWithData:takeData];
        if (tmpShoppingCart==nil) {
            tmpShoppingCart=[[NSMutableArray alloc]init];
        }
        [tmpShoppingCart addObject:goodsBUy];
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:tmpShoppingCart];
        [user setObject:data forKey:@"shoppingCart"];
        [user synchronize];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"添加成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"商品已存在" message:@"请重新选择。" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
@end
