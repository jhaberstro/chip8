//
//  Chip8Screen.m
//  Chip8
//
//  Created by Jedd Haberstro on 26/07/2010.
//

#import "Chip8Screen.h"
#import <assert.h>

static size_t const kWidth = 64;
static size_t const kHeight = 32;
static size_t const kBitsPerComponent = 1;
static size_t const kSamplesPerPixel = 1;

@implementation Chip8Screen

- (id)init {
	if ((self = [super init]) != nil) {	
        clearColor = [NSColor blackColor];
        drawColor = [NSColor blueColor];
        
		imageRep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:0
											 pixelsWide:kWidth
											 pixelsHigh:kHeight
											 bitsPerSample:kBitsPerComponent
											 samplesPerPixel: kSamplesPerPixel
											 hasAlpha:NO
											 isPlanar:NO
											 //colorSpaceName:@"NSDeviceRGBColorSpace" //@"NSCalibratedBlackColorSpace"
											 colorSpaceName:@"NSCalibratedWhiteColorSpace"
											 bytesPerRow:kWidth * kSamplesPerPixel
											 bitsPerPixel:kBitsPerComponent * kSamplesPerPixel];		
        [self clear];

		updateTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 60.0)
	                                                  target:self
	                                                selector:@selector(update)
	                                                userInfo:nil
	                                                 repeats:YES];
	}
	
	return self;
}

- (void)dealloc {
	[updateTimer invalidate];
	[updateTimer release];
	[clearColor release];
	[drawColor release];
	[imageRep release];
    [super dealloc];
}
    
- (size_t)width {
    return kWidth;
}
    
- (size_t)height {
    return kHeight;
}

- (void)update {
	for (int y = 0; y < kHeight; ++y) {
		for (int x = 0; x < kWidth; ++x) {
			[imageRep setPixel:&pixels[y][x] atX:x y:y];
		}
	}
}

- (BOOL)setPixelAtX:(int)x andY:(int)y {
	NSUInteger pixel = pixels[y][x];
	NSUInteger newPixel = pixel ^ 1;
	pixels[y][x] = newPixel;
	return newPixel == 0;
}

- (void)clear {
	for (int y = 0; y < kHeight; ++y) {
		for (int x = 0; x < kWidth; ++x) {
			pixels[y][x] = 0;
		}
	}
}

- (NSBitmapImageRep*)imageRep {
    return imageRep;
}

@end
