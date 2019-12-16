//  NSBundle+CBHAboutWindowTests.m
//  CBHAboutWindowTests
//
//  Created by Christian Huxtable <chris@huxtable.ca>, December 2019.
//  Copyright (c) 2019 Christian Huxtable. All rights reserved.

#import "NSBundle+CBHAboutWindowTests.h"

#import "NSObject+Swizzle.h"


@implementation NSBundle (CBHAboutWindowTests)

+ (void)load
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		[self swizzleSelector:@selector(mainBundle) withSelector:@selector(testBundle)];
	});
}

+ (NSBundle *)testBundle
{
	return [NSBundle bundleWithIdentifier:@"ca.huxtable.CBHAboutWindowTests"];
}

@end
