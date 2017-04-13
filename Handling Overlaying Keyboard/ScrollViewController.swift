//
//  ScrollViewController.swift
//  Handling Overlaying Keyboard
//
//  Created by Fitsyu on 11/04/2017.
//  Copyright © 2017 Fitsyu. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.TheKeyboardProblemEndsHere
        
        textField.delegate = self
    }
    
}

extension ScrollViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
