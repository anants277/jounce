//
//  PhysicsCategory.swift
//  Doodle
//
//  Created by Creo Server on 19/02/20.
//  Copyright © 2020 Creo Server. All rights reserved.
//

import Foundation

struct PhysicsCategory {
    static let none : UInt32 = 0
    static let player : UInt32 = 0b1
    static let solidLandingArea : UInt32 = 0b10
    static let ground : UInt32 = 0b100
    static let fly : UInt32 = 0b11
    static let spring : UInt32 = 0b1000
    static let breakableLandingArea : UInt32 = 0b10000
    static let bullet : UInt32 = 0b100000
    static let enemy : UInt32 = 0b1000000
    static let movableLandingArea : UInt32 = 0b100000
    static let RingArea : UInt32 = 0b1000000
    static let basketSensor : UInt32 = 0b10000000
    static let roundObstacle : UInt32 = 0b100000000
}
