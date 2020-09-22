//
//  MainPresenter.swift
//  MovieHub
//
//  Created by a on 19.09.2020.
//  Copyright © 2020 a. All rights reserved.
//

import Foundation

protocol MainViewProtocol: class {
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getMovies()
    var movies: Movie? { get set }
    func tapOnTheMovie(movie: ResultPart?)
}

class MainPresenter: MainViewPresenterProtocol {
 
    var router: RouterProtocol?
    var movies: Movie?
    var networkService: NetworkServiceProtocol!
    weak var view: MainViewProtocol?
    
   
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getMovies()
    }
    
    func tapOnTheMovie(movie: ResultPart?) {
        router?.showDetail(movie: movie)
     }
         
    func getMovies() {
        networkService.downloadMovies { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.movies = movies
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }

    
    
}
