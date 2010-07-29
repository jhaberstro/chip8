//
//  GameView.m
//  Chip8
//
//  Created by Jedd Haberstro on 26/07/2010.
//

#import "GameView.h"


@implementation GameView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

- (void)dealloc {
    [imageRep release];
    [super dealloc];
}

- (void)setBitmapImageRep:(NSBitmapImageRep*)rep {
    imageRep = rep;
    [rep retain];
}

- (void)drawRect:(NSRect)dirtyRect {
    if (imageRep) {
        [imageRep drawInRect:dirtyRect];
    }
}

@end
