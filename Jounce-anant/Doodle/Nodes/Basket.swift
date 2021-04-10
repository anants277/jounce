//
//  Basket.swift
//  Doodle
//
//  Created by Creo Server on 04/03/20.
//  Copyright © 2020 Creo Server. All rights reserved.
//

import Foundation
import SpriteKit

class Basket: SKSpriteNode {
    let basketTexture: SKTexture = SKTexture(imageNamed: "basketHoop")
    var leftRing : SKSpriteNode!
    var rightRing : SKSpriteNode!
    var basketSensor : SKSpriteNode!
    init(basketSize : CGSize) {
        super.init(texture: basketTexture, color: .red, size: basketTexture.size())
        leftRing = SKSpriteNode(color: .clear, size: CGSize(width: 5, height: 5))
        rightRing = SKSpriteNode(color: .clear, size: CGSize(width: 5, height: 5))
        basketSensor = SKSpriteNode(color: .orange, size: CGSize(width: 5, height: 5))
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addChild(leftRing)
        leftRing.position = CGPoint(x: -basketTexture.size().width/2, y: basketTexture.size().height/2)
        leftRing.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 5, height: 5))
        leftRing.physicsBody?.isDynamic = false
        leftRing.physicsBody?.categoryBitMask = PhysicsCategory.RingArea
        leftRing.physicsBody?.collisionBitMask = PhysicsCategory.player
        leftRing.physicsBody?.contactTestBitMask = PhysicsCategory.none
        
        
        addChild(rightRing)
        rightRing.position = CGPoint(x: basketTexture.size().width/2, y: basketTexture.size().height/2)
        rightRing.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 5, height: 5))
        rightRing.physicsBody?.isDynamic = false
        rightRing.physicsBody?.categoryBitMask = PhysicsCategory.RingArea
        rightRing.physicsBody?.collisionBitMask = PhysicsCategory.player
        rightRing.physicsBody?.contactTestBitMask = PhysicsCategory.none
        
        addChild(basketSensor)
        basketSensor.position = CGPoint.zero
        basketSensor.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 5, height: 5))
        basketSensor.physicsBody?.isDynamic = false
        basketSensor.physicsBody?.categoryBitMask = PhysicsCategory.basketSensor
        basketSensor.physicsBody?.collisionBitMask = PhysicsCategory.none
        basketSensor.physicsBody?.contactTestBitMask = PhysicsCategory.player
    }
}
