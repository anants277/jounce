//
//  TopView.swift
//  Doodle
//
//  Created by Creo Server on 04/03/20.
//  Copyright © 2020 Creo Server. All rights reserved.
//

import SpriteKit

class TopView : SKNode {
    
    var size : CGSize!
    var labelSize : CGSize!
    var livesLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var playPauseLabel = SKLabelNode()
    var highScoreLabel = SKLabelNode()
    var livesLabelNode : SKSpriteNode!
    var scoreLabelNode : SKNode!
    var highScoreLabelNode : SKNode!
    var pauseButton : SKSpriteNode!
    
    init(viewSize : CGSize) {
        super.init()
        labelSize = CGSize(width: viewSize.width/4, height: viewSize.height - Constants.nodgeHeight)
        self.size = viewSize
        livesLabelNode = SKSpriteNode(texture: nil, color: .clear, size: labelSize)
        scoreLabelNode = SKSpriteNode(texture: nil, color: .clear, size: labelSize)
        highScoreLabelNode = SKSpriteNode(texture: nil, color: .clear, size: labelSize)
        pauseButton = SKSpriteNode(texture: nil, color: .clear, size: labelSize)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let back = SKSpriteNode(texture: nil, color: .clear, size: size)
        addChild(back)
        
        addChild(livesLabelNode)
        var livesLabelNodePosition = CGPoint.zero
        if Constants.nodgeHeight > 0 {
            livesLabelNodePosition = CGPoint(x: -size.width/2 + labelSize.width/2, y: -labelSize.height/2)
        }
        else {
            livesLabelNodePosition = CGPoint(x: -size.width/2 + labelSize.width/2, y: 0)
        }
        
        livesLabelNode.position = livesLabelNodePosition
        livesLabelNode.addChild(livesLabel)
        livesLabel.attributedText = Utilities.makeLivesString(text : "1")
        livesLabel.horizontalAlignmentMode = .center
        livesLabel.verticalAlignmentMode = .center
        livesLabel.fontColor = .black
        livesLabel.fontSize = 30
        
        addChild(scoreLabelNode)
        var scoreLabelNodePosition = CGPoint.zero
        if Constants.nodgeHeight > 0 {
            scoreLabelNodePosition = CGPoint(x: -size.width/4 + labelSize.width/2, y: -labelSize.height/2)
        }
        else {
            scoreLabelNodePosition = CGPoint(x: -size.width/4 + labelSize.width/2, y: 0)
        }
        
        scoreLabelNode.position = scoreLabelNodePosition
        scoreLabelNode.addChild(scoreLabel)
        scoreLabel.attributedText = Utilities.makeTopViewString(text1: "Score", text2: "0")
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.fontColor = .black
        scoreLabel.fontSize = 20
        scoreLabel.numberOfLines = 0
//
        addChild(highScoreLabelNode)
        var highScoreLabelNodePosition = CGPoint.zero
        if Constants.nodgeHeight > 0 {
            highScoreLabelNodePosition = CGPoint(x: 0 + labelSize.width/2, y: -labelSize.height/2)
        }
        else {
            highScoreLabelNodePosition = CGPoint(x: 0 + labelSize.width/2, y: 0)
        }
        
        highScoreLabelNode.position = highScoreLabelNodePosition
        highScoreLabelNode.addChild(highScoreLabel)
        
        highScoreLabel.attributedText = Utilities.makeTopViewString(text1: "High Score", text2: "0")
        highScoreLabel.horizontalAlignmentMode = .center
        highScoreLabel.verticalAlignmentMode = .center
        highScoreLabel.fontColor = .black
        highScoreLabel.fontSize = 20
        highScoreLabel.numberOfLines = 0
//
        addChild(pauseButton)
        var pauseButtonPosition = CGPoint.zero
        if Constants.nodgeHeight > 0 {
            pauseButtonPosition = CGPoint(x: size.width/4 + labelSize.width/2, y: -labelSize.height/2)
        }
        else {
            pauseButtonPosition = CGPoint(x: size.width/4 + labelSize.width/2, y: 0)
        }
        
        pauseButton.position = pauseButtonPosition
        pauseButton.addChild(playPauseLabel)
        pauseButton.name = "pauseButton"
        playPauseLabel.text = "PAUSE"
        playPauseLabel.horizontalAlignmentMode = .center
        playPauseLabel.verticalAlignmentMode = .center
        playPauseLabel.fontColor = .black
        playPauseLabel.fontName = "boldSystemFont"
        playPauseLabel.fontSize = 16
    }
}



