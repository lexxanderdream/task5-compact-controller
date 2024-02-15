//
//  ViewController.swift
//  CompactController
//
//  Created by Alexander Zhuchkov on 15.02.2024.
//

import UIKit

class ViewController: UIViewController {

 
    // MARK: - Subviews
    private lazy var button: UIButton = {
        let button = UIButton(primaryAction: .init(handler: { [weak self] _ in
            self?.presentSecondViewController()
        }))
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Present", for: .normal)
        
        return button
    }()

    
    // MARK: - Helper Methods
    private func setupView() {
        
        view.addSubview(button)
        
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
    }
    
    private func presentSecondViewController() {
        
        let viewController = SecondViewController()
        let navigationViewController = UINavigationController(rootViewController: viewController)
        navigationViewController.modalPresentationStyle = .popover
        
        let popover = navigationViewController.popoverPresentationController
        popover?.delegate = self
        popover?.sourceView = button
        popover?.sourceRect = button.bounds
        
        present(navigationViewController, animated: true)
    }
}

// MARK: - UIViewController Lify Cycle
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
    }

}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    func popoverPresentationController(_ popoverPresentationController: UIPopoverPresentationController, willRepositionPopoverTo rect: UnsafeMutablePointer<CGRect>, in view: AutoreleasingUnsafeMutablePointer<UIView>) {
        print("will reposition to", rect)
    }
}
