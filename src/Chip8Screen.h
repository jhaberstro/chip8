//
//  Chip8Screen.h
//  Chip8
//
//  Created by Jedd Haberstro on 26/07/2010.
//

#import <Cocoa/Cocoa.h>


@interface Chip8Screen : NSObject {
    NSBitmapImageRep* imageRep;
    NSColor* clearColor;
    NSColor* drawColor;
	NSUInteger pixels[32][64];
    NSTimer* updateTimer;
} 

- (id)init;
- (void)dealloc;
- (size_t)width;
- (size_t)height;
- (void)update;
- (BOOL)setPixelAtX:(int)x andY:(int)y;
- (void)clear;
- (NSBitmapImageRep*)imageRep;

@end
