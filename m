Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C8DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 17:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E1961262
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 17:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 86E1961262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 227D76EC48;
	Fri,  5 Nov 2021 17:48:28 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2078.outbound.protection.outlook.com [40.107.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F4F86EC48
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 17:48:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFt10erxc7G0cnuijoA1KsMjKlYT6I5V/xtkFiD6+vSI5bSOfAR6LlfAM0MyysLGZigb3OcWCbMdJg84AnwMwfKmecu4/GSs1M82/27Me1+RIaol/5xNB7kGJ29ADZnS0WJ161a06h9MVoLsfI7DfaLm9/L0Yz5+639OIx0+UpMMwBJlfeerS+/8TXt6FutwdIWTaVo36J01KyLrLZzrudsQN518115bwP9srJHWGoO8fygAQffxsYeo84COPqIuyErpU7ykeItBze5KZcvaSX4FajvwPKtDt4HcoWXYpuPyV9MoRH0wBtXf4nXQdH3f4OE50uZmNFCMykgvGKdV3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJmPjGo6sZ6g12/CZR7bbua9kPxo4Y9rAAsR1qYk/og=;
 b=H2ZAso07g94sVjZT2htPkG9Eb8ayafI7gWyo8AXQqHjggDXmQbaGnVhcYYXWLMust02zZaTUyQePny/4oWUaiFjBTeTLcS79oYDX579JITITHZrUYkynx8n/e5YJTtNqo411sFR/kaTi8xJHn0K4Y7y8Ae1leeEzCZ2xUBihfNViypfsHwraQa6R5rndUU592P3tHyDrZ5opaGVXsX8+S+Tg28BoZ470fuPZl4S0nLFdNuByMw4qkRkZepivak5I8z4/P55hlFv4smIBHYb1xq2bnxZ7Ma/iG0Of/fXQVFoCpORZVI6g4in2YO+9ohcBYo5ECxRSWnZgkJlpWKJSWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJmPjGo6sZ6g12/CZR7bbua9kPxo4Y9rAAsR1qYk/og=;
 b=iA/HMobktcMJmZGA3JDG6nfPc5uSOEFy8pC2cnAuFF9+MdMpjbN/Ww6nQ5XthDnGePO2LsSU322wCF4wjtwDIiMprEf05TMfbSnPg2p1uor6rqCFv9uL001rFifg/BKoISNkkfHP//3uhZ303SA5iMjvIFlsQyUcv8Nbp7rKORA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB4546.namprd12.prod.outlook.com (2603:10b6:5:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 17:48:25 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 17:48:24 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: fix the kfd pre_reset sequence in sriov
To: shaoyunl <shaoyun.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211105165741.2617-1-shaoyun.liu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <3b5fe2ba-d03c-b2ca-df69-f7b27dfd4ce7@amd.com>
Date: Fri, 5 Nov 2021 13:48:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211105165741.2617-1-shaoyun.liu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: LO2P265CA0038.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::26) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 LO2P265CA0038.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:61::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10 via Frontend Transport; Fri, 5 Nov 2021 17:48:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e99d3eff-c8af-40a3-46a3-08d9a084772f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4546:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4546084078A998CA22C259C7928E9@DM6PR12MB4546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NIf6PgTD9xusIlpaCN46UUuUKJVr+a/N8n3cnw3gpdvVjYCHvD2vXHyD6M+9Pq4PEpFl2cOkOfLX4OvFiF5On2goZodoGIRlBqlQgKJZSi3tDHx4T/mJe0Hyqf8eCVICYxRrGV/C9SA6Rggeuri0ujGs20vYypqseGumCgyT1Ri6FL1i1uxajqDZVpPEeQTZMI0QYUjlqc3wfHHaAnk4BPHn8TRLZ+NlrCg5tLrtvCJUyPh1M/zK46lNz/61jdh+ayMquV+AGXc8vQpAxH9wPhN9PI0puaQuSuionphlu/KWQb3qH6+0XxxGp4UE0LwMkEwGFnBpKbRUR0M1YHi35H2ckxayKRmRBYY46wdx45nf0wu0j28NXARzj0V3QEFbJEuZ7d9aRXZLYflBABS+knJmKxP455yojxFuy/snCn6/c0wbl0HIXX0EIg/lfeg/uzknDDfKa6A/xPM3siFWvqs8qQPKuVTeUChRyCRiGFu1tX05X3zIJW8+Ujgob7uA7VzWMufDcIB5dO0Ei5SXPjtzR33Bmn7h5qbupBacxu/hev8aNM2IJzebSS7eXsMkod1R2Aeyw2cLzxRBzINBt83hPYLb5367HrDy2zfyKilW3A/FR/ZRkURM5BpejoAP8bi5Sw8mDPdhuqokmlwacf78f1b/5mFgi4O14blH0nfU9hF+LQompSc4kaA0LsCTLVwEJmIEyoY1hglI+d8vu+qeMgoo4kMBjKzJeOfgXSJ/h2GzNNLZYsk2SS4F7NQp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36916002)(316002)(66946007)(86362001)(8676002)(5660300002)(6666004)(16576012)(53546011)(186003)(38100700002)(6486002)(2906002)(2616005)(508600001)(66556008)(83380400001)(66476007)(31686004)(956004)(26005)(31696002)(8936002)(36756003)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFFUT3BacHg3YkEveWtXMmlvUFk4YlBkeHYrNEFYTC84aDVNTXg1M2pvTnYw?=
 =?utf-8?B?QTFtYm16Z1dJSmY5SC8wTVNmR3RHMm43OGJMV00rREFibVI4OFMzdE04SDZo?=
 =?utf-8?B?elN3bkxjdXI4NE1Da2lNY1B4THk0bXEzMjV3aldTMlh1ZGRvVmZZQU5yR29Y?=
 =?utf-8?B?L0lJNURWK0NsQlJBMDhBc0hCRCttbnA0OTVnYmpDMGFNdHY2YnVzRnhNV1Jh?=
 =?utf-8?B?VENIVDNXWnBDNklQVVplVWtIN1BvMFFxQUlpbDRTRDhNZGp6NWpId05vY3Vw?=
 =?utf-8?B?S0ZqZi84ZHhXakU4dzBEL09oV0VqRTBSR0licUJuUGJmR01sNzhiS2RIOXlL?=
 =?utf-8?B?Z2RhOFo1RTMvbUhKTnFZM0pTOVFsQ1dLS2tReDVRSUNqTURoYnpkSng0SFpr?=
 =?utf-8?B?YWZJYmFZWnY2VW9vMG8yeTJ0RnNYUEJUb1dzVmVnU1VRdmEydTQ5Zy9ocW9a?=
 =?utf-8?B?bnUyNUVYMlMvSTVrVWhwd1htODBQV0s5M29PMHFxOU1QNXpyclNtcE9NbGtK?=
 =?utf-8?B?L200S0hvdUZROXA4eUpueWdmRks2TVB6MHhQV0xFc2lPeGdCcjVTZ0xnbzRz?=
 =?utf-8?B?SUh0NEREVWJLSUhkVDBnQzEwb3RDVElXRnhmOXIvcm96MUpJd0dPelNZK1pJ?=
 =?utf-8?B?QUZXS0tTNHdoM1BYMGpNZkFYTXh6RWlMYU8wK2JMVGRkYWtoREhybUI3OXpK?=
 =?utf-8?B?dW5GMVpYclpLTHFJN0xoZEM1NlJ2SDBhbG8zelROTGhXcDZqcXlwZ295dHlS?=
 =?utf-8?B?SUFabHpZZ1RRZHZIOFRJYm54TkYrbGtTdnVtRHFYVE4xcE43aCtEZE93ZEs4?=
 =?utf-8?B?Vm56N0xDTGRTbkF2Uk96Q2xGTDhTYkRGcHRMaXZOVjFSSjViczYzK3hJaFky?=
 =?utf-8?B?ZXArTUlncG5aeFM1YVhhUlA1QW1KT3cwMDZpc3UrOXpjUW1IaisyS3FzRlQz?=
 =?utf-8?B?UVFTRTJkSXlqNGFaU2dsUzJMQTZ5d3IySXlRbFlSbG4vZGJkSG5FMlErNXpZ?=
 =?utf-8?B?ZVR1RENNZitvdWhHWlZhUmFPNFllTkRzMjhrcGlFb2ZwK1VZai9MS3daeW1y?=
 =?utf-8?B?aWhFeWtnd2pxNTQrUFFVMW9jQ3dTQW1oMHQ0b0FrdGtHZkZWcWZ1QlhRcCtY?=
 =?utf-8?B?N0V0S3NteWRabUhVb2ltazFQd1BHY2hTK2RseXVaUDE1NThFUHVvNmxUMmlx?=
 =?utf-8?B?Y0p0Q1dJSnR1bWR6dlBrb2VDWk1Ld25INjNHNkMyNmUrL2c2YW9IU0NaalM4?=
 =?utf-8?B?SDVNRG8yblRyVU1ZN3hycnBOL3pBWXFnaFNxMHlZVUVXS21oQ3hyQkdmUHhm?=
 =?utf-8?B?MGRZRi9qR0VndWQxNWw0Mzk4WXNuejhKMzM5OTRwQXFXZm0wbzBCZVo2MjRr?=
 =?utf-8?B?LzU4cUgrd2dSMWZLVHhQQVZXazRtL29xVDNLL3pqQWRrSGJ1N0o3d1hRV1Vv?=
 =?utf-8?B?NWVTWkJ0MlFHN29lRXY4NGJ6bzFmaUxWUDN5Z2RtcUw3UlVuQTh0MUVQSkFY?=
 =?utf-8?B?R2x5ZEFXMjZldjZoWHZqVzljY0dJQUU5dG0zSDhZanpuTDR6ZmY0bG83S00y?=
 =?utf-8?B?OVdVblRseUE1elB5eDhSN1lFM0s4TStuYW1pV0RCZzFtZmNjUVJtb29CT0xW?=
 =?utf-8?B?ZzZJVGd4dlBOMU03cHZlYXY0Rm10MmkvMEovcStpVTdrOUZYeDYwWnA0N2J6?=
 =?utf-8?B?RVRtd0lHTmhPWVV1c29yZUVjS0VWRjZ1V3gyK21sU0RrdUx5ZEd3bFdUK2lR?=
 =?utf-8?B?dWs4UkZqVms0Uko2NWVucHp6TnNDOE8zdGtyZFlINjZNRjRRWXVpQ2dlNVZB?=
 =?utf-8?B?cFpJaUJDU05iMnoyTlNHSnV5ZTVZc3pFaGg2eTJpakRaN2Q2YnJ1RkJGb3hD?=
 =?utf-8?B?alpHVThrZ0VjVUg0YUZBaEZZb0J0Z0xVNlJVNFdEOTFKVUZsVCtkSEh3Yktr?=
 =?utf-8?B?Sk10dDl0TDFKbXp2M015c1Ruam5MUUlXMWdBSmIzb1VHSGJibXRoTHlQcllP?=
 =?utf-8?B?Zjc2ZjlaS3ZwY1gxM3VPbU9DdXpxbFBYSmNPaXo0a2NjRjRabjNkVnpDTVla?=
 =?utf-8?B?ZXZlNSs2UmxKS2dSRlEvUHZnMUZuZS95cElUQ3ZuSm0yM2VqOUFpT3M0Zm91?=
 =?utf-8?B?NTF2bXRmdG5UeFBHT284K0NKdTNJbUovNGY0RWQ4RkdQYXBDWmtCQUVsRjJP?=
 =?utf-8?Q?KetFhw3BJChxQfUxdO6JMyw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99d3eff-c8af-40a3-46a3-08d9a084772f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 17:48:24.8208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L47wd6LDQnw9nMlnMR5ElW8LfQss4WT+qcz0CVxuyuD7VtU2jlHRA/LXJMadx68+iUyEcHABTxH3n+EOZGR9gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4546
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There was a reason why pre_reset was done differently on SRIOV. However, 
the code has changed a lot since then. Is this concern still valid?

