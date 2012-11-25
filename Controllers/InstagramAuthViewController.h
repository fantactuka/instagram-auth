//
//  InstagramAuthViewController.h
//  InstaAuthTry
//
//  Created by Maksim Horbachevsky on 11/24/12.
//  Copyright (c) 2012 Maksim Horbachevsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstagramAuthWebView.h"
#import "InstagramAuthDelegate.h"

@interface InstagramAuthViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet InstagramAuthWebView *authWebView;
@property (nonatomic, weak) id <InstagramAuthDelegate> instagramAuthDelegate;

@end
