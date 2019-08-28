//
//  ViewController.swift
//  S3Upload
//
//  Created by Nate Armstrong on 8/24/19.
//  Copyright © 2019 Nate Armstrong. All rights reserved.
//

import UIKit
import AWSS3

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        uploadFile()
    }

    func uploadFile() {
        let file = Bundle.main.url(forResource: "cake-1", withExtension: "png")!
        let transfer = AWSS3TransferUtility.default()

        transfer.uploadFile(file, bucket: secrets.awsBucket, key: "cake-1.png", contentType: "image/png", expression: nil) { task, error in
            if let error = error {
                print("There was an error. Check out task.response for more info.", error.localizedDescription)
                return
            }
            print("Success!")
        }
    }
}

let secrets = Secrets.instance

struct Secrets: Codable {
    let awsIdentityPoolID: String
    let awsBucket: String

    enum CodingKeys: String, CodingKey {
        case awsIdentityPoolID = "AWS_IDENTITY_POOL_ID"
        case awsBucket = "AWS_BUCKET"
    }

    public static let instance: Secrets = {
        let decoder = PropertyListDecoder()
        guard
            let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
            let data = try? Data(contentsOf: url),
            let secrets = try? decoder.decode(Secrets.self, from: data)
        else {
            fatalError("Secrets not found. Edit Secrets.plist")
        }
        return secrets
    }()
}
