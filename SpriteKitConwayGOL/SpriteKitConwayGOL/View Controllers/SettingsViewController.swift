//
//  SettingsViewController.swift
//  SpriteKitConwayGOL
//
//  Created by Christopher Devito on 6/29/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    let mainStackView = UIStackView()
    let liveCellColors = ["TEAL", "BLUE", "GREEN", "YELLOW", "RED", "PURPLE"]
    let liveCellColorsSystem: [UIColor] = [.systemTeal, .systemBlue, .systemGreen, .systemYellow, .systemRed, .systemPurple]
    var liveCellColor: UIColor = .systemTeal
    let deadCellColors = ["BLACK", "WHITE", "LIGHT GRAY", "DARK GRAY"]
    let deadCellColorsSystem: [UIColor] = [.black, .white, .systemGray4, .systemGray]
    var deadCellColor: UIColor = .white
    let speedLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {
        navigationItem.title = "Settings"

        let liveCellColorStackView = UIStackView()
        let deadCellColorStackView = UIStackView()
        let speedStackView = UIStackView()
        let gridSizeStackView = UIStackView()
        let settings5StackView = UIStackView()
        let liveCellColorLabel = UILabel()
        let liveCellPickerView = UIPickerView()
        let deadCellColorLabel = UILabel()
        let deadCellPickerView = UIPickerView()

        let speedSlider = UISlider()

        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(liveCellColorStackView)
        mainStackView.addArrangedSubview(deadCellColorStackView)
        mainStackView.addArrangedSubview(speedStackView)
        mainStackView.addArrangedSubview(gridSizeStackView)
        mainStackView.addArrangedSubview(settings5StackView)
        liveCellColorStackView.addArrangedSubview(liveCellColorLabel)
        liveCellColorStackView.addArrangedSubview(liveCellPickerView)
        deadCellColorStackView.addArrangedSubview(deadCellColorLabel)
        deadCellColorStackView.addArrangedSubview(deadCellPickerView)
        speedStackView.addArrangedSubview(speedLabel)
        speedStackView.addArrangedSubview(speedSlider)

        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        liveCellColorStackView.translatesAutoresizingMaskIntoConstraints = false
        deadCellColorStackView.translatesAutoresizingMaskIntoConstraints = false
        speedStackView.translatesAutoresizingMaskIntoConstraints = false
        gridSizeStackView.translatesAutoresizingMaskIntoConstraints = false
        settings5StackView.translatesAutoresizingMaskIntoConstraints = false
        liveCellPickerView.translatesAutoresizingMaskIntoConstraints = false
        liveCellColorLabel.translatesAutoresizingMaskIntoConstraints = false
        deadCellPickerView.translatesAutoresizingMaskIntoConstraints = false
        deadCellColorLabel.translatesAutoresizingMaskIntoConstraints = false
        speedSlider.translatesAutoresizingMaskIntoConstraints = false
        speedLabel.translatesAutoresizingMaskIntoConstraints = false

        // Temp view to keep track of stackview4
        let backgroundView4 = UIView()
        backgroundView4.backgroundColor = .systemPink
        backgroundView4.translatesAutoresizingMaskIntoConstraints = false
        gridSizeStackView.insertSubview(backgroundView4, at: 0)
        NSLayoutConstraint.activate([
            backgroundView4.topAnchor.constraint(equalTo: gridSizeStackView.topAnchor),
            backgroundView4.bottomAnchor.constraint(equalTo: gridSizeStackView.bottomAnchor),
            backgroundView4.leadingAnchor.constraint(equalTo: gridSizeStackView.leadingAnchor),
            backgroundView4.trailingAnchor.constraint(equalTo: gridSizeStackView.trailingAnchor)
        ])

        // Temp view to keep track of stackview5
        let backgroundView5 = UIView()
        backgroundView5.backgroundColor = .systemTeal
        backgroundView5.translatesAutoresizingMaskIntoConstraints = false
        settings5StackView.insertSubview(backgroundView5, at: 0)
        NSLayoutConstraint.activate([
            backgroundView5.topAnchor.constraint(equalTo: settings5StackView.topAnchor),
            backgroundView5.bottomAnchor.constraint(equalTo: settings5StackView.bottomAnchor),
            backgroundView5.leadingAnchor.constraint(equalTo: settings5StackView.leadingAnchor),
            backgroundView5.trailingAnchor.constraint(equalTo: settings5StackView.trailingAnchor)
        ])

        mainStackView.axis = .vertical
        liveCellColorStackView.axis = .horizontal
        deadCellColorStackView.axis = .horizontal
        speedStackView.axis = .horizontal
        gridSizeStackView.axis = .horizontal
        settings5StackView.axis = .horizontal

        mainStackView.alignment = .fill
        liveCellColorStackView.alignment = .fill
        deadCellColorStackView.alignment = .fill
        speedStackView.alignment = .fill
        gridSizeStackView.alignment = .fill
        settings5StackView.alignment = .fill

        mainStackView.distribution = .fillEqually
        liveCellColorStackView.distribution = .fillEqually
        deadCellColorStackView.distribution = .fillEqually
        speedStackView.distribution = .fillEqually
        gridSizeStackView.distribution = .fillEqually
        settings5StackView.distribution = .fillEqually

        mainStackView.spacing = 10
        liveCellColorStackView.spacing = 10
        deadCellColorStackView.spacing = 10
        speedStackView.spacing = 10
        gridSizeStackView.spacing = 10
        settings5StackView.spacing = 10

        NSLayoutConstraint.activate([
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
            mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])

        liveCellColorLabel.textAlignment = .right
        deadCellColorLabel.textAlignment = .right
        speedLabel.textAlignment = .right

        liveCellColorLabel.text = "Live Cell Color:"
        deadCellColorLabel.text = "Dead Cell Color:"
        speedLabel.text = "Speed: 4"

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

        speedSlider.minimumValue = 1
        speedSlider.minimumValueImage = UIImage(systemName: "tortoise.fill")
        speedSlider.maximumValue = 10
        speedSlider.maximumValueImage = UIImage(systemName: "hare.fill")
        speedSlider.value = 4
        let speedThumbConfiguration = UIImage.SymbolConfiguration(pointSize: 13)
        speedSlider.setThumbImage(UIImage(systemName: "circle.fill", withConfiguration: speedThumbConfiguration), for: .normal)
        speedSlider.addTarget(self, action: #selector(setSpeed(_:)), for: .valueChanged)

    }

    @IBAction func setSpeed(_ sender: UISlider) {
        speedLabel.text = "Speed: \(Int(sender.value))"
    }
}

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 0 { return 1 }
        else { return 1 }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 { return liveCellColors.count }
        else { return deadCellColors.count }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 { liveCellColor = liveCellColorsSystem[row] }
        else { deadCellColor = deadCellColorsSystem[row] }
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var tempView = view as? UILabel
        if tempView == nil {
            tempView = UILabel()
            tempView?.font = UIFont(name: "System", size: 14)
            tempView?.textAlignment = .center
        }

        if pickerView.tag == 0 {
            tempView?.text = liveCellColors[row]
            tempView?.textColor = liveCellColorsSystem[row]
        }
        else {
            tempView?.text = deadCellColors[row]
            if row == 1 {
                tempView?.textColor = .black
            } else {
                tempView?.textColor = deadCellColorsSystem[row]
            }
        }

        return tempView!
    }
}
