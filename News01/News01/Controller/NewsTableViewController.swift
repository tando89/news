//
//  NewsTableViewController.swift
//  News01
//
//  Created by Tan Do  on 5/5/18.
//  Copyright © 2018 Tan Do . All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SDWebImage
class NewsTableViewController: UITableViewController {

    @IBOutlet var tableFeeds: UITableView!
    let newsURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey=fb2eb065e7304b12bf0b926180d77525"
    var news: [[String: Any]] = [[String: Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNews()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateNews() {
        SVProgressHUD.show(withStatus: "Getting feeds...")
        Alamofire.request(newsURL).responseJSON { (response) in
            if response.result.isSuccess {
                if let responseData = response.result.value as! [String: Any]? {
                    if let responseFeeds = responseData["articles"] as! [[String: Any]]? {
                        print(responseFeeds)
                        
                        self.news = responseFeeds
                        self.tableFeeds?.reloadData()
                        SVProgressHUD.dismiss()
                        
                    }
                }
            } else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    @IBAction func refreshFeeds(_ sender: Any) {
        updateNews()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCells", for: indexPath) as! NewsTableViewCell
        if self.news.count > 0 {
            let eachFeed = news[indexPath.row]
            cell.titleLabel?.text = (eachFeed["title"] as? String) ?? "N/A"
            cell.descriptionLabel?.text = (eachFeed["description"] as? String) ?? "N/A"
            let url = eachFeed["urlToImage"] as? String
            cell.newsImage.sd_setImage(with: URL(string: url!), placeholderImage: UIImage(named: "loadingImage.png"))
            
        }
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let webViewController = storyBoard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        let eachURL = news[indexPath.row]
        let newsURL = eachURL["url"] as? String
        webViewController.getURL = (newsURL)!
        self.navigationController?.pushViewController(webViewController, animated: true)
        
        
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
