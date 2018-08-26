//
//  ViewController.swift
//  SwiftRoutes
//
//  Created by Mykola Lavrov on 26.08.2018.
//  Copyright © 2018 Mykola Lavrov. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0.5, alpha: 0.4)
        makeServiceCall()
    }
    private func makeServiceCall() {
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
            self.activityIndicator.stopAnimating()
            
            if UserDefaults.standard.bool(forKey: "LOGGED_IN") {
                print("LOGGED_IN")
                // navigate to protected page
                AppDelegate.shared.rootViewController.switchToMainScreen()
            } else {
                print("LOGGED_OUT")
                // navigate to login screen
                AppDelegate.shared.rootViewController.switchToLogout()
            }
        }
    }
}
