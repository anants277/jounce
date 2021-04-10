//
//  GameScene.swift
//  Doodle
//
//  Created by Creo Server on 18/02/20.
//  Copyright © 2020 Creo Server. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    
    var restartLabel : SKLabelNode!
    var restartLabelNode : SKSpriteNode!
    var fromPaused : Bool = true
    var score : Int = 0
    var highScore : Int = 0
    var scoreString : String = "0"
    var highScoreString : String = "0"
    var isGameOver : Bool = false
    var isGamepaused : Bool = false
    var topView : TopView!
    var button : FTButtonNode!
    var maxplayerPosition : CGPoint!
    var cameraPosition : CGPoint!
    var gameTimer : Timer!
    var isFalling = false
    var backgrounds = [Background]()
    var player : Player!
    var ground : Ground!
    var cameraNode = SKCameraNode()
    var restartTexture = SKTexture(imageNamed: "restart")
    var motionManager = CMMotionManager()
    
    override func didMove(to view: SKView) {
        restartLabel = SKLabelNode(text: "RESTART")
        restartLabel.name = "restartLabel"
        restartLabelNode = SKSpriteNode(texture: restartTexture, color: .brown, size: CGSize(width:200, height:200))
        restartLabelNode.zPosition = 5
        topView = TopView(viewSize: CGSize(width: size.width, height: size.height/10))
        physicsWorld.contactDelegate = self
        player = Player(playerSize: Constants.playerSize)
        player.zPosition = 2
        ground = Ground(size: view.frame.size)
        setup()
        setupMotion()
//        gameTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(spawnRoundObstacle), userInfo: nil, repeats: true)
    }
    
    
    func setupMotion() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.01
            motionManager.startAccelerometerUpdates(to: .main) {
                (data, error) in
                guard let data = data, error == nil else {
                    return
                }
//                print(data.acceleration.x)
                if !self.isGamepaused {
                    let currentX = self.player.position.x
                    self.player.position.x = currentX + CGFloat(data.acceleration.x * 20)
                    if currentX < 0 {
                        self.player.position.x = self.size.width
                    }
                    else if currentX > self.size.width {
                        self.player.position.x = 0
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        let touchedNodes = self.nodes(at: location)
        for touchedNode in touchedNodes {
            if touchedNode.name == "pauseButton"  {
                fromPaused = true
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.pausePlay()
//                }
            }
            else if touchedNode.name == "restartLabel" {
                restartButtontapped()
            }
        }
        fromPaused = false
//        if location.x > size.width/2 {
//            gameTimer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(goRight), userInfo: nil, repeats: true)
//            player.xScale = -1
//        }
//        else {
//            gameTimer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(goLeft), userInfo: nil, repeats: true)
//            player.xScale = 1
//        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        gameTimer.invalidate()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        gameTimer.invalidate()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        gameTimer.invalidate()
    }
    
    override func update(_ currentTime: TimeInterval) {
        resetPlayerHorizontalPos()
        
        if player.position.y >= maxplayerPosition.y {
            maxplayerPosition.y = player.position.y
            changeCameraPosition()
            scrollBackground()
        }
        if player.position.y <= cameraNode.position.y - UIScreen.main.bounds.height/2 && !isGameOver {
            isGameOver = true
            gameOver()
        }
    }
    
    func setup() {
        
        addChild(ground)
        ground.position.x = size.width/2
        ground.position.y = 0
        
        addChild(player)
        maxplayerPosition = CGPoint(x: size.width/2, y: size.height/2)
        player.position = maxplayerPosition
        
        
        addChild(cameraNode)
        camera = cameraNode
        cameraPosition = CGPoint(x: size.width/2, y: size.height/2)
        camera?.position = cameraPosition
        
        
        topView.position = CGPoint(x: 0, y: size.height/2 - topView.size.height/2)
        cameraNode.addChild(topView)
        topView.zPosition = 4
        highScoreString = UserDefaults.standard.string(forKey: "highScore") ?? "0"
        highScore = Int(highScoreString) ?? 0
        topView.highScoreLabel.attributedText = Utilities.makeTopViewString(text1: "High Score", text2: highScoreString)
        
        for i in 0...1 {
            let background = Background(size: size)
            background.position.y = CGFloat(i) * size.height
            backgrounds.append(background)
            addChild(background)
            background.zPosition = -1
        }
    }
    
    func setupButton() {
        let buttonTexture: SKTexture! = SKTexture(imageNamed: "button")
        let buttonTextureSelected: SKTexture! = SKTexture(imageNamed: "selectedButton")
        button = FTButtonNode(normalTexture: buttonTexture, selectedTexture: buttonTextureSelected, disabledTexture: buttonTexture)
        button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(restartButtontapped))
        button.position = cameraNode.position
        button.zPosition = 5
        addChild(button)
        button.name = "RestartButton"
        button.setButtonLabel(title: "Restart", font: "Arial", fontSize: 20)

    }
    
    func setupRestart() {
        addChild(restartLabelNode)
        restartLabelNode.position = cameraNode.position
        restartLabelNode.addChild(restartLabel)
        restartLabel.verticalAlignmentMode = .top
        restartLabel.text = "RESTART"
        restartLabel.zRotation = 0.05
        restartLabel.zPosition = 6
        restartLabel.fontName = "boldSystemFont"
        restartLabel.fontColor = .black
        
    }
    
    func jump() {
        player.physicsBody?.velocity.dy = 0
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: Constants.jumpimpulse ))
    }
    
    func springJump() {
        player.physicsBody?.velocity.dy = 0
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: Constants.jumpimpulse * 2 ))
    }
    
    func changeCameraPosition() {
        let moveCamera = SKAction.move(to: maxplayerPosition, duration: 0.0)
        cameraNode.run(moveCamera)
        score = Int(maxplayerPosition.y/10)
        scoreString = String(score)
        topView.scoreLabel.attributedText = Utilities.makeTopViewString(text1: "Score", text2: scoreString)
        if score > highScore  {
            topView.highScoreLabel.attributedText = Utilities.makeTopViewString(text1: "High Score", text2: scoreString)
        }
    }
    
    func resetPlayerHorizontalPos() {
        if player.position.x < 0 {
            player.position.x = size.width
        }
        else if player.position.x > size.width {
            player.position.x = 0
        }
    }
    
    func scrollBackground() {
        for background in backgrounds {
            let dy = background.position.y - cameraNode.position.y
            if dy < -(background.size.height + size.height/2) {
                background.resetAll(score: player.position.y, numberOfPositions: 8, needBreakableland: true, needMovableland: true)
//                background.setupEnemy(numberOfEnemies: 2)
//                background.setupSpring(numberOfSprings: 2)
                background.position.y += background.size.height * 2
            }
        }
    }
     
    func fireBullet() {
        let bullet = Bullet()
        bullet.position = player.position
        bullet.position.y += 30
        bullet.zPosition = 1
        self.addChild(bullet)

        let moveBullet = SKAction.applyImpulse(CGVector(dx: 0, dy: 50), duration: 1)
        let deleteBullet = SKAction.removeFromParent()
        let bulletSequence = SKAction.sequence([moveBullet, deleteBullet])
        bullet.run(bulletSequence)
    }
    
    @objc func restartButtontapped() {
        let scene = GameScene(size: CGSize(width: (view?.frame.width)!, height: (view?.frame.height)!))
//        let transition = SKTransition.moveIn(with: .down, duration: 2)
//        self.view?.presentScene(scene, transition: transition)
        self.view?.presentScene(scene)
        self.view?.ignoresSiblingOrder = true
        self.view?.showsFPS = true
        self.view?.showsNodeCount = true
    }
    
    @objc func goLeft() {
        player.physicsBody?.applyForce(CGVector(dx: -Constants.sideForce  , dy: 0))
    }
    
    @objc func goRight() {
        player.physicsBody?.applyForce(CGVector(dx: Constants.sideForce , dy: 0))
    }
    
    @objc func spawnRoundObstacle() {
        let randomXStart = Utilities.random(min: 0, max: size.width)
        let startPoint = CGPoint(x: randomXStart, y: maxplayerPosition.y + size.height/2)
        let endPoint = CGPoint(x: randomXStart, y: maxplayerPosition.y - size.height/2)
        let roundObstacle = Roundostacle(ostacleSize: Constants.playerSize)
        roundObstacle.position = startPoint
        addChild(roundObstacle)
        let moveLandingArea = SKAction.move(to: endPoint, duration: 1.5)
        let deleteLandindArea = SKAction.removeFromParent()
        let landingAreaSequence = SKAction.sequence([moveLandingArea,deleteLandindArea])
        roundObstacle.run(landingAreaSequence)
    }
}

