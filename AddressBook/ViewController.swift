//
//  ViewController.swift
//  AddressBook
//
//  Created by campstud on 7/13/18.
//  Copyright © 2018 campstud. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    @IBOutlet weak var addressBook: UITableView!
    
    
    
    var names: Array<String> = []
     var photos: Array<String> = []
     var addresses: Array<String> = []
     var emails: Array<String> = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.addressBook.dequeueReusableCell(withIdentifier: "addressCell")
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "addressCell")
        }
        cell?.textLabel!.text = self.names[indexPath.row]
        cell?.imageView?.image = UIImage(named: self.photos[indexPath.row])
        return cell!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.names = ["tom", "jerry", "tweety", "sylvester"]
        self.photos = ["tom.jpg", "jerry.jpg", "tweety.jpg", "sylvester.jpg"]
        self.emails = ["tom.the.cat@acme.com", "jerry.the.mouse@acme.com", "tweety.the.bird@acme.com", "sylvester.the.cat@acme.com"]
        self.addresses = ["699 S Mill Ave Tempe AZ 85281", "7001 E Williams Field Rd, Mesa, AZ 85212", "411 N Central Ave, Phoenix, AZ 85004", "1475 N Scottsdale Rd, Scottsdale, AZ 85287"]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailView" {
            let indexPath = self.addressBook.indexPathForSelectedRow
            let dest = segue.destination as! CSEDetailViewController
            let index = indexPath!.row
            dest.selectedName = self.names[index]
            dest.selectedEmail = self.emails[index]
            dest.selectedAddress = self.addresses[index]
            dest.selectedImage = self.photos[index]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }


}

