//
//  Chip8Memory.m
//  Chip8
//
//  Created by Jedd Haberstro on 19/07/2010.
//  Copyright 2010 DS Media Labs, Inc. All rights reserved.
//

#import "Chip8Memory.h"
#include <assert.h>


@implementation Chip8Memory

- (void)writeMemory:(uint8_t)data atIndex:(int)index {
    assert(index <= 0xfff);
    assert(index >= 0x200);
    memory[index] = data;
}

- (uint8_t)readMemoryAtIndex:(int)index {
    assert(index <= 0xfff);
    assert(index >= 0x200);
    return memory[index];
}

@end
