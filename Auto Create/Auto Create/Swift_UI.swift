//
//  Swift-UI.swift
//  Auto Create
//
//  Created by Gianmarco Lugaresi on 22/02/24.
//

import SwiftUI
import Foundation
import AppKit
import CoreServices
import SecurityFoundation
import Cocoa

struct Swift_UI: View {
    @State private var isActive = false
    @State private var isClicked = 0
    @State private var folderName: String = ""
    @State private var folderPath1: String?
    @State private var folderPath: String = ""
    
    var body: some View {
        
        VStack{
            if isClicked == 0 {
                
                VStack{
                    HStack{
                        Text("SwiftUI")
                            .fontWeight(.bold)
                            .padding(10)
                            .font(.title)
                        Text("project")
                            .padding(10)
                    }
                    .background(Color.orange)
                    .cornerRadius(8)
                    .padding(.top,-2)
                    
                }
                .foregroundColor(.white)
                .frame(width:300,height: 70)
                
                VStack{
                    
                    HStack{
                        Text("• Name:")
                            .padding(.top,-2)
                            .fontWeight(.bold)
                        TextEditor(text: ($folderName))
                            .cornerRadius(5)
                            .frame(width: 100, height: 20)
                            .font(.system(size: 18))
                    }
                    Spacer()
                    HStack{
                        Text("• Posizione:")
                            .padding(.top,-30)
                            .fontWeight(.bold)
                        Button("Choose"){
                            requestWritePermission()
                        }
                        .padding(12)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                        .buttonStyle(.borderless)
                        .foregroundColor(.black)
                        .padding(.top,-40)
                        
                        
                    }
                    Spacer()
                    HStack{
                        Button("Send"){
                            do {
                                try createDirectory(atPath: folderPath, withIntermediateDirectories: true, folderName: folderName)
                                let swiftContents = """
                                    import SwiftUI

                                    struct HomeView: View {
                                        var body: some View {
                                            Text("Hello, World!")
                                        }
                                    }

                                    #Preview {
                                        SwiftUIView()
                                    }
                                    """
                                let swift_data = swiftContents.data(using: .utf8)
                                try createFile(inDirectory: folderPath+"/"+folderName, withName: "ContetView.swift", contents: swift_data)
                                let swift1Contents = """
                                    import SwiftUI

                                    @main
                                    struct App: App {
                                        var body: some Scene {
                                            WindowGroup {
                                                HomeView()
                                                    
                                            }
                                        }
                                    }
                                    """
                                let swift1_data = swift1Contents.data(using: .utf8)
                                try createFile(inDirectory: folderPath+"/"+folderName, withName: "App.swift", contents: swift1_data)
                                exit(0)
                            }catch {
                                print("Errore generico: \(error)")
                            }
                            
                        }
                        Button("Refresh"){
                            withAnimation{
                                isClicked = 2
                            }
                        }
                    }
                    
                }
                .frame(width: 180,height:160)
                .padding(50)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                
            }
            else if isClicked == 2{
                HomeView()
                    .transition(.opacity)
            }
        }
        .padding(50)
        .frame(width:300, height: 350)
        .background(Color.white)
        .environment(\.colorScheme, .light)
        .cornerRadius(10)
    }
    func requestWritePermission() {
        let openPanel = NSOpenPanel()
        openPanel.message = "Seleziona la cartella di destinazione"
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.allowsMultipleSelection = false

        openPanel.begin { response in
            if response.rawValue == NSApplication.ModalResponse.OK.rawValue {
                let folderPath1 = openPanel.urls[0].path
                folderPath = String(describing:folderPath1)
            }
        }
    }

    func createDirectory(
        atPath folderPath: String,
        withIntermediateDirectories createIntermediates: Bool,
        folderName: String,
        attributes: [FileAttributeKey : Any]? = nil
    ) throws {
        let directoryPath = (folderPath as NSString).appendingPathComponent(folderName)

        try FileManager.default.createDirectory(
            atPath: directoryPath,
            withIntermediateDirectories: createIntermediates,
            attributes: attributes
        )
        
    }
    func createFile(inDirectory directory: String, withName fileName: String, contents data: Data?, attributes attr: [FileAttributeKey: Any]? = nil) throws {
        do {
            let filePath = (directory as NSString).appendingPathComponent(fileName)

            try data?.write(to: URL(fileURLWithPath: filePath), options: .atomic)
        } catch {
            print("Errore durante la creazione del file: \(error.localizedDescription)")
            throw error
        }
    }

        

    
}


#Preview {
    Swift_UI()
}
