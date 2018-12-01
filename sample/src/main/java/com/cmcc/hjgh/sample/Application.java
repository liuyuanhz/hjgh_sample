package com.cmcc.hjgh.sample;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.embedded.ConfigurableEmbeddedServletContainer;
import org.springframework.boot.context.embedded.EmbeddedServletContainerCustomizer;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;


@Configuration
@SpringBootApplication
@ImportResource({ "classpath:spring-context.xml" })
public class Application implements EmbeddedServletContainerCustomizer{
	private static final Logger LOG = LoggerFactory.getLogger(Application.class);
	
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
        LOG.info("Started sample server");
    }
    
    @Value("#{configProperties['sample.port']}")
    private String samplePort;

    public Integer getSamplePort(){
        return Integer.parseInt(samplePort);
    }
    
    @Value("#{configProperties['sample.context-path']}")
    private String sampleContextPath;

    public String getSampleContextPath(){
        return sampleContextPath;
    }

	@Override
	public void customize(ConfigurableEmbeddedServletContainer container) {
		LOG.info("[############# SpringBoot Port:" + getSamplePort() + " #############]");
		LOG.info("[############# SpringBoot Context Path:" + getSampleContextPath() + " #############]");
		container.setPort(getSamplePort());
		container.setContextPath(getSampleContextPath());
	} 

}