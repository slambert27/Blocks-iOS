//
//  Block.h
//  Blocks
//
//  Created by Sam Lambert on 4/12/17.
//  Copyright © 2017 Sam Lambert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Box.h"

@interface Block : NSObject

@property NSString* color;

@property int score;

@property int width;

@property int height;

@property double orientation;

@property UIImageView* blockImage;

@property bool Next;

@property NSTimer *timer;

@property CGRect screenSize;
@property float screenWidth;
@property float screenHeight;

// hold values to multiply col and row to account for orientation
@property NSArray* coordinates;

// all possible coordinates for purposes of space finding
@property NSArray* coordinates1;
@property NSArray* coordinates2;
@property NSArray* coordinates3;
@property NSArray* coordinates4;

- (id)initWithColor:(NSString*)blockColor :(UIImageView*)image :(bool)next;

- (void) updateImage;

// used by initWithColor, changeColor to set width, height, score based on color
- (void)setColorVariables;

- (void)changeColorAndOrientation:(NSString*)blockColor :(double)orient;

@end
