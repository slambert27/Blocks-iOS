//
//  Box.m
//  Blocks
//
//  Created by Sam Lambert on 4/11/17.
//  Copyright © 2017 Sam Lambert. All rights reserved.
//

#import "Box.h"

@implementation Box

// initialize box object at given point with blank image, initialize empty as true and blocked as false
- (id)initWithPoint:(CGPoint)aPoint :(UIView *)gameView {
    //rypress.com/tutorials/objective-c/classes
    self = [super init];
    if (self) {
        _empty = true;
        _blocked = false;
        _point = aPoint;
        // sets up image for each block, initially gray to look blank, Box image changes to block color
            //when block is placed, rather than placing a new UIImage for each block
        _blockImage = [[UIImageView alloc] initWithFrame:CGRectMake(aPoint.x - 18, aPoint.y - 18, 37, 37)];
        
        _blockImage.image = [UIImage imageNamed:@"blank.png"];

        [gameView addSubview:_blockImage];
    }
    
    return self;
}

- (bool)isEmpty {
    return _empty;
}

- (bool)isBlocked {
    return _blocked;
}

- (void)makeEmpty {
    _empty = true;
    _blocked = false;
    // reset to blank box
    _blockImage.image = [UIImage imageNamed:@"blank.png"];
}

- (void)makeBlocked {
    _empty = false;
    _blocked = true;
    
    _blockImage.image = [UIImage imageNamed:@"black.png"];
}

- (void)makeFull:(NSString *)color{
    _empty = false;
    _blockImage.image = [UIImage imageNamed:[color stringByAppendingString:@".png"]];
}

- (CGPoint)getPoint {
    return _point;
}

@end
