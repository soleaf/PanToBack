PanToBack
=========

Panning To Back Naivigating in  iOS App


![screenshot](screenshot.gif)

Use
========

0. Copy files in 'src' to your project. And import header.

1. Initation

```objective-c
    PanToBack *backer = [[PanToBack alloc] init];
    [backer linkView:self.view];
    backer.delegate = self;
    backer.isDissabled = NO;
```

2. Delegate

REQUIRED
```objective-c
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
```

OPTIONAL : Define Disable some Areas
- (BOOL)panToBankAbleViewOn:(CGPoint)point
{
    if (point.x < 320 && point.y < 200){
        NSLog(@"DO NOT USE IN %f.%f",point.x, point.y);
        return NO;
    }
    else return YES;
}
