//
//  APIManager.swift
//  LanguageGame
//
//  Created by Ayman  on 08.04.18.
//  Copyright © 2018 Ayman . All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    //MARK: URLS
    struct URLS {
        static let baseURL = "https://gist.githubusercontent.com/DroidCoder/7ac6cdb4bf5e032f4c737aaafe659b33/raw/baa9fe0d586082d85db71f346e2b039c580c5804/words.json"
        static let sentencesURL = baseURL
    }
    
    //MARK: API Requests
    class func getsentencesList(completionHandler: @escaping (DataResponse<[SentenceModel]>)-> Void)  {
        
        let url = URLS.sentencesURL
        _ = request(url, method: .get).responseCollection{ (response: DataResponse<[SentenceModel]>) in
            
            completionHandler(response)
        }
    }
}
