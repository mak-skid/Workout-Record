//
//  WorkoutViewController.swift
//  Workout Record
//
//  Created by Ono Makoto on 7/6/2022.
//

import UIKit


class WorkoutViewController: UIViewController, UITextFieldDelegate {
    var set_index: Int = 1
    var min: Int = 00
    var sec: Int = 00
    var typeState : String = ""
    var weightState : String? = nil
    var numState : Int? = nil
    
    let currentType: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.backgroundColor = .gray
        label.frame = CGRect(x: 10, y: screenSize.height*0.1, width: screenSize.width-20, height: screenSize.height*0.2)
        label.layer.cornerRadius = 10
        return label
    }()
    
    let exerciseIn: UITextField = {
        let textIn = UITextField()
        textIn.placeholder = "Input the current exercise"
        textIn.keyboardType = .default
        textIn.clearButtonMode = .always
        textIn.borderStyle = .roundedRect
        //textIn.delegate = self
        textIn.frame = CGRect(x: 10, y: screenSize.height*0.3, width: screenSize.width-20, height: screenSize.height*0.1)
        textIn.returnKeyType = .done
        textIn.addTarget(self, action: #selector(textInDidEndEditing(_:)), for: .editingChanged)
        return textIn
    }()
    
    let timeLabel: UILabel = {
        let time = UILabel()
        time.clipsToBounds = true
        time.textAlignment = .center
        time.frame = CGRect(x: 10, y: screenSize.height*0.4, width: screenSize.width-20, height: screenSize.height*0.3 - 10)
        return time
    }()
    
    func labelStyling () {
        UILabel.appearance(whenContainedInInstancesOf: [WorkoutViewController.self]).font = .systemFont(ofSize: 20, weight: .semibold)
        UILabel.appearance().layer.cornerRadius = 20
        UILabel.appearance().clipsToBounds = true
    }
    
    let repLabel: UILabel = {
        let rep = UILabel()
        rep.text = "Weight: \n Rep count: "
        rep.numberOfLines = 0
        rep.frame = CGRect(x: 0, y: screenSize.height*0.7, width: screenSize.width/3, height: screenSize.height*0.1)
        rep.textAlignment = .center
        return rep
    }()
    
    let weightInput: UITextField = {
        let weightIn = UITextField()
        weightIn.placeholder = "60kg"
        weightIn.keyboardType = .default
        weightIn.clearButtonMode = .always
        weightIn.borderStyle = .roundedRect
        //weightIn.delegate = self
        weightIn.frame =  CGRect(x: screenSize.width*(1/3), y: screenSize.height*0.7, width: screenSize.width/3, height: screenSize.height*0.05)
        weightIn.returnKeyType = .done
        weightIn.addTarget(self, action: #selector(weightInDidEndEditing(_:)), for: .editingChanged)
        return weightIn
    }()
    
    let numInput: UITextField = {
        let numIn = UITextField()
        numIn.placeholder = "10"
        numIn.keyboardType = .numberPad
        numIn.clearButtonMode = .always
        numIn.borderStyle = .roundedRect
        //numIn.delegate = self
        numIn.frame =  CGRect(x: screenSize.width*(1/3), y: screenSize.height*0.75, width: screenSize.width/3, height: screenSize.height*0.05)
        numIn.returnKeyType = .done
        numIn.addTarget(self, action: #selector(numInDidEndEditing(_:)), for: .editingChanged)
        return numIn
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundColor(color: .systemBlue, forState: .normal)
        button.setBackgroundColor(color: .blue, forState: .highlighted)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = screenSize.height*0.05
        button.frame = CGRect(x: screenSize.width*(2/3)+50, y: screenSize.height*0.7, width: screenSize.height*0.1, height: screenSize.height*0.1)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.tag = 6
        return button
    }()
    
    let buttonStackView: UIStackView = {
        let buttonStack = UIStackView()
        let buttonsArray: [String] = ["60s", "90s", "2m", "3m", "4m", "5m"]
        for (i, elm) in buttonsArray.enumerated() {
            let oneBtn: UIButton = {
                let button = UIButton(type: .custom)
                button.setTitle(elm, for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.tag = i
                button.setBackgroundColor(color: .systemOrange, forState: .normal)
                button.setBackgroundColor(color: .systemGray2, forState: .highlighted)
                button.layer.masksToBounds = true
                button.layer.cornerRadius = screenSize.height*0.04
                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                
                return button
            }()
            buttonStack.distribution = .fillEqually
            buttonStack.frame = CGRect(x: 0, y: screenSize.height*0.8, width: screenSize.width, height: screenSize.height*0.1)
            buttonStack.spacing = 10
            buttonStack.addArrangedSubview(oneBtn)
        }
        return buttonStack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelStyling()
        
        view.backgroundColor = .systemBackground
        
        currentType.text = "Current exercise: \(typeState) \nSet: \(set_index)"
        
        timeLabel.text = String(format: "%01d:%02d", min, sec)
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        [currentType, exerciseIn, timeLabel, repLabel, weightInput, numInput, saveButton, buttonStackView].forEach {
            view.addSubview($0)
        }
    }
    
    @objc internal func textInDidEndEditing(_ textField: UITextField) {
        typeState = exerciseIn.text!
        set_index = 1
        currentType.text = "Current exercise: \(typeState) \nSet: \(set_index)"
    }
    
    @objc internal func numInDidEndEditing(_ textField: UITextField) {
        numState = Int(numInput.text!) ?? nil
    }
    
    @objc internal func weightInDidEndEditing(_ textField: UITextField) {
        weightState = weightInput.text!
    }

    @objc internal func buttonAction(sender: UIButton!) {
        switch sender.tag {
            case 0:
                min = 1
                sec = 00
            case 1:
                min = 1
                sec = 30
            case 2:
                min = 2
                sec = 00
            case 3:
                min = 3
                sec = 00
            case 4:
                min = 4
                sec = 00
            case 5:
                min = 5
                sec = 00
            case 6:
                print(typeState)
                if typeState == "" || numState == nil || weightState == nil {
                    let alert: UIAlertController = UIAlertController(title: "No exercise name or rep count", message: "You have not typed in the name of the exercise and/or the rep count.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let db = Database()
                    db.add(typeState: typeState, weight_str: weightState!, set_i: set_index, numState: numState!)
                    set_index += 1
                    currentType.text = "Current exercise: \(typeState) \nSet: \(set_index)"
                }
            default:
                print("error")
        }

        if isAlreadyRunning == false {
            startTimer()
        } else {
            stopTimer = true
            startTimer()
        }
    }
    
    var isAlreadyRunning = false
    var stopTimer = false
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {timer in
            if self.stopTimer == true {
                timer.invalidate()
                self.stopTimer = false
            }
            if self.sec > 0 {
                self.sec = self.sec - 1
            }
            else if self.min > 0 && self.sec == 0 {
                self.min = self.min - 1
                self.sec = 59
            }
            else if self.min == 0 && self.sec == 0 {
                timer.invalidate()
                self.isAlreadyRunning = false
            }
            self.timeLabel.text = String(format: "%01d:%02d", self.min, self.sec)
        })
        self.isAlreadyRunning = true
    }
}

extension UIButton {

    func setBackgroundColor(color: UIColor, forState: UIControl.State) {

        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.setBackgroundImage(colorImage, for: forState)
    }
}
