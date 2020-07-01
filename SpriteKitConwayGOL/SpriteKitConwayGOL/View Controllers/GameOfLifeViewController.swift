//
//  GameOfLifeViewController.swift
//  SpriteKitConwayGOL
//
//  Created by Christopher Devito on 6/29/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import UIKit
import SpriteKit

class GameOfLifeViewController: UIViewController {
    let settings = SettingsController.shared

    var skView: SKView?
    var scene: GameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        skView = SKView(frame: view.frame)
        view.addSubview(skView!)
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("View Will Appear")
        if settings.preset != settings.prevPreset {
            setupView()
        }
    }

    func setupView() {
        guard let skView = skView else { return }
        NSLayoutConstraint.activate([
            skView.topAnchor.constraint(equalTo: view.topAnchor),
            skView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            skView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            skView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        scene = GameScene(size: view.bounds.size)
        
        skView.showsFPS = true
        skView.preferredFramesPerSecond = settings.speed
        skView.showsNodeCount = true
        scene?.scaleMode = .resizeFill
        guard let tabBar = tabBarController?.tabBar else { return }
        settings.tabBarHeight = tabBar.frame.height
        skView.presentScene(scene)
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }

    override var prefersStatusBarHidden: Bool {
        true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
