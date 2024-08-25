# Cholera Data Analysis

## Overview

This project analyzes cholera data to identify patterns and trends over the years. We have utilized various data analysis and visualization techniques to gain insights into cholera cases and fatalities across different countries.

## Conclusion

From the analysis, we observe the following patterns:

1. **Developed Nations**: Developed countries show significantly lower counts of cholera cases and associated deaths, likely due to better sanitation and healthcare infrastructure.
2. **India**: India exhibits the highest number of cholera cases and deaths, which can be attributed to its large population, historical sanitation challenges, and political instability during the 1950s-70s. However, there have been substantial improvements in recent years.
3. **Haiti**: Despite being a small Caribbean nation with economic challenges and environmental drawbacks, Haiti has managed to control death rates effectively, showcasing their successful interventions in managing cholera.

## About the Dataset

### Context

Cholera is an acute diarrhoeal infection caused by ingesting food or water contaminated with the bacterium *Vibrio cholerae*. It remains a global health threat and an indicator of inequity and inadequate social development. Estimates suggest that there are 1.3 to 4.0 million cholera cases and 21,000 to 143,000 deaths worldwide each year.

### Content

- `data.csv`: Contains country-wise data on the number of cholera cases, deaths, and case fatality ratio (CFR) from 1949 to 2016.

### Data Source

Data is sourced from the World Health Organization (WHO) [here](https://apps.who.int/gho/data/node.main.174?lang=en).

## Techniques and Packages Used

### Techniques

- **Data Cleaning**: Handling missing values, correcting inconsistent data entries.
- **Data Visualization**: Using line plots, bar plots, heatmaps, and geographic maps to visualize trends and distributions.
- **Exploratory Data Analysis (EDA)**: Identifying patterns, outliers, and significant trends in cholera cases and deaths.

### Packages

- **`tidyverse`**: For data manipulation and visualization. It includes `ggplot2`, `dplyr`, `tidyr`, and other packages essential for data analysis.
- **`sf`**: For handling spatial data and plotting geographic maps.
- **`ggrepel`**: For creating clear and non-overlapping text labels in plots.
- **`cowplot`**: For arranging multiple plots in a grid layout.

## Process

1. **Loading Libraries**: Import required R packages for data manipulation, visualization, and spatial analysis.
2. **Reading the Dataset**: Load and preview the dataset to understand its structure.
3. **Identifying Data Types**: Examine the data types to ensure they are appropriate for analysis.
4. **Handling Missing Values**: Identify and address missing data points.
5. **Data Cleaning**: Replace missing values and correct data inconsistencies.
6. **Visualization**: Create various plots to visualize trends, distributions, and comparisons:
   - WHO region-wise trends over years
   - Country-wise distribution of cholera cases and deaths
   - World heatmap for cholera cases
   - Analysis of least and most affected countries in the last 10 years
   - Country-wise median fatality rate

## Usage

To run the analysis, clone the repository and ensure you have the required R packages installed. Follow the RMarkdown document provided in the repository to reproduce the analysis and visualizations.

## Acknowledgements

We acknowledge the World Health Organization (WHO) for providing the data used in this analysis.

```
