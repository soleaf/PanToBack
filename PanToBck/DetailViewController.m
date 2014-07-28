//
//  DetailViewController.m
//  PanToBck
//
//  Created by soleaf on 13. 11. 7..
//  Copyright (c) 2013년 soleaf. All rights reserved.
//

#import "DetailViewController.h"
#import "PanToBack.h"

@interface DetailViewController () <PanTobackDelegate>
{
    PanToBack *backer;
}

- (void)configureView;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    backer = [[PanToBack alloc] init];
    [backer linkView:self.view];
    backer.delegate = self;
    backer.isDissabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)panToBankAbleViewOn:(CGPoint)point
{
    if (point.x < 320 && point.y < 200){
        NSLog(@"DO NOT USE IN %f.%f",point.x, point.y);
        return NO;
    }
    else return YES;
}

@end
