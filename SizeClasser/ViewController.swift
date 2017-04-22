//
//  ViewController.swift
//  SizeClasser
//
//  Created by Cem Olcay on 22/04/2017.
//  Copyright © 2017 cemolcay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var label: UILabel?

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    update()
  }

  func update(for traitCollection: UITraitCollection? = nil) {
    guard let trait = SizeClasser(traitCollection: traitCollection ?? super.traitCollection) else { return }
    var text = ""
    if trait.contains(.portrait) {
      text += "Portrait\n"
    }
    if trait.contains(.landscape) {
      text += "Landscape\n"
    }
    if trait.contains(.iPhonePortrait) {
      text += "iPhone Portrait\n"
    }
    if trait.contains(.iPhoneLandscape) {
      text += "iPhone Landscape\n"
    }
    if trait.contains(.iPadPortrait) {
      text += "iPad Portrait\n"
    }
    if trait.contains(.iPadLandscape) {
      text += "iPad Landscape\n"
    }
    if trait.contains(.iPadSplitOneThird) {
      text += "Split View 1/3\n"
    }
    if trait.contains(.iPadSplitHalf) {
      text += "Split View 1/2\n"
    }
    if trait.contains(.iPadSplitTwoThird) {
      text += "Split View 2/3\n"
    }
    if SizeClasser.isiPadPro {
      text += "iPad Pro"
    }
    label?.text = text
  }
}

