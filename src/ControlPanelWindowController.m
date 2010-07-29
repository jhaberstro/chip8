//
//  ControlPanelWindowController.m
//  Chip8
//
//  Created by Jedd Haberstro on 26/07/2010.
//

#import "ControlPanelWindowController.h"


@implementation ControlPanelWindowController

- (IBAction)openRom:(id)sender {
	NSOpenPanel* openPanel = [NSOpenPanel openPanel];
	[openPanel setCanChooseFiles:YES];
	[openPanel setCanChooseDirectories:NO];
	[openPanel setAllowsMultipleSelection:NO];
	[openPanel beginWithCompletionHandler: ^ void (NSInteger result) {
        if (result != 0) {
			if (currentGameWindow) {
                [playStopButton setState:NSOffState];
				[currentGameWindow loadRom:[openPanel URL]];
			}
			else {
				currentGameWindow = [[GameWindowController alloc] initWithRomPath:[openPanel URL]];
				[self run:nil];
                [playStopButton setState:NSOnState];
            }	
        }
	}];
}

- (IBAction)run:(id)sender {
	if (currentGameWindow != nil) {
		[[currentGameWindow window] makeKeyAndOrderFront:nil];
		if (![currentGameWindow isEmulatorRunning]) {
			[currentGameWindow run];
		}
		else {
			[currentGameWindow stop];
		}
	}
}

@end
