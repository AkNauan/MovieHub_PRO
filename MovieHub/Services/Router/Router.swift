//
//  Router.swift
//  MovieHub
//
//  Created by a on 19.09.2020.
//  Copyright © 2020 a. All rights reserved.
//

import Foundation
import UIKit


protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
   func initialViewController()
   func showDetail(movie: ResultPart?)
   func popToRoot()
}

class Router: RouterProtocol {
   
    
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, builder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = builder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else {
                return
            }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetail(movie: ResultPart?) {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createDetailModule(movie: movie, router: self) else {
                return
            }
            navigationController.pushViewController(mainViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
}