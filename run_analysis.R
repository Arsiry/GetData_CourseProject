run <- function() {
        
        #downloading information from files
        
        activity_labels<-read.table("./UCI_HAR_Dataset/activity_labels.txt")

        subject_train<-read.table("./UCI_HAR_Dataset/train/subject_train.txt")
        subject_test<-read.table("./UCI_HAR_Dataset/test/subject_test.txt")
        
        X_train<-read.table("./UCI_HAR_Dataset/train/X_train.txt")
        X_test<-read.table("./UCI_HAR_Dataset/test/X_test.txt")
        y_train<-read.table("./UCI_HAR_Dataset/train/y_train.txt")
        y_test<-read.table("./UCI_HAR_Dataset/test/y_test.txt")        

        library(dplyr)
        
        # connecting train  and test sets
        # extracting neded columns
        # also connecting column names
        
        subject<-rbind(subject_train,subject_test)
        colnames(subject)<-"subject"
        
        X<-rbind(X_train,X_test)        
        X_extracts<-select(X, V1:V6, V41:V46, V81:V86, 
                           V121:V126, V161:V166, V201, V202, V214, 
                           V215, V227, V228, V240, V241, V253, V254, 
                           V266:V271, V345:V350, V424:V429, V503, 
                           V504, V516, V517, V529, V530, V542, V543)
        colnames(X_extracts) <- c(
"timeBodyAccMeanX","timeBodyAccMeanY","timeBodyAccMeanZ",
"timeBodyAccStdX","timeBodyAccStdY","timeBodyAccStdZ",
"timeGravityAccMeanX","timeGravityAccMeanY","timeGravityAccMeanZ",
"timeGravityAccStdX","timeGravityAccStdY","timeGravityAccStdZ",
"timeBodyAccJerkMeanX","timeBodyAccJerkMeanY","timeBodyAccJerkMeanZ",
"timeBodyAccJerkStdX","timeBodyAccJerkStdY","timeBodyAccJerkStdZ",
"timeBodyGyroMeanX","timeBodyGyroMeanY","timeBodyGyroMeanZ",
"timeBodyGyroStdX","timeBodyGyroStdY","timeBodyGyroStdZ",
"timeBodyGyroJerkMeanX","timeBodyGyroJerkMeanY","timeBodyGyroJerkMeanZ",
"timeBodyGyroJerkStdX","timeBodyGyroJerkStdY","timeBodyGyroJerkStdZ",
        "timeBodyAccMagMean","timeBodyAccMagStd",
        "timeGravityAccMagMean","timeGravityAccMagStd",
        "timeBodyAccJerkMagMean","timeBodyAccJerkMagStd",
        "timeBodyGyroMagMean","timeBodyGyroMagStd",
        "timeBodyGyroJerkMagMean","timeBodyGyroJerkMagStd",
"frequencyBodyAccMeanX","frequencyBodyAccMeanY","frequencyBodyAccMeanZ",
"frequencyBodyAccStdX","frequencyBodyAccStdY","frequencyBodyAccStdZ",
"frequencyBodyAccJerkMeanX","frequencyBodyAccJerkMeanY","frequencyBodyAccJerkMeanZ",
"frequencyBodyAccJerkStdX","frequencyBodyAccJerkStdY","frequencyBodyAccJerkStdZ",
"frequencyBodyGyroMeanX","frequencyBodyGyroMeanY","frequencyBodyGyroMeanZ",
"frequencyBodyGyroStdX","frequencyBodyGyroStdY","frequencyBodyGyroStdZ",
        "frequencyBodyAccMagMean","frequencyBodyAccMagStd",
        "frequencyBodyAccJerkMagMean","frequencyBodyAccJerkMagStd",
        "frequencyBodyGyroMagMean","frequencyBodyGyroMagStd",
        "frequencyBodyGyroJerkMagMean","frequencyBodyGyroMagStd")
        
        y<-rbind(y_train,y_test)
        merged_y <- merge(y,activity_labels)
        colnames(merged_y)<-c("activityLabel","activityLabelName")
        y_extract<-select(merged_y,activityLabelName)

        rm("X_train")
        rm("X_test")
        rm("X")
        rm("y_train")
        rm("y_test")
        rm("y")
        rm("merged_y")
        rm("subject_train")
        rm("subject_test")
        
        # connecting all neded information
        
        data_tbl<-cbind(subject,X_extracts,y_extract)
        
        data <- tbl_df(data_tbl)
        
        rm("subject")
        rm("X_extracts")
        rm("data_tbl")

        # grouping data

        data_by <- group_by(data,activityLabelName,subject)

        write.table(data_by, file="./UCI_HAR_Dataset/group_data.txt", row.name=FALSE)
}