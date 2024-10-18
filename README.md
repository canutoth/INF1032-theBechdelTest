# Voices Unheard: The Bechdel Test 

### Overview

Welcome to the repository for *Voices Unheard: The Bechdel Test*, a final project for the Introduction to Data Science chair at Pontifical Catholic University of Rio de Janeiro (PUC-Rio). This repository contains all the codes, data, and resources used to build the project, which examines gender representation in cinema using the Bechdel Test as the primary evaluation tool.

***

### Repository Structure

> **/data:** Contains raw and processed data collected from (insert api names and whatever here).
> 
> **/scripts:** Includes all scripts used for data collection, data cleaning, statistical analysis, and visualization.  A /requirements.txt file and further instructions are provided to ensure replicability.
> 
> **/results:** Contains the output of all analyses, including: visualizations (graphs showing trends in gender representation), statistical results (outputs from tests such as Chi-Square and regression analysis) and summary tables of key findings.

***

### Data

Our project uses data from the following sources:

- Bechdel Test API: Determines whether films pass the Bechdel Test based on three criteria.
- OMDb: Provides metadata such as title, release year, genre, and country.

To ensure replicability, `/data` also:
1. Explains the data extraction process from the various APIs and methods used and
2. Describes all the mathematical and statistical tests conducted in the project, providing a quantitative, evidence-based evaluation of the data

***

### Scripts

For the best use of the scripts found on this repository, you should start by checking the `\requirements.txt` file found in this directory.
We advise you to grab the data sample to compile your code or to extract your own data by your own parameters/needs/filters as instructed at /data.

**Key scripts include:**

- `abc.py`:
- `aeiou.swift`:
- `math.py`: Runs various statistical tests, such as Chi-Square, regression analysis, and correlation tests. Further explanation and listing of all tests can be found at /statistics.

***

### Results

The results of the analysis, including all visualizations and summary tables, are available in the `/results` directory. These are organized by the specific research questions addressed in the study.

***

### Contributing

We welcome contributions from the community. If you have any suggestions or improvements, please submit a pull request or open an issue.

***

### Contact

For any questions or further information, please contact the developers of this project:

- Isabela Sobrenome (e-mail)
- Júlia Tadeu (e-mail)
- Luana Bueno (lubuenorj@gmail.com)
- Theo Canuto (canutoeotheo@gmail.com)
