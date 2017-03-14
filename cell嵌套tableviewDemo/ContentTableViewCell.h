#import <UIKit/UIKit.h>
@class ContentInfo;

@protocol ContentTableViewCellDelegate <NSObject>

-(void)reloadCellHeightForModel:(ContentInfo*)content atIndexPath:(NSIndexPath*)indexPath;

@end

static NSString *kContentTableViewCell=@"ContentTableViewCell";

@interface ContentTableViewCell : UITableViewCell
@property (nonatomic,assign)id<ContentTableViewCellDelegate> delegate;
-(void)configCell:(ContentInfo*)content withIndexPath:(NSIndexPath*)indexPath;
@end
