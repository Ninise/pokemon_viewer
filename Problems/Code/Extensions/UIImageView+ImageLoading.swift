//
//  UIImageView+ImageLoading.swift
//  Problems
//
//  Created on 2019-04-29.
//  Copyright © 2019 MetaLab Design. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {

    /// Sets the ImageViews image as the contents of the URL
    ///
    /// - Parameter url: The location of the image.
    /// - Parameters:
    ///   - url: The location of the image.
    ///   - urlSession: The URLSession to run the task on.
    /// - Returns: the URLSessionTask of the operation.
    @discardableResult
    func setImage(from url: URL, usingUrlSession urlSession: URLSession = URLSession.shared) -> URLSessionTask {

        let imageRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60.0)
        let imageRequestTask = urlSession.dataTask(with: imageRequest) { (data, response, error) in
            if error != nil {
                dump(error)
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Not a proper HTTPURLResponse or statusCode")
                return
            }

            self.image = UIImage(data: data!)
        }

        imageRequestTask.resume()

        return imageRequestTask
    }

}
