library(shiny)
library(tidyverse)
library(plotly)

mushrooms <- read_csv('mushrooms.csv', 
                      col_types = str_c(rep('f', 23), 
                                         collapse = ''),
                      na = '?')

mushrooms <- mushrooms %>% 
    rename_all(~str_replace_all(., '-', '_')) %>% 
    mutate(class = str_replace_all(class, 
                                   c('^e$' = 'edible',
                                     '^p$' = 'poisonous')),
           cap_shape = str_replace_all(cap_shape, 
                                       c('^b$' = 'bell',
                                         '^c$' = 'conical',
                                         '^x$' = 'convex', 
                                         '^f$' = 'flat',
                                         '^k$' = 'knobbed',
                                         '^s$' = 'sunken')),
           cap_surface = str_replace_all(cap_surface, 
                                         c('^f$' = 'fibrous',
                                           '^g$' = 'grooves',
                                           '^y$' = 'scaly',
                                           '^s$' = 'smooth')),
           cap_color = str_replace_all(cap_color,
                                       c('^n$' = 'brown',
                                         '^b$' = 'buff',
                                         '^c$' = 'cinnamon',
                                         '^g$' = 'gray',
                                         '^r$' = 'green',
                                         '^p$' = 'pink',
                                         '^u$' = 'purple',
                                         '^e$' = 'red',
                                         '^w$' = 'white',
                                         '^y$' = 'yellow')),
           bruises = str_replace_all(bruises,
                                     c('^t$' = 'present',
                                       '^f$' = 'absent')),
           odor = str_replace_all(odor,
                                  c('^a$' = 'almond',
                                    '^l$' = 'anise',
                                    '^c$' = 'creosote',
                                    '^y$' = 'fishy',
                                    '^f$' = 'foul',
                                    '^m$' = 'musty',
                                    '^n$' = 'none',
                                    '^p$' = 'pungent',
                                    '^s$' = 'spicy')),
           gill_attachment = str_replace_all(gill_attachment,
                                             c('^a$' = 'attached',
                                               '^d$' = 'descending',
                                               '^f$' = 'free',
                                               '^n$' = 'notched')),
           gill_spacing = str_replace_all(gill_spacing,
                                          c('^c$' = 'close',
                                            '^w$' = 'crowded',
                                            '^d$' = 'distant')),
           gill_size = str_replace_all(gill_size,
                                       c('^b$' = 'broad',
                                         '^n$' = 'narrow')),
           gill_color = str_replace_all(gill_color,
                                        c('^k$' = 'black',
                                          '^n$' = 'brown',
                                          '^b$' = 'buff',
                                          '^h$' = 'chocholate',
                                          '^g$' = 'gray',
                                          '^r$' = 'green',
                                          '^o$' = 'orange',
                                          '^p$' = 'pink',
                                          '^u$' = 'purple',
                                          '^e$' = 'red',
                                          '^w$' = 'white',
                                          '^y$' = 'yellow')),
           stalk_shape = str_replace_all(stalk_shape,
                                         c('^e$' = 'enlarging',
                                           '^t$' = 'tapering')),
           stalk_root = str_replace_all(stalk_root,
                                        c('^b$' = 'bulbous',
                                          '^c$' = 'club',
                                          '^u$' = 'cup',
                                          '^e$' = 'equal',
                                          '^z$' = 'rhizomorphs',
                                          '^r$' = 'rooted')),
           stalk_surface_above_ring = str_replace_all(stalk_surface_above_ring,
                                                      c('^f$' = 'fibrous',
                                                        '^y$' = 'scaly',
                                                        '^k$' = 'silky',
                                                        '^s$' = 'smooth')),
           stalk_surface_below_ring = str_replace_all(stalk_surface_below_ring,
                                                      c('^f$' = 'fibrous',
                                                        '^y$' = 'scaly',
                                                        '^k$' = 'silky',
                                                        '^s$' = 'smooth')),
           stalk_color_above_ring = str_replace_all(stalk_color_above_ring,
                                                    c('^n$' = 'brown',
                                                      '^b$' = 'buff',
                                                      '^c$' = 'cinnamon',
                                                      '^g$' = 'gray',
                                                      '^o$' = 'orange',
                                                      '^p$' = 'pink',
                                                      '^e$' = 'red',
                                                      '^w$' = 'white',
                                                      '^y$' = 'yellow')),
           stalk_color_below_ring = str_replace_all(stalk_color_below_ring,
                                                    c('^n$' = 'brown',
                                                      '^b$' = 'buff',
                                                      '^c$' = 'cinnamon',
                                                      '^g$' = 'gray',
                                                      '^o$' = 'orange',
                                                      '^p$' = 'pink',
                                                      '^e$' = 'red',
                                                      '^w$' = 'white',
                                                      '^y$' = 'yellow')),
           veil_type = str_replace_all(veil_type,
                                       c('^p$' = 'partial',
                                         '^u$' = 'universal')),
           veil_color = str_replace_all(veil_color,
                                        c('^n$' = 'brown',
                                          '^o$' = 'orange',
                                          '^w$' = 'white',
                                          '^y$' = 'yellow')),
           ring_number = str_replace_all(ring_number,
                                         c('^n$' = 'none',
                                           '^o$' = 'one',
                                           '^t$' = 'two')),
           ring_type = str_replace_all(ring_type,
                                       c('^c$' = 'cobwebby',
                                         '^e$' = 'evanescent',
                                         '^f$' = 'flaring',
                                         '^l$' = 'large',
                                         '^n$' = 'none',
                                         '^p$' = 'pendant',
                                         '^s$' = 'sheathing',
                                         '^z$' = 'zone')),
           spore_print_color = str_replace_all(spore_print_color,
                                               c('^k$' = 'black',
                                                 '^n$' = 'brown',
                                                 '^b$' = 'buff',
                                                 '^h$' = 'chocolate',
                                                 '^r$' = 'green',
                                                 '^o$' = 'orange',
                                                 '^u$' = 'purple',
                                                 '^w$' = 'white',
                                                 '^y$' = 'yellow')),
           population = str_replace_all(population,
                                        c('^a$' = 'abundant',
                                          '^c$' = 'clustered',
                                          '^n$' = 'numerous',
                                          '^s$' = 'scattered',
                                          '^v$' = 'several',
                                          '^y$' = 'solitary')),
           habitat = str_replace_all(habitat,
                                     c('^g$' = 'grasses',
                                       '^l$' = 'leaves',
                                       '^m$' = 'meadows',
                                       '^p$' = 'paths',
                                       '^u$' = 'urban',
                                       '^w$' = 'waste',
                                       '^d$' = 'woods'))) %>% 
    mutate_all(list(str_to_sentence)) %>% 
    rename_all(~str_replace_all(., '_', ' ') %>% str_to_title()) %>% 
    mutate_all(as.factor)
