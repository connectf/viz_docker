FROM         ubuntu
MAINTAINER    viz

#把java与tomcat添加到容器中
ADD jdk-8u91-linux-x64.tar.gz /usr/local/
ADD apache-tomcat-7.0.69.tar.gz /usr/local/
ADD be.war /usr/local
ADD fe.war /usr/local
ADD backend.sql /usr/local

#配置java与tomcat环境变量
ENV JAVA_HOME /usr/local/jdk1.8.0_91
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $JAVA_HOME/bin:$PATH

#容器运行时监听的端口
EXPOSE  8080 8081
