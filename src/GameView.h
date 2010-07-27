//
//  GameView.h
//  Chip8
//
//  Created by Jedd Haberstro on 26/07/2010.
//  Copyright 2010 DS Media Labs, Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface GameView : NSView {
    NSBitmapImageRep* imageRep;
}

- (void)setBitmapImageRep:(NSBitmapImageRep*)rep;

@end