extension GameScene : SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        //player & enemy
        if collision == PhysicsCategory.player | PhysicsCategory.enemy {
//            print("hit by enemy")
        }
        
        if collision == PhysicsCategory.player | PhysicsCategory.RingArea {
            player.physicsBody?.velocity.dx = 0
        }
        
        if collision == PhysicsCategory.player | PhysicsCategory.spring {
           
            if (player.physicsBody?.velocity.dy)! < CGFloat(0) {
//                 print("spring")
                if contact.bodyA.node is Player && contact.bodyB.node is Spring {
                    if (contact.bodyA.node?.position.y)! > (contact.bodyB.node?.position.y)! + 5 {
                        springJump()
                    }
                }
                else {
                    if (contact.bodyB.node?.position.y)! > (contact.bodyA.node?.position.y)! + 5 {
                        springJump()
                    }
                }
            }
        }
            
        //bullet & enemy
        if collision == PhysicsCategory.bullet | PhysicsCategory.enemy {
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
//            print("enemy killed")
        }
            
        //player & ground
        else if collision == PhysicsCategory.player | PhysicsCategory.ground {
            jump()
        }
            
        //player & solidLand
        else if collision == PhysicsCategory.player | PhysicsCategory.solidLandingArea {
            
            if (player.physicsBody?.velocity.dy)! < CGFloat(0) {
//                print("solidLand")
                if contact.bodyA.node is Player && contact.bodyB.node is SolidLandingArea {
                    if (contact.bodyA.node?.position.y)! > (contact.bodyB.node?.position.y)! + 10 {
                        jump()
                    }
                }
                else {
                    if (contact.bodyB.node?.position.y)! > (contact.bodyA.node?.position.y)! + 10 {
                        jump()
                    }
                }
            }
        }
        
        
        //player & basketSensor
        else if collision == PhysicsCategory.player | PhysicsCategory.basketSensor {
            
            if (player.physicsBody?.velocity.dy)! < CGFloat(0) {
                print("basket!!!!")
                if contact.bodyA.node?.parent is Basket {
                    contact.bodyA.node?.parent?.removeFromParent()
                }
                if contact.bodyB.node?.parent is Basket {
                    contact.bodyB.node?.parent?.removeFromParent()
                }
            }
        }
            
        
        //player & breakableLand
        else if collision == PhysicsCategory.player | PhysicsCategory.breakableLandingArea {
            
            if (player.physicsBody?.velocity.dy)! < CGFloat(0) {
//                print("breakLand")
                if contact.bodyA.node is Player && contact.bodyB.node is BreakableLandingArea {
                    if (contact.bodyA.node?.position.y)! > (contact.bodyB.node?.position.y)! + 10 {
                        let land = contact.bodyB.node as? BreakableLandingArea
                        land?.breakLand(landPosition: land!.position)
                    }
                }
                else {
                    if (contact.bodyB.node?.position.y)! > (contact.bodyA.node?.position.y)! + 10 {
                        let land = contact.bodyA.node as? BreakableLandingArea
                        land?.breakLand(landPosition: land!.position)
                    }
                }
            }
        }
         
        //player & movableLand
        else if collision == PhysicsCategory.player | PhysicsCategory.movableLandingArea {
            
            if (player.physicsBody?.velocity.dy)! < CGFloat(0) {
                print("movable land")
                if contact.bodyA.node is Player && contact.bodyB.node is MovableLandingArea {
                    if (contact.bodyA.node?.position.y)! > (contact.bodyB.node?.position.y)! + 10 {
                        jump()
                    }
                }
                else {
                    if (contact.bodyB.node?.position.y)! > (contact.bodyA.node?.position.y)! + 10 {
                        jump()
                    }
                }
            }
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
    
    func gameOver() {
        if score > highScore {
            UserDefaults.standard.set(score, forKey: "highScore")
        }
        print("GameOver")
//        setupButton()
        player.removeFromParent()
        setupRestart()
        
    }
    func pausePlay() {
        if isGamepaused == false {
            topView.playPauseLabel.text = "PLAY"
            self.isPaused = true
            isGamepaused = true
            return
        }
        else {
            self.isPaused = false
            topView.playPauseLabel.text = "PAUSE"
            isGamepaused = false
            return
        }
    }
}


