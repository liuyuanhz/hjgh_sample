package com.cmcc.hjgh.sample.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cmcc.hjgh.sample.manager.SampleManager;
import com.cmcc.hjgh.sample.service.SampleService;

@Service("sampleService")
public class SampleServiceImpl implements SampleService {

	@Autowired
	private SampleManager sampleManager;
	
}
