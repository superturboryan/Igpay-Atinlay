//
//  ViewController.swift
//  Igpay Atinlay
//
//  Created by Ryan David Forsyth on 2019-03-02.
//  Copyright © 2019 Ryan F. All rights reserved.
//

import UIKit
import Foundation
import SVProgressHUD
import ChameleonFramework

class ViewController: UIViewController {

    //MARK: - Variables, outlets
    
    private var englishToPL = true
   
    @IBOutlet weak var scrollView: UIScrollView!
  
    @IBOutlet weak var copyButton: UIButton!
    
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputTextView: UITextView!
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    
    
    //MARK: - TouchView
    

    
    //MARK: - View did load, appear

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextField.delegate = self
        
        //UIUpdates()
        
        englishGenerator(input: "erehay isway omesay ealray igpay atinlay")
    }
    

    
    //MARK: - Buttons
    
    @IBAction func copyPressed(_ sender: UIButton) {
        
        UIPasteboard.general.string = outputTextView.text
        SVProgressHUD.showSuccess(withStatus: "Copied to clipboard")
    }

    @IBAction func switchPressed(_ sender: Any) {
        
        //Change translation direction
        englishToPL = !englishToPL
        
        //Switch labels
        let temp = inputLabel.text
        inputLabel.text = outputLabel.text
        outputLabel.text = temp
        
        //Clear input and output fields
        inputTextField.text = ""
        outputTextView.text = ""
    }
    
    //When return is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        if inputTextField.text == ""{
            reportError(title: "Input Empty", message: "Please enter some text in the input field")
        }
        else{
            if englishToPL {
                outputTextView.text = PLGenerator(input: inputTextField.text!)
            }
            else {
                outputTextView.text = englishGenerator(input: inputTextField.text!)
            }
        }
        return false
    }
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////

extension ViewController : UITextFieldDelegate {
    
    //MARK: - Error alert popup
    
    func reportError(title : String, message : String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
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
   
    //MARK: - Generators
    
    func PLGenerator(input : String) -> String {
        
        var pigLatinString = ""
        
        let vowels : [Character] = ["a" , "e" , "i" , "o" , "u" , "y"]
        let consonants : [Character] = ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "z"]
        
        let individualWordArray : [String] = input.lowercased().components(separatedBy: " ")
        
        var pigLatinWordArray : [String] = [String]()
        
        
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
        //String concatenation
        for pigLatinWord in pigLatinWordArray {
    
            pigLatinString += pigLatinWord + " "
        }
        
        return pigLatinString
    }
    
    func englishGenerator(input : String) -> String {
        
        var englishString = ""
        
        let pigLatinWordArray : [String] = input.lowercased().components(separatedBy: " ")
        
        var englishWordArray : [String] = [String]()
        
        for word in pigLatinWordArray {
            
            var englishWordToAdd = word
            
            var charArray = Array(englishWordToAdd)
            
            if charArray.count > 2 {
                charArray.remove(at: charArray.count-1)
                charArray.remove(at: charArray.count-1)
            }
            
            if charArray[charArray.count-1] == "w" {
                charArray.remove(at: charArray.count-1)
            }
            else{
                let charToInsert = charArray[charArray.count-1]
                charArray.remove(at: charArray.count-1)
                charArray.insert(charToInsert, at: 0)
            }
            
            englishWordToAdd = String(charArray)
            englishWordArray.append(englishWordToAdd)
        }
        
        for englishWord in englishWordArray {
            englishString += englishWord + " "
        }
        
        return englishString
    }
    
    //MARK: - UI Updates
    
    func UIUpdates() {
        //Corner radii
        
        
        //Shadows
  
    }
    
}

extension String {
    subscript(value: NSRange) -> Substring {
        return self[value.lowerBound..<value.upperBound]
    }
}

extension String {
    subscript(value: CountableClosedRange<Int>) -> Substring {
        get {
            return self[index(at: value.lowerBound)...index(at: value.upperBound)]
        }
    }
    
    subscript(value: CountableRange<Int>) -> Substring {
        get {
            return self[index(at: value.lowerBound)..<index(at: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeUpTo<Int>) -> Substring {
        get {
            return self[..<index(at: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeThrough<Int>) -> Substring {
        get {
            return self[...index(at: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeFrom<Int>) -> Substring {
        get {
            return self[index(at: value.lowerBound)...]
        }
    }
    
    func index(at offset: Int) -> String.Index {
        return index(startIndex, offsetBy: offset)
    }
}

