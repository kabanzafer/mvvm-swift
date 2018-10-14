//
//  OMDBManager.swift
//  MVVMSimple
//
//  Created by Zafer Kaban on 10/12/18.
//  Copyright © 2018 Zafer Kaban. All rights reserved.
//

import Foundation

public struct MovieSearchResult {
    
    public var title : String
    public var type : String
    public var year : String
    public var imdbId : String
    public var poster : String
    
    init(title : String, type : String, year : String, imdbId : String, poster : String) {
        self.title = title
        self.year = year
        self.type = type
        self.imdbId = imdbId
        self.poster = poster
    }
}

class OMDBManager {
    
    private static let baseURL = "https://www.omdbapi.com/?apikey=a5a5180a&s="
    
    static let shared = OMDBManager()
    
    func searchForTitle(_ title : String ,completion : @escaping (_ result : [MovieSearchResult]?) -> Void) {
        let url = OMDBManager.baseURL + title
        let rest = RestApiManager(withURLString: url)
        rest.makeHTTPGetRequest { (result) in
            let searchResult = self.parseSearchResult(result)
            completion(searchResult)
        }
    }
    
    func parseSearchResult (_ result : Dictionary<String, Any>) -> [MovieSearchResult] {
        var searchResultArray = Array<MovieSearchResult>()
        if let search : Array = (result["Search"] as? Array<Dictionary<String,String>>) {
            for item in search {
                let title = item["Title"]!
                let type = item["Type"]!
                let year = item["Year"]!
                let imdbId = item["imdbID"]!
                let poster = item["Poster"]!
                let searchResult = MovieSearchResult(title: title, type: type, year: year, imdbId: imdbId, poster: poster)
                searchResultArray.append(searchResult)
            }
        }
        return searchResultArray
    }
    
}
