#import <UIKit/UIKit.h>
@class ContentInfo;

static NSString *kContentTableViewCell=@"ContentTableViewCell";

@interface ContentTableViewCell : UITableViewCell
@property (nonatomic,copy)void(^updateBlock)(BOOL isUpdate,NSIndexPath *indexPath);

-(void)configCell:(ContentInfo*)content withIndexPath:(NSIndexPath*)indexPath;

@end
