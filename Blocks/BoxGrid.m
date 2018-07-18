//
//  BoxGrid.m
//  Blocks
//
//  Created by Sam Lambert on 4/11/17.
//  Copyright © 2017 Sam Lambert. All rights reserved.
//

#import "BoxGrid.h"
#import <tgmath.h>

@implementation BoxGrid

- (id)initWithView:(UIView *)gameView {
    
    self = [super init];
    
    _screenSize = [UIScreen mainScreen].bounds;
    _screenWidth = _screenSize.size.width;
    _screenHeight = _screenSize.size.height;
    
    if (self) {
        _gameView = gameView;
        _fullRows = [[NSMutableArray alloc] init];
        //[_fullRows removeAllObjects];
        _fullColumns = [[NSMutableArray alloc] init];
        //[_fullColumns removeAllObjects];
        _numberFull = 0;

        _grid = [[NSMutableArray alloc] init];

        for (int i = 0; i < 8; i++) {
            NSMutableArray *row = [[NSMutableArray alloc] init];
            for (int j = 0; j < 8; j++) {
                [row addObject:[[Box alloc] initWithPoint:CGPointMake(36*i+((_screenWidth - 288)/2)+18, 36*j+_screenHeight*.13+18) :gameView]];
            }
            
            [_grid addObject:row];
        }
    }
    return self;
}

- (void)addBlack:(int)col :(int)row {
    [[[_grid objectAtIndex:col] objectAtIndex:row] makeBlocked];
}

- (void)addBlocks:(int)col :(int)row :(NSString*)color {
    [[[_grid objectAtIndex:col] objectAtIndex:row] makeFull:color];
}

- (void)removeBlocks:(int)col :(int)row {
    [[[_grid objectAtIndex:col] objectAtIndex:row] makeEmpty];
}

- (void)checkFullLines {
    for (int col = 0; col < 8; col++) {
        bool full = true;
        for (int row = 0; row < 8; row++) {
            Box *box = _grid[col][row];
            if (box.isEmpty || box.isBlocked) {
                full = false;
            }
        }
        if (full) {
            _numberFull += 1;
            [_fullColumns addObject:[NSNumber numberWithInt:col]];
        }
    }
    
    for (int row = 0; row < 8; row++) {
        bool full = true;
        for (int col = 0; col < 8; col++) {
            Box *box = _grid[col][row];
            if (box.isEmpty || box.isBlocked) {
                full = false;
            }
        }
        if (full) {
            _numberFull += 1;
            [_fullRows addObject:[NSNumber numberWithInt:row]];
        }
    }
}

- (int)clearLines {
    
    [self checkFullLines];
    
    for (NSNumber *col in _fullColumns) {
        
        // www.appcoda.com/ios-programming-animation-uiimageview/
        /////////////////////// Load images
        NSArray *imageNames = @[@"clear0.png", @"clear1.png", @"clear2.png", @"clear3.png", @"clear4.png", @"clear5.png", @"clear6.png", @"clear7.png", @"clear8.png", @"clear9.png", @"clear10.png", @"clear11.png", @"clear11.png", @"clear11.png", @"clear11.png", @"clear11.png", @"clear11.png", @"clear11.png",@"clear11.png", @"clear10.png", @"clear9.png", @"clear8.png", @"clear7.png", @"clear6.png", @"clear5.png", @"clear4.png", @"clear3.png", @"clear2.png", @"clear1.png", @"clear0.png"];
        
        NSMutableArray *images = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < imageNames.count; i++) {
            [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
        }
        
        // Normal Animation
        UIImageView *animation = [[UIImageView alloc] initWithFrame:CGRectMake(col.intValue*36+((_screenWidth - 288)/2), _screenHeight*.13, 36, 288)];
        animation.animationImages = images;
        animation.animationDuration = .8;
        
        [_gameView addSubview:animation];
        animation.animationRepeatCount = 1;
        
        [animation startAnimating];
        //////////////////////
        
        for (int row = 0; row < 8; row++) {
            [_grid[col.intValue][row] makeEmpty];
        }
        imageNames =nil;
        images = nil;
        animation = nil;
    }
    
    for (NSNumber *row in _fullRows) {
        
        NSArray *imageNames = @[@"clear0r.png", @"clear1r.png", @"clear2r.png", @"clear3r.png", @"clear4r.png", @"clear5r.png", @"clear6r.png", @"clear7r.png", @"clear8r.png", @"clear9r.png", @"clear10r.png", @"clear11r.png", @"clear11r.png", @"clear11r.png", @"clear11r.png", @"clear11r.png", @"clear11r.png", @"clear11r.png", @"clear11r.png", @"clear10r.png", @"clear9r.png", @"clear8r.png", @"clear7r.png", @"clear6r.png", @"clear5r.png", @"clear4r.png", @"clear3r.png", @"clear2r.png", @"clear1r.png", @"clear0r.png"];
        
        NSMutableArray *images = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < imageNames.count; i++) {
            [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
        }
        
        // Normal Animation
        UIImageView *animation = [[UIImageView alloc] initWithFrame:CGRectMake(((_screenWidth - 288)/2), row.intValue*36+_screenHeight*.13, 288, 36)];
        animation.animationImages = images;
        animation.animationDuration = .8;
        
        [_gameView addSubview:animation];
        animation.animationRepeatCount = 1;
        
        [animation startAnimating];
        
        for (int col = 0; col < 8; col++) {
            [_grid[col][row.intValue] makeEmpty];
        }
        imageNames = nil;
        images = nil;
        animation = nil;
    }
    
    int numberCleared = _numberFull;
    _numberFull = 0;
    [_fullColumns removeAllObjects];
    [_fullRows removeAllObjects];
    
    return numberCleared;
}

