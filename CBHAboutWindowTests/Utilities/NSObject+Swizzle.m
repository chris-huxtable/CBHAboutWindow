//  NSObject+Swizzle.m
//  CBHAboutWindowTests
//
//  Created by Christian Huxtable <chris@huxtable.ca>, December 2019.
//  Copyright (c) 2019 Christian Huxtable. All rights reserved.

#import "NSObject+Swizzle.h"

@import ObjectiveC.runtime;


@implementation NSObject (Swizzle)

#pragma mark - Swizzling

+ (BOOL)swizzleSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector
{
	Class class = object_getClass((id)self);

	Method originalMethod = class_getClassMethod(class, originalSelector);
	Method swizzledMethod = class_getClassMethod(class, swizzledSelector);

	if ( class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)) )
	{
		class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
	}
	else
	{
		method_exchangeImplementations(originalMethod, swizzledMethod);
	}

	return YES;
}

- (BOOL)swizzleSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector
{
	Class class = [self class];

	Method originalMethod = class_getInstanceMethod(class, originalSelector);
	Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

	if ( class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)) )
	{
		class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
	}
	else
	{
		method_exchangeImplementations(originalMethod, swizzledMethod);
	}

	return YES;
}

@end
