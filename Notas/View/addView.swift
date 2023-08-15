//
//  addView.swift
//  Notas
//
//  Created by Raquel on 11/8/23.
//

import SwiftUI

struct addView: View {
    
    @ObservedObject var model : ViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack{
            Text(model.updateItem != nil ? "Editar Nota" : "Agregar Nota")
                .font(.largeTitle)
                .bold()
            Spacer()
            TextEditor(text: $model.nota)
            Divider()
            DatePicker("Seleccionar fecha", selection: $model.fecha)
            Spacer()
            Button(action: {
                if model.updateItem != nil {
                    model.updateData(context: context)
                } else {
                    model.saveData(context: context)
                }
            }){
                Label(
                    title: {Text("Guardar")
                        .foregroundColor(.white)
                        .bold()},
                    icon: {Image(systemName: "plus").foregroundColor(.white)}
                )
            }.padding()
                .frame(width: UIScreen.main.bounds.width - 30)
                .background(model.nota == "" ? Color.gray : Color.blue)
                .cornerRadius(8)
                .disabled(model.nota == "" ? true : false)
        }.padding()
    }
}
