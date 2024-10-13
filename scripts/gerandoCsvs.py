import pandas as pd
import json

# Carregar os dados dos JSONs
def load_movies(file_path):
    with open(file_path, 'r') as file:
        return json.load(file)

# Carregar ambos os arquivos JSON
merged_movies = load_movies('MergedMovies.json')
final_merged_movies = load_movies('MergedBrazilianAndOtherMovies.json')

# Combinar os dois conjuntos de filmes
combined_movies = merged_movies + final_merged_movies

# 1. Criar o CSV 'a.csv': filme, década, score, nacionalidade, todos os gêneros
def create_a_csv(movies, output_path):
    # Lista para armazenar os dados
    data = []
    for movie in movies:
        title = movie.get('title')
        year = movie.get('year')
        # Calcular a década
        if year:
            decade = (year // 10) * 10
        else:
            decade = None
        # Score (Assumindo que 'rating' está presente e é o Bechdel score)
        rating = movie.get('rating', None)
        # Nacionalidade
        country = 'USA' if 'United States' in movie.get('details', {}).get('Country', '') else 'Others'
        # Gêneros (pegar todos os gêneros)
        genre = movie.get('details', {}).get('Genre', '') if movie.get('details', {}).get('Genre') else None
        
        data.append([title, decade, rating, country, genre])

    # Criar um DataFrame e salvar como CSV
    df = pd.DataFrame(data, columns=['filme', 'decada', 'score', 'nacionalidade', 'genero'])
    df.to_csv(output_path, index=False)
    print(f"Arquivo {output_path} gerado com sucesso.")

# Combina os dois JSONs em um único CSV
create_a_csv(combined_movies, 'aCombined.csv')

# 2. Criar o CSV 'b.csv': década, % nota 0, % nota 1, % nota 2, % nota 3 (por nacionalidade)
def create_b_csv(movies, output_path):
    # Dicionário para armazenar as porcentagens
    data = {}
    
    for movie in movies:
        year = movie.get('year')
        rating = movie.get('rating', None)
        country = 'USA' if 'United States' in movie.get('details', {}).get('Country', '') else 'Others'
        
        if year:
            decade = (year // 10) * 10
        else:
            continue
        
        if decade not in data:
            data[decade] = {'USA': [0, 0, 0, 0], 'Others': [0, 0, 0, 0], 'total': {'USA': 0, 'Others': 0}}
        
        if rating is not None and 0 <= rating <= 3:
            data[decade][country][rating] += 1
            data[decade]['total'][country] += 1
    
    # Calcular as porcentagens
    rows = []
    for decade, counts in data.items():
        for country in ['USA', 'Others']:
            total = counts['total'][country]
            if total > 0:
                percentages = [count / total * 100 for count in counts[country]]
            else:
                percentages = [0, 0, 0, 0]
            rows.append([decade, country] + percentages)
    
    # Criar o DataFrame e salvar como CSV
    df = pd.DataFrame(rows, columns=['decada', 'nacionalidade', '%nota0', '%nota1', '%nota2', '%nota3'])
    df.to_csv(output_path, index=False)
    print(f"Arquivo {output_path} gerado com sucesso.")

# Combina os dois JSONs em um único CSV para análise de porcentagens
create_b_csv(combined_movies, 'bCombined.csv')