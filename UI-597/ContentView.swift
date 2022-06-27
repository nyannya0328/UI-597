//
//  ContentView.swift
//  UI-597
//
//  Created by nyannyan0328 on 2022/06/27.
//

import SwiftUI

struct ContentView: View {
    @State var generatedImage : Image?
    @State var generatedPDF : URL?
    
    @State var showShareLink : Bool = false
    var body: some View {
        GeometryReader{proxy in
            
             let size = proxy.size
            ZStack(alignment:.top){
                
           
                Home()
                
                HStack(spacing:20){
                    
                    
                    if let generatedImage{
                        
                        ShareLink(item: generatedImage,preview:SharePreview( "A")){
                            
                            Image(systemName: "arrow.up.doc")
                        }
                     
                        
                        
                        
                    }
                    
                  
                    
                    
                    if let _ = generatedPDF{
                        
                        Button {
                            showShareLink.toggle()
                            
                        } label: {
                            
                           Image(systemName: "square.and.arrow.up")
                        }

                        
                    }
                    
                   

                    
                }
                .padding()
                .font(.system(size: 30))
                .foregroundColor(.purple)
                .frame(maxWidth: .infinity,alignment: .trailing)
                
                
                
           
            }
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .onAppear{
                  
                  renderView(viewSize: size)
              }
            
        }
        .sheet(isPresented: $showShareLink) {
            
            if let generatedPDF{
                
                sharelink(items: [generatedPDF])
            }
        }
    
    }
    @MainActor
    func renderView(viewSize : CGSize){
        
        
        let rendar = ImageRenderer(content: Home().frame(width:viewSize.width,height: viewSize.height))
        
        if let image = rendar.uiImage{
            
            generatedImage = Image(uiImage: image)
        }
        
        let tempURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        
        let renderURL = tempURL.appending(path: "\(UUID().uuidString).pdf")
        
        if let conumer = CGDataConsumer(url: renderURL as CFURL),let contex = CGContext(consumer: conumer, mediaBox: nil, nil){
            
            
            rendar.render { size, render in
                
                var mailBox = CGRect(origin: .zero, size: size)
                contex.beginPage(mediaBox: &mailBox)
                render(contex)
                contex.endPDFPage()
                contex.closePDF()
                
                generatedPDF = renderURL
            }
            
            
        }
        
        
        
        
        
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct sharelink : UIViewControllerRepresentable{
    
    var items : [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        
        let view = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        return view
        
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
        
    }
}
