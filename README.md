# Glacial Lake Outburst Flood (GLOF) Prediction Web App

![GLOF Prediction Web App](https://images.pexels.com/photos/28359751/pexels-photo-28359751.jpeg?cs=srgb&dl=pexels-gsn-travel-28359751.jpg&fm=jpg)

## Overview
This repository contains a Shiny-based web application designed to predict the risk of Glacial Lake Outburst Floods (GLOFs) in the Himalayan region of India. GLOFs pose significant risks to downstream communities, infrastructure, and ecosystems. Our web application provides users with tools to estimate the risk score of GLOFs based on various parameters and visualize the data interactively.

## Features
- **Risk Prediction Model**: Predicts a GLOF risk score based on key parameters like glacial lake attributes, climatic conditions, and geological factors.
- **Interactive Visualization**: 
  - 2D and 3D interactive charts for exploring data and trends.
  - Comprehensive visuals for better decision-making.
- **User Authentication**: 
  - Google-based login and logout system for secure access.
- **Data Insights**: Analyzes and presents historical and current data trends for glacial lakes in the Himalayan region.

## Parameters Used in Prediction
The application uses the following parameters for GLOF risk prediction:
- **Glacial Lake ID**
- **Latitude and Longitude**
- **Altitude (m)**
- **Lake Area (sq. km)**
- **Ice Cover (%)**
- **Temperature (°C)**
- **Precipitation (mm/year)**
- **Slope Angle (degrees)**
- **Nearby Glacier (Yes/No)**
- **Seismic Activity (Yes/No)**
- **Moraine Dam Type**
- **Historical GLOF Events (Yes/No)**

## Files in the Repository
1. **b1.R**: Contains the core RShiny application code, including the user interface and server logic.
2. **cleaned_glacial_lake_dataset.csv**: Preprocessed dataset of glacial lakes with attributes required for prediction and visualization.
3. **glof analysis.pbix**: Power BI file containing detailed data analysis and visual reports for GLOF insights.

## How to Use
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/glof-rshiny-project.git
   cd glof-rshiny-project
   ```
2. **Install Required Libraries**:
   Ensure you have the following R packages installed:
   - shiny
   - ggplot2
   - plotly
   - shinythemes
   - dplyr
3. **Run the Application**:
   Open `b1.R` in RStudio and click on the `Run App` button. Alternatively, use:
   ```R
   shiny::runApp('b1.R')
   ```
4. **Access the Web App**:
   Navigate to the provided localhost URL to interact with the app.

## Key Functionalities
- **Risk Prediction**: Enter parameters such as latitude, longitude, lake area, and other attributes to get a calculated risk score.
- **Data Visualization**:
  - Explore 2D and 3D interactive charts to better understand the relationships between parameters and risk scores.
  - View historical trends and insights into past GLOF events.
- **Secure Access**: Google login ensures secure user authentication for app usage.

 
## Future Work
- Integration of real-time satellite data for dynamic risk assessments.
- Enhanced machine learning models for improved prediction accuracy.
- Mobile-responsive web app design for better accessibility.

## Acknowledgments
This project was developed as part of a broader initiative to mitigate risks associated with GLOFs in the Himalayan region. Special thanks to contributors and data providers.

## License
This project is licensed under the [MIT License](LICENSE).

## Contact
For any queries or contributions, please contact:
**Aditya Sharma** (Developer)
- Email: [sharmaaditya18012004@gmail.com](mailto:sharmaaditya18012004@gmail.com)
- GitHub: [AdityaSharma1801](https://github.com/AdityaSharma1801)

**Bhavya Pradhan** (Co-Developer) 
- Email: [bhavyapradhan8@gmail.com](mailto:bhavyapradhan8@gmail.com)
- GitHub: [Bhavya2004-ds](https://github.com/Bhavya2004-ds)
---
Feel free to contribute by raising issues or submitting pull requests to enhance the project.