- (bool)addBlockToGrid:(Block *)block :(int)score {

    bool bomb = false;
    
    CGPoint point = block.blockImage.frame.origin;
    int gridX = point.x - ((_screenWidth - 288)/2);
    int gridY = point.y - _screenHeight*.13;
    // default settings to be adjusted for each block depending on shape, to ensure best placement
    int col = (gridX + 18) / 36;
    int row = (gridY + 18) / 36;
    
    if ([block.color isEqualToString:@"multi"]) {
        bomb = true;
        [block.timer invalidate];
        block.timer = nil;
        
        NSArray *imageNames = @[@"bomb0.png", @"bomb1.png", @"bomb2.png", @"bomb3.png", @"bomb4.png", @"bomb5.png", @"bomb6.png", @"bomb7.png", @"bomb8.png", @"bomb9.png", @"bomb10.png", @"bomb11.png", @"bomb11.png", @"bomb11.png", @"bomb11.png", @"bomb11.png", @"bomb11.png", @"bomb11.png", @"bomb11.png", @"bomb10.png", @"bomb9.png", @"bomb8.png", @"bomb7.png", @"bomb6.png", @"bomb5.png", @"bomb4.png", @"bomb3.png", @"bomb2.png", @"bomb1.png", @"bomb0.png"];
        
        NSMutableArray *images = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < imageNames.count; i++) {
            [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
        }
        
        double width = 111;
        double height = 111;
        int animcol = col;
        int animrow = row;
        
        // Normal Animation
        if (col == 7) {
            width -= 37;
        }
        if (col == 0) {
            width -= 37;
            animcol++;
        }
        if (row == 7) {
            height -= 37;
        }
        if (row == 0) {
            height -= 37;
            animrow++;
        }
        
        UIImageView *animation = [[UIImageView alloc] initWithFrame:CGRectMake((animcol-1)*36+((_screenWidth - 288)/2), (animrow-1)*36+_screenHeight*.13, width, height)];

        
        animation.animationImages = images;
        animation.animationDuration = .8;
        
        [_gameView addSubview:animation];
        animation.animationRepeatCount = 1;
        
        [animation startAnimating];

        
        for (int i=-1; i<2; i++) {
            for (int j=-1; j<2; j++) {
                if (0 <= col+i && col+i <= 7 && 0 <= row+j && row+j <= 7) {
                    [self removeBlocks:col+i :row+j];
                }
            }
        }
        imageNames = nil;
        images = nil;
        animation = nil;
    }
    
    else if ([block.color isEqualToString:@"white"]) {
        int odds = 1000 / (score +1);
        int makeBlack = arc4random() % (odds + 2);
        if (makeBlack == 0) {
            [self addBlack:col :row];
        }
        else {
            [self addBlocks:col :row :block.color];
        }
    }
    
    else {
        
        for (int i=0; i<block.coordinates.count - 1; i+=2) {
            
            NSNumber *colPlus = block.coordinates[i];
            NSNumber *rowPlus = block.coordinates[i+1];
            
            [self addBlocks:col+colPlus.intValue :row+rowPlus.intValue :block.color];
        }
    }
    return bomb;
}

