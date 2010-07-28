//
//  Chip8Registers.m
//  Chip8
//
//  Created by Jedd Haberstro on 26/07/2010.
//

#import "Chip8Registers.h"

@implementation Chip8Registers

- (id)init {
    if ((self = [super init]) != nil) {
        PC = 0x200;
		memset(stack, 0, sizeof(uint16_t) * 16);
		memset(V, 0, sizeof(uint8_t) * 16);
		I = 0;
		SP = 0;
		soundRegister = 0;
		delayRegister = 0;
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

- (uint16_t)decrementProgramCounter {
    PC -= 2;
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
	delayRegister = value;
}

- (void)activateSoundTimer:(uint8_t)value {
	soundRegister = value;
	soundActivated = YES;
}

- (void)soundTimerUpdate {
	if (soundRegister > 0) {
		--soundRegister;
	}
	
	if (soundRegister == 0 && soundActivated) {
		NSBeep();
		soundActivated = NO;
	}
}
- (void)delayTimerUpdate {
	if (delayRegister > 0) {
		--delayRegister;
	}
}

@end
