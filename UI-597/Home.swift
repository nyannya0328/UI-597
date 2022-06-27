//
//  Home.swift
//  UI-597
//
//  Created by nyannyan0328 on 2022/06/27.
//

import SwiftUI

struct Home: View {
    @Environment(\.self) var env
    var body: some View {
        VStack{
            
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
            
            LabeledContent {
                
                
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                
            } label: {
                
                Text("Hello, world!")
                
            }

            
       
        
            
            
            LabeledContent {
                
                
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                
            } label: {
                
                Text("Hello, world!")
                
            }

            
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
         
    
            Rectangle()
                .fill(env.colorScheme == .dark ? .black : .white)
           
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
