//
//  Bullet.swift
//  Doodle
//
//  Created by Creo Server on 28/02/20.
//  Copyright © 2020 Creo Server. All rights reserved.
//

import UIKit
import SpriteKit
class Bullet: SKSpriteNode {
    let myTexture = SKTexture(imageNamed: "bullet")
    init() {
        let bulletSize = CGSize(width: 10, height: 10)
        super.init(texture: nil, color: .red, size: bulletSize)
        setup()
    }
    init(bulletSize : CGSize) {
//        let texture = SKTexture(imageNamed: "solidLand")
//        super.init(texture: texture, color: .green, size: landingAreaSize)
        super.init(texture: nil, color: .red, size: bulletSize)
        setup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.allowsRotation = false
        physicsBody?.categoryBitMask = PhysicsCategory.bullet
        physicsBody?.collisionBitMask = PhysicsCategory.none
        physicsBody?.contactTestBitMask = PhysicsCategory.enemy
    }
    
}
