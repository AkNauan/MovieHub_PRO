//
//  MoovieModel.swift
//  MovieHub
//
//  Created by a on 19.09.2020.
//  Copyright © 2020 a. All rights reserved.
//

import Foundation
import UIKit

struct Movie: Decodable {
    var results: [ResultPart]
}

struct ResultPart: Decodable {
    
    var isFavouriteMovie: Bool = false
    let title: String?
    let vote_average: Double?
    let id: Int?
    let overview: String?
    let release_date: String?
    let poster_path: String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case vote_average
        case id
        case overview
        case release_date
        case poster_path
    }
    

}

struct Constants {
    static let leftDistanceToView: CGFloat = 40
    static let rightDistanceToView: CGFloat = 40
    static let galleryMinimumLineSpacing: CGFloat = 10
    static let galleryItemWidth = (UIScreen.main.bounds.width - Constants.leftDistanceToView - Constants.rightDistanceToView - (Constants.galleryMinimumLineSpacing / 2)) / 2
}

