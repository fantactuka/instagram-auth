//
//  InstagramAuthViewController.h
//  InstaAuthTry
//
//  Created by Maksim Horbachevsky on 11/24/12.
//  Copyright (c) 2012 Maksim Horbachevsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstagramAuthDelegate.h"

@interface InstagramAuthViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, weak) id <InstagramAuthDelegate> instagramAuthDelegate;

@end
