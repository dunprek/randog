//
//  DogAPI.swift
//  randog
//
//  Created by Gideon Steven Tobing on 29/03/19.
//  Copyright © 2019 Gideon. All rights reserved.
//

import Foundation
import UIKit

class DogAPI{
    enum Endpoint {
        case randomImageFromAllDogsCollection
        case randomImageForBreed (String)
        case listAllBreeds
        
        var url: URL{
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
                
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
                
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
    }
    
    
    class func
        requestBreedsList(completionHandler: @escaping ([String],Error?) -> Void) {
        let task =
            URLSession.shared.dataTask(with: Endpoint.listAllBreeds.url){
            (data, response, error) in
            
                guard let data = data else{
                    completionHandler([],error)
                    return
                }
                
                let decoder = JSONDecoder()
                let breedsResponse = try! decoder.decode(BreedsListResponse.self, from: data)
                let breeds = breedsResponse.message.keys.map({$0})
                completionHandler(breeds, nil)
                
        } 
        task.resume()
    }
    
    class func requestRandomImage (breed: String, completionHandler: @escaping (DogImage?,Error?) -> Void){
        
        // use this to add the endpoint or what we call url
        let randomImageEndpoint = DogAPI.Endpoint.randomImageForBreed(breed).url
        
        // request task background task in swift
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
            guard let data = data else{
                completionHandler(nil,error)
                return
            }
            
            // log what inside the data
            print(data)
            
            //object JSONDecoder used for decoding the json and map it to our object model
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            print(imageData)
            
            completionHandler(imageData,nil)
            
        }
        
            task.resume()
    }
    
    
    //callled from viewcontroller
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void)
    {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else {
                completionHandler(nil,error)
                return
            }
            
            let downloadedImage = UIImage(data: data)
            completionHandler(downloadedImage,nil)
            })
        task.resume()
            
    }
    
    
}
