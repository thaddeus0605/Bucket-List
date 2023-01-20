//
//  ContentView.swift
//  Bucket List
//
//  Created by Thaddeus Dronski on 1/15/23.
//




import SwiftUI
import MapKit
import LocalAuthentication


struct ContentView: View {
    
   @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isUnlocked {
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())
                            
                            Text(location.name)
                                .fixedSize()
                        }
                        .onTapGesture {
                            viewModel.selectedPlace = location
                        }
                    }
                }
                    .ignoresSafeArea()
                Circle()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            //create a new location
                            viewModel.addLocation()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .padding()
                        .background(.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                    }
                }
            } else {
                //button here
                Button("Unlock Places") {
                    viewModel.authenticat()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .sheet(item: $viewModel.selectedPlace) { place in
            EditView(location: place) {
                viewModel.update(location: $0)
               
            }
        }
    }
}


//biometrics

//struct ContentView: View {
//    @State private var isUnlocked = false
//
//    var body: some View {
//        VStack {
//            if isUnlocked {
//                Text("Unlocked")
//            } else {
//                Text("Locked")
//            }
//        }
//        .onAppear(perform: authenticate)
//    }
//    func authenticate() {
//        let context = LAContext()
//        var error: NSError?
//
//        //check whether biometric authentication is possible
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//            //it's possible, so og ahead and use it
//            let reason = "We need to unlock your data."
//
//            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
//                //authentication has now completed
//                if success {
//                    //authenticated successfully
//                    isUnlocked = true
//                } else {
//                    //there was a problem
//                }
//            }
//        } else {
//            // no biometrics
//        }
//    }
//}






//integrating MapKit with SwiftUI
//struct Location: Identifiable {
//    let id = UUID()
//    let name: String
//    let coordinate: CLLocationCoordinate2D
//}
//
//struct ContentView: View {
//    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
//
//    let locations = [
//        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
//        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
//    ]
//
//    var body: some View {
//        NavigationView {
//            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
//                MapAnnotation(coordinate: location.coordinate) {
//                    NavigationLink {
//                        Text(location.name)
//                    } label: {
//                        Circle()
//                            .stroke(.red, lineWidth: 3)
//                            .frame(width: 44, height: 44)
//                    }
//                }
//            }
//            .navigationTitle("London Explorer")
//        }
//    }
//}



//switching view states with enums
//enum LoadingState {
//    case loading, success, failed
//}
//
//
//struct LoadingView: View {
//    var body: some View {
//        Text("Loading....")
//    }
//}
//
//struct SuccessView: View {
//    var body: some View {
//        Text("Success!")
//    }
//}
//
//struct FailedView: View {
//    var body: some View {
//        Text("Failed")
//    }
//}
//
//struct ContentView: View {
//    var loadingState = LoadingState.loading
//
//    var body: some View {
//        VStack {
//            if loadingState == .loading {
//                LoadingView()
//            } else if loadingState == .success {
//                SuccessView()
//            } else if loadingState == .failed {
//                FailedView()
//            }
//        }
//    }
//}

////Writing data to the documetns directroy
//func getDocumentsDirectory() -> URL {
//    // find all possible documetns directories for this user
//    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//
//    //jsut send back the first one, which ought to be the only one
//    return paths[0]
//}
//
//struct ContentView: View {
//    var body: some View {
//        Text("Hello World")
//            .onTapGesture {
//                let str = "Test Message"
//                let url = getDocumentsDirectory().appendingPathComponent("message.txt")
//
//                do {
//                    try str.write(to: url, atomically: true, encoding: .utf8)
//                    let input = try String(contentsOf: url)
//                    print(input)
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//    }
//}


//adding conformacne to comparable for custom types
//struct User: Identifiable, Comparable {
//    let id = UUID()
//    let firstName: String
//    let lastName: String
//
//    static func <(lhs: User, rhs: User) -> Bool {
//        lhs.lastName < rhs.lastName
//    }
//}
//
//struct ContentView: View {
//   let users = [
//            User(firstName: "Arnold", lastName: "Rimmer"),
//            User(firstName: "Kristine", lastName: "Kochanski"),
//            User(firstName: "David", lastName: "Lister")
//   ].sorted()
//
//    var body: some View {
//        List(users) { user in
//            Text("\(user.lastName), \(user.firstName)")
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