mushrooms

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel('Mushroom Edibility'),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = 'x',
                        label = 'Mushroom Characteristic:',
                        choices = mushrooms %>% 
                            select(-Class) %>% 
                            colnames())
        ),

        # Show a plot of the generated distribution
        mainPanel(
           textOutput('title'),
            
           plotlyOutput('barplot'),
        
           dataTableOutput('table')
           )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$title <- renderText({
        str_glue("Mushroom Edibility by {str_replace_all(input$x, '_', ' ') %>% str_to_title()}")
    })
    
    output$table <- renderDataTable({
        mushrooms %>% 
            count(Class, !!sym(input$x), .drop = FALSE) %>% 
            rename('Count' = n)
    })
    
    output$barplot <- renderPlotly({
        
        df <- mushrooms %>% 
            count(Class, !!sym(input$x), .drop = FALSE) %>% 
            rename('x' = !!sym(input$x), 'Count' = n)
        
        ggplotly({
            df %>% 
                ggplot(aes(x = fct_reorder(x, .x = Count, .desc = TRUE),
                           y = Count,
                           fill = Class,
                           text = str_c(str_c(input$x, ': '), x, '<br>',
                                        'Edibility: ', Class, '<br>',
                                        'Count: ', Count))) +
                    geom_col(position = 'dodge') +
                    labs(x = str_replace_all(input$x, '_', ' ') %>% 
                                str_to_title()) +
                    scale_x_discrete(drop = FALSE) +
                    theme_minimal(base_family = 'Source Sans Pro') +
                    theme(panel.grid.major.x = element_blank(),
                          axis.text.x = element_text(vjust = 5))
        }, tooltip = 'text')    
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
