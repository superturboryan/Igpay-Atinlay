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
            outputTextView.text = PLGenerator(input: inputTextField.text!)
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
   
    //MARK - Generator
    
    func PLGenerator(input : String) -> String {
        
        let vowels : [Character] = ["a" , "e" , "i" , "o" , "u" , "y"]
        let consonants : [Character] = ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "z"]
        
        let individualWordArray : [String] = input.lowercased().components(separatedBy: " ")
        
        if individualWordArray == [] {
            return "Please enter some text above!"
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
    
    func englishGenerator(input : String) -> String {
        
        var englishString = ""
        
        let pigLatinWordArray : [String] = input.lowercased().components(separatedBy: " ")
        
        
        
        
        
        
        
        
        
        return englishString
    }
    
    //MARK: - UI Updates
    
    func UIUpdates() {
        //Corner radii
        
        
        //Shadows

  
    }
    
}



