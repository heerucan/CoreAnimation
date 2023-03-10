//
//  ViewController.swift
//  CoreAnimationPractice
//
//  Created by heerucan on 2023/03/10.
//

import UIKit

final class ViewController: UIViewController {
    
    private var practiceView = UIView()
    private var keyframeView = UIView()
    private var starView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureLayout()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = 100
        animation.toValue = 200
        animation.byValue = 150
        animation.duration = 1
        animation.beginTime = CACurrentMediaTime()
        animation.timeOffset = 2
        animation.repeatCount = .infinity
        animation.autoreverses = true
        practiceView.layer.add(animation, forKey: nil)
        
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "backgroundColor")
        keyframeAnimation.isAdditive = true
        keyframeAnimation.values = [UIColor.red.cgColor, UIColor.green.cgColor, UIColor.blue.cgColor]
        keyframeAnimation.keyTimes = [0, 0.5, 1]
        keyframeAnimation.duration = 2
        keyframeAnimation.repeatCount = .infinity
        practiceView.layer.add(keyframeAnimation, forKey: "backgroundColor")
        
        // 프로그램한테 어떤 애니메이션을 줄 지 알리는 것
        let starRotation = CAKeyframeAnimation(keyPath: "transform.rotation")
        starRotation.keyTimes = [0, 0.5, 1]
        starRotation.values = [0, Double.pi*3, Double.pi*3]
        starRotation.duration = 10
        starRotation.repeatCount = Float.infinity
        practiceView.layer.add(starRotation, forKey: "transform.rotation")
    }
    
    private func setupUI() {
        practiceView = UIView(frame: CGRect(x: 10, y: 0, width: 100, height: 100))
        practiceView.backgroundColor = .red
        keyframeView = UIView(frame: CGRect(x: 20, y: 200, width: 100, height: 100))
        keyframeView.backgroundColor = .blue
        starView = UIView(frame: CGRect(x: 100, y: 500, width: 50, height: 50))
        starView.backgroundColor = .orange
    }
    
    private func configureLayout() {
        view.addSubview(practiceView)
        view.addSubview(keyframeView)
        view.addSubview(starView)
    }
}
