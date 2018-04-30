//
//  ViewController.swift
//  bestsourceofmovies
//
//  Created by Vadim on 30/04/2018.
//  Copyright © 2018 Vadim. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let client = ApiClient();
        
        client.loadMovies(page: 1, completion: { [weak self] result in DispatchQueue.main.async {
            switch result {
            case .success(let data):
                print(JSON(data))
            case .failure(let error):
                print(error);
            } } });
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

