//  NSImage+Scaling.h
//  CBHAboutWindowTests
//
//  Created by Christian Huxtable <chris@huxtable.ca>, April 2019.
//  Copyright (c) 2019 Christian Huxtable. All rights reserved.

@import AppKit;


NS_ASSUME_NONNULL_BEGIN

@interface NSImage (Scaling)

- (NSImage *)imageScaledToSize:(NSSize)size;

@end

NS_ASSUME_NONNULL_END
