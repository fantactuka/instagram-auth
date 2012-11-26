//
//  InstagramAuthViewController.m
//  InstaAuthTry
//
//  Created by Maksim Horbachevsky on 11/24/12.
//  Copyright (c) 2012 Maksim Horbachevsky. All rights reserved.
//

#import "InstagramAuthViewController.h"
#import "InstagramAuthConfig.h"
#import "NSString+QueryString.h"

@interface InstagramAuthViewController ()
@end

@implementation InstagramAuthViewController

@synthesize instagramAuthDelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self validateInstagramAuthConfig];
    [self setupInstagramAuthWebView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *url = [[request URL] absoluteString];

    if ([url hasPrefix:kInstagramAuthRedirectUrl]) {
        NSRange tokenRange = [[url lowercaseString] rangeOfString:@"#access_token="];

        if (tokenRange.location != NSNotFound) {
            NSString *token = [url substringFromIndex:tokenRange.location + tokenRange.length];
            if (instagramAuthDelegate) {
                [instagramAuthDelegate instagramAuthSucceeded:token];
            }
        }
        else {
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

- (void) setupInstagramAuthWebView {
    UIWebView *instagramAuthWebView = [[UIWebView alloc] initWithFrame:self.view.frame];
    instagramAuthWebView.delegate = self;
    [self.view addSubview:instagramAuthWebView];

    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token", kInstagramAuthClientId, kInstagramAuthRedirectUrl];
    [instagramAuthWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void) validateInstagramAuthConfig {
    if (
            [kInstagramAuthRedirectUrl length] == 0 ||
            [kInstagramAuthClientId length] == 0 ||
            [kInstagramAuthClientSecret length] == 0) {
        [NSException raise:@"kInstagramAuth* constants could not be empty. See InstagramAuthConfig.h file to setup Instagram constants." format:@""];
    }
}

@end
