//
//  ContentView.swift
//  Dummyapp
//
//  Created by G Yacobu on 26/02/26.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    @StateObject private var loginVM = LoginViewModel(networkHelper: NetworkHelper())
    @Environment(\.modelContext) private var context
    @State private var navigateToProduct = false
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    HStack (spacing: 16) {
                        Text("Email")
                            .frame(width: 90, alignment: .leading)
                        TextField("Enter Email ID", text: $loginVM.username)
                            .foregroundStyle(.brown)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.emailAddress)
                            .submitLabel(.next)
                            .focused($focusedField,equals: .email)
                    }
                    
                    HStack(spacing: 16) {
                        Text("Password")
                            .frame(width: 90, alignment: .leading)
                        
                        SecureField("********", text: $loginVM.password)
                            .foregroundStyle(.brown)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.default)
                            .submitLabel(.done)
                            .focused($focusedField,equals: .password)
                    }
                    
                    Button("Login") {
                        loginAction()
                    }
                    
                    .font(.title3)
                    .frame(maxWidth: .infinity, maxHeight: 45)
                    .background(Color.orange.opacity(0.6))
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                    .disabled(loginVM.username.isEmpty || loginVM.password.isEmpty)
                    
                }
                .foregroundStyle(.white)
                .padding()
                .background(Color.loginview)
                .cornerRadius(20)
                .padding(.horizontal, 20)
                
                // MARK:- Keyboard Submit Handling
                .onSubmit {
                    switch focusedField {
                    case .email:
                        focusedField = .password
                    case .password:
                        loginAction()
                    default:
                        break
                    }
                }
                
                .alert("Dummyapp", isPresented: $loginVM.isAlert) { 
                    Button("OK",role: .cancel) {
                        
                    }
                }message: {
                    Text(loginVM.errorMessage)
                }
            }
            .navigationDestination(isPresented: $navigateToProduct) { 
                ProductView()
            }
        }
        
    }
    
    private func loginAction() {
        
        Task {
            do {
                try await loginVM.loginAPI()
                for product in loginVM.prodcutsList {
                    let entity = ProductEntity(title: product.title, category: product.category, description: product.description, price: product.price, rating: product.rating, discountPercentage: product.discountPercentage, stock: product.stock)
                    context.insert(entity)
                }
                
                try context.save()
                print("Inserted Data successfully ✅ ")
                navigateToProduct = true
            }catch {
                loginVM.errorMessage = error.localizedDescription
                loginVM.isAlert = true
            }
            
        }
    }
    }


#Preview {
    LoginView()
}
