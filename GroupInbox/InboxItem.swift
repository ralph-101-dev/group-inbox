//
//  InboxItem.swift
//  GroupInbox
//
//  Created by 정지승 on 2023/09/12.
//

import Foundation

struct InboxItem {
    let id: String
    let title: String
    let message: String
}

struct InboxGroup {
    let groupId: String
    let items: [InboxItem]
    
    static let mock: [InboxGroup] = [
        .init(groupId: "A", items: [
            .init(id: UUID().uuidString, title: "Instagram", message: "1오늘 가장 많이 시청된 릴스를 확인해보세요."),
            .init(id: UUID().uuidString, title: "Instagram", message: "2오늘 가장 많이 시청된 릴스를 확인해보세요."),
            .init(id: UUID().uuidString, title: "Instagram", message: "3오늘 가장 많이 시청된 릴스를 확인해보세요."),
            .init(id: UUID().uuidString, title: "Instagram", message: "4오늘 가장 많이 시청된 릴스를 확인해보세요."),
        ]),
        .init(groupId: "B", items: [
            .init(id: UUID().uuidString, title: "카카오톡", message: "[기기 로그인 알림1]"),
            .init(id: UUID().uuidString, title: "카카오톡", message: "[기기 로그인 알림2]"),
            .init(id: UUID().uuidString, title: "카카오톡", message: "[기기 로그인 알림3]"),
            .init(id: UUID().uuidString, title: "카카오톡", message: "[기기 로그인 알림4]"),
        ]),
        .init(groupId: "C", items: [
            .init(id: UUID().uuidString, title: "근처에 토스를 켠 사람이 있어요", message: "지금 눌러서 확인하기1"),
            .init(id: UUID().uuidString, title: "근처에 토스를 켠 사람이 있어요", message: "지금 눌러서 확인하기2"),
            .init(id: UUID().uuidString, title: "근처에 토스를 켠 사람이 있어요", message: "지금 눌러서 확인하기3"),
            .init(id: UUID().uuidString, title: "근처에 토스를 켠 사람이 있어요", message: "지금 눌러서 확인하기4"),
        ]),
        .init(groupId: "D", items: [
            .init(id: UUID().uuidString, title: "근처에 토스를 켠 사람이 있어요", message: "지금 눌러서 확인하기1"),
            .init(id: UUID().uuidString, title: "근처에 토스를 켠 사람이 있어요", message: "지금 눌러서 확인하기4"),
        ]),
        .init(groupId: "E", items: [
            .init(id: UUID().uuidString, title: "근처에 토스를 켠 사람이 있어요", message: "지금 눌러서 확인하기1"),
            .init(id: UUID().uuidString, title: "근처에 토스를 켠 사람이 있어요", message: "지금 눌러서 확인하기2"),
            .init(id: UUID().uuidString, title: "근처에 토스를 켠 사람이 있어요", message: "지금 눌러서 확인하기4"),
        ]),
        .init(groupId: "F", items: [
            .init(id: UUID().uuidString, title: "근처에 토스를 켠 사람이 있어요", message: "지금 눌러서 확인하기1"),
        ]),
    ]
}
