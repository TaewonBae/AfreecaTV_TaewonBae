//
//  VODController.swift
//  AfreecaTV
//
//  Created by 배태원 on 2023/01/04.
//

import UIKit
import WebKit
class VODController: UIViewController{
    
    @IBOutlet weak var web_view: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let sURL = "https://vod.afreecatv.com/"
        let uURL = URL(string: sURL)
        var request = URLRequest(url: uURL!)
        web_view.load(request)
    }
    
    override func loadView() {
        super.loadView()
    }
}
