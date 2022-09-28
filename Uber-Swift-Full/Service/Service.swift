//
//  Service.swift
//  Uber-Swift-Full
//
//  Created by hakkı can şengönül on 28.09.2022.
//

import FirebaseDatabase
import FirebaseAuth
let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
struct Service{
    static let currentUid = Auth.auth().currentUser?.uid
    static func fetchUserData(completion: @escaping(User) -> Void) {
        REF_USERS.child(currentUid!).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else{ return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
}
