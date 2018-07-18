//
//  ViewController.h
//  Blocks
//
//  Created by Sam Lambert on 4/5/17.
//  Copyright © 2017 Sam Lambert. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *statsView;
@property (strong, nonatomic) IBOutlet UIView *howToView;

@property (strong, nonatomic) IBOutlet UILabel *highscoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *blocksPlacedLabel;
@property (strong, nonatomic) IBOutlet UILabel *rowsClearedLabel;
@property (strong, nonatomic) IBOutlet UILabel *bombsPlacedLabel;


- (IBAction)playButton:(id)sender;
- (IBAction)statsButton:(id)sender;
- (IBAction)howToButton:(id)sender;

- (IBAction)dismissStats:(id)sender;
- (IBAction)dismissHowTo:(id)sender;

@end

