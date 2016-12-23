//
//  GoodsDetailFrontier.m
//  Shopping
//
//  Created by River on 23/12/2016.
//  Copyright © 2016 River. All rights reserved.
//

#import "GoodsDetailFrontier.h"

@interface GoodsDetailFrontier ()
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsKind;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsSales;
@property (weak, nonatomic) IBOutlet UITextView *goodsDesc;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
- (IBAction)addToShoppingCart:(id)sender;

@end

@implementation GoodsDetailFrontier

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
}
@end
