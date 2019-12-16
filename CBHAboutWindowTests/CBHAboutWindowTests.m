//  CBHAboutWindowTests.m
//  CBHAboutWindowTests
//
//  Created by Christian Huxtable <chris@huxtable.ca>, December 2019.
//  Copyright (c) 2019 Christian Huxtable. All rights reserved.

@import XCTest;
@import CBHAboutWindow;

@import Foundation.NSBundle;

#import "NSBundle+CBHAboutWindowTests.h"
#import "NSImage+Scaling.h"


@interface CBHAboutWindowTests : XCTestCase
{
	CBHAboutWindowController *_aboutController;
}
@end


@implementation CBHAboutWindowTests

- (void)setUp
{
	[super setUp];

	_aboutController = [CBHAboutWindowController controller];
	[_aboutController showWindow:self];
}


#pragma mark - Properties

- (void)testIcon
{
	NSData *expected = [[[NSImage imageNamed:NSImageNameApplicationIcon] imageScaledToSize:NSMakeSize(192, 192)] TIFFRepresentation];
	NSData *icon = [[_aboutController icon] TIFFRepresentation];
	XCTAssertEqualObjects(icon, expected, @"Auto-configured icon should be correct.");

	expected = [[[NSImage imageNamed:NSImageNameComputer] imageScaledToSize:NSMakeSize(192, 192)] TIFFRepresentation];
	[_aboutController setIcon:[NSImage imageNamed:NSImageNameComputer]];
	icon = [[_aboutController icon] TIFFRepresentation];
	XCTAssertEqualObjects(icon, expected, @"Manually configured icon should be correct.");
}

- (void)testTitle
{
	NSString *expected = @"xctest";
	NSString *title = [_aboutController title];
	XCTAssertEqualObjects(title, expected, @"Auto-configured title should be correct.");

	expected = @"DifferentTitle";
	[_aboutController setTitle:expected];
	title = [_aboutController title];

	XCTAssertEqualObjects(title, expected, @"Manually configured title should be correct.");
}

- (void)testVersion
{
	NSString *expected = @"1.0.0";
	NSString *version = [_aboutController version];
	XCTAssertEqualObjects(version, expected, @"Auto-configured version should be correct.");

	expected = @"1.1.0β";
	[_aboutController setVersion:expected];
	version = [_aboutController version];
	XCTAssertEqualObjects(version, expected, @"Manually configured version should be correct.");
}

- (void)testBuild
{
	NSString *expected = @"2";
	NSString *build = [_aboutController build];
	XCTAssertEqualObjects(build, expected, @"Auto-configured build should be correct.");

	expected = @"4";
	[_aboutController setBuild:expected];
	build = [_aboutController build];
	XCTAssertEqualObjects(build, expected, @"Manually configured build should be correct.");
}

- (void)testVersionAndBuild
{
	NSString *expectedVersion = @"1.0.0";
	NSString *expectedBuild = @"2";
	NSString *version = [_aboutController version];
	NSString *build = [_aboutController build];
	XCTAssertEqualObjects(version, expectedVersion, @"Auto-configured version should be correct.");
	XCTAssertEqualObjects(build, expectedBuild, @"Auto-configured build should be correct.");

	NSString *versionString = [_aboutController versionString];
	XCTAssertEqualObjects(versionString, @"Version 1.0.0", @"Manually configured version string should be correct.");

	NSString *versionAndBuildString = [_aboutController versionAndBuildString];
	XCTAssertEqualObjects(versionAndBuildString, @"Version 1.0.0 (2)", @"Manually configured version and build string should be correct.");


	expectedVersion = @"1.1.0β";
	expectedBuild = @"4";
	[_aboutController setVersion:expectedVersion andBuild:expectedBuild];
	version = [_aboutController version];
	build = [_aboutController build];
	XCTAssertEqualObjects(version, expectedVersion, @"Manually configured version should be correct.");
	XCTAssertEqualObjects(build, expectedBuild, @"Manually configured build should be correct.");

	versionString = [_aboutController versionString];
	XCTAssertEqualObjects(versionString, @"Version 1.1.0β", @"Manually configured version string should be correct.");

	versionAndBuildString = [_aboutController versionAndBuildString];
	XCTAssertEqualObjects(versionAndBuildString, @"Version 1.1.0β (4)", @"Manually configured version and build string should be correct.");


	XCTAssertEqual([_aboutController shouldShowVersionAndBuild], NO, @"Auto-configured configured flag should be correct.");
	[_aboutController setShouldShowVersionAndBuild:YES];
	XCTAssertEqual([_aboutController shouldShowVersionAndBuild], YES, @"Manually configured flag should be correct.");
	[_aboutController setShouldShowVersionAndBuild:YES];
	XCTAssertEqual([_aboutController shouldShowVersionAndBuild], YES, @"Manually configured flag should still be correct.");

}

- (void)testAuthor
{
	NSString *expected = @"Designed & Written by Chris Huxtable";
	NSString *author = [_aboutController author];
	XCTAssertEqualObjects(author, expected, @"Auto-configured author should be correct.");

	expected = @"Engineered by Isambard Kingdom Brunel";
	[_aboutController setAuthor:expected];
	author = [_aboutController author];
	XCTAssertEqualObjects(author, expected, @"Manually configured author should be correct.");
}

- (void)testCopyright
{
	NSString *expected = @"Copyright © 2019 Chris Huxtable. All rights reserved.";
	NSString *copyright = [_aboutController copyright];
	XCTAssertEqualObjects(copyright, expected, @"Auto-configured copyright should be correct.");

	expected = @"Engineered by Isambard Kingdom Brunel";
	[_aboutController setCopyright:expected];
	copyright = [_aboutController copyright];
	XCTAssertEqualObjects(copyright, expected, @"Manually configured copyright should be correct.");
}

- (void)testWebsiteURL
{
	NSURL *expected = [NSURL URLWithString:@"https://huxtable.ca/apps"];
	NSURL *website = [_aboutController websiteURL];
	XCTAssertEqualObjects(website, expected, @"Auto-configured website should be correct.");

	expected = [NSURL URLWithString:@"https://example.com"];
	[_aboutController setWebsiteURL:expected];
	website = [_aboutController websiteURL];
	XCTAssertEqualObjects(website, expected, @"Manually configured website should be correct.");
}

@end
