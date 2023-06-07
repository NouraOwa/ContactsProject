//
//  NewContactView.swift
//  Contacts
//
//  Created by Noura Alowayid on 18/11/1444 AH.
//

import SwiftUI

struct NewContactView: View {
    @Binding var showModal: Bool
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var company: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    @State var emailIsValid: Bool = true
    
    @ObservedObject private var viewModel = ContactViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                Image(systemName: "person.circle.fill" )
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.secondary)
                Button("Add Photo"){}
                Form {
                    Section(header: Text("")) {
                        TextField("First name", text: $firstName)
                        TextField("Last name", text: $lastName)
                        TextField("Company", text: $company)
                    }
                    Section() {
                        TextField("add phone", text: $phone)
                            .keyboardType(.numberPad)
                    }
                    Section() {
                        TextField("add email", text: $email)
                            .foregroundColor(emailIsValid ? Color.black : Color.red)
                            .disableAutocorrection(true)
                            .onChange(of: email) { newValue in
                                
                                if(newValue.range(of:"^\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$", options: .regularExpression) != nil) {
                                    
                                    self.emailIsValid = true
                                    
                                    print("valid")
                                    
                                } else {
                                    
                                    self.emailIsValid = false
                                    
                                    print("invalid")
                                    
                                }
                                
                            }
                        
                    }
                    
                    Section() {
                        Button(action: {
                            self.viewModel.addData(firstName: firstName, lastName: lastName, company: company, phone: phone, email: email)
                        }) {
                            HStack{
                                Text("Add Contact")
                            }
                            .padding()
                            .foregroundColor(.white).bold()
                            .background(Color.secondary)
                            .cornerRadius(30)
                            .padding(.leading,90)
                            
                        }
                    }
                }
                .navigationTitle("New Contact")
            }
        }
    }
}

