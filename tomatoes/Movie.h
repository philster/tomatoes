//
//  Movie.h
//  tomatoes
//
//  Created by Phil Wee on 1/21/14.
//  Copyright (c) 2014 Philster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, strong) NSString *cast;
@property (nonatomic, strong) NSString *image;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
