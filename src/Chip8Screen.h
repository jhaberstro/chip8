//
//  Chip8Screen.h
//  Chip8
//
//  Created by Jedd Haberstro on 26/07/2010.
//

#import <Cocoa/Cocoa.h>


@interface Chip8Screen : NSObject {
    NSBitmapImageRep* imageRep;
    NSImage* image;
}

- (id)init;
- (void)dealloc;
- (uint8_t*)bitmapData;
- (size_t)size;
- (size_t)width;
- (size_t)height;
- (uint8_t)setPixel:(uint8_t)value atX:(int)x andY:(int)y;
- (void)clear;
- (NSImage*)image;
- (NSBitmapImageRep*)imageRep;

@end
