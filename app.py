from fastapi import FastAPI
from transformers import pipeline

## create a new FastAPI app instance
app=FastAPI()

## Intialize the text generator
pipe = pipeline("text2text-generation", model="google/flan-t5-small")

@app.get("/")
def home():
    return {"message": "Hello, world!"}

# Define a function to handle the GET request at '/generate'

@app.get("/generate")
def generate(text:str):
    # use the pipeline to generate the text from given input text
    output=pipe(text)
    
    # return the generate text in  json response    
    return {"output": output[0]['generated_text']}