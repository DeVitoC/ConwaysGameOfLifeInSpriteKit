//
//  SettingsViewController.swift
//  SpriteKitConwayGOL
//
//  Created by Christopher Devito on 6/29/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    let settingsController = SettingsController.shared

    let mainStackView = UIStackView()
    let speedLabel = UILabel()
    let cellSizeLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {
        navigationItem.title = "Settings"

        let liveCellColorStackView = UIStackView()
        let deadCellColorStackView = UIStackView()
        let speedStackView = UIStackView()
        let cellSizeStackView = UIStackView()
        let presetStackView = UIStackView()
        let liveCellColorLabel = UILabel()
        let liveCellPickerView = UIPickerView()
        let deadCellColorLabel = UILabel()
        let deadCellPickerView = UIPickerView()
        let speedSlider = UISlider()
        let cellSizeSlider = UISlider()
        let presetLabel = UILabel()
        let presetPickerView = UIPickerView()

        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(liveCellColorStackView)
        mainStackView.addArrangedSubview(deadCellColorStackView)
        mainStackView.addArrangedSubview(speedStackView)
        mainStackView.addArrangedSubview(cellSizeStackView)
        mainStackView.addArrangedSubview(presetStackView)
        liveCellColorStackView.addArrangedSubview(liveCellColorLabel)
        liveCellColorStackView.addArrangedSubview(liveCellPickerView)
        deadCellColorStackView.addArrangedSubview(deadCellColorLabel)
        deadCellColorStackView.addArrangedSubview(deadCellPickerView)
        speedStackView.addArrangedSubview(speedLabel)
        speedStackView.addArrangedSubview(speedSlider)
        cellSizeStackView.addArrangedSubview(cellSizeLabel)
        cellSizeStackView.addArrangedSubview(cellSizeSlider)
        presetStackView.addArrangedSubview(presetLabel)
        presetStackView.addArrangedSubview(presetPickerView)

        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        liveCellColorStackView.translatesAutoresizingMaskIntoConstraints = false
        deadCellColorStackView.translatesAutoresizingMaskIntoConstraints = false
        speedStackView.translatesAutoresizingMaskIntoConstraints = false
        cellSizeStackView.translatesAutoresizingMaskIntoConstraints = false
        presetStackView.translatesAutoresizingMaskIntoConstraints = false
        liveCellPickerView.translatesAutoresizingMaskIntoConstraints = false
        liveCellColorLabel.translatesAutoresizingMaskIntoConstraints = false
        deadCellPickerView.translatesAutoresizingMaskIntoConstraints = false
        deadCellColorLabel.translatesAutoresizingMaskIntoConstraints = false
        speedSlider.translatesAutoresizingMaskIntoConstraints = false
        speedLabel.translatesAutoresizingMaskIntoConstraints = false
        cellSizeSlider.translatesAutoresizingMaskIntoConstraints = false
        cellSizeLabel.translatesAutoresizingMaskIntoConstraints = false
        presetPickerView.translatesAutoresizingMaskIntoConstraints = false
        presetLabel.translatesAutoresizingMaskIntoConstraints = false

        mainStackView.axis = .vertical
        liveCellColorStackView.axis = .horizontal
        deadCellColorStackView.axis = .horizontal
        speedStackView.axis = .horizontal
        cellSizeStackView.axis = .horizontal
        presetStackView.axis = .horizontal

        mainStackView.alignment = .fill
        liveCellColorStackView.alignment = .fill
        deadCellColorStackView.alignment = .fill
        speedStackView.alignment = .fill
        cellSizeStackView.alignment = .fill
        presetStackView.alignment = .fill

        mainStackView.distribution = .fillEqually
        liveCellColorStackView.distribution = .fillEqually
        deadCellColorStackView.distribution = .fillEqually
        speedStackView.distribution = .fillEqually
        cellSizeStackView.distribution = .fillEqually
        presetStackView.distribution = .fillEqually

        mainStackView.spacing = 10
        liveCellColorStackView.spacing = 10
        deadCellColorStackView.spacing = 10
        speedStackView.spacing = 10
        cellSizeStackView.spacing = 10
        presetStackView.spacing = 10

        NSLayoutConstraint.activate([
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
            mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])

        liveCellColorLabel.textAlignment = .right
        deadCellColorLabel.textAlignment = .right
        speedLabel.textAlignment = .right
        cellSizeLabel.textAlignment = .right
        presetLabel.textAlignment = .right

        liveCellColorLabel.text = "Live Cell Color:"
        deadCellColorLabel.text = "Dead Cell Color:"
        speedLabel.text = "Speed: 4"
        cellSizeLabel.text = "Cell Size: 10"
        presetLabel.text = "Preset: "

        liveCellColorLabel.font = UIFont(name: "System", size: 14)
        deadCellColorLabel.font = UIFont(name: "System", size: 14)

        liveCellPickerView.dataSource = self
        liveCellPickerView.delegate = self
        liveCellPickerView.widthAnchor.constraint(equalTo: liveCellColorStackView.widthAnchor, multiplier: 0.4).isActive = true
        liveCellPickerView.selectRow(0, inComponent: 0, animated: false)
        liveCellPickerView.tag = 0

        deadCellPickerView.dataSource = self
        deadCellPickerView.delegate = self
        deadCellPickerView.widthAnchor.constraint(equalTo: deadCellColorStackView.widthAnchor, multiplier: 0.4).isActive = true
        deadCellPickerView.selectRow(0, inComponent: 0, animated: false)
        deadCellPickerView.tag = 1

        presetPickerView.dataSource = self
        presetPickerView.delegate = self
        presetPickerView.widthAnchor.constraint(equalTo: presetStackView.widthAnchor, multiplier: 0.4).isActive = true
        presetPickerView.selectRow(0, inComponent: 0, animated: false)
        presetPickerView.tag = 2

        speedSlider.minimumValue = 1
        speedSlider.minimumValueImage = UIImage(systemName: "tortoise.fill")
        speedSlider.maximumValue = 10
        speedSlider.maximumValueImage = UIImage(systemName: "hare.fill")
        speedSlider.value = 4
        let speedThumbConfiguration = UIImage.SymbolConfiguration(pointSize: 13)
        speedSlider.setThumbImage(UIImage(systemName: "circle.fill", withConfiguration: speedThumbConfiguration), for: .normal)
        speedSlider.addTarget(self, action: #selector(setSpeed(_:)), for: .valueChanged)

        cellSizeSlider.minimumValue = 6
        cellSizeSlider.minimumValueImage = UIImage(systemName: "smallcircle.fill.circle")
        cellSizeSlider.maximumValue = 20
        cellSizeSlider.maximumValueImage = UIImage(systemName: "largecircle.fill.circle")
        cellSizeSlider.value = 10
        let cellSizeThumbConfiguration = UIImage.SymbolConfiguration(pointSize: 13)
        cellSizeSlider.setThumbImage(UIImage(systemName: "circle.fill", withConfiguration: cellSizeThumbConfiguration), for: .normal)
        cellSizeSlider.addTarget(self, action: #selector(setCellSize(_:)), for: .valueChanged)
    }

    @objc func setSpeed(_ sender: UISlider) {
        speedLabel.text = "Speed: \(Int(sender.value))"
        settingsController.speed = Int(sender.value)
    }

    @objc func setCellSize(_ sender: UISlider) {
        cellSizeLabel.text = "Cell Size: \(Int(sender.value))"
        settingsController.cellSize = Int(sender.value)
    }
}

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 0 { return 1 }
        else if pickerView.tag == 1 { return 1 }
        else { return 1 }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 { return settingsController.liveCellColors.count }
        else if pickerView.tag == 1 { return settingsController.deadCellColors.count }
        else { return settingsController.presets.count }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 { settingsController.liveCellColor = settingsController.liveCellColorsSystem[row] }
        else if pickerView.tag == 1 { settingsController.deadCellColor = settingsController.deadCellColorsSystem[row] }
        else { settingsController.preset = settingsController.presets[row] }
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var tempView = view as? UILabel
        if tempView == nil {
            tempView = UILabel()
            tempView?.font = UIFont(name: "System", size: 14)
            tempView?.textAlignment = .center
        }

        if pickerView.tag == 0 {
            tempView?.text = settingsController.liveCellColors[row]
            tempView?.textColor = settingsController.liveCellColorsSystem[row]
        }
        else if pickerView.tag == 1 {
            tempView?.text = settingsController.deadCellColors[row]
            if row == 1 {
                tempView?.textColor = .black
            } else {
                tempView?.textColor = settingsController.deadCellColorsSystem[row]
            }
        } else {
            tempView?.text = settingsController.presets[row]
            tempView?.textColor = .black
        }

        return tempView!
    }
}