- (bool)checkFit:(Block *)block {
    
    // top left corner of image
    CGPoint point = block.blockImage.frame.origin;
    int gridX = point.x - ((_screenWidth - 288)/2);
    int gridY = point.y - _screenHeight*.13;
    int col = (gridX + 18) / 36;
    int row = (gridY + 18) / 36;
    
    bool fit = true;
    bool outOfRange = false;
    
    if ([block.color isEqualToString:@"white"] || [block.color isEqualToString:@"multi"]) {
        if ([_grid[col][row] isEmpty] == false) {
            fit = false;
        }
    }
    
    else {
        int i = 0;
        while (i<block.coordinates.count - 1 && !outOfRange && fit) {
            
            NSNumber *colPlus = block.coordinates[i];
            NSNumber *rowPlus = block.coordinates[i+1];
            
            if (row+rowPlus.intValue > 7 || col+colPlus.intValue > 7) {
                outOfRange = true;
            }
            
            else {
                if ([_grid[col+colPlus.intValue][row+rowPlus.intValue] isEmpty] == false) {
                    fit = false;
                }
            }
            i += 2;
        }
    }
    
    if (outOfRange || !fit) {
        return false;
    }
    
    else {
        return true;
    }
}

- (bool)findSpace:(Block *)block {
    
    bool spaceLeft = false;
    
    int boxesChecked = 0;
    int col = 0;
    int row = 0;
    
    while (!spaceLeft && boxesChecked < 64) {
        
        int i = 0;
        
        int rotate1 = 0;
        int rotate2 = 0;
        int rotate3 = 0;
        int rotate4 = 0;
        
        while (i < block.coordinates.count) {
            
            
            NSNumber *colPlus = block.coordinates1[i];
            NSNumber *rowPlus = block.coordinates1[i+1];
        
            if (row+rowPlus.intValue > 7 || col+colPlus.intValue > 7) {
                
            }
        
            else {
                if ([_grid[col+colPlus.intValue][row+rowPlus.intValue] isEmpty]) {
                    rotate1++;
                }
            }
            
            colPlus = block.coordinates2[i];
            rowPlus = block.coordinates2[i+1];
            
            if (row+rowPlus.intValue > 7 || col+colPlus.intValue > 7) {
               
            }
            
            else {
                if ([_grid[col+colPlus.intValue][row+rowPlus.intValue] isEmpty]) {
                    rotate2++;
                }
            }
            
            colPlus = block.coordinates3[i];
            rowPlus = block.coordinates3[i+1];
            
            if (row+rowPlus.intValue > 7 || col+colPlus.intValue > 7) {

            }
            
            else {
                if ([_grid[col+colPlus.intValue][row+rowPlus.intValue] isEmpty]) {
                    rotate3++;
                }
            }
            
            colPlus = block.coordinates4[i];
            rowPlus = block.coordinates4[i+1];
            
            if (row+rowPlus.intValue > 7 || col+colPlus.intValue > 7) {

            }
            
            else {
                if ([_grid[col+colPlus.intValue][row+rowPlus.intValue] isEmpty]) {
                    rotate4++;
                }
            }
            
            i += 2;
        }
        
        if (rotate1 == block.score || rotate2 == block.score || rotate3 == block.score || rotate4 == block.score) {
            spaceLeft = true;
        }
        
        boxesChecked++;
        col++;
        if (col == 8) {
            col = 0;
            row++;
        }
    }
    return spaceLeft;
}

- (bool)checkForEmptyBoard {
    
    bool empty = true;
    for (int col=0; col<8; col++) {
        for (int row=0; row<8; row++) {
            Box *box = _grid[col][row];
            if (!box.isEmpty || box.isBlocked) {
                empty = false;
            }
        }
    }
    return empty;
}

@end
