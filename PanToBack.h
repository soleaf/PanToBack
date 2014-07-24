//
//  SwipeToBack.h
//  travelogue
//
//  Created by soleaf on 13. 11. 7..
//  Copyright (c) 2013년 soleaf. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 In UIViewcontroller with UINavigationViewController,
 Use gesture to pop viewcontroller.
 
 https://github.com/soleaf/PanToBack
 */

@protocol PanTobackDelegate <NSObject>

-(void)back;

@end

@interface PanToBack : NSObject

@property UILabel *ui_backIndicator;

@property NSString *backText;
@property BOOL isDissabled;
@property id<PanTobackDelegate> delegate;

-(void)linkView:(UIView *)newTargetView;

@end
