//
//  Photo.swift
//  View Updates
//
//  Created by Boris Yurkevich on 04/11/2020.
//

import Foundation

struct Photo: Decodable, Identifiable {
    
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: URL
    let download_url: URL
}
