//
//  Observer.swift
//  listwithsearch
//
//  Created by putra rolli on 09/10/22.
//

import Foundation
import Alamofire

class Observer : ObservableObject{
    @Published var title = [ListData]()

    init() {
        getTitle()
    }
    
    func getTitle(count: Int = 5)
    {
        AF.request("http://api.icndb.com/jokes/random/\(count)")
            .responseJSON{
                response in
                if let json = response.result.value {
                    if  (json as? [String : AnyObject]) != nil{
                        if let dictionaryArray = json as? Dictionary<String, AnyObject?> {
                            let jsonArray = dictionaryArray["value"]

                            if let jsonArray = jsonArray as? Array<Dictionary<String, AnyObject?>>{
                                for i in 0..<jsonArray.count{
                                    let json = jsonArray[i]
                                    if let id = json["id"] as? Int, let titleString = json["title"] as? String{
                                    self.title.append(ListData(id: id, title: titleString))
                                    }
                                }
                            }
                        }
                    }
                }
        }
    }
}
