//
//  Theme.swift
//  Pet Finder
//
//  Created by Jechol Lee on 6/13/16.
//  Copyright © 2016 Ray Wenderlich. All rights reserved.
//

import UIKit

let SelectedThemeKey = "SelectedTheme"

enum Theme: Int {
  case normal, dark, graphical

  var mainColor: UIColor {
    switch self {
    case .normal:
        return UIColor(red: 87.0/255.0, green: 188.0/255.0, blue: 95.0/255.0, alpha: 1.0)
    case .dark:
        return UIColor(red: 242.0/255.0, green: 101.0/255.0, blue: 34.0/255.0, alpha: 1.0)
    case .graphical:
        return UIColor(red: 10.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 1.0)
    }

  }

  var barStyle: UIBarStyle {
    switch self {
    case .normal, .graphical:
      return .default
    case .dark:
      return .black
    }
  }

  var navigationBackgroundImage: UIImage? {
    return self == .graphical ? UIImage(named: "navBackground") : nil
  }

  var tabBarBackgroundImage: UIImage? {
    return self == .graphical ? UIImage(named: "tabBarBackground") : nil
  }

  var backgroundColor: UIColor {
    switch self {
    case .normal, .graphical:
      return UIColor(white: 0.9, alpha: 1.0)
    case .dark:
      return UIColor(white: 0.8, alpha: 1.0)
    }
  }

  var secondaryColor: UIColor {
    switch self {
    case .normal:
      return UIColor(red: 242.0/255.0, green: 101.0/255.0, blue: 34.0/255.0, alpha: 1.0)
    case .dark:
      return UIColor(red: 34.0/255.0, green: 128.0/255.0, blue: 66.0/255.0, alpha: 1.0)
    case .graphical:
      return UIColor(red: 140.0/255.0, green: 50.0/255.0, blue: 48.0/255.0, alpha: 1.0)
    }
  }
}

struct ThemeManager {

  static func currentTheme() -> Theme {
    UserDefaults.standard.value(forKeyPath: SelectedThemeKey)
    if let storedTheme = (UserDefaults.standard.value(forKey: SelectedThemeKey) as AnyObject).integerValue {
      return Theme(rawValue: storedTheme)!
    } else {
      return .normal
    }
  }

  static func applyTheme(theme: Theme) {
    // 1
//    UserDefaults.standard.setValue(theme.rawValue, forKey: SelectedThemeKey)
    UserDefaults.standard.set(theme.rawValue, forKey: SelectedThemeKey)
    UserDefaults.standard.synchronize()

    // 2
    let sharedApplication = UIApplication.shared
    sharedApplication.delegate?.window??.tintColor = theme.mainColor

    UINavigationBar.appearance().barStyle = theme.barStyle
    //UINavigationBar.appearance().setBackgroundImage(theme.navigationBackgroundImage, forBarMetrics: .default)
    UINavigationBar.appearance().setBackgroundImage(theme.navigationBackgroundImage, for: .default)

    UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")
    UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrowMaskFixed")

    //
    UITabBar.appearance().barStyle = theme.barStyle
    UITabBar.appearance().backgroundImage = theme.tabBarBackgroundImage

    let tabIndicator = UIImage(named: "tabBarSelectionIndicator")?.withRenderingMode(.alwaysTemplate)
    let tabResizableIndicator = tabIndicator?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0))
    UITabBar.appearance().selectionIndicatorImage = tabResizableIndicator

    //
    let controlBackground = UIImage(named: "controlBackground")?.withRenderingMode(.alwaysTemplate)
      .resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
    let controlSelectedBackground = UIImage(named: "controlSelectedBackground")?
        .withRenderingMode(.alwaysTemplate)
        .resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))

    UISegmentedControl.appearance().setBackgroundImage(controlBackground, for: .normal,
                                                       barMetrics: .default)
    UISegmentedControl.appearance().setBackgroundImage(controlSelectedBackground, for: .selected,
                                                       barMetrics: .default)

    //
    UIStepper.appearance().setBackgroundImage(controlBackground, for: .normal)
    UIStepper.appearance().setBackgroundImage(controlBackground, for: .disabled)
    UIStepper.appearance().setBackgroundImage(controlBackground, for: .highlighted)
    UIStepper.appearance().setDecrementImage(UIImage(named: "fewerPaws"), for: .normal)
    UIStepper.appearance().setIncrementImage(UIImage(named: "morePaws"), for: .normal)

    //
    UISlider.appearance().setThumbImage(UIImage(named: "sliderThumb"), for: .normal)
    UISlider.appearance().setMaximumTrackImage(UIImage(named: "maximumTrack")?
        .resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 6.0)),
                                               for: .normal)
    UISlider.appearance().setMinimumTrackImage(UIImage(named: "minimumTrack")?
        .withRenderingMode(.alwaysTemplate)
        .resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 6.0, bottom: 0, right: 0)),
                                               for: .normal)
    UISwitch.appearance().onTintColor = theme.mainColor.withAlphaComponent(0.3)
    UISwitch.appearance().thumbTintColor = theme.mainColor


  }
}
