//
//  GamePlayController.m
//  Blocks
//
//  Created by Sam Lambert on 4/5/17.
//  Copyright © 2017 Sam Lambert. All rights reserved.
//

#import "GamePlayController.h"
#import <tgmath.h>
#import "ViewController.h"
#import <CoreText/CoreText.h>

@interface GamePlayController ()

@end

@implementation GamePlayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _screenSize = [UIScreen mainScreen].bounds;
    _screenWidth = _screenSize.size.width;
    _screenHeight = _screenSize.size.height;
    
    // coordinates of waiting location for next block
    _origLoc = CGPointMake(_screenWidth / 2, _screenHeight * .77);
    
    // establish game grid
    _gameGrid = [[BoxGrid alloc] initWithView:self.view];
    [self.view bringSubviewToFront:_block];
    
    // initialize score
    
    _nextBlock = [[Block alloc] initWithColor:[self getRandomColor] :_block :true];
    
    _laterBlock = [[Block alloc] initWithColor:[self getRandomColor] :_block2 :false];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)quitButton:(id)sender {
    
    // on quit, if yes, return to main view and delete current game grid
    _quitSure.hidden = NO;
    [self.view bringSubviewToFront:_quitSure];
}

// rotate block
- (IBAction)rotateClockwise:(UIButton *)sender {
    
    if (![_nextBlock.color isEqualToString:@"multi"]) {
        double orient = _nextBlock.orientation - .5;
        if (orient == 0) {
            orient+=2;
        }
        [_nextBlock changeColorAndOrientation:_nextBlock.color :orient];
    }
}

- (IBAction)moveBlock:(UIPanGestureRecognizer *)sender {

    NSUserDefaults *scoreRecord = [NSUserDefaults standardUserDefaults];

    // allow user to move block
    CGPoint translation = [sender translationInView:self.view];
    sender.view.center = CGPointMake(sender.view.center.x + translation.x, sender.view.center.y + translation.y);
    [sender setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        // if block is placed outside grid, return it to original location
        if (_block.center.x < ((_screenWidth - 288)/2) || _block.center.y < _screenHeight*.13 || _block.center.x > _screenWidth - ((_screenWidth - 288)/2) || _block.center.y > _screenHeight*.13+288) {
            [UIImageView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{_block.center = _origLoc;} completion:nil];
        }
        
        // perform all turn-based operations (check for fit, add blocks to grid, clear lines, update score,
            // create new block, check for space for new block)
        else {
            
            // check for fit
            bool blockDoesFit = [_gameGrid checkFit:_nextBlock];
            
            if (blockDoesFit) {
                //fill appropriate boxes in grid based on block placement
                bool bomb = [_gameGrid addBlockToGrid:_nextBlock :_score];
                
                if (bomb) {
                    NSInteger bombscore = [scoreRecord integerForKey:@"bombsPlaced"];
                    [scoreRecord setInteger:bombscore+1 forKey:@"bombsPlaced"];
                    [scoreRecord synchronize];
                }
                
                // update score
                _score += _nextBlock.score;
                _scoreLabel.text = [NSString stringWithFormat:@"%d", _score];
                NSInteger blockscore = [scoreRecord integerForKey:@"blocksPlaced"];
                [scoreRecord setInteger:blockscore+1 forKey:@"blocksPlaced"];
                [scoreRecord synchronize];
                
                //put block back at origLoc, update color
                [_nextBlock changeColorAndOrientation:_laterBlock.color :_laterBlock.orientation];
                if ([_laterBlock.color isEqualToString:@"multi"]) {
                    [_laterBlock.timer invalidate];
                    _laterBlock.timer = nil;
                }
                [_laterBlock changeColorAndOrientation:[self getRandomColor] :2];
                
                int cleared = [_gameGrid clearLines];
                _score += 8*cleared;
                _scoreLabel.text = [NSString stringWithFormat:@"%d", _score];
                NSInteger rowClear = [scoreRecord integerForKey:@"rowsCleared"];
                [scoreRecord setInteger:rowClear+cleared forKey:@"rowsCleared"];
                [scoreRecord synchronize];

                if ([_gameGrid checkForEmptyBoard]) {
                    int clearScore = _score / 5;
                    if (clearScore > 100) {
                        clearScore = 100;
                    }
                    _score += clearScore;
                    _scoreLabel.text = [NSString stringWithFormat:@"%d", _score];
                    UILabel *clearLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 320, 300)];
                    clearLabel.text = [NSString stringWithFormat:@"+%d", clearScore];
                    clearLabel.textAlignment = NSTextAlignmentCenter;
                    clearLabel.textColor = [UIColor orangeColor];
                    [self.view addSubview:clearLabel];
                    
                    // stackoverflow.com
                    clearLabel.font = [UIFont fontWithName:@"Press Start 2P" size:70];
                    clearLabel.transform = CGAffineTransformScale(clearLabel.transform, 0.35, 0.35);
                    [UIView animateWithDuration:1.0 animations:^{
                        clearLabel.transform = CGAffineTransformScale(clearLabel.transform, 5, 5);
                    }];
                    [UIView animateWithDuration:1.5 animations:^{
                        clearLabel.alpha = 0;
                    }];
                    
                }
                else {
                    bool spaceLeft = [_gameGrid findSpace:_nextBlock];
                    if (!spaceLeft) {
                        //GAME OVER
                        _GameOver.hidden = NO;
                        [self.view bringSubviewToFront:_GameOver];
                        // wait 2 seconds then dismiss game
                        _GameOverTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(dismissGame) userInfo:nil repeats:NO];
                    }
                }
            }
            else {
                
                
                [UIImageView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{_block.center = _origLoc;} completion:nil];
                
                
            }
            
        }
    }
}

// returns random color string for random next block
- (NSString *)getRandomColor {
    
    NSString *returnColor;
    
 
    int multirand = arc4random() % 50;
    
    if (multirand == 25 && _score >= 300) {
        returnColor = @"multi";
    }
    
    else {
        NSMutableArray *colors = [[NSMutableArray alloc] initWithObjects:@"white", @"yellow", @"cyan", @"blue", @"pink", @"red", @"green", nil];
        int rand = arc4random() % 7;
        returnColor = colors[rand];
        colors = nil;
    }
    
    return returnColor;
}

- (IBAction)quitYes:(id)sender {
    _quitSure.hidden = YES;
    [self dismissGame];
}

- (IBAction)quitNo:(id)sender {
    _quitSure.hidden = YES;
}

- (void)dismissGame {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSUserDefaults *scoreRecord = [NSUserDefaults standardUserDefaults];
    NSInteger theHighScore = [scoreRecord integerForKey:@"HighScore"];
    
    if ((int) theHighScore < _score) {
        [scoreRecord setInteger:_score forKey:@"HighScore"];
        [scoreRecord synchronize];
    }
    _gameGrid = nil;

}

@end
