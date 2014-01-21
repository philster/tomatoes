//
//  Movie.m
//  tomatoes
//
//  Created by Phil Wee on 1/21/14.
//  Copyright (c) 2014 Philster. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.title = [dictionary objectForKey:@"title"];
        self.synopsis = [dictionary objectForKey:@"synopsis"];
        self.cast = [self castNames:[dictionary objectForKey:@"abridged_cast"]];
        self.image = [[dictionary objectForKey:@"posters"] objectForKey:@"original"];
    }
    return self;
}

- (NSString *)castNames:(NSDictionary *)castList
{
    NSMutableArray *castNames = [NSMutableArray array];
    for (NSDictionary *castMember in castList) {
        [castNames addObject:[castMember objectForKey:@"name"]];
    }
    return [castNames componentsJoinedByString:@", "];
}

@end
