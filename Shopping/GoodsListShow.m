//
//  GoodsListShowViewController.m
//  Shopping
//
//  Created by River on 22/12/2016.
//  Copyright © 2016 River. All rights reserved.
//

#import "GoodsListShow.h"
#import "GoodsListCell.h"
#import "GoodsDetailFrontier.h"
#import "Goods.h"

@interface GoodsListShow ()<UITableViewDataSource, UITableViewDelegate,GoodsDetailDelegate>
@property (nonatomic,retain) NSMutableArray *goodsList;
@property (weak, nonatomic) IBOutlet UITableView *goodsListTableView;

@end

@implementation GoodsListShow

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    for (int i=0; i<self.goodsList.count; i++) {
//        Goods *goods=(Goods *)[self.goodsList objectAtIndex:i];
//        NSLog(@"%@ %@",goods.imgName,goods.name);
//    }
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
    NSData *takeData=[user objectForKey:@"goodsList"];
    _goodsList=[NSKeyedUnarchiver unarchiveObjectWithData:takeData];

    if(_goodsList==nil){
        _goodsList=[NSMutableArray array];
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
    GoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Goods List Show Cell"];
    Goods *goods=(Goods*)[self.goodsList objectAtIndex:indexPath.row];
    cell.goodsName.text=goods.name;
    cell.goodsKind.text=goods.kind;
    cell.goodsImg.image=[UIImage imageWithData:goods.imgName];
    cell.goodsPrice.text=[NSString stringWithFormat:@"%@%@",@"$",[GoodsListShow changeFloat:[NSString stringWithFormat:@"%f",goods.price]]];
    cell.goodsSales.text=[NSString stringWithFormat:@"%d",goods.sales];
    cell.goodsDesc.text=goods.desc;

//    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
//    [cell.headImageView addGestureRecognizer:g];
//    cell.headImageView.userInteractionEnabled = YES;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"Show Goods Detail frontier"]){
        GoodsDetailFrontier *vc = (GoodsDetailFrontier *)segue.destinationViewController;
        vc.goods  = (Goods *)sender;
        vc.delegate = self;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    Goods *goods = (Goods *)[self.goodsList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"Show Goods Detail frontier" sender:goods];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *addToShoppingCart=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"加入购物车" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击加入购物车");
    }];
    addToShoppingCart.backgroundColor=[UIColor greenColor];
    return @[addToShoppingCart];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
}
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
