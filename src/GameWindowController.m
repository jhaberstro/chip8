//
//  GameWindowController.m
//  Chip8
//
//  Created by Jedd Haberstro on 26/07/2010.
//

#import "GameWindowController.h"

int CharacterToKeyIndex(unichar c) {
	switch(c) {
		case '1': return 0x1;
		case '2': return 0x2;
		case '3': return 0x3;
		case '4': return 0xc;
		case 'q': return 0x4;
		case 'w': return 0x5;
		case 'e': return 0x6;
		case 'r': return 0xd;
		case 'a': return 0x7;
		case 's': return 0x8;
		case 'd': return 0x9;
		case 'f': return 0xe;
		case 'z': return 0xa;
		case 'x': return 0x0;
		case 'c': return 0xb;
		case 'v': return 0xf;
	}
	
	return -1;
}

@interface GameWindowController (Private)
- (void)execute;
@end

@implementation GameWindowController

- (id)initWithRomPath:(NSURL*)romPath {
    if ((self = [super initWithWindowNibName:@"GameWindow"]) != nil) {
		[self loadRom:romPath];
		[self window];
    }
    
    return self;
}

- (void)windowDidLoad {
    [view setBitmapImageRep:[[chip8 screen] imageRep]];
    [self showWindow:self];
}

- (void)dealloc {
	[self stop];
    [chip8 release];
    [super dealloc];
}

- (void)loadRom:(NSURL*)romPath {
	if (chip8 != nil) {
		[self stop];
	    [chip8 release];
	}
	
	NSData* programData = [[NSData alloc] initWithContentsOfURL:romPath];
    chip8 = [[Chip8 alloc] initWithProgramData:programData];
	[chip8 setKeys:&keys[0]];
	[view setBitmapImageRep:[[chip8 screen] imageRep]];
	[view display];
    [programData release];
}

- (void)run {
	if (![chip8 isRunning]) {
		loopTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 60.0)
	                                                 target:self
	                                               selector:@selector(execute)
	                                               userInfo:nil
	                                                repeats:YES];
		[chip8 run];
	}
}

- (void)stop {
	if ([chip8 isRunning]) {
		[chip8 stop];
		[loopTimer invalidate];
		[loopTimer release];
	}
	
}

- (BOOL)isEmulatorRunning {
    return [chip8 isRunning];
}

- (void)keyDown:(NSEvent*)theEvent {
	NSString* characters = [theEvent charactersIgnoringModifiers];
	for (unsigned int i = 0; i < [characters length]; ++i) {
		unichar character = [characters characterAtIndex:i];
		int keyIndex = CharacterToKeyIndex(character);
		if (keyIndex != -1) {
            keys[keyIndex] = YES;
		}
	}
}

- (void)keyUp:(NSEvent*)theEvent {
	NSString* characters = [theEvent charactersIgnoringModifiers];
	for (unsigned int i = 0; i < [characters length]; ++i) {
		unichar character = [characters characterAtIndex:i];
		int keyIndex = CharacterToKeyIndex(character);
		if (keyIndex != -1) {
			keys[keyIndex] = NO;
		}
	}
}

@end


@implementation GameWindowController (Private)

- (void)execute {
	[view display];
}

@end
