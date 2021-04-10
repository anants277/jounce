//
//  Constants.swift
//  Doodle
//
//  Created by Creo Server on 03/03/20.
//  Copyright © 2020 Creo Server. All rights reserved.
//

import Foundation
import UIKit
class Constants: NSObject {
    
    static let referenceSize =  CGSize(width: 1242, height: 2688)
    static let deviceSize = CGSize(width: UIScreen.main.nativeBounds.width, height: UIScreen.main.nativeBounds.height)
    static var XscaleFactor : CGFloat!
    static var YscaleFactor : CGFloat!
    static var factor : CGFloat!
    static var playerSize : CGSize!
    static var landSize : CGSize!
    static var enemySize : CGSize!
    static var springSize : CGSize!
    static var nodgeHeight : CGFloat!
//    static var topViewSize : CGSize!
    static var sideForce : CGFloat!
    static var jumpimpulse : CGFloat!
    
    static func calculateAssetsSize() {
        XscaleFactor = deviceSize.width/referenceSize.width
        YscaleFactor = deviceSize.height/referenceSize.height
        factor = XscaleFactor*YscaleFactor
        playerSize = CGSize(width: 40 * sqrt(XscaleFactor), height: 40 * sqrt(YscaleFactor))
        landSize = CGSize(width: 80 * sqrt(XscaleFactor), height: 20 * sqrt(YscaleFactor))
        enemySize = CGSize(width: 30 * sqrt(XscaleFactor), height: 30 * sqrt(YscaleFactor))
        springSize = CGSize(width: 5 * sqrt(XscaleFactor), height: 5 * sqrt(YscaleFactor))
        sideForce = 0.5 * sqrt(XscaleFactor * YscaleFactor)
        jumpimpulse = 55 * sqrt(XscaleFactor * YscaleFactor)
        nodgeHeight = UIApplication.shared.windows.first?.safeAreaInsets.top
//        topViewSize = CGSize(width: 414 * sqrt(XscaleFactor), height: 50 * sqrt(YscaleFactor))
        
        
        
        
//        playerSize = CGSize(width: 30 * (XscaleFactor), height: 60 * (YscaleFactor))
//        landSize = CGSize(width: 80 * (XscaleFactor), height: 20 * (YscaleFactor))
//        enemySize = CGSize(width: 30 * (XscaleFactor), height: 30 * (YscaleFactor))
//        springSize = CGSize(width: 5 * (XscaleFactor), height: 5 * (YscaleFactor))
//        sideForce = 0.5 * sqrt(XscaleFactor * YscaleFactor)
//        jumpimpulse = 70 * sqrt(YscaleFactor * YscaleFactor)
        
        
        
        
        
//        switch UIDevice.current.screenType {
//        case .iPhones_4_4S :
//            playerSize = CGSize(width: 15, height: 30)
//            landSize = CGSize(width: 60, height: 10)
//            enemySize = CGSize(width: 20, height: 20)
//            springSize = CGSize(width: 5, height: 5)
//            sideForce = 0
//            jumpimpulse = 0
//        case .iPhones_5_5s_5c_SE :
//            playerSize = CGSize(width: 15, height: 30)
//            landSize = CGSize(width: 60, height: 10)
//            enemySize = CGSize(width: 20, height: 20)
//            springSize = CGSize(width: 5, height: 5)
//            sideForce = 0
//            jumpimpulse = 0
//        case .iPhones_6_6s_7_8 :
//            playerSize = CGSize(width: 15, height: 30)
//            landSize = CGSize(width: 60, height: 10)
//            enemySize = CGSize(width: 20, height: 20)
//            springSize = CGSize(width: 5, height: 5)
//            sideForce = 0
//            jumpimpulse = 0
//        case .iPhone_XR_11 :
//            playerSize = CGSize(width: 15, height: 30)
//            landSize = CGSize(width: 60, height: 10)
//            enemySize = CGSize(width: 20, height: 20)
//            springSize = CGSize(width: 5, height: 5)
//            sideForce = 0
//            jumpimpulse = 0
//        case .iPhones_6Plus_6sPlus_7Plus_8Plus :
//            playerSize = CGSize(width: 15, height: 30)
//            landSize = CGSize(width: 60, height: 10)
//            enemySize = CGSize(width: 20, height: 20)
//            springSize = CGSize(width: 5, height: 5)
//            sideForce = 0
//            jumpimpulse = 0
//        case .iPhone_11Pro :
//            playerSize = CGSize(width: 15, height: 30)
//            landSize = CGSize(width: 60, height: 10)
//            enemySize = CGSize(width: 20, height: 20)
//            springSize = CGSize(width: 5, height: 5)
//            sideForce = 0
//            jumpimpulse = 0
//        case .iPhones_X_XS :
//            playerSize = CGSize(width: 30, height: 60)
//            landSize = CGSize(width: 80, height: 20)
//            enemySize = CGSize(width: 30, height: 30)
//            springSize = CGSize(width: 5, height: 5)
//            sideForce = 0
//            jumpimpulse = 0
//        case .iPhone_XSMax_ProMax :
//            playerSize = CGSize(width: 30, height: 60)
//            landSize = CGSize(width: 80, height: 20)
//            enemySize = CGSize(width: 30, height: 30)
//            springSize = CGSize(width: 5, height: 5)
//            sideForce = 0.5
//            jumpimpulse = 70
//        default :
//            playerSize = CGSize(width: 30, height: 60)
//            landSize = CGSize(width: 80, height: 20)
//            enemySize = CGSize(width: 30, height: 30)
//            springSize = CGSize(width: 5, height: 5)
//            sideForce = 0
//            jumpimpulse = 0
//        }
    }
}
