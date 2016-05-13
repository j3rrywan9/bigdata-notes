# Machine Learning

## What is Data Mining?
Combination of AI and statistical analysis to discover information that is "hidden" in the data.

Associations
Sequences
Classifications
Forecasting
Anomalies
Grouping/Clusters/Segments

## How does Machine Learning work?
Explore Data
Finds patterns
Performs predictions

## Three Sets
training data, validation data, and test data.

## KNIME

### Naive Bayes Assignment
Create a KNIME workflow that utilizes the Naive Bayes method to train a model on the Adult training data set.

The Naive Bayes method is available in the Node Repository panel under "Analytics" -> "Mining" -> "Bayes" category. There are two different nodes: "Naive Bayes Learner" and "Naive Bayes Predictor".

#### Naive Bayes Learner
The "Naive Bayes Learner" node creates a Bayesian model from the input training data. It calculates the distributions and probabilities to define the Bayesian model's rules from the traning data.

### Decision Tree Assignment
Create a KNIME workflow that utilizes the Decision Tree learning method to train a model on the Iris training data set.

The Decision Tree method is available in the Node repository panel under "Analytics" -> "Mining" -> "Decision Tree" category. There are two different nodes: "Decision Tree Learner" and "Decision Tree Predictor".

#### Decision Tree Learner
The "Decision Tree Learner" node creates a Decision Tree model from the input training data.

#### Decision Tree Predictor
The "Decision Tree Predictor" node applies an existing Decision Tree model to the input data table.

## Spark MLlib

### Data Types

#### Arrays

#### Vectors

#### LabeledPoints

### Classification and Regression
The **spark.mllib** package supports various methods for binay classification, multiclass classification, and regression analysis.

#### Naive Bayes

## Mining Association Rules

## Clustering

## Resources
### The Adult data set
[Adult Data Set](http://archive.ics.uci.edu/ml/datasets/Adult)

[Data](https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data)

### The Iris data set
[Iris Data Set](http://archive.ics.uci.edu/ml/datasets/Iris)

[Association rule learning](https://en.wikipedia.org/wiki/Association_rule_learning)

[Data](https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data)
