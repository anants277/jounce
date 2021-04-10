//
//  File.swift
//  Doodle
//
//  Created by Creo Server on 24/02/20.
//  Copyright © 2020 Creo Server. All rights reserved.
//

import Foundation
import UIKit
class Utilities {
    
    class func random(min : CGFloat , max : CGFloat) -> CGFloat {
        return CGFloat(Float(arc4random()) / 4294967296) * (max-min) + min
    }
    
    class func makeTopViewString(text1: String , text2: String) -> NSMutableAttributedString {
        let attrs1 = [NSAttributedString.Key.font : UIFont.italicSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.black]
        let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 23), NSAttributedString.Key.foregroundColor : UIColor.black]
        let attributedString1 = NSMutableAttributedString(string:text1+"\n", attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:text2, attributes:attrs2)
        attributedString1.append(attributedString2)
        return attributedString1
    }
    
    class func makeLivesString(text: String ) -> NSMutableAttributedString {
        let attrs1 = [NSAttributedString.Key.font : UIFont.italicSystemFont(ofSize: 30), NSAttributedString.Key.foregroundColor : UIColor.black]
        let attrs3 = [NSAttributedString.Key.font : UIFont.italicSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.black]
        let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 23), NSAttributedString.Key.foregroundColor : UIColor.black]
        let attributedString1 = NSMutableAttributedString(string:"❤️", attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:text, attributes:attrs2)
        let attributedString3 = NSMutableAttributedString(string:"X ", attributes:attrs3)
        attributedString1.append(attributedString3)
        attributedString1.append(attributedString2)
        return attributedString1
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}

extension UIDevice {
    var iPhoneX: Bool { UIScreen.main.nativeBounds.height == 2436 }
    var iPhone: Bool { UIDevice.current.userInterfaceIdiom == .phone }
    var iPad: Bool { UIDevice().userInterfaceIdiom == .pad }
    enum ScreenType: String {
        case iPhones_4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_X_XS = "iPhone X or iPhone XS"
        case iPhone_XR_11 = "iPhone XR or iPhone 11"
        case iPhone_XSMax_ProMax = "iPhone XS Max or iPhone Pro Max"
        case iPhone_11Pro = "iPhone 11 Pro"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1792:
            return .iPhone_XR_11
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2426:
            return .iPhone_11Pro
        case 2436:
            return .iPhones_X_XS
        case 2688:
            return .iPhone_XSMax_ProMax
        default:
            return .unknown
        }
    }

}
