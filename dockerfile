# pull official base image
FROM node:current

# set working directory
WORKDIR /


# add `/node_modules/.bin` to $PATH
ENV PATH /node_modules/.bin:$PATH

# install app dependencies
COPY package.json ./

RUN npm install 
RUN npm install -y
RUN npm install -g @angular/cli

# add app
COPY . ./

EXPOSE 4200

# start app
CMD ["ng","serve"]

