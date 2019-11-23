//  _CBHAboutColorView.m
//  CBHAboutWindow
//
//  Created by Christian Huxtable <chris@huxtable.ca>, April 2019.
//  Copyright (c) 2019 Christian Huxtable. All rights reserved.
//
//  Permission to use, copy, modify, and/or distribute this software for any
//  purpose with or without fee is hereby granted, provided that the above
//  copyright notice and this permission notice appear in all copies.
//
//  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
//  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
//  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
//  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
//  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
//  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
//  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

#import "_CBHAboutColorView.h"


NS_ASSUME_NONNULL_BEGIN

@interface _CBHAboutColorView ()
{
	NSColor * __nullable _color;
}
@end

NS_ASSUME_NONNULL_END


@implementation _CBHAboutColorView

@synthesize color = _color;

- (void)drawRect:(NSRect)dirtyRect
{
	if ( _color )
	{
		[_color setFill];
		NSRectFill(dirtyRect);
	}
	else
	{
		[super drawRect:dirtyRect];
	}
}

@end
