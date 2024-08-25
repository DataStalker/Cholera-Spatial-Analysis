### 1. **Loading Required Libraries**


library(tidyverse)
library(sf)

# For additional analysis and visualization
library(ggrepel)
library(cowplot) 


### 2. **Reading the Dataset**

df <- read_csv("cholera.csv")
head(file)


### 3. **Identifying Data Types**

glimpse(file)


### 4. **Identifying Missing Values**


file %>%
  summarise_all(~sum(is.na(.))) %>%
  gather(key = "Column", value = "Missing_Count")


### 5. **Data Cleaning**
- Replace `NA` with 0
- Replace "Unknown" values with 0
- Fix entries like `"3 5"`


df_clean <- file %>%
  mutate(across(everything(), ~replace_na(., 0))) %>%
  mutate(across(contains("cholera"), ~str_replace_all(., "Unknown", "0"))) %>%
  mutate(`Number of reported cases of cholera` = str_replace_all(`Number of reported cases of cholera`, "3 5", "0"),
         `Number of reported deaths from cholera` = str_replace_all(`Number of reported deaths from cholera`, "0 0", "0"),
         `Cholera case fatality rate` = str_replace_all(`Cholera case fatality rate`, "0.0 0.0", "0"))


### 6. **Unique Countries Count**


country_list <- unique(df_clean$Country)
length(country_list)


### 7. **WHO Region Wise Visualization**


df_clean %>%
  mutate(across(c(`Number of reported cases of cholera`, `Number of reported deaths from cholera`), as.numeric)) %>%
  group_by(`WHO Region`, Year) %>%
  summarise(Reported_Cases = sum(`Number of reported cases of cholera`),
            Deaths = sum(`Number of reported deaths from cholera`)) %>%
  ggplot(aes(x = Year)) +
  geom_line(aes(y = Reported_Cases, color = "Reported Cases")) +
  geom_line(aes(y = Deaths, color = "Deaths")) +
  facet_wrap(~`WHO Region`, scales = "free") +
  labs(title = "WHO Region-wise Cholera Cases and Deaths Over the Years", 
       y = "Cases/Deaths Count", color = "") +
  theme_minimal() +
  theme(legend.position = "bottom")


### 8. **Country-wise Distribution of Cholera Cases**


file_ctry <- df_clean %>%
  group_by(Country) %>%
  summarise(`Cholera Cases Count` = sum(as.numeric(`Number of reported cases of cholera`)))

ggplot(file_ctry, aes(x = reorder(Country, `Cholera Cases Count`), y = `Cholera Cases Count`)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "Cholera Cases Distribution - All Time", 
       x = "Countries", y = "Cholera Cases Count") +
  theme_minimal()


### 9. **World Heat Map for Cholera Cases**


# Load the shapefile and clean up the country names
map_df <- st_read("TM_WORLD_BORDERS-0.3.shp") %>%
  rename(Country = name) %>%
  mutate(Country = recode(Country, 
                          "Burma" = "Myanmar", 
                          "Korea, Republic of" = "Republic of Korea",
                          "Russia" = "Russian Federation",
                          "United Kingdom" = "United Kingdom of Great Britain and Northern Ireland",
                          "United States" = "United States of America", 
                          "Venezuela" = "Venezuela (Bolivarian Republic of)"))

# Join the map data with cholera cases
merged <- left_join(map_df, file_ctry, by = "Country")

# Plot the heatmap
ggplot(merged) +
  geom_sf(aes(fill = `Cholera Cases Count`), color = "white") +
  scale_fill_viridis_c(option = "Blues", na.value = "white", name = "Cholera Cases") +
  labs(title = "Cholera Cases History: World Level") +
  theme_void()


### 10. **Least and Most Affected Countries (Last 10 Years)**


final_10_yrs <- seq(2007, 2016)
ten_yr_case <- df_clean %>% filter(Year %in% final_10_yrs)

file_yr_ctry <- ten_yr_case %>%
  group_by(Country) %>%
  summarise(`Cholera Cases Count` = sum(as.numeric(`Number of reported cases of cholera`)))

best_cases_country <- file_yr_ctry %>% arrange(`Cholera Cases Count`) %>% head(10)
worst_cases_country <- file_yr_ctry %>% arrange(desc(`Cholera Cases Count`)) %>% head(10)

# Plotting Least Affected Countries
ggplot(best_cases_country, aes(x = reorder(Country, `Cholera Cases Count`), y = `Cholera Cases Count`)) +
  geom_col(fill = "green") +
  coord_flip() +
  labs(title = "Countries with the Least Count of Cholera (Last 10 Years)",
       x = "Countries", y = "Cholera Cases Count") +
  theme_minimal()

# Plotting Most Affected Countries
ggplot(worst_cases_country, aes(x = reorder(Country, `Cholera Cases Count`), y = `Cholera Cases Count`)) +
  geom_col(fill = "red") +
  coord_flip() +
  labs(title = "Countries with the Highest Count of Cholera (Last 10 Years)",
       x = "Countries", y = "Cholera Cases Count") +
  theme_minimal()


### 11. **Country-wise Deaths from Cholera (All Time)**


file_ctry_deaths <- df_clean %>%
  group_by(Country) %>%
  summarise(`Deaths from Cholera` = sum(as.numeric(`Number of reported deaths from cholera`)))

ggplot(file_ctry_deaths, aes(x = reorder(Country, `Deaths from Cholera`), y = `Deaths from Cholera`)) +
  geom_col(fill = "purple") +
  coord_flip() +
  labs(title = "Cholera Death Cases Distribution - All Time", 
       x = "Countries", y = "Deaths Count") +
  theme_minimal()


### 12. **WHO Region vs Year Heatmap for Cholera Cases (Last 10 Years)**


file_yr_region <- ten_yr_case %>%
  group_by(`WHO Region`, Year) %>%
  summarise(`Cholera Cases Count` = sum(as.numeric(`Number of reported cases of cholera`)))

ggplot(file_yr_region, aes(x = Year, y = `WHO Region`, fill = `Cholera Cases Count`)) +
  geom_tile(color = "white") +
  scale_fill_viridis_c(option = "YlOrBr") +
  labs(title = "WHO Region vs Year Heatmap of Cholera Cases (Last 10 Years)", 
       x = "Year", y = "WHO Region") +
  theme_minimal()


### 13. **Country-wise Median Fatality Rate**


fat_ctry <- df_clean %>%
  group_by(Country) %>%
  summarise(`Median Fatality Rate` = median(as.numeric(`Cholera case fatality rate`), na.rm = TRUE))

ggplot(fat_ctry, aes(x = reorder(Country, `Median Fatality Rate`), y = `Median Fatality Rate`)) +
  geom_col(fill = "red") +
  coord_flip() +
  labs(title = "Median Fatality Rate - Nation wise", 
       x = "Country", y = "Fatality Rate (Median)") +
  theme_minimal()


---

