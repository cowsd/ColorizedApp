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
    
    var currentColor = UIColor.systemGray6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
        view.backgroundColor = currentColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsVC = segue.destination as? SettingsViewController {
            settingsVC.currentColor = currentColor
            settingsVC.delegate = self
        }
    }
    
}

// MARK: - SettingsVC Delegate
extension HomeViewController: SettingsViewControllerDelegate {
    func didSelectColor(_ color: UIColor) {
        view.backgroundColor = color
        currentColor = color
    }
}

// MARK: - Navigation Bar Appearance
private extension HomeViewController {
    func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

