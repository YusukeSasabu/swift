// RUN: %target-swift-emit-silgen -enable-sil-ownership  %s | %FileCheck %s
// RUN: %target-swift-emit-sil -enable-sil-ownership -verify %s

protocol BestFriend: class {
  init()
  static func create() -> Self
}

class Animal {
  required init(species: String) {}

  static func create() -> Self { return self.init() }
  required convenience init() { self.init(species: "\(type(of: self))") }
}

class Dog: Animal, BestFriend {}
// CHECK-LABEL: sil private [transparent] [thunk] @$S4main3DogCAA10BestFriendA2aDPxycfCTW
// CHECK:         [[SELF:%.*]] = apply
// CHECK:         unchecked_ref_cast [[SELF]] : $Animal to $Dog
// CHECK-LABEL: sil private [transparent] [thunk] @$S4main3DogCAA10BestFriendA2aDP6createxyFZTW
// CHECK:         [[SELF:%.*]] = apply
// CHECK:         unchecked_ref_cast [[SELF]] : $Animal to $Dog
