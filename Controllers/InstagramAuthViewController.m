//
//  InstagramAuthViewController.m
//  InstaAuthTry
//
//  Created by Maksim Horbachevsky on 11/24/12.
//  Copyright (c) 2012 Maksim Horbachevsky. All rights reserved.
//

#import "InstagramAuthViewController.h"
#import "ApiKey.h"
#import "NSString+QueryString.h"

@interface InstagramAuthViewController ()
@end

@implementation InstagramAuthViewController

@synthesize authWebView, instagramAuthDelegate;

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIWebView *instagramAuthWebView = [[UIWebView alloc] initWithFrame:frame];
    instagramAuthWebView.delegate = self;
    [self.view addSubview: instagramAuthWebView];

    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token", INSTAGRAM_CLIENT_ID, INSTAGRAM_CALLBACK_BASE];
    [instagramAuthWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *url = [[request URL] absoluteString];

    if ([url hasPrefix:INSTAGRAM_CALLBACK_BASE]) {
        // Extract the token
        NSRange tokenRange = [[url lowercaseString] rangeOfString:@"#access_token="];
        if (tokenRange.location != NSNotFound) {
            NSString *token = [url substringFromIndex:tokenRange.location + tokenRange.length];
            if (instagramAuthDelegate) {
                [instagramAuthDelegate instagramAuthSucceeded:token];
            }
        }
        else {
            // Error, should be something like: error_reason=user_denied&error=access_denied&error_description=The+user+denied+your+request
            NSDictionary *params = [url dictionaryFromQueryComponents];
            if (instagramAuthDelegate) {
                [instagramAuthDelegate instagramAuthFailed:[params objectForKey:@"error"]
                                               errorReason:[params objectForKey:@"error_reason"]
                                          errorDescription:[params objectForKey:@"error_description"]];
            }
        }

        return NO;
    }

    return YES;
}

@end
