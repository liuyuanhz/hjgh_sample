package com.cmcc.hjgh.sample.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONObject;
import com.cmcc.hjgh.sample.service.SampleService;
import com.cmcc.hjgh.sample.util.ResponseBuilder;


@RestController
@RequestMapping(value = "/sample")
public class SampleController {
	private static final Logger LOG = LoggerFactory.getLogger(SampleController.class);
	
	@Autowired
	private SampleService sampleService;
	
	@RequestMapping(value = "/test", method = {RequestMethod.GET, RequestMethod.POST})
	public String titleList(HttpServletRequest request, @RequestParam long userId) {
		LOG.info("ENTER /hjgh/sample/test, userId: {}", userId);
		
		String response = ResponseBuilder.success("activityInfo", new JSONObject());
		LOG.info("LEVEL /party/activity/loadInfoById, response: {}", response);
		return response;
	}
}
