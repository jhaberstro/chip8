//
//  Chip8AppDelegate.h
//  Chip8
//
//  Created by Jedd Haberstro on 19/07/2010.
//  Copyright 2010 DS Media Labs, Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Chip8AppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
