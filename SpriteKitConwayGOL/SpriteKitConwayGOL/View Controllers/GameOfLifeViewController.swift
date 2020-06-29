//
//  GameOfLifeViewController.swift
//  SpriteKitConwayGOL
//
//  Created by Christopher Devito on 6/29/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import UIKit

class GameOfLifeViewController: UIViewController {
    let settingsController = SettingsController.shared

    let stackView = UIStackView()
    let aliveLabel = UILabel()
    let deadLabel = UILabel()
    let speedLabel = UILabel()
    let cellSizeLabel = UILabel()
    let presetLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(stackView)
        stackView.addArrangedSubview(aliveLabel)
        stackView.addArrangedSubview(deadLabel)
        stackView.addArrangedSubview(speedLabel)
        stackView.addArrangedSubview(cellSizeLabel)
        stackView.addArrangedSubview(presetLabel)
        stackView.axis = .vertical

        stackView.translatesAutoresizingMaskIntoConstraints = false
        aliveLabel.translatesAutoresizingMaskIntoConstraints = false
        deadLabel.translatesAutoresizingMaskIntoConstraints = false
        speedLabel.translatesAutoresizingMaskIntoConstraints = false
        cellSizeLabel.translatesAutoresizingMaskIntoConstraints = false
        presetLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8)
        ])

        aliveLabel.text = "\(settingsController.liveCellColor)"
        deadLabel.text = "\(settingsController.deadCellColor)"
        speedLabel.text = "\(settingsController.speed)"
        cellSizeLabel.text = "\(settingsController.cellSize)"
        presetLabel.text = "\(settingsController.preset)"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("View Will Appear")
        aliveLabel.text = "\(settingsController.liveCellColor)"
        deadLabel.text = "\(settingsController.deadCellColor)"
        speedLabel.text = "\(settingsController.speed)"
        cellSizeLabel.text = "\(settingsController.cellSize)"
        presetLabel.text = "\(settingsController.preset)"
        view.reloadInputViews()
    }

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        NSLog("View Did Appear")
//        aliveLabel.text = "\(settingsController.liveCellColor)"
//        deadLabel.text = "\(settingsController.deadCellColor)"
//        speedLabel.text = "\(settingsController.speed)"
//        cellSizeLabel.text = "\(settingsController.cellSize)"
//        presetLabel.text = "\(settingsController.preset)"
//        view.reloadInputViews()
//
//    }
}
