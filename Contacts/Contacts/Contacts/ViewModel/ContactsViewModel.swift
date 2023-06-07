//
//  ContactsViewModel.swift
//  Contacts
//
//  Created by Noura Alowayid on 18/11/1444 AH.
//

import Foundation
import FirebaseFirestore
class ContactViewModel: ObservableObject {
    
    @Published var contacts = [Contact]()
    private var db = Firestore.firestore()
    
    
    func fetchData() {
        db.collection("contacts").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.contacts = documents.map { (queryDocumentSnapshot) -> Contact in
                let data = queryDocumentSnapshot.data()
                let firstName = data["firstName"] as? String ?? ""
                let lastName = data["lastName"] as? String ?? ""
                let company = data["company"] as? String ?? ""
                let phone = data["phone"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                return Contact(firstName: firstName, lastName: lastName, company: company, phone: phone, email: email)
            }
        }
    }
    
    func addData(firstName: String, lastName: String, company: String, phone: String, email: String) {
        db.collection("contacts").addDocument(data: ["firstName": firstName, "lastName": lastName, "company": company, "phone": phone, "email": email ]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
}
