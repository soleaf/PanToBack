//
//  DetailViewController.h
//  PanToBck
//
//  Created by soleaf on 13. 11. 7..
//  Copyright (c) 2013년 soleaf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
