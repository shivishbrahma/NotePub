---
title: Data Handling Using R
author: Purbayan Chowdhury(@shivishbrahma)
created_ts: 2024-06-29 20:56:32
edited_ts: 2024-07-07 15:47:04
tags: [r, "data handling", dplyr, "datatable", "dataframe"]
course_id: 55199
---

- [Built in DataSets in R](#built-in-datasets-in-r)
    - [Assignment - Data Frames](#assignment---data-frames)
- [Installing packages](#installing-packages)
- [Data Tables](#data-tables)
    - [Assignment - Data Tables](#assignment---data-tables)
- [Using lapply and sapply](#using-lapply-and-sapply)
    - [Assignment - Loop Functions](#assignment---loop-functions)
- [Data Import](#data-import)
    - [CSV](#csv)
    - [txt](#txt)
    - [Copy xlsx and use below command](#copy-xlsx-and-use-below-command)
    - [ODBC](#odbc)
- [Web Scrapping](#web-scrapping)
- [dplyr](#dplyr)
    - [Intro to dplyr](#intro-to-dplyr)
    - [Data structure - tbl](#data-structure---tbl)
    - [Assignment - Intro to dplyr](#assignment---intro-to-dplyr)
    - [Assignment - dplyr Verbs and Functions](#assignment---dplyr-verbs-and-functions)
    - [Pipe Operator Use](#pipe-operator-use)
- [Join](#join)
    - [Assignment - Set Operations](#assignment---set-operations)
    - [Assignment - Creating Contingency Tables](#assignment---creating-contingency-tables)
    - [Practice Exercise 1](#practice-exercise-1)


```r
name <- c("A", "P", "F", "J", "C")
age <- c(28, 30, 21, 39, 35)
child <- c(FALSE, TRUE, TRUE, FALSE, TRUE)

df <- data.frame(name, age, child)
names(df) <- c("Name", "Age", "Child")
```

### string as factor

```r
df <- data.frame(name, age, child, stringsAsFactors = FALSE)
```

## Built in DataSets in R

```r
library(datasets)
library(help=datasets)
?USArrests
fix(USArrests)
summary(USArrests)
fivenum(USArrests)

str(USArrests)
colnames(USArrests)
rownames(USArrests)

nrow(USArrests)
ncol(USArrests)

USArrests[1, 1]
USArrests[, c(2,4)]

people[3, 2]
people[3, "age"]
people[3, ]
people[, "age"]

people[c(3, 5), c("age", "child")]
people[2] # return column
people["age"]
people$age
people[[2]] #return column list
people[["age"]]

# add a column

weight <- c(74, 63, 68, 55, 56)
cbind(people, weight)

tom <- data.frame("Tom", 37, FALSE, 183)
rbind(people, tom) # error

tom <- data.frame(name = "Tom", age = 37, child = FALSE, height = 183)
rbind(people, tom)

# sorting

sort(people$age)
ranks <- order(people$age)
ranks
people[ranks,]
people[order(people$age, decreasing = TRUE), ]

which(rdf$e1 > 22)
rdf[which(rdf$e1 > 22), ]

rdf[, which(names(rdf) %in% c("c1", "d1"))]
rdf[which(rdf[, 5]>22),]

rdf[order(rdf$e1), ]
rdf[order(-rdf$e1), ]
rdf[rev(order(rdf$e1)), ]

attach(rdf)

# matrices

m1 <- matrix(1:100, nrow=10)
m2 <- as.matrix(rdf)
m3 <- cbind(a, b, c, d, e)
m4 <- rbind(a, b, c, d, e)

object.size(m3)
```

### Assignment - Data Frames

```r
data_handle_1 <- function() {
    name <- c("A", "B", "C", "D", "E")
    age <- c(10, 11, 12, 13, 14)
    department <- c("AA", "BB", "CC", "DD", "EE")
    empdetails <- data.frame(name, age, department)
    print(empdetails)
    details <- str(empdetails)
    print(details)

    details <- str(mtcars)
    print(details)
    print(summary(mtcars))

    print(mtcars[c(1,2,10)])

    print(mtcars[order(mtcars$mpg),])
    mtcars_mpg30 <- mtcars[which(mtcars$mpg > 30),]
    print(mtcars_mpg30)

    print(mtcars_mpg30[order(-mtcars_mpg30$mpg, -mtcars_mpg30$disp),])
}
data_handle_1()
```

## Installing packages

```r
install.packages("dplyr")
library("dplyr")
x <- c(1,2,3,4,5)
mfv(x)
detach("package:dplyr", unload=TRUE)
remove.packages("dplyr")

library(data.table)

# data.table

mtcarsDT[
    mpg > 20,
    .(AvgHP = mean(hp),
    "MinWT(kg)" = min(wt*453.6)), # wt lbs
    by = .(cyl, under5gears = gear < 5)
]
```

## Data Tables

The Syntax of datatables: - `DT[i, j, by]`

```r
DT <- data.table(A=1:6, B=c("a", "b", "c"), C=rnorm(6), D=TRUE)

typeof(1) == "double" i.e. "numeric"
typeof(1L) == "integer"

typeof(NA) == "logical"
typeof(NA_integer_) == "integer"

class(DT) # "data.table" "data.frame"

DT[, .(B, C)]

# Computing on columns

DT[, .(Total = sum(A), Mean = mean(C))]

# Recycling in j

DT[, .(B, C=sum(C))]

DT[, plot(A,C)]

DT[, {  print(A)
        hist(C)
        NULL }]

DT[, .(MySum = sum(B),
     MyMean = mean(B)),
     by = .(A)]

DT[, .(MySum = sum(B)), by = .(Grp = A%%2)]

DT[, sum(B), by = A%%2]

# Grouping only on a subset

DT[2:4, sum(B), by = A%%2]
```

### Assignment - Data Tables

```r
data(mtcars)
library(data.table)
data_table <- function(){
    mt <- as.data.table(mtcars)
    mt[
        mpg > 15,
        .(AvgHp=mean(hp), AvgWt=mean(wt)),
        by = .(cyl, carb)
    ]
}
data_table()
```

## Using lapply and sapply

- lapply : Loop over a list and evaluate a function on each element
- sapply : Same as lapply but try to simplify the result
- apply  : Apply a function over the margins of an array
- tapply : Apply a function over subsets of a vector
- mapply : Multivariate version of lapply

```r
function(X, FUN, ...)
{
    FUN <- match.fun(FUN)
    if(!is.vector(X) || is.object(X))
        X <- as.list(X)
    .Internal(lapply(X, FUN))
}

lapply(x, mean)

lapply(x, function(elt) elt[, 1])

sapply(x, mean)

m <- matrix(c(1:10, 11:20), nrow = 10, ncol = 2)
apply(m, 1, mean)

# Returns:  [1]  6  7  8  9 10 11 12 13 14 15

a <- array(rnorm(2*2*10), c(2,2,10))
apply(a, c(1,2), mean)
rowMeans(a, dims = 2)

tapply(iris$Petal.Length, Species, mean)

# setosa   versicolor   virginica

# 1.462     4.260       5.552

s <- split(airquality, airquality$Month)

interaction(f1, f2)

l1 <- list(a = c(1:10), b = c(11:20))
l2 <- list(c = c(21:30), d = c(31:40))
mapply(sum, l1$a, l1$b, l2$c, l2$d)

# Returns:[1]  64  68  72  76  80  84  88  92  96 100

noise(5, 1, 2)
```

### Assignment - Loop Functions

```r
loops <- function(){
    ## task 1
    maths <- c(70, 75, 80, 85, 90)
    science <- c(71, 76, 81, 86, 91)
    english <- c(73, 78, 83, 88, 93)
    ## Create a list using the vectors
    scores_list <- list(maths, science, english)
    ## Calculate class average using lapply
    print(lapply(scores_list, mean))

    ## task 2
    s1 <- c(70, 80, 90)
    s2 <- c(71, 81, 91)
    s3 <- c(72, 82, 92)
    s4 <- c(73, 83, 93)
    student_scores_list <- list(s1, s2, s3, s4)
    print(sapply(student_scores_list, mean))

    ## task 3
    matrix_data <- matrix(1:50, nrow = 10, ncol = 5, byrow = FALSE)
    print(apply(matrix_data, 2, mean))

    ## task 4
    data(mtcars)
    print(tapply(mtcars$mpg, list(mtcars$cyl, mtcars$am), mean))

    ## task 5
    x <- c(1:5)
    y <- c(6:10)
    print(mapply(function(a, b) a * b, x, y))
}
loops()
```

## Data Import

### CSV

```r
read.csv("mat_db.csv") -> dt
write.csv(dt, "new_mat_db.csv", row.names = F)
```

### txt

```r
read.table("sample.txt", fill = T, header = F) -> a
```

### Copy xlsx and use below command

```r
read.table("clipboard", header=T, sep="\t")

# read.delim(file, header = FALSE, sep = "\t", quote = "\"",  dec = ".", fill = TRUE, comment.char = "", ...)

read.table("another.txt", fill=T, header=F,
colClasses=c("character", "character", "character", "character"),
nrow = 10, skip = 5) -> a
```

### ODBC

```r
install.packages("RODBC")
con <- odbcConnect("DemoData", uid="rob", pwd="treebird")
babynames <- sqlQuery(con, "SELECT StateCode, COUNT(*) FROM BabyNames
WHERE [YEAR] = 2012 GROUP BY DESC")
plot(babynames)
```

## Web Scrapping

```r
install.packages("rvest")

weather_link <- ""
forecast_html <- html_nodes(weatherlink, ".forecast-text")
forecast_text <- html_text(forecast_html)
forecast_text
paste(forecast_text, collapse=" ")
```

## dplyr

### Intro to dplyr

```r
install.packages("dplyr")
install.packages("hflights")
library(dplyr)
library(hflights)
```

### Data structure - tbl

```r
hflights <- as_tibble(hflights)
glimpse(hflights)
```

### Assignment - Intro to dplyr

```r
library("dplyr")
hflights <- read.csv("hflights.csv")
dplyrs <- function(){
    print(dim(hflights))

    print(head(hflights))
    print(tail(hflights))
    
    print(head(hflights, n=20))
    
    glimpse(hflights)
    
    hflights1 <- data.frame(head(hflights, 50))
    hflights1_tbl <- tbl_df(hflights1)
    carriers <- hflights1_tbl$UniqueCarrier
    print(carriers)
    
    abrCarrier <- c("AA" = "American", "AS" = "Alaska", "B6" = "JetBlue", "CO" = "Continental", "DL" = "Delta", "OO" = "SkyWest", "UA" = "United", "US" = "US_Airways", "WN" = "Southwest", "EV" = "Atlantic_Southeast", "F9" = "Frontier", "FL" = "AirTran", "MQ" = "American_Eagle", "XE" = "ExpressJet", "YV" = "Mesa")
    hflights$Carrier <- mapply(function(a) abrCarrier[a], hflights$UniqueCarrier)
    print(head(hflights, 10))
}
dplyrs()

# Five Verbs of dplyr - select, filter, mutate, arrange, summarize

filter(hflights, DayofMonth>15, Month==1)

select(hflights, Year : DayofMonth)

hflights1 <- mutate(hflights,  Distance_Km= Distance*2.2)

arrange(hflights, year, month, day)

summarise(hflights, mean(ArrDelay, na.rm = TRUE))

summarise(group_by(airquality, Month), mean(Temp, na.rm = TRUE))
```

### Assignment - dplyr Verbs and Functions

```r
library("dplyr")
hflights <- read.csv("hflights.csv")
dplyr_verbs <- function (){
    #1
    hflights %>% filter(FlightNum == 428 |FlightNum == 460) %>% print

    #2
    hflights1 <- hflights %>% head(20) %>% as.data.frame 
    hflights1 %>% select(FlightNum, contains("Time")) %>% print

    #3
    hflights1 %>% mutate(velocity=Distance*60/AirTime) %>% print

    #4
    hflights1 %>% arrange(desc(ArrTime)) %>% print

    #5
    hflights %>% group_by(UniqueCarrier) %>% summarise(n_flights=n(), n_canc=sum(Cancelled)) %>% print

    #6
    hflights %>% group_by(Month) %>% summarise(mean(ArrDelay, na.rm=TRUE)) %>% print
}
dplyr_verbs()
```

### Pipe Operator Use

```r
hflights %>%
mutate(speed=Distance/AirTime) %>%
group_by (FlightNum) %>%
summarise(avgspd=mean(speed, na.rm = TRUE)) %>%
arrange(desc(avgspd))

mflights<-mutate(hflights, speed=Distance/AirTime)
sflights<-summarise(group_by(mflights, FlightNum), avgspd=mean(speed, na.rm = TRUE))
arrange(sflights, desc(avgspd))
```

## Join

```r
# df1 - left

# df2 - right
df1 %>% inner_join(df2, by = "customer_id")

df1 %>% left_join(df2, by = "customer_id")

df1 %>% right_join(df2, by = "customer_id")

df1 %>% full_join(df2, by = "customer_id")

df1 %>% anti_join(df2, by = "customer_id")

# intersect(x, y, ...)

# union(x, y, ...)

# union_all(x, y, ...)

# setdiff(x, y, ...)
```

### Assignment - Set Operations

```r
data(mtcars)
library(dplyr)
sets <- function() {
    first <- mtcars[1:6,]
    second <- mtcars[6:15,]
    print(intersect(first, second))
    print(union(first, second))
    print(union_all(first, second))
    print(setdiff(first, second))
}
sets()

# Cut, pretty and range

cut(rpois(100,6), range(rpois(100,6))[1], range(rpois(100,6))[2])
cut(rpois(100,6), pretty(rpois(100,6)))

table(USArrests[,3])

table(cut(USArrests[,3], pretty(USArrests[,3])))

table(cut(USArrests[,3], pretty(USArrests[,3], 4)))

table(airquality[,4], airquality[,5])

table(cut(airquality[,4], pretty(airquality[,4])), airquality[,5]) -> a

prop.table(a, 1)
```

### Assignment - Creating Contingency Tables

```r
data(mtcars)
print(table(cut(mtcars$mpg, breaks = pretty(mtcars$mpg))))

# Data Handling - test your knowledge

library(dplyr)
data(mtcars)
data_oper <- function(){
    #Enter code below
    #Task 1
    #Use mtcars dataset and print the first 6 rows after ordering the dataset based on column mpg.
    #Hint: Use order() function
    print(head(mtcars[order(mtcars$mpg),], 6))

    #Task 2
    #Use mtcars dataset, Print rows having mpg greater than 30 and gear equal to 4. 
    #Hint: Use filter() function.
    print(filter(mtcars, mpg > 30, gear ==4))
    
    #Task 3
    #Perform select operation using columns mpg,cyl,disp,gear on mtcars dataset.
    #Print the first 5 rows.
    print(head(select(mtcars, mpg, cyl, disp, gear), 5))
    

    #Task 4
    #Use mtcars, Mutate column mpg in the mtcars by applying round function on mpg, store it in variable s2.
    #Print the first 5 rows of s2.
    s2<-mutate(mtcars, mpg=round(mpg))
    print(head(s2, 5))
    
    
    #Task 5
    #Arrange the dataset s2 based on the columns mpg,cyl,disp.
    #Print the first 6 rows after arrange operation.
    print(head(arrange(s2, mpg,cyl,disp), 6))
    
    #Task 6
    #Print the summary of column wt. Use mtcars dataset.
    print(summary(mtcars$wt))
    
    #Task 7
    # Use mtcars dataset. Categorize the values of a column mpg . Break it in to intervals (0 to 15,15 to 20,20 to 30) , label them as "Low","Medium","High".
    #Create a table after categorizing.
    #Print the table.
    #Hint: Use table() an cut() functions together.
    intervals <- c(0, 15, 20, 30)
    labels <- c("Low", "Medium", "High")
    print(table(cut(mtcars$mpg, breaks = intervals, labels = labels)))
    
    #End  
    }
data_oper()
```

### Practice Exercise 1

```r
# USArrests :- Select 25% of states with least Murder's with: 1) Row Positions Changed 2) Row Positions Unchanged

USArrests %>% arrange(Murder) %>% head(round(nrow(USArrests)*0.25))
USArrests[which(USArrests[,1] <= quantile[USArrests[,1]](2)),]

# Practice Exercise 2

# USArrests :- Urban Population > 75 or Rape > 20

USArrests[which(USArrests[, 3] > 75 | USArrests[, 4] > 20), ]

# Practice Exercise 3 -dplyr Verbs & Functions

```
