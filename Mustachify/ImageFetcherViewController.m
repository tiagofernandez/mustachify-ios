#import "ImageFetcherViewController.h"
#import "ImageDisplayViewController.h"
#import "ImageFetcher.h"

@implementation ImageFetcherViewController

@synthesize searchField;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  NSString *query = self.searchField.text;
  
  if (![query isEqualToString:@""]) {
    NSString *imageURL = [ImageFetcher imageURLForQuery:query];

    ImageDisplayViewController *destinationVC = segue.destinationViewController;
    destinationVC.title    = query;
    destinationVC.imageURL = imageURL;
  }
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.searchField becomeFirstResponder];
}

- (void)viewDidUnload
{
  self.searchField = nil;
  [super viewDidUnload];
}

@end
