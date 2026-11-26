#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImGuiLoad : NSObject
+ (instancetype)share;
- (void)show;
- (void)initTapGes;
- (void)autoOpenWhenReady;
@end

NS_ASSUME_NONNULL_END
