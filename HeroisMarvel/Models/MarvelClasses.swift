//
//  MarvelClasses.swift
//  HeroisMarvel
//
//  Created by Lucas Santana Brito on 19/01/20.
//  Copyright © 2020 lsb.br. All rights reserved.
//

import Foundation

struct MarvelInfo: Codable {
    let code: Int
    let status: String
    let data: MarvelData
}

struct MarvelData: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [MarvelHero]
}

struct MarvelHero: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
    let urls: [HeroURL]
    
}

struct Thumbnail: Codable {
    let path: String
    let ext: String?
    
    var url: String {
        return path + "." + (ext ?? "jpg")
    }
    
    enum CodinKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}

struct HeroURL: Codable {
    let type: String
    let url: String
    
}
