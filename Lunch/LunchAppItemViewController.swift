//
//  LunchAppItemViewController.swift
//  Lunch
//
//  Created by Sonia Gilbert on 10/03/2015.
//  Copyright (c) 2015 Site Equip. All rights reserved.
//

import UIKit
// Aim is to connect up our save button ,to allow us to pass information
// back to our list table

// Step 1 : add in our protocol class for our delegate
protocol AddItemViewControllerDelegate : class {
    //this allows use to send it back to our list view controller

    func addItemViewControllerDidSave(controller: LunchAppItemViewController,item: Item)
    // This method will allow us to dismiss our current view controller
    func addItemViewControllerDidCancel(controller: LunchAppItemViewController)

}



class LunchAppItemViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var quantityTextField: UITextField!

    @IBOutlet weak var saveButtonPressed: UIBarButtonItem!

    @IBOutlet weak var segmentButtonPressed: UISegmentedControl!
// Step 2 add an empty property that will be filled with our delegate
    // we add in a delegate variable with an instance delegate so that we can access its methods inside
    //of our class

    weak var delegate : AddItemViewControllerDelegate?
    // we add in a prperty called iconPressed, so we can set the value of our segmented control to it
    //we can the assign it to our iconName property inside our save function
    var iconPressed = "Other"


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Ingredients"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // step 3 add in our save button functionality create a new item object
    @IBAction func saveButton(sender: UIBarButtonItem) {
        let item = Item()
        item.name = nameTextField.text
        item.quantity = quantityTextField.text
        item.iconName = iconPressed
        println(item.iconName)
//When our save button is clicked this sends the delegate method addItemViewControllerDidSave
        //back to our list table view controller which then does somehing with our new item

        delegate?.addItemViewControllerDidSave(self, item: item)
    }
    //step4 add in our cancel button functionality
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        // when the cancel button is pressed, the addItemViewControllerDid Cancel method is called
        //on our list table view controller
        // we use self as we are the controller sending the message
        delegate?.addItemViewControllerDidCancel(self)
    }

    @IBAction func segmentSelected(sender: UISegmentedControl) {


        /* a switch statement considers a value and compares it against several possible matching values
        
        switch someValueToConsider {
         case value1:
        respond to value1
        case value2:
        repond to value2
        case value3:
        respond to value3
        default
        resond to all other resonsibilities
        }
        
        Switch statement must be exhaustive, which means you must provide a response for every outcome. If not appropiriate default appears last




*/

        switch segmentButtonPressed.selectedSegmentIndex {

        case 0:
            iconPressed = "FruitVeg"
            println(iconPressed)
        case 1:
            iconPressed = "Meat"
            println(iconPressed)

        case 2:
            iconPressed = "Fish"
            println(iconPressed)

        default:
            iconPressed = "Other"
            println(iconPressed)


        }

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