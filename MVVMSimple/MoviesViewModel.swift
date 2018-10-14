//
//  MoviesViewModel.swift
//  MVVMSimple
//
//  Created by Zafer Kaban on 10/11/18.
//  Copyright © 2018 Zafer Kaban. All rights reserved.
//

import Foundation

class MoviesViewModel {
    
    private var array : Array<MovieSearchResult>?
    public var delegate : MoviesViewProtocol?
    
    public func elementAtIndex (_ indexPath : IndexPath) -> MovieSearchResult {
        return array![indexPath.row]
    }
    
    public func elementCount () -> Int {
        return array == nil ? 0 : array!.count
    }
    
    func searchMovies(_ str : String) {
        OMDBManager.shared.searchForTitle(str) { (result) in
            var array = Array<MovieSearchResult>()
            for movie : MovieSearchResult in result! {
                array.append(movie)
            }
            self.array = array
            self.delegate?.searchResultRetrieved()
        }
    }
}
