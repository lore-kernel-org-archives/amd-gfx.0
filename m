Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28F91061B39
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 11:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67E8510E2AA;
	Tue, 31 Mar 2026 11:58:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s06RfKqo";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013048.outbound.protection.outlook.com
 [40.107.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0849310E2AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 11:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mm2RRZPqMJ/F9d1KtMXpqnqWtYbCbtPtOhOSWBqLDsyDR6tw6iM3qBPlLMNe/76WQ4wCfaRovij3gdUqTk87hitM0DLH6LxRyUPj+qK+7qYFRWZ8ciF4YlICnhu/XDnkQB7ywhWyqDF3efdual6KcajSWtzpfBYjPR/TwrFgO8toMo3IhS5Q/0YUgec6iTcB13/RD9gSryz0TNSWX7jamJKYZwwA1Pruqff1NB2vzkCEspZtDK87HJ50Xbxyv12N3Y9GTB0RY2LHYGl3eIbexmcf9OIqKpfP0peIUywZFrBWAsswL8saAYpsHPn9jMw9wCZ/Aztj4pDUnqfUTZwhDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dh9PyZf2p5fLPHaUeYCHkFihYwd7T8smbNdURWF4buc=;
 b=xfYxRMthWF3tPwo2mFNmA8E9RIkFxq6hDYc34Fei1RMZLEvHGCIlo+Fvpc6jXY5YH92s3IkkkPM5mTvGDEQSH2BHyqSB1hoJ9X8UTyi8k7u+XSWpa5DK4Ywc+AUhH2OO+enDDaKR9ITOFXXuRva4Q8l2Mwiw//xzNEyAWJBj+fWQFq5osZmRwrw7vh0FfgbRucUhWXyLvgxy7+iiVJMlzNEqJ6LB2bnwuNlBLuHnLTE/bnKy58T99Tq9zOq3VY2vdnkZNRyAvJSAZbrhnKDZRo8M8opAuNqoBbqbe7m3ajns+jJV2AZ1m5yJ4VPna/qRuP3fGPz+LntMBQAeshUwyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh9PyZf2p5fLPHaUeYCHkFihYwd7T8smbNdURWF4buc=;
 b=s06RfKqoKxLjdNFTTAR4PM0J2B2+edoqTeuueWkxSxX1dwUSg2+iD2kj7uQr2KuzQeZT7mmLJWTTwY0X/EYW0dnw92uEZExR6WeAGQchUPZfJAcd+23BNG04B7OVDggIdwWgQ3Egg2Y35ddd/iWPx3r+fnE52Kuhjyi0xWOxsDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 11:58:01 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 11:58:01 +0000
Content-Type: multipart/alternative;
 boundary="------------C6q8iQ9h2iGUJYYljpQQjABC"
Message-ID: <4f1a3f1d-da13-4343-a296-65503dc3b578@amd.com>
Date: Tue, 31 Mar 2026 17:27:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 3/4] drm/amdgpu/userq: call dma_resv_wait_timeout
 without test for signalled
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260331074943.2510941-1-sunil.khatri@amd.com>
 <20260331074943.2510941-4-sunil.khatri@amd.com>
 <4c88cbb1-521c-4cba-8ce0-8a31c3c24f18@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <4c88cbb1-521c-4cba-8ce0-8a31c3c24f18@amd.com>
