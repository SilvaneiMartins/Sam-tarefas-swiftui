//
//  Note.swift
//  SamNotes
//
//  Created by Silvanei  Martins on 27/04/24.
//

import SwiftUI

struct Note: Identifiable {
    var id = UUID().uuidString
    var note: String
    var date: Date
    var cardColor: Color
}

func getSampleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    let date = calendar.date(bySetting: .day, value: offset, of: Date())
    return date ?? Date()
}

var notes: [Note] = [
    Note(note: "O início dos trabalhos de UI de design sem tela a serem realizados.", date: getSampleDate(offset: 1), cardColor: Color("Yellow")),
    
    Note(note: "13 coisas das quais você deve desistir se quiser ser um designer UX de sucesso.", date: getSampleDate(offset: -10), cardColor: Color("Purple")),
    
    Note(note: "Os princípios psicológicos que todo designer de UI/UX precisa conhecer.", date: getSampleDate(offset: -15), cardColor: Color("Green")),
    
    Note(note: "53 termos de pesquisa que você precisa conhecer como designer de UX.", date: getSampleDate(offset: 10), cardColor: Color("Blue")),
    
    Note(note: "10 lições de UI e UX do design do meu produto.", date: getSampleDate(offset: 1), cardColor: Color("Orange")),
]
