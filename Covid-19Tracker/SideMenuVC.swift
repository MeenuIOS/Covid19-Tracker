//
//  SideMenuVC.swift
//  Covid-19Tracker
//
//  Created by Sarath Sasi on 07/04/20.
//  Copyright © 2020 XCoders. All rights reserved.
//

import UIKit
import UIKit
import Firebase
import FirebaseAuth
import WebKit


class SideMenuVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
    }
   
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60
    }
    //
    func tableView(_ tableViews: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cellIdentifier = String()
        
        if(indexPath.section == 0){
           cellIdentifier = "cell1"
        }else{
            cellIdentifier = "cell2"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier:cellIdentifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 0){
    UIApplication.shared.open(NSURL(string:"https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public")! as URL)
         
        }
        else{
            if Auth.auth().currentUser != nil {
                         do {
                             try Auth.auth().signOut()
                           
                             self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)

                         } catch let error as NSError {
                             print(error.localizedDescription)
                         }
                 }
            
        }
        
        
    }
}
