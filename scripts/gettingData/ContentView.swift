import SwiftUI
import Foundation


struct ContentView: View {
    
    let manager = APIRequestManager.shared
    
    var body: some View {
        VStack {
            Text("Search for movies")
                .font(.largeTitle)
                .padding()
            
            
            Button("Buscar Filmes") {
                Task {
                    do {
                        if manager.completeMovies.count == 0 {
                            let moviesWithDetails = try! await getMoviesWithDetails()
                            manager.completeMovies = moviesWithDetails
                            
                            // classificating movies by country 
                            let countMoviesCountry = classifyMoviesByCountry(movies: moviesWithDetails)
                            let classifiedMoviesByName = classifyMoviesByNames(movies: moviesWithDetails)

                            // classificating movies by decade
                            let counterMoviesDecades = counterClassifyMoviesFromDecades(movies: moviesWithDetails)
                            let classifiedDecadesByName = classifyMoviesFromDecadesByNames(movies: moviesWithDetails)
                            
                            print("Array da API: \(manager.completeMovies.count)\n")                            
                            print("Counter American Movies: \(countMoviesCountry["American"]?.count ?? 0)\n")
                            print("Counter Other Movies: \(countMoviesCountry["Other"]?.count ?? 0)\n") //we used 'Others' in the code but in the paper its called 'Global'
                        }
                    } catch {
                        print("Error fetching movies: \(error)")
                    }
                }
            }
            
        }
        .padding()
    }
}
