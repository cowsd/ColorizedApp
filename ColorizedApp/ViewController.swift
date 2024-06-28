//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Alex Pesenka on 22/05/24.
//

import UIKit

final class ViewController: UIViewController {
// MARK: - IB Outlets
    @IBOutlet weak var colorDisplayView: UIView!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!

// MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorDisplayView.layer.cornerRadius = 16
        setColor()
        
        redValueLabel.text = string(from: redSlider)
        greenValueLabel.text = string(from: greenSlider)
        blueValueLabel.text = string(from: blueSlider)

    }
    
// MARK: - IB Actions
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        setColor()
        switch sender {
        case redSlider:
            redValueLabel.text = string(from: redSlider)
        case greenSlider:
            greenValueLabel.text = string(from: greenSlider)
        default:
            blueValueLabel.text = string(from: blueSlider)
        }
    }
    
// MARK: - Private Methods
    
    private func setColor() {
        colorDisplayView.backgroundColor = UIColor(
            red: redSlider.value.cgFloat(),
            green: greenSlider.value.cgFloat(),
            blue: blueSlider.value.cgFloat(),
            alpha: 1.0
        )
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
}

// MARK: - CGFloat Converter

extension Float {
    func cgFloat() -> CGFloat {
        CGFloat(self)
    }
    
}
