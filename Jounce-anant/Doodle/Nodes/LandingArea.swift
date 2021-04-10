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
        super.init(texture: nil, color: .green, size: landingAreaSize)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = false
    }
}
