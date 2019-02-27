# Loaf 🍞
Inspired by Android's [Toast](https://developer.android.com/reference/android/widget/Toast), **Loaf** is a Swifty Framework for Easy iOS Toasts 

[![Version](https://img.shields.io/cocoapods/v/Loaf.svg?style=flat)](https://cocoapods.org/pods/Loaf)
[![License](https://img.shields.io/cocoapods/l/Loaf.svg?style=flat)](https://github.com/schmidyy/Loaf/blob/master/LICENSE)
![Xcode 9.0+](https://img.shields.io/badge/Xcode-9.0%2B-blue.svg)
![iOS 11.0+](https://img.shields.io/badge/iOS-11.0%2B-blue.svg)
![Swift 4.0+](https://img.shields.io/badge/Swift-4.0%2B-orange.svg)
____


## Installation

### Cocoapods

Loaf is on Cocoapods! After [setting up Cocoapods in your project](https://guides.cocoapods.org/), simply add the folowing to your Podfile:
```
pod 'Loaf'
```
then run `pod install` from the directory containing the Podfile!

Don't forget to include `import Loaf` in every file you'd like to use Loaf

----

## Usage

From any view controller, a **_Loaf_** can be presented by calling:
```swift
Loaf("Message goes here", sender: self).show()
```
Which will result in:

<img width="400" alt="screen shot 2019-02-27 at 3 59 07 pm" src="https://user-images.githubusercontent.com/22358682/53522566-a2b1f880-3aa8-11e9-8451-f555811f85ed.png">

Bellow, I will discuss how to further customize your Loaf!

### Basic styles

**_Loaf_** comes with 4 basic style out of the box.

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

----

More documentation to come!
