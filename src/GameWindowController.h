//
//  GameWindowController.h
//  Chip8
//
//  Created by Jedd Haberstro on 26/07/2010.
//

#import <Cocoa/Cocoa.h>
#import "GameView.h"
#import "Chip8.h"

@interface GameWindowController : NSWindowController {
    IBOutlet GameView* view;
    NSTimer* loopTimer;
    Chip8* chip8;
    BOOL keys[16];
}

- (id)initWithRomPath:(NSURL*)romPath;
- (void)dealloc;
- (void)loadRom:(NSURL *)romPath;
- (void)run;
- (void)stop;
- (BOOL)isEmulatorRunning;

@end
