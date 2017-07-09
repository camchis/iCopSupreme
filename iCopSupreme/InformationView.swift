//
//  InformationView.swift
//  supremetestbruh
//
//  Created by Cameron Chisholm on 09/04/2017.
//  Copyright © 2017 Cameron Chisholm. All rights reserved.
//

import UIKit
import Eureka
import AES256CBC

class InformationView: FormViewController {
    
    let defaults = UserDefaults.standard
    var number: String!
    var firstname: String!
    var email: String!
    var address: String!
    var city: String!
    var zipcode: String!
    var state: String!
    var country: String!
    var card: String!
    var cardnum: String!
    var expyear: String!
    var expmonth: String!
    var CVV: String!
    var cd: String!
    var auto: String!
    var boolauto: String!
    var onoff: String!
    var category: String!
    var size: String!
    var colour: String!
    var keyword: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if UserDefaults.standard.string(forKey: "onoff") == nil {
            onoff = "false"
        } else {
            onoff = (UserDefaults.standard.string(forKey: "onoff"))!
        }
        
        
        if UserDefaults.standard.string(forKey: "name") == nil {
            firstname = "not set"
        } else {
            firstname = (UserDefaults.standard.string(forKey: "name"))!
        }
        
        
        if UserDefaults.standard.string(forKey: "number") == nil {
            number = "0"
        } else {
            number = (UserDefaults.standard.string(forKey: "number"))!
        }
        
        if UserDefaults.standard.string(forKey: "email") == nil {
            email = "not set"
        } else {
            self.email = (UserDefaults.standard.string(forKey: "email"))!
        }
        
        if UserDefaults.standard.string(forKey: "address") == nil {
            address = "not set"
        } else {
            self.address = (UserDefaults.standard.string(forKey: "address"))!
        }
        
        if UserDefaults.standard.string(forKey: "city") == nil {
            city = "not set"
        } else {
            self.city = (UserDefaults.standard.string(forKey: "city"))!
        }
        
        if UserDefaults.standard.string(forKey: "zipcode") == nil {
            zipcode = "not set"
        } else {
            self.zipcode = (UserDefaults.standard.string(forKey: "zipcode"))!
        }
        
        if UserDefaults.standard.string(forKey: "state") == nil {
            state = "AK"
        } else {
            self.state = (UserDefaults.standard.string(forKey: "state"))!
        }
        
        if UserDefaults.standard.string(forKey: "country") == nil {
            country = "USA"
        } else {
            self.country = (UserDefaults.standard.string(forKey: "country"))!
        }
        
        if UserDefaults.standard.string(forKey: "card") == nil {
            card = "Visa"
        } else {
            self.card = (UserDefaults.standard.string(forKey: "card"))!
            if card == "master" {
                card = "Mastercard"
            } else if card == "visa" {
                card = "Visa"
            } else if card == "american_express" {
                card = "American Express"
            }
        }
        
        if UserDefaults.standard.string(forKey: "cardnum") == nil {
            cardnum = "0000"
        } else {
            self.cardnum = (UserDefaults.standard.string(forKey: "cardnum"))!
        }
        
        if UserDefaults.standard.string(forKey: "expyear") == nil {
            expyear = "2017"
        } else {
            self.expyear = (UserDefaults.standard.string(forKey: "expyear"))!
        }
        
        if UserDefaults.standard.string(forKey: "expmonth") == nil {
            expmonth = "11"
        } else {
            self.expmonth = (UserDefaults.standard.string(forKey: "expmonth"))!
        }
        
        if UserDefaults.standard.string(forKey: "cvv") == nil {
            CVV = "0"
        } else {
            self.CVV = (UserDefaults.standard.string(forKey: "cvv"))!
        }
        
        if UserDefaults.standard.string(forKey: "cd") == nil {
            cd = "0000"
        } else {
            self.cd = (UserDefaults.standard.string(forKey: "cd"))
        }
        
        if UserDefaults.standard.string(forKey: "boolauto") == nil {
            boolauto = "false"
        } else {
            self.boolauto = (UserDefaults.standard.string(forKey: "boolauto"))!
        }
        
        if UserDefaults.standard.string(forKey: "category") == nil {
            category = "Accessories"
        } else {
            self.category = (UserDefaults.standard.string(forKey: "category"))!
        }
        
        if UserDefaults.standard.string(forKey: "size") == nil {
            size = "Small"
        } else {
            self.size = (UserDefaults.standard.string(forKey: "size"))!
        }
        
        if UserDefaults.standard.string(forKey: "keyword") == nil {
            keyword = ""
        } else {
            self.keyword = (UserDefaults.standard.string(forKey: "keyword"))!
        }
        
