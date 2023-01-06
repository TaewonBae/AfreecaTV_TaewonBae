//
//  EsportsController.swift
//  AfreecaTV
//
//  Created by 배태원 on 2023/01/04.
//

import UIKit
import WebKit

class EsportsController: UIViewController{
    
    @IBOutlet weak var web_view: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sURL = "https://esports.afreecatv.com/"
        let uURL = URL(string: sURL)
        var request = URLRequest(url: uURL!)
        web_view.load(request)
    }
    
    override func loadView() {
        super.loadView()
    }
}
