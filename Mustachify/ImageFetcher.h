#import <Foundation/Foundation.h>

@interface ImageFetcher : NSObject

+ (NSString *)imageURLForQuery:(NSString *)query;

+ (void)loadImage:(NSString *)imageURL
         intoView:(UIImageView *)imageView;

@end
