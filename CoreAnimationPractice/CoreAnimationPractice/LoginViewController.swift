//
//  LoginViewController.swift
//  CoreAnimationPractice
//
//  Created by heerucan on 2023/03/13.
//

/*
 로그인 버튼 - shimmering
 입력 안하고 로그인 버튼 누를 경우 - 빈 텍스트필드 shake
 텍스트필드 테두리 그라디언트 - CAGradientLayer
 로그인 성공 시 - CAEmitterLayer
 CASpringAnimation
 */

import UIKit

final class LoginViewController: UIViewController {
    
    private let loginLabel: UILabel = {
        let view = UILabel()
        view.text = "로그인"
        view.textColor = .blue
        view.font = .systemFont(ofSize: 20)
        return view
    }()
    
    private let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureLayout()
    }
    
    // MARK: - Init UI
    
    private func setupUI() {
        view.backgroundColor = .white
        nextButton.backgroundColor = .blue
        nextButton.setTitle("다음", for: .normal)
        nextButton.addTarget(self, action: #selector(touchupNextButton), for: .touchUpInside)
    }
    
    private func configureLayout() {
        view.addSubview(nextButton)
        view.addSubview(loginLabel)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    // MARK: - Custom Method
    @objc private func touchupNextButton() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .moveIn
        transition.subtype = .fromBottom
        transition.timingFunction = CAMediaTimingFunction(name: .easeIn)
        loginLabel.layer.add(transition, forKey: "transition")
        //        navigationController?.pushViewController(viewController: DetailViewController(), animated: true) {
        //            print("what it is?")
        ////            self.view.removeFromSuperview()
        //        }
    }
}

extension UINavigationController {
    func pushViewController(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(2)
        CATransaction.setCompletionBlock(completion)
        CATransaction.setCompletionBlock {
            
        }
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}
