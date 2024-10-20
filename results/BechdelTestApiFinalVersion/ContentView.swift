import SwiftUI
import Foundation


struct ContentView: View {
    
    let manager = APIRequestManager.shared
    
    var body: some View {
        VStack {
            Text("Clique abaixo para ativar e buscar filmes")
                .font(.largeTitle)
                .padding()
            
            //printa no console após a pessoa clicar em buscar os filmes
            
            Button("Buscar Filmes") {
                print("Botão clicado") //Botão foi clicado - print funcionou
                Task {
                    do {
                        if manager.completeMovies.count == 0 {
//                            print("entrei na func")
                            let moviesWithDetails = try! await getMoviesWithDetails()
//                            print("sai da func")
                            manager.completeMovies = moviesWithDetails
                            
                            // Classificar os filmes por país
//                            let countMoviesCountry = classifyMoviesByCountry(movies: moviesWithDetails)
//                            let classifiedMoviesByName = classifyMoviesByNames(movies: moviesWithDetails)
//                            
//                            let counterMoviesDecades = counterClassifyMoviesFromDecades(movies: moviesWithDetails)
//                            let classifiedDecadesByName = classifyMoviesFromDecadesByNames(movies: moviesWithDetails)
                            
                            // Exibir ou manipular os filmes classificados
//                            print("Array da API: \(manager.completeMovies.count)\n")
//                            print("Array da API: \(manager.completeMovies)")
                            
//                            print("Counter American Movies: \(countMoviesCountry["American"]?.count ?? 0)\n")
//                            print("Counter Brazilian Movies: \(countMoviesCountry["Brazilian"]?.count ?? 0)\n")
//                            print("Counter Other Movies: \(countMoviesCountry["Other"]?.count ?? 0)\n")
                            
//                            print("American Movies: \n\(classifiedMoviesByName["American"])\n\n")
//                            print("Brazilian Movies: \n\(classifiedMoviesByName["Brazilian"])\n\n")
//                            print("Other Movies: \n\(classifiedMoviesByName["Other"])\n\n")
                            
//                            print("Decada de 1930 Count: \(counterMoviesDecades["Decada de 1930 Count"]?.count ?? 0)")
//                            print("Decada de 1940 Count: \(counterMoviesDecades["Decada de 1940 Count"]?.count ?? 0)")
//                            print("Decada de 1950 Count: \(counterMoviesDecades["Decada de 1950 Count"]?.count ?? 0)")
//                            print("Decada de 1960 Count: \(counterMoviesDecades["Decada de 1960 Count"]?.count ?? 0)")
//                            print("Decada de 1970 Count: \(counterMoviesDecades["Decada de 1970 Count"]?.count ?? 0)")
//                            print("Decada de 1980 Count: \(counterMoviesDecades["Decada de 1980 Count"]?.count ?? 0)")
//                            print("Decada de 1990 Count: \(counterMoviesDecades["Decada de 1990 Count"]?.count ?? 0)")
//                            print("Decada de 2000 Count: \(counterMoviesDecades["Decada de 2000 Count"]?.count ?? 0)")
//                            print("Decada de 2010 Count: \(counterMoviesDecades["Decada de 2010 Count"]?.count ?? 0)")
//                            print("Decada de 2020 Count: \(counterMoviesDecades["Decada de 2020 Count"]?.count ?? 0)\n")
//
//                            print("Decada de 1930 Names: \(classifiedDecadesByName["Decada de 1930 Names"] ?? [])")
//                            print("Decada de 1940 Names: \(classifiedDecadesByName["Decada de 1940 Names"] ?? [])")
//                            print("Decada de 1950 Names: \(classifiedDecadesByName["Decada de 1950 Names"] ?? [])")
//                            print("Decada de 1960 Names: \(classifiedDecadesByName["Decada de 1960 Names"] ?? [])")
//                            print("Decada de 1970 Names: \(classifiedDecadesByName["Decada de 1970 Names"] ?? [])")
//                            print("Decada de 1980 Names: \(classifiedDecadesByName["Decada de 1980 Names"] ?? [])")
//                            print("Decada de 1990 Names: \(classifiedDecadesByName["Decada de 1990 Names"] ?? [])")
//                            print("Decada de 2000 Names: \(classifiedDecadesByName["Decada de 2000 Names"] ?? [])")
//                            print("Decada de 2010 Names: \(classifiedDecadesByName["Decada de 2010 Names"] ?? [])")
//                            print("Decada de 2020 Names: \(classifiedDecadesByName["Decada de 2020 Names"] ?? [])")
                            
//                            saveMoviesToJsonFiles(classifiedMoviesByName)
                            
                            let filePath1 = "/Users/isabelabraconipontual/Downloads/Trabalho CDD/AmericanMovies.json/AmericanMovies (1).json"
                            let fileURL1 = URL(fileURLWithPath: filePath1)
                            
                            let filePath2 = "/Users/isabelabraconipontual/Downloads/Trabalho CDD/AmericanMovies.json/AmericanMovies (2).json"
                            let fileURL2 = URL(fileURLWithPath: filePath2)
                            
                            let filePath3 = "/Users/isabelabraconipontual/Downloads/Trabalho CDD/AmericanMovies.json/AmericanMovies (3).json"
                            let fileURL3 = URL(fileURLWithPath: filePath3)
                            
                            let filePath4 = "/Users/isabelabraconipontual/Downloads/Trabalho CDD/AmericanMovies.json/AmericanMovies (4).json"
                            let fileURL4 = URL(fileURLWithPath: filePath4)
                            
                            let filePath5 = "/Users/isabelabraconipontual/Downloads/Trabalho CDD/AmericanMovies.json/AmericanMovies (5).json"
                            let fileURL5 = URL(fileURLWithPath: filePath5)
                            
                            let filePath6 = "/Users/isabelabraconipontual/Downloads/Trabalho CDD/AmericanMovies.json/AmericanMovies (6).json"
                            let fileURL6 = URL(fileURLWithPath: filePath6)
                            
                            let filePath7 = "/Users/isabelabraconipontual/Downloads/Trabalho CDD/AmericanMovies.json/AmericanMovies (7).json"
                            let fileURL7 = URL(fileURLWithPath: filePath7)
                            
                            let filePath8 = "/Users/isabelabraconipontual/Downloads/Trabalho CDD/AmericanMovies.json/AmericanMovies (8).json"
                            let fileURL8 = URL(fileURLWithPath: filePath8)
                            
                            let filePath9 = "/Users/isabelabraconipontual/Downloads/Trabalho CDD/AmericanMovies.json/AmericanMovies (9).json"
                            let fileURL9 = URL(fileURLWithPath: filePath9)
                            
                            let filePath10 = "/Users/isabelabraconipontual/Downloads/Trabalho CDD/AmericanMovies.json/AmericanMovies.json"
                            let fileURL10 = URL(fileURLWithPath: filePath10)

                            
                            mergeAndSaveMoviesFromJsonFiles(fileURLs: [fileURL1, fileURL2,fileURL3,fileURL4,fileURL5,fileURL6,fileURL7,fileURL8,fileURL9,fileURL10])
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
