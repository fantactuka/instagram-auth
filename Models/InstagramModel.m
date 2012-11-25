//
//  InstagramModel.m
//  Instagram
//
//  Created by Stuart Hall on 30/11/11.
//

#import "InstagramModel.h"

@implementation InstagramModel

@synthesize dictionary;

+ (InstagramModel *)modelWithDictionary:(NSDictionary *)modelDictionary {
    InstagramModel *model = [[[self class] alloc] init];
    model.dictionary = modelDictionary;
    return model;
}

+ (NSArray *)modelsFromDictionaries:(NSArray *)modelDictionaries {
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:[modelDictionaries count]];
    for (NSDictionary *userDict in modelDictionaries) {
        [models addObject:[self modelWithDictionary:userDict]];
    }

    return models;
}

@end
