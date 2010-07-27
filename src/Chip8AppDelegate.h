//
//  Chip8AppDelegate.h
//  Chip8
//
//  Created by Jedd Haberstro on 19/07/2010.
//

#import <Cocoa/Cocoa.h>
#import "ControlPanelWindowController.h"

@interface Chip8AppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet NSWindow *controlWindow;
    IBOutlet ControlPanelWindowController* controlPanelController;
}

@end
