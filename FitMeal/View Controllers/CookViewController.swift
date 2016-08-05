//
//  CookViewController.swift
//  FitMeal
//
//  Created by Mingyang Sun on 7/13/16.
//  Copyright © 2016 MingyangSun. All rights reserved.
//

import UIKit



class CookViewController: UIViewController, UIPickerViewDelegate,UITextFieldDelegate {
    let MMbackgroundColor: String = "backgroundColor"
    let MMtextColor: String = "textColor"
    let MMtoolbarColor: String = "toolbarColor"
    let MMbuttonColor: String = "buttonColor"
    let MMfont: String = "font"
    let MMvalueY: String = "yValueFromTop"
    let MMselectedObject: String = "selectedObject"
    let MMtoolbarBackgroundImage: String = "toolbarBackgroundImage"
    let MMtextAlignment: String = "textAlignment"
    let MMshowsSelectionIndicator: String = "showsSelectionIndicator"

    var cusine=["African", "Chinese", "Japanese", "Korean", "Vetnamese", "Thai", "Indian", "British", "Irish", "French", "Italian", "Mexican", "Spanish", "Middle eastern", "Jewish", "American", "Cajun", "Southern", "Greek", "German", "Nordic", "Eastern european", "Caribbean", "Latin American",""]
    var intolerance=["Dairy", "Egg", "Gluten", "Peanut", "Sesame", "Seafood", "Shellfish", "Soy", "Sulfite", "Tree nut", "Wheat",""]
    var type=["Main course", "Side dish", "Dessert", "Appetizer", "Salad", "Bread", "Breakfast", "Soup", "Beverage", "Sauce", "Drink",""]
    var diet=["Pescetarian", "Lacto vegetarian", "Ovo vegetarian", "Vegan", "Paleo", "Primal", "Vegetarian",""]
    var customFont: UIFont = UIFont(name: "Palatino-Bold", size: 22.0)!
    
    var multiSelectedStringCusine:[String]=[]
    
    @IBOutlet weak var cusineTextField: UITextField!
    @IBOutlet weak var suggestionsTextView: UITextView!
    @IBOutlet weak var intoleranceTextField: UITextField!
    @IBOutlet weak var dietTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var excludeTextField: UITextField!
    @IBOutlet weak var includeTextField: UITextField!
    @IBOutlet weak var queryTextField: UITextField!
    @IBOutlet weak var calMinTextField: UITextField!
    @IBOutlet weak var calMaxTextField: UITextField!
    @IBOutlet weak var proteinMinTextField: UITextField!
    @IBOutlet weak var proteinMaxTextField: UITextField!
    @IBOutlet weak var carbsMinTextField: UITextField!
    @IBOutlet weak var carbsMaxTextField: UITextField!
    @IBOutlet weak var fatMinTextField: UITextField!
    @IBOutlet weak var fatMaxTextField: UITextField!
    
    @IBAction func clearAllButtonTapped(sender: AnyObject) {
        cusineTextField.text=""
        intoleranceTextField.text=""
        dietTextField.text=""
        typeTextField.text=""
        excludeTextField.text=""
        includeTextField.text=""
        queryTextField.text=""
        calMaxTextField.text=""
        calMinTextField.text=""
        proteinMinTextField.text=""
        proteinMaxTextField.text=""
        carbsMaxTextField.text=""
        carbsMinTextField.text=""
        fatMaxTextField.text=""
        fatMinTextField.text=""
    }
    

