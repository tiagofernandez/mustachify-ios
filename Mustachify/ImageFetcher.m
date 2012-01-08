#import "ImageFetcher.h"
#import "AFHTTPRequestOperation.h"
#import "JSONKit.h"
#import "SVProgressHUD.h"

#include <stdio.h>

@implementation ImageFetcher

+ (NSString *)searchURLforQuery:(NSString *)query
{
  NSString *baseURL = @"http://ajax.googleapis.com/ajax/services/search/images?v=1.0&rsz=1&start=%d&q=%@";
  NSString *encodedQuery = [query stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
  return [NSString stringWithFormat:baseURL, random() % 10, encodedQuery];
}

+ (NSString *)imageURLForQuery:(NSString *)query
{
  NSString *searchURL = [self searchURLforQuery:query];
  
  NSString *jsonResponse = [NSString stringWithContentsOfURL:[NSURL URLWithString:searchURL]
                                                    encoding:NSASCIIStringEncoding
                                                       error:nil];
  
  NSLog(@"Parsing JSON response: %@", jsonResponse);
  
  NSDictionary *json = [jsonResponse objectFromJSONString];
  
  return [[[[json objectForKey:@"responseData"] objectForKey:@"results"] objectAtIndex:0] objectForKey:@"unescapedUrl"];
}

+ (void)loadImage:(NSString *)imageURL
         intoView:(UIImageView *)imageView
{
  if (!imageURL) return;
  
  NSLog(@"Fetching image from URL: %@", imageURL);

  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
  
  AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
  AFHTTPRequestOperation * __weak theOperation = operation;

  [SVProgressHUD showWithStatus:@"Please wait"];
    
  [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    if (theOperation) {
      [imageView setImage:[UIImage imageWithData:theOperation.responseData]];
      [imageView setNeedsDisplay];
      [SVProgressHUD dismiss];
    }
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    if (theOperation) {
      [SVProgressHUD dismissWithError:@"Network error"];
    }
  }];
  
  [operation start];
}

@end
