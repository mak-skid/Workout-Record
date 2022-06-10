//
//  ViewController.swift
//  Workout Record
//
//  Created by Ono Makoto on 7/6/2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: RecordsViewController())
        let vc3 = UINavigationController(rootViewController: WorkoutViewController())
        let vc4 = UINavigationController(rootViewController: MenusViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle.portrait")
        vc3.tabBarItem.image = UIImage(systemName: "waveform.path.ecg")
        vc4.tabBarItem.image = UIImage(systemName: "menucard")
        
        
        vc1.title = "Home"
        vc2.title = "Records"
        vc3.title = "Workout"
        vc4.title = "Menu"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    
    }


}

