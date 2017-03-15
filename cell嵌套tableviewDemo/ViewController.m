#import "ViewController.h"
#import "ContentInfo.h"
#import "CommentInfo.h"
#import "CommentTableViewCell.h"
#import "ContentTableViewCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import <Masonry/Masonry.h>

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong)UITableView *infoTable;
@property (nonatomic,strong)NSMutableArray *items;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.infoTable=[UITableView new];
    self.infoTable.delegate=self;
    self.infoTable.dataSource=self;
    self.infoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.infoTable registerClass:[ContentTableViewCell class] forCellReuseIdentifier:kContentTableViewCell];
    [self.view addSubview:self.infoTable];
    [self.infoTable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
    self.items=[NSMutableArray array];
    
    for (NSUInteger i = 0; i < 100; ++i) {
        
        ContentInfo *testModel = [[ContentInfo alloc] init];
        testModel.title = @"sugar";
        testModel.desc = @"I'm hurting, baby, I'm broken down I need your loving, loving, I need it now When I'm without you I'm something weak You got me begging Begging, I'm on my knees I don't wanna be needing your love I just wanna be deep in your love And it's killing me when you're away Ooh, baby,'Cause I really don't care where you are I just wanna be there where you are And I gotta get one little taste Your sugar Yes, please";
        testModel.headerImg = @"head";
        testModel.uid = [NSString stringWithFormat:@"testModel%ld", i + 1];
        
        [self.items addObject:testModel];
    }
    
    [self.infoTable reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContentInfo *model = [self.items objectAtIndex:indexPath.row];
    
    CGFloat h = [ContentTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        ContentTableViewCell *cell = (ContentTableViewCell *)sourceCell;
        [cell configCell:model withIndexPath:indexPath ];
    } cache:^NSDictionary *{
        NSDictionary *cache = @{kHYBCacheUniqueKey : model.uid,
                                kHYBCacheStateKey  : model.uid,
                                kHYBRecalculateForStateKey : @(model.isUpdateCacheCell_hight)};
        return cache;
    }];
    
    return h-120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kContentTableViewCell];
    
    if (cell==nil) {
        cell = [[ContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kContentTableViewCell];
        
    }
    
    ContentInfo *model = [self.items objectAtIndex:indexPath.row];
    cell.updateBlock=^(BOOL isupdate ,NSIndexPath *indexPath)
    {
        model.isUpdateCacheCell_hight=isupdate;
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    };
    [cell configCell:model withIndexPath:indexPath];
    model.isUpdateCacheCell_hight=NO;
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
