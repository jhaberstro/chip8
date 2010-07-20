//
//  Chip8Memory.h
//  Chip8
//
//  Created by Jedd Haberstro on 19/07/2010.
//  Copyright 2010 DS Media Labs, Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <stdint.h>

@interface Chip8Memory : NSObject {
    uint8_t memory[4096];
}

- (void)writeMemory:(uint8_t)data atIndex:(int)index;
- (uint8_t)readMemoryAtIndex:(int)index;

@end
