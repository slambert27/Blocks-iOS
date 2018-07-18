//
//  BoxGrid.h
//  Blocks
//
//  Created by Sam Lambert on 4/11/17.
//  Copyright © 2017 Sam Lambert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Box.h"
#import "Block.h"

@interface BoxGrid : NSObject

// grid array
@property NSMutableArray *grid;

@property CGRect screenSize;
@property float screenWidth;
@property float screenHeight;

//game view
@property UIView* gameView;

// lists of full rows and columns for clearing
@property NSMutableArray *fullRows;
@property NSMutableArray *fullColumns;
@property int numberFull;

// init with game view to apply images
- (id)initWithView:(UIView*)gameView;

// make box blocked
- (void)addBlack:(int)col :(int)row;

- (void)addBlocks:(int)col :(int)row :(NSString*)color;

- (void)removeBlocks:(int)col :(int)row;

// checks for full lines and adds to full lists for clearing
- (void)checkFullLines;

// clears rows and columns once they're full
- (int)clearLines;

// adds block of color to grid, returns true if black block for stats keeping
- (bool)addBlockToGrid:(Block *)block :(int)score;

// checks fit for user placement
- (bool)checkFit:(Block *)block;

// looks for space on board for next piece between each turn
- (bool) findSpace:(Block *)block;

- (bool) checkForEmptyBoard;

@end
