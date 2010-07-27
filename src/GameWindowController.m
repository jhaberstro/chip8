//
//  GameWindowController.m
//  Chip8
//
//  Created by Jedd Haberstro on 26/07/2010.
//  Copyright 2010 DS Media Labs, Inc. All rights reserved.
//

#import "GameWindowController.h"

@interface GameWindowController (Private)
- (void)execute;
@end

@implementation GameWindowController

- (id)initWithRomPath:(NSURL*)romPath {
    if ((self = [super initWithWindowNibName:@"GameWindow"]) != nil) {
		NSData* programData = [[NSData alloc] initWithContentsOfURL:romPath];
        chip8 = [[Chip8 alloc] initWithProgramData:programData];
        [programData release];
        
        [self window];
    }
    
    return self;
}

- (void)windowDidLoad {
    Chip8Screen* screen = [chip8 screen];
    NSBitmapImageRep* imageRep = [screen imageRep];
    [view setBitmapImageRep:imageRep];
    [self showWindow:self];
}

- (void)dealloc {
    [chip8 release];
    [super dealloc];
}

- (void)run {
	loopTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 60.0)
                                                 target:self
                                               selector:@selector(execute)
                                               userInfo:nil
                                                repeats:YES];
	[chip8 run];
}

- (void)stop {
	[loopTimer invalidate];
	[loopTimer release];
	[chip8 stop];
}

@end


@implementation GameWindowController (Private)

- (void)execute {
	[view setNeedsDisplay:YES];
	[view display];
}

@end
