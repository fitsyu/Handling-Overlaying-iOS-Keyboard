//
//  Extension.swift
//  Handling Overlaying Keyboard
//
//  Created by Fitsyu on 11/04/2017.
//  Copyright © 2017 Fitsyu. All rights reserved.
//

import UIKit

fileprivate func keyboardHeight(from notification: Notification) -> CGFloat {
    let info = notification.userInfo as NSDictionary?
    let rectValue = info![UIKeyboardFrameBeginUserInfoKey] as! NSValue
    let kbHeight  = rectValue.cgRectValue.size.height
    
    return kbHeight
}

fileprivate enum Direction {
    case up, down
}


extension UIScrollView {
    
    func makeAwareOfKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyBoardDidShow(notification: Notification) {
        
        let kbHeight = keyboardHeight(from: notification)
        
        let contentInsets = UIEdgeInsetsMake(0, 0, kbHeight, 0)
        self.contentInset = contentInsets
        self.scrollIndicatorInsets = contentInsets
    }
    
    func keyBoardWillHide(notification: Notification) {
        
        // restore content inset to 0
        let contentInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        self.contentInset = contentInsets
        
        self.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    // the intuitive shortcut
    var TheKeyboardProblemEndsHere: Void  {
        return makeAwareOfKeyboard()
    }
}

extension UIViewController {

    fileprivate func moveView(_ direction: Direction, offset: CGFloat ) {
        
        let movement: CGFloat =  direction == .up ? -offset : offset
        
        UIView.beginAnimations("animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration( 0.3 )
        
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }

    func makeAwareOfKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    
    func keyBoardDidShow(notification: Notification) {
        
        // materials
        let kbHeight = keyboardHeight(from: notification)
        let textField = activeTextField()
        
        let H = self.view.frame.height
        let y = textField!.frame.origin.y
        let h = textField!.frame.height
        
        let reversedPosition = ( H-(y+h) )
        
        // decision factors
        let covered   = reversedPosition < kbHeight
        let notLifted = self.view.frame.origin.y == 0
        
        
        // judge & execute
        if covered && notLifted {
            let offset = abs( reversedPosition - kbHeight )
            moveView(.up, offset: offset)
        }
        
        //print("up")
    }
    
    func keyBoardWillHide(notification: Notification) {
        
        // only move back down if it was lifted up
        let lifted = self.view.frame.origin.y < 0
        
        if lifted {
            let offset = abs(self.view.frame.origin.y)
            moveView(.down, offset: offset)
        }
        
        //print("down")
    }
    
    func activeTextField() -> UITextField? { return nil }
    
    // the intuitive shortcut
    var TheKeyboardProblemEndsHere: Void  {
        return makeAwareOfKeyboard()
    }
}


//@objc protocol KeyboardAware {
//    func makeAwareOfKeyboard()
//    @objc optional func keyBoardDidShow(notification: Notification)
//    @objc optional func keyBoardWillHide(notification: Notification)
//}
//
//extension KeyboardAware {
//    func makeAwareOfKeyboard() {
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//    }
//}


/** 
 *
    Note: 
 
    There are duplications in the code and I wanted to get rid of them by
    creating KeyboardAware protocol. But as discussed in this SO post
 
    http://stackoverflow.com/questions/39487168/non-objc-method-does-not-satisfy-optional-requirement-of-objc-protocol
 
    I'll leave them be for now.
 
 
    TODO:
    turn this into pod
 */
