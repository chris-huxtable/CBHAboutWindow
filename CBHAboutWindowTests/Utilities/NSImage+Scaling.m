//  NSImage+Scaling.m
//  CBHAboutWindowTests
//
//  Created by Christian Huxtable <chris@huxtable.ca>, April 2019.
//  Copyright (c) 2019 Christian Huxtable. All rights reserved.

#import "NSImage+Scaling.h"


@implementation NSImage (Scaling)

- (NSImage *)imageScaledToSize:(NSSize)size
{
	NSImage *image = [[NSImage alloc] initWithSize:size];
	NSRect rect = {NSZeroPoint, size};

	[image lockFocus];
	[[self bestRepresentationForRect:rect context:nil hints:nil] drawInRect:rect];
	[image unlockFocus];

	return image;
}

@end
