//  CBHAboutWindowController.m
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

#import "CBHAboutWindowController.h"

#import "CBHAboutImageView.h"


NS_ASSUME_NONNULL_BEGIN

@interface CBHAboutWindowController ()
{
	@private
	IBOutlet CBHAboutImageView *_iconView;
	IBOutlet NSTextField *_titleField;
	IBOutlet NSTextField *_versionField;
	IBOutlet NSTextField *_authorField;
	IBOutlet NSTextField *_copyrightField;
	IBOutlet NSButton *_websiteButton;

	NSURL *_websiteURL;
}

#pragma mark Actions

- (IBAction)openWebsite:(id)sender;


#pragma mark Utilities

- (NSImage *)_image:(NSImage *)image scaledToSize:(NSSize)size;

@end

NS_ASSUME_NONNULL_END


@implementation CBHAboutWindowController


#pragma mark Factories

+ (instancetype)controller
{
	return [[[self class] alloc] initWithWindowNibName:@"CBHAboutWindow"];
}


#pragma mark Overrides

- (void)awakeFromNib
{
	[super awakeFromNib];

	NSRunningApplication *currentApplication = [NSRunningApplication currentApplication];
	NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
	NSBundle *bundle = [NSBundle bundleWithIdentifier:@"ca.huxtable.CBHAboutWindow"];

	NSWindow *window = [self window];
	[window setBackgroundColor:[NSColor controlColor]];
	[window setMovableByWindowBackground:YES];

	NSString *string = NSLocalizedStringFromTableInBundle(@"About %@", nil, bundle, @"CBHAboutWindowController::window.title");
	[window setTitle:[NSString stringWithFormat:string, [currentApplication localizedName]]];

	[self setIcon:[NSImage imageNamed:NSImageNameApplicationIcon]];
	[self setTitle:[currentApplication localizedName]];

	NSString *version = [info objectForKey:@"CFBundleShortVersionString"];
	NSString *build = [info objectForKey:@"CFBundleVersion"];

	NSUInteger versionLength = [version length];
	if ( versionLength > 1 )
	{
		unichar lastChar = [version characterAtIndex:versionLength - 1];
		if ( lastChar < '0' || lastChar > '9' ) { [self setVersion:version withBuild:build]; }
		else { [self setVersion:version]; }
	}
	else { [self setVersion:version]; }

	string = NSLocalizedStringFromTableInBundle(@"Designed & Written by", nil, bundle, @"CBHAboutWindowController::author");
	[self setAuthor:[NSString stringWithFormat:@"%@ %@", string, @"Chris Huxtable"]];

	string = NSLocalizedStringFromTableInBundle(@"Copyright", nil, bundle, @"CBHAboutWindowController::copyright");
	NSString *reserved = NSLocalizedStringFromTableInBundle(@"All rights reserved", nil, bundle, @"CBHAboutWindowController::reserved");
	[self setCopyright:[NSString stringWithFormat:@"%@ %@. %@.", string, @"© 2019 Chris Huxtable", reserved]];

	[_websiteButton setTitle:NSLocalizedStringFromTableInBundle(@"Website", nil, bundle, @"CBHAboutWindowController::website")];
	[self setWebsiteURL:[NSURL URLWithString:@"https://huxtable.ca/apps"]];
}


#pragma mark Properties

- (void)setIcon:(NSImage *)icon
{
	[_iconView setImage:[self _image:icon scaledToSize:NSMakeSize(192, 192)]];
}

- (NSImage *)icon
{
	return [_iconView image];
}


- (void)setTitle:(NSString *)title
{
	[_titleField setStringValue:title];
}

- (NSString *)title
{
	return [_titleField stringValue];
}


- (void)setVersion:(NSString *)version
{
	NSBundle *bundle = [NSBundle bundleWithIdentifier:@"ca.huxtable.CBHAboutWindow"];
	NSString *label = NSLocalizedStringFromTableInBundle(@"Version", nil, bundle, @"CBHAboutWindowController::version");
	[_versionField setStringValue:[NSString stringWithFormat:@"%@ %@", label, version]];
}

- (void)setVersion:(NSString *)version withBuild:(NSString *)build
{
	NSBundle *bundle = [NSBundle bundleWithIdentifier:@"ca.huxtable.CBHAboutWindow"];
	NSString *label = NSLocalizedStringFromTableInBundle(@"Version", nil, bundle, @"CBHAboutWindowController::version");
	[_versionField setStringValue:[NSString stringWithFormat:@"%@ %@ (%@)",  label, version, build]];
}

- (NSString *)version
{
	return [_versionField stringValue];
}


- (void)setAuthor:(NSString *)author
{
	[_authorField setStringValue:author];
}

- (NSString *)author
{
	return [_authorField stringValue];
}


- (void)setCopyright:(NSString *)copyright
{
	[_copyrightField setStringValue:copyright];
}

- (NSString *)copyright
{
	return [_copyrightField stringValue];
}


@synthesize websiteURL = _websiteURL;


#pragma mark Actions

- (IBAction)openWebsite:(id)sender
{
	if ( !_websiteURL ) { return; }
	[[NSWorkspace sharedWorkspace] openURL:_websiteURL];
}


#pragma mark Utilities

- (NSImage *)_image:(NSImage *)image scaledToSize:(NSSize)size
{
	NSRect rect = NSMakeRect(0, 0, size.width, size.width);
	NSImageRep *imageRep = [image bestRepresentationForRect:rect context:nil hints:nil];

	NSImage *outImage = [[NSImage alloc] initWithSize:size];

	[outImage lockFocus];
	[imageRep drawInRect:rect];
	[outImage unlockFocus];

	return outImage;
}

@end
