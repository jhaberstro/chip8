//
//  Chip8.m
//  Chip8
//
//  Created by Jedd Haberstro on 19/07/2010.
//

#import "Chip8.h"
#import <assert.h>
#import <stdlib.h>
#import <stdio.h>

@interface Chip8 (Private)
- (uint16_t)fetchInstruction;
- (void)execute;
@end

@implementation Chip8

- (id)initWithProgramData:(NSData*)program {
	if ((self = [super init]) != nil) {
        running = NO;
		memory = [[Chip8Memory alloc] init];
		registers = [[Chip8Registers alloc] init];
        screen = [[Chip8Screen alloc] init];
        size_t length = [program length];
		assert(length <= (0xfff - 0x200));
		[program getBytes:[memory memoryData] + 0x200 length:length];
		srandom(time(0));
	}
	
	return self;
}

- (void)dealloc {
	[self stop];
	[screen release];
	[registers release];
	[memory release];
    [super dealloc];
}

- (void)run {
    if (!running) {
        loopTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 30.0)
                                                     target:self
                                                   selector:@selector(execute)
                                                   userInfo:nil
                                                    repeats:YES];
    }
    
    running = YES;
}

- (void)stop {
	if (running) {
        [loopTimer invalidate];        
		[loopTimer release];
        running = NO;
	}
}

- (Chip8Screen*)screen {
    return screen;
}

- (void)setKeys:(BOOL*)newKeys {
	assert(newKeys);
	keys = newKeys;
}

- (BOOL)isRunning {
    return running;
}

@end

@implementation Chip8 (Private)

- (uint16_t)fetchInstruction {
	uint8_t const* bytes = (uint8_t const*)[memory memoryData];
	int pc = [registers programCounter];
	return ((bytes[pc] << 8) | bytes[pc + 1]);
}