X-ClientProxiedBy: MA5P287CA0023.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::16) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 913e9ad6-62a0-4e59-fff7-08de8f1cc1e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: epFH45jRT1jWpx6yx17BASLv8g6coDEROeqQvLs1XZOY/OwjTI4R3h3Mo9sINA8pwQzFnkS0n3O9/Pq/L/kElS0/YNDx1K6OY2V7gIyljdW+eP8GBqCbRFOMD0fJFZDkLru7mrBmSbiLYC5UaMQcbfmmRsk61oAHxn68z4tOZg1B9o9oWRl6XHqR0XdRLHvxCwlErq6KtnMP2HfUiicUsHgqCCv6Jcw7ul1MSIxiNxhf6IhpjTh0/oy8XmCe6fsDeyUmisr0u9zaqpBWitTo04ZjVeubFYa3Nhc4MYmjGQuq7R+34CFZEUC0E+k+i0PutHUEA4+Cm+5BgXR6G1Jp/+0yHW5/AiI1SYrqpPGKpuuFNfvHmzR3xXs6wnUtmdTNHArDR8VxDCJxVc+nIw4+vlBc7B8ux3myFTGSZinhsu+lKrO/hZM3iy4BN8La6OJE+pPmieyf/oMilssQs0EagKxLUwSIsVNPwvZppI8rQLYPnDwwsXmw/fbuG8silF5HvqGiTT9JB7NS4By/bJfw4k4eYfO7q8t2O65bhq66l+or/8G+5wgMDNnqAXUAr9RyaIzqVTJ8m1dV625UFUhDdH6VVrMnd0Iym8D1StnlldrDtutzWxQwG53uCiFRSu3aT1bFipFOzOb3qqdiEBYm6zRSx/xYWTrBEyLpxmKgggpd2EMNSqKuOHmEt8mC8uz2JSSQSmwqKZ6wdSEg+IqIqnCOT3ev1rGkTG62r8IpAcc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXF3dzJyTzZiQW9nK1BId3hpcEo2Rk5iN2pQVklEQVBaUTlMVlQwdzBJZmZC?=
 =?utf-8?B?OGRwU3pUQmRTNGFseVZvUEsweHQwekNFMW9QNmZ1SEZYa1hYWk1EdTE1WUFW?=
 =?utf-8?B?UHgvV1doZm9rUnhTRmNYeVB2K1plY1A2ZnEzbkpYcTNPTGFxckZBK0p6SXpu?=
 =?utf-8?B?cmcwMzYweEZ2bFFIbDE1SHgwVUVUMHFSTmo1OXpWUVc1NkVEekUzdGQ5ZC9k?=
 =?utf-8?B?T0lpdmNiL0UwdTFTSkJLRmxzRExEaVFSazhwaFJ5Q2VORUY3cjFCY3JwcWo4?=
 =?utf-8?B?Wk5DSHdmQkZlbEVMRFFKYnN4Zk4reEY1TGNvamxmNTRGdUZnNlkvOGRsSUpS?=
 =?utf-8?B?VjNzandRMmZpcXhzdElkeWFXZGllT1pYZDhGS3M4TGxFVnFSWlVXUXVna1hi?=
 =?utf-8?B?MHhBeVRhS0Uwa2F2OHcyVnRRUEN2RzNBTnJyaU83UHJLQmh3VXpKbHFhTUJM?=
 =?utf-8?B?OEROR2tJN0RTMEo1LzJFc3hLU2Y0QStIM2FsTGFyMW40OEFNYzZGMnB3cklw?=
 =?utf-8?B?UWs2eVBiOGpHMmZjK204akNWaUlXamhkOEt5NHdRTE1mNEZDeldnTjZqcW96?=
 =?utf-8?B?cmgxcXhYUDRGYTdNWVFoa01GN2NXams0OS9yUEtGbTAxSjNMUW93WlRCb3M3?=
 =?utf-8?B?cTRBZmVoQXZzejRtd05uNWtCcUJXaXEyaEVMR3lYT0Q4azIwa1poOSszNE5B?=
 =?utf-8?B?RWhNOEtvY0RDeFZtVTlJNUp2K1IvVGdpbGlPSzdvd1d1cnhva1VoSzM1VWh5?=
 =?utf-8?B?S0g1djFCVzdhSjEwTlQrSk85d0VHc0ZuTW9TUTBxOTNocGJOWWFIcThoYllU?=
 =?utf-8?B?WmVUQ2t1alZHVXBIOXE1WmNETjN6YWQzYXRuYjBsYUUwT055ZEc3YlgyVTFr?=
 =?utf-8?B?cmNtSDN4MEEzTzk3dVZUK1YxdmliU2E1c2VneTNjL2VVSm0zOTUxYmt0c1c3?=
 =?utf-8?B?TzZFV3c0a2w4UHdUdHZvRG5sYXlQaGlGYmtMVUlGMHpUNUxodlBVMmdIUW9t?=
 =?utf-8?B?RWFyNHBVdGhOTVBlNTdZbGo1LzZXQnFtaXgybVRzbXJLbi8wa0tMS29xUTZY?=
 =?utf-8?B?UGRSNHNwU3BpYVRNL1VXMFIxcFp6ZU9GNkJYNW1JVklFRzN4SFhPMk91ZlUz?=
 =?utf-8?B?ekM5NlJFaEU5QjNuMmE0Y2RyeVFBeHhqOU8xdU5tQjZEQVZIWWVHMk9Lb2Z5?=
 =?utf-8?B?RitZMTlEc3BmaVcxaldCQ1BvU0lOM1JOUmRKWUtCQzlSR1Ivcm5HWmR4NEIv?=
 =?utf-8?B?d2Rra2h2OENXVEJzVXJsZlIvSUV6ZnJzTGYrRXJDWTI0Z0RmRUc4ZUhpL2dO?=
 =?utf-8?B?OUVKekNnbm01L0UvYk45TmJEWmhtWjBVWG1uNEt4ekFWV3pSQWtRWnc4OEdv?=
 =?utf-8?B?aVVka29RdGhCVFJ1eXVTc2NNV2dZc05MK21XclpGUFYvOWZLVWNRa2RxRSth?=
 =?utf-8?B?RURDcnZZQUowRU0rUFN5WkJmb1VHY3F2RCt1OWZPN3p6Q0htSlJTN2RMK20r?=
 =?utf-8?B?d1dqbGZyY2xhNnJKVHZSNGV6MkN0bGVFem9CYlFDaUZJT1dpdDcyQ2IvT3Mv?=
 =?utf-8?B?aGxWRzJwd2ljM3Y2VkIzSUh4ak51TGYvb3BwZjV2NE15UXZBcXhJbzM1Y29x?=
 =?utf-8?B?b2FTRWFvWENpMk1zLy9veURrMWwxeGZKWVBkY0t5cnhQeDRsOGFLWUxnVjAw?=
 =?utf-8?B?YmhHOVJrb3ZzRU0wYURnV1pxc0VENjFWdjJuUE5kMXg2eTVVdEJ3NXJYMXNm?=
 =?utf-8?B?L0doeDlqMGE0cklENEZFVHlYUGpnSDV2NWU5bXFJd25IQVYxV3JSZ1VJOGtI?=
 =?utf-8?B?cVZWTXZ6a3VmNEwrMWNtM0F4cnN4UmZZWkIrRHc3eXk5RW8rZ2pQSWVhc3pt?=
 =?utf-8?B?dG9tcmJkYStFVXlaYVFUWU10dCtMc1Q1OFNQSkRhN2k5NGlRWVFqbzBaY0Nj?=
 =?utf-8?B?Z1Y0UW5yRStBNlJkU1ZmQ0NDTTRFRTQvbEk4THJpSVdZZ21ySnRxUCsrWjl1?=
 =?utf-8?B?QTNkd2RnWVBUSVhhQ3JEVzFxVUsyMUxwWkRXeDk0VEpyM3ZtcEFrY01GaVdm?=
 =?utf-8?B?bHRSamsyeG5HMGRFbmo5c1FuYlFQWGwyTTlOT1EzTWdOS21TVHVqZ1BhMGEx?=
 =?utf-8?B?NlE4cXZXR1hPeUxCaFkrejIzU2Zsei9HZTA2T2xCRWdpT3JhNDd0ZXZuRjlP?=
 =?utf-8?B?NTYzc2V2cTlGcnI4TFp6V1ZXN3VFZ1dwSGdDWXhpRWZyemZITy8ybmkrcjda?=
 =?utf-8?B?c1p0UnJaNmhhZ3N1Znp1SlVzL1RtMjA2Y3NvK1ljQUtIRWV4MGJUdTRjeW1t?=
 =?utf-8?B?RE1KMDc0V2ZwcjNkdk51ZHE5SU1leVVDbXgvaHBJMThueHJTTGE4UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913e9ad6-62a0-4e59-fff7-08de8f1cc1e4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:58:00.9209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrJ8C+b51+dnJWldQMcNy3/HW7poFPala9ogIfyQYp6surCsaF24GmI+Cn8V3VbiuyZ3id46e1LiuZOh8hB09g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953
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

