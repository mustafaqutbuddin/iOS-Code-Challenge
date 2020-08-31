//
//  UIViewController.swift
//  iOS Code Challenge
//
//  Created by Mustafa on 29/08/2020.
//  Copyright © 2020 Mustafa. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupNavBar(withTitle title: String) {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .black
        navigationItem.title = title
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            
            // Create button appearance, with the custom color
            let buttonAppearance = UIBarButtonItemAppearance(style: .plain)
            buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
            // Apply button appearance
            navBarAppearance.buttonAppearance = buttonAppearance
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            
        } else {
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
            navigationController?.navigationBar.barTintColor = .black
        }
        
    }
    
    func alertController(withTitle title: String, message: String ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        alertController.view.layoutIfNeeded()
        present(alertController, animated: true, completion: nil)
    }
}
