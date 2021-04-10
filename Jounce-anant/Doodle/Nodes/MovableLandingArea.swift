//
//  MovableLandingArea.swift
//  Doodle
//
//  Created by Creo Server on 02/03/20.
//  Copyright © 2020 Creo Server. All rights reserved.
//

import SpriteKit

class MovableLandingArea : SKSpriteNode {
    
    init() {
        let landingAreaSize = CGSize(width: 80, height: 20)
        super.init(texture: nil, color: .gray, size: landingAreaSize)
        setup()
    }
    init(landSize : CGSize) {
        let texture = SKTexture(imageNamed: "movableLand")
//        super.init(texture: texture, color: .green, size: landingAreaSize)
        super.init(texture: texture, color: .gray, size: landSize)
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
        physicsBody?.categoryBitMask = PhysicsCategory.movableLandingArea
        physicsBody?.contactTestBitMask = PhysicsCategory.player
    }
    
    func move() {
        let landXPosition = self.position.x
        let minLandXPosition = CGFloat(40)
        let maxLandXPosition = UIScreen.main.bounds.width - 40
        let firstDuration = (landXPosition - minLandXPosition) / (maxLandXPosition - minLandXPosition) * 2
        let startPoint = CGPoint(x: 40 , y: self.position.y )
        let endPoint = CGPoint(x: UIScreen.main.bounds.width - 40 , y: self.position.y )
        let moveLandingAreaLeftForFirstTime = SKAction.move(to: startPoint, duration: TimeInterval(firstDuration))
        let moveLandingAreaLeft = SKAction.move(to: startPoint, duration: 2)
        let moveLandingAreaRight = SKAction.move(to: endPoint, duration: 2)
        let landingAreaSequence = SKAction.sequence([moveLandingAreaRight,moveLandingAreaLeft])
        self.run(moveLandingAreaLeftForFirstTime) {
            self.run(SKAction.repeatForever(landingAreaSequence))
        }
    }
}

