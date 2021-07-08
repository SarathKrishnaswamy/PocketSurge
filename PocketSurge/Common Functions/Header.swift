//
//  Header.swift
//  PocketSurge
//
//  Created by J.Sarath Krishnaswamy on 07/07/21.
//

import Foundation
import Foundation
import UIKit
import AVFoundation

let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
let SCENEDELEGATE = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
let COMMONFUNCTION = CommonFunctions.shared


var NETWORK_CONNECTION_STATUS = false

enum UIUserInterfaceIdiom : Int {
    case unspecified
    case phone
    case pad
}

let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad

let IS_IPHONE_5_OR_LESS = UIScreen.main.bounds.size.height <= 568
let IS_IPHONE_X = UIScreen.main.nativeBounds.size.height == 2436
let IS_IPHONE_XS_MAX = UIScreen.main.nativeBounds.size.height == 2688
let IS_IPHONE_XR = UIScreen.main.nativeBounds.size.height == 1792
let IS_IPHONE_NOTCH = IS_IPHONE_XS_MAX || IS_IPHONE_XR || IS_IPHONE_X ? true : false
let IS_IPHONE_6 = UIScreen.main.bounds.size.height == 667
let IS_IPHONE_6PLUS = UIScreen.main.bounds.size.height == 736
let DEVICE_ID = UIDevice.current.identifierForVendor?.uuidString
let IOS_VERSION = UIDevice.current.systemVersion

let VALID_EMAIL_ALERT = "Please enter valid email address"
let VALID_PWD_ALERT = "Please enter valid password"
let VALID_USERNAME_ALERT = "Please enter valid username"
let VALID_PWD_EMAIL = "Please check your credentials"
let VALID_TITLE = "Please enter your title"
let VALID_CATEGORY = "Please enter your category"
let VALID_AMOUNT = "Please enter your amount"
let VALID_TITLE_CAT = "Please check all your fields"

//MARK:- Generic Font
let TITLE_SMALL     :  CGFloat = IS_IPAD ? 15.0 : 12.0
let TITLE_MEDIUM    :  CGFloat = IS_IPAD ? 17.0 : 14.0
let TITLE_LARGE     :  CGFloat = IS_IPAD ? 19.0 : 16.0
let TITLE_EXTRALARGE:  CGFloat = IS_IPAD ? 21.0 : 18.0

let TEXT_SMALL      :  CGFloat = IS_IPAD ? 19.0 : 16.0
let TEXT_MEDIUM     :  CGFloat = IS_IPAD ? 21.0 : 18.0
let TEXT_LARGE      :  CGFloat = IS_IPAD ? 23.0 : 20.0
let TEXT_EXTRALARGE :  CGFloat = IS_IPAD ? 25.0 : 22.0

let Title_header = UIFont.preferredFont(forTextStyle: .headline)
let body = UIFont.preferredFont(forTextStyle: .body)
let sub_headline = UIFont.preferredFont(forTextStyle: .subheadline)
let title_1 = UIFont.preferredFont(forTextStyle: .title1)

//MARK:- Custom Font
let NAVIGATIONBAR_FONT:CGFloat = IS_IPAD ? 22 : 18.0
let BARBUTTON_TEXT_FONT: CGFloat = IS_IPAD ? 20.0 : 15.0
let PROFILE_NAME_FONT :  CGFloat = IS_IPAD ? 45.0 : 40.0
let PROFILE_LIKES_FONT :  CGFloat = IS_IPAD ? 15.0 : 10.0

//MARK:- Alert Message
let NO_NETWORK_ALERT = "Please check your network connection"
let LOGOUT_ALERT = "Are you sure, Do you want to logout?"

extension UIViewController {

  func presentAlert(withTitle title: String, message : String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default) { action in
        print("You've pressed OK Button")
        
    }
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}

extension String{
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

extension UIFont{
    class func getRegularFontWith(size:CGFloat)->UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
    class func getMediumFontWith(size:CGFloat)->UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }
    class func getBoldFontWith(size:CGFloat)->UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
    class func getLightFontWith(size:CGFloat)->UIFont {
        return UIFont.systemFont(ofSize: size, weight: .light)
    }
}
