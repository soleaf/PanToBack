//
//  SwipeToBack.m
//  travelogue
//
//  Created by soleaf on 13. 11. 7..
//  Copyright (c) 2013년 soleaf. All rights reserved.
//

#import "PanToBack.h"

@interface PanToBack () <UIGestureRecognizerDelegate>
{
    UIPanGestureRecognizer *panGestureRec;
    UIView *targetView;
    
    BOOL backSwipeReversed;
    CGFloat backSwipeBegan;
}

@end

@implementation PanToBack


#pragma mark - Init

-(void)linkView:(UIView *)newTargetView;
{
    targetView = newTargetView;;
    panGestureRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGestureRec.delegate = self;
    [newTargetView addGestureRecognizer:panGestureRec];

    
    if (!self.backText) self.backText = @"Back";
    self.backText = self.backText;
    
    [self makeBackIndicator];
}

-(void) makeBackIndicator
{
    if (self.ui_backIndicator) return;
    
    // Indicator Make
    self.ui_backIndicator = [[UILabel alloc] initWithFrame:CGRectMake(-80, 0, 80, 80)];
    self.ui_backIndicator.font = [UIFont boldSystemFontOfSize:17];
    self.ui_backIndicator.textColor = [UIColor whiteColor];
    self.ui_backIndicator.textAlignment = NSTextAlignmentCenter;
    self.ui_backIndicator.text = self.backText;
    
    float statusbarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    [self move:self.ui_backIndicator
           toY:((targetView.frame.size.height/2) - (self.ui_backIndicator.frame.size.height/2)-statusbarHeight)];
    
    self.ui_backIndicator.layer.cornerRadius = self.ui_backIndicator.frame.size.width/2;
    [targetView addSubview:self.ui_backIndicator];
}


#pragma mark - Gesture
- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture //Your action method
{
    if (self.isDissabled) return;
    self.ui_backIndicator.alpha = 1.;
    
    float center = targetView.frame.size.width/2 - self.ui_backIndicator.frame.size.width/2;
    switch(panGesture.state) {
        case UIGestureRecognizerStateChanged:
        {
            if (self.ui_backIndicator.frame.origin.x == -80 && [panGesture velocityInView:targetView].x  <=0) return;
            
            /*
             Define Backer Location
             */
            
            float moveTo = 0;
            // Direction ->
            if ([panGesture velocityInView:targetView].x >= 0 && !backSwipeReversed){
                moveTo = [panGesture locationInView:targetView].x - backSwipeBegan - 80;
            }
            // Direction <-
            else{
                moveTo = [panGesture locationInView:targetView].x;
                backSwipeReversed = YES;
            }
            
            /*
             Animation
             */
            
            // Arrived to center
            if (moveTo > center){

                [UIView animateWithDuration:0.3 animations:^{
                    [self move:self.ui_backIndicator toX:center];
                }];
                
                self.ui_backIndicator.backgroundColor = [UIColor colorWithRed:1.00 green:0.47 blue:0.00 alpha:0.8];
            }
            // Moving...
            else{
                
                [UIView animateWithDuration:0.3 animations:^{
                    [self move:self.ui_backIndicator toX:moveTo];
                }];
                
                self.ui_backIndicator.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:0.8];
            }
        }
        case UIGestureRecognizerStateBegan:
            // Saving Begin position
            if (backSwipeBegan <= 0)
                backSwipeBegan = [panGesture locationInView:targetView].x;
            break;
        case UIGestureRecognizerStateEnded:{
            
            backSwipeBegan = 0;
            backSwipeReversed = NO;
            
            // Action!
            if (self.ui_backIndicator.frame.origin.x >= center){
                
                [self back];
                
            }
            // Canceled
            else{
                [UIView animateWithDuration:.3 animations:^{
                    [self move:self.ui_backIndicator toX:-80];
                } completion:^(BOOL finished) {
                    [self move:self.ui_backIndicator toX:-80];
                }];
                
            }
            
        }
            break;
        default:
            break;
    }
}


#pragma mark - Assist for moving UIView
- (void) move:(UIView*)view toX:(CGFloat)x
{
    CGRect frame = view.frame;
    frame.origin.x = x;
    
    view.frame = frame;
}

- (void) move:(UIView*)view toY:(CGFloat)y
{
    CGRect frame = view.frame;
    frame.origin.y = y;
    
    view.frame = frame;
}


#pragma mark - Action
- (void) back
{
    [self.delegate back];
}


@end
