//
//  MarvelAPI.swift
//  HeroisMarvel
//
//  Created by Lucas Santana Brito on 19/01/20.
//  Copyright © 2020 lsb.br. All rights reserved.
//

import Foundation
import SwiftHash
import Alamofire

class MarvelAPI {
    static private let basePath = "https://gateway.marvel.com/v1/public/characters?"
    static private let privateKey = "31af8fc82873fca360f16050411047ca78f4b8cc"
    static private let publicKey = "1a203994c3299e58e3138d0d157b479a"
    static private let limit = 50

    
    class func loadHeros(name: String?, page: Int = 0, onComplete: @escaping (MarvelInfo?) -> Void) {
        let offset = page * limit
        let startsWith: String
        
        if let name = name, !name.isEmpty {
            startsWith = "nameStartsWith=\(name.replacingOccurrences(of: " ", with: ""))&"
            
        } else {
            startsWith = ""
        }
        
        let url = basePath + "offset=\(offset)&limit=\(limit)&" + startsWith + getCredentials()
        
        AF.request(url).responseJSON { (response) in
            guard let data = response.data
                else {
                    onComplete(nil)
                    return
            }
            
            do {
                let marvelInfo = try JSONDecoder().decode(MarvelInfo.self, from: data)
                
                if marvelInfo.code == 200 {
                    onComplete(marvelInfo)
                } else {
                    onComplete(nil)
                }
                
            } catch {
                debugPrint(error)
                onComplete(nil)
            }
            
        }
        
    }
    
    private class func getCredentials() -> String {
        let ts = String(Int(Date().timeIntervalSince1970))
        let hash = MD5(ts+privateKey+publicKey).lowercased()
        return "ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }

}
