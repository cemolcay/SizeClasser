#
#  Be sure to run `pod spec lint SizeClasser.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "SizeClasser"
  s.version      = "0.0.1"
  s.summary      = "Device specific UITraitCollection helper with split view detection for iOS."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
SizeClasser
===

Device specific `UITraitCollection` helper with split view detection for iOS.

Demo
----

![alt tag](https://github.com/cemolcay/SizeClasser/blob/master/Examples/demo.gif?raw=true)

Requirements
----

- Swift 3.0+
- iOS 8.0+

Install
----

```
use_frameworks!
pod 'SizeClasser'
```

Usage
----

[`SizeClasser`](https://github.com/cemolcay/SizeClasser/SizeClasser/SizeClasser.swift) is an `OptionSet` type struct.
You can initilize it with your viewController's `traitCollection` property to identify your current device specific orientation and split view status.

```
/// Screen height is bigger than width. Portrait mode in all devices.
public static let portrait = SizeClasser(rawValue: 1 << 0)
/// Screen width is bigger than height. Landscape mode in all devices.
public static let landscape = SizeClasser(rawValue: 1 << 1)
/// Portrait mode for iPhone devices.
public static let iPhonePortrait = SizeClasser(rawValue: 1 << 2)
/// Landscape mode for iPhone devices.
public static let iPhoneLandscape = SizeClasser(rawValue: 1 << 3)
/// Portrait mode for iPad devices.
public static let iPadPortrait = SizeClasser(rawValue: 1 << 4)
/// Landscape mode for iPad devices.
public static let iPadLandscape = SizeClasser(rawValue: 1 << 5)
/// Split mode 1/3 of visible area in iPad devices.
public static let iPadSplitOneThird = SizeClasser(rawValue: 1 << 8)
/// Split mode 1/2 of visible area in iPad devices.
public static let iPadSplitHalf = SizeClasser(rawValue: 1 << 9)
/// Split mode 2/3 of visible area in iPad devices.
public static let iPadSplitTwoThird = SizeClasser(rawValue: 1 << 10)
```

For example, if you want to detect iPad split view 1/3 on landscape orientation, simply:

```
guard let trait = SizeClasser(traitCollection: traitCollection ?? super.traitCollection) else { return }
if trait.contains([.iPadLandscape, .iPadSplitOneThird]) {
// You are on iPad, landscape and 1/3 split view mode
if SizeClasser.isiPadPro {
// You are on 12.9" iPad
} else {
// You are on regular iPad / iPad mini
}
}
```

Also you can use `SizeClasser.isiPadPro` to detect 12.9" iPad Pro if you want to layout your views more specificly.

#### Note on `traitCollectionDidChange:previousTraitCollection` function:
This function only get called if `traitCollection` changes.
If you are on iPad, either portrait or landscape mode, it won't change 1/3 split view to 2/3 split view transitions.
iOS calculates them both `compact width regular height` mode.
So, I recommend to use `viewDidLayoutSubviews:` function to detect split view changes specificly.
![alt tag](https://github.com/cemolcay/SizeClasser/blob/master/Examples/split.png?raw=true)
                   DESC

  s.homepage     = "https://github.com/cemolcay/SizeClasser"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "cemolcay" => "ccemolcay@gmail.com" }
  # Or just: s.author    = "cemolcay"
  # s.authors            = { "cemolcay" => "ccemolcay@gmail.com" }
  s.social_media_url   = "http://twitter.com/cemolcay"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # s.platform     = :ios
  s.platform     = :ios, "8.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/cemolcay/SizeClasser.git", :tag => "#{s.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "SizeClasser/SizeClasser.swift"
  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
