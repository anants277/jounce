//
//  File.swift
//  Doodle
//
//  Created by Creo Server on 19/02/20.
//  Copyright © 2020 Creo Server. All rights reserved.
//

import SpriteKit

class Ground : SKSpriteNode {
    
    init(size : CGSize) {
        let groundSize = CGSize(width: size.width, height: 40)
        super.init(texture: nil, color: .brown, size: groundSize)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = PhysicsCategory.ground
        physicsBody?.collisionBitMask = PhysicsCategory.none
        physicsBody?.contactTestBitMask = PhysicsCategory.player
    }
}
