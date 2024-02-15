//
//  SecondViewController.swift
//  CompactController
//
//  Created by Alexander Zhuchkov on 15.02.2024.
//


import UIKit

class SecondViewController: UIViewController {
    
    // Available Sizes
    enum Size: Int, CustomStringConvertible, CaseIterable {
        case normal = 280
        case small = 150
        
        var description: String {
            return "\(rawValue)pt"
        }
        
        var height: CGFloat {
            return CGFloat(rawValue)
        }
    }
    
    // MARK: - Properties
    var size: Size = .normal {
        didSet {
            // We need to change preferredContentSize of UINavigationController (Presented View Controller)
            self.presentingViewController?.presentedViewController?.preferredContentSize = .init(width: 300, height: size.height)
        }
    }
    
    // MARK: - Helper Methods
    private func setupSegmentedControl() {
        let segmentedControl = UISegmentedControl(items: Size.allCases.map { "\($0)" })
        
        segmentedControl.sizeToFit()
        segmentedControl.selectedSegmentIndex = Size.allCases.firstIndex(of: size) ?? 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        // Add to NavigationBar
        navigationItem.titleView = segmentedControl
    }
    
    
    private func setupView() {
        // Background
        view.backgroundColor = .systemBackground
        
        // Segmented control
        setupSegmentedControl()
        
        // Close button
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
    }
    
    // MARK: - Actions
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        self.size = Size.allCases[sender.selectedSegmentIndex]
    }
    
    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.size = .normal
        
        setupView()
    }
}
