//
//  Chip8Memory.m
//  Chip8
//
//  Created by Jedd Haberstro on 19/07/2010.
//

#import "Chip8Memory.h"
#include <assert.h>


@implementation Chip8Memory

- (id)init {
    if ((self = [super init]) != nil) {
        memory = malloc(sizeof(uint8_t) * 4096);
    }
    
    return self;
}

- (void)dealloc {
    free(memory);
    [super dealloc];
}

- (void)writeMemory:(uint8_t)data atIndex:(int)index {
    assert(index <= 0xfff);
    memory[index] = data;
}

- (uint8_t)readMemoryAtIndex:(int)index {
    assert(index <= 0xfff);
    return memory[index];
}

- (uint8_t*)memoryData {
    return &memory[0];
}

@end
