#import "CommentTableViewCell.h"
#import "CommentInfo.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import <Masonry/Masonry.h>
#import "YZTextAttachment.h"

@interface CommentTableViewCell ()
@property (nonatomic,strong)UILabel *lblDesc;
@end

@implementation CommentTableViewCell
// 获取表情字符串
- (void)emotionText_desc
{
    
    NSMutableString *strM = [NSMutableString string];
    
    [_lblDesc.attributedText enumerateAttributesInRange:NSMakeRange(0, _lblDesc.attributedText.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        NSString *str = nil;
        
        YZTextAttachment *attachment = attrs[@"NSAttachment"];
        
        if (attachment) { // 表情
            str = attachment.emotionStr;
         
            NSString  *imageName = [NSString stringWithFormat:@"Emotion.bundle/%@",str];

            NSLog(@"表情图片 %@",imageName);
        } else { // 文字
            str = [_lblDesc.attributedText.string substringWithRange:range];
            [strM appendString:str];
        }
        
    }];
   
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.lblDesc=[UILabel new];
        self.lblDesc.numberOfLines=0;
        self.lblDesc.font=[UIFont systemFontOfSize:13];
        self.lblDesc.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:self.lblDesc];
        
        [self.lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.size.equalTo(self.contentView);
            make.center.equalTo(self.contentView);
        }];

        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        self.hyb_bottomOffsetToCell=5;
       
        return self;
    }
    
    return nil;
}
-(void)configCellWithModel:(CommentInfo *)comment
{
    NSString *str = [NSString stringWithFormat:@"%@回复%@：",
                     comment.name, comment.reply];
    NSMutableAttributedString *desc=[[NSMutableAttributedString alloc]initWithString:str];
    [desc appendAttributedString:comment.comment];
   
    [desc addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(0, desc.length)];
    [desc addAttribute:NSForegroundColorAttributeName
                 value:[UIColor orangeColor]
                 range:NSMakeRange(0, comment.name.length)];
    [desc addAttribute:NSForegroundColorAttributeName
                 value:[UIColor orangeColor]
                 range:NSMakeRange(comment.name.length + 2, comment.reply.length)];
    
     self.lblDesc.attributedText=desc;
    //[self emotionText_desc];
}
@end
