package com.cmcc.hjgh.sample.manager.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.cmcc.hjgh.sample.dao.mybatis.SampleMybatis;
import com.cmcc.hjgh.sample.manager.SampleManager;

@Component
public class SampleManagerImpl implements SampleManager {

	@Autowired
	private SampleMybatis sampleMybatis;
}
