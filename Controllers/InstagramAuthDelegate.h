//
// Created by Maksim Horbachevsky on 11/24/12.
// All rights reserved
//

@protocol InstagramAuthDelegate <NSObject>
- (void)instagramAuthLoadFailed:(NSError *)error;

- (void)instagramAuthSucceeded:(NSString *)token;

- (void)instagramAuthFailed:(NSString *)error
                errorReason:(NSString *)errorReason
           errorDescription:(NSString *)errorMessage;
@end
