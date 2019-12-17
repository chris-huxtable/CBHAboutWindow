<p align="center">
  <img src="https://user-images.githubusercontent.com/2386387/70958341-f21ce180-2046-11ea-9197-7bea3dd1178e.png">
</p>

# CBHAboutWindow

[![release](https://img.shields.io/github/release/chris-huxtable/CBHAboutWindow.svg)](https://github.com/chris-huxtable/CBHAboutWindow/releases)
[![pod](https://img.shields.io/cocoapods/v/CBHAboutWindow.svg)](https://cocoapods.org/pods/CBHAboutWindow)
[![licence](https://img.shields.io/badge/licence-ISC-lightgrey.svg?cacheSeconds=2592000)](https://github.com/chris-huxtable/CBHAboutWindow/blob/master/LICENSE)
[![coverage](https://img.shields.io/badge/coverage-95%25-brightgreen.svg?cacheSeconds=2592000)](https://github.com/chris-huxtable/CBHAboutWindow)

A fancier about window. Designed for my ease-of-use, but flexible enough for anyone.

## Examples:

Adding a controller so that once the window is closed both the window and controller are released.
```objective-c
CBHAboutWindowController *controller = [CBHAboutWindowController controller];

/// Setup...
[controller setTitle:@"Great Western Railway"];
[controller setVersion:@"1.0.0β"];
[controller setAuthor:@"Engineered by Isambard Kingdom Brunel"];
[controller setCopyright:@"Copyright © 1835 Isambard Kingdom Brunel. All rights reserved."];

[controller setWebsiteURL:[NSURL URLWithString:@"https://en.wikipedia.org/wiki/Great_Western_Railway"]];

[controller showWindow:self];
```


## Licence
CBHAboutWindow is available under the [ISC license](https://github.com/chris-huxtable/CBHAboutWindow/blob/master/LICENSE).
