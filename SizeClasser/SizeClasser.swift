//
//  SizeClasser.swift
//  SizeClasser
//
//  Created by Cem Olcay on 22/04/2017.
//  Copyright © 2017 cemolcay. All rights reserved.
//

import UIKit

/// Helper `OptionSet` type struct for extending `UITraitCollection` with device specific landscape, portrait or split view mode detections.
public struct SizeClasser: OptionSet {

  // MARK: OptionSet

  public var rawValue: Int

  public init(rawValue: Int) {
    self.rawValue = rawValue
  }

  // MARK: Init

  /// Initilizes with UITraitCollection.
  /// Recommended usage is in UIViewController's `viewDidLayoutSubviews` function or with UIViewController's `traitCollection` property.
  public init?(traitCollection: UITraitCollection) {
    guard let appSize = UIApplication.shared.windows.first?.bounds.size else { return nil }
    let screenSize = UIScreen.main.bounds.size
    var sizes = SizeClasser()

    switch traitCollection.userInterfaceIdiom {
    case .phone:
      if screenSize.width > screenSize.height { // Landscape
        sizes.insert(.iPhoneLandscape)
        sizes.insert(.landscape)
      } else { // Portrait
        sizes.insert(.iPhonePortrait)
        sizes.insert(.portrait)
      }

    case .pad:
      if screenSize.width > screenSize.height { // Landscape
        sizes.insert(.iPadLandscape)
        sizes.insert(.landscape)
      } else { // Portrait
        sizes.insert(.iPadPortrait)
        sizes.insert(.portrait)
      }

      // Split View
      if screenSize != appSize {
        if screenSize.height > screenSize.width { // Portrait
          if appSize.width < screenSize.width / 2.0 {
            sizes.insert(.iPadSplitOneThird)
          } else {
            sizes.insert(.iPadSplitTwoThird)
          }
        } else { // Landscape
          let lowRange = screenSize.width - 15
          let highRange = screenSize.width + 15
          if lowRange / 2.0 <= appSize.width && appSize.width <= highRange / 2.0 {
            sizes.insert(.iPadSplitHalf)
          } else if appSize.width <= highRange / 3.0 {
            sizes.insert(.iPadSplitOneThird)
          } else {
            sizes.insert(.iPadSplitTwoThird)
          }
        }
      }

    default:
      return nil
    }

    self = sizes
  }

  // MARK: Options

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

  // MARK: Helpers

  /// Returns maximum length of screen wheater is in portrait or landscape mode.
  public static let maxScreenLength: CGFloat = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
  /// iPad Pro 12.9" maximum length of screen.
  public static let ipadProMaxScreenLength: CGFloat = 1366.0
  /// Returns `true` if device is iPad Pro 12.9"
  public static let isiPadPro = SizeClasser.maxScreenLength == SizeClasser.ipadProMaxScreenLength
}
