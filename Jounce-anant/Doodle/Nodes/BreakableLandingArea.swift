//
//  BreakableLandingArea.swift
//  Doodle
//
//  Created by Creo Server on 02/03/20.
//  Copyright © 2020 Creo Server. All rights reserved.
//

import SpriteKit

class BreakableLandingArea: SKNode {

    var size : CGSize!
    var leftLandSize : CGSize!
    var rightLandSize : CGSize!
    var leftland : SKSpriteNode!
    var rightland : SKSpriteNode!
    
    init(size : CGSize) {
        super.init()

        self.size = size
        
        leftLandSize = CGSize(width: size.width/2 - 2.5, height: size.height)
        rightLandSize = leftLandSize
        let leftTexture = SKTexture(imageNamed: "leftBrokenLand")
        let rightTexture = SKTexture(imageNamed: "leftBrokenLand")
//        leftland = SKSpriteNode(color: .brown, size: leftLandSize)
//        rightland = SKSpriteNode(color: .brown, size: rightLandSize)
        leftland = SKSpriteNode(texture: leftTexture, color: .brown, size: leftLandSize)
        rightland = SKSpriteNode(texture: rightTexture, color: .brown, size: rightLandSize)
        setup()
        setupPhysics()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
       
        self.name = "BreakableLandingArea"
        
        addChild(leftland)
        let leftLandXPos = self.position.x - leftLandSize.width/2 - 2.5
        let leftLandYPos = self.position.y
        leftland.position = CGPoint(x: leftLandXPos, y: leftLandYPos)
        
        addChild(rightland)
        let rightlandXPos = self.position.x + leftLandSize.width/2 + 2.5
        let rightLandYPos = self.position.y
        rightland.position = CGPoint(x: rightlandXPos, y: rightLandYPos)
        
        
    }
    
    func setupPhysics() {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = PhysicsCategory.breakableLandingArea
        physicsBody?.contactTestBitMask = PhysicsCategory.player
    }
    
    func breakLand(landPosition : CGPoint) {
        leftland.zRotation = -0.5
        rightland.zRotation = 0.5
        let endPoint = CGPoint(x: landPosition.x , y: landPosition.y - UIScreen.main.bounds.height/2)
        let moveLandingArea = SKAction.move(to: endPoint, duration: 1)
        let deleteLandindArea = SKAction.removeFromParent()
        let landingAreaSequence = SKAction.sequence([moveLandingArea,deleteLandindArea])
        self.run(landingAreaSequence)
    }
}


