//
//  ViewController.swift
//  Handling Overlaying Keyboard
//
//  Created by Fitsyu on 10/04/2017.
//  Copyright © 2017 Fitsyu. All rights reserved.
//

import UIKit

class OrdinaryViewController: UIViewController {

    var _activeTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        TheKeyboardProblemEndsHere
        
    }
    
}

extension OrdinaryViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        _activeTextField = textField
    }
    
    override func activeTextField() -> UITextField? {
        return _activeTextField
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

