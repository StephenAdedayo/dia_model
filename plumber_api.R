library(plumber)
library(caret)
library(randomForest)

# Load saved model and dummyVars object
model <- readRDS("model.rds")
dmy <- readRDS("dmy.rds")

# Enable CORS for all endpoints
#* @filter cors
function(req, res){
  res$setHeader("Access-Control-Allow-Origin", "*")
  res$setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS")
  res$setHeader("Access-Control-Allow-Headers", "Content-Type")
  
  if (req$REQUEST_METHOD == "OPTIONS") {
    res$status <- 200
    return(list())
  } else {
    plumber::forward()
  }
}

#* @apiTitle Diabetes Prediction API

#* Predict diabetes
#* @param Age:number
#* @param Gender:string
#* @param Polyuria:string
#* @param Polydipsia:string
#* @param SuddenWeightLoss:string
#* @param weakness:string
#* @param Polyphagia:string
#* @param GenitalThrush:string
#* @param VisualBlurring:string
#* @param Itching:string
#* @param Irritability:string
#* @param DelayedHealing:string
#* @param PartialParesis:string
#* @param MuscleStiffness:string
#* @param Alopecia:string
#* @param Obesity:string
#* @post /predict
function(Age, Gender, Polyuria, Polydipsia, SuddenWeightLoss,
         weakness, Polyphagia, GenitalThrush, VisualBlurring,
         Itching, Irritability, DelayedHealing, PartialParesis,
         MuscleStiffness, Alopecia, Obesity) {

  new_data <- data.frame(
    Age = as.numeric(Age),
    Gender = as.factor(Gender),
    Polyuria = as.factor(Polyuria),
    Polydipsia = as.factor(Polydipsia),
    SuddenWeightLoss = as.factor(SuddenWeightLoss),
    weakness = as.factor(weakness),
    Polyphagia = as.factor(Polyphagia),
    GenitalThrush = as.factor(GenitalThrush),
    VisualBlurring = as.factor(VisualBlurring),
    Itching = as.factor(Itching),
    Irritability = as.factor(Irritability),
    DelayedHealing = as.factor(DelayedHealing),
    PartialParesis = as.factor(PartialParesis),
    MuscleStiffness = as.factor(MuscleStiffness),
    Alopecia = as.factor(Alopecia),
    Obesity = as.factor(Obesity)
  )
  
  new_data_transformed <- data.frame(predict(dmy, newdata = new_data))
  
  prediction <- predict(model, new_data_transformed, type = "prob")[, "Positive"]
  result <- ifelse(prediction > 0.5, "Positive", "Negative")
  
  return(list(prediction = result, probability = prediction))
}
