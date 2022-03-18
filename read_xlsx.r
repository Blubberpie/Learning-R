library("writexl") # Import a library for exporting as Excel file

# Get and set working directory
getwd()
setwd("C:/Dev/projects/r_test/data")

# Load the data, but only from columns 1 to 8
play_data <- read.csv(
    "play.csv",
    header = TRUE,
    sep = ","
)[, 1:8]

# Let's rename the columns. They're quite ugly
# You don't need to do this. But it's a good idea to
# clean up your data.
colnames(play_data) <- c(
    "quarterly",
    "seconds_left",
    "team_a",
    "team_b",
    "play_by_play_details",
    "team_a_score",
    "team_b_score",
    "point_difference"
)

# Show column names
names(play_data)

# Get row
play_data[1, ]

# Get column
play_data[1]

# Define a function that will help us do our job
# your_function_name <- function() { your logic here }
set_quarterly_scores <- function() {
    # Get the necessary columns
    quarter <- play_data[1]
    team_a_scores <- play_data[6]
    team_b_scores <- play_data[7]

    # Set up the result lists
    quarterly_a_scores <- c()
    quarterly_b_scores <- c()

    # The score at the beginning of each quarter
    score_at_start_a <- 0
    score_at_start_b <- 0

    # Keep track of the current quarter number
    last_quarter <- quarter[1, ]

    # Loop through the quarters
    # If the quarter number goes up, then we are at a new quarter
    # If the quarter number goes down, it's the end of the 4th quarter
    # Loop from 1 to the length of the quarter column
    for (i in seq_len(nrow(quarter))) {
        current_quarter <- quarter[i, ]

        # If current quarter is greater than last quarter: for example 3 > 2
        # then we reset the score_at_start variable to the end of quarter score
        if (current_quarter > last_quarter) {
            score_at_start_a <- team_a_scores[i - 1, ]
            score_at_start_b <- team_b_scores[i - 1, ]
        }
        # Otherwise if it is less: for example 1 < 4
        # Then we reset it to 0
        else if (current_quarter < last_quarter) {
            score_at_start_a <- 0
            score_at_start_b <- 0
        }

        # Add to our result list here
        quarterly_a_scores[i] <- team_a_scores[i, ] - score_at_start_a
        quarterly_b_scores[i] <- team_b_scores[i, ] - score_at_start_b
        last_quarter <- current_quarter
    }

    # Let's test our code shall we?
    # Here are the values we expect for quarterly A and B
    ground_truth_a <- c(0, 2, 4, 4, 6, 2, 2, 4, 6, 0, 0, 0, 0, 2, 2, 2, 2, 4, 6, 0, 0, 2, 3, 5, 0, 2, 4, 4, 3, 3, 5, 9, 11, 0, 2, 2, 2, 4) # nolint
    ground_truth_b <- c(0, 0, 0, 2, 3, 2, 4, 4, 4, 2, 5, 7, 9, 11, 2, 2, 4, 6, 8, 0, 2, 4, 6, 8, 2, 4, 6, 6, 1, 1, 4, 4, 4, 2, 4, 6, 8, 12) # nolint

    # Here we tell the program to die and complain if
    # our answer is not the same as the ground truth!
    # This kind of testing is called "assertion"
    #
    # If our answer is correct, the program will simply
    # continue with the next lines
    stopifnot(identical(quarterly_a_scores, ground_truth_a))
    stopifnot(identical(quarterly_b_scores, ground_truth_b))

    # Now that we know our answer is correct, let's
    # add them as new columns to our original table
    play_data$team_a_score_quarterly <- quarterly_a_scores
    play_data$team_b_score_quarterly <- quarterly_b_scores
    write_xlsx(play_data, sprintf("%s/result.xlsx", getwd()))
}

# Execute the function we just created
set_quarterly_scores()
