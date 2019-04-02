//
//  ViewController.swift
//  randog
//
//  Created by Gideon Steven Tobing on 27/03/19.
//  Copyright © 2019 Gideon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        DogAPI.requestRandomImage(completionHandler: handleRandomImageResponse(imageData:error:))
    }
    
    func handleImageFileResponse(image: UIImage?,error: Error?) {
            DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    func handleRandomImageResponse (imageData: DogImage?, error: Error?){
        
        guard let imageURL = URL(string: imageData?.message ?? "") else{
            return
        }
        
        //remove the encolsure by calling ```handleImageFileResponse```///
        DogAPI.requestImageFile(url: imageURL, completionHandler: handleImageFileResponse(image:error:))
        }
    
    
}





