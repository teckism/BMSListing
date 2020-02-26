//
//  BMSBaseViewController.swift
//  BMSListing
//
//  Created by Pankaj Teckchandani on 26/02/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import UIKit

class BMSBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BMSBaseViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //Detect iPhone X or not
       func detectIsPhoneXOrAbove() -> Bool {
           var bFlag = false
           if UIDevice().userInterfaceIdiom == .phone {
               switch UIScreen.main.nativeBounds.height {
               case 1136:
                   bFlag = false
               //print("IPHONE 5,5S,5C")
               case 1334:
                   bFlag = false
               //print("IPHONE 6,7,8 IPHONE 6S,7S,8S ")
               case 1920, 2208:
                   bFlag = false
               //print("IPHONE 6PLUS, 6SPLUS, 7PLUS, 8PLUS")
               case 2436:
                   bFlag = true
               //print("IPHONE X, IPHONE XS")
               case 2688:
                   bFlag = true
               //print("IPHONE XS_MAX")
               case 1792:
                   bFlag = true
               //print("IPHONE XR")
               default:
                   bFlag = false
                   //print("UNDETERMINED")
               }
           }
           return bFlag
       }

}
