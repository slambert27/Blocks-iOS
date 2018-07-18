//
//  GamePlayController.h
//  Blocks
//
//  Created by Sam Lambert on 4/5/17.
//  Copyright © 2017 Sam Lambert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Box.h"
#import "BoxGrid.h"
#import "Block.h"

@interface GamePlayController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *gameView;

@property CGRect screenSize;
@property float screenWidth;
@property float screenHeight;

@property BoxGrid *gameGrid;

// quit actions
- (IBAction)quitButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *quitSure;
- (IBAction)quitYes:(id)sender;
- (IBAction)quitNo:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *GameOver;

@property NSTimer* GameOverTimer;

- (void) dismissGame;

@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property int score;

@property (strong, nonatomic) IBOutlet UIImageView *block;

@property (strong, nonatomic) IBOutlet UIImageView *block2;

@property Block *nextBlock;

@property Block *laterBlock;

// original location of block0
@property CGPoint origLoc;

// point user places block
@property CGPoint userPlace;

- (IBAction)rotateClockwise:(UIButton *)sender;

- (IBAction)moveBlock:(UIPanGestureRecognizer *)sender;

- (NSString*)getRandomColor;

@end
