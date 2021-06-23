//
//  TabPagerViewDmeoController.m
//  TYPagerControllerDemo
//
//  Created by tany on 2017/7/19.
//  Copyright © 2017年 tany. All rights reserved.
//

#import "TabPagerViewDmeoController.h"
#import "TYTabPagerView.h"
#import "Masonry.h"

@interface TabPagerViewDmeoController ()<TYTabPagerViewDataSource, TYTabPagerViewDelegate>

@property (nonatomic, strong) TYTabPagerView *pagerView;

@property (nonatomic, strong) NSArray *datas;

@end

@implementation TabPagerViewDmeoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"TabPagerViewDmeoController";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.pagerView];
    [self.pagerView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            // Fallback on earlier versions
        }
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    NSMutableArray *datas = [NSMutableArray array];
    for (NSInteger i = 0; i < 20; ++i) {
        [datas addObject:i%2 == 0 ? [NSString stringWithFormat:@"Tab %ld",i]:[NSString stringWithFormat:@"Tab Tab %ld",i]];
    }
    _datas = [datas copy];
    
    [self.pagerView reloadData];
    //[_pagerView scrollToViewAtIndex:1 animate:YES];
}

#pragma mark - TYTabPagerViewDataSource
- (NSInteger)numberOfViewsInTabPagerView {
    return _datas.count;
}

- (UIView *)tabPagerView:(TYTabPagerView *)tabPagerView viewForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    UIView *view = [[UIView alloc]initWithFrame:[tabPagerView.layout frameForItemAtIndex:index]];
    view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%255/255.0];
    //NSLog(@"viewForIndex:%ld prefetching:%d",index,prefetching);
    return view;
}

- (NSString *)tabPagerView:(TYTabPagerView *)tabPagerView titleForIndex:(NSInteger)index {
    NSString *title = _datas[index];
    return title;
}

#pragma mark - lazy
- (TYTabPagerView *)pagerView{
    if (!_pagerView) {
        TYTabPagerView *pagerView = [[TYTabPagerView alloc]init];
        pagerView.tabBar.layout.barStyle = TYPagerBarStyleCoverView;
        pagerView.tabBar.progressView.backgroundColor = [UIColor lightGrayColor];
        pagerView.dataSource = self;
        pagerView.delegate = self;
        _pagerView = pagerView;
    }
    return _pagerView;
}

@end
