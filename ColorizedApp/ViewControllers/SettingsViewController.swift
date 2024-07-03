//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Alex Pesenka on 22/05/24.
//

import UIKit

final class SettingsViewController: UIViewController {
    // MARK: - IB Outlets
    @IBOutlet weak var colorView: UIView!
    
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
        
        colorView.layer.cornerRadius = 16
        
        setValue(for: redSlider, greenSlider, blueSlider)
        setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        setValue(for: redTextField, greenTextField, blueTextField)
        
        setColor()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IB Actions
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValue(for: redValueLabel)
            setValue(for: redTextField)
        case greenSlider:
            setValue(for: greenValueLabel)
            setValue(for: greenTextField)
        default:
            setValue(for: blueValueLabel)
            setValue(for: blueTextField)
        }
        
        setColor()
    }
    
    @IBAction func doneButtonDidTapped() {
        delegate?.didSelectColor(colorView.backgroundColor ?? .systemBackground)
        dismiss(animated: true)
    }
    
}

// MARK: - Private Methods
extension SettingsViewController {
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: redSlider.value.cgFloat(),
            green: greenSlider.value.cgFloat(),
            blue: blueSlider.value.cgFloat(),
            alpha: 1.0
        )
    }
    
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel: label.text = string(from: redSlider)
            case greenValueLabel: label.text = string(from: greenSlider)
            default: label.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField: textField.text = string(from: redSlider)
            case greenTextField: textField.text = string(from: greenSlider)
            default: textField.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for sliders: UISlider...) {
        let ciColor = CIColor(color: currentColor)
        sliders.forEach { slider in
            switch slider {
            case redSlider: redSlider.value = Float(ciColor.red)
            case greenSlider: greenSlider.value = Float(ciColor.green)
            default: blueSlider.value = Float(ciColor.blue)
            }
        }
    }
    
    private func showInputAlert(for textField: UITextField) {
        let alert = UIAlertController(
            title: "Invalid Value",
            message: "Enter value between 0.00 and 1",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            textField.becomeFirstResponder()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

// MARK: - UITextFieldDelegate

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, let value = Float(text), value >= 0, value <= 1 else {
            showInputAlert(for: textField)
            return
        }
        
        switch textField {
        case redTextField:
            redSlider.setValue(value, animated: true)
            setValue(for: redValueLabel)
        case greenTextField:
            greenSlider.setValue(value, animated: true)
            setValue(for: greenValueLabel)
        default:
            blueSlider.setValue(value, animated: true)
            setValue(for: blueValueLabel)
        }
        
        setColor()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.sizeToFit()
        textField.inputAccessoryView = keyboardToolBar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: textField,
            action: #selector(resignFirstResponder)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolBar.items = [flexBarButton, doneButton]
    }
    
}
