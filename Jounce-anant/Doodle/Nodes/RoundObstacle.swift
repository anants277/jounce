//
//  File.swift
//  Doodle
//
//  Created by Creo Server on 06/03/20.
//  Copyright © 2020 Creo Server. All rights reserved.
//

import SpriteKit
class Roundostacle : SKSpriteNode {
    let blueTexture = SKTexture(imageNamed: "blueBall")
    let pinkTexture = SKTexture(imageNamed: "pinkBall")
    let aquaTexture = SKTexture(imageNamed: "aquaBall")
    let myTextures : [SKTexture]!
    var ostacleSize = CGSize(width: 40, height: 40)
    let ostaclePhySize = CGSize(width: 40, height: 40)
    
    init(ostacleSize : CGSize) {
        myTextures  = [blueTexture,pinkTexture]
        let randomTexture = myTextures [Int(Utilities.random(min: 0, max: CGFloat(myTextures.count - 1) + 0.99))]
        if ostacleSize.width > ostacleSize.height {
            self.ostacleSize = CGSize(width: ostacleSize.width, height: ostacleSize.width)
        }
        else {
            self.ostacleSize = CGSize(width: ostacleSize.height, height: ostacleSize.height)
        }
        super.init(texture: randomTexture, color: .green, size: randomTexture.size())
        setup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
       
        physicsBody = SKPhysicsBody(circleOfRadius: self.ostacleSize.width/2)
        physicsBody?.categoryBitMask = PhysicsCategory.roundObstacle
        physicsBody?.collisionBitMask = PhysicsCategory.player
        physicsBody?.contactTestBitMask = PhysicsCategory.player
        physicsBody?.affectedByGravity = false
    }
}
