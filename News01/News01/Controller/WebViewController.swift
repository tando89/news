//
//  WebViewController.swift
//  News01
//
//  Created by Tan Do  on 5/5/18.
//  Copyright © 2018 Tan Do . All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController {
    @IBOutlet weak var detailNews: WKWebView!
    
    var getURL = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: getURL) {
            detailNews.load(URLRequest(url: url))
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
