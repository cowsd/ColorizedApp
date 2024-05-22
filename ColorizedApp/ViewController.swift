//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Alex Pesenka on 22/05/24.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var colorDisplayView: UIView!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorDisplayView.layer.cornerRadius = 16
    }
    
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let sliderToLabel: [UISlider: UILabel] = [
            redSlider: redValueLabel,
            greenSlider: greenValueLabel,
            blueSlider: blueValueLabel
        ]
        
        if let label = sliderToLabel[sender] {
            label.text = sender.value.formatted(.number.precision(.fractionLength(2)))
        }
            
        updateColorDisplayView()
    }
    
    
    private func updateColorDisplayView() {
        colorDisplayView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0)
    }
    
}
