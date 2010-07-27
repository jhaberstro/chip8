//
//  ControlPanelWindowController.m
//  Chip8
//
//  Created by Jedd Haberstro on 26/07/2010.
//  Copyright 2010 DS Media Labs, Inc. All rights reserved.
//

#import "ControlPanelWindowController.h"


@implementation ControlPanelWindowController

- (IBAction)openRom:(id)sender {
	if (currentGameWindow) {
		[currentGameWindow release];
	}
	
	NSOpenPanel* openPanel = [NSOpenPanel openPanel];
	[openPanel setCanChooseFiles:YES];
	[openPanel setCanChooseDirectories:NO];
	[openPanel setAllowsMultipleSelection:NO];
	[openPanel beginWithCompletionHandler: ^ void (NSInteger result) {
        if (result != 0) {
            currentGameWindow = [[GameWindowController alloc] initWithRomPath:[openPanel URL]];
        }
	}];
}

- (IBAction)run:(id)sender {
    if (currentGameWindow) {
		[currentGameWindow run];
	}
}

- (IBAction)stop:(id)sender {
    if (currentGameWindow) {
		[currentGameWindow stop];
	}
}

@end
