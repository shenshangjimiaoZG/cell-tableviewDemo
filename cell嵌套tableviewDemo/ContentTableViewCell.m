#import "ContentTableViewCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import <Masonry/Masonry.h>
#import "CommentTableViewCell.h"
#import "ContentInfo.h"
#import "CommentInfo.h"
#import <ZYCornerRadius/UIImageView+CornerRadius.h>
#import "YZInputView.h"
#import "UITextView+YZEmotion.h"


@interface ContentTableViewCell ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIImageView *headerImgView;
@property (nonatomic,strong)UILabel *lblContent,*lblTitle;
@property (nonatomic,strong)UIView *imgsView;
@property (nonatomic,strong)NSMutableArray *imgAry;
@property (nonatomic,strong)UITableView *commentTable;
@property (nonatomic,strong)YZInputView *txtInput;
@property (nonatomic,strong)UIButton *btnEmtion;
@property (nonatomic,strong)UIButton *btnReply;

@property (nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,strong)ContentInfo *info;
@property (strong, nonatomic) YZEmotionKeyboard *emotionKeyboard;

@end

@implementation ContentTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
        self.headerImgView=[UIImageView new];
        self.headerImgView.image=[UIImage imageNamed:@"head"];
        [self.headerImgView zy_cornerRadiusAdvance:20 rectCornerType:UIRectCornerAllCorners];
        [self.headerImgView zy_attachBorderWidth:2 color:[UIColor lightGrayColor]];
        [self.contentView addSubview:self.headerImgView];
        
        self.lblTitle=[UILabel new];
        self.lblTitle.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.lblTitle];
        
        self.lblContent=[UILabel new];
        self.lblContent.font=[UIFont systemFontOfSize:13];
        self.lblContent.numberOfLines=0;
        self.lblContent.textColor=[UIColor colorWithRed:70.0f/255.0f green:70.0f/255.0f blue:70.0f/255.0f alpha:1];
        [self.contentView addSubview:self.lblContent];
        
        self.imgsView=[UIView new];
        [self.contentView addSubview:self.imgsView];
        
        self.commentTable=[UITableView new];
        [self.contentView addSubview:self.commentTable];
        
        self.txtInput=[YZInputView new];
        self.txtInput.font=[UIFont systemFontOfSize:17];
        self.txtInput.textColor=[UIColor colorWithRed:11.0f/255.0f green:124.0f/255.0f blue:175.0f/255.0f alpha:1];
        self.txtInput.backgroundColor=[UIColor lightGrayColor];
        self.txtInput.layer.borderWidth=2;
        [self.contentView addSubview:self.txtInput];
        
        self.btnEmtion=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.btnEmtion addTarget:self action:@selector(clickEmtionKeyboard) forControlEvents:UIControlEventTouchUpInside];
        [self.btnEmtion setBackgroundImage:[UIImage imageNamed:@"smail"] forState:UIControlStateNormal];

        [self.contentView addSubview:self.btnEmtion];
        
        self.btnReply=[UIButton buttonWithType:UIButtonTypeCustom];
        self.btnReply.layer.borderWidth=1;
        [self.btnReply addTarget:self action:@selector(addComent) forControlEvents:UIControlEventTouchUpInside];
        [self.btnReply setTitle:@"回复" forState:UIControlStateNormal];
        [self.btnReply setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.btnReply];
        
        __weak __typeof(self)weakSelf=self;
        
        [self.headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.mas_equalTo(15);
            make.width.height.mas_equalTo(40);
            make.right.equalTo(weakSelf.lblTitle.mas_left).offset(-15);
        }];
        [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(weakSelf.headerImgView.mas_right).offset(15);
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-15);
            make.centerY.equalTo(weakSelf.headerImgView);
            make.bottom.equalTo(weakSelf.lblContent.mas_top).offset(-15);
        }];
        [self.lblContent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.equalTo(weakSelf.lblTitle);
            make.top.equalTo(weakSelf.lblTitle.mas_bottom).offset(15);
            make.bottom.equalTo(weakSelf.imgsView.mas_top).offset(-35);
            
        }];
        [self.imgsView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf.lblContent.mas_bottom).offset(35);
            make.left.equalTo(weakSelf.contentView.mas_left).offset(15);
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-15);
            make.bottom.equalTo(weakSelf.commentTable.mas_top).offset(-10);
            make.height.equalTo(@110);
            
        }];
        [self.commentTable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.imgsView.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.contentView.mas_left).offset(15);
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-15);
            make.bottom.equalTo(weakSelf.txtInput.mas_top).offset(-10);
        }];
        
        [self.txtInput mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf.commentTable.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.commentTable.mas_left);
            make.right.equalTo(weakSelf.btnEmtion.mas_left).offset(-5);
            make.height.equalTo(@35);
        }];
        [self.btnEmtion mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.equalTo(weakSelf.txtInput);
            make.left.equalTo(weakSelf.txtInput.mas_right).offset(5);
            make.width.equalTo(@40);
            make.right.equalTo(weakSelf.btnReply.mas_left).offset(-5);
        }];
        [self.btnReply mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.equalTo(weakSelf.txtInput);
            make.left.equalTo(weakSelf.btnEmtion.mas_right).offset(5);
            make.width.equalTo(@60);
            make.right.equalTo(weakSelf.commentTable.mas_right);
        }];
        self.imgAry=[NSMutableArray array];
        for(int i=0;i<3;i++)
        {
            UIImageView *img=[UIImageView new];
            img.contentMode=UIViewContentModeScaleAspectFit;
            img.image=[UIImage imageNamed:@"sugar"];
            [self.imgAry addObject:img];
            [self.imgsView addSubview:img];
        }
        for(UIImageView *img in self.imgAry)
        {
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.equalTo(weakSelf.imgsView);
            }];
        }
        
        [self.imgAry mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:225 leadSpacing:5 tailSpacing:5];
        
        self.commentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        UIView *line=[[UIView alloc]init];
        line.backgroundColor=[UIColor colorWithRed:175.0f/255 green:171.0f/255 blue:179.0f/255 alpha:1];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.bottom.equalTo(self.contentView);
            make.height.equalTo(@1);
        }];
        
        
        self.hyb_bottomOffsetToCell=5;
        
        return self;
    }
    return nil;
}
-(void)configCell:(ContentInfo *)content withIndexPath:(NSIndexPath *)indexPath
{
    
    
    self.indexPath=indexPath;
    self.lblContent.text=content.desc;
    self.lblTitle.text=content.title;
    self.info=content;
    
    CGFloat commentTableHight=0;
    for(CommentInfo *comment in content.comments)
    {
        CGFloat cellH=[CommentTableViewCell hyb_heightForTableView:self.commentTable config:^(UITableViewCell *sourceCell) {
            CommentTableViewCell *cell=(CommentTableViewCell*)sourceCell;
            [cell configCellWithModel:comment];
        } cache:^NSDictionary *{
            
            return @{kHYBCacheUniqueKey : comment.cid,
                     kHYBCacheStateKey :comment.cid,
                     kHYBRecalculateForStateKey : @(NO)};
            
        }];
        commentTableHight+=cellH;
    }
    
    [self.commentTable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(commentTableHight);
    }];
    self.commentTable.dataSource = self;
    self.commentTable.delegate = self;
    [self.commentTable reloadData];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.info.comments.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentInfo *model = [self.info.comments objectAtIndex:indexPath.row];
    
    return [CommentTableViewCell hyb_heightForTableView:self.commentTable config:^(UITableViewCell *sourceCell) {
        CommentTableViewCell *cell = (CommentTableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    } cache:^NSDictionary *{
        return @{kHYBCacheUniqueKey : model.cid,
                 kHYBCacheStateKey : model.cid,
                 kHYBRecalculateForStateKey : @(NO)};
    }];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:kCommentTableViewCell];
    if(cell==nil)
    {
        cell=[[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCommentTableViewCell];
    }
    CommentInfo *comment=self.info.comments[indexPath.row];
    [cell configCellWithModel:comment];
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.info.comments removeObjectAtIndex:indexPath.row];
        
        if(_updateBlock)
        {
            _updateBlock(YES,self.indexPath);
        }
    }
}

