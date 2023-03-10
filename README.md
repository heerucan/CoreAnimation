# Core Animation

**Layer Basics**

- CALayer
- CALayerDelegate
- CAConstraint
- CALayoutManager
- CAConstraintLayoutManager
- CAAction

**Text, Shapes, and Gradients**

- CATextLayer
- CAShapeLayer
- CAGradientLayer

**Particle Systems**

- CAEmitterLayer
- CAEmitterCell

**Animation**

- CAAnimation
- CAAnimationDelegate
- CAPropertyAnimation
- CABasicAnimation
- CAKeyframeAnimation
- CASpringAnimation
- CATransition
- CAValueFunction

**Animation Groups**

- CAAnimationGroup
- CATransaction

**Animation Timing**

- func CACurrentMediaTime() → CFTimeInterval
- CAMediaTimingFunction
- CAMediaTiming
- CADisplayLink

<br>

# CoreAnimation 프레임워크

iOS 및 macOS 앱에서 애니메이션 및 그래픽 효과를 구현하는 데 사용되는 강력한 프레임워크

Core Animation은 **직접 그리지 않고, 온보드 그래픽 하드웨어(GPU)로 넘겨** 렌더링을 가속화한다.

- `장점`
    1. 앱의 속도를 늦추지 않고
    2. 높은 프레임 속도와
    3. 부드러운 애니메이션 제공
- `how?`
    
    뷰의 컨텐츠를 비트맵으로 캐싱해 그래픽 하드웨어에서 직접 조작할 수 있도록 함 (Layer가 하는 일)
    
    컨텐츠의 위기가 바뀌거나, 크기가 작아지거나 커지거나 등의 시각적 변경은 결국 개체의 속성이 바뀌는 것! → CA는 속성의 현재 값에서 바뀐 새 값을 캐싱해 애니메이션 적용
    
- `Layer`
    
    Core Animation의 중심!
    
    - 컨텐츠의 변경 사항을 **캡쳐해서 저장**하고,
    **하드웨어에게 전달**해
    소프트웨어에서 보다 빠르게 동작할 수 있는 애니메이션 생성
    
    View(`drawRect()`)로 하게 된다면, **메인 스레드의 CPU를 사용해서 비용이 많이 든다.**
    
    그래서! view.layer.cornerRadius와 같이 뷰의 레이어에 접근하는 것이다.


<br>
<br>


UIBezierPath를 통해 직선/곡선을 그릴 수 있는데 여기에 애니메이션을 주려면 CALayer를 사용해야 한다.

# CALayer 클래스

이미지 기반 컨텐츠를 관리하고 애니메이션을 수행할 수 있도록 하는 객체

```swift
class CALayer: NSObject
```

- CAMediaTiming 프로토콜을 채택함으로써 레이어 객체는 duration, pacing을 가지고 있다. visual contents를 관리하기 위해서 content의 모양과 상대적 위치 (position, size, transform) 등을 알아야 한다.
- **Layer Tree**
    
    Window Layer → View Layer → Sub Layer(SubLayer는 여러개 소유 가능)로 구성
    
    Presentation Layer - 애니메이션이 나타나는 순간의 화면에 접근이 가능해서 애니메이션 진행 중 어떤 작업을 하기 유용
    
- **Layer는 View를 대체할 수 없다.**
    - View의 Infrastructure, View는 자신과 대응되는 레이어를 가지고 있다.
    - 이벤트 처리, content를 그리거나, responder chain에 응답을 안하기 때문에
    - 뷰의 내용을 더 쉽고 효율적으로 그리거나, 애니메이션 구현시킬 수 있는 것일 뿐
    - 뷰에 의해 만들어진 layer 객체가 만들어졌다면, 그 뷰는 자동적으로 레이어의 대리인이 된다.
