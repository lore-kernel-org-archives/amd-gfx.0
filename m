Return-Path: <SRS0=Hu2c=BR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BFAC433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 09:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BDB82177B
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 09:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XsD79C4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDB82177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D15DB6E98B;
	Fri,  7 Aug 2020 09:08:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 494FA6E98B
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2020 09:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApK8AgFLkr9MCFS+m3tInKusHw3rS/R4zcS92HAL31N31rnkiwA7lXYgPqT+KF6KNI9KFwvZKDZzaV66fY/aLu2FlJPvN+7E+QYC7w0zusalI5J2OcOqRgkWktRdm8UJFdPdYVkmCGoDXv81d1aD+/fR7CVkWFnaluEWpUy16CybkZdfyZ26Gh75FTKqNHCP975LuQYt70qMhF4kqYH0ZM4B+tR3KnXMadboa5+YxDibfUp3t2nxpossZrnKkGfa9qcFmYnvQjmWJLQm4teCYaKijYtuhIj47dr7pHwdphIELpkRf1PuwY85wLqNl2ocQkQPnIUI8wjCnpmHZbxGUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLxSBt9jkjQNZ+3VKHUiCtQUnfj9SR/D7zl4T+0QLAQ=;
 b=OxDg2Npf+NCnCme55mXrmpKjPi01nEkVyGXN6K2EDayghl+rmSWsq/hzxLATZV9dZJy7+cn1YpbS/IsiSeRCtB2TezMTA1XhlZU+hEI5zgYNGEjCDOEoYhqFz1g7EgjKt04TB0Rdla0VFnQRNHPgtapYwvI8zPX2Q4OMgy7WYDCp5iughxNceZO37/tzWsz6wkXc6X8mOO3x+Z11B4aCDdd2JicFKihRv0qVCxGNCSQuKFZ7gMRE1clQyJLtPyRn6A2AyBw0jNc9VxBIeaXIoU4ymUnrKJNzcwFy+xt1WGi4k9N8MXYtKhAhSYVFToWclYAHa+qPt7A0Z2Zqzuq1Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLxSBt9jkjQNZ+3VKHUiCtQUnfj9SR/D7zl4T+0QLAQ=;
 b=XsD79C4mTeDtjNbRfy2nAJHePZDbQ+hfQFjIdurr4BNmhUKZhz5NGQyHO1s7WKszIBrocY5K0DpKCMv0woq7SlpjW6HhRCCiSePzpR48BLAVi1FI+JUuEZcRD7zSu8R86v1+eFAT44V58DgEkeyyqB4+kpzkZj1sXrXsrPvqnBw=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Fri, 7 Aug
 2020 09:08:05 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3239.023; Fri, 7 Aug 2020
 09:08:05 +0000
Subject: Re: [PATCH] drm/amdgpu: annotate a false positive recursive locking
To: "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20200806070230.21457-1-Dennis.Li@amd.com>
 <84678659-b4a6-8332-a71b-28d1b412ae16@gmail.com>
 <DM5PR12MB2533F4B9325903B915AD41F9ED480@DM5PR12MB2533.namprd12.prod.outlook.com>
 <031236ab-0646-bf1c-a93b-aec90bc6dab1@amd.com>
 <SN1PR12MB25447D63750B41887E893668ED480@SN1PR12MB2544.namprd12.prod.outlook.com>
 <cf4bc6ce-fca0-1c45-5665-4085a835196a@amd.com>
 <SN1PR12MB254440D6E152B08D3CA8D4C5ED480@SN1PR12MB2544.namprd12.prod.outlook.com>
 <b5d73714-9064-9baa-e687-406f9f4b1b69@amd.com>
 <DM5PR12MB2533C80EDE996B5E79ED169BED480@DM5PR12MB2533.namprd12.prod.outlook.com>
 <9121c08e-9043-b1fc-414a-03e4d7a280e3@amd.com>
 <DM5PR12MB25335CB16FB3B4CE6584355CED490@DM5PR12MB2533.namprd12.prod.outlook.com>
 <77def862-07d6-1079-b767-0ff4827a6234@amd.com>
 <DM5PR12MB2533453E6A4B046D4C7EE9F3ED490@DM5PR12MB2533.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b4375e2c-d28e-011f-4c6c-b4b05bf87e79@amd.com>
