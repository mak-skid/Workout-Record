//
//  WorkoutViewController.swift
//  Workout Record
//
//  Created by Ono Makoto on 7/6/2022.
//

import UIKit

class WorkoutViewController: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let screenSize = UIScreen.main.bounds.size
        
        
        let currentType = UILabel()
        currentType.text = "Now: Bench Press"
        currentType.backgroundColor = .gray
        currentType.frame = CGRect(x: 10, y: screenSize.height*0.1, width: screenSize.width-20, height: screenSize.height*0.2)
        currentType.layer.cornerRadius = 10

        
        let nextType = UILabel()
        nextType.text = "Next: Seated Rowing"
        nextType.textColor = .white
        nextType.backgroundColor = .systemBackground
        nextType.frame = CGRect(x: 10, y: screenSize.height*0.3, width: screenSize.width-20, height: screenSize.height*0.1)
        nextType.layer.cornerRadius = 10
        
        let time = UILabel()
        time.text = "00:11"
        time.clipsToBounds = true
        time.textAlignment = .center
        time.frame = CGRect(x: 10, y: screenSize.height*0.4, width: screenSize.width-20, height: screenSize.height*0.3 - 10)
        
        UILabel.appearance(whenContainedInInstancesOf: [WorkoutViewController.self]).font = .systemFont(ofSize: 20, weight: .semibold)
        UILabel.appearance().layer.cornerRadius = 20
        UILabel.appearance().clipsToBounds = true
        
        
        let title = UILabel()
        title.text = "Rep count: "
        title.textColor = .white
        title.frame = CGRect(x: 0, y: screenSize.height*0.7, width: screenSize.width/2, height: screenSize.height*0.1)
        title.textAlignment = .center
        
        let textField = UITextField()
        textField.placeholder = "10"
        textField.keyboardType = .numberPad
        textField.clearButtonMode = .always
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.frame =  CGRect(x: screenSize.width/2, y: screenSize.height*0.7, width: screenSize.width/2, height: screenSize.height*0.1)
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)

        
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
                //button.frame.size = CGSize(width: screenSize.width / 6 - 5, height: 40)
                
                return button
            }()
            buttonStack.distribution = .fillEqually
            buttonStack.frame = CGRect(x: 0, y: screenSize.height*0.8, width: screenSize.width, height: screenSize.height*0.1)
            buttonStack.spacing = 10
            buttonStack.addArrangedSubview(oneBtn)
            
        }
        
        /*
        let stackView = UIStackView(arrangedSubviews: [currentType, nextType, time, repInput, buttonStack])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.frame = CGRect(x: 0, y: screenSize.height*0.1, width: screenSize.width, height: screenSize.height*0.8)
        stackView.backgroundColor = .systemBackground
        stackView.spacing = 10
        //stackView.translatesAutoresizingMaskIntoConstraints = false
        //stackView.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        */
        view.addSubview(currentType)
        view.addSubview(nextType)
        view.addSubview(time)
        view.addSubview(title)
        view.addSubview(textField)
        view.addSubview(buttonStack)
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
