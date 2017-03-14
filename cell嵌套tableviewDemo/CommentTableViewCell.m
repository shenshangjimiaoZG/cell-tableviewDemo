#import "CommentTableViewCell.h"
#import "CommentInfo.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import <Masonry/Masonry.h>

@interface CommentTableViewCell ()
@property (nonatomic,strong)UILabel *lblDesc;
@end

@implementation CommentTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.lblDesc=[UILabel new];
        self.lblDesc.text=@"sugar";
        self.lblDesc.font=[UIFont systemFontOfSize:14];
        self.lblDesc.textColor=[UIColor darkGrayColor];
        [self.contentView addSubview:self.lblDesc];
        
        [self.lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.edges.mas_equalTo(self.contentView);
        }];

        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return self;
    }
    
    return nil;
}
-(void)configCellWithModel:(CommentInfo *)comment
{
    NSString *str = [NSString stringWithFormat:@"%@回复%@：%@",
                     comment.name, comment.reply, comment.comment];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor orangeColor]
                 range:NSMakeRange(0, comment.name.length)];
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor orangeColor]
                 range:NSMakeRange(comment.name.length + 2, comment.reply.length)];
    self.lblDesc.attributedText = text;
}
@end
