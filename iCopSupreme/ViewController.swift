//
//  ViewController.swift
//  supremetestbruh
//
//  Created by Cameron Chisholm on 29/03/2017.
//  Copyright © 2017 Cameron Chisholm. All rights reserved.
//

import UIKit
import JavaScriptCore
import Just
import Alamofire
import SwiftyJSON
//import DynamicButton
import TKSwitcherCollection
import AES256CBC

class ViewController: UIViewController, UIWebViewDelegate {
    
    let defaults = UserDefaults.standard

    @IBOutlet weak var supremeView: UIWebView!
    var cardnum: String!
    var cardtype: String!
    var CVV: String!
    var cd: String!
    var keyword: String!
    var category: String!
    var number: String!
    var firstname: String!
    var email: String!
    var address: String!
    var city: String!
    var zipcode: String!
    var state: String!
    var country: String!
    var card: String!
    var expyear: String!
    var expmonth: String!
    var boolauto: String!
    var loop: Int!
    var end: Int!
    var onoff: String!
    var loadreq: Bool!
    var size: String!
    var colour: String!
    var noloop: Int!
    var skrrr: Int!
    var sizeid: String!
    var colourid: String!
    var itemid: String!
    var jsfile: String!
    var jssize: String!
    var gtoken: String!
    @IBOutlet weak var capLabel: UILabel!
    @IBOutlet weak var capIndicator: UIActivityIndicatorView!
    var counter: Int!
    var timer = Timer()
    @IBOutlet weak var capSwitch: TKSimpleSwitch!
    var status: String!
    var capArray: [String]!
    var noitem: Bool!
    var atcstarted: Bool!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var colourLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var atcSwitch: TKSimpleSwitch!
    var atcstatus: String!
    var password: String!

    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let launchedBefore1 = UserDefaults.standard.bool(forKey: "launchedBefore1")
        if launchedBefore1  {
            print("Not first launch.")
        } else {
            password = AES256CBC.generatePassword()
            UserDefaults.standard.set(password, forKey: "password")
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set(true, forKey: "launchedBefore1")
        }
        
        if UserDefaults.standard.string(forKey: "password") == nil {
            print("nil")
        } else {
            password = UserDefaults.standard.string(forKey: "password")!
            print(password)
        }


        supremeView.delegate = self
        let url = URL (string: "http://www.supremenewyork.com/mobile/#categories/new")
        let requestObj = URLRequest(url: url!);
        supremeView.loadRequest(requestObj)
        loop = 0
        end = 0
        loadreq = true
        noloop = 0
        skrrr = 0
        let context = JSContext()
        let jspath = Bundle.main.path(forResource: "hihihi", ofType: "js")
        do {
            jsfile = try  String(contentsOfFile: jspath!, encoding: String.Encoding.utf8)
            _ = context?.evaluateScript(jsfile)

        } catch (let error) {
            print("Error while processing script file: \(error)")
        }
        
        let jspathsize = Bundle.main.path(forResource: "checkout", ofType: "js")
        do {
            jssize = try  String(contentsOfFile: jspathsize!, encoding: String.Encoding.utf8)
            _ = context?.evaluateScript(jssize)
            
        } catch (let error) {
            print("Error while processing script file: \(error)")
        }
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        counter = 0
        status = "nil"
        capSwitch.setOn(false, animate: false)
        atcSwitch.setOn(false, animate: false)

        capArray = []
        noitem = true
        atcstarted = false
        atcstatus = "idle"
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.string(forKey: "onoff") == nil {
            onoff = "false"
        } else {
            onoff = (UserDefaults.standard.string(forKey: "onoff"))!
        }
        
        if UserDefaults.standard.string(forKey: "name") == nil {
            firstname = "0"
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
            state = "not set"
        } else {
            self.state = (UserDefaults.standard.string(forKey: "state"))!
        }
        