    @IBAction func searchButtonTapped(sender: AnyObject) {
       
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "toRecipeListViewController" {
            return check()
        }
        
        return super.shouldPerformSegueWithIdentifier(identifier, sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let recipeListController = segue.destinationViewController as! RecipeListViewController
        if(segue.identifier=="toRecipeListViewController"){
            recipeListController.cusine=cusineTextField.text
            recipeListController.diet=dietTextField.text
            recipeListController.excludeIngredients=excludeTextField.text
            recipeListController.includeIngredients=includeTextField.text
            recipeListController.intolerances=intoleranceTextField.text
            recipeListController.maxCalories=Double(calMaxTextField.text!)
            recipeListController.minCalories=Double(calMinTextField.text!)
            recipeListController.maxCarbs=Double(carbsMaxTextField.text!)
           recipeListController.minCarbs=Double(carbsMinTextField.text!)
            recipeListController.maxProtein=Double(proteinMaxTextField.text!)
            recipeListController.minProtein=Double(proteinMinTextField.text!)
           recipeListController.query=queryTextField.text
            recipeListController.maxFat=Double(fatMaxTextField.text!)
            recipeListController.minFat=Double(fatMinTextField.text!)
            recipeListController.type=typeTextField.text!
            /*if typeTextField.text != ""{
                recipeListController.type=typeTextField.text}
            else if typeTextField.text == ""{
                recipeListController.type="any"
            }*/

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if(InformationInputViewController.suggestions != nil){
            suggestionsTextView.text=InformationInputViewController.suggestions
        }else{
            suggestionsTextView.text=nil
        }
        cusineTextField.tag=0
        intoleranceTextField.tag=1
        typeTextField.tag=2
        dietTextField.tag=3
        cusineTextField.delegate=self
       
        intoleranceTextField.delegate=self
      
        typeTextField.delegate=self
      
        dietTextField.delegate=self
    
        
        
     
        // Do any additional setup after loading the view.
        // if(suggestionsTextView.text != nil){
           //  suggestionsTextView.text = suggestions}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
     
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }

 
  
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        let options: [NSObject : AnyObject] = [MMbackgroundColor: UIColor.blackColor(), MMtextColor: UIColor.whiteColor(), MMtoolbarColor: UIColor.darkGrayColor(), MMbuttonColor: UIColor.whiteColor(), MMfont: customFont, MMvalueY: 5]
        var cusineString:[String]=[]
        var intoleranceString: [String]=[]
        if textField.tag == 0{
            
            MMPickerView.showPickerViewInView(self.view, withStrings: cusine, withOptions: options, completion: {selectedString-> Void in
                self.cusineTextField.text=selectedString
      
          })
            
            return false
        }else if textField.tag == 1{
          
            MMPickerView.showPickerViewInView(self.view, withStrings: intolerance, withOptions: options, completion: {selectedString-> Void in
                intoleranceString.append(selectedString)
                var stringRepresentation=intoleranceString.joinWithSeparator(", ")
                self.intoleranceTextField.text=stringRepresentation
             })
            return false
        }else if textField.tag==2{
            
            MMPickerView.showPickerViewInView(self.view, withStrings: type, withOptions: options, completion: {selectedString-> Void in
                self.typeTextField.text=selectedString})
   
            return false
        }else if textField.tag==3{
         
            MMPickerView.showPickerViewInView(self.view, withStrings: diet, withOptions: options, completion: {selectedString-> Void in
                self.dietTextField.text=selectedString})
        
            return false
        }
        return false
            }
    func check()-> Bool{
    
        if(includeTextField.text=="" && queryTextField.text==""){
            nilError()
            print("nil error")
            return false
        }
    
        if(includeTextField.text != ""){
        if(checkeIncludeOnly(includeTextField.text!) == false){
            invalidInputError()
            print("error text include")
            return false
            }
        }
        if(queryTextField.text != ""){
        if( checkQueryOnly(queryTextField.text!) == false){
            invalidInputError()
            print("error text query")
            return false
        }
        }
        if(calMaxTextField.text != "" || calMinTextField.text != "" || carbsMaxTextField.text != "" || carbsMinTextField.text != "" || proteinMaxTextField.text != "" || proteinMinTextField.text != "" || fatMaxTextField.text != "" || fatMinTextField.text != ""){
        if(checkNumberOnly(calMaxTextField.text!) == false || checkNumberOnly(calMinTextField.text!) == false || checkNumberOnly(proteinMaxTextField.text!) == false || checkNumberOnly(proteinMinTextField.text!) == false || checkNumberOnly(fatMaxTextField.text!) == false || checkNumberOnly(fatMinTextField.text!) == false || checkNumberOnly(carbsMaxTextField.text!) == false || checkNumberOnly(carbsMinTextField.text!) == false){
            invalidInputError()
            print("error number")
            return false
        }
        }
        return true
       
    }
    
    func checkeIncludeOnly(checkString:String)->Bool{
        let alphabetWithSpaceAndCommaRegex = "[A-Za-z, ]+"
        
        let test = NSPredicate(format:"SELF MATCHES %@", alphabetWithSpaceAndCommaRegex)
        
        return test.evaluateWithObject(checkString)
    }
    
    func checkQueryOnly(checkString:String)->Bool{
     
        let alphabetRegex = "[A-Za-z]+"
        let test=NSPredicate(format:"SELF MATCHES %@", alphabetRegex)

        return test.evaluateWithObject(checkString)
       
    }
    func checkNumberOnly(checkString:String)->Bool{

        let numbersRegex = "[0-9 ]+"
        let test=NSPredicate(format:"SELF MATCHES %@", numbersRegex)
     
        return test.evaluateWithObject(checkString)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  
      func nilError(){
        let nilAlertController=UIAlertController(title:"No Value", message: "You need to input either ingredients or query, or both, please check again!",preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction=UIAlertAction(title:"OK", style:UIAlertActionStyle.Default, handler: nil)
        nilAlertController.addAction(alertAction)
        
        self.presentViewController(nilAlertController, animated: true, completion: nil)
        
    }
    func invalidInputError(){
        let alertController=UIAlertController(title: "Invalid Input",message: "You input invalid information, please check your input again!", preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction=UIAlertAction(title:"OK", style:UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(alertAction)
        self.presentViewController(alertController, animated: true, completion: nil)

        
    }
    func moreThanOneQueryError(){
        let alertController=UIAlertController(title: "Invalid Input",message: "You input more than one query, please check your input again!", preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction=UIAlertAction(title:"OK", style:UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(alertAction)
        self.presentViewController(alertController, animated: true, completion: nil)

        
    }
}
