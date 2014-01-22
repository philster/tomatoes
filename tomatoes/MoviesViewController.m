//
//  MoviesViewController.m
//  tomatoes
//
//  Created by Phil Wee on 1/20/14.
//  Copyright (c) 2014 Philster. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieDetailViewController.h"
#import "MovieCell.h"
#import "Movie.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"

@interface MoviesViewController ()

@property (nonatomic, strong) NSArray *movies;

- (void)reload;

@end

@implementation MoviesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"Movies";
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    [self reload];
}

#pragma mark - Table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCell"];

    Movie *movie = self.movies[indexPath.row];
    cell.movieTitleLabel.text = movie.title;
    cell.synopsisLabel.text = movie.synopsis;
    cell.castLabel.text = movie.cast;

    NSURL *url = [[NSURL alloc] initWithString:movie.image];
    [cell.movieImage setImageWithURL:url];

    return cell;
}

#pragma mark - Private methods

- (void)reload
{
    [self.refreshControl endRefreshing];
    [SVProgressHUD showWithStatus:@"Loading Movies"];
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        if (!connectionError && responseCode == 200) {
            // all is good, load the data
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            //NSLog(@"%@", object);
            
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *dictionary in [object objectForKey:@"movies"]) {
                [arr addObject:[[Movie alloc] initWithDictionary:dictionary]];
            }
            self.movies = arr;
            
            [self.tableView reloadData];

            [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1.0];
        }
        else {
            //show error message
            NSLog(@"connectionError=%@", connectionError);
            NSLog(@"responseCode=%d", responseCode);
            [SVProgressHUD showErrorWithStatus:@"Network Error"];
        }

    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *selectedCell = (UITableViewCell *)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedCell];
    Movie *movie = self.movies[indexPath.row];
    
    MovieDetailViewController *movieDetailViewController = (MovieDetailViewController *)segue.destinationViewController;
    movieDetailViewController.movie = movie;
}

@end
