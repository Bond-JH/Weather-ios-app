//
//  ContentView.swift
//  Weather
//
//  Created by 杨家豪 on 2025/9/25.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = " "
    @State private var errorMessage:String?
    var body: some View {
        NavigationStack{
            VStack{
                ContentUnavailableView(errorMessage ?? "Please type a city above and press enter",systemImage: "magnifyingglass")
                
            }
        }
        .searchable(text: $searchText, prompt: Text("City Name"))
        .onSubmit(of: .search){
            let apiKey = "dc922e9bfcb53527bbb6302707c8b827"
            guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(searchText)&appid=\(apiKey)")else{
                print("Invalid URL")
                return
            }
            let session = URLSession.shared
            let task = session.dataTask(with: url){data,response,error in
                if let error {
                  print("Error: \(error.localizedDescription)")
                  return
                }
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else{
                    print("Invalid Response")
                    return
                }
                guard let data else {
                  print("No data received")
                  return
                }
                print(String(data: data, encoding: .utf8) ?? "")

            }
            task.resume()
            
        }
    }
}

#Preview {
    ContentView()
}
