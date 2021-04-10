//
//  File.swift
//  Doodle
//
//  Created by Creo Server on 19/02/20.
//  Copyright © 2020 Creo Server. All rights reserved.
//

import SpriteKit

class SolidLandingArea : SKSpriteNode {
    
    init() {
        let landingAreaSize = CGSize(width: 80, height: 20)
//        let texture = SKTexture(imageNamed: "solidLand")
//        super.init(texture: texture, color: .green, size: landingAreaSize)
        super.init(texture: nil, color: .green, size: landingAreaSize)
        setup()
    }
    
    init(landSize : CGSize) {
        let texture = SKTexture(imageNamed: "solidLand")
//        super.init(texture: texture, color: .green, size: landingAreaSize)
        super.init(texture: texture , color: .green, size: landSize)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        self.name = "SolidLandingArea"
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = PhysicsCategory.solidLandingArea
//        physicsBody?.collisionBitMask = PhysicsCategory.player
        physicsBody?.contactTestBitMask = PhysicsCategory.player
        
    }
}

