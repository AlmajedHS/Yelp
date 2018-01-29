//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var businesses: [Business]!
    var filteredBusiness : [Business]!
     var searchBar = UISearchBar()
    var searchController = UISearchController()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
       
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
//        searchDisplayController?.displaysSearchBarInNavigationBar = true
//        
//        searchController.searchBar.sizeToFit()
//       navigationItem.titleView = searchController.searchBar
//        searchController.hidesNavigationBarDuringPresentation = false
        
        //searchController.hidesNavigationBarDuringPresentation = false
        
        
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
        
            self.businesses = businesses
            self.filteredBusiness = self.businesses
            self.tableView.reloadData()
            if let businesses = businesses {
                
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
            }
        )
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            if filteredBusiness != nil{
                return filteredBusiness!.count
            }else{
                return 0
            }
            
            
        }
        
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
            
            cell.business = filteredBusiness[indexPath.row]
            
            return cell
            
            
        }
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: Error!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        print(searchText)
            filteredBusiness = searchText.isEmpty ? businesses : businesses.filter({(business: Business) -> Bool in
                return business.name?.range(of: searchText) != nil
            })
            
            tableView.reloadData()
       
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
