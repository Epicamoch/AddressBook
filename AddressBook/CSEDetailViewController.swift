//
//  CSEDetailViewController.swift
//  AddressBook
//
//  Created by campstud on 7/13/18.
//  Copyright © 2018 campstud. All rights reserved.
//

import UIKit
import MessageUI

class CSEDetailViewController: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    var selectedAddress: String = ""
    var selectedEmail: String = ""
    var selectedName: String = ""
    var selectedImage: String = ""
    
    
    @IBAction func email(_ sender: Any) {
        let emailTitle = "Test Email"
        let messageBody = "iOS programming is so fun!"
        let toRecipients = [self.selectedEmail]
       
        let mc = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setMessageBody(messageBody, isHTML: false)
        mc.setToRecipients(toRecipients)
        
        self.present(mc,animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.address.text = self.selectedAddress
        self.name.text = self.selectedName
        self.email.text = self.selectedEmail
        self.photo.image = UIImage(named: self.selectedImage)
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "map" {
            let dest = segue.destination as! CSEMapViewController
            dest.address = self.selectedAddress
        }
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
