//
//  GameViewController.swift
//  BreadAndGames
//
//  Created by Philipp-Marcel Duck on 22.11.24.
//

import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view as! SKView? {
            // Lade die GameScene
            let scene = GameScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene)

            view.ignoresSiblingOrder = true
            // view.showsFPS = true
            // view.showsNodeCount = true
        }
    }
}
