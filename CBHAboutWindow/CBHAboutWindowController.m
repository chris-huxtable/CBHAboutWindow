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

	NSImage *_icon;
	NSString *_title;

	NSString *_version;
	NSString *_build;
	BOOL _shouldShowVersionAndBuild;

	NSString *_author;
	NSString *_copyright;

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


#pragma mark - Initialization

- (instancetype)initWithWindow:(NSWindow *)window
{
	if ( (self = [super initWithWindow:window]) )
	{
		[self setup];
	}

	return self;
}


#pragma mark - Life Cycle

- (void)setup
{
	NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
	NSBundle *bundle = [NSBundle bundleWithIdentifier:@"ca.huxtable.CBHAboutWindow"];

	_icon = [self _image:[NSImage imageNamed:NSImageNameApplicationIcon] scaledToSize:NSMakeSize(192, 192)];
	_title = [[NSRunningApplication currentApplication] localizedName];

	_version = [info objectForKey:@"CFBundleShortVersionString"];
	_build = [info objectForKey:@"CFBundleVersion"];
	_shouldShowVersionAndBuild = NO;

	NSString *string = NSLocalizedStringFromTableInBundle(@"Designed & Written by", nil, bundle, @"CBHAboutWindowController::author");
	_author = [NSString stringWithFormat:@"%@ %@", string, @"Chris Huxtable"];

	string = NSLocalizedStringFromTableInBundle(@"Copyright", nil, bundle, @"CBHAboutWindowController::copyright");
	NSString *reserved = NSLocalizedStringFromTableInBundle(@"All rights reserved", nil, bundle, @"CBHAboutWindowController::reserved");
	_copyright = [NSString stringWithFormat:@"%@ %@. %@.", string, @"© 2019 Chris Huxtable", reserved];

	_websiteURL = [NSURL URLWithString:@"https://huxtable.ca/apps"];
}

- (void)windowDidLoad
{
	NSBundle *bundle = [NSBundle bundleWithIdentifier:@"ca.huxtable.CBHAboutWindow"];

	NSWindow *window = [self window];
	[window setBackgroundColor:[NSColor controlColor]];
	[window setMovableByWindowBackground:YES];

	NSString *string = NSLocalizedStringFromTableInBundle(@"About %@", nil, bundle, @"CBHAboutWindowController::window.title");
	[window setTitle:[NSString stringWithFormat:string, _title]];

	[_iconView setImage:_icon];
	[_titleField setStringValue:_title];

	[self updateVersionField];

	[_authorField setStringValue:_author];
	[_copyrightField setStringValue:_copyright];

	[_websiteButton setTitle:NSLocalizedStringFromTableInBundle(@"Website", nil, bundle, @"CBHAboutWindowController::website")];
}


#pragma mark - Icon and Title

@synthesize icon = _icon;

- (void)setIcon:(NSImage *)icon
{
	_icon = [self _image:icon scaledToSize:NSMakeSize(192, 192)];
	[_iconView setImage:_icon];
}


@synthesize title = _title;

- (void)setTitle:(NSString *)title
{
	_title = [title copy];
	[_titleField setStringValue:_title];
}


#pragma mark - Version and Build

@synthesize version = _version;

- (void)setVersion:(NSString *)version
{
	_version = [version copy];
	[self updateVersionField];
}


@synthesize build = _build;

- (void)setBuild:(NSString *)build
{
	_build = [build copy];
	[self updateVersionField];
}


- (void)setVersion:(NSString *)version andBuild:(NSString *)build
{
	_version = [version copy];
	_build = [build copy];

	[self updateVersionField];
}


@synthesize shouldShowVersionAndBuild = _shouldShowVersionAndBuild;

- (void)setShouldShowVersionAndBuild:(BOOL)flag
{
	if ( _shouldShowVersionAndBuild == flag ) { return; }
	_shouldShowVersionAndBuild = flag;

	[self updateVersionField];
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

- (void)updateVersionField
{
	NSString *string = ( _shouldShowVersionAndBuild ) ? [self versionAndBuildString] : [self versionString];
	[_versionButton setTitle:string];
	[_versionButton setNeedsDisplay];
}


#pragma mark - Author and Copyright

@synthesize author = _author;

- (void)setAuthor:(NSString *)author
{
	_author = [author copy];
	[_authorField setStringValue:_author];
}


@synthesize copyright = _copyright;

- (void)setCopyright:(NSString *)copyright
{
	_copyright = [copyright copy];
	[_copyrightField setStringValue:_copyright];
}


#pragma mark - Website

@synthesize websiteURL = _websiteURL;

- (IBAction)openWebsite:(id)sender
{
	if ( _websiteURL ) { [[NSWorkspace sharedWorkspace] openURL:_websiteURL]; }
}

- (IBAction)swapVersion:(id)sender
{
	[self setShouldShowVersionAndBuild:!_shouldShowVersionAndBuild];
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

@end
