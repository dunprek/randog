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
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    let breeds: [String] = ["greyhound","poodle"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
       
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

 extension ViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         DogAPI.requestRandomImage(completionHandler: handleRandomImageResponse(imageData:error:))
    }
}





