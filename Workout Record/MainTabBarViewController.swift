//
//  ViewController.swift
//  Workout Record
//
//  Created by Ono Makoto on 7/6/2022.
//

import UIKit

class tabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        //let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc1 = UINavigationController(rootViewController: RecordsViewController())
        let vc2 = UINavigationController(rootViewController: WorkoutViewController())
        //let vc4 = UINavigationController(rootViewController: MenusViewController())
        
        //vc1.tabBarItem.image = UIImage(systemName: "house")
        vc1.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle.portrait")
        vc2.tabBarItem.image = UIImage(systemName: "waveform.path.ecg")
        //vc4.tabBarItem.image = UIImage(systemName: "menucard")
        
        
        vc1.title = "Records"
        vc2.title = "Workout"
        //vc3.title = "Workout"
        //vc4.title = "Menu"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2], animated: true)
    
    }
}