        if UserDefaults.standard.string(forKey: "cardnum") == nil {
            cardnum = "000"
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
        
        if UserDefaults.standard.string(forKey: "country") == nil {
            country = "USA"
        } else {
            self.country = (UserDefaults.standard.string(forKey: "country"))!
        }
        
        
        if UserDefaults.standard.string(forKey: "card") == nil {
            card = "Visa"
        } else {
            self.card = (UserDefaults.standard.string(forKey: "card"))!
            if card == "Mastercard" {
                card = "master"
            } else if card == "Visa" {
                card = "visa"
            } else if card == "American Express" {
                card = "american_express"
            } else if card == "Solo" {
                card = "solo"
            } else if card == "PayPal" {
                card = "paypal"
            }
        }
        
        if UserDefaults.standard.string(forKey: "cd") == nil {
            cd = "0000"
        } else {
            self.cd = (UserDefaults.standard.string(forKey: "cd"))!
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
            keyword = "not set"
        } else {
            self.keyword = (UserDefaults.standard.string(forKey: "keyword"))!
        }
        
        if UserDefaults.standard.string(forKey: "colour") == nil {
            colour = "not set"
        } else {
            self.colour = (UserDefaults.standard.string(forKey: "colour"))!
        }
        
        keywordLabel.text = keyword!
        sizeLabel.text = size!
        colourLabel.text = colour!

    }
    

    
    func startATC() {
        
        atcstatus = "idle"
        
        atcstarted = true
        
        print("startATC")
        
        let current = String(describing: supremeView.request)
        
     //   if noloop == 0 {
            
        if current.range(of: "new") != nil || current.range(of: "categories") != nil {
                print(category)
                supremeView.stringByEvaluatingJavaScript(from: "var cat = allCategoriesAndProducts.products_and_categories.\(category!);")
                let suptest = supremeView.stringByEvaluatingJavaScript(from: "for(var i in cat) { \n var string = cat[i].name; \n if (string.includes('\(keyword!)')) { \n var productid = cat[i].id \n var gotoproduct = 'http://www.supremenewyork.com/shop/' + productid + '.json'; \n window.location.href = gotoproduct \n } \n }")
                self.itemid = supremeView.stringByEvaluatingJavaScript(from: "productid")
                self.itemid = String(describing: itemid!)
                print("ITEMID", itemid)
                
                if itemid == "" {
                    noitem = true
                    self.supremeView.reload()
                }
                
                var newurl = "http://www.supremenewyork.com/shop/\(itemid!).json"
                
                
                let headers: HTTPHeaders = [
                    "User-Agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 10_2 like Mac OS X) AppleWebKit/602.3.12 (KHTML, like Gecko) Mobile/14C92",
                    "Accept": "application/json",
                    "Content-Type": "application/x-www-form-urlencoded",
                    "X-HTTP-Method-Override": "GET",
                    "X-Requested-With": "XMLHttpRequest",
                    "Referer": "http://www.supremenewyork.com/mobile/"
                ]
                
                atcstatus = "prereq"
                
                // GET Request
                Alamofire.request(newurl, headers: headers).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        
                        self.atcstatus = "json"
                        
                        // Style = Colour
                        let style = json["styles"]
                        let styles = style.count
                        
                        // Go through each colour, check if it matches user search
                        for i in 0...styles {
                            if style[i]["name"].stringValue.lowercased().contains(self.colour.lowercased()) {
                                self.colourid = style[i]["id"].stringValue
                                // Get each size available from matched style
                                let sizejson = style[i]["sizes"]
                                let sizes = sizejson.count as Int
                                // Go through each size, check if it matches user search
                                for i in 0...sizes {
                                    if self.size.lowercased() == sizejson[i]["name"].stringValue.lowercased() {
                                        self.sizeid = sizejson[i]["id"].stringValue
                                        self.onoff = "true"
                                        self.atcstarted = false
                                        self.atcstatus = "atc"
                                        self.addtocart(sizeid: self.sizeid, colourid: self.colourid, itemid: self.itemid)
                                        
                                    }
                                }
                                
                            }
                        }
                        
                        
                    case .failure(let error):
                        print(error)
                    }
                }
                
                
                
            }
     //   }
        
    }
    
    
    @IBAction func atcChanged(_ sender: TKSimpleSwitch) {
        if atcSwitch.isOn == true {
            startATC()
        } else {
            self.supremeView.stopLoading()
            let url = URL (string: "http://www.supremenewyork.com/mobile/#categories/new")
            let requestObj = URLRequest(url: url!);
            supremeView.loadRequest(requestObj)
            supremeView.reload()
        }
        
        // add captcha alert
    }

    
    func count() {
        if capSwitch.isOn == true {
            if counter == 30 {
                print(capArray)
                print(capArray.count)
                startCaptcha()
            }
            if counter < 100 {
                counter = Int(counter) + 1
                print(counter!)
            } else {
                //   self.capLabel.text = "❌"
                timer.invalidate()
                counter = 0
                if capArray.count > 0 {
                    capArray.remove(at: 0)
                    print(capArray)
                    print(capArray.count)
                }
                startCaptcha()
            }
        } else {
            if counter < 100 {
                counter = Int(counter) + 1
            } else {
                if capArray.count > 0 {
                    capArray.removeAll()
                    self.capLabel.text = "❌"
                    timer.invalidate()
                    counter = 0
                }
            }
        }
    }
    
    func startcount() {
        if counter == 0 {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: "count", userInfo: nil, repeats: true)
        }
    }
    
    
    @IBAction func switchChanged(_ sender: TKSimpleSwitch) {
        startCaptcha()
    }
    
    
    func startCaptcha() {
        self.startcount()
        if capSwitch.isOn == true {
            
            status = "started"
            
            let urlString = "http://api.anti-captcha.com/createTask"
            
            
            let body = "{ \n \"clientKey\":\"a32bf1c61530c20cf868a65c1dceefbe\", \n \"task\": \n { \n \"type\":\"NoCaptchaTaskProxyless\", \n \"websiteURL\":\"http://supremenewyork.com/checkout\", \n \"websiteKey\": \n \"6LeWwRkUAAAAAOBsau7KpuC9AV-6J8mhw4AjC3Xz\" \n } \n }"
            
            let url = URL(string: urlString)!
            let jsonData = body.data(using: .utf8, allowLossyConversion: false)!
            
            var request1 = URLRequest(url: url)
            request1.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request1.httpBody = jsonData
            request1.httpMethod = "POST"
            
        if capSwitch.isOn == true {

            Alamofire.request(request1).responseJSON {
                response in
                switch response.result {
                case .success:
                    print(response)
                    var taskID = String(describing: response)
                    if let start = taskID.range(of: "taskId = "),
                        let end  = taskID.range(of: ";", range: start.upperBound..<taskID.endIndex) {
                        self.capLabel.text = "..."
                        
                        let substring = taskID[start.upperBound..<end.lowerBound]
                        print(substring)
                        
                        let body = "{ \n \"clientKey\":\"a32bf1c61530c20cf868a65c1dceefbe\", \n \"taskId\":\(substring) \n }"
                        print(body)
                        
                        let capurl = URL(string: "https://api.anti-captcha.com/getTaskResult")!
                        let jsonData = body.data(using: .utf8, allowLossyConversion: false)!
                        
                        var request2 = URLRequest(url: capurl)
                        request2.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                        request2.httpBody = jsonData
                        request2.httpMethod = "POST"
                        
                        if self.capSwitch.isOn == true {

                            func getToken() {
                                self.capLabel.text = ""
                                self.capIndicator.startAnimating()
                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
                                    Alamofire.request(request2).responseJSON { response in
                                        print(response)
                                        var token = String(describing: response)
                                        if token.range(of: "solution") != nil {
                                            if let start = token.range(of: "gRecaptchaResponse = \""),
                                                let end  = token.range(of: "\";", range: start.upperBound..<token.endIndex) {
                                                token = token[start.upperBound..<end.lowerBound]
                                                print(token)
                                                self.capLabel.text = "✅"
                                                self.capIndicator.stopAnimating()
                                           //     self.gtoken = token
                                                self.capArray!.append(token)
                                                self.gtoken = self.capArray[0]
                                                print(self.capArray)
                                                print(self.capArray.count)
                                         //       self.startcount()
                                            }
                                        } else {
                                            getToken()
                                        }
                                    }
                                })
                            }
                            getToken()
                        } else {
                            print("invalid input")
                        }
                    }
                    
                    
                    break
                case .failure(let error):

                    print(error)
                }
                }
            }
        }
        
    }
    
    func addtocart(sizeid: String!, colourid: String!, itemid: String!) {
        
        let current = String(describing: supremeView.request)

        if onoff == "true" {
            
           // skrrr = 1
            
            let request = NSMutableURLRequest(url: NSURL(string: "http://www.supremenewyork.com/mobile/#products/\(itemid!)")! as URL)
            supremeView.loadRequest(request as URLRequest)
            
            
            
            if skrrr == 0 {
                    skrrr = 1
                print("#products")

                }
            
            onoff = "false"

        }
 
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        if atcstarted == true {
            if noitem == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(600), execute: {
                    self.startATC()
                })
            }

        }
        
        print("DID LOAD")
        
        let current = String(describing: supremeView.request)
        print(current)
        
        if colourid != nil {
            atcstatus = "item"
            supremeView.stringByEvaluatingJavaScript(from: "var colourid = '\(colourid!)'; \n var size = '\(sizeid!)';")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.supremeView.stringByEvaluatingJavaScript(from: self.jsfile)
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    self.supremeView.stringByEvaluatingJavaScript(from: "window.location.hash = 'checkout';")
                })
            })
        }
        
        if current.range(of: "checkout") != nil {
            if gtoken == nil {
                supremeView.stringByEvaluatingJavaScript(from: "function test2() { \n $('#order_billing_country')['val']('\(country!)'); \n $('#order_billing_state')['val']('\(state!)'); \n $('#order_billing_name')['val']('\(firstname!)'); \n $('#order_email')['val']('\(email!)'); \n $('#order_tel')['val']('\(number!)'); \n $('#order_billing_address')['val']('\(address!)'); \n $('#order_billing_city')['val']('\(city!)'); \n $('#order_billing_zip')['val']('\(zipcode!)'); \n $('#credit_card_type')['val']('\(card!)'); \n $('#credit_card_n')['val']('\(cardnum!)'); \n $('#credit_card_month')['val']('\(expmonth!)'); \n $('#credit_card_year')['val']('\(expyear!)'); \n $('#credit_card_cvv')['val']('\(CVV!)'); \n $('#order_terms')['prop']('checked', true); \n $('#submit_button').trigger('click'); \n }")
                
                supremeView.stringByEvaluatingJavaScript(from: "function test1() \n { \n $('#submit_button').trigger('click'); \n }")
                if boolauto == "true" {
                    supremeView.stringByEvaluatingJavaScript(from: "setTimeout(test2, \(cd!));")
                }
            } else {
            supremeView.stringByEvaluatingJavaScript(from: "function test2() { \n document.getElementById(\"g-recaptcha-response\").innerHTML=\"\(gtoken!)\"; \n $('#order_billing_country')['val']('\(country!)'); \n $('#order_billing_state')['val']('\(state!)'); \n $('#order_billing_name')['val']('\(firstname!)'); \n $('#order_email')['val']('\(email!)'); \n $('#order_tel')['val']('\(number!)'); \n $('#order_billing_address')['val']('\(address!)'); \n $('#order_billing_city')['val']('\(city!)'); \n $('#order_billing_zip')['val']('\(zipcode!)'); \n $('#credit_card_type')['val']('\(card!)'); \n $('#credit_card_n')['val']('\(cardnum!)'); \n $('#credit_card_month')['val']('\(expmonth!)'); \n $('#credit_card_year')['val']('\(expyear!)'); \n $('#credit_card_cvv')['val']('\(CVV!)'); \n $('#order_terms')['prop']('checked', true); \n $('#submit_button').trigger('click'); \n }")
    
            supremeView.stringByEvaluatingJavaScript(from: "function test1() \n { \n $('#submit_button').trigger('click'); \n }")
            if boolauto == "true" {
                supremeView.stringByEvaluatingJavaScript(from: "setTimeout(test2, \(cd!));")
            }
        }
            atcstatus = "idle"
            atcstarted = false
         //   capSwitch.setOn(false)
        // atcSwitch.setOn(false)
        }

        /*
        
        print("DIDLOAD")
        let current = String(describing: supremeView.request)
        

        if current.range(of: "#products") != nil {
            if skrrr == 0 {
            skrrr = 1
            print("#products")
            supremeView.stringByEvaluatingJavaScript(from: "var colourid = '\(colourid!)'; \n var size = '\(sizeid!)';")

            supremeView.stringByEvaluatingJavaScript(from: jsfile)
            supremeView.stringByEvaluatingJavaScript(from: "window.location.hash = 'checkout';")


            }
            
        if current.range(of: "checkout") != nil {
            supremeView.stringByEvaluatingJavaScript(from: jssize)
        }
            
    }
        
        
        print("ON OFF" + onoff)
        print(current)

        HTTPCookieStorage.shared.cookieAcceptPolicy = HTTPCookie.AcceptPolicy.always

        
        if current.range(of:"checkout") != nil{
            supremeView.stringByEvaluatingJavaScript(from: "$('#order_billing_country')['val']('\(country!)'); \n $('#order_billing_state')['val']('\(state!)'); \n $('#g-recaptcha').remove(); \n $('#order_billing_name')['val']('\(firstname!)'); \n $('#order_email')['val']('\(email!)'); \n $('#order_tel')['val']('\(number!)'); \n $('#order_billing_address')['val']('\(address!)'); \n $('#order_billing_city')['val']('\(city!)'); \n $('#order_billing_zip')['val']('\(zipcode!)'); \n $('#credit_card_type')['val']('\(card!)'); \n $('#credit_card_n')['val']('\(cardnum!)'); \n $('#credit_card_month')['val']('\(expmonth!)'); \n $('#credit_card_year')['val']('\(expyear!)'); \n $('#credit_card_cvv')['val']('\(CVV!)'); \n $('#order_terms')['prop']('checked', true);")
            supremeView.stringByEvaluatingJavaScript(from: "function test1() \n { \n $('#submit_button').trigger('click'); \n }")
        if boolauto == "true" {
            supremeView.stringByEvaluatingJavaScript(from: "setTimeout(test1, \(cd!));")
        }
    }

    */

        
    /*
        
    if noloop == 0 {
        
    if current.range(of: "new") != nil {
                print(category)
        supremeView.stringByEvaluatingJavaScript(from: "var cat = allCategoriesAndProducts.products_and_categories.\(category!);")
        let suptest = supremeView.stringByEvaluatingJavaScript(from: "for(var i in cat) { \n var string = cat[i].name; \n if (string.includes('Tagless')) { \n var productid = cat[i].id \n var gotoproduct = 'http://www.supremenewyork.com/shop/' + productid + '.json'; \n window.location.href = gotoproduct \n } \n }")
        self.itemid = supremeView.stringByEvaluatingJavaScript(from: "productid")
        self.itemid = String(describing: itemid!)
        var newurl = "http://www.supremenewyork.com/shop/\(itemid!).json"
        
        
        let headers: HTTPHeaders = [
            "User-Agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 10_2 like Mac OS X) AppleWebKit/602.3.12 (KHTML, like Gecko) Mobile/14C92",
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "X-HTTP-Method-Override": "GET",
            "X-Requested-With": "XMLHttpRequest",
            "Referer": "http://www.supremenewyork.com/mobile/"
        ]
        
        // GET Request
        Alamofire.request(newurl, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                // Style = Colour
                let style = json["styles"]
                let styles = style.count
                
                // Go through each colour, check if it matches user search
                for i in 0...styles {
                    if self.colour.lowercased() == style[i]["name"].stringValue.lowercased() {
                        self.colourid = style[i]["id"].stringValue
                        // Get each size available from matched style
                        let sizejson = style[i]["sizes"]
                        let sizes = sizejson.count as Int
                        // Go through each size, check if it matches user search
                        for i in 0...sizes {
                            if self.size.lowercased() == sizejson[i]["name"].stringValue.lowercased() {
                                self.sizeid = sizejson[i]["id"].stringValue
                                self.onoff = "true"
                                self.noloop = 1
                                self.addtocart(sizeid: self.sizeid, colourid: self.colourid, itemid: self.itemid)

                            }
                        }

                    }
                }
                
      
            case .failure(let error):
                print(error)
            }
        }
        
        
        
    }
        }
        
    func loadCheckout(cookie: String) {
        
        let headers: HTTPHeaders = [
            "User-Agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 10_2 like Mac OS X) AppleWebKit/602.3.12 (KHTML, like Gecko) Mobile/14C92",
            "Accept": "text/html",
            "Accept-Encoding": "gzip, deflate, sdch",
            "Accept-Language": "en-US,en;q=0.8",
            "X-HTTP-Method-Override": "POST",
            "X-Requested-With": "XMLHttpRequest",
            "Referer": "http://www.supremenewyork.com/mobile/",
            "Cookie": "hasShownCookieNotice=1; \(cookie) lastVisitedFragment=checkout",
            "If-None-Match": "W/\"c08db5910ebaba177679f61ac4d0d165\""
        ]
        
        let parameters: Parameters = [
            
            "store_credit_id": "",
            "from_mobile": "1",
            "cookie-sub": "%7B%22+str(variant)+%22%3A1%7D",
            "same_as_billing_address": "1",
            "order[billing_name]": self.firstname,
            "order[email]": self.email,
            "order[tel]": self.number,
            "order[billing_address]": self.address,
            "order[billing_address_2]": "",
            "order[billing_zip]": self.zipcode,
            "order[billing_city]": self.city,
            "order[billing_state]": self.state,
            "order[billing_country]": self.country,
            "store_address": "1",
            "credit_card[type]": self.cardtype,
            "credit_card[cnb]": self.cardnum,
            "credit_card[month]": self.expmonth,
            "credit_card[year]": self.expyear,
            "credit_card[vval]": self.CVV,
            "order[terms]": "0",
            "g-recaptcha-response": "",
            "is_from_ios_native": "1",
 
        ]
        
        Alamofire.request("http://supremenewyork.com/checkout.json", method: .post, parameters: parameters, headers: headers).validate().responseString { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let data = response.data
                let utf8Text = String(data: data!, encoding: .utf8)
                self.supremeView.loadHTMLString(utf8Text!, baseURL: URL(string: "http://supremenewyork.com/mobile/checkout")!)
                
            case .failure(let error):
                print(error)
            }
        
        

        
        }
        
        

        */
        
        
        /*
        let url = URL(string: "http://www.supremenewyork.com/checkout/totals_mobile.js?order%5Bbilling_country%5D=GB&cookie-sub=%257B%257D&mobile=true")!
        

        
        var requestObj = URLRequest(url: url)
 
        requestObj.httpMethod = "GET"
        requestObj.httpShouldHandleCookies = true

        requestObj.addValue("www.supremenewyork.com", forHTTPHeaderField: "Host")
        requestObj.addValue("www.supremenewyork.com", forHTTPHeaderField: "Origin")
        requestObj.addValue("text/html", forHTTPHeaderField: "Accept")
        requestObj.addValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        requestObj.addValue("gzip, deflate, sdch", forHTTPHeaderField: "Accept-Encoding")
        requestObj.addValue("en-US,en;q=0.8", forHTTPHeaderField: "Accept-Language")
        requestObj.addValue("http://www.supremenewyork.com/mobile", forHTTPHeaderField: "Referer")
        requestObj.addValue("Mozilla/5.0 (iPhone; CPU iPhone OS 10_2 like Mac OS X) AppleWebKit/602.3.12 (KHTML, like Gecko) Mobile/14C92", forHTTPHeaderField: "User-Agent")
        requestObj.addValue("W/\"c08db5910ebaba177679f61ac4d0d165\"", forHTTPHeaderField: "If-None-Match")
        requestObj.addValue("hasShownCookieNotice=1; \(cookie) lastVisitedFragment=checkout", forHTTPHeaderField: "Cookie")
        
    
        if loadreq == true {
            loadreq = false
            self.supremeView.loadRequest(requestObj)
            }
 
        
        }
         */

    
        /*
        if current.range(of: "product") == nil {
            supremeView.stringByEvaluatingJavaScript(from: "var count = 0 \n function repage() { \n if (count == 0) { \n if (document.getElementById('product-nav')) { \n count = 1 \n location.reload() \n } \n } \n clearInterval(); \n }; \n setInterval(repage, 100);")

        }
*/
/*
        supremeView.stringByEvaluatingJavaScript(from: "for(var i in allCategoriesAndProducts.products_and_categories.Accessories) { \n  var string = allCategoriesAndProducts.products_and_categories.Accessories[i].name; \n  if (string.includes('Tagless Tees')) { \n var productid = allCategoriesAndProducts.products_and_categories.Accessories[i].id \n var gotoproduct = 'http://www.supremenewyork.com/mobile/#products/' + productid; \n window.location.href = gotoproduct \n } \n }")

        supremeView.stringByEvaluatingJavaScript(from: "$('#submit_button').trigger('click')")
        supremeView.stringByEvaluatingJavaScript(from: "function submitthing () { \n $('#submit_button').trigger('click') \n }")
        supremeView.stringByEvaluatingJavaScript(from: "setTimeout('submitthing()', \(cd));")
*/

    
    }

    @IBAction func refreshButton(_ sender: AnyObject) {
        supremeView.reload()
    }

    @IBAction func showInfo(_ sender: Any) {
        let alertController = UIAlertController(title: "Current Info", message: "Name: \(firstname!) \n E-Mail: \(email!) \n Number: \(number!) \n Address: \(address!) \n ZIP: \(zipcode!) \n City: \(city!) \n State: \(state!) \n Country: \(country!) \n \n Card Type: \(card!) \n Checkout Delay: \(cd!) \n Auto Checkout: \(boolauto!) \n Category: \(category!) \n Size: \(size!) \n Keyword(s) \(keyword!) \n Colour: \(colour!) \n Auto ATC: \(onoff!)", preferredStyle: .alert)
        
        
        let OKAction = UIAlertAction(title: "Cool", style: .default) { action in }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true) {}
    }
}


