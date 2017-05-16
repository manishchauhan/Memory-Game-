//
//  highscoreTableViewController.swift
//  DemoMemoryGame
//
//  Created by Manish on 04/02/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import UIKit

class highscoreTableViewController: UITableViewController {
    private let reuseIdentifier = "highscoreRow"
    private let headerreuseIdentifier = "headerRow"
    var scoreArray = [MemoryEntity]()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerReusebleCell()
        self.tableView?.delegate=self;
        self.tableView?.dataSource=self;
        //fetch score
        setUPData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    private func setUPData()
    {
        scoreArray=MemoryDataModel.getAllNotes()!;
    }
    // Regsiter view
    func registerReusebleCell() -> Void {
        let nib = UINib(nibName: "tableRowView", bundle: nil)
        tableView?.registerNib(nib, forCellReuseIdentifier: reuseIdentifier);
     
        // header row
        let headerNib = UINib(nibName: "headerTableViewCell", bundle: nil)
        tableView?.registerNib(headerNib, forCellReuseIdentifier: headerreuseIdentifier);
        let header = tableView.dequeueReusableCellWithIdentifier(headerreuseIdentifier) as! headerTableViewCell
        tableView.tableHeaderView=header;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func refreshData() -> Void {
        
        dispatch_async(dispatch_get_main_queue()){
            self.setUPData();
            self.tableView?.reloadData();
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.6 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                //moved to main thread
                self.tableView!.setContentOffset(CGPointZero, animated: true)
            }
            
        }
        
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scoreArray.count;
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)  as! highScoreRowTableViewCell

        cell.usernameText.text=scoreArray[indexPath.item].username;
        cell.rankText.text=String(indexPath.item+1);
        cell.scoreText.text=String(scoreArray[indexPath.item].userscore!);
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
