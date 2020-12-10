java -jar myproject-0.0.1-SNAPSHOT.jar 

debug日志 --debug

指定项目名 --spring.config.name=myproject

指定配置文件 --spring.config.location=classpath:/default.properties,classpath:/override.properties

制定加载目录 -Dloader.path=./config

maven重新打包
<plugin>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-maven-plugin</artifactId>
    <configuration>
        <layout>ZIP</layout>
    </configuration>
</plugin>
