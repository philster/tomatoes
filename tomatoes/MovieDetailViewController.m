//
//  MovieDetailViewController.m
//  tomatoes
//
//  Created by Phil Wee on 1/21/14.
//  Copyright (c) 2014 Philster. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "Movie.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = self.movie.title;
    self.castLabel.text = self.movie.cast;
    self.synopsisLabel.text = self.movie.synopsis;
    NSURL *url = [[NSURL alloc] initWithString:self.movie.image];
    [self.movieImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

- (IBAction)closeButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
