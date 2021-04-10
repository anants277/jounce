//
//  Cannon.swift
//  Doodle
//
//  Created by Creo Server on 06/03/20.
//  Copyright © 2020 Creo Server. All rights reserved.
//

import SpriteKit
class CannonBall : SKSpriteNode {
    let myTexture = SKTexture(imageNamed: "cannonBall")
    var CannonBallSize = CGSize(width: 40, height: 40)
    let CannonBallPhySize = CGSize(width: 40, height: 40)
    
    init(CannonBallSize : CGSize) {
        if CannonBallSize.width > CannonBallSize.height {
            self.CannonBallSize = CGSize(width: CannonBallSize.width, height: CannonBallSize.width)
        }
        else {
            self.CannonBallSize = CGSize(width: CannonBallSize.height, height: CannonBallSize.height)
        }
        super.init(texture: myTexture, color: .green, size: myTexture.size())
        setup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
       
//        physicsBody = SKPhysicsBody(rectangleOf: playerSize)
        physicsBody = SKPhysicsBody(circleOfRadius: self.CannonBallSize.width/2)
//        physicsBody = SKPhysicsBody(texture: myTexture, size: playerPhySize)
//        physicsBody?.allowsRotation = false
        physicsBody?.categoryBitMask = PhysicsCategory.roundObstacle
        physicsBody?.collisionBitMask = PhysicsCategory.player
        physicsBody?.contactTestBitMask = PhysicsCategory.player
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
//        physicsBody?.mass = 0.08
//        physicsBody?.density = 1.0
    }
    
}
