//
//  ViewController.swift
//  Alamofire Upload
//
//  Created by Lun Sovathana on 12/9/16.
//  Copyright © 2016 Lun Sovathana. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView1.image = #imageLiteral(resourceName: "iphone 7 black")
        imageView2.image = #imageLiteral(resourceName: "iphone7 plus")
    }
    
    @IBAction func uploadImages(_ sender: Any) {
        
        // Multiple upload
        multipleUpload()
        
        // Upload single
        singleUpload()
        
    }
    
    func multipleUpload(){
        let imageData1 = UIImagePNGRepresentation(imageView1.image!)
        let imageData2 = UIImagePNGRepresentation(imageView2.image!)
        
        let uploadHeaders: HTTPHeaders = [
            "Authorization": "Basic cmVzdGF1cmFudEFETUlOOnJlc3RhdXJhbnRQQFNTV09SRA==",
            "Accept": "application/json",
            ]
        let url = URL(string: "http://120.136.24.174:15020/v1/api/admin/upload/multiple")
        // multiple
        Alamofire.upload(multipartFormData: { formData in
            
            // Image param name is files
            formData.append(imageData1!, withName: "files", fileName: "image.jpg", mimeType: "image/jpg")
            formData.append(imageData2!, withName: "files", fileName: "image.jpg", mimeType: "image/jpg")
            // name
            formData.append("image".data(using: .utf8)!, withName: "name")
            
            
        }, usingThreshold: 0, to: url!, method: HTTPMethod(rawValue: "POST")!, headers: uploadHeaders, encodingCompletion: {encodingResult in
            
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    debugPrint(response)
                }
            case .failure(let encodingError):
                print(encodingError)
            }
            
            
        })
    }
    
    func singleUpload(){
        let urlUpload = "http://120.136.24.174:1301/v1/api/uploadfile/single"
        let headers: HTTPHeaders = [
            "Authorization": "Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ=",
            "Accept": "application/json",
            "Content-Type": "multipart/form-data"
        ]

        let imageData = UIImagePNGRepresentation(imageView1.image!)
        
        Alamofire.upload(multipartFormData: { formData in
            
            formData.append(imageData!, withName: "FILE", fileName: "Image.jpg", mimeType: "image/jpg")
            
        }, usingThreshold: 0, to: urlUpload, method: HTTPMethod(rawValue: "POST")!, headers: headers, encodingCompletion: {encodingResult in
            
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    debugPrint(response)
                }
            case .failure(let encodingError):
                print(encodingError)
            }
            
            
        })
        
    }
    
}

