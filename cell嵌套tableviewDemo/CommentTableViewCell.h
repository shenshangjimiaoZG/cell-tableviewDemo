#import <UIKit/UIKit.h>
@class CommentInfo;
static NSString *kCommentTableViewCell=@"CommentTableViewCell";
@interface CommentTableViewCell : UITableViewCell
- (void)configCellWithModel:(CommentInfo *)comment;
@end
