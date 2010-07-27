//
//  ControlPanelWindowController.h
//  Chip8
//
//  Created by Jedd Haberstro on 26/07/2010.
//  Copyright 2010 DS Media Labs, Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GameWindowController.h"

@interface ControlPanelWindowController : NSWindowController {
    GameWindowController* currentGameWindow;
}

- (IBAction)openRom:(id)sender;
- (IBAction)run:(id)sender;
- (IBAction)stop:(id)sender;

@end
