//
//  Enemy.swift
//  Doodle
//
//  Created by Creo Server on 28/02/20.
//  Copyright © 2020 Creo Server. All rights reserved.
//

import SpriteKit

class Enemy: SKSpriteNode {
    
    let myTexture = SKTexture(imageNamed: "enemy")
    init() {
        let playerSize = CGSize(width: 30, height: 30)
        super.init(texture: nil, color: .black, size: playerSize)
        setup()
    }
    init(enemySize : CGSize) {
//        let texture = SKTexture(imageNamed: "solidLand")
//        super.init(texture: texture, color: .green, size: landingAreaSize)
        super.init(texture: nil, color: .black, size: enemySize)
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
        physicsBody?.categoryBitMask = PhysicsCategory.enemy
        physicsBody?.collisionBitMask = PhysicsCategory.none
        physicsBody?.contactTestBitMask = PhysicsCategory.player
    }
}
