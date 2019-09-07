//
//  UIImageView.swift
//  ChatApp
//
//  Created by Nazim Uddin on 5/9/19.
//  Copyright © 2019 Nazim Uddin. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView{
    func loadImageUsingCachWithUrlString(urlString:String){
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        //otherwise fire off a new download
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            // download hit an error so lets return out
            if error != nil {
                print("Error: \(error?.localizedDescription ?? "error")")
                return
            }
            DispatchQueue.main.async {
                if let downloadImage = UIImage(data: data!) {
                    imageCache.setObject(downloadImage, forKey: urlString as AnyObject)
                    self.image = downloadImage
                }
            }
        }
        task.resume()
    }
}
