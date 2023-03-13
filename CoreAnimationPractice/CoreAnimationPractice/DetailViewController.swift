//
//  DetailViewController.swift
//  CoreAnimationPractice
//
//  Created by heerucan on 2023/03/10.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private var moveHorizontalView = UIView()
    private var moveVerticalView = UIView()
    private var horizontalScaleView = UIView()
    private var verticalScaleView = UIView()
    private var bothXYScaleView = UIView()
    private var fadeInView = UIView()
    private var fadeOutView = UIView()
    private var shakeView = UIView()
    private var changeColorView = UIView()
    private var rotateView = UIView()
    private var circleMoveView = UIView()
    private var squareMoveView = UIView()
    private var rotateAndMoveGroupView = UIView()
    private var scaleChangeAndMoveGroupView = UIView()
    private var scaleChangeAndRotateGroupView = UIView()
    private var scaleFadeMoveRotateGroupView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let timingFunction = CAMediaTimingFunction(controlPoints: 0, 0.3, 0.6, 1)
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(3)
        CATransaction.setAnimationTimingFunction(timingFunction)
        
        // MARK: - 가로로 이동
        let moveHorizontalBasicAnimation = CABasicAnimation(keyPath: "position.x")
        // fromValue, toValue 모두 anchorPoint이고, center값을 기준으로 동작
        // moveHorizontalView.center.x = 45임. 왜냐하면 (leading margin = 20) + (해당 view의 width 절반값 = 25)
        moveHorizontalBasicAnimation.fromValue = moveHorizontalView.center.x
        moveHorizontalBasicAnimation.toValue = moveHorizontalView.center.x+300
        moveHorizontalBasicAnimation.duration = 1 // 지속시간, 숫자가 작을수록 모션이 빨라짐
        moveHorizontalBasicAnimation.beginTime = CACurrentMediaTime()
        moveHorizontalBasicAnimation.timeOffset = 0
        moveHorizontalBasicAnimation.repeatCount = .infinity
        moveHorizontalBasicAnimation.autoreverses = true
        moveHorizontalBasicAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        moveHorizontalView.layer.add(moveHorizontalBasicAnimation, forKey: "horizontal")
        
        // MARK: - 세로로 이동
        let moveVerticalBasicAnimation = CABasicAnimation(keyPath: "position.y")
        moveVerticalBasicAnimation.fromValue = moveVerticalView.center.y
        moveVerticalBasicAnimation.toValue = rotateView.center.y
        moveVerticalBasicAnimation.duration = 1
        moveVerticalBasicAnimation.repeatCount = .infinity
        moveVerticalBasicAnimation.autoreverses = true
        moveVerticalBasicAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        moveVerticalView.layer.add(moveVerticalBasicAnimation, forKey: "vertical")
        
        // MARK: - 가로만 확대
        let horizontalScaleAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        horizontalScaleAnimation.fromValue = 1
        horizontalScaleAnimation.toValue = 2
        horizontalScaleAnimation.duration = 1
        horizontalScaleAnimation.repeatCount = .infinity
        horizontalScaleAnimation.autoreverses = true // 역재생
        horizontalScaleView.layer.add(horizontalScaleAnimation, forKey: "scaleupX")
        
        // MARK: - 세로만 확대
        let verticalScaleAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        verticalScaleAnimation.fromValue = 1
        verticalScaleAnimation.toValue = 2
        verticalScaleAnimation.duration = 1
        verticalScaleAnimation.repeatCount = .infinity
        verticalScaleAnimation.autoreverses = true
        verticalScaleView.layer.add(verticalScaleAnimation, forKey: "scaleupY")
        
        // MARK: - 가로세로 확대
        let bothXYScaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        bothXYScaleAnimation.fromValue = 1
        bothXYScaleAnimation.toValue = 2
        bothXYScaleAnimation.duration = 1
        bothXYScaleAnimation.repeatCount = .infinity
        bothXYScaleAnimation.autoreverses = true
        bothXYScaleView.layer.add(bothXYScaleAnimation, forKey: "scaleupXY")
        
        // MARK: - 페이드인
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        fadeInAnimation.duration = 2
        fadeInAnimation.repeatCount = .infinity
        fadeInView.layer.add(fadeInAnimation, forKey: "fadeIn")
        
        // MARK: - 페이드아웃
        let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
        fadeOutAnimation.fromValue = 1
        fadeOutAnimation.toValue = 0
        fadeOutAnimation.duration = 2
        fadeOutAnimation.repeatCount = .infinity
        fadeOutView.layer.add(fadeOutAnimation, forKey: "fadeOut")
        
        CATransaction.commit()

        // MARK: - 흔들기
        let shakeAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        shakeAnimation.byValue = -5
        shakeAnimation.duration = 0.01
        shakeAnimation.repeatCount = .infinity
        shakeAnimation.autoreverses = true
        shakeView.layer.add(shakeAnimation, forKey: "shake")
        
        // MARK: - 색변경
        let changeColorKeyframe = CAKeyframeAnimation(keyPath: "backgroundColor")
        changeColorKeyframe.isAdditive = true
        changeColorKeyframe.values = [UIColor.red.cgColor, UIColor.green.cgColor, UIColor.blue.cgColor]
        // keyTimes는 duration 동안 키프레임을 얼마나 나눌 건지에 대한 것
        changeColorKeyframe.keyTimes = [0, 0.5, 1]
        changeColorKeyframe.duration = 2
        changeColorKeyframe.repeatCount = .infinity
        changeColorView.layer.add(changeColorKeyframe, forKey: "backgroundColor")
        
        // MARK: - 회전
        let rotateKeyFrame = CAKeyframeAnimation(keyPath: "transform.rotation")
        rotateKeyFrame.keyTimes = [0, 0.5, 1]
        rotateKeyFrame.values = [0, Double.pi*3, Double.pi*3]
        rotateKeyFrame.duration = 10
        rotateKeyFrame.repeatCount = .infinity
        rotateView.layer.add(rotateKeyFrame, forKey: "transform.rotation")
        
        // MARK: - 원으로 이동하면서 모양 바뀌기
        let moveKeyFrame = CAKeyframeAnimation(keyPath: "position.x")
        moveKeyFrame.keyTimes = [0, 0.5, 1]
        moveKeyFrame.values = [110, 200, 300]
        let circleKeyframe = CAKeyframeAnimation(keyPath: "cornerRadius")
        circleKeyframe.keyTimes = [0, 0.5, 1]
        circleKeyframe.values = [0, 10, 45/2]
        let circleAndMoveGroup = CAAnimationGroup()
        circleAndMoveGroup.animations = [moveKeyFrame, circleKeyframe]
        circleAndMoveGroup.duration = 1
        circleAndMoveGroup.repeatCount = .infinity
        circleAndMoveGroup.autoreverses = true
        circleAndMoveGroup.timingFunction = CAMediaTimingFunction(name: .easeIn)
        circleMoveView.layer.add(circleAndMoveGroup, forKey: "circleAndMove")
        
        // MARK: - 사각형으로 이동하면서 모양 바뀌기
        let squareKeyframe = CAKeyframeAnimation(keyPath: "cornerRadius")
        squareKeyframe.keyTimes = [0, 0.5, 1]
        squareKeyframe.values = [45/2, 10, 0]
        let squareAndMoveGroup = CAAnimationGroup()
        squareAndMoveGroup.animations = [moveKeyFrame, squareKeyframe]
        squareAndMoveGroup.duration = 1
        squareAndMoveGroup.repeatCount = .infinity
        squareAndMoveGroup.autoreverses = true
        squareKeyframe.timingFunction = CAMediaTimingFunction(name: .easeOut)
        squareMoveView.layer.add(squareAndMoveGroup, forKey: "squareAndMove")
        
        // MARK: - 이동하면서 회전
        let rotateAndMoveGroup = CAAnimationGroup()
        rotateAndMoveGroup.animations = [moveKeyFrame, rotateKeyFrame]
        rotateAndMoveGroup.duration = 1
        rotateAndMoveGroup.repeatCount = .infinity
        rotateAndMoveGroup.autoreverses = true
        rotateAndMoveGroup.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        rotateAndMoveGroupView.layer.add(rotateAndMoveGroup, forKey: "rotateAndMove")
        
        // MARK: - 이동하면서 확대/축소
        let scaleKeyFrame = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleKeyFrame.keyTimes = [0, 0.3, 0.6, 1]
        scaleKeyFrame.values = [1, 0.5, 1, 0.5]
        let scaleChangeAndMoveGroup = CAAnimationGroup()
        scaleChangeAndMoveGroup.animations = [moveKeyFrame, scaleKeyFrame]
        scaleChangeAndMoveGroup.duration = 1
        scaleChangeAndMoveGroup.repeatCount = .infinity
        scaleChangeAndMoveGroup.autoreverses = true
        scaleChangeAndMoveGroupView.layer.add(scaleChangeAndMoveGroup, forKey: "scaledownAndMove")
        
        // MARK: - 회전하면서 확대/축소
        let rotate2KeyFrame = CAKeyframeAnimation(keyPath: "transform.rotation")
        rotate2KeyFrame.keyTimes = [0, 1]
        rotate2KeyFrame.values = [0, Double.pi*3]
        let scaleChangeAndRotateGroup = CAAnimationGroup()
        scaleChangeAndRotateGroup.animations = [rotate2KeyFrame, scaleKeyFrame]
        scaleChangeAndRotateGroup.duration = 1
        scaleChangeAndRotateGroup.repeatCount = .infinity
        scaleChangeAndRotateGroup.autoreverses = true
        scaleChangeAndRotateGroupView.layer.add(scaleChangeAndRotateGroup, forKey: "scaleupAndRotate")
                
        // MARK: - 확대, 축소하면서 페이드인, 페이드아웃 여러번 적용
        let fadeInOutKeyFrame = CAKeyframeAnimation(keyPath: "opacity")
        fadeInOutKeyFrame.keyTimes = [0, 0.3, 0.6, 1]
        fadeInOutKeyFrame.values = [1, 0, 1, 0]
        let scaleFadeMoveRotateGroup = CAAnimationGroup()
        scaleFadeMoveRotateGroup.animations = [rotate2KeyFrame, scaleKeyFrame, moveKeyFrame, fadeInOutKeyFrame]
        scaleFadeMoveRotateGroup.duration = 1
        scaleFadeMoveRotateGroup.repeatCount = .infinity
        scaleFadeMoveRotateGroup.autoreverses = true
        scaleFadeMoveRotateGroupView.layer.add(scaleFadeMoveRotateGroup, forKey: "scaleMoveRotateFade")
        
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        moveHorizontalView = UIView(frame: CGRect(x: 20, y: 50, width: 50, height: 50))
        moveHorizontalView.backgroundColor = .red
        
        moveVerticalView = UIView(frame: CGRect(x: 200, y: 120, width: 50, height: 50))
        moveVerticalView.backgroundColor = .red
        
        changeColorView = UIView(frame: CGRect(x: 20, y: 120, width: 50, height: 50))
        changeColorView.backgroundColor = .black
        
        horizontalScaleView = UIView(frame: CGRect(x: 40, y: 330, width: 50, height: 50))
        horizontalScaleView.backgroundColor = .green
        
        verticalScaleView = UIView(frame: CGRect(x: 200, y: 260, width: 50, height: 50))
        verticalScaleView.backgroundColor = .green
        
        bothXYScaleView = UIView(frame: CGRect(x: 200, y: 370, width: 50, height: 50))
        bothXYScaleView.backgroundColor = .green
        
        fadeInView = UIView(frame: CGRect(x: 20, y: 400, width: 50, height: 50))
        fadeInView.backgroundColor = .blue
        
        fadeOutView = UIView(frame: CGRect(x: 85, y: 400, width: 50, height: 50))
        fadeOutView.backgroundColor = .blue
        
        shakeView = UIView(frame: CGRect(x: 20, y: 470, width: 50, height: 50))
        shakeView.backgroundColor = .blue
        
        rotateView = UIView(frame: CGRect(x: 20, y: 190, width: 50, height: 50))
        rotateView.backgroundColor = .orange
        
        circleMoveView = UIView(frame: CGRect(x: 85, y: 470, width: 50, height: 50))
        circleMoveView.backgroundColor = .purple
        
        squareMoveView = UIView(frame: CGRect(x: 85, y: 540, width: 50, height: 50))
        squareMoveView.backgroundColor = .purple
        
        rotateAndMoveGroupView = UIView(frame: CGRect(x: 20, y: 260, width: 50, height: 50))
        rotateAndMoveGroupView.backgroundColor = .yellow
        
        scaleChangeAndMoveGroupView = UIView(frame: CGRect(x: 85, y: 610, width: 50, height: 50))
        scaleChangeAndMoveGroupView.backgroundColor = .systemPink
        
        scaleChangeAndRotateGroupView = UIView(frame: CGRect(x: 20, y: 540, width: 50, height: 50))
        scaleChangeAndRotateGroupView.backgroundColor = .cyan
        
        scaleFadeMoveRotateGroupView = UIView(frame: CGRect(x: 20, y: 670, width: 50, height: 50))
        scaleFadeMoveRotateGroupView.backgroundColor = .black
    }
    
    private func configureLayout() {
        view.addSubview(moveHorizontalView)
        view.addSubview(moveVerticalView)
        view.addSubview(changeColorView)
        view.addSubview(horizontalScaleView)
        view.addSubview(verticalScaleView)
        view.addSubview(bothXYScaleView)
        view.addSubview(fadeInView)
        view.addSubview(fadeOutView)
        view.addSubview(shakeView)
        view.addSubview(rotateView)
        view.addSubview(circleMoveView)
        view.addSubview(squareMoveView)
        view.addSubview(rotateAndMoveGroupView)
        view.addSubview(scaleChangeAndMoveGroupView)
        view.addSubview(scaleChangeAndRotateGroupView)
        view.addSubview(scaleFadeMoveRotateGroupView)
    }
}