--------------C6q8iQ9h2iGUJYYljpQQjABC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 31-03-2026 05:21 pm, Christian König wrote:
> On 3/31/26 09:49, Sunil Khatri wrote:
>> In function amdgpu_userq_gem_va_unmap_validate call
>> dma_resv_wait_timeout directly.
>>
>> Suggested-by: Christian König<christian.koenig@amd.com>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++---------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ++--
>>   2 files changed, 4 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index c85a4f4eefcf..0ef829065403 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -1480,7 +1480,6 @@ int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>>   	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
>>   	struct amdgpu_bo_va *bo_va = mapping->bo_va;
>>   	struct dma_resv *resv = bo_va->base.bo->tbo.base.resv;
>> -	int ret = 0;
>>   
>>   	if (!ip_mask)
>>   		return 0;
>> @@ -1494,14 +1493,8 @@ int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>>   	 * unmap is only for one kind of userq VAs, so at this point suppose
>>   	 * the eviction fence is always unsignaled.
>>   	 */
>> -	if (!dma_resv_test_signaled(resv, DMA_RESV_USAGE_BOOKKEEP)) {
>> -		ret = dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP, true,
>> -					    MAX_SCHEDULE_TIMEOUT);
>> -		if (ret <= 0)
>> -			return -EBUSY;
>> -	}
>> -
>> -	return 0;
>> +	return dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP,
>> +				     true, MAX_SCHEDULE_TIMEOUT);
> That wait can never fail and so never return an error.
>
> Just return 0 here or even better drop the return value.
Do we want to return and check in caller for -ERESTARTSYS ?


