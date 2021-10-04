//
//  BoardViewController.swift
//  LEDBoard
//
//  Created by Woochan Park on 2021/10/04.
//

import UIKit

class BoardViewController: UIViewController {

  // MARK: - IBOutlet
  
  @IBOutlet weak var boardView: UIView! {
    didSet {
      applyRoundDesign(to: boardView)
    }
  }
  @IBOutlet weak var inputTextField: UITextField!
  
  @IBOutlet weak var sendButton: UIButton! {
    didSet {
      applyRoundDesign(to: sendButton)
    }
  }
  
  @IBOutlet weak var randomTextColorButton: UIButton! {
    didSet {
      applyRoundDesign(to: randomTextColorButton)
    }
  }
  
  @IBOutlet weak var resultLabel: UILabel!
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    inputTextField.delegate = self
//    resultLabel.numberOfLines
    
  }
  
  // MARK: - Custom
  
  private func applyRoundDesign(to view: UIView) {
    view.layer.cornerRadius = view.frame.height/4
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
  }
  
  // MARK: - IBAction
  
  @IBAction func didTapSendButton(_ sender: UIButton) {
    guard let text = inputTextField.text else {
      fatalError()
    }
    
    resultLabel.text = text
    inputTextField.resignFirstResponder()
  }
  
  @IBAction func didTapColorButton(_ sender: Any) {
    
    let redValue : CGFloat = CGFloat((1...256).randomElement()!) / CGFloat(256)
    let greenValue : CGFloat = CGFloat((1...256).randomElement()!) / CGFloat(256)
    let blueVlaue: CGFloat = CGFloat((1...256).randomElement()!) / CGFloat(256)
    
    let randomColor = UIColor(red: redValue, green: greenValue, blue: blueVlaue, alpha: 1)
    
    
    resultLabel.textColor = randomColor
  }
  
  @IBAction func didTapReturnKey(_ sender: UITextField) {
    
    resultLabel.text = sender.text
  }
  
  @IBAction func didTap(_ sender: UIView) {
    
    inputTextField.resignFirstResponder()
    
    boardView.isHidden.toggle()
  }
}

extension BoardViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    resultLabel.text = textField.text
    
    textField.resignFirstResponder()
    return true
  }
}
