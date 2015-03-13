//
//  LunchTableViewController.swift
//  Lunch
//
//  Created by Sonia Gilbert on 09/03/2015.
//  Copyright (c) 2015 Site Equip. All rights reserved.
//


import UIKit
// becoming a delegate step1
//declare yourself as the delegate by adding AddItemViewControllerDelegate to the class declaration

class LunchTableViewController: UITableViewController,AddItemViewControllerDelegate {
    //this creates an empty array that will hold only Item objects
    var items = [Item]()
    // This function is called when our view is loaded. Do setup like setting the title in here
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        self.title = "Lunch"

        //here we are creating a new item
        // The first line assigns a new item object to a constant called item1

        let item1 = Item()
        //the second two lines assign values to this objects name and quantity properties
        item1.name = "Tomatoes"
        item1.quantity = "800g"
        item1.iconName = "FruitVeg"
        //the third uses =+ to add our item1 to the items array
        self.items += [item1]

        let item2 = Item()
        item2.name = "Seabass"
        item2.quantity = "4 fillets"
        item2.iconName = "Fish"
        self.items += [item2]
        
        




    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    //This function allows us to tell the table view how many rows of data we want to display
    // the extra parameter name inside this function is actually the second parameters external parameter name. This will be used when the function is called

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.

        //Instead of returning a static vaule such as 1 - we want to return the amount of item objects currently inside our array "items"
        //To do this we use the .count method
        return items.count

    }
// this function allows us to tell the table view how to display each row of data. Here we add in our
    //prototype cell so the table view knows how to display its data

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // this line declars our reisable cell. We add in ItemCell wher it said reuseidentier so we can tell the tableview
        //to create this kind of cell for each row of data

        // step1 add in reuse identifer
        // this function is run everytime a new row of data needs a cell

        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
// step2 this line accesses the item at a specified number inside our array
        //we use the indexpath to point to the correct row of data

        let item = self.items[indexPath.row]
        println(indexPath.row)
        // step 3 set our text labels
        //first access our cell property textLabel
        // we use the ! to unwrap this optional value so we can set its properties
        // note only use the ! when you definatley know there is a value
        //we then access the text property
        // and finally assign it to the name of the current item

        cell.textLabel!.text = item.name
        cell.detailTextLabel!.text = item.quantity
        // Here we want to display our icon inside of our cell
        // to do this we use UUImage method that allows us to set an image by its file name
        cell.imageView!.image = UIImage (named:item.iconName)
        return cell
    }
// MARK: - Protocol Methods
    //step2: Conform to the protocol set in LunchAddItemViewControler
    // to do this we need to fill in both protocol methods
    // aim is to add our item passed ny lunchAdd ViewController to our table below
    func addItemViewControllerDidSave(controller: LunchAppItemViewController, item: Item) {

//we want to use the insertRowsAtIndexPath method
        // this is what we need
        // An array of NSIndexPath objects, representing a row in our table view
        //First get the row index
        // This counts how many items are in our array currently
        //At the moment we have 2 items on our array, so this is the number that will be returned
        //this actuallywill correspond to the third row in our table as our
        //table counts from 0, 1, 2

        let rowIndex = items.count
        //create a new indexpath combining our row and section number. if you
        //have one section, the section number will be 0 as we count from 0

        let indexPath = NSIndexPath(forRow: rowIndex, inSection: 0)


        //add our indexPath into an array

        let indexPathArray = [indexPath]
        // add our new item to our items array
        // we do this after the index path toensure our row index points to
        //the correct place

        self.items += [item]

        // now add our insertRowAtIndexPath Method

        tableView.insertRowsAtIndexPaths(indexPathArray, withRowAnimation: .Automatic)

        //dismiss our view controller
        dismissViewControllerAnimated(true, completion: nil)






    }
    // aim is to dismiss  the lunchAddItemViewController
    func addItemViewControllerDidCancel(controller: LunchAppItemViewController) {
        dismissViewControllerAnimated(true, completion: nil)


        }




    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // step 3: tell the other controller that we are its delegate
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

        if segue.identifier == "AddItem" {
            // set the delegate property on our Add Item controller
            //first get a reference


        let navigationController = segue.destinationViewController as UINavigationController

        //second get a referance to add item view controller
            // here we use topviewcontroller method to access whatever controller
            //is on top
            //The navigation stack containes views and other navigation controllers.
            // They sit on top of one another. hierarchy as follows
            // AddItem contoller
            //navigationcontroller
            //lunchtableviewcontroller
            //navigationcontroller

            //xcode cannot be be sure what object is sitting on top of the navigation stack
            //so again we have to use type casting to let it know- as LunchAddItemViewController

            let addItemController = navigationController.topViewController
            as LunchAppItemViewController

            //once we have a reference to the correct controller, we can access
            //its delegate property and set it to ourself
            addItemController.delegate = self



        }
        
    }



    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source

            //so when we delete items from a table view we need to delete it from our array too

            // we this funstion is alled the cell that is in deletes mode passes its indexpath to us. 
            //We then use removeAt Index and pass it index to delete the correct item in our array

            self.items.removeAtIndex(indexPath.row
            )
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    //here we want to rearrange the order of our items in our array so that our order is preserved




    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

        //first get a reference to the item that is inside the row we want to move from
        let item = items[fromIndexPath.row]
        //next remove this item

        items.removeAtIndex(fromIndexPath.row)

        //insert the item back into array at the correct position

        items.insert(item, atIndex: toIndexPath.row)

        println(item.name)


    }


// this method allows us to rearrange our tableview but does not change the order of our items in our items array

    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
