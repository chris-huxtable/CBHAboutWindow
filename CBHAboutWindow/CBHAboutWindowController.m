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

#import "_CBHAboutImageView.h"


NS_ASSUME_NONNULL_BEGIN

@interface CBHAboutWindowController ()
{
	@private
	IBOutlet _CBHAboutImageView *_iconView;
	IBOutlet NSTextField *_titleField;
	IBOutlet NSButton *_versionButton;
	IBOutlet NSTextField *_authorField;
	IBOutlet NSTextField *_copyrightField;
	IBOutlet NSButton *_websiteButton;

	NSString *_version;
	NSString *_build;

	BOOL _versionAndBuild;

	NSURL *_websiteURL;
}

#pragma mark - Actions

- (IBAction)openWebsite:(id)sender;


#pragma mark - Utilities

- (NSImage *)_image:(NSImage *)image scaledToSize:(NSSize)size;

@end

NS_ASSUME_NONNULL_END


@implementation CBHAboutWindowController


#pragma mark - Factories

+ (instancetype)controller
{
	return [[[self class] alloc] initWithWindowNibName:@"CBHAboutWindow"];
}


#pragma mark - Overrides

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

	_version = [info objectForKey:@"CFBundleShortVersionString"];
	_build = [info objectForKey:@"CFBundleVersion"];
	_versionAndBuild = NO;
	[self updateVersionField];

	string = NSLocalizedStringFromTableInBundle(@"Designed & Written by", nil, bundle, @"CBHAboutWindowController::author");
	[self setAuthor:[NSString stringWithFormat:@"%@ %@", string, @"Chris Huxtable"]];

	string = NSLocalizedStringFromTableInBundle(@"Copyright", nil, bundle, @"CBHAboutWindowController::copyright");
	NSString *reserved = NSLocalizedStringFromTableInBundle(@"All rights reserved", nil, bundle, @"CBHAboutWindowController::reserved");
	[self setCopyright:[NSString stringWithFormat:@"%@ %@. %@.", string, @"© 2019 Chris Huxtable", reserved]];

	[_websiteButton setTitle:NSLocalizedStringFromTableInBundle(@"Website", nil, bundle, @"CBHAboutWindowController::website")];
	[self setWebsiteURL:[NSURL URLWithString:@"https://huxtable.ca/apps"]];
}


#pragma mark - Properties

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
	_version = [version copy];
	[self updateVersionField];
}

- (NSString *)version
{
	return _version;
}

- (void)setBuild:(NSString *)build
{
	_build = [build copy];
	[self updateVersionField];
}

- (NSString *)build
{
	return _build;
}

- (void)setVersion:(NSString *)version withBuild:(NSString *)build
{
	_version = [version copy];
	_build = [build copy];

	[self updateVersionField];
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


#pragma mark - Actions

- (IBAction)openWebsite:(id)sender
{
	if ( !_websiteURL ) { return; }
	[[NSWorkspace sharedWorkspace] openURL:_websiteURL];
}

- (IBAction)swapVersion:(id)sender
{
	_versionAndBuild = !_versionAndBuild;
	[self updateVersionField];
}


#pragma mark - Utilities

- (NSImage *)_image:(NSImage *)image scaledToSize:(NSSize)size
{
	NSImage *outImage = [[NSImage alloc] initWithSize:size];
	NSRect rect = {NSZeroPoint, size};

	[outImage lockFocus];
	[[image bestRepresentationForRect:rect context:nil hints:nil] drawInRect:rect];
	[outImage unlockFocus];

	return outImage;
}

- (void)updateVersionField
{
	NSString *string = ( _versionAndBuild ) ? [self versionAndBuildString] : [self versionString];
	[_versionButton setTitle:string];
	[_versionButton setNeedsDisplay];
}

- (NSString *)versionString
{
	NSBundle *bundle = [NSBundle bundleWithIdentifier:@"ca.huxtable.CBHAboutWindow"];
	NSString *label = NSLocalizedStringFromTableInBundle(@"Version", nil, bundle, @"CBHAboutWindowController::version");
	return [NSString stringWithFormat:@"%@ %@", label, _version];
}

- (NSString *)versionAndBuildString
{
	NSBundle *bundle = [NSBundle bundleWithIdentifier:@"ca.huxtable.CBHAboutWindow"];
	NSString *label = NSLocalizedStringFromTableInBundle(@"Version", nil, bundle, @"CBHAboutWindowController::version");
	return [NSString stringWithFormat:@"%@ %@ (%@)", label, _version, _build];
}

@end
