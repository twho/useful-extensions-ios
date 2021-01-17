# Useful Extensions in Swift
[![Generic badge](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://shields.io/) [![Generic badge](https://img.shields.io/badge/iOS-12.0+-blue.svg)](https://shields.io/)

### NSObject
```swift
var appDelegate: UIApplicationDelegate { get }
```
### UIApplication
```swift
public func setStatusBarBackgroundColor(_ color: UIColor)
```
### UIImageView
```swift
public func colored(color: UIColor?)
```
### UISlider
```swift
public func setThumbImage(_ image: UIImage?)
```
### NSLayoutConstraint
```swift
public func changeConstant(_ constant: CGFloat)
```
### StringProtocol
```swift
public func index(of string: Self, options: String.CompareOptions = []) -> Index?
```
### UILabel
```swift
public convenience init(title: String, size: CGFloat, bold: Bool = true, color: UIColor, numOfLines: Int = 1, alignment: NSTextAlignment = .center)
```
### UITableView
```swift
public func reloadDataWithAnimation()
```
### UIView
```swift
public var heightConstraint: NSLayoutConstraint? { get }

public var widthConstraint: NSLayoutConstraint? { get }

public func setAnchors(top: UIView? = nil, bottom: UIView? = nil, left: UIView? = nil, right: UIView? = nil)

public func setConstraintsToView(top: UIView? = nil, tConst: CGFloat = 0, bottom: UIView? = nil, bConst: CGFloat = 0, left: UIView? = nil, lConst: CGFloat = 0, right: UIView? = nil, rConst: CGFloat = 0)

public func centerSubView(_ view: UIView)

public func setSquareUsingWidthReference()

public func setSquarUsignHeightReference()

public func setHeightByAspectRatio(_ ratio: CGFloat)

public func setHeightConstraint(_ height: CGFloat)

public func setWidthConstraint(_ width: CGFloat)

public func alignCenter(to view: UIView)

public convenience init(color: UIColor)

public func setCornerBorder(color: UIColor? = nil, cornerRadius: CGFloat = 12.0, borderWidth: CGFloat = 1.5)

public func setCircular(color: UIColor? = nil, borderWidth: CGFloat = 5.0)

public func setBlurredBorder(shadowRadius: CGFloat = 15.0, inset: CGFloat = 10, corner: CGFloat = 10)

public func addSubViews(_ views: [UIView])

public func removeSubviews()

public func setAsShadow(bounds: CGRect, cornerRadius: CGFloat = 0.0, shadowRadius: CGFloat = 1)

public func getZeroHeightConstraint(attachToView: UIView) -> NSLayoutConstraint

public func addGestureRecognizers(_ recognizers: [UIGestureRecognizer], _ delegate: UIGestureRecognizerDelegate)

public func addBlurryEffect(_ style: UIBlurEffect.Style = .light)
```
### UIButton
```swift
public func setImage(_ image: UIImage?)

public func setTitle(_ text: String?)

public func setTitleImageSpacing(spacing: CGFloat, imgPadding: CGFloat = 0.0)
```
### UIColor
```swift
public func getColorTint() -> UIColor
```
### UIImage
```swift
public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1))

public func colored(_ color: UIColor?) -> UIImage?

public var aspectRatio: CGFloat

public func isContentEqualTo(_ anotherImage: UIImage) -> Bool

public func cropToWideRatio() -> UIImage?
```
### UIStackView
```swift
public convenience init(arrangedSubviews: [UIView]? = nil, axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, spacing: CGFloat)

public func removeAllSubviews()
```
### UIViewController
```swift
public var isViewVisible: Bool { get }

public var cellReuseIdentifier: String { get } 

public func hideKeyboardWhenTappedAround()

public func addKeyboardViewMoveListeners()

public func addNavigationBar(title: String, leftBarItem: UIBarButtonItem? = nil, rightBarItem: UIBarButtonItem? = nil, titleColor: UIColor = .white, backgroundColor: UIColor = .black) -> UINavigationBar

@objc public func backToPreviousVC()

public func presentInFullscreen(_ vc: UIViewController, _ animated: Bool = true)

public func runInAnimation(_ function: @escaping (()->()), completion: ((Bool) -> Void)? = nil)
```