Regards
Sunil Khatri

>
> Regards,
> Christian.
>
>>   }
>>   
>>   void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 937a6dd3a4b5..43a7cb2d5db9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2005,9 +2005,9 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>>   	 */
>>   	if (unlikely(atomic_read(&bo_va->userq_va_mapped) > 0)) {
>>   		r = amdgpu_userq_gem_va_unmap_validate(adev, mapping, saddr);
>> -		if (unlikely(r == -EBUSY))
>> +		if (r <= 0 && r != -ERESTARTSYS)
>>   			dev_warn_once(adev->dev,
>> -				      "Attempt to unmap an active userq buffer\n");
>> +				      "Attempt to unmap an active userq buffer ret=%d\n", r);
>>   	}
>>   
>>   	list_del(&mapping->list);
--------------C6q8iQ9h2iGUJYYljpQQjABC
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 31-03-2026 05:21 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:4c88cbb1-521c-4cba-8ce0-8a31c3c24f18@amd.com">
      <pre wrap="" class="moz-quote-pre">On 3/31/26 09:49, Sunil Khatri wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">In function amdgpu_userq_gem_va_unmap_validate call
dma_resv_wait_timeout directly.

Suggested-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ++--
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index c85a4f4eefcf..0ef829065403 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1480,7 +1480,6 @@ int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_bo_va *bo_va = mapping-&gt;bo_va;
 	struct dma_resv *resv = bo_va-&gt;base.bo-&gt;tbo.base.resv;
-	int ret = 0;
 
 	if (!ip_mask)
 		return 0;
@@ -1494,14 +1493,8 @@ int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 	 * unmap is only for one kind of userq VAs, so at this point suppose
 	 * the eviction fence is always unsignaled.
 	 */
-	if (!dma_resv_test_signaled(resv, DMA_RESV_USAGE_BOOKKEEP)) {
-		ret = dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP, true,
-					    MAX_SCHEDULE_TIMEOUT);
-		if (ret &lt;= 0)
-			return -EBUSY;
-	}
-
-	return 0;
+	return dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP,
+				     true, MAX_SCHEDULE_TIMEOUT);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That wait can never fail and so never return an error.

Just return 0 here or even better drop the return value.</pre>
    </blockquote>
    Do we want to return and check in caller for&nbsp;<span style="color: rgb(208, 208, 208); font-family: Consolas, &quot;Courier New&quot;, monospace; font-size: 10.998px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; background-color: rgb(60, 60, 60); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">-ERESTARTSYS ?
</span>
    <p><br>
    </p>
    <p>Regards<br>
      Sunil Khatri</p>
    <blockquote type="cite" cite="mid:4c88cbb1-521c-4cba-8ce0-8a31c3c24f18@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> }
 
 void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 937a6dd3a4b5..43a7cb2d5db9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2005,9 +2005,9 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	 */
 	if (unlikely(atomic_read(&amp;bo_va-&gt;userq_va_mapped) &gt; 0)) {
 		r = amdgpu_userq_gem_va_unmap_validate(adev, mapping, saddr);
-		if (unlikely(r == -EBUSY))
+		if (r &lt;= 0 &amp;&amp; r != -ERESTARTSYS)
 			dev_warn_once(adev-&gt;dev,
-				      &quot;Attempt to unmap an active userq buffer\n&quot;);
+				      &quot;Attempt to unmap an active userq buffer ret=%d\n&quot;, r);
 	}
 
 	list_del(&amp;mapping-&gt;list);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------C6q8iQ9h2iGUJYYljpQQjABC--
