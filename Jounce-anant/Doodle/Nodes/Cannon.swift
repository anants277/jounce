//
//  Cannon.swift
//  Doodle
//
//  Created by Creo Server on 17/03/20.
//  Copyright © 2020 Creo Server. All rights reserved.
//

import Foundation
import SpriteKit
class Cannon : SKSpriteNode {
    init(cannonSize : CGSize) {
        let texture = SKTexture(imageNamed: "cannon")
//        super.init(texture: texture, color: .green, size: landingAreaSize)
        super.init(texture: texture, color: .gray, size: cannonSize)
        setup()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.name = "Cannon"
//        self.xScale = -1
//        physicsBody = SKPhysicsBody(rectangleOf: size)
//        physicsBody?.isDynamic = false
//        physicsBody?.affectedByGravity = false
//        physicsBody?.categoryBitMask = PhysicsCategory.none
//        physicsBody?.contactTestBitMask = PhysicsCategory.none
        
    }
    
    func shootCannon() {
        let cannonBall = CannonBall(CannonBallSize: Constants.playerSize)
        self.addChild(cannonBall)
        let cannonBallPosition = CGPoint(x: self.position.x , y: self.position.y)
        cannonBall.position = self.position
        cannonBall.zPosition = 5
        
        
//        let applyImpulse = SKAction.applyImpulse(CGVector(dx: 1, dy: 1), duration: 1)
//        let deleteCannonBall = SKAction.removeFromParent()
//        let cannonSequence = SKAction.sequence([applyImpulse,deleteCannonBall])
//        cannonBall.run(cannonSequence)
//        let landXPosition = self.position.x
//        let minLandXPosition = CGFloat(40)
//        let maxLandXPosition = UIScreen.main.bounds.width - 40
//        let firstDuration = (landXPosition - minLandXPosition) / (maxLandXPosition - minLandXPosition) * 2
//        let startPoint = CGPoint(x: 40 , y: self.position.y )
//        let endPoint = CGPoint(x: UIScreen.main.bounds.width - 40 , y: self.position.y )
//        let moveLandingAreaLeftForFirstTime = SKAction.move(to: startPoint, duration: TimeInterval(firstDuration))
//        let moveLandingAreaLeft = SKAction.move(to: startPoint, duration: 2)
//        let moveLandingAreaRight = SKAction.move(to: endPoint, duration: 2)
//        let landingAreaSequence = SKAction.sequence([moveLandingAreaRight,moveLandingAreaLeft])
//        self.run(moveLandingAreaLeftForFirstTime) {
//            self.run(SKAction.repeatForever(landingAreaSequence))
//        }
    }
}
