//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Alex Pesenka on 22/05/24.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func sliderValueChanged(_ sender: UISlider) {
        if sender == redSlider {
            redValueLabel.text = formatSliderValue(sender.value)
            } else if sender == greenSlider {
                greenValueLabel.text = formatSliderValue(sender.value)
            } else if sender == blueSlider {
                blueValueLabel.text = formatSliderValue(sender.value)
            }
    }
    
    private func formatSliderValue(_ value: Float) -> String {
        return value.formatted(.number.precision(.fractionLength(2)))
    }
}

