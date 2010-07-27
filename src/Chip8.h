//
//  Chip8.h
//  Chip8
//
//  Created by Jedd Haberstro on 19/07/2010.
//

#import <Cocoa/Cocoa.h>
#import "Chip8Registers.h"
#import "Chip8Memory.h"
#import "Chip8Screen.h"

@interface Chip8 : NSObject {
    Chip8Memory* memory;
    Chip8Registers* registers;
    Chip8Screen* screen;
    NSTimer* loopTimer;
}

- (id)initWithProgramData:(NSData*)program;
- (void)dealloc;
- (void)run;
- (void)stop;
- (Chip8Screen*)screen;

@end