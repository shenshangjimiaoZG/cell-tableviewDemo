#import <Foundation/Foundation.h>
@class CommentInfo;
@interface ContentInfo : NSObject
@property (nonatomic,copy)NSString *uid,*title,*desc,*headerImg;
@property (nonatomic,strong)NSMutableArray<CommentInfo *> *comments;
@property (nonatomic,assign)BOOL isUpdateCacheCell_hight;
@end
