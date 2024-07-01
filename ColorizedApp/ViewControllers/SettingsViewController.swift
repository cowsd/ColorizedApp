//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Alex Pesenka on 22/05/24.
//

import UIKit

final class SettingsViewController: UIViewController {
    // MARK: - IB Outlets
    @IBOutlet weak var colorDisplayView: UIView!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    // MARK: - Public Properties
    var currentColor: UIColor!
    weak var delegate: SettingsViewControllerDelegate?
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        colorDisplayView.layer.cornerRadius = 16
        
        let rgbValues = currentColor.getRGBValues()
        setupSlider(redSlider, withValue: rgbValues.red)
        setupSlider(greenSlider, withValue: rgbValues.green)
        setupSlider(blueSlider, withValue: rgbValues.blue)
        
        updateColorView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IB Actions
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        updateColorView()
        updateSliderUI(for: sender)
    }
    
    @IBAction func doneButtonDidTapped() {
        delegate?.didSelectColor(
            UIColor(
                red: redSlider.value.cgFloat(),
                green: greenSlider.value.cgFloat(),
                blue: blueSlider.value.cgFloat(),
                alpha: 1.0
            )
        )
        
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func updateColorView() {
        colorDisplayView.backgroundColor = UIColor(
            red: redSlider.value.cgFloat(),
            green: greenSlider.value.cgFloat(),
            blue: blueSlider.value.cgFloat(),
            alpha: 1.0
        )
    }
    
    private func showInputAlert(for textField: UITextField) {
        let alert = UIAlertController(
            title: "Invalid Value",
            message: "Enter value between 0.00 and 1",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            textField.becomeFirstResponder()
        }))
        present(alert, animated: true)
    }
    
    
}
// MARK: - Slider Setup
private extension SettingsViewController {
    func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    func setupSlider(_ slider: UISlider, withValue value: Float) {
        slider.value = value
        updateSliderUI(for: slider)
    }
    
    func updateSliderUI(for slider: UISlider) {
        let valueString = string(from: slider)
        switch slider {
        case redSlider:
            redValueLabel.text = valueString
            redTextField.text = valueString
        case greenSlider:
            greenValueLabel.text = valueString
            greenTextField.text = valueString
        default:
            blueValueLabel.text = valueString
            blueTextField.text = valueString
        }
    }
}

// MARK: - UITextFieldDelegate

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, let value = Float(text), value >= 0, value <= 1 else {
            showInputAlert(for: textField)
            return
        }
        
        let roundedValue = round(value * 100) / 100.0
        let roundedString = String(format: "%.2f", roundedValue)
        
        switch textField {
        case redTextField:
            redSlider.value = roundedValue
            redValueLabel.text = roundedString
            redTextField.text = roundedString
        case greenTextField:
            greenSlider.value = roundedValue
            greenValueLabel.text = roundedString
            greenTextField.text = roundedString
        default:
            blueSlider.value = roundedValue
            blueValueLabel.text = roundedString
            blueTextField.text = roundedString
        }
        
        textField.resignFirstResponder()
        updateColorView()
        return
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