> commit 7b184b006185215daf4e911f8de212964c99a514
> Author: wentalou <Wentao.Lou@amd.com>
> Date:   Fri Dec 7 13:53:18 2018 +0800
>
>     drm/amdgpu: kfd_pre_reset outside req_full_gpu cause sriov hang
>
>     XGMI hive put kfd_pre_reset into amdgpu_device_lock_adev,
>     but outside req_full_gpu of sriov.
>     It would make sriov hang during reset.
>
>     Signed-off-by: Wentao Lou <Wentao.Lou@amd.com>
>     Reviewed-by: Shaoyun Liu <Shaoyun.Liu@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Regards,
   Felix


On 2021-11-05 12:57 p.m., shaoyunl wrote:
> The KFD pre_reset should be called before reset been executed, it will
> hold the lock to prevent other rocm process to sent the packlage to hiq
> during host execute the real reset on the HW
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 95fec36e385e..d7c9dce17cad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4278,8 +4278,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   	if (r)
>   		return r;
>   
> -	amdgpu_amdkfd_pre_reset(adev);
> -
>   	/* Resume IP prior to SMC */
>   	r = amdgpu_device_ip_reinit_early_sriov(adev);
>   	if (r)
> @@ -5015,8 +5013,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   
>   		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
>   
> -		if (!amdgpu_sriov_vf(tmp_adev))
> -			amdgpu_amdkfd_pre_reset(tmp_adev);
> +		amdgpu_amdkfd_pre_reset(tmp_adev);
>   
>   		/*
>   		 * Mark these ASICs to be reseted as untracked first
