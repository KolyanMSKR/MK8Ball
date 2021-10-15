//
//  TabBarController.swift
//  MK8Ball
//
//  Created by Mykola Korotun on 15.10.2021.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTabBar()
    }

    private func setTabBar() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let filmsListVC = storyboard.instantiateInitialViewController() as? MainViewController,
              let settingsVC = storyboard.instantiateInitialViewController() as? SettingsViewController else {
            return
        }
        
        viewControllers = [filmsListVC, settingsVC]
    }

}
