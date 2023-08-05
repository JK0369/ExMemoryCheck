//
//  ViewController.swift
//  ExMemoryHeapStack
//
//  Created by 김종권 on 2023/08/05.
//

import UIKit

struct StructA {
    let a = 0
}

class ClassA {
    var a = 0
}

struct StructNestedClass {
    var a = ClassA()
}

struct ClassNestedStruct {
    var a = StructA()
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ex) String 타입
//        var stringValue = "iOS 앱 개발 알아가기 - string은 과연 stack에 저장될까? heap에 저장될까?"
//        var stringValue2 = stringValue
//
//        printMemoryAddress(&stringValue) // 0x000000016b8a78c8
//        printMemoryAddress(&stringValue2) // 0x000000016b8a78b8
        
        // ex) struct 타입
//        var structValue = StructA()
//        printMemoryAddress(&structValue) // 0x000000016af9f8d0
        
        // ex) class타입
//        var classInstance = ClassA()
//        printMemoryAddress(&classInstance) // reference 주소: 0x000000016b97b8c0
//        printHeapMemoryAddress(classInstance) // 실제 주소: 0x0000000128956c50
        
        // ex) class타입을 가지고 있는 struct 타입 메모리 주소
//        var structValueNestedClass = StructNestedClass()
//        printMemoryAddress(&structValueNestedClass) // 주소: 0x000000016dcbb8d0
//        printMemoryAddress(&(structValueNestedClass.a)) // reference 주소: 0x000000016dcbb8d0
//        printHeapMemoryAddress(structValueNestedClass) // (crash: struct는 class타입이 아니므로)
//        printHeapMemoryAddress(structValueNestedClass.a) // 주소: 0x0000000153c26710
        
        // ex) struct타입을 가지고 있는 class 타입 메모리 주소
        var classNestedStruct = ClassNestedStruct()
        printMemoryAddress(&classNestedStruct) // 주소: 0x000000016d1c78d0
        printMemoryAddress(&(classNestedStruct.a)) // 주소: 0x000000016d1c78d0
        printHeapMemoryAddress(classNestedStruct) // (crash: class인스턴스 값 자체가 heap에 존재하지 않음)
        printHeapMemoryAddress(classNestedStruct.a) // (crash: a는 struct이므로 heap에 존재 x)
        printMemoryAddressObject(classNestedStruct) // 주소: 0x000000016d1c78c8
        printMemoryAddressObject(classNestedStruct.a) // 주소: 0x000000016d1c78c0
    }
}

func printMemoryAddress<T>(_ o: inout T) {
    withUnsafePointer(to: &o) { print($0) }
}

func printMemoryAddressObject<T>(_ o: T) {
    withUnsafePointer(to: o) { print($0) }
}

func printHeapMemoryAddress<T>(_ o: T) {
    let pointer = UnsafeMutableRawPointer(mutating: Unmanaged.passUnretained(o as AnyObject).toOpaque())
    print(pointer)
}
