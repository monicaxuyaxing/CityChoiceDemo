//
//  ViewController.m
//  CityChoice
//
//  Created by 杨晓亮 on 17/1/4.
//  Copyright © 2017年 OMS. All rights reserved.
//

#import "ViewController.h"
#import "ProvinceModel.h"
#import "CityModel.h"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,retain) NSMutableArray *dataSource;
@property (nonatomic,retain) ProvinceModel *currProvince;

@end

@implementation ViewController

- (UITableView *) tableView
{
    
    if(!_tableView)
    {
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat w = self.view.frame.size.width;
        CGFloat h = self.view.frame.size.height - y;
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, w, h) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.sectionIndexColor = [UIColor grayColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 1)];
        v.backgroundColor = [UIColor grayColor];
        [_tableView setTableFooterView:v];
    }
    
    return _tableView;
}

- (NSMutableArray *) dataSource
{
    if(!_dataSource)
    {
        _dataSource = [NSMutableArray array];
        for(int i = 0; i < 10; i++)
        {
            ProvinceModel *province = [[ProvinceModel alloc] init];
            province.pId = [NSString stringWithFormat:@"%d",i];
            province.pName = [NSString stringWithFormat:@"省份%d",i];
            for(int j = 0; j < 8; j++)
            {
                CityModel *city = [[CityModel alloc] init];
                city.cId =  [NSString stringWithFormat:@"%d",j];
                city.cName = [NSString stringWithFormat:@"城市%d",j];
                [province.citys addObject:city];
            }
            [_dataSource addObject:province];
            
        }
    }
    return _dataSource;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.barTintColor = [UIColor redColor];
    [navBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor clearColor];
    //self.view.backgroundColor = [HP_UIColorUtils colorWithHexString:BACKGROUND_COLOR02];
    [self.view addSubview:self.tableView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark UITabelViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ProvinceModel *province = (ProvinceModel *)self.dataSource[section];
    NSLog(@"%@",province);
    return  (province.selected) ? province.citys.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    ProvinceModel *province = (ProvinceModel *)self.dataSource[indexPath.section];
    CityModel *city = province.citys[indexPath.row];
    cell.textLabel.textColor = city.selected ? [UIColor redColor] : [UIColor blackColor];
    cell.textLabel.text = city.cName;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ProvinceModel *province = (ProvinceModel *)self.dataSource[section];
    UIButton *provinceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    provinceBtn.tag = [province.pId integerValue];
    provinceBtn.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
    [provinceBtn addTarget:self action:@selector(provinceChoice:) forControlEvents:UIControlEventTouchUpInside];
    provinceBtn.selected = province.selected;
    
    UILabel *provinceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, 40)];
    provinceLabel.text = province.pName;
    provinceLabel.textColor = province.selected ? [UIColor redColor] : [UIColor blueColor];
    if(province == self.currProvince)
    {
        provinceLabel.textColor = [UIColor redColor];
    }
    [provinceBtn addSubview:provinceLabel];
    return provinceBtn;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

//不让cell点击变高亮
- (BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProvinceModel *province = (ProvinceModel *)self.dataSource[indexPath.section];
    CityModel *currCity = province.citys[indexPath.row];
    for(CityModel *city in province.citys)
    {
        city.selected = (city == currCity) ? YES : NO;
    }
    [self.tableView reloadData];
}

#pragma mark - 省份选择
- (void) provinceChoice:(UIButton *) sender
{
    sender.selected = !sender.selected;
    
    for(ProvinceModel *p in self.dataSource)
    {
        if(sender.tag == [p.pId integerValue])
        {
            self.currProvince = p;
            p.selected = sender.selected;
        
        }else
        {
            p.selected = NO;
            for(CityModel *city in p.citys)
            {
                city.selected = NO;
            }
        }
    }
    [self.tableView reloadData];
        
}

@end