- **원리**
    
    **Geometry**
    
    공간에 있는 도형의 모양, 상대적 위치 의미
    
    1. **Bounds와 Position**
        
        ![gemtry](https://user-images.githubusercontent.com/63235947/224241066-95065df9-fee9-459b-bf61-965a921115c4.png)
        
        - Bounds는 어느 좌표에 어떤 크기로 있는지
        - Position은 Layer의 중앙 위치 → 전체 화면 기준 레이어의 위치 정의
    2. **AnchorPoint** : 어떤 변형이 일어나는 기준점 
        
        ex. AnchorPoint를 기준으로 회전한다는 것. (0.5, 0.5)냐, (1,1)이냐에 따라 회전 점이 달라져
        ![스크린샷 2023-03-10 오전 10 28 02](https://user-images.githubusercontent.com/63235947/224241108-68750bfa-ca49-45a0-b382-a0d7d9ab5596.png)

        ![스크린샷 2023-03-10 오전 10 28 11](https://user-images.githubusercontent.com/63235947/224241114-18c7e6a2-4af5-462f-865b-092011b1a44d.png)

        
- **CALayer를 상속받는 클래스**
    1. CATextLayer
    2. CAGradientLayer
    3. CAShapeLayer

<br>
<hr>

![스크린샷 2023-03-10 오전 11 53 20](https://user-images.githubusercontent.com/63235947/224241139-a0a37c7e-6c71-4354-b024-e5cd4c4baa70.png)


**CAAnimation 슈퍼클래스는 CAMediaTiming과 CAAction 프로토콜을 채택**
![스크린샷 2023-03-10 오후 2 28 51](https://user-images.githubusercontent.com/63235947/224241159-523bcaab-ab36-439e-9547-792add02fc46.png)

<br>

# CAAnimation 슈퍼클래스

**Core Animation 에 있는 애니메이션을 위한 추상 슈퍼클래스**

```swift
class CAAnimation: NSObject
```

- CAAnimation은 `CAMediaTiming 프로토콜과 CAAction 프로토콜`을 채택해서 기본 제공을 받는다.
- CAAnimation 관련 인스턴스를 생성하는 것이 아닌, 서브클래스인
CABasicAnimation, CAKeyframeAnimation, CAAnimationGroup, CATransition 인스턴스 생성하자
- CAAnimation은 UIView가 아니라 CALayer에 적용해 애니메이션을 줄 수 있다.
- SceneKit을 위한 Gemotry(공간 내 도형의 모양, 상대적 위치) 애니메이션의 시간, 처리과정, 액션도 나타낼 수 있다.

<br>

# CAMediaTiming 프로토콜

**애니메이션의 타이밍과 지속시간, 재생 속도, 반복 횟수 등을 조절하는 데 사용**

- CAAnimation과 CALayer가 클래스 구현
- `CACurrentMediaTime()`이 현재 절대 시간을 가져올 수 있게 도와준다.
    - `CFTimeInterval`(현재 시간)을 반환 → 시스템 전체에서 유일
    - beginTime에 해당 값을 할당하면 → 렌더링된 후에 시작
    - beginTime에 해당 값을 할당하지 않으면 → 뷰가 렌더링된 후 **가능한 한 빨리 실행**
        
        ```swift
        func CACurrentMediaTime() -> CFTimeInterval
        
        // 애니메이션의 시작시간을 현재 시간으로 설정
        animation.beginTime = CACurrentMediaTime()
        ```
        
- **주요 프로퍼티**
    1. **beginTime** : 애니메이션의 시작시간
    2. **timeOffset** : 애니메이션의 시작시간 지연시키고, 일시중지 + 재개하는 데 사용 - 기본값 0.0
        1. 1.0 : 현재 시간보다도 1초 후에 시작
        2. 현재시간, speed 0 → speed 1 : 일시중지 → 다시 시작
            ![스크린샷 2023-03-10 오후 1 56 28](https://user-images.githubusercontent.com/63235947/224241195-c796b412-2db5-414c-9139-7a44deb86a57.png)

            
    3. **duration** : 애니메이션의 총 지속시간 - 기본값 0.25초
    4. **speed** : 애니메이션의 재생 속도 - 기본값 1.0
    5. **repeatCount** : 애니메이션의 반복 횟수 - 기본값 0 (0으로 설정 시 1번 실행) / 무한반복 - infinity
    6. **repeatDuration** : 애니메이션의 반복 지속 시간 (repeatCount 대신 사용 가능)
    7. **autoreverses** : 애니메이션이 역방향으로 재생되는지 여부 - 기본값 false
    8. **fillMode** : 애니메이션이 시작 전이나 종료 후 어떤 값을 유지할지 나타냄 - kCAFillModeRemoved
    
    ```swift
    animation.duration = 1
    animation.beginTime = CACurrentMediaTime()
    animation.timeOffset = 2
    animation.repeatCount = 4
    animation.autoreverses = true
    ```
    
<br>

# CAAction 프로토콜

**CALayer의 애니메이션 이벤트에 대한 동작을 처리하는 데 사용**

[https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/ReactingtoLayerChanges/ReactingtoLayerChanges.html](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/ReactingtoLayerChanges/ReactingtoLayerChanges.html)

- 애니메이션 이벤트가 발생할 때 수행할 동작을 정의
- 2가지 메소드
    1. `run(forKey:object:arguments:)` : 애니메이션 이벤트가 발생할 때 실행할 동작 정의
    2. `shouldRemoveAction(forKey:)` : 이벤트가 끝나고 해당 이벤트를 제거할 지 여부 결정

<br>

# CAPropertyAnimation 클래스

**CAAnimation의 서브클래스로, CALayer 프로퍼티를 애니메이션화하는 데 사용**

- 자체 인스턴스를 만든 게 아닌, CABasicAnimation, CAKeyframeAnimation 인스턴스를 만들어야 한다.
- **주요 프로퍼티 및 메소드**
    1. keyPath : 애니메이션 대상의 프로퍼티 지정 가능
    2. isAdditive : 현재 프레젠테이션 값에 더해져서 새로운 프레젠테이션 값을 생성하는지 여부
    3. isCumulative : 반복 애니메이션의 결과를 생성하는 것에 영향
    4. valueFunction : 애니메이션의 변화를 표현, 보간법을 사용해서 가능 - 기본값 nil


<br>

# **CABasicAnimation 클래스**

CAPropertyAnimation의 하위 클래스

**레이어 프로퍼티에 기본 단일 키 프레임 애니메이션 제공**

```swift
open class CABasicAnimation : CAPropertyAnimation {

    
    /* The objects defining the property values being interpolated between.
     * All are optional, and no more than two should be non-nil. The object
     * type should match the type of the property being animated (using the
     * standard rules described in CALayer.h). The supported modes of
     * animation are:
     *
     * - both `fromValue' and `toValue' non-nil. Interpolates between
     * `fromValue' and `toValue'.
     *
     * - `fromValue' and `byValue' non-nil. Interpolates between
     * `fromValue' and `fromValue' plus `byValue'.
     *
     * - `byValue' and `toValue' non-nil. Interpolates between `toValue'
     * minus `byValue' and `toValue'.
     *
     * - `fromValue' non-nil. Interpolates between `fromValue' and the
     * current presentation value of the property.
     *
     * - `toValue' non-nil. Interpolates between the layer's current value
     * of the property in the render tree and `toValue'.
     *
     * - `byValue' non-nil. Interpolates between the layer's current value
     * of the property in the render tree and that plus `byValue'. */
    
    open var fromValue: Any?

    open var toValue: Any?

    open var byValue: Any?
}
```

애니메이션의 시작값과 끝값을 정의하는 데 사용, 적어도 하나는 설정해줘야 함

- fromValue, toValue, byValue
1. fromValue, toValue가 설정된 경우, 애니메이션이 두 값 사이를 보간(두 점 사이의 궤적 연결)
2. fromValue, byValue가 설정된 경우, `(fromValue) ~ (fromValue+byValue)` 사이 보간
3. byValue, toValue가 설정된 경우, `(toValue-byValue) ~ (toValue)` 사이 보간
4. fromValue만 설정된 경우, `(fromValue) ~ (속성의 현재 표기 값)` 사이 보간
5. toValue만 설정된 경우, 레이어의 렌더 트리에서 `(속성의 현재값) ~ (toValue)` 사이 보간
6. byValue만 설정된 경우, 레이어의 렌더 트리에서 `(속성의 현재값) ~ (해당값+byValue`) 보간

**보간* : 공이 튀어올랐을 때, 공의 초기값 - 튀어 오른 최댓값 - 바닥에 떨어진 값 만 지정하면 나머지는 자동으로 계산

<br>

# **CAKeyframeAnimation 클래스**

CAPropertyAnimation의 하위 클래스

**레이어 객체에 키 프레임 단위로 쪼개서 각각의 키 프레임마다 애니메이션 기능을 제공하는 객체
(여러 Keyframe 가능인듯)**

keyTimes, values 속성을 사용해 애니메이션의 중간값을 명시적으로 지정 가능

```swift
let keyframeAnimation = CAKeyframeAnimation(keyPath: "backgroundColor")
keyframeAnimation.isAdditive = true
keyframeAnimation.values = [UIColor.red.cgColor, UIColor.green.cgColor, UIColor.blue.cgColor]
keyframeAnimation.keyTimes = [0, 0.5, 1]
keyframeAnimation.duration = 3
keyframeView.layer.add(keyframeAnimation, forKey: "keyframe")
```

<br>

# Tutorial

UIView의 색상, 크기 등의 프로퍼티를 변경하는 것은 그 아래 깔린 레이어를 바꾼 거다.

CA는 OpenGL 베이스로 그래픽 작업을 하기 쉽게 만들어졌다.

![스크린샷 2023-03-10 오전 11 04 28](https://user-images.githubusercontent.com/63235947/224241237-2f09235b-d857-47f2-9199-e903f9b7fa85.png)


UIKit/AppKit은 CA보다 윗단계 프레임워크라 CA에서 복잡한 UI와 애니메이션을 요청할 필요가 없다.

**More About CALayer**

- layer는 모델객체다.
- layer는 복잡한 Auto Layout를 포함하지 않고 user experience를 다루지 않는다.
- layer에는 콘텐츠가 화면에 표시되는 것에 영향을 미치는 borderWidth, borderColor, cornerRadius, element position(위치) 등을 포함하는 시각적 특징을 가지고 있다.

**Layer Animation**

레이어 애니메이션은 뷰 애니메이션과 같은 방식으로 작동한다.

특정 시간 범위의 초기값과 최종값 사이의 속성을 애니메이션화하고 중간 렌더링을 Core Animation이 처리하도록 한다.

<br>
<hr>

### Bounds와 Frame

둘 다, CGRect 타입이다.

**`Bounds`**

- The bounds rectangle, which describes the view’s location and size in 
**its own coordinate system**
- 자기자신의 좌표계 기준

**`Frame`**

- The frame rectangle, which describes the view’s location and size in 
**its superview’s coordinate system**
- 슈퍼뷰의 좌표계를 기준

**`무슨 차이?`**

- 기준이 되는 좌표계가 다르면, origin이 달라질 수 있다.
    - bounds는 자기자신 중심이기에 (0,0) → 위치 정보가 X
    - frame은 슈퍼뷰 기준으로 (20, 60)
- 회전 시에
    - bounds는 변화가 없다.
    - frame은 view를 모두 감쌀 수 있도록 커진다. → frame의 origin, size 값 모두 더 커진 빨간색 사각형 기준으로 계산
    ![스크린샷 2023-03-10 오전 10 11 00](https://user-images.githubusercontent.com/63235947/224241273-9e7ecdac-c418-43bf-ad77-54962c59d9f7.png)

    
    
    왼쪽 - bounds, 오른쪽 - frame
    

**`언제 어떤 것을 쓰나?`**

- bounds : view 내부에 그림 그릴 때, 하위 view 정렬 시 등 내부적인 변경
- frame : view의 위치나 크기 설정 시 사용

<br>
<hr>

### CGRect, CGPoint, CGSize

**CGPoint**

(x, y) 좌표를 설정할 수 있기에 View의 위치를 나타낼 때 사용

```swift
public struct CGPoint {
		public var x: CGFloat
		public var y: CGFloat

		public init()
		public init(x: CGFloat, y: CGFloat)
}
```

```swift
let myPoint: CGPoint = .init(x: 100, y: 300)
```

**CGSize**

(width, height) 사이즈를 설정할 수 있기에 View의 size를 설정할 때 사용

```swift
public struct CGSize {
		public var width: CGFloat
		public var height: CGFloat

		public init()
		public init(width: CGFloat, height: CGFloat)
}
```

```swift
let mySize: CGSize = .init(width: 100, height: 200)
```

**CGRect**

(origin: CGPoint, size: CGSize)를 갖고 있기에 View의 frame에 접근 시 사용
```swift
public struct CGRect {
		public var origin: CGPoint
		public var size: CGSize

		public init()
		public init(origin: CGPoint, size: CGSize)
}
```

```swift
let rect: CGRect = .init(origin: CGPoint(x: 100, y: 200), size: CGSize(width: 150, height: 200))
```

```swift
practiceView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
```
