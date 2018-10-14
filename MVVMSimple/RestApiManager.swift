//
//  RestApiManager.swift
//  MVVMSimple
//
//  Created by Zafer Kaban on 10/12/18.
//  Copyright © 2018 Zafer Kaban. All rights reserved.
//

import Foundation

class RestApiManager: NSObject {
    
    var urlString : String?
    
    init(withURLString url : String) {
        super.init()
        self.urlString = url
    }
    
    func makeHTTPGetRequest(completion : @escaping (_ result : Dictionary<String, Any>) -> Void) {
        guard let escapedURL = urlString!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else  {
            return
        }
        let request = URLRequest(url: URL(string: escapedURL)!)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    if let jsonDictionary = jsonObject as? Dictionary<String, Any> {                        
                        completion(jsonDictionary)
                    }
                } catch {
                    print("Error parsong json data")
                }
            }
        }
        task.resume()
    }
}
