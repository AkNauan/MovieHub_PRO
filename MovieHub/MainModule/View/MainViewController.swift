//
//  MainViewController2.swift
//  MovieHub
//
//  Created by a on 22.09.2020.
//  Copyright © 2020 a. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    
    var presenter: MainViewPresenterProtocol!
    var cells: Movie?
    
    let menuBatton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "more"), for: .normal)
        return button
    }()
    
    let basketButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "basket"), for: .normal)
        return button
    }()
    
    let posterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .light)
        label.text = "Film Poster"
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.text = "MovieHub"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        return label
    }()
    
    let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .horizontal
       layout.minimumLineSpacing = Constants.galleryMinimumLineSpacing
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
       cv.translatesAutoresizingMaskIntoConstraints = false
       cv.showsHorizontalScrollIndicator = false
       cv.showsVerticalScrollIndicator = false
       cv.backgroundColor = .white
       cv.contentInset = UIEdgeInsets(top: 0, left: Constants.leftDistanceToView, bottom: 0, right: Constants.rightDistanceToView)
       cv.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseId)

       return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
     
        self.view.backgroundColor = UIColor.white
        setUpContraints()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }


    
    func setUpContraints() {
        
        view.addSubview(basketButton)
        view.addSubview(menuBatton)
        view.addSubview(nameLabel)
        view.addSubview(posterLabel)
        view.addSubview(collectionView)
        
        // SetUp Buttons
        
        menuBatton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        menuBatton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        menuBatton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        menuBatton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true

        basketButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        basketButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        basketButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        basketButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        
        
        //SetUp Labels
        
        nameLabel.topAnchor.constraint(equalTo: menuBatton.bottomAnchor, constant: 15).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        
        posterLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        posterLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        posterLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        
        
        //SetUP CollectionView
        
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: posterLabel.bottomAnchor, constant: 10).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 350).isActive = true

    }
    
}

extension MainViewController: MainViewProtocol {
    func success() {
        self.cells = presenter.movies
        collectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = presenter.movies?.results[indexPath.item]
        presenter.tapOnTheMovie(movie: movie)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.galleryItemWidth, height: collectionView.frame.height * 0.9)
    }

}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.movies?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseId, for: indexPath) as! MovieCollectionViewCell
        
        cell.nameLabel.text = cells?.results[indexPath.item].title
        cell.smallDescriptionLabel.text = cells?.results[indexPath.item].overview
        cell.voteAverageLabel.text = String(cells?.results[indexPath.item].vote_average ?? 0.0)
        
        if let imageInfo = cells?.results[indexPath.item].poster_path {
            let url = "https://image.tmdb.org/t/p/w500/" + imageInfo
            if let unwrappedUrl = URL(string: url) {
                cell.mainImageView.downloaded(from: unwrappedUrl)
            }
        }
        
        return cell
    }
}








