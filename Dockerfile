# a base image for all nodejs images built on centos7 and setup with nodejs 8.
FROM centos:centos7

# installing the NodeSource Node.js 8.x repo...
RUN curl -sL https://rpm.nodesource.com/setup_8.x | bash -

# install nodejs
RUN yum install nodejs -y

# set env variables
ENV base_dir /usr/src/app
ENV code_dir ${base_dir}/code
ENV data_dir ${base_dir}/data

# create dirs
RUN mkdir ${base_dir}; mkdir ${code_dir}; mkdir ${data_dir}

# set the working dir
WORKDIR ${code_dir}

# copy the application files
COPY . ./

# RUN npm install (--only=production to exclude devDependencies)
RUN npm install --only=production

# expose service port
EXPOSE 3030

# run application
CMD [ "node", "app.js" ]