// 懒加载键盘
- (YZEmotionKeyboard *)emotionKeyboard
{
    // 创建表情键盘
    if (_emotionKeyboard == nil) {
        
        YZEmotionKeyboard *emotionKeyboard = [YZEmotionKeyboard emotionKeyboard];
        __weak typeof(self)weakSelf=self;
        emotionKeyboard.sendContent = ^(NSAttributedString *content){
            
            weakSelf.txtInput.attributedText=content;
        };
        
        _emotionKeyboard = emotionKeyboard;
    }
    return _emotionKeyboard;
}
#pragma mark 表情键盘和文字键盘的切换
-(void)clickEmtionKeyboard
{
    if (self.txtInput.inputView == nil) {
        self.txtInput.yz_emotionKeyboard=self.emotionKeyboard;
        [self.btnEmtion setBackgroundImage:[UIImage imageNamed:@"toolbar-text"] forState:UIControlStateNormal];
    } else {
        self.txtInput.inputView = nil;
        [self.txtInput reloadInputViews];
        [self.btnEmtion setBackgroundImage:[UIImage imageNamed:@"smail"] forState:UIControlStateNormal];
    }
    
   
}
-(void)addComent
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"kGetMsg" object:nil];
    
    [self.txtInput resignFirstResponder];
    [self endEditing:YES];
    
    // 添加一条数据
    CommentInfo *model = [[CommentInfo alloc] init];
    model.name = @"asap";
    model.reply = @"sugar";
    model.comment =self.txtInput.attributedText;
   
    if(model.comment.length<=0)
    {
        model.comment=[[NSAttributedString alloc]initWithString:@"I'm hurting, baby, I'm broken down I need your loving, loving, I need it now When I'm without you I'm something weak You got me begging Begging, I'm on my knees I don't wanna be needing your love I just wanna be deep in your love And it's killing me when you're away Ooh, baby,'Cause I really don't care where you are I just wanna be there where you are And I gotta get one little taste Your sugar Yes, please"];
    }
    model.cid = [NSString stringWithFormat:@"commonModel%ld",  self.info.comments.count + 1];
    
    [self.info.comments addObject:model];
    
    if(_updateBlock)
    {
        _updateBlock(YES,self.indexPath);
    }
    
    self.txtInput.text=nil;
    
}
@end
