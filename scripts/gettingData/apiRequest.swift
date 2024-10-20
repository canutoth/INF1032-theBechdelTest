//
//  API's request.swift
//  New
//
//  Created by Luana Bueno on 10/10/24.
//

import Foundation
import Foundation

// Função que faz a busca de todos os filmes do BechdelTest e retorna a lista de filmes ordenados
func bechdelSearch(isMock: Bool) async throws -> [WelcomeElement] {
    
    if isMock == true {
            
            let urlString = Bundle.main.url(forResource: "movies", withExtension: "json")
            let data = try Data(contentsOf: urlString!)
            var welcome = try JSONDecoder().decode([WelcomeElement].self, from: data)
            welcome = welcome.filter { $0.year >= 1930 }
            welcome.sort { $0.year < $1.year }
            return welcome
            
    } else {
        let urlString = "https://bechdeltest.com/api/v1/getAllMovies"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let session = URLSession(configuration: .ephemeral)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, response) = try await session.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        var welcome = try JSONDecoder().decode([WelcomeElement].self, from: data)
        // Filtrar filmes da década de 1930
        welcome = welcome.filter { $0.year >= 1930 }
        // Ordenar os filmes por ano
        welcome.sort { $0.year < $1.year }
        return welcome
    }
    
}

//funcao de classificacao de filmes por pais
func classifyMoviesByCountry(movies: [CompleteMovie]) -> [String: [CompleteMovie]] {
//    print("entrei e analisei os filmes")
    var classification: [String: [CompleteMovie]] = [
        "American": [],
        "Brazilian": [],
        "Other": []
    ]
    
    for movie in movies {
        
        
        if let country = movie.details?.country?.lowercased() {
            if country.contains("united states") {
                classification["American"]?.append(movie)
            }
            if country.contains("brazil") {
                classification["Brazilian"]?.append(movie)
            }
            if !country.contains("brazil") && !country.contains("united states") {
                classification["Other"]?.append(movie)
            }
        }
        
    }
    
    return classification
}

func classifyMoviesByNames(movies: [CompleteMovie]) -> [String: [CompleteMovie]] {
    var classification: [String: [CompleteMovie]] = [
        "American": [],
        "Brazilian": [],
        "Other": []
    ]
    
    for movie in movies {
        
        //        print(/*movie.details?.title ?? "", */movie.details?.country?.lowercased() ?? "")
        
        if let country = movie.details?.country?.lowercased() {
            if country.contains("united states") {
                classification["American"]?.append(movie)
            }
            if country.contains("brazil") {
                classification["Brazilian"]?.append(movie)
            }
            if !country.contains("brazil") && !country.contains("united states") {
                classification["Other"]?.append(movie)
            }
        }
    }
    
    return classification
}

func counterClassifyMoviesFromDecades(movies: [CompleteMovie]) -> [String: [CompleteMovie]] {
    var classification: [String: [CompleteMovie]] = [
        "Decada de 1930 Count": [],
        "Decada de 1940 Count": [],
        "Decada de 1950 Count": [],
        "Decada de 1960 Count": [],
        "Decada de 1970 Count": [],
        "Decada de 1980 Count": [],
        "Decada de 1990 Count": [],
        "Decada de 2000 Count": [],
        "Decada de 2010 Count": [],
        "Decada de 2020 Count": []
    ]
    
    for movie in movies {
        //        if let year = Int(movie.year) {
        switch movie.year {
        case 1930...1939:
            classification["Decada de 1930 Count"]?.append(movie)
        case 1940...1949:
            classification["Decada de 1940 Count"]?.append(movie)
        case 1950...1959:
            classification["Decada de 1950 Count"]?.append(movie)
        case 1960...1969:
            classification["Decada de 1960 Count"]?.append(movie)
        case 1970...1979:
            classification["Decada de 1970 Count"]?.append(movie)
        case 1980...1989:
            classification["Decada de 1980 Count"]?.append(movie)
        case 1990...1999:
            classification["Decada de 1990 Count"]?.append(movie)
        case 2000...2009:
            classification["Decada de 2000 Count"]?.append(movie)
        case 2010...2019:
            classification["Decada de 2010 Count"]?.append(movie)
        case 2020...2029:
            classification["Decada de 2020 Count"]?.append(movie)
        default:
            break
        }
    }
    //    }
    
    return classification
}

func classifyMoviesFromDecadesByNames(movies: [CompleteMovie]) -> [String: [String]] {
    var classification: [String: [String]] = [
        "Decada de 1930 Names": [],
        "Decada de 1940 Names": [],
        "Decada de 1950 Names": [],
        "Decada de 1960 Names": [],
        "Decada de 1970 Names": [],
        "Decada de 1980 Names": [],
        "Decada de 1990 Names": [],
        "Decada de 2000 Names": [],
        "Decada de 2010 Names": [],
        "Decada de 2020 Names": []
    ]
    
    for movie in movies {
        switch movie.year {
        case 1930...1939:
            classification["Decada de 1930 Names"]?.append(movie.title)
        case 1940...1949:
            classification["Decada de 1940 Names"]?.append(movie.title)
        case 1950...1959:
            classification["Decada de 1950 Names"]?.append(movie.title)
        case 1960...1969:
            classification["Decada de 1960 Names"]?.append(movie.title)
        case 1970...1979:
            classification["Decada de 1970 Names"]?.append(movie.title)
        case 1980...1989:
            classification["Decada de 1980 Names"]?.append(movie.title)
        case 1990...1999:
            classification["Decada de 1990 Names"]?.append(movie.title)
        case 2000...2009:
            classification["Decada de 2000 Names"]?.append(movie.title)
        case 2010...2019:
            classification["Decada de 2010 Names"]?.append(movie.title)
        case 2020...2029:
            classification["Decada de 2020 Names"]?.append(movie.title)
        default:
            break
            
        }
    }
    
    return classification
}



// Função que faz o request no imdb dos detalhes do filme usando o imdbID
func fetchMovieDetails(for imdbID: String) async throws -> OMDbMovieDetails {
    //let urlString = "https://www.omdbapi.com/?&apikey=f5e35efc&i=tt\(imdbID)"
    let urlString = "https://www.omdbapi.com/?i=tt\(imdbID)&apikey=f5e35efc"
    guard let url = URL(string: urlString) else {
        throw URLError(.badURL)
    }
    
    let session = URLSession(configuration: .ephemeral)
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let (data, response) = try await session.data(for: request)
    
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
        throw URLError(.badServerResponse)
    }
    
    let imdbDetails = try JSONDecoder().decode(OMDbMovieDetails.self, from: data)
    
    return imdbDetails
}

// Função principal que retorna a lista de filmes completa com todos os detalhes
func getMoviesWithDetails() async throws -> [CompleteMovie] {
//    print("pegando dados")
    var completeMovies: [CompleteMovie] = []
    
    // Busca os filmes
    let movies = try await bechdelSearch(isMock: false)
    
    // Para cada filme, pegar o imdbid e buscar os detalhes
    for movie in movies {
        do {
            var details = try await fetchMovieDetails(for: movie.imdbid)
            details.released = nil //ja que escolhemos obter só o ano do bechdelTest
            
            let completeMovie = CompleteMovie(
                year: movie.year,
                rating: movie.rating,
                title: movie.title,
                imdbid: movie.imdbid,
                details: details
            )
            print("pensando")
            completeMovies.append(completeMovie)
        } catch {
            print("Erro ao buscar detalhes do filme \(movie.title): \(error)")
        }
    }
    return completeMovies.sorted { $0.year < $1.year }
}

