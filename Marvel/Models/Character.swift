//
//  Hero.swift
//  Marvel
//
//  Created by Nazildo Souza on 30/04/20.
//  Copyright © 2020 Nazildo Souza. All rights reserved.
//

import SwiftUI

struct Character: Codable {
    let code: Int
    let status: String
    let data : Data

    struct Data: Codable {
        let count: Int
        let total: Int
        let results: [Results]
    }
        
    struct Results: Codable {
        let id: Int
        let name: String
        let description: String?
        let thumbnail: Thumbnail
        let urls: [URLs]
    }

    struct Thumbnail: Codable {
        let path: String
        let `extension`: String
        
        var image: String {
            return "\(path)/portrait_xlarge.\(`extension`)"
        }
    }

    struct URLs: Codable {
        var type: String
        let url: String
    }

}

