//
//  ContactsView.swift
//  Contacts
//
//  Created by Noura Alowayid on 18/11/1444 AH.
//

import SwiftUI
import Firebase

struct ContactsView: View {
    
    @ObservedObject private var viewModel = ContactViewModel()
    @State private var showModal = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(viewModel.contacts) { contact in
                    HStack() {
                        Text(contact.firstName ?? "")
                            .font(.title3)
                        Text(contact.lastName ?? "")
                            .font(.title3).bold()
                    }
                }
            }.onAppear() {
                self.viewModel.fetchData()
                
            }
            .navigationTitle("Contacts")
            .navigationBarItems(trailing:
                                    Button(action: {
                self.showModal = true
            }) {
                VStack {
                    Image(systemName: "plus")
                    
                }
            }
                .sheet(isPresented: self.$showModal, onDismiss: {  }) {
                    NewContactView(showModal: self.$showModal)
                })
            .navigationBarTitle(Text("Add New"), displayMode: .inline)
            .searchable(text: $searchText) {
                ForEach(viewModel.contacts.filter { $0.firstName!.contains(searchText) || $0.lastName!.contains(searchText) }, id: \.id) { contact in
                    HStack() {
                        Text(contact.firstName ?? "")
                            .font(.title3)
                        Text(contact.lastName ?? "")
                            .font(.title3).bold()
                    }
                }
            }
        }
    }
}
struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}