Date: Fri, 7 Aug 2020 11:08:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DM5PR12MB2533453E6A4B046D4C7EE9F3ED490@DM5PR12MB2533.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0093.eurprd07.prod.outlook.com
 (2603:10a6:207:6::27) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR07CA0093.eurprd07.prod.outlook.com (2603:10a6:207:6::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.14 via Frontend Transport; Fri, 7 Aug 2020 09:08:04 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 71565fec-9e07-4fa5-1ef5-08d83ab16533
X-MS-TrafficTypeDiagnostic: MN2PR12MB4360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43600E605BF2D91EC60DCA6883490@MN2PR12MB4360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2SwJHmj6NEicUpJAhcorpm84v+E24VPxT4jrbL4ce0y0KbJoMzBxu7vFC4fubeLxlib6gOXag9mRmiGdozHLGVMszQrKrSvw9DAIvimB5iF9n7nh4LHgza4vuVBfMoj3hfvjrCmTK53vAApHJuftPOybuYMvBPBZL6jteYg4nRUNOHxL1N/3fgTJiqwUsYZdMVqGdzxDCxcTPs8xaLEOnxU6lGrkG7Ks6FaHpq53Hs5oDgzkJODXVvyFXYccroljmr5Rg+5LKqDZHxe1Oh6O0ezkQdqujB+2igvgq6ddfjHDPtHKX1vTxXfM70UizZ+gFP0c+CO1WXz37BBkETXaltDfEpE1Hrus8FNrwESEEWQsVUPYpG7htedumyMFqUUxn4K8dt5//OlKPWUImrYrSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(6666004)(86362001)(83380400001)(478600001)(36756003)(5660300002)(66476007)(66556008)(2616005)(66946007)(52116002)(31686004)(316002)(186003)(8676002)(31696002)(6486002)(2906002)(110136005)(8936002)(16526019)(921003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: skqNvpNWA2a8OJ+k3kjNAzwkACo4WPyxJd6yWhVzh+ACQHala/3KRj/46QHjZ2uuop9ikHsPvDpXtiZ9PcDME6a80uloeH4GMWDSCeCgxmEBTr1i5StWQ5ZhIiV7GjhPr21/8EQhYZSPcfZbUApBPZkqVFnQ6QooN3YCFoToTEJ7LCMVUzFiPtwkh56W7C2FhOKt6+s8mDDJebPrQCsXV99TCUiuI8VqUdCCLLiUI8YIQ11ydaUOV/niJ0V0DVdRVleoSvQqaKemNaUThoCALH+uGPaXyzCi0IBaAuJz5ZvcLcdpLbcl5U/SYDeq3qn/cSrG3Nb/M2NLfL+hr+ZnoT6s083zWFMSunG7BcvuvzR1U/9Cg4dCrSGFaXJ3F3nc3wJfwSN7v+UwFXIFuZsq9IxF2K46pDig/RdzCuarrOm27cpqXthguhB6gfU1WuCRODAaDc5qUy4W5SLkwEs97Nlw8LqK9fh4hMMb/TE6iTQRDPWLJbHwsqTYfplVyQ2ffnEiRbA1AmxZIS9TndtNWsVEXPULYpXEW1Li5e0vthJrkzjPRXN90cSG09f6Ti++PX/gBFKicipQ/DjIe1dPfDOR0h4eh0HF/Q6avC1DpNPjjLrnlwS4ROakk3QDz+IEGseSOMnCfcCBD/2MyrvPimhVJ6eUWRSydfe+bJwt1sY5MURD5AQofvesO2E6T0fZoJpTkOVlmPskCvRhuItG3A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71565fec-9e07-4fa5-1ef5-08d83ab16533
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 09:08:05.6945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lAUfsj9e0ilDaxT9N6+6XhyfeSFcokwmfFLYco7snDZPyLUCXTvwGDZd3Z2dgYP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[SNIP]
>>>> What we should do instead is to make sure we have only a single lock for the complete hive instead.
>>>> [Dennis Li] If we use a single lock, users will must wait for all devices resuming successfully, but in fact their tasks are only running in device a. It is not friendly to users.
>>> Well that is intentional I would say. We can only restart submissions after all devices are resumed successfully, cause otherwise it can happen that a job on device A depends on memory on device B which isn't accessible.
>>> [Dennis Li] Yes, you are right. Driver have make sure that the shared resources(such as the shard memory) are ready before unlock the lock of adev one by one. But each device still has private hardware resources such as video  and display.
>> Yeah, but those are negligible and we have a team working on display support for XGMI. So this will sooner or later become a problem as well.
>>
>> I still think that a single rwsem for the whole hive is still the best option here.
>>
>> [Dennis Li] For your above concern, we can open a new thread to discuss it. If we make a decision to use a single after discussing, we can create another patch for it.
> That's a really good argument, but I still hesitate to merge this patch.
> How severe is the lockdep splat?
>
> At bare minimum we need a "/* TODO: ...." comment why we do this and how to remove the workaround again.
> [Dennis Li] It is not a workaround. According to design of lockdep, each rw_semaphore should has a separated lock_class_key. I have explained that init_rwsem has the above limitation, so we must correct it.

Yeah, but this explanation is not really sufficient. Again this is not 
an limitation of init_rwsem, but intentional behavior.

In other words in most cases lockdep should splat if you use rw 
semaphores like this.

That we avoid this by locking multiple amdgpu device always in the same 
order is rather questionable driver design.

>   Core network driver (net/core/dev.c) has the similar use case with us.

Just took a look at that, but this is completely different use case. The 
lockdep classes are grouped by driver type to note the difference in the 
network stack.

A quick search showed that no other device driver is doing this in the 
kernel, so I'm not sure if such a behavior wouldn't be rejected. Adding 
Daniel to comment on this as well.

Felix had some really good arguments to make that an urgent fix, so 
either we come up with some real rework of this or at least add a big 
"/* TODO....*/".

Regards,
Christian.

>
> Regards,
> Christian.
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
