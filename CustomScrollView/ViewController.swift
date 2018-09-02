//
//  ViewController.swift
//  CustomScrollView
//
//  Created by SaTHEEsH KaNNaN on 05/05/17.
//  Copyright © 2017 Innoppl Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var sampleScrollView : SKScrollView!
    @IBOutlet var sampleTextField : UITextField!
    
    @IBOutlet var addButton : UIButton!
    @IBOutlet var deleteButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        sampleTextField.placeholder = "Please enter index to perform"
        sampleTextField.text = ""
        sampleTextField.delegate = self
        
    }
    
    
    @IBAction func buttonTarget(_ button : UIButton) -> Void {
        
        let index = (sampleTextField.text?.isEmpty)! ? -1 : Int(sampleTextField.text!)!
        
        if button == addButton {
        
            let colors : [UIColor] = [.red, .blue, .orange, .green, .magenta, .brown, .black]
            let colorIndex = Int(arc4random_uniform(UInt32(colors.count)))

            let heights : [CGFloat] = [100, 140, 439, 129, 332, 192, 43, 83]
            let heightIndex = Int(arc4random_uniform(UInt32(heights.count)))
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: self.sampleScrollView.frame.size.width, height: heights[heightIndex]))
            view.backgroundColor = colors[colorIndex]
            
            if index != -1 {
                view.backgroundColor = .cyan
            }
            
            index == -1 ? sampleScrollView.insertNewSubView(view) : sampleScrollView.insertNewSubView(view, atIndex: index, scrollToView: true)            
        }
        
        if button == deleteButton {
            sampleScrollView.deleteSubView(atIndex: index)
        }
        
        sampleTextField.text = ""
        
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.inputAccessoryView = self.addKeyboardDoneButton()
        return true
    }
    
    func addKeyboardResignTapGesture() -> Void {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func addKeyboardDoneButton() -> UIToolbar {
        
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        
        return keyboardToolbar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

