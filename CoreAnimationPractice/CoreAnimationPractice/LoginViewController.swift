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
    private let transitionButton = UIButton()
    private let emitterButton = UIButton()
    
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
        
        transitionButton.backgroundColor = .green
        transitionButton.setTitle("트랜지션보기", for: .normal)
        transitionButton.addTarget(self, action: #selector(touchupTransitionButton), for: .touchUpInside)
        
        emitterButton.backgroundColor = .orange
        emitterButton.setTitle("파티클보기", for: .normal)
        emitterButton.addTarget(self, action: #selector(touchupEmitterButton), for: .touchUpInside)
    }
    
    private func configureLayout() {
        view.addSubview(nextButton)
        view.addSubview(transitionButton)
        view.addSubview(emitterButton)
        view.addSubview(loginLabel)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        transitionButton.translatesAutoresizingMaskIntoConstraints = false
        transitionButton.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 20).isActive = true
        transitionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        transitionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        transitionButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        transitionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        emitterButton.translatesAutoresizingMaskIntoConstraints = false
        emitterButton.topAnchor.constraint(equalTo: transitionButton.bottomAnchor, constant: 20).isActive = true
        emitterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        emitterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        emitterButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        emitterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    // MARK: - Custom Method
    @objc private func touchupNextButton() {
        navigationController?.pushViewController(viewController: DetailViewController(), animated: true) {
        }
    }
    
    @objc private func touchupTransitionButton() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .moveIn
        transition.subtype = .fromBottom
        transition.timingFunction = CAMediaTimingFunction(name: .easeIn)
        loginLabel.layer.add(transition, forKey: "transition")
    }
    
    @objc private func touchupEmitterButton() {
        print(#function)
        let particleEmitter = CAEmitterLayer()
        particleEmitter.emitterPosition = CGPoint(x: view.center.x, y: 100) // 파티클이 뿜어져나올 위치
        particleEmitter.emitterSize = CGSize(width: view.frame.size.width, height: 2)
        
        let cell = CAEmitterCell()
        cell.birthRate = 10
        cell.lifetime = 10
        cell.lifetimeRange = 2
        cell.velocity = 100
        cell.velocityRange = 50
        cell.emissionRange = .pi*2 // 2pi는 360도 모든 방향으로 방출
        cell.spin = 3
        cell.spinRange = 10
        cell.scale = 0.2
        cell.scaleRange = 0.1
        cell.yAcceleration = 500
        cell.contents = UIImage(named: "ruhee")?.cgImage
        
        particleEmitter.emitterCells = [cell]
        view.layer.addSublayer(particleEmitter)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            particleEmitter.birthRate = 0
        }
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
