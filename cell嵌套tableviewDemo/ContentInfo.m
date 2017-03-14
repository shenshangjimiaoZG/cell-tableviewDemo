#import "ContentInfo.h"
#import "CommentInfo.h"

@implementation ContentInfo

-(NSMutableArray<CommentInfo *> *)comments
{
    if (_comments == nil) {
        _comments = [[NSMutableArray alloc] init];
    }
    
    return _comments;

}
@end
