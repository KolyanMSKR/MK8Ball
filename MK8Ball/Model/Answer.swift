//
//  Answer.swift
//  MK8Ball
//
//  Created by Mykola Korotun on 15.10.2021.
//

import Foundation

struct Answer: Decodable {
    let magic: Magic
}

struct Magic: Decodable {
    let answer: String
}
