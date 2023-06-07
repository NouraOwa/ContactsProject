//
//  ContactsModel.swift
//  Contacts
//
//  Created by Noura Alowayid on 18/11/1444 AH.
//

import Foundation
struct Contact: Codable, Identifiable {
    var id: String = UUID().uuidString
    var firstName: String?
    var lastName: String?
    var company: String?
    var phone: String?
    var email: String?
}
