//
//  File.swift
//  Doodle
//
//  Created by Creo Server on 19/02/20.
//  Copyright © 2020 Creo Server. All rights reserved.
//

import SpriteKit

class Background : SKNode {
    
    var numberOfPosition = 0
    var wallPaper : SKSpriteNode!
    var size : CGSize!
    var possibleLandingPositions : [CGPoint] = []
    var breakableLandingPositions : [CGPoint] = []
    var solidLandingPositions : [CGPoint] = []
    var movableLandingPositions : [CGPoint] = []
    var attachmentPositions : [CGPoint] = []
    var enemyPositions : [CGPoint]!
    var springPositions : [CGPoint]!
    var cannonPositions : [CGPoint]!
    
    init(size : CGSize) {
        super.init()
        numberOfPosition = 15
        self.size = size
        wallPaper = SKSpriteNode(imageNamed: "wallpaper")
        setupWallper()
//        setupCannons()
        possibleLandingPositions = generateRandomPosition(height: size.height, numberOfPositions: 8)
        solidLandingPositions = possibleLandingPositions
        setupSolidLandingAreas()
        
        attachmentPositions = solidLandingPositions
        enemyPositions = attachmentPositions
        setupBasket(numberOfBaskets: 2)
        setupSpring(numberOfSprings: 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetAll(score : CGFloat, numberOfPositions : Int, needBreakableland: Bool, needMovableland: Bool) {
        self.removeAllChildren()
        possibleLandingPositions = []
        breakableLandingPositions = []
        solidLandingPositions = []
        movableLandingPositions = []
        self.numberOfPosition = numberOfPositions
        wallPaper = SKSpriteNode(imageNamed: "wallpaper")
        setupWallper()
//        setupCannons()
        possibleLandingPositions = generateRandomPosition(height: size.height, numberOfPositions: numberOfPositions)
        if needBreakableland {
            generateBreakableLandPosition(numberOfLand: 4)
            setupBreakableLandingAreas()
        }
        if needMovableland {
            generateMovableLandPosition(numberOfLand: 4)
            setupMovableLandingAreas()
        }
        solidLandingPositions = possibleLandingPositions
        attachmentPositions = solidLandingPositions
        setupSolidLandingAreas()
        if score > 100 {
            setupBasket(numberOfBaskets: 2)
            setupSpring(numberOfSprings: 2)
        }
        else if score > 800 {
            setupBasket(numberOfBaskets: 1)
            setupSpring(numberOfSprings: 2)
        }
        else if score > 1200 {
            setupBasket(numberOfBaskets: 1)
            setupSpring(numberOfSprings: 2)
        }
        else if score > 1600 {
            setupBasket(numberOfBaskets: 1)
            setupSpring(numberOfSprings: 2)
        }
    }
    
    func generateBreakableLandPosition(numberOfLand : Int) {
        for i in stride(from: 0, to: self.possibleLandingPositions.count - 1, by: numberOfLand) {
            var index = 0
            if i+numberOfLand < self.possibleLandingPositions.count - 1 {
                index = Int(Utilities.random(min: CGFloat(i), max: CGFloat(i+numberOfLand)))
            }
            else {
                index = Int(Utilities.random(min: CGFloat(i), max: CGFloat(possibleLandingPositions.count-1)))
            }
            breakableLandingPositions.append(possibleLandingPositions[index])
            possibleLandingPositions.remove(at: index)
        }
    }
    
    func generateMovableLandPosition(numberOfLand : Int) {
        for i in stride(from: 0, to: self.possibleLandingPositions.count - 1, by: numberOfLand) {
            var index = 0
            if i+numberOfLand < self.possibleLandingPositions.count - 1 {
                index = Int(Utilities.random(min: CGFloat(i), max: CGFloat(i+numberOfLand)))
            }
            else {
                index = Int(Utilities.random(min: CGFloat(i), max: CGFloat(possibleLandingPositions.count-1)))
            }
            movableLandingPositions.append(possibleLandingPositions[index])
            possibleLandingPositions.remove(at: index)
        }
    }
    
    func setupWallper() {
        addChild(wallPaper)
        wallPaper.size = size
        wallPaper.anchorPoint = CGPoint(x: 0, y: 0)
        wallPaper.zPosition = -1
    }
    
    func setupSolidLandingAreas() {
        for solidLandingPosition in solidLandingPositions {
            let landingArea = SolidLandingArea(landSize: Constants.landSize)
            landingArea.zPosition = 1
            landingArea.position = solidLandingPosition
            addChild(landingArea)
        }
    }
    
    func setupBreakableLandingAreas() {
        for breakableLandingPosition in breakableLandingPositions {
            let landingArea = BreakableLandingArea(size: Constants.landSize)
            landingArea.zPosition = 1
            landingArea.position = breakableLandingPosition
            addChild(landingArea)
        }
    }
    
    func setupMovableLandingAreas() {
        for movableLandingPosition in movableLandingPositions {
            let landingArea = MovableLandingArea(landSize: Constants.landSize)
            landingArea.zPosition = 1
            landingArea.position = movableLandingPosition
            addChild(landingArea)
            landingArea.move()
        }
    }
    
    func setupBasket(numberOfBaskets : Int ) {
        enemyPositions = attachmentPositions
        for _ in 0...numberOfBaskets-1 {
            let basket = Basket(basketSize: Constants.playerSize)
            addChild(basket)
            let index = Int(Utilities.random(min: 0, max: CGFloat(attachmentPositions.count-1)))
            let position = CGPoint(x: enemyPositions[index].x, y: enemyPositions[index].y+50 )
            basket.position = position
            basket.zPosition = 4
            attachmentPositions.remove(at: index)
        }
    }
    
    func setupCannons() {
        let cannonPositions = generateCannonPosition(height: size.height, numberOfCannon: 2)
        for cannonPosition in cannonPositions {
            let cannon = Cannon(cannonSize : CGSize(width: 100, height: 100))
            addChild(cannon)
            cannon.position = cannonPosition
            cannon.zPosition = 5
            cannon.xScale = -1
//            cannon.shootCannon()
            let cannonBall = CannonBall(CannonBallSize: Constants.playerSize)
            self.addChild(cannonBall)
            cannonBall.position = cannonPosition
            cannonBall.zPosition = 5
        }
    }
    
    
    func setupSpring(numberOfSprings : Int ) {
        springPositions = attachmentPositions
        for _ in 0...numberOfSprings-1 {
            let spring = Spring()
            addChild(spring)
            let index = Int(Utilities.random(min: 0, max: CGFloat(attachmentPositions.count-1)))
            let position = CGPoint(x: springPositions[index].x, y: springPositions[index].y+20)
            spring.position = position
            spring.zPosition = 2
            attachmentPositions.remove(at: index)
        }
    }
    
    func generateRandomPosition(height : CGFloat, numberOfPositions : Int) -> [CGPoint] {
        var positions : [CGPoint] = []
        let yPositions = generateYPos(height: height, numberOfPositions: numberOfPositions)
        for yPos in yPositions {
            //width of LandingArea/2 = 40
            let randomXPos = Utilities.random(min: 40, max: size.width - 40)
            positions.append(CGPoint(x: randomXPos, y: yPos))
        }
        return positions
    }
    
    func generateCannonPosition(height : CGFloat, numberOfCannon : Int) -> [CGPoint] {
        var positions : [CGPoint] = []
        let yPositions = generateYPos(height: height, numberOfPositions: numberOfCannon)
        for yPos in yPositions {
            let xPos = CGFloat(20)
            positions.append(CGPoint(x: xPos, y: yPos))
        }
        return positions
    }
    
    func generateYPos(height : CGFloat, numberOfPositions : Int) -> [CGFloat] {
        var yPositionsArray : [CGFloat] = []
        let numberOfPositions = numberOfPositions
        let leastPos = height/CGFloat(numberOfPositions)
        for i in 1...numberOfPositions {
            yPositionsArray.append(leastPos*CGFloat(i))
        }
        return yPositionsArray
    }
}


