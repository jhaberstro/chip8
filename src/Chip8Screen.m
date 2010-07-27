//
//  Chip8Screen.m
//  Chip8
//
//  Created by Jedd Haberstro on 26/07/2010.
//

#import "Chip8Screen.h"
#import <assert.h>

size_t const kWidth = 64;
size_t const kHeight = 32;
size_t const kBitsPerComponent = 1;
size_t const kSamplesPerPixel = 1;

@implementation Chip8Screen

- (id)init {
	if ((self = [super init]) != nil) {		
		imageRep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:0
											 pixelsWide:kWidth
											 pixelsHigh:kHeight
											 bitsPerSample:kBitsPerComponent
											 samplesPerPixel: kSamplesPerPixel
											 hasAlpha:NO
											 isPlanar:NO
											 colorSpaceName:@"NSCalibratedBlackColorSpace"
											 bitmapFormat:0 // NSAlphaFirstBitmapFormat?
											 bytesPerRow:kWidth * kBitsPerComponent * kSamplesPerPixel
											 bitsPerPixel:0]; // Let NSBitmapImageRep figure this out
		
		image = [[NSImage alloc] initWithSize:NSMakeSize(kWidth, kHeight)];
		[image addRepresentation:imageRep];
        [self clear];
	}
	
	return self;
}

- (void)dealloc {
	[image release];
	[imageRep release];
    [super dealloc];
}

- (uint8_t*)bitmapData {
	return [imageRep bitmapData];
}

- (size_t)size {
	assert([imageRep bytesPerPlane] == ([imageRep bytesPerRow] * kHeight));
	return [imageRep bytesPerRow] * kHeight;
}
    
- (size_t)width {
    return kWidth;
}
    
- (size_t)height {
    return kHeight;
}
    
- (uint8_t)setPixel:(uint8_t)value atX:(int)x andY:(int)y {
    NSUInteger pixel;
    [imageRep getPixel:&pixel atX:x y:y];
    NSUInteger newPixel = pixel ^ value;
    [imageRep setPixel:&newPixel atX:x y:y];
    return pixel;
}

- (void)clear {
	uint8_t* data = [imageRep bitmapData];
	size_t length = [self size];
	for (size_t i = 0; i < length; ++i) {
		data[i] = 0;
	}
}

- (NSImage*)image {
    return image;
}

- (NSBitmapImageRep*)imageRep {
    return imageRep;
}

@end
