//
//  Block.m
//  Blocks
//
//  Created by Sam Lambert on 4/12/17.
//  Copyright © 2017 Sam Lambert. All rights reserved.
//

#import "Block.h"

@implementation Block

- (id)initWithColor:(NSString *)blockColor :(UIImageView *)image :(bool)next{
    
    self = [super init];
    
    _screenSize = [UIScreen mainScreen].bounds;
    _screenWidth = _screenSize.size.width;
    _screenHeight = _screenSize.size.height;
    
    if (self) {
        _Next = next;
        _color = blockColor;
        _blockImage = image;
        _orientation = 2;
        [self setColorVariables];
    }
    return self;
}

- (void)setColorVariables {
    
    if ([_color isEqualToString:@"white"] || [_color isEqualToString:@"multi"]) {
        _score = 1;
        _width = 1;
        _height = 1;
        
        _coordinates = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
        _coordinates1 = _coordinates;
        _coordinates2 = _coordinates;
        _coordinates3 = _coordinates;
        _coordinates4 = _coordinates;
    }
    
    else if ([_color isEqualToString:@"yellow"]) {
        _score = 2;
        _width = 1;
        _height = 2;
        
        _coordinates1 = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], nil];
        _coordinates2 = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], nil];
        _coordinates3 = _coordinates1;
        _coordinates4 = _coordinates2;
        
        if (_orientation == 2 || _orientation == 1) {
            _coordinates = _coordinates1;
        }
        
        else {
            _coordinates = _coordinates2;
        }
    }
    
    else if ([_color isEqualToString:@"cyan"]) {
        _score = 3;
        _width = 1;
        _height = 3;
        
        _coordinates1 = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:2], nil];
        _coordinates2 = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:2], [NSNumber numberWithInt:0], nil];
        _coordinates3 = _coordinates1;
        _coordinates4 = _coordinates2;
        
        if (_orientation == 2 || _orientation == 1) {
            _coordinates = _coordinates1;
        }
        
        else {
            _coordinates = _coordinates2;
        }
    }
    
    else if ([_color isEqualToString:@"blue"]) {
        _score =3;
        _width = 2;
        _height = 2;
        
        _coordinates1 = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
        _coordinates2 = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
        _coordinates3 = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
        _coordinates4 = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], nil];
        
        if (_orientation == 2) {
            _coordinates = _coordinates1;
        }
        
        else if (_orientation == 1.5) {
            _coordinates = _coordinates2;
        }
        
        else if (_orientation == 1) {
            _coordinates = _coordinates3;
        }
        
        else {
            _coordinates = _coordinates4;
        }
    }
    
    else if ([_color isEqualToString:@"pink"]) {
        _score = 4;
        _width = 2;
        _height = 2;
        
        _coordinates1 = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
        
        _coordinates = _coordinates1;
        _coordinates2 = _coordinates1;
        _coordinates3 = _coordinates1;
        _coordinates4 = _coordinates1;
    }
    
    else if ([_color isEqualToString:@"red"]) {
        _score = 4;
        _width = 2;
        _height = 3;
        
        _coordinates1 = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:2], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], nil];
        _coordinates2 = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:0], nil];
        _coordinates3 = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], nil];
        _coordinates4 = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:2], [NSNumber numberWithInt:0], nil];
        
        if (_orientation == 2) {
            _coordinates = _coordinates1;
        }
        
        else if (_orientation == 1.5) {
            _coordinates = _coordinates2;
        }
        
        else if (_orientation == 1) {
            _coordinates = _coordinates3;
        }
        
        else {
            _coordinates = _coordinates4;
        }
    }
    
    else if ([_color isEqualToString:@"green"]) {
        _score = 5;
        _width = 2;
        _height = 4;
        
        _coordinates1 = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:2], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:1], [NSNumber numberWithInt:3], nil];
        _coordinates2 = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:0], [NSNumber numberWithInt:3], [NSNumber numberWithInt:0], nil];
        _coordinates3 = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:1], [NSNumber numberWithInt:3], nil];
        _coordinates4 = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:2], [NSNumber numberWithInt:0], [NSNumber numberWithInt:3], [NSNumber numberWithInt:0], nil];
        
        if (_orientation == 2) {
            _coordinates = _coordinates1;
        }
        
        else if (_orientation == 1.5) {
            _coordinates = _coordinates2;
        }
        
        else if (_orientation == 1) {
            _coordinates = _coordinates3;
        }
        
        else {
            _coordinates = _coordinates4;
        }
    }
    
    double mult = 1;
    if (!_Next) {
        mult = .5;
    }
    int X = _screenWidth / 2;
    if (!_Next) {
        X = 50;
    }
    
    //change dimensions on rotation to keep block same size
    if (_orientation == .5 || _orientation == 1.5) {
        int temp = _height;
        _height = _width;
        _width = temp;
    }
    
    _blockImage.frame = CGRectMake(160, 445, _width*37*mult, _height*37*mult);
    _blockImage.center = CGPointMake(X, _screenHeight * .77);
    if ([_color isEqualToString:@"multi"]) {
        
        _blockImage.image = [UIImage imageNamed:@"white.png"];
        _timer = [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(updateImage) userInfo:nil repeats:YES];
    }
    
    else {
        _blockImage.image = [UIImage imageNamed:[_color stringByAppendingString:@"Block.png"]];
    }
}

- (void)changeColorAndOrientation:(NSString *)blockColor :(double)orient{
    _color = blockColor;
    _orientation = orient;
    _blockImage.transform = CGAffineTransformMakeRotation(orient*M_PI);
    [self setColorVariables];
    int X = _screenWidth / 2;
    if (!_Next) {
        X = 50;
    }
    _blockImage.center = CGPointMake(X, _screenHeight * .77);
}

- (void)updateImage {
    
    NSMutableArray *colors = [[NSMutableArray alloc] initWithObjects:@"yellow.png", @"cyan.png", @"blue.png", @"pink.png", @"red.png", @"green.png", nil];
    
    int rand = arc4random() % 6;
    
    _blockImage.image = [UIImage imageNamed:colors[rand]];
}


@end
