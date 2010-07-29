//
//  ControlPanelWindowController.h
//  Chip8
//
//  Created by Jedd Haberstro on 26/07/2010.
//

#import <Cocoa/Cocoa.h>
#import "GameWindowController.h"

@interface ControlPanelWindowController : NSWindowController {
    IBOutlet NSButton* playStopButton;
    GameWindowController* currentGameWindow;
    BOOL running;
}

- (IBAction)openRom:(id)sender;
- (IBAction)run:(id)sender;

@end
