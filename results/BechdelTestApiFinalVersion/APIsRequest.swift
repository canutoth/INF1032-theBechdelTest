import Foundation

// Função que faz a busca de todos os filmes do BechdelTest e retorna a lista de filmes ordenados
func bechdelSearch(isMock: Bool) async throws -> [WelcomeElement] {
    
    if isMock == true {
        
        let urlString = Bundle.main.url(forResource: "movies", withExtension: "json")
        let data = try Data(contentsOf: urlString!)
        var welcome = try JSONDecoder().decode([WelcomeElement].self, from: data)
        welcome = welcome.filter { $0.year >= 2022 }
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
        welcome = welcome.filter { $0.year >= 2022 }
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
    //let urlString = "https://www.omdbapi.com/?&apikey=770a2d89&i=tt\(imdbID)"
    let urlString = "https://www.omdbapi.com/?i=tt\(imdbID)&apikey=aa36d6ea"
    
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
    let movies = try await bechdelSearch(isMock: true)
    
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
//            print(completeMovie)
            completeMovies.append(completeMovie)
            print(completeMovie)
        } catch {
            print("Erro ao buscar detalhes do filme \(movie.title): \(error)")
        }
    }
    return completeMovies.sorted { $0.year < $1.year }
}

func saveMoviesToJsonFiles(_ classifiedMovies: [String: [CompleteMovie]]) {
    do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        // Caminho do diretório de documentos
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            // Salvar filmes Americanos
            if let americanMovies = classifiedMovies["American"] {
                let americanData = try encoder.encode(americanMovies)
                let americanFileURL = documentsDirectory.appendingPathComponent("AmericanMovies.json")
                try americanData.write(to: americanFileURL)
                print("Arquivo 'AmericanMovies.json' salvo com sucesso em: \(americanFileURL.path)")
            }
            
            // Salvar filmes Brasileiros
            if let brazilianMovies = classifiedMovies["Brazilian"] {
                let brazilianData = try encoder.encode(brazilianMovies)
                let brazilianFileURL = documentsDirectory.appendingPathComponent("BrazilianMovies.json")
                try brazilianData.write(to: brazilianFileURL)
                print("Arquivo 'BrazilianMovies.json' salvo com sucesso em: \(brazilianFileURL.path)")
            }
            
            // Salvar outros filmes
            if let otherMovies = classifiedMovies["Other"] {
                let otherData = try encoder.encode(otherMovies)
                let otherFileURL = documentsDirectory.appendingPathComponent("OtherMovies.json")
                try otherData.write(to: otherFileURL)
                print("Arquivo 'OtherMovies.json' salvo com sucesso em: \(otherFileURL.path)")
            }
        }
        
    } catch {
        print("Erro ao salvar os filmes em arquivos JSON: \(error)")
    }
}

func mergeAndSaveMoviesFromJsonFiles(fileURLs: [URL]) {
    var mergedMovies: [String: [CompleteMovie]] = [:]
    var seenMovieTitles: Set<String> = []
    
    do {
        // JSONDecoder para decodificar os arquivos
        let decoder = JSONDecoder()
        
        // Iterar sobre os URLs fornecidos e processar os arquivos
        for fileURL in fileURLs {
            let data = try Data(contentsOf: fileURL)
            
            // Decodificar o arquivo JSON
            let classifiedMovies = try decoder.decode([String: [CompleteMovie]].self, from: data)
            
            // Mesclar os filmes, removendo duplicatas
            for (category, movies) in classifiedMovies {
                if mergedMovies[category] == nil {
                    mergedMovies[category] = []
                }
                
                for movie in movies {
                    // Checar se o título já foi visto
                    if !seenMovieTitles.contains(movie.title) {
                        mergedMovies[category]?.append(movie)
                        seenMovieTitles.insert(movie.title)
                    }
                }
            }
        }
        
        // Agora vamos salvar os arquivos combinados
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        // Caminho do diretório de documentos
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            // Salvar filmes Americanos
            if let americanMovies = mergedMovies["American"] {
                let americanData = try encoder.encode(americanMovies)
                let americanFileURL = documentsDirectory.appendingPathComponent("AmericanMoviesMerged.json")
                try americanData.write(to: americanFileURL)
                print("Arquivo 'AmericanMoviesMerged.json' salvo com sucesso em: \(americanFileURL.path)")
            }
            
            // Salvar filmes Brasileiros
            if let brazilianMovies = mergedMovies["Brazilian"] {
                let brazilianData = try encoder.encode(brazilianMovies)
                let brazilianFileURL = documentsDirectory.appendingPathComponent("BrazilianMoviesMerged.json")
                try brazilianData.write(to: brazilianFileURL)
                print("Arquivo 'BrazilianMoviesMerged.json' salvo com sucesso em: \(brazilianFileURL.path)")
            }
            
            // Salvar outros filmes
            if let otherMovies = mergedMovies["Other"] {
                let otherData = try encoder.encode(otherMovies)
                let otherFileURL = documentsDirectory.appendingPathComponent("OtherMoviesMerged.json")
                try otherData.write(to: otherFileURL)
                print("Arquivo 'OtherMoviesMerged.json' salvo com sucesso em: \(otherFileURL.path)")
            }
        }
        
    } catch {
        print("Erro ao processar os arquivos JSON: \(error)")
    }
}
