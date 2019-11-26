<H1 align="center">
Loaf 🍞
</H1>
<H4 align="center">
Inspired by Android's Toast,</br>
Loaf is a Swifty Framework for Easy iOS Toasts</br>
</H4>

<p align="center">
<a href="https://cocoapods.org/pods/Loaf"><img alt="Version" src="https://img.shields.io/cocoapods/v/Loaf.svg?style=flat"></a> 
<a href="https://github.com/schmidyy/Loaf/blob/master/LICENSE"><img alt="Liscence" src="https://img.shields.io/cocoapods/l/Loaf.svg?style=flat"></a> 
<a href="https://developer.apple.com/"><img alt="Platform" src="https://img.shields.io/badge/platform-iOS-green.svg"/></a> 
<a href="https://developer.apple.com/swift"><img alt="Swift4.2" src="https://img.shields.io/badge/language-Swift4.2-orange.svg"/></a>
<a href="http://clayallsopp.github.io/readme-score?url=https://github.com/schmidyy/loaf"><img alt="Readme Score" src="http://readme-score-api.herokuapp.com/score.svg?url=https://github.com/schmidyy/loaf"></a>
</p>

____

## Usage

From any view controller, a Loaf can be presented by calling:
```swift
Loaf("Message goes here", sender: self).show()
```
Which will result in:

<img width="400" alt="screen shot 2019-02-27 at 3 59 07 pm" src="https://user-images.githubusercontent.com/22358682/53522566-a2b1f880-3aa8-11e9-8451-f555811f85ed.png">

Bellow, I will discuss how to further customize your Loaf!

## Playground

I've provided an example project to showcase uses of Loaf! Simply clone this repo, and open `LoafExamples.xcodeproj`. From here you can see and experiment custom Loaf styles in `Examples.swift`

## Customization

### Basic styles

Loaf comes with 4 basic style out of the box.

| Success | Error |
| ------- | ----- |
| <img width="525" alt="screen shot 2019-02-27 at 3 45 44 pm" src="https://user-images.githubusercontent.com/22358682/53521918-4f8b7600-3aa7-11e9-934d-866e04189e99.png"> | <img width="525" alt="screen shot 2019-02-27 at 3 45 52 pm" src="https://user-images.githubusercontent.com/22358682/53521932-59ad7480-3aa7-11e9-8ba5-f6adef7002e2.png"> |

| Warning | Info |
| ------- | ---- |
| <img width="525" alt="screen shot 2019-02-27 at 3 45 58 pm" src="https://user-images.githubusercontent.com/22358682/53521946-629e4600-3aa7-11e9-8a1e-542048d05afc.png"> | <img width="525" alt="screen shot 2019-02-27 at 3 53 26 pm" src="https://user-images.githubusercontent.com/22358682/53522180-db050700-3aa7-11e9-8363-b28f1c21b186.png"> |

These styles can be specified in the `style` property.
For instance, to use `Success` styled Loaf, call it like so:
```swift
Loaf("This is a success loaf", state: .success, sender: self).show()
```

### Custom styles

Loaf allows you to specify a custom style! This will let you set the colors, font, icon. and icon alignment. Here are some examples of custom Loaf styles!

| Colors and icon | Right icon alignment | No icon |
| ---- | ---- | ---- |
| <img width="517" alt="screen shot 2019-02-27 at 6 09 33 pm" src="https://user-images.githubusercontent.com/22358682/53529532-e3b30880-3aba-11e9-9d07-4a4ffd0acee8.png"> | <img width="517" alt="screen shot 2019-02-27 at 6 13 13 pm" src="https://user-images.githubusercontent.com/22358682/53529721-73f14d80-3abb-11e9-830e-1e007fcca84a.png"> | <img width="517" alt="screen shot 2019-02-27 at 6 13 22 pm" src="https://user-images.githubusercontent.com/22358682/53529730-7bb0f200-3abb-11e9-98aa-5aa705266260.png"> |

All of these properties are specified as part of custom state, like so:
```swift
Loaf("Switched to light mode", state: .custom(.init(backgroundColor: .black, icon: UIImage(named: "moon"))), sender: self).show()
```

### Presenting and dismissing

Loaf allows you to specify the presenting and dismissing direction. The presenting direction is independant from the dismissal direction. Here are some examples:

| Vertical | Left |
| ---- | ---- |
| ![vertical](https://user-images.githubusercontent.com/22358682/53534239-f71a9f80-3acb-11e9-8010-c7915012a187.gif) | ![left](https://user-images.githubusercontent.com/22358682/53534240-f7b33600-3acb-11e9-8b10-b6d2cb3199a2.gif) |

| Right | Mix |
| ---- | ---- |
| ![right](https://user-images.githubusercontent.com/22358682/53534241-f7b33600-3acb-11e9-8e55-457c5a2f32d2.gif) | ![mix](https://user-images.githubusercontent.com/22358682/53534242-f7b33600-3acb-11e9-9e74-88653d469746.gif) |

These are specified in the function signature, like so:
```swift
Loaf("Loaf message", presentingDirection: .left, dismissingDirection: .vertical, sender: self).show()
```

### Location

Toasts are typically presented at the bottom of the screen, but Loaf allows you to also present them at the top of the screen. Here is an example of a Loaf being presented at the top of the view:

<img width="400" alt="screen shot 2019-02-27 at 8 30 04 pm" src="https://user-images.githubusercontent.com/22358682/53534861-92147900-3ace-11e9-8668-361ec311698a.png">

This is also specified in the function signature, like so:
```swift
Loaf("Loaf message", location: .top, sender: self).show()
```

### Other

Specify the presentation duration. When presenting a Loaf with `.show()`, a presentation duration can be specified. The default value is 4s, but there are presets for 2s and 8s. This is done by using `.show(.short)` for 2s, or `.show(.long)` for 8s. A custom duration can also be specified with `.show(.custom(x))`, where x represents the duration in seconds.

**⚠️ New in `0.5.0`:**

- A completion handler can be specified in the Loaf `show()` function signature. This block will be called when the dismissal animation is completed, or when the Loaf is tapped. This completion handler is now passed with a enum representing whether the Loaf was tapped or timmed out. Here is an example of using a completion handler:

```swift
Loaf(example.rawValue, sender: self).show { dismissalType in
     switch dismissalType {
          case .tapped: print("Tapped!")
          case .timedOut: print("Timmed out!")
     }
}
```

- A Loaf's width can be specified via the `Style` component. The width can be specifed as a fixed size (i.e. 280px) or as a percentage of the screen's width. (i.e. `0.8` -> 80%). Here is some example usage:

```Swift
Loaf(example.rawValue, state: .custom(.init(backgroundColor: .black, width: .screenPercentage(0.8))), sender: self).show()
```

- Loaf's will now be presented above tab bars, when possible.
- Loaf's can be manually dismissed through a global method: 

```swift
Loaf.dismiss(sender: self) // Where `self` is the Loaf's presenter
```

____

## Installation

### Cocoapods

Loaf is on Cocoapods! After [setting up Cocoapods in your project](https://guides.cocoapods.org/), simply add the folowing to your Podfile:
```
pod 'Loaf'
```
then run `pod install` from the directory containing the Podfile!

Don't forget to include `import Loaf` in every file you'd like to use Loaf

### Requirements

- Swift 4.2+
- iOS 9.0+

### Contributing

Pull requests, feature requests and bug reports are welcome 🚀

____

Thanks to [@kirkbyo](https://github.com/kirkbyo) for helping me through the tough parts of this 💪

<p align="center">
Made with ❤️ in 🇨🇦 by <a href="https://twitter.com/devschmidy">Mat Schmid</a>
</p>
