//
//  ViewController.swift
//  Task2_ThreeButtons
//
//  Created by pavel mishanin on 4/2/24.
//

import UIKit

final class BaseButton: UIButton {
    
    private let tapHandler: (()->())?
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: [.allowUserInteraction, .beginFromCurrentState],
                           animations: {
                let scale = self.isHighlighted ? 0.8 : 1
                self.transform = CGAffineTransform(scaleX: scale, y: scale)
            }, completion: nil)
            
            if self.isHighlighted {
                tapHandler?()
            }
        }
    }
    
    init(text: String, tapHandler: (()->())? = nil) {
        self.tapHandler = tapHandler
        super.init(frame: .zero)

        if let image = UIImage(systemName: "arrow.right.circle.fill") {
            setImage(image, for: .normal)
        }
        
        backgroundColor = .systemBlue
        tintColor = .white
        setTitleColor(.white, for: .normal)
        
        let imageOffset: CGFloat = 8
        
        setTitle(text, for: .normal)
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 14 + imageOffset, bottom: 10, right: 14)
        layer.cornerRadius = 8
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageOffset, bottom: 0, right: imageOffset)
        semanticContentAttribute = .forceRightToLeft
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        
       if tintAdjustmentMode == .dimmed {
           tintColor = .systemGray3
           setTitleColor(.systemGray3, for: .normal)
           backgroundColor = .systemGray2
       } else {
           setTitleColor(.white, for: .normal)
           tintColor = .white
           backgroundColor = .systemBlue
       }
    }
}

final class ViewController: UIViewController {
    
    private let firstButton = BaseButton(text: "First Button")
    private let secondButton = BaseButton(text: "Second Medium Button")
    private lazy var thirdButton = BaseButton(text: "Third") { [weak self] in self?.presentModalVC() }
    
    private lazy var vStack = UIStackView(arrangedSubviews: [firstButton, secondButton, thirdButton])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        vStack.axis = .vertical
        vStack.spacing = 10
        vStack.alignment = .center
        vStack.distribution = .equalSpacing
        
        view.addSubview(vStack)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
    
    func presentModalVC() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .lightGray
        present(viewController, animated: true)
    }
}

