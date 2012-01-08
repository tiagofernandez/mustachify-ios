#import "ImageDisplayViewController.h"
#import "ImageFetcher.h"

@implementation ImageDisplayViewController

@synthesize imageView;
@synthesize imageURL;

- (void)viewDidUnload
{
  self.imageView = nil;
  [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [ImageFetcher loadImage:self.imageURL intoView:self.imageView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)inScroll
{
  return self.imageView;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)processImage:(id)sender
{
  NSString *url = [NSString stringWithFormat:@"http://mustachify.me/?src=%@", self.imageURL];
  [ImageFetcher loadImage:url intoView:self.imageView];
}

@end
