//
//  HomeViewController.swift
//  ColorizedApp
//
//  Created by Alex Pesenka on 28/06/24.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func didSelectColor (_ color: UIColor)
}

final class HomeViewController: UIViewController {
    
    var targetColor = UIColor.systemGray6

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = targetColor
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsVC = segue.destination as? SettingsViewController {
            settingsVC.targetColor = targetColor
            settingsVC.delegate = self
            print("Works")
        }
    }
    
}

extension HomeViewController: SettingsViewControllerDelegate {
    func didSelectColor(_ color: UIColor) {
        view.backgroundColor = color
        targetColor = color
    }
    
}
