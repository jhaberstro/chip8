//
//  Chip8Registers.h
//  Chip8
//
//  Created by Jedd Haberstro on 26/07/2010.
//

#import <Cocoa/Cocoa.h>


@interface Chip8Registers : NSObject {
    NSTimer* delayTimer;
    NSTimer* soundTimer;
    
    // I really hate these uppercase, one-two variables names.
    // But nothing else really works that looks both better and easy
    // to map to the chip8 documentation.
    uint16_t stack[16];
    uint16_t PC;
    uint16_t I;
    uint8_t SP;
    uint8_t V[16];
    uint8_t soundRegister;
    uint8_t delayRegister;
}

- (id)init;

- (uint16_t)stackTop;
- (void)setStackTop:(uint16_t)value;
- (uint8_t)incrementStackPointer;
- (uint8_t)decrementStackPointer;

- (uint16_t)programCounter;
- (uint16_t)incrementProgramCounter;
- (void)setProgramCounter:(uint16_t)value;

- (uint16_t)addressRegister;
- (void)setAddressRegister:(uint16_t)value;

- (uint8_t)dataRegister:(int)index;
- (void)setDataRegister:(int)index withValue:(uint8_t)value;

- (uint8_t)delayTimer;
- (uint8_t)soundTimer;
- (void)activateDelayTimer:(uint8_t)value;
- (void)activateSoundTimer:(uint8_t)value;

@end
