## Use the officail python 3.11 image
FROM python:3.11

## set the working directory'
WORKDIR /code

## set the working directory contents in the container 
COPY ./requirements.txt /code/requirements.txt

# install the requirements.txt file
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Set up a new user named "user"
RUN useradd user
# Switch to the "user" user
USER user

# Set home to the user's home directory

ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

# set the working directory to the user's home directory
WORKDIR $HOME/app

# Copy the current directory contents into the container at $HOME/app settings the owner to 
COPY --chown=user . $HOME/app

# start the FASTAPI app on port 7860
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7860"]