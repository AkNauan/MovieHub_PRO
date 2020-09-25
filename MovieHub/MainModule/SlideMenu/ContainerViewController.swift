//
//  ContainerViewController.swift
//  MovieHub
//
//  Created by a on 22.09.2020.
//  Copyright © 2020 a. All rights reserved.
//
//
//import UIKit
//
//class ContainerViewController: UIViewController {
//
//    var controller: UIViewController!
//    var menuController: UIViewController!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        configureMainViewController()
//    }
//    
//    func configureMainViewController() {
//        let mainVC = MainViewController()
//        controller = mainVC
//        view.addSubview(controller.view)
//        addChild(controller)
//    }
//    
//    func configureMenuViewController() {
//        if menuController == nil {
//            menuController = MenuViewController()
//            view.insertSubview(menuController.view, at: 0)
//            addChild(menuController)
//            
//        }
//    }
//
//}
