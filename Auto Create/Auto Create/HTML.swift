//
//  HTML.swift
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

struct HTML: View {
    @State private var isActive = false
    @State private var isClicked = 0
    @State private var folderName: String = ""
    @State private var folderPath1: String?
    @State private var folderPath: String = ""
    @State private var path: String = ""
    var body: some View {
        
        VStack{
            if isClicked == 0 {
                
                VStack{
                    HStack{
                        Text("HTML")
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
                                try createDirectory(atPath: folderPath+"/"+folderName, withIntermediateDirectories: true, folderName: "css")
                                let CssContents = ""
                                let Css_data = CssContents.data(using: .utf8)
                                try createFile(inDirectory: folderPath+"/"+folderName+"/css", withName: "style.css", contents: Css_data)
                                try createDirectory(atPath: folderPath+"/"+folderName, withIntermediateDirectories: true, folderName: "html")
                                try createDirectory(atPath: folderPath+"/"+folderName, withIntermediateDirectories: true, folderName: "img")
                                try createDirectory(atPath: folderPath+"/"+folderName,
                                                    withIntermediateDirectories: true, folderName: "templates")
                                let IndexContents = ""
                                let Index_data = IndexContents.data(using: .utf8)
                                try createFile(inDirectory: folderPath+"/"+folderName+"/templates", withName: "index.html", contents: Index_data)
                                try createDirectory(atPath: folderPath+"/"+folderName,
                                                    withIntermediateDirectories: true, folderName: "js")
                                let JsContents = ""
                                let Js_data = JsContents.data(using: .utf8)
                                try createFile(inDirectory: folderPath+"/"+folderName+"/js", withName: "script.js", contents: Js_data)
                                let mainContents = """
                                    from flask import Flask, render_template
                                    import routes

                                    app = Flask(__name__)

                                    app.add_url_rule("/", view_func=routes.index_route)  # / è la home page

                                    app.add_url_rule("/video", view_func=routes.video_route)

                                    app.run(host="0.0.0.0", port=8000)
                                    """
                                let main_data = mainContents.data(using: .utf8)
                                try createFile(inDirectory: folderPath+"/"+folderName, withName: "main.py", contents: main_data)
                                
                                
                                exit(0)
                                
                            }  catch let error as LocalizedError {
                                print("Errore: \(error.localizedDescription)")
                            } catch {
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
        HTML()
    }

