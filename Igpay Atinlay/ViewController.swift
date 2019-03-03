//
//  ViewController.swift
//  Igpay Atinlay
//
//  Created by Ryan David Forsyth on 2019-03-02.
//  Copyright © 2019 Ryan F. All rights reserved.
//

import UIKit
import SVProgressHUD
import ChameleonFramework

class ViewController: UIViewController {

    //MARK: - Variables, outlets
   
    @IBOutlet weak var scrollView: UIScrollView!
  
    @IBOutlet weak var copyButton: UIButton!
    
    
    @IBOutlet weak var englishTextField: UITextField!
    @IBOutlet weak var latinTextView: UITextView!
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    
    
    //MARK: - TouchView
    

    
    //MARK: - View did load, appear

    override func viewDidLoad() {
        super.viewDidLoad()
        
        englishTextField.delegate = self
        
        //UIUpdates()
        
    }
    

    
    //MARK: - Buttons
    
    @IBAction func copyPressed(_ sender: UIButton) {
        
        UIPasteboard.general.string = latinTextView.text
        SVProgressHUD.showSuccess(withStatus: "Copied to clipboard")
    }

    @IBAction func switchPressed(_ sender: Any) {
        
        let temp = inputLabel.text
        inputLabel.text = outputLabel.text
        outputLabel.text = temp
        englishTextField.text = ""
        latinTextView.text = ""
    }
    
    
    
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////

extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        latinTextView.text = PLGenerator(input: englishTextField.text!)
        return false
    }
    
    //MARK: - Listeners
    
    @objc func registerForKeyboardNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification: )), name: UIWindow.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification: )), name: UIWindow.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func deregisterFromKeyboardNotication() {
        
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardDidShowNotification, object: nil)
        
    }
    
    //MARK: - Keyboard notifications
    
    @objc func keyboardWasShown(notification : NSNotification) {
        print("KEYBOARD SHOWN!!!")
        
    }
    
    @objc func keyboardWillHide(notification : NSNotification) {
        
        
        
    }
   
    //MARK - Generator
    
    func PLGenerator(input : String) -> String {
        
        let vowels : [Character] = ["a" , "e" , "i" , "o" , "u" , "y"]
        let consonants : [Character] = ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "z"]
        
        let individualWordArray : [String] = input.lowercased().components(separatedBy: " ")
        
        if individualWordArray == [] {
            latinTextView.text = "Please enter some text above!"
        }
        
        var pigLatinWordArray : [String] = [String]()
        var pigLatinString = ""
        
        for word in individualWordArray {
            
            var pigLatinWordToAdd = word
            
            if let firstLetter : Character = word.first {
                
                if vowels.contains(firstLetter) {
                    
                    pigLatinWordToAdd = word + "way"
                    pigLatinWordArray.append(pigLatinWordToAdd)
                }
                if consonants.contains(firstLetter) {
                    
                    pigLatinWordToAdd.remove(at: pigLatinWordToAdd.startIndex)
                    pigLatinWordToAdd += String(firstLetter) + "ay"
                    pigLatinWordArray.append(pigLatinWordToAdd)
                }
            }
            
        }
        for pigLatinWord in pigLatinWordArray {
            
            pigLatinString += pigLatinWord + " "
        }
        return pigLatinString
    }
    
    //MARK: - UI Updates
    
    func UIUpdates() {
        //Corner radii
        
        
        //Shadows

  
    }
    
}



