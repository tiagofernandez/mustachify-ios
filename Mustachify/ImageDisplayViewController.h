#import <UIKit/UIKit.h>

@interface ImageDisplayViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSString *imageURL;

- (IBAction)processImage:(id)sender;

@end