        if UserDefaults.standard.string(forKey: "colour") == nil {
            colour = ""
        } else {
            self.colour = (UserDefaults.standard.string(forKey: "colour"))!
        }




        
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: Selector("saveStuff"))
        self.navigationItem.rightBarButtonItem = save
        form +++ Section("Cart")
            <<< SwitchRow("onoff"){
                $0.title = "Auto add to Cart"
                $0.value = NSString(string: onoff).boolValue
            }
            <<< LabelRow(){
                $0.hidden = Condition.function(["onoff"], { form in
                    return !((form.rowBy(tag: "onoff") as? SwitchRow)?.value ?? false)
                })
                $0.title = "Automatic ATC is on!"
            }
    
        form +++ Section("Item")
            <<< TextRow("keyword"){
                $0.title = "Keyword"
                $0.placeholder = "Enter keyword here"
                $0.value = keyword
            }
            <<< TextRow("colour"){
                $0.title = "Colour"
                $0.placeholder = "Enter colour here"
                $0.value = colour
                
            }
            <<< PickerRow<String>("category") {
                $0.title = "Category"
                $0.options = ["Jackets", "Shirts", "Tops/Sweaters", "Sweatshirts", "Pants", "T-Shirts", "Hats", "Bags", "Shorts", "Shoes", "Accessories", "Skate"]
                $0.value = category    // initially selected
        }
            
            <<< PickerRow<String>("size") {
                $0.title = "Size"
                $0.options = ["n/a", "Small", "Medium", "Large", "XLarge", "30", "32", "34", "36"]
                $0.value = size    // initially selected
        }




        form +++ Section("Details")
            <<< NameRow("aTag"){ row in
                row.title = "Full Name"
                row.placeholder = "Enter name here"
                row.value = firstname
            }
            <<< EmailRow("email"){
                $0.title = "Email"
                $0.placeholder = "Enter email here"
                $0.value = email
            }
            <<< PhoneRow("number"){
                $0.title = "Number"
                $0.placeholder = "Enter number here"
                $0.value = number
            }
            <<< TextRow("address"){
                $0.title = "Address"
                $0.placeholder = "Enter address here"
                $0.value = address
            }
            <<< ZipCodeRow("zipcode"){
                $0.title = "ZIP Code"
                $0.placeholder = "Enter ZIP/Post Code here"
                $0.value = zipcode
            }
            <<< TextRow("city"){
                $0.title = "City"
                $0.placeholder = "Enter city here"
                $0.value = city
            }
            
            +++ Section("Select State")
            <<< PickerRow<String>("state") {
                $0.title = "State"
                $0.options = ["n/a", "AK","AL","AR","AZ","CA","CO","CT","DC","DE","FL","GA","GU","HI","IA","ID", "IL","IN","KS","KY","LA","MA","MD","ME","MH","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY", "OH","OK","OR","PA","PR","PW","RI","SC","SD","TN","TX","UT","VA","VI","VT","WA","WI","WV","WY"]
                $0.value = state    // initially selected
            }
            
            +++ Section("Select Country")
            <<< PickerRow<String>("country") {
                $0.title = "Country"
                $0.options = ["USA","CANADA","JAPAN","GB","NB","AT","BY","BE","BG","HR","CZ","DK","EE","FI","FR", "DE","GR","HU","IS","IE","IT","LV","LT","LU","MC","NL","NO","PL","PT","RO","RU","SK","SI","ES","SE","CH","TR", "UA"]
                $0.value = country    // initially selected
            }
        
            +++ Section("Card Type")
            <<< PickerRow<String>("card") {
                $0.title = "Card Type"
                $0.options = ["Visa", "American Express", "Mastercard", "Solo", "PayPal"]
                $0.value = card
        }
        
        form +++ Section("Card Details")
            <<< TextRow("cardnum"){ row in
                row.title = "Card Number"
                row.placeholder = "Enter card number here"
                row.value = cardnum
        }
            <<< TextRow("expmonth"){
                $0.title = "Exp Month"
                $0.placeholder = "Enter expiry month here"
                $0.value = expmonth
        }
            <<< TextRow("expyear"){
                $0.title = "Exp Year"
                $0.placeholder = "Enter expiry year here"
                $0.value = expyear
        }
            <<< TextRow("cvv"){
                $0.title = "CVV"
                $0.placeholder = "Enter CVV here"
                $0.value = CVV
        }

        form +++ Section("Misc")
            <<< TextRow("cd"){ row in
                row.title = "Checkout Delay"
                row.placeholder = "Enter delay here (ms)"
                row.value = cd
        }
        
            <<< SwitchRow("checkout"){
                $0.title = "Automatic Checkout"
                $0.value = NSString(string: boolauto).boolValue
            }
            <<< LabelRow(){
                $0.hidden = Condition.function(["checkout"], { form in
                    return !((form.rowBy(tag: "checkout") as? SwitchRow)?.value ?? false)
                })
                $0.title = "Automatic checkout is on!"
        }
        

    }
    
    
    func saveStuff() {
        let alert = UIAlertController(title: "Saved", message: "Information has been saved", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Let's cop 🤙", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        let row: NameRow? = form.rowBy(tag: "aTag")
        let value = row?.value
        UserDefaults.standard.set(value, forKey: "name")
        
        
        let emailrow: EmailRow? = form.rowBy(tag: "email")
        let emailval = emailrow?.value
        UserDefaults.standard.set(emailval, forKey: "email")
        
        let numberrow: PhoneRow? = form.rowBy(tag: "number")
        let numberval = numberrow?.value
        UserDefaults.standard.set(numberval, forKey: "number")
        
        let addressrow: TextRow? = form.rowBy(tag: "address")
        let addressval = addressrow?.value
        UserDefaults.standard.set(addressval, forKey: "address")
        
        let cityrow: TextRow? = form.rowBy(tag: "city")
        let cityval = cityrow?.value
        UserDefaults.standard.set(cityval, forKey: "city")
        
        let ziprow: ZipCodeRow? = form.rowBy(tag: "zipcode")
        let zipval = ziprow?.value
        UserDefaults.standard.set(zipval, forKey: "zipcode")
        
        let countryrow: PickerRow<String>? = form.rowBy(tag: "country")
        let countryval = countryrow?.value
        UserDefaults.standard.set(countryval, forKey: "country")
        
        let staterow: PickerRow<String>? = form.rowBy(tag: "state")
        let stateval = staterow?.value
        UserDefaults.standard.set(stateval, forKey: "state")
        
        let cardrow: PickerRow<String>? = form.rowBy(tag: "card")
        let cardval = cardrow?.value
        UserDefaults.standard.set(cardval, forKey: "card")
        
        let cardnumrow: TextRow? = form.rowBy(tag: "cardnum")
        let cardnumval = cardnumrow?.value
        UserDefaults.standard.set(cardnumval, forKey: "cardnum")

        let yearrow: TextRow? = form.rowBy(tag: "expyear")
        let yearval = yearrow?.value
        UserDefaults.standard.set(yearval, forKey: "expyear")
        
        let monthrow: TextRow? = form.rowBy(tag: "expmonth")
        let monthval = monthrow?.value
        UserDefaults.standard.set(monthval, forKey: "expmonth")

        let cvvrow: TextRow? = form.rowBy(tag: "cvv")
        let cvvval = cvvrow?.value
        UserDefaults.standard.set(cvvval, forKey: "cvv")
        
        let cdrow: TextRow? = form.rowBy(tag: "cd")
        let cdval = cdrow?.value
        UserDefaults.standard.set(cdval, forKey: "cd")
        
        let switchval: SwitchRow? = form.rowBy(tag: "checkout")
        UserDefaults.standard.set(switchval?.value, forKey: "checkout")
        
        if switchval!.value == true {
            boolauto = "true"
            UserDefaults.standard.set(boolauto, forKey: "boolauto")
        } else {
            boolauto = "false"
            UserDefaults.standard.set(boolauto, forKey: "boolauto")
        }
        
        let onoffval: SwitchRow? = form.rowBy(tag: "onoff")
        UserDefaults.standard.set(onoffval!.value, forKey: "onoff")
        if onoffval!.value == true {
            onoff = "true"
            UserDefaults.standard.set(boolauto, forKey: "onoff")
        } else {
            onoff = "false"
            UserDefaults.standard.set(boolauto, forKey: "onoff")
        }
        
        
        let categoryrow: PickerRow<String>? = form.rowBy(tag: "category")
        let categoryval = categoryrow?.value
        UserDefaults.standard.set(categoryval, forKey: "category")
        
        
        let sizerow: PickerRow<String>? = form.rowBy(tag: "size")
        let sizeval = sizerow?.value
        UserDefaults.standard.set(sizeval, forKey: "size")
        
        let colourrow: TextRow? = form.rowBy(tag: "colour")
        let colourval = colourrow?.value
        UserDefaults.standard.set(colourval, forKey: "colour")
        
        let keywordrow: TextRow? = form.rowBy(tag: "keyword")
        let keywordval = keywordrow?.value
        UserDefaults.standard.set(keywordval, forKey: "keyword")
        
        print(size)
        print(card)


 
        
    }
}
