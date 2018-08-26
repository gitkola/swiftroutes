//
//  ViewController.swift
//  SwiftRoutes
//
//  Created by Mykola Lavrov on 26.08.2018.
//  Copyright © 2018 Mykola Lavrov. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    private var current: UIViewController
    init() {
        self.current = SplashViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewController(current)               // 1
        current.view.frame = view.bounds              // 2
        view.addSubview(current.view)                 // 3
        current.didMove(toParentViewController: self) // 4
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showLoginScreen() {
        
        let new = UINavigationController(rootViewController: LoginViewController())// 1
        addChildViewController(new)                    // 2
        new.view.frame = view.bounds                   // 3
        view.addSubview(new.view)                      // 4
        new.didMove(toParentViewController: self)      // 5
        current.willMove(toParentViewController: nil)  // 6
        current.view.removeFromSuperview()            // 7
        current.removeFromParentViewController()       // 8
        current = new                                  // 9
    }
    
    func switchToMainScreen() {
        let mainViewController = MainViewController()
        let new = UINavigationController(rootViewController: mainViewController)
        animateFadeTransition(to: new)
    }
    
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParentViewController: nil)
        addChildViewController(new)
        
        transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
        }) { completed in
            self.current.removeFromParentViewController()
            new.didMove(toParentViewController: self)
            self.current = new
            completion?()  //1
        }
    }
    
    func switchToLogout() {
        let loginViewController = LoginViewController()
        let logoutScreen = UINavigationController(rootViewController: loginViewController)
        animateDismissTransition(to: logoutScreen)
    }
    
    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        let initialFrame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        current.willMove(toParentViewController: nil)
        addChildViewController(new)
        transition(from: current, to: new, duration: 0.3, options: [], animations: {
            new.view.frame = self.view.bounds
        }) { completed in
            self.current.removeFromParentViewController()
            new.didMove(toParentViewController: self)
            self.current = new
            completion?()
        }
    }
}


