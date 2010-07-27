//
//  Chip8Registers.m
//  Chip8
//
//  Created by Jedd Haberstro on 26/07/2010.
//

#import "Chip8Registers.h"


@interface Chip8Registers (PrivateMethods)

- (void)soundTimerUpdate;
- (void)delayTimerUpdate;

@end 

@implementation Chip8Registers

- (id)init {
    if ((self = [super init]) != nil) {
        PC = 0x200;
    }
    
    return self;
}

- (uint16_t)stackTop {
	assert(SP < 16);
	return stack[SP];
}

- (void)setStackTop:(uint16_t)value {
	assert(SP < 16);
	stack[SP] = value;
}

- (uint8_t)incrementStackPointer {
	++SP;
	assert(SP < 16);
	return SP;
}

- (uint8_t)decrementStackPointer {
	--SP;
	assert(SP < 16);
	return SP;
}

- (uint16_t)programCounter {
	return PC;
}

- (uint16_t)incrementProgramCounter {
	PC += 2;
	return PC;
}

- (void)setProgramCounter:(uint16_t)value {
	PC = value;
}


- (uint16_t)addressRegister {
	return I;
}

- (void)setAddressRegister:(uint16_t)value {
	I = value;
}


- (uint8_t)dataRegister:(int)index {
	assert(index < 16);
	return V[index];
}

- (void)setDataRegister:(int)index withValue:(uint8_t)value {
	assert(index < 16);
	V[index] = value;
}


- (uint8_t)delayTimer {
	return delayRegister;
}

- (uint8_t)soundTimer {
	return soundRegister;
}

- (void)activateDelayTimer:(uint8_t)value {
	if (value != 0 && soundTimer != nil) {
		delayRegister = value;
		delayTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 60.0)
                                                      target:self
                                                    selector:@selector(delayTimerUpdate)
                                                    userInfo:nil
                                                     repeats:YES];
	}
}

- (void)activateSoundTimer:(uint8_t)value {
	if (value != 0 && soundTimer != nil) {
		soundRegister = value;
		soundTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 60.0)
                                                      target:self
                                                    selector:@selector(soundTimerUpdate)
                                                    userInfo:nil
                                                     repeats:YES];
	}
}

@end


@implementation Chip8Registers (PrivateMethods)

- (void)soundTimerUpdate {
	--soundRegister;
	if (soundRegister == 0) {
		NSBeep();
		[soundTimer invalidate];
		[soundTimer release];
	}
}
- (void)delayTimerUpdate {
	--delayRegister;
	if (delayRegister == 0) {
		// Do anything here?
		[delayTimer invalidate];
		[delayTimer release];
	}
}

@end
