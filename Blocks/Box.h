//
//  Box.h
//  Blocks
//
//  Created by Sam Lambert on 4/11/17.
//  Copyright © 2017 Sam Lambert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Box : NSObject

@property CGPoint point;
@property bool empty;
@property bool blocked;
@property UIImageView* blockImage;

// initialize box at point with blank image
- (id)initWithPoint:(CGPoint)aPoint :(UIView*)gameView;

// returns empty value
- (bool)isEmpty;

// returns blocked value
- (bool)isBlocked;

// sets empty value to true and blocked value to false
- (void) makeEmpty;

// sets empty value to false and blocked value to true
- (void) makeBlocked;

// sets empty value to false
- (void) makeFull:(NSString*)color;

- (CGPoint) getPoint;

@end
