//
//  SentenceModel.swift
//  LanguageGame
//
//  Created by Ayman  on 08.04.18.
//  Copyright © 2018 Ayman . All rights reserved.
//

import Foundation
import Alamofire

final class SentenceModel : NSObject,ResponseObjectSerializable, ResponseCollectionSerializable {
    
    var textEng = ""
    var textSpa = ""
    
    required init?(response: HTTPURLResponse, representation: Any) {
        let responce = (representation as AnyObject)
        if let textEng = responce.value(forKey: "text_eng") as? String {
            self.textEng = textEng
        }
        if let textSpa = responce.value(forKey: "text_spa") as? String {
            self.textSpa = textSpa
        }
    }
    
    static func collection(from response: HTTPURLResponse, withRepresentation representation: Any) -> [SentenceModel] {
        
        if let resposne = representation as? NSArray {
            return resposne.map({SentenceModel(response: response , representation: $0)!})
        }
        else
        {
            return []
        }
    }
}
