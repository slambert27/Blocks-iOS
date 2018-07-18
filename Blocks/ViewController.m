//
//  ViewController.m
//  Blocks
//
//  Created by Sam Lambert on 4/5/17.
//  Copyright © 2017 Sam Lambert. All rights reserved.
//

#import "ViewController.h"

//SCORES

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.statsView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playButton:(id)sender {
}

- (IBAction)statsButton:(id)sender {
    

    NSUserDefaults *scoreRecord = [NSUserDefaults standardUserDefaults];
    NSInteger theHighScore = [scoreRecord integerForKey:@"HighScore"];
    _highscoreLabel.text = [NSString stringWithFormat:@"%d", (int) theHighScore];
    NSInteger rowsCleared = [scoreRecord integerForKey:@"rowsCleared"];
    _rowsClearedLabel.text = [NSString stringWithFormat:@"%d", (int) rowsCleared];
    NSInteger blocksPlaced = [scoreRecord integerForKey:@"blocksPlaced"];
    _blocksPlacedLabel.text = [NSString stringWithFormat:@"%d", (int) blocksPlaced];
    NSInteger bombsPlaced = [scoreRecord integerForKey:@"bombsPlaced"];
    _bombsPlacedLabel.text = [NSString stringWithFormat:@"%d", (int) bombsPlaced];

    self.statsView.hidden = NO;
}

- (IBAction)howToButton:(id)sender {
    
    self.howToView.hidden = NO;
}

- (IBAction)dismissStats:(id)sender {
    
    self.statsView.hidden = YES;
}

- (IBAction)dismissHowTo:(id)sender {
    
    self.howToView.hidden = YES;
}
@end
