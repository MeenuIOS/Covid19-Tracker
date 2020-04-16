//
//  CovidCasesVC.swift
//  Covid-19Tracker
//
//  Created by Sarath Sasi on 07/04/20.
//  Copyright © 2020 XCoders. All rights reserved.
//

import UIKit
import SideMenu

class CovidCasesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalCasesLabel: UILabel!
    @IBOutlet weak var totalRecoveredLabel: UILabel!
    @IBOutlet weak var totalDeathLabel: UILabel!
    @IBOutlet weak var updateDate: UILabel!
    
    
    
    private var allData: AllData = AllData()
    var countries: [Country] = []
    var formatter = DateFormatter()
    var lastUpdateDate = ""
    var countriesName: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRemainingNavItems()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func refreshList(_ sender: Any) {
        
        self.viewDidLoad()
        self.view.setNeedsLayout()
        self.view.setNeedsDisplay()
                      
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 120
    }
    
    func tableView(_ tableViews: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let country = countries[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! CovidlistTVCell
        
        cell.country.text = country.country;
        cell.deathLabel.text = "\(country.deaths) deaths";
        cell.recoverdLabel.text = "\(country.recovered) recovered";
        cell.casesLabel.text = "\(country.cases) cases";
        return cell
        
    }
    
    func loadData() {
        self.formatter.timeStyle = .medium
        self.lastUpdateDate = self.formatter.string(from: Date())
        updateDate.text = "Updated Date/Time - " + self.lastUpdateDate
        allDataApiGetData { (data) in
            self.allData = data
        }
 
        getData { (data) in
            self.countries = data
        }
    }
    func getData(completion: @escaping ([Country]) -> ()) {
        //For Getting the total Value of the particular Countries
        guard let url = URL(string: "https://corona.lmao.ninja/countries") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let data = try! JSONDecoder().decode([Country].self, from: data!)
            
            DispatchQueue.main.async {
                completion(data)
                self.tableView.reloadData()
            }
        }
        .resume()
    }
    
    func allDataApiGetData(completion: @escaping (AllData) -> ()) {
        //For Getting the total Value of the all Countries
        guard let url = URL(string: "https://corona.lmao.ninja/all") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let data = try! JSONDecoder().decode(AllData.self, from: data!)
            
            DispatchQueue.main.async {
                completion(data)
                self.totalCasesLabel.text = "\(self.allData.cases) total Cases"
                self.totalRecoveredLabel.text = "\(self.allData.recovered) total Recovered"
                self.totalDeathLabel.text = "\(self.allData.deaths) total Deaths"
                
            }
        }
        .resume()
    }
}


extension UIViewController {
    func setupRemainingNavItems() {
        
        let button = UIButton(type: .custom)
        //button.setTitle("", for: .normal)
         button.setImage(UIImage (named: "open-menus"), for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
        button.addTarget(self, action: #selector(tapbutton), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        
        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    @objc func tapbutton()
    {
        setupSideMenu()
        updateMenus()
        
    }
    
    private func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
        
    }
    
    private func updateMenus() {
        let settings = makeSettings()
        SideMenuManager.default.leftMenuNavigationController?.settings = settings
        
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    private func selectedPresentationStyle() -> SideMenuPresentationStyle {
        let modes: [SideMenuPresentationStyle] = [.menuSlideIn, .viewSlideOut, .viewSlideOutMenuIn, .menuDissolveIn]
        return modes[2]
    }
    
    private func makeSettings() -> SideMenuSettings {
        let presentationStyle = SideMenuPresentationStyle.viewSlideOut
        // presentationStyle.backgroundColor = UIColor(patternImage:s)
        presentationStyle.menuStartAlpha = CGFloat(1)
        presentationStyle.menuScaleFactor = CGFloat(1)
        presentationStyle.onTopShadowOpacity = 1
        presentationStyle.presentingEndAlpha = CGFloat(1)
        presentationStyle.presentingScaleFactor = CGFloat(1)
        
        var settings = SideMenuSettings()
        settings.presentationStyle = presentationStyle
        settings.menuWidth = min(view.frame.width, view.frame.height) * CGFloat(0.8)
        let styles:[UIBlurEffect.Style?] = [nil, .dark, .light, .extraLight]
        settings.blurEffectStyle = styles[1]
        settings.statusBarEndAlpha = 1
        return settings
    }
}
extension UIViewController: SideMenuNavigationControllerDelegate {
    
    public func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
    }
    
    public func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }
    
    public func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }
    
    public func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
}
