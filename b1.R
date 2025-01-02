library(shiny)
library(shinydashboard)
library(caret)
library(randomForest)
library(ggplot2)
library(plotly)
library(DT)
library(shinyjs)
library(httr)

# Set your Google OAuth2 credentials
google_client_id <- "236978117567-j5vvq2i6qaocjmdbet996l69qcmsbmml.apps.googleusercontent.com"

google_client_secret <- "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"

# Define the OAuth scopes
scopes <- c("https://www.googleapis.com/auth/userinfo.profile",
            "https://www.googleapis.com/auth/userinfo.email")

library(shiny)
library(plotly)
ui<-tagList(
  useShinyjs(),
  navbarPage(
    title = "Glacial Lake Risk Assessment",
    id = "main_navbar",
    inverse = FALSE,
    header = tags$head(
      tags$link(
        href = "https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;500;700&display=swap",
        rel = "stylesheet"
      ),
      tags$link(
        href = "https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap",
        rel = "stylesheet"
      ),
      tags$style(HTML("
    html{
    scroll-behavior:smooth;
    }
     body {
  font-family: 'Roboto', sans-serif !important;
  font-size: 14px;
  margin: 0;
  padding: 0;
  background-color: #f4f7f9; /* Slightly lighter shade */
}

.navbar {
  background-color: #fbbc77 !important; /* Softer Peach */
  border-color: #fbbc77 !important;
  margin-bottom: 0;
  position: sticky;
  top: 0;
  z-index: 1000;
}

.navbar .navbar-brand,
.navbar .navbar-nav > li > a {
  color: #003366 !important; /* Slightly darker blue for better contrast */
  font-weight: bold !important;
  font-size: 16px;
}

.navbar .navbar-nav {
  float: right !important;
}

.navbar .navbar-nav > li > a:hover {
  background-color: #ffdcb6 !important; /* Softer hover color */
  color: #003366 !important;
}

.hero-section {
  position: relative;
  background: linear-gradient(
      rgba(0, 0, 0, 0.3),
      rgba(0, 0, 0, 0.6),
      rgba(0, 0, 0, 0.3)
    ),
    url('https://images.pexels.com/photos/28359751/pexels-photo-28359751.jpeg?cs=srgb&dl=pexels-gsn-travel-28359751.jpg&fm=jpg');
  background-size: cover;
  background-position: center;
  height: 90vh; /* Slightly reduced height */
  color: white;
  text-align: center;
  padding-top: 180px; /* Adjusted padding for better positioning */
  padding-bottom: 20px;
  margin-bottom: 0;
}

.hero-section h1 {
  font-size: 2.8em; /* Increased size slightly */
  font-weight: bold;
  margin-bottom: 15px; /* Reduced margin */
}

.hero-section p {
  font-size: 1.2em;
  margin-bottom: 20px; /* Reduced margin */
  color:white;
}

.hero-section .btn,.btn1 {
  font-size: 16px;
  padding: 10px 22px; /* Adjusted padding for consistent button sizing */
  background-color: #003366; /* Softer Peach */
  color: white;
  border: none;
  border-radius: 50px;
  font-weight: bold;
  margin:10px;
  transition: all 0.3s ease-in-out;
  width:200px;
}
.hero-section .btn1{
border:5px solid #003366;
color:#003366;
background-color:white;

}


.hero-section .btn:hover {
  background-color: white; /* Deep Blue */
  color: #003366;
  border:5px solid #003366;
  transform: scale(1.05); /* Added slight hover effect */
}
.hero-section .btn1:hover{
background-color:#003366;
color:white;
border:none;

}

.section {
  padding: 25px 20px; /* Adjusted padding */
  text-align: center;
  background-color: #f6f9fc; /* Softer Light Gray */
  margin-bottom: 20px;
}

.section h3 {
  font-size: 2.4em; /* Increased size */
  color: #003366; /* Deep Blue */
  margin-bottom: 15px; /* Adjusted margin */
  color:#003366;
}

.section .feature-box {
  margin-top: 20px;
  border-radius: 10px;
  padding: 18px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Slightly stronger shadow */
  background-color: #003366;
  transition: box-shadow 0.3s ease-in-out;
   transition: box-shadow 0.3s ease-in-out;
   color:white;
   width:33%;
   display:inline-block;
}

.section .feature-box:hover {
  box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2); /* Added hover effect */
  transform: scale(1.02);
}
.section .feature-box p{
color:white;
}
.cta-section{
text-align:center;
}
.cta-buttons {
  display: flex;
  justify-content: center;
  gap: 20px; /* Adjusted spacing */
  margin-top: 20px;
}

.cta-buttons .btn {
  width: 180px;
  font-size: 16px;
  padding: 12px;
  border-radius: 12px; /* Slightly sharper edges */
 background-color: #fbbc77; /* Softer Peach */
  color: #003366;
  font-weight:bold;
  transition: all 0.3s ease-in-out;
  border:none;
}

.cta-buttons .btn:hover {
  background-color: #003366; /* Soft Aqua */
  color:white;
  transform: scale(1.05); /* Added scale effect */
}

   #UPLOAD PAGE   
      


h3 {
    color: #3b5998;
    font-weight: bold;
    margin-bottom: 15px;
}

p {
    font-size: 14px;
    color: #555;
}

.step-box .btn {
    background-color: #003366;
    color: white;
    border: none;
    border-radius: 10px;
    font-size: 16px;
    cursor: pointer;
    transition: all 0.3s ease-in-out;
}


@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.step-container {
  margin-bottom: 20px;
   animation: fadeIn 1.2s ease-in-out; 
}

.step-box {
  background-color: #f5f5f5;
  padding: 15px;
  margin: 10px 0;
  border-radius: 10px;
  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.step-box h3 {
  color: #003366;
}

  


/* Prediction Steps Layout */
.prediction-steps-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: 30px;
  padding: 20px;
  
}
.prediction-steps-container h2{
color:#003366;
font-weight:bold;
font-size:40px;
}

.prediction-steps-container .step-box {
width:500px;
  align-items: center;
  margin: 15px 0;
  padding: 20px;
  background-color: #ffffff;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.prediction-steps-container .step-box:hover {
  transform: translateY(-5px);
  box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
}

.step-icon {
  font-size: 30px;
  color: #003366;
  margin-right: 20px;
}

.step-content h4 {
  font-size: 1.5em;
  color: #2A4D70;
}

.step-content p {
  font-size: 1em;
  color: #505050;
}

/* Button and Result Styling */
.box .btn-predict {
  background-color: #003366;
  color: white;
  font-size: 16px;
  padding: 12px 20px;
  border-radius: 5px;
}

#result-container {
  text-align: center;
  background-color: #f1f1f1;
  padding: 40px 20px;
  margin-top: 40px;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

#result-container h3 {
  font-size: 2em;
  color: #2A4D70;
}

#prediction-result {
  font-size: 3em;
  font-weight: bold;
  color: #D32F2F;
  margin-top: 20px;
  font-family:'IBM Plex Mono',cursive
}
.prediction-steps-container .step-box {
  opacity: 0;
  transform: translateY(20px);
  animation: fadeInUp 0.5s forwards;
}

@keyframes fadeInUp {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Apply this animation to each step with different delays */
.prediction-steps-container .step-box:nth-child(1) {
  animation-delay: 0.2s;
}
.prediction-steps-container .step-box:nth-child(2) {
  animation-delay: 0.4s;
}
.prediction-steps-container .step-box:nth-child(3) {
  animation-delay: 0.6s;
}
.prediction-steps-container .step-box:nth-child(4) {
  animation-delay: 0.8s;
}



/* Sidebar styling */
/* Instruction Section for 2D Graphs */
.instruction-container {
  text-align: center;
  background: linear-gradient(to right, #99d9e4, #003366); /* Blue Gradient */
  color: white;
  padding: 30px;
  border-radius: 10px;
  margin-bottom: 20px;
}

.instruction-container h2 {
  font-size: 2em;
  margin-bottom: 10px;
}

.animation-box {
  margin-top: 20px;
  animation: bounce 2s infinite;
}

.icon-large {
  font-size: 40px;
  color: #fff;
}

/* Input Columns for 2D Graphs */
.input-columns {
  display: flex;
  justify-content: space-between;
  margin-bottom: 15px;
}

.input-columns .col-sm-6 {
  margin-right: 10px;
}

/* Spinner for 2D Graphs */
#loading-spinner-2d {
  text-align: center;
  margin-top: 20px;
  color: #003366;
  font-size: 24px;
}






/* Instruction Section */
.instruction-container {
  text-align: center;
  background: linear-gradient(to right, #fbbc77, #003366);
  color: white;
  padding: 30px;
  border-radius: 10px;
  margin-bottom: 20px;
}

.instruction-container h2 {
  font-size: 2em;
  margin-bottom: 10px;
}

.animation-box {
  margin-top: 20px;
  animation: bounce 2s infinite;
}

.icon-large {
  font-size: 40px;
  color: #fff;
}

/* Animation Keyframes */
@keyframes bounce {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-10px);
  }
}

/* Input Columns Styling */
.input-columns {
  display: flex;
  justify-content: space-between;
  margin-bottom: 15px;
   animation: fadeIn 0.5s ease-in-out;
}

.input-columns .col-sm-4 {
  margin-right: 10px;
}

/* Spinner */
#loading-spinner {
  text-align: center;
  margin-top: 20px;
  color: #003366;
  font-size: 24px;
}







/* Styling for Google Login Button */
.btn-google-login,.btn-google-logout {
    background-color: #db4437;
    color: white;
    font-size: 16px;
    border-radius: 5px;
    width: 100%;
    padding: 10px;
    transition: all 0.3s ease;
}

.btn-google-login:hover,.btn-google-logout:hover {
    background-color: #c1351d;
}

/* Instruction Box Styling */
.login-instruction-container {
    background: linear-gradient(to right, #fbbc77, #003366);
    border-radius: 15px;
    padding: 20px;
    text-align: center;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
   
}

.login-instruction-container h2 {
    color: white;
    font-weight: bold;
}

.login-instruction-container .animation-box {
    font-size: 50px;
    color: #db4437;
    margin-top: 20px;
}

/* User Info Styling */
.user-info-container .box {
    background-color: #f0f8ff;
    border-radius: 10px;
}

.user-info-container .box h4 {
    font-size: 18px;
    font-weight: bold;
    color: #003366;
}






  
    "))
    ),
    tabPanel(
      "Home",
      value="home",
      div(
        class = "hero-section",
        h1("Understanding Glacial Lake Outburst Floods (GLOFs)"),
        p(
          "Discover how data-driven models help mitigate risks associated with glacial lakes and prepare for potential outburst events."
        ),
        actionButton("explore_button", "START EXPLORING", class = "btn", 
                     onclick = "document.getElementById('f').scrollIntoView({behavior: 'smooth'});"),
        actionButton("get_started", "GET STARTED", class = "btn1")
      ),
      
      div(
        class = "section",id="f",
        h3("Our Mission"),
        p(
          "We leverage technology and data science to analyze, predict, and visualize the risks of glacial lake outburst floods. Our platform provides essential tools for researchers, policymakers, and disaster response teams."
        ),
        div(
          class = "features-container",
          div(
            class = "feature-box",
            tags$i(
              class = "fa fa-database",
              style = "font-size: 50px; color: #90EE90;"
            ),
            h4("Data Analysis"),
            p("Upload and analyze datasets for real-time insights.")
          ),
          div(
            class = "feature-box",
            tags$i(
              class = "fa fa-chart-line",
              style = "font-size: 50px; color: #FFCCCB;"
            ),
            h4("Predictive Modeling"),
            p("Utilize machine learning models to predict risk levels.")
          ),
          div(
            class = "feature-box",
            tags$i(
              class = "fa fa-globe",
              style = "font-size: 50px; color: #ADD8E6;"
            ),
            h4("Visualization"),
            p("Generate interactive 2D and 3D visualizations for better understanding.")
          )
        )
      ),
      
      div(
        class = "cta-section",
        h3("Get Started Today"),
        p("Choose one of the tools below to begin your journey with us."),
        div(
          class = "cta-buttons",
          actionButton(
            "go_to_prediction",
            "Risk Prediction",
            icon = icon("chart-line"),
            class = "btn btn-success"
          ),
          actionButton(
            "go_to_upload",
            "Upload Data",
            icon = icon("upload"),
            class = "btn btn-warning"
          ),
          actionButton(
            "go_to_graphs",
            "View Graphs",
            icon = icon("chart-bar"),
            class = "btn btn-info"
          )
        )
      )
    ),
    
    tabPanel("Login",
             value="login",
             fluidRow(
               # Instruction Section
               column(12, 
                      div(class = "login-instruction-container",
                          h2("Login to Access Your Dashboard"),
                          p("Use your Google account to sign in and start exploring the flood risk prediction models."),
                          div(class = "animation-box", icon("google", class = "icon-large"))
                      )
               ),
               
               # Google Login Button
               column(12, 
                      div(id="in",
                          box(
                            width = 12, 
                            title = "Login with Google", 
                            status = "primary", 
                            solidHeader = TRUE,
                            actionButton("login_btn", "Login with Google", icon = icon("google"), class = "btn-google-login"),
                            
                            
                          )
                      )
               ),
               
               # User Info Section (Visible after login)
               column(12, 
                      div(class = "user-info-container",id = "out", style = "display: none; text-align: center;",
                          box(
                            width = 12, 
                            title = "User Info", 
                            status = "info", 
                            solidHeader = TRUE,
                            uiOutput("profile_picture"),
                            uiOutput("user_info"),
                            
                            actionButton("logout_btn", "Logout",  icon = icon("sign-out-alt"),class = "btn-google-logout" )
                          )
                          
                          
                          
                      )
                      
                      
               )
             )
    )
    
  ),
  tags$script(HTML("
    Shiny.addCustomMessageHandler('update_tab_label', function(tab_label) {
      $('#main_navbar a[data-value=\"login\"]').text(tab_label);
    });
  "))
)

server <- function(input, output, session) {
  data <- reactiveVal(NULL)
  user_logged_in <- reactiveVal(FALSE)
  # OAuth function for Google login
  google_auth <- function() {
    # Redirect user to Google OAuth 2.0
    oauth_url <- oauth2.0_authorize_url(oauth_endpoint, google_app, scope = "email")
    browseURL(oauth_url)
  }
  
  observeEvent(input$login_btn, {
    req(input$login_btn)
    
    # Initiate OAuth 2.0 authentication
    oauth_endpoints("google")
    myapp <- oauth_app("google", key = google_client_id, secret = google_client_secret)
    goog_auth <- oauth2.0_token(oauth_endpoints("google"), myapp, scope = scopes, cache = FALSE)
    
    # Get user information
    user_info <- GET("https://www.googleapis.com/oauth2/v2/userinfo", config(token = goog_auth))
    user_info_data <- content(user_info)
    
    output$user_info <- renderUI({
      user_info_text <- paste(
        "<div style='font-family: Arial, sans-serif; font-size: 14px; color: #333;'>",
        "<p style='font-weight: bold;'>Hello, ", user_info_data$name, "</p>",
        "<p>Email: <span style='font-style: italic;'>", 
        ifelse(!is.null(user_info_data$email), user_info_data$email, "Not available"), 
        "</span></p>",
        "<p>ID: <span style='color: #007BFF;'>", 
        ifelse(!is.null(user_info_data$id), user_info_data$id, "Not available"), 
        "</span></p>",
        "<p>Birthday: <span style='text-transform: capitalize;'>", 
        ifelse(!is.null(user_info_data$birthday), user_info_data$birthday, "Not available"), 
        "</span></p>",
        "<p>Verified: <span style='color: green;'>", 
        ifelse(!is.null(user_info_data$verified_email), 
               user_info_data$verified_email, 
               "Not available"), 
        "</span></p>",
        "</div>"
      )
      # Render HTML with line breaks
      HTML(user_info_text)
    })
    output$profile_picture <- renderUI({
      # Display profile picture using the URL
      tags$img(src = user_info_data$picture, style = "border-radius: 50%; height: 100px; width: 100px;")
    })
  })
  
  
  
  
  observeEvent(input$login_btn, {
    # When the user clicks the "Login" button, show the modal dialog
    showModal(modalDialog(
      title = "Welcome!",
      "You have successfully logged in!",
      easyClose = TRUE,
      footer = tagList(
        modalButton("Close"),
        actionButton("ok_button", "OK")
      ),
      size = "s"
    ))
  })
  
  observeEvent(input$ok_button, {
    removeModal()  # Close the modal dialog when OK is clicked
  })
  
  observeEvent(input$login_btn, {
    shinyjs::show("out") 
    shinyjs::hide("in")# Show the user info div
    
  })
  
  observeEvent(input$login_btn, {
    user_logged_in(TRUE)  # Set login state to TRUE
    updateNavbarPage(session, "main_navbar", selected = "login")
    session$sendCustomMessage("update_tab_label", "Logout")
    # Add tabs dynamically after login
    
    appendTab(inputId = "main_navbar", tabPanel("Upload Data",
                                                value="ud",
                                                fluidRow(
                                                  # Instruction Section
                                                  column(12,
                                                         div(class = "instruction-container",
                                                             h2("How to Upload and Analyze Your Data"),
                                                             p("Follow these steps to upload your dataset and preview it for analysis."),
                                                             div(class = "animation-box", icon("upload", class = "icon-large"))
                                                         )
                                                  ),
                                                  
                                                  # Step 1: Upload File
                                                  column(12, 
                                                         div(class = "step-container", 
                                                             div(class = "step-box",
                                                                 tags$h3("Step 1: Upload Your File"),
                                                                 tags$p("Upload a CSV file containing your dataset."),
                                                                 fileInput("file", "Upload Dataset (CSV)", accept = ".csv"),
                                                                 actionButton("upload_file", "Upload", class = "btn"),
                                                                 textOutput("upload_message")
                                                             )
                                                         )
                                                  ),
                                                  
                                                  # Step 2: Preview Data
                                                  column(12, 
                                                         div(class = "step-container", 
                                                             div(class = "step-box",
                                                                 tags$h3("Step 2: Preview Data"),
                                                                 tags$p("Preview the first few rows of your uploaded data."),
                                                                 conditionalPanel(
                                                                   condition = "output.isFileUploaded",
                                                                   dataTableOutput("dataset_preview"),
                                                                   tags$p("Ensure the data format and values are correct.")
                                                                 )
                                                             )
                                                         )
                                                  ),
                                                  
                                                  # Step 3: Analyze Data
                                                  column(12, 
                                                         div(class = "step-container", 
                                                             div(class = "step-box",
                                                                 tags$h3("Step 3: Analyze Your Data"),
                                                                 tags$p("Get a quick summary of your dataset or perform specific checks."),
                                                                 conditionalPanel(
                                                                   condition = "output.isFileUploaded",
                                                                   selectInput("analysis_type", "Choose Analysis", 
                                                                               choices = c("Summary", "Missing Values", "Unique Counts")),
                                                                   uiOutput("analysis_result")
                                                                 )
                                                             )
                                                         )
                                                  )
                                                )
    )
    
    
    
    
    )
    appendTab(inputId = "main_navbar", tabPanel("Prediction",
                                                value="p",
                                                fluidRow(
                                                  # Instruction Section
                                                  column(12,
                                                         div(class = "instruction-container",
                                                             h2("How to Predict Flood Risk Score"),
                                                             p("Follow these steps to predict the flood risk score using the provided parameters."),
                                                             div(class = "animation-box", icon("calculator", class = "icon-large"))
                                                         )
                                                  ),
                                                  
                                                  # Prediction Section with Visualized Steps
                                                  column(12, 
                                                         div(class = "prediction-steps-container",
                                                             div(class = "step-box",
                                                                 div(class = "step-icon", icon("check-circle")),
                                                                 div(class = "step-content",
                                                                     h4("Step 1: Enter Parameters"),
                                                                     p("Provide the necessary parameters in the input form to begin the prediction.")
                                                                 )
                                                             ),
                                                             div(class = "step-box",
                                                                 div(class = "step-icon", icon("upload")),
                                                                 div(class = "step-content",
                                                                     h4("Step 2: Upload Data (if required)"),
                                                                     p("If needed, upload a dataset to improve prediction accuracy.")
                                                                 )
                                                             ),
                                                             div(class = "step-box",
                                                                 div(class = "step-icon", icon("calculator")),
                                                                 div(class = "step-content",
                                                                     h4("Step 3: Predict Risk Score"),
                                                                     p("Click the 'Predict Risk Score' button to calculate the risk.")
                                                                 )
                                                             ),
                                                             div(class = "step-box",
                                                                 div(class = "step-icon", icon("flag-checkered")),
                                                                 div(class = "step-content",
                                                                     h4("Step 4: View Results"),
                                                                     p("The flood risk score will be displayed below in real-time.")
                                                                 )
                                                             )
                                                         )
                                                  ),
                                                  
                                                  # Inputs for Prediction
                                                  column(12, 
                                                         box(
                                                           title = "Enter Parameters", width = 12, 
                                                           solidHeader = TRUE, 
                                                           status = "primary", 
                                                           collapsible = TRUE, 
                                                           uiOutput("parameter_inputs"),  # Dynamic input generation
                                                           actionButton("predict", "Predict Risk Score", icon = icon("calculator"), class = "btn-predict")
                                                         )
                                                  ),
                                                  
                                                  # Display Prediction Results
                                                  column(12, 
                                                         div(id = "result-container",
                                                             h3("Prediction Result:"),
                                                             div(id = "prediction-result", 
                                                                 htmlOutput("prediction_result"))
                                                         )
                                                  )
                                                )
    ) )
    appendTab(inputId="main_navbar",    tabPanel("Graphs",
                                                 value = "g",
                                                 fluidRow(
                                                   # Instruction Section
                                                   column(12,
                                                          div(class = "instruction-container",
                                                              h2("Visualize Your Data in 2D"),
                                                              p("Choose the variables for the X and Y axes, select a plot type, and create insightful 2D graphs."),
                                                              div(class = "animation-box", icon("chart-bar", class = "icon-large"))
                                                          )
                                                   ),
                                                   
                                                   # Inputs and Plot Section
                                                   column(12,
                                                          box(
                                                            title = "Create 2D Visualization", width = 12,
                                                            solidHeader = TRUE,
                                                            status = "primary",
                                                            collapsible = TRUE,
                                                            div(class = "input-columns",
                                                                column(6, selectInput("x_var", "X-Axis", choices = NULL)),
                                                                column(6, selectInput("y_var", "Y-Axis", choices = NULL))
                                                            ),
                                                            selectInput("plot_type", "Plot Type",
                                                                        choices = c("Scatter Plot", "Bar Plot", "Line Plot")),
                                                            
                                                            div(id = "loading-spinner-2d", style = "display:none;", icon("spinner", class = "fa-spin")),
                                                            plotOutput("plot_2d", height = "500px")
                                                          )
                                                   )
                                                 )
    )
    )
    appendTab(inputId="main_navbar",    tabPanel("3D Graphs",
                                                 value="graphs",
                                                 fluidRow(
                                                   # Instructions Section
                                                   column(12,
                                                          div(class = "instruction-container",
                                                              h2("Explore 3D Data Visualizations"),
                                                              p("Select variables for the X, Y, and Z axes and choose the type of 3D plot to create."),
                                                              div(class = "animation-box", icon("cubes", class = "icon-large"))
                                                          )
                                                   ),
                                                   
                                                   # Inputs and 3D Plot Section
                                                   column(12,
                                                          box(
                                                            title = "Create 3D Visualization", width = 12,
                                                            solidHeader = TRUE,
                                                            status = "primary",
                                                            collapsible = TRUE,
                                                            div(class = "input-columns",
                                                                column(4, selectInput("x_var_3d", "X-Axis", choices = NULL)),
                                                                column(4, selectInput("y_var_3d", "Y-Axis", choices = NULL)),
                                                                column(4, selectInput("z_var_3d", "Z-Axis", choices = NULL))
                                                            ),
                                                            selectInput("plot_type_3d", "3D Plot Type",
                                                                        choices = c("3D Scatter", "3D Mesh", "3D Line")),
                                                            
                                                            div(id = "loading-spinner", style = "display:none;", icon("spinner", class = "fa-spin")),
                                                            plotlyOutput("plot_3d", height = "500px")
                                                          )
                                                   )
                                                 )
    ))
    
    updateNavbarPage(session, "main_navbar", selected = "home")  # Redirect to Dashboard
  })
  observeEvent(input$get_started, {
    # Redirect to the Login tab
    updateTabsetPanel(session, inputId = "main_navbar", selected = "ud")
  })
  
  
  observeEvent(input$go_to_prediction, {
    updateTabsetPanel(session, inputId = "main_navbar", selected = "p")
  })
  
  
  
  observeEvent(input$go_to_upload, {
    updateTabsetPanel(session, inputId = "main_navbar", selected = "ud")
  })
  observeEvent(input$go_to_graphs, {
    updateTabsetPanel(session, inputId = "main_navbar", selected = "g")
  })
  
  observeEvent(input$logout_btn, {
    showModal(
      modalDialog(
        title = "Confirm Logout",
        "Are you sure you want to log out?",
        easyClose = FALSE,
        footer = tagList(
          modalButton("Cancel"),
          actionButton("confirm_logout", "Logout", class = "btn-danger")
        )
      )
    )
  })
  
  observeEvent(input$confirm_logout, {
    removeModal() # Close the confirmation modal
    
    # Invalidate the token and clear session variables
    session$reload()
    
  })
  
  
  
  
  
  
  
  # Check if a file is uploaded
  output$isFileUploaded <- reactive({
    return(!is.null(input$file))
  })
  outputOptions(output, "isFileUploaded", suspendWhenHidden = FALSE)
  
  # Handle file upload
  observeEvent(input$file, {
    req(input$file)
    data <- read.csv(input$file$datapath)
    
    # File upload message
    output$upload_message <- renderText({
      paste("File uploaded successfully! The dataset has", nrow(data), "rows and", ncol(data), "columns.")
    })
    
    # Dataset preview
    output$dataset_preview <- renderDataTable({
      head(data, 5)
    })
    
    # Analysis results
    observeEvent(input$analysis_type, {
      if (input$analysis_type == "Summary") {
        output$analysis_result <- renderPrint({
          summary(data)
        })
      } else if (input$analysis_type == "Missing Values") {
        output$analysis_result <- renderPrint({
          colSums(is.na(data))
        })
      } else if (input$analysis_type == "Unique Counts") {
        output$analysis_result <- renderPrint({
          sapply(data, function(x) length(unique(x)))
        })
      }
    })
  })
  
  
  
  
  
  
  
  # Handle file upload and model training
  observeEvent(input$file, {
    req(input$file)
    raw_data <- read.csv(input$file$datapath)
    
    data_cleaned <- raw_data[, !(names(raw_data) %in% c("Glacial.Lake.ID"))]
    data_cleaned$Nearby.Glacier..Yes.No. <- as.factor(data_cleaned$Nearby.Glacier..Yes.No.)
    data_cleaned$Seismic.Activity..Yes.No. <- as.factor(data_cleaned$Seismic.Activity..Yes.No.)
    data_cleaned$Moraine.Dam.Type <- as.factor(data_cleaned$Moraine.Dam.Type)
    data_cleaned$Historical.GLO.Events..Yes.No. <- as.factor(data_cleaned$Historical.GLO.Events..Yes.No.)
    data_cleaned$Risk.Score <- as.factor(data_cleaned$Risk.Score)
    
    data(data_cleaned)
    
    output$dataset <- renderDataTable({ datatable(data_cleaned) })
    output$upload_message <- renderText({ "Dataset uploaded successfully!" })
    
    set.seed(42)
    trainIndex <- createDataPartition(data_cleaned$Risk.Score, p = 0.8, list = FALSE)
    train_data <- data_cleaned[trainIndex,]
    
    rf_model <- randomForest(Risk.Score ~ ., data = train_data, ntree = 100, importance = TRUE)
    assign("rf_model", rf_model, envir = .GlobalEnv)
    
    output$parameter_inputs <- renderUI({
      lapply(names(train_data)[-ncol(train_data)], function(var) {
        if (is.factor(train_data[[var]])) {
          selectInput(var, label = var, choices = levels(train_data[[var]]))
        } else {
          numericInput(var, label = var, value = median(train_data[[var]], na.rm = TRUE))
        }
      })
    })
    
    updateSelectInput(session, "x_var", choices = names(data_cleaned))
    updateSelectInput(session, "y_var", choices = names(data_cleaned))
    updateSelectInput(session, "x_var_3d", choices = names(data_cleaned))
    updateSelectInput(session, "y_var_3d", choices = names(data_cleaned))
    updateSelectInput(session, "z_var_3d", choices = names(data_cleaned))
  })
  
  observeEvent(input$predict, {
    req(data(), rf_model)
    
    input_data <- sapply(names(data())[-ncol(data())], function(var) input[[var]])
    input_df <- as.data.frame(t(input_data), stringsAsFactors = FALSE)
    
    for (col in names(input_df)) {
      if (is.factor(data()[[col]])) {
        input_df[[col]] <- factor(input_df[[col]], levels = levels(data()[[col]]))
      } else {
        input_df[[col]] <- as.numeric(input_df[[col]])
      }
    }
    
    prediction <- predict(rf_model, newdata = input_df)
    
    color <- switch(
      as.character(prediction),
      "Very High" = "red",
      "High" = "#FF5722",
      "Medium" = "#FFEB3B",
      "Low" = "green",
      "gray"
    )
    
    output$prediction_result <- renderUI({
      HTML(sprintf("<span style='color:%s;'>Predicted Risk: %s</span>", color, prediction))
    })
  })
  
  output$plot_2d <- renderPlot({
    req(input$x_var, input$y_var)
    ggplot(data(), aes_string(x = input$x_var, y = input$y_var)) +
      {
        if (input$plot_type == "Scatter Plot") geom_point(color = "#5e548e") else
          if (input$plot_type == "Bar Plot") geom_bar(stat = "identity", fill = "#5e548e") else
            if (input$plot_type == "Line Plot") geom_line(color = "#5e548e")
      } +
      theme_minimal()
  })
  
  output$plot_3d <- renderPlotly({
    req(input$plot_type_3d, input$x_var_3d, input$y_var_3d, input$z_var_3d)
    
    if (input$plot_type_3d == "3D Scatter") {
      plot_ly(data = data(), 
              x = ~get(input$x_var_3d), 
              y = ~get(input$y_var_3d), 
              z = ~get(input$z_var_3d), 
              type = 'scatter3d', 
              mode = 'markers',
              marker = list(size = 3, color = "#5e548e")) %>%
        layout(
          scene = list(
            xaxis = list(title = input$x_var_3d),
            yaxis = list(title = input$y_var_3d),
            zaxis = list(title = input$z_var_3d)
          )
        )
    }
    else if (input$plot_type_3d == "3D Mesh") {
      plot_ly(data = data(), 
              x = ~get(input$x_var_3d), 
              y = ~get(input$y_var_3d), 
              z = ~get(input$z_var_3d), 
              type = 'mesh3d',
              color = I("#5e548e")) %>%
        layout(
          scene = list(
            xaxis = list(title = input$x_var_3d),
            yaxis = list(title = input$y_var_3d),
            zaxis = list(title = input$z_var_3d)
          )
        )
    }
    else if (input$plot_type_3d == "3D Line") {
      plot_ly(data = data(), 
              x = ~get(input$x_var_3d), 
              y = ~get(input$y_var_3d), 
              z = ~get(input$z_var_3d), 
              type = 'scatter3d', 
              mode = 'lines',
              line = list(color = "#5e548e", width = 4)) %>%
        layout(
          scene = list(
            xaxis = list(title = input$x_var_3d),
            yaxis = list(title = input$y_var_3d),
            zaxis = list(title = input$z_var_3d)
          )
        )
    }
  })
}

shinyApp(ui= ui, server = server, options =list(port = 3066))
