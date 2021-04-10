//
//  GameViewController.swift
//  Doodle
//
//  Created by Creo Server on 18/02/20.
//  Copyright © 2020 Creo Server. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

var XscaleFactor : CGFloat!
var YscaleFactor : CGFloat!
class GameViewController: UIViewController {

    let constanctSize = CGSize(width: 414, height: 896)
    var deviceSize : CGSize!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deviceSize = self.view.frame.size
        XscaleFactor = deviceSize.width/constanctSize.width
        YscaleFactor = deviceSize.height/constanctSize.height
        if let view = self.view as! SKView? {
            let scene = GameScene(size: CGSize(width: view.frame.width, height: view.frame.height))
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true

        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
