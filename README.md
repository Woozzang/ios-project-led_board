# LED-Board

입력한 텍스트를 전광판 화면에 보여주는 앱 🌱 ([SSAC](https://github.com/Woozzang/ssac-bless-me) 과제 프로젝트)
<br />
![1](/Resources/1.gif)

<br />

사용 개념 : `UITextField`, `FirstResponder`, `UIButton`, `TapGestureRecognizer`, `Delegation`, `Target-Action`, `UIScrollview`
<br />
<br />

# 1단계

✅  iOS Version, Device Orientation 설정

✅  AppIcon 적용

→ 리소스 이미지가 단일 해상도만 전달되어서 [이 링크](https://appiconmaker.co/Home/Index/c2ab35a1-ed84-48a8-a065-b684eeb78509) 에서 해상도별 아이콘을 생성해서 넣어주었다.

✅  LaunchScreen

- 이미지 추가
- 3초간 강제로 보여주는 로직 넣어주기

✅  Xcode12 에서는 안되는 padding 넣기 직접 구현

→ `IntrinsicContentSize` 대신 Autolayout 제약을 사용한다면 `contentInset` 으로 해결하면 될 것 같다.

→ 앱 구성이 화면 하나뿐이라서 편의상 UIButton 을 따로 서브클래싱해서 사용하지 않았다.

```swift
 extension UIButton {
  
  private var customDefinedHorizontalPadding: CGFloat {
    get {
      return 24
    }
  }
  
  open override var intrinsicContentSize: CGSize {
  
    get {
      let baseSize = super.intrinsicContentSize
      
      return CGSize(width: baseSize.width + (customDefinedHorizontalPadding * 2),
                    height: baseSize.height)
    }
  }
}
```

✅  기본적인 화면 구성
<br />
<br />
<br />

# 2단계

✅ Outlet 연결 후, 코드로 UI 수정

→ `didSet` 에 커스텀메서드 호출

```swift
@IBOutlet weak var boardView: UIView! {
    didSet {
      applyRoundDesign(to: boardView)
    }
}

...

private func applyRoundDesign(to view: UIView) {
    view.layer.cornerRadius = view.frame.height/4
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
}
```

✅  Button Action 에 TextField 의 Text 변경 로직 추가

✅ Aa Button 을 클릭하면, Label 의 텍스트컬러가 랜덤으로 변화

```swift
@IBAction func didTapColorButton(_ sender: Any) {
    
    let redValue : CGFloat = CGFloat((1...256).randomElement()!) / CGFloat(256)
    let greenValue : CGFloat = CGFloat((1...256).randomElement()!) / CGFloat(256)
    let blueVlaue: CGFloat = CGFloat((1...256).randomElement()!) / CGFloat(256)
    
    let randomColor = UIColor(red: redValue, green: greenValue, blue: blueVlaue, alpha: 1)
    
    
    resultLabel.textColor = randomColor
}
```
<br />
<br />

# 3단계

✅  탭 제스쳐가 실행되면 키보드를 내려주기

→ TapGestureRecognizer 는 RootView 에 추가해주었고, 액션을 연결하여 resignFristResponder() 를 호출해주었다.
<br />
<br />

# 4단계

✅  키보드 리턴키를 누르면 키보드가 내려가게 구현하기

→ 리턴 키를 누르면  `Did End On Exit` 메시지가 전달된다. 이것을 처리할 액션을 구현하면 된다.

→ 다른 방법으로 UITextFieldDelegate 중에도 관련 메서드가 있을까?? 있음

```swift
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    resultLabel.text = textField.text
    textField.resignFirstResponder()
    return true
}
```
<br />
<br />

# 5단계

✅  탭 제스처를 클릭씨 상단 View 가 토글 형태로 숨겼다 보였다 하는 기능을 구현

✅  글자수가 많아지면 자동으로 스크롤 되게 구현

→ 기존의 스크롤뷰 기존 설정은 그대로 진행

→ UILabel 과 스크롤뷰의 컨텐츠 루트뷰에 스페이싱 제약을 걸고, 상위뷰의 width 제약을 equltTo 에서 greaterThan 으로 바꿔주면 동적으로 증가한당!
<br />
![Untitled](/Resources/2.gif)
