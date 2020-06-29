//
//  SettingsController.swift
//  SpriteKitConwayGOL
//
//  Created by Christopher Devito on 6/29/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import UIKit

class SettingsController {

    static let shared = SettingsController()

    let liveCellColors = ["TEAL", "BLUE", "GREEN", "YELLOW", "RED", "PURPLE"]
    let liveCellColorsSystem: [UIColor] = [.systemTeal, .systemBlue, .systemGreen, .systemYellow, .systemRed, .systemPurple]
    var liveCellColor: UIColor = .systemTeal
    let deadCellColors = ["BLACK", "WHITE", "LIGHT GRAY", "DARK GRAY"]
    let deadCellColorsSystem: [UIColor] = [.black, .white, .systemGray4, .systemGray]
    var deadCellColor: UIColor = .white
    let presets = ["Random", "Gosper Glider Gun", "Constructor", "Stable Shapes", "Spaceships"]
    var speed: Int = 4
    var cellSize: Int = 10
    var preset: String = "Random"
}
