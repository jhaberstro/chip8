//
//  Chip8Memory.h
//  Chip8
//
//  Created by Jedd Haberstro on 19/07/2010.
//

#import <Cocoa/Cocoa.h>
#import <stdint.h>

@interface Chip8Memory : NSObject {
    uint8_t* memory;
}

- (id)init;
- (void)dealloc;
- (void)writeMemory:(uint8_t)data atIndex:(int)index;
- (uint8_t)readMemoryAtIndex:(int)index;
- (uint8_t*)memoryData;

@end
