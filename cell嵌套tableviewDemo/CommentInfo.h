#import <Foundation/Foundation.h>

@interface CommentInfo : NSObject
@property (nonatomic,copy)NSString *cid,*name,*reply;
@property (nonatomic,copy)NSAttributedString *comment;
@end
