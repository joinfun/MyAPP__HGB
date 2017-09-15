//
//  HGBComponentViewController.m
//  MyApp_HGB
//
//  Created by huangguangbao on 2017/9/12.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "HGBComponentViewController.h"
#import "HGBCommonSelectCell.h"

#import "HGBKeybordController.h"
#import "HGBPromptViewController.h"
#import "HGBBottomPopViewController.h"
#import "HGBBottomSelectViewController.h"
#import "HGBDateViewController.h"
#import "HGBTimeViewController.h"

#define Identify_Cell @"cell"

@interface HGBComponentViewController ()
/**
 弹出类组件
 */
@property(strong,nonatomic)NSArray *popDataArray;
/**
 普通组件
 */
@property(strong,nonatomic)NSArray *commonDataArray;
@end

@implementation HGBComponentViewController

#pragma mark life
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationItem];//导航栏
    [self viewSetUp];//UI

}
#pragma mark 导航栏
//导航栏
-(void)createNavigationItem
{
    //导航栏
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.0/256 green:191.0/256 blue:256.0/256 alpha:1];
    [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:0.0/256 green:191.0/256 blue:256.0/256 alpha:1]];
    //标题
    UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 136*wScale, 16)];
    titleLab.font=[UIFont boldSystemFontOfSize:16];
    titleLab.text=@"组件";
    titleLab.textAlignment=NSTextAlignmentCenter;
    titleLab.textColor=[UIColor whiteColor];
    self.navigationItem.titleView=titleLab;
    

}
//返回
-(void)returnhandler{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark UI
-(void)viewSetUp{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, kWidth, kHeight-44) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor colorWithRed:220.0/256 green:220.0/256 blue:220.0/256 alpha:1];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.popDataArray=@[@"键盘",@"提示",@"底部弹出窗",@"日期选择",@"时间选择",@"Picker选择"];
   
    [self.tableView registerClass:[HGBCommonSelectCell class] forCellReuseIdentifier:Identify_Cell];
    [self.tableView reloadData];
}
#pragma mark table view delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 72 * hScale;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 72 * hScale)];
    headView.backgroundColor = [UIColor colorWithRed:220.0/256 green:220.0/256 blue:220.0/256 alpha:1];
    //信息提示栏
    UILabel *tipMessageLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, 0, kWidth - 32 * wScale, CGRectGetHeight(headView.frame))];
    tipMessageLabel.backgroundColor = [UIColor clearColor];
    if (section == 0) {
        tipMessageLabel.text = @"弹出类组件";
    }else{
        tipMessageLabel.text = @"其他组件";
    }
    tipMessageLabel.textColor = [UIColor grayColor];
    tipMessageLabel.textAlignment = NSTextAlignmentLeft;
    tipMessageLabel.font = [UIFont systemFontOfSize:12.0];
    tipMessageLabel.numberOfLines = 0;
    [headView addSubview:tipMessageLabel];
    return headView;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return  self.popDataArray.count;
    }else{
        return self.commonDataArray.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HGBCommonSelectCell *cell=[tableView dequeueReusableCellWithIdentifier:Identify_Cell forIndexPath:indexPath];
    if(indexPath.section==0){
        cell.title.text=self.popDataArray[indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section==0){
        if(indexPath.row==0){
            [self pushController:[[HGBKeybordController alloc]init]];
        }else if (indexPath.row==1){
            [self pushController:[[HGBPromptViewController alloc]init]];
        }else if (indexPath.row==2){
            [self pushController:[[HGBBottomPopViewController alloc]init]];
        }else if (indexPath.row==3){
            [self pushController:[[HGBDateViewController alloc]init]];
        }else if (indexPath.row==4){
            [self pushController:[[HGBTimeViewController alloc]init]];
        }else if (indexPath.row==5){
            [self pushController:[[HGBBottomSelectViewController alloc]init]];
        }
    }
}
-(void)pushController:(UIViewController*)controller{
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:controller];
    [self.tabBarController presentViewController:nav animated:YES completion:nil];
}
#pragma mark get
-(NSArray *)popDataArray{
    if(_popDataArray==nil){
        _popDataArray=[NSArray array];
    }
    return _popDataArray;
}
-(NSArray *)commonDataArray{
    if(_commonDataArray==nil){
        _commonDataArray=[NSArray array];
    }
    return _commonDataArray;
}
@end
