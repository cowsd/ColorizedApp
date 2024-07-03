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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsVC = segue.destination as? SettingsViewController {
            settingsVC.currentColor = view.backgroundColor
            settingsVC.delegate = self
        }
    }
    
}

// MARK: - SettingsVC Delegate
extension HomeViewController: SettingsViewControllerDelegate {
    func didSelectColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}

// MARK: - Navigation Bar Appearance
private extension HomeViewController {
    func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.5)
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

