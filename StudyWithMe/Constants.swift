//
//  Constants.swift
//  StudyWithMe
//
//  Created by Tholg on 06/09/2024.
//

import Foundation
import UIKit

typealias TimeIntervalMilisecond = Double

class Constants {
    // Any constants access via this property in background thread could be warned, this warning can be ignored
    static var keyWindow: UIWindow? {
        if Thread.isMainThread {
            return UIApplication.shared.windows.first
        } else {
            return DispatchQueue.main.sync {
                 UIApplication.shared.windows.first
            }
        }
    }
    static var screenWidth: CGFloat {
        Self.keyWindow?.frame.width ?? 0
    }
    static var screenHeight: CGFloat {
        Self.keyWindow?.frame.height ?? 0
    }
    static var screenMaxLength: CGFloat {
        max(Self.screenWidth, Self.screenHeight)
    }
    static var screenMinLength: CGFloat {
        min(Self.screenWidth, Self.screenHeight)
    }
    static var safeAreaInsets: UIEdgeInsets {
        Self.keyWindow?.safeAreaInsets ?? .zero
    }
}
