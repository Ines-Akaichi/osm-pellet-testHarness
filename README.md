# Evaluation of the Obligation State Manager-Pellet (OSM-Pellet)

This repository provides an **evaluation framework** for testing the generation and execution of **obligations** following **the Obligation Compliance Model Ontotlogy** based on patient information.
It is based on a **data generator** and includes a **test harness** for measuring performance in terms of the number of obligations.

## Overview

The evaluation framework uses two main components:

### 1. Generator [1]
- Generates a configurable number of cumulative **obligations** based on input **subsets of patient information**. An example of subsets of patient information can be found here [2].
- Each obligation instance is generated following the Obligation Compliance Model Ontology
- Supports multiple **temporal cases** to simulate realistic scenarios.
- Each obligation follows a general parameterized template.  The template defines the structural components of an obligation, while entities, resources, actions, and temporal parameters are instantiated dynamically.
For each obligation, the generator creates randomized instances of entities, resources, and actions. Each component is assigned a unique IRI to ensure independence between obligations. The \_{i} suffix is a placeholder index used to generate these unique IRIs for multiple instances of the same type (e.g.,  actions, patients, forms). In this context, entities represent patients, while resources correspond to admission forms. An example of a template can be found below:

```turtle
emr:Patient rdfs:subClassOf :Entity .
emr:AdmissionForm rdfs:subClassOf :Resource .

:elapse :atTime "RANDOM_TIME"^^xsd:long .

:action_{i} a :Action .
:patient_{i} a emr:Patient .
:form_{i} a emr:AdmissionForm .

:obligation_{i} a :Obligation ;
    :obligationContent :temporal_action_{i} ;
    :activationCondition :alwaysTriggered .

:temporal_action_{i} a :TemporalAction ;
    :numericStartTime "START_TIME"^^xsd:long ;
    :numericDeadline "DEADLINE_TIME"^^xsd:long ;
    :actionContent :regulated_action_{i} .

:regulated_action_{i} a :RegulatedAction ;
    :action :action_{i} ;
    :entity :patient_{i} ;
    :resource :form_{i} .
```

### 2. Test Harness
- Evaluates the **execution time** of the OWL Obligation State Manager. 

## Usage

### Running the Generator [1]
1. Configure input parameters (e.g., subsets of patient information, number of obligations) in the benchmark.properties file.  
2. Run the generator to create a set of obligations stored in **Turtle (.ttl) files**.
3. The script for running the Test Harness can be found under the scripts folder.

[1] https://github.com/Ines-Akaichi/osm-abox-generator

[2] https://zenodo.org/records/18891663