- (void)execute {
	int t = 0;	
	while(t++ < 13) {
		uint16_t instruction = [self fetchInstruction];
		[registers incrementProgramCounter];
		switch((instruction & 0xf000) >> 12) {
			case 0x0: {
				uint8_t op = (instruction & 0x00ff);
				if (op == 0xfd) {
					[self stop];
				}
				if (op == 0xe0) {
					[screen clear];
				}
				else if (op == 0xee) {
					[registers setProgramCounter:[registers stackTop]];
					[registers decrementStackPointer];
				}

				break;
			}

			case 0x1: {
				[registers setProgramCounter:instruction & 0x0fff];
				break;
			}

			case 0x2: {
				[registers incrementStackPointer];
				[registers setStackTop:[registers programCounter]];
				[registers setProgramCounter:instruction & 0x0fff];
				break;
			}

			case 0x3: {
				uint8_t x = (instruction & 0x0f00) >> 8;
				uint8_t kk = (instruction & 0x00ff);
				if ([registers dataRegister:x] == kk) {
					[registers incrementProgramCounter];
				}

				break;
			}

			case 0x4: {
				uint8_t x = (instruction & 0x0f00) >> 8;
				uint8_t kk = (instruction & 0x00ff);
				if ([registers dataRegister:x] != kk) {
					[registers incrementProgramCounter];
				}

				break;
			}

			case 0x5: {
				uint8_t x = (instruction & 0x0f00) >> 8;
				uint8_t y = (instruction & 0x00f0) >> 4;
				if ([registers dataRegister:x] == [registers dataRegister:y]) {
					[registers incrementProgramCounter];
				}

				break;
			}

			case 0x6: {
				uint8_t x = (instruction & 0x0f00) >> 8;
				uint8_t kk = (instruction & 0x00ff);
				[registers setDataRegister:x withValue:kk];
				break;
			}

			case 0x7: {
				uint8_t x = (instruction & 0x0f00) >> 8;
				uint8_t kk = (instruction & 0x00ff);
				[registers setDataRegister:x withValue:[registers dataRegister:x] + kk];
				break;
			}

			case 0x8: {
				uint8_t x = (instruction & 0x0f00) >> 8;
				uint8_t y = (instruction & 0x00f0) >> 4;
				uint8_t op = (instruction & 0x000f);

				if (op == 0x0) {
					[registers setDataRegister:x withValue:[registers dataRegister:y]];
				}
				else if (op == 0x1) {
					[registers setDataRegister:x withValue:[registers dataRegister:x] | [registers dataRegister:y]];
				}
				else if (op == 0x2) {
					[registers setDataRegister:x withValue:[registers dataRegister:x] & [registers dataRegister:y]];
				}
				else if (op == 0x3) {
					[registers setDataRegister:x withValue:[registers dataRegister:x] ^ [registers dataRegister:y]];
				}
				else if (op == 0x4) {
					uint16_t sum = (uint16_t)[registers dataRegister:x] + (uint16_t)[registers dataRegister:y];
					[registers setDataRegister:0xf withValue: (sum > 0xff) ? 1 : 0];
					[registers setDataRegister:x withValue:sum & 0xff];
				}
				else if (op == 0x5) {
					uint8_t regX = [registers dataRegister:x];
					uint8_t regY = [registers dataRegister:y];
					[registers setDataRegister:0xf withValue:(regX >= regY) ? 1 : 0];
					[registers setDataRegister:x withValue:regX - regY];
				}
				else if (op == 0x6) {
					uint8_t regX = [registers dataRegister:x];
					[registers setDataRegister:0xf withValue:(regX & 0x1)];
					[registers setDataRegister:x withValue:regX >> 1];
				}
				else if (op == 0x7) {
					uint8_t regX = [registers dataRegister:x];
					uint8_t regY = [registers dataRegister:y];
					[registers setDataRegister:0xf withValue:(regY >= regX) ? 1 : 0];
					[registers setDataRegister:x withValue:(regY - regX)];
				}
				else if (op == 0xe) {
					uint8_t regX = [registers dataRegister:x];
					[registers setDataRegister:0xf withValue:(regX >> 7) & 0x1];
					[registers setDataRegister:x withValue:regX << 1];
				}

				break;
			}

			case 0x9: {
	            uint8_t x = (instruction & 0x0f00) >> 8;
	            uint8_t y = (instruction & 0x00f0) >> 4;
				uint8_t regX = [registers dataRegister:x];
				uint8_t regY = [registers dataRegister:y];
				if (regX != regY) {
					[registers incrementProgramCounter];
				}

				break;
			}

			case 0xa: {
				[registers setAddressRegister:instruction & 0x0fff];
				break;
			}

			case 0xb: {
				[registers setProgramCounter:(instruction & 0x0fff) + [registers dataRegister:0]];
				break;
			}

			case 0xc: {
				uint8_t x = (instruction & 0x0f00) >> 8;
				uint8_t kk = (instruction & 0x00ff);
				[registers setDataRegister:x withValue:(random() % 255) & kk];
				break;
			}

			case 0xd: {
				uint8_t n = (instruction & 0x000f);
				uint8_t regX = [registers dataRegister:(instruction & 0x0f00) >> 8];
				uint8_t regY = [registers dataRegister:(instruction & 0x00f0) >> 4];
				uint8_t const* spriteData = [memory memoryData] + [registers addressRegister];
				size_t width = [screen width];
				size_t height = [screen height];

				[registers setDataRegister:0xf withValue:0];
				for (int y = 0; y < n; ++y) {
					uint8_t spriteByte = spriteData[y];
					for (int x = 0; x < 8; ++x) {
						if (spriteByte & (1 << (7 - x))) {
							if ([screen setPixelAtX:(regX + x) % width andY:(regY + y) % height] == YES) {
								[registers setDataRegister:0xf withValue:1];
							}
						}
					}
				}

				break;
			}

			case 0xe: {
				if ((instruction & 0x00ff) == 0x9e) {
					uint8_t regX = [registers dataRegister:(instruction & 0x0f00) >> 8];
					if (keys[regX] == YES) {
						[registers incrementProgramCounter];
					}
				}
				else if ((instruction & 0x00ff) == 0xa1) {
					uint8_t regX = [registers dataRegister:(instruction & 0x0f00) >> 8];
					if (keys[regX] == NO) {
						[registers incrementProgramCounter];
					}	
				}

				break;
			}

			case 0xf: {
				uint8_t x = (instruction & 0x0f00) >> 8;
				uint8_t op = instruction & 0x00ff;

				if (op == 0x07) {
					[registers setDataRegister:x withValue:[registers delayTimer]];
				}
				else if (op == 0x0a) {
					BOOL keyPressed = NO;
					for (int i = 0; i < 16; ++i) {
						if (keys[i] == YES) {
							keyPressed = YES;
							[registers setDataRegister:x withValue:i];
							break;
						}
					}
					
					if (keyPressed == NO) {
						[registers decrementProgramCounter];
					}					
				}
				else if (op == 0x15) {
					[registers activateDelayTimer:[registers dataRegister:x]];
				}
				else if (op == 0x18) {
					[registers activateSoundTimer:[registers dataRegister:x]];
				}
				else if (op == 0x1e) {
					[registers setAddressRegister:[registers addressRegister] + [registers dataRegister:x]];
				}
				else if (op == 0x29) {
					[registers setAddressRegister:[registers dataRegister:x] * 5];
				}
				else if (op == 0x33) {
					uint8_t regx = [registers dataRegister:x];
					uint8_t hundredsDigit = regx / 100;
					uint8_t tensDigit = (regx % 100) / 10;
					uint8_t onesDigit = (regx % 10);
					int addressReg = [registers addressRegister];
					[memory writeMemory:hundredsDigit atIndex:addressReg];
					[memory writeMemory:tensDigit atIndex:addressReg + 1];
					[memory writeMemory:onesDigit atIndex:addressReg + 2];
				}
				else if (op == 0x55) {
					for (int i = 0; i <= x; ++i) {
						int addressReg = [registers addressRegister];
						[memory writeMemory:[registers dataRegister:i] atIndex:addressReg];
						[registers setAddressRegister:addressReg + 1];
					}
				}
				else if (op == 0x65) {
					for (int i = 0; i <= x; ++i) {
						int addressReg = [registers addressRegister];
						[registers setDataRegister:i withValue:[memory readMemoryAtIndex:addressReg]];
						[registers setAddressRegister:addressReg + 1];
					}
				}

				break;
			}
		}

		[registers soundTimerUpdate];
		[registers delayTimerUpdate];		
	}	
}

@end
