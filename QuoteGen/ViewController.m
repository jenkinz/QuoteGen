//
//  ViewController.m
//  QuoteGen
//
//  Created by Brian Jenkins on 8/25/12.
//  Copyright (c) 2012 Brian Jenkins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize myQuotes;
@synthesize movieQuotes;
@synthesize quote_text;
@synthesize quote_opt;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.myQuotes = [NSArray arrayWithObjects:
                        @"Live and let live",
                        @"Don't cry over spilled milk",
                        @"Testing a \"quote\" dude!",
                        @"As Steve Kurek always says, \"It's not a wedding until a penis comes out!\"",
                        nil];
    
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"Quotes" ofType:@"plist"];
    
    self.movieQuotes = [[NSMutableArray arrayWithContentsOfFile:plistCatPath] copy];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.myQuotes = nil;
    self.movieQuotes = nil;
    self.quote_text = nil;
    self.quote_opt = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(IBAction)quote_btn_touch:(id)sender
{
    if (self.quote_opt.selectedSegmentIndex == 2) {
        // Random "My" quote
        int numQuotes = [self.myQuotes count],
            randIdx = (arc4random() % numQuotes);

        NSString *myQuote = [self.myQuotes objectAtIndex:randIdx];
        
        self.quote_text.text = [NSString stringWithFormat:@"Random \"My\" Quote:\n\n%@", myQuote];
    }
    else {
        // Movie Quote
        NSString *selCat = @"classic";
        if (self.quote_opt.selectedSegmentIndex == 1) {
            selCat = @"modern";
        }
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@", selCat];
        NSArray *filteredArr = [self.movieQuotes filteredArrayUsingPredicate:predicate];
        
        int numMovieQuotes = [filteredArr count];
        
        if (numMovieQuotes > 0) {
            int randIdxMovie = (arc4random() % numMovieQuotes);
        
            NSString *movieQuote = [[self.movieQuotes objectAtIndex:randIdxMovie] valueForKey:@"quote"];
        
            self.quote_text.text = [NSString stringWithFormat:@"Random %@ Movie Quote:\n\n%@", selCat, movieQuote];
        }
        else {
            self.quote_text.text = [NSString stringWithFormat:@"No quotes to display :("];
        }
    }
}

@end
