//  NSObject+Swizzle.h
//  CBHAboutWindowTests
//
//  Created by Christian Huxtable <chris@huxtable.ca>, December 2019.
//  Copyright (c) 2019 Christian Huxtable. All rights reserved.

@import Foundation;


NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzle)

+ (BOOL)swizzleSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector;
- (BOOL)swizzleSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector;

@end

NS_ASSUME_NONNULL_END
