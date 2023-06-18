//
//  Post.swift
//  AniDuvarim
//
//  Created by Fatih Karahan on 18.06.2023.
//

import Foundation
class Post{
    var email : String
    var yorum : String
    var gorselUrl : String
    
    init(email : String, yorum : String, gorselUrl : String) {
        self.email = email
        self.gorselUrl = gorselUrl
        self.yorum = yorum
    }
}
