//
//  Spring.swift
//  Doodle
//
//  Created by Creo Server on 28/02/20.
//  Copyright © 2020 Creo Server. All rights reserved.
//

import UIKit
import SpriteKit
class Spring: SKSpriteNode {
    let myTexture = SKTexture(imageNamed: "spring")
    var springSize = CGSize(width: 10, height: 20)
    let springPhySize = CGSize(width: 10, height: 20)
    init() {
        super.init(texture: myTexture, color: .red, size: springSize)
        setup()
    }
    init(springSize : CGSize) {
//        let texture = SKTexture(imageNamed: "solidLand")
//        super.init(texture: texture, color: .green, size: landingAreaSize)
        super.init(texture: nil, color: .red, size: springSize)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.allowsRotation = false
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = PhysicsCategory.spring
        physicsBody?.collisionBitMask = PhysicsCategory.none
        physicsBody?.contactTestBitMask = PhysicsCategory.player
    }
}
