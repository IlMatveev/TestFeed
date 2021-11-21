//
//  Filter.swift
//  TestFeed
//
//  Created by Ilya Matveev on 22.11.2021.
//

import SwiftUI

struct Filter: View {
    var filter: PostFilter
    var period: PostPeriod?
    
    var selectFilter: (PostFilter, PostPeriod?) -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                self.selectFilter(.myMix, nil)
            }) {
                Text("MY MIX")
                    .foregroundColor(filter == .myMix ? .mint : .gray)
            }
            Spacer()
            Button(action: {
                self.selectFilter(.newest, nil)
            }) {
                Text("NEWEST")
                    .foregroundColor(filter == .newest ? .mint : .gray)
            }
            Spacer()
            Button(action: {
                self.selectFilter(.top, .lastYear)
            }) {
                Text("TOP")
                    .foregroundColor(filter == .top ? .mint : .gray)
            }
            Spacer()
        }
    }
}
