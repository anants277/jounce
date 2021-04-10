//
//  Player.swift
//  Doodle
//
//  Created by Creo Server on 19/02/20.
//  Copyright © 2020 Creo Server. All rights reserved.
//

import SpriteKit
var impulseScaleFactor  = 1
class Player : SKSpriteNode {
    let myTexture = SKTexture(imageNamed: "smallBall")
    var playerSize = CGSize(width: 40, height: 40)
    let playerPhySize = CGSize(width: 40, height: 40)
    
    init(playerSize : CGSize) {
        if playerSize.width > playerSize.height {
            self.playerSize = CGSize(width: playerSize.width, height: playerSize.width)
        }
        else {
            self.playerSize = CGSize(width: playerSize.height, height: playerSize.height)
        }
        super.init(texture: myTexture, color: .green, size: myTexture.size())
        setup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
       
//        physicsBody = SKPhysicsBody(rectangleOf: playerSize)
        physicsBody = SKPhysicsBody(circleOfRadius: self.playerSize.width/2)
//        physicsBody = SKPhysicsBody(texture: myTexture, size: playerPhySize)
//        physicsBody?.allowsRotation = false
        physicsBody?.categoryBitMask = PhysicsCategory.player
        physicsBody?.collisionBitMask = PhysicsCategory.RingArea | PhysicsCategory.roundObstacle
        physicsBody?.contactTestBitMask = PhysicsCategory.solidLandingArea | PhysicsCategory.enemy
//        physicsBody?.mass = 0.08
//        physicsBody?.density = 1.0
    }
}
