//
//  Home.swift
//  Notas
//
//  Created by Raquel on 11/8/23.
//

import SwiftUI

struct Home: View {
    
    @Environment(\.managedObjectContext) var context
    @StateObject var model = ViewModel()
    @FetchRequest(entity: Notas.entity(), sortDescriptors: [NSSortDescriptor(key: "fecha", ascending: true)], animation: .spring()) var results: FetchedResults<Notas>
    
    var body: some View {
        
        NavigationView{
            List{
                ForEach(results){ item in
                    VStack(alignment: .leading){
                        
                        Button(action: {
                            item.finished.toggle()
                        }) {
                            Text(item.nota ?? "")
                            .font(.title)
                            .bold()
                            .strikethrough(item.finished, color: Color.red)
                            
                        Text(item.fecha ?? Date(), style: .date)
                                .strikethrough(item.finished, color: Color.red)

                        }
                    }.contextMenu(ContextMenu(menuItems: {
                        Button(action: {
                            model.sendData(item: item)
                        }) {
                            Label(title:{ Text("Editar")}, icon: {
                                Image(systemName: "pencil")
                            })
                        }
                        Button(action: {
                            model.deleteData(item: item, context: context)
                        }) {
                            Label(title:{ Text("Eliminar")}, icon: {
                                Image(systemName: "trash")
                            })
                        }
                    }))
                }
                
            }.navigationBarTitle("Notas")
                .navigationBarItems(trailing:
                                        Button(action: {
                    model.resetData()
                    model.show.toggle()
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.blue)
                }).sheet(isPresented: $model.show, content: {
                                addView(model: model)
                            })
        }
    }
}
