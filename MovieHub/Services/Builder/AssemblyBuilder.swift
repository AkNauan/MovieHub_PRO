//
//  Builder.swift
//  MovieHub
//
//  Created by a on 19.09.2020.
//  Copyright © 2020 a. All rights reserved.
//

import Foundation
import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(movie: ResultPart?, router: RouterProtocol, delegate: DetailViewDelegate) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(movie: ResultPart?, router: RouterProtocol, delegate: DetailViewDelegate) -> UIViewController {
        let view = DetailViewController()
        view.delegate = delegate
        
        let presenter = DetailPresenter(view: view, movie: movie!, router: router)
        view.presenter = presenter
        return view
    }
    
    
}
