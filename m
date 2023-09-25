Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D76CE7AB1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 17:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB99910E2BB;
	Mon, 25 Sep 2023 17:51:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEDDD10E2BB
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 17:51:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OymyAZ6CtYHm7WeI9mAyrGnoMFCYpirxj8d0D+EmYQojRsStBcyetWZqo1l5+kHJSDHzL1ubTzJcwzQ0MHMtv8CoBmbeOu2J8erWJCFLfhIy5gkCD8hj5jiLWA0RIUn8FUxDmVGMfKGUDvbSKd6xWKTxsZzWWwv1MuepknArUTHbAK4qEQY7Q1YgvnyNhS0sBZvUZ59EXm5La2GL5Kvp+wErl8pk7oOlsmKYNdK5YVMeG5xi9ciIiaIip/xtLqv/6pPM+gRcqL8cAbNWgpr+MFsjHvA1tjDA9j67epD96UN6tTBklFKErpbqgjkYHHMJyeDrKYCGca+Kr/XPJazi5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQ1AM9ZKU+Dxh8c7vhkkUtdY2HpqPdMUYQPN1p8Nq3c=;
 b=VMK1R5BwSfVJsCSn2WJa43hokU1P58dhbDTqNF+hb2u4tXcNNYb7CAV6qPD24LMlmzJsFWJInhicOzA1n1RV0gx5jjL2S9HWoNYN8HLfmDvkb+YFOrI3n5b9rRO4GR3N2VLtacDYOjlaFQCX9YhjdCyA32UluGMQExR/2jJuisi0W7p1pU0jxPZ0+OZADuXkM/A2VvkNGFU7rNHN339zMDoBMnynRgI4qZERNM/k8wg2T8KrZqy8zTGwFv2YadXvRb12eE3LANkHX3nheXucRenTYD7SyRwyRzufa/BMihvEM8/tdPgKmXVTBemlLYGXqlzBOXSRQlUpOa6OZ0Kkww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQ1AM9ZKU+Dxh8c7vhkkUtdY2HpqPdMUYQPN1p8Nq3c=;
 b=p+EZ0+2IK6PjB0xW6PXl37jldlvHsFMIfZYTmFxyshEPf8t/DOk/m3Z//Ct1u3wYCc4wd5ZttGNRafpoN6DJygq6BLgzV850Us668iMZR2/ShTFimLwYQMil7OROtSRGpWTeFLmmg8uxzgyXvecPxBPhcUzhcLQCY/9MpkUSjpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 25 Sep
 2023 17:51:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 17:51:37 +0000
Message-ID: <ee50e145-1b20-4399-93fc-9dbb1aecbe29@amd.com>
Date: Mon, 25 Sep 2023 12:51:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Propagate failures in dc_set_power_state()
Content-Language: en-US
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230922201243.104935-1-mario.limonciello@amd.com>
 <843e9cef-cff4-479a-ad0b-6d161d5d7c5d@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <843e9cef-cff4-479a-ad0b-6d161d5d7c5d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0005.namprd08.prod.outlook.com
 (2603:10b6:805:66::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e7b978-9e38-4680-07ff-08dbbdf010ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 14qwHpNM5GlaaX+OWo3OTfFDPlGYvG9TNZGu+DXbSZ6YquMO30X2BFYccDYLkyFziAY+tWLEPTxf4ok958NZPR/MYl+Y4xS17iG/d7GlgfZHXWiseum3WPwgNVZPWUJ1eJYH9yMzfSXVULWO1w0ficSJzPYunTvWQXrgJCVMEUot9B7cgxRtFTFhqfe0ps56s2krRGE4te06RhkTLjMNGrmBJ70TxtfeSNAczkVTzfcpKYl1Xf9Z791d6Gfp3/URxQV1EPHRBLaY842z412hyIUNu4bzPPrDiXpCoaAYGupt/fvMCAG/edw6lww8lRBTkkWHfkshW5En9qkO0iTbX6MJPJcQ5q7Q+i4DP8GWxmMRI7ZUjksrkkofeQNIjdeJNisPnH7I6dlA0URF6N62tIc9KZfhXcmoeFobPR2iexWmpq36gWQx2V/t+77G33LnlqdzGT9Xl/lu+lxkdl3bsy5IPrrMbkoFPZUCYGYuxHNqVcKCC4OrsST64DtGxlnnzxdEUA+vv2UcdlFiguoSCD3r346x5gotvytp64a7IFTKO8M0rnmT7xsNNA8kccsYl2Jk46NVek3wRkSRDfdcMzU5auuhJaZrM/U/sRcG0dgCxJmEW4AgPNiRFLbCKZ6V
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(1800799009)(451199024)(186009)(8676002)(8936002)(31686004)(44832011)(5660300002)(26005)(83380400001)(316002)(6512007)(53546011)(66556008)(66476007)(66946007)(41300700001)(478600001)(966005)(2616005)(6506007)(31696002)(38100700002)(36756003)(86362001)(2906002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmZyU29vWTMxR1MrZ0d5SE11RDF3ZXNhdWVBYS9BalcwMGNnSUZxU0o4bGto?=
 =?utf-8?B?MUhBajBnUjlhTE1UM3JXaEE0ZmdhUXFWcnFoQUtOL0RsK2tSZWZxMGZhSTBQ?=
 =?utf-8?B?QnlOc3diNnZuTW40aTQ0dndid21VbjBpWEd6L2dOZ243RWFyVHYrTDBYS2I5?=
 =?utf-8?B?UVN5VUhMSGVnOXltRjUvNk1HV2ZScEhTWDFudHVXRzFrQ3dpZ2t1K0JOTk1p?=
 =?utf-8?B?bENhM3N1UmdWUDdhRS9RV2k0Vk5vMFlnTWVYUU9RR0NINDNmUWVnb1IwNm1v?=
 =?utf-8?B?N1VvOVIxYlVjemM1ZlFWZ1NPQnlJcGxTMkdZc0s4Wk81TUFEeTBrKzVaemlC?=
 =?utf-8?B?QmVXV29HSC9vZEl6RE1jTzROUllQVFdhdmF1cU1seW1IcW45djhjVlBFekc5?=
 =?utf-8?B?ZVZlbUFYVXBzVFdGbUVMdzFRNVFZVEVOTGNxS2M0MkwrWFpKWmJTa3FwOXRy?=
 =?utf-8?B?anpsZW1JeUJTREVnVURGWERxQ1JtSW56UkNpZDhhY1NxWVZZeXN5cE5TRlow?=
 =?utf-8?B?Y3FYQ0laV0pESEJnUXhCRnozMm9NbS9zN2t5bEJGSmVqVStpdXRGNVJjMTlx?=
 =?utf-8?B?VXcxMXZWT0hrSjBDV2p1WmNidkdncHhqNndMb0djK2tNS0V6aTVlWGZ5eDVN?=
 =?utf-8?B?Q3JqWHBYRHZ2QTFKdW0yNWkvSGhaVjA3MlEya3BoeEQzUjYxYmNqY0VmODBy?=
 =?utf-8?B?bThZVlAzYk9zTDJrN01oczlyVG9Vd2oyWVJZd0xxWkZYSEFYaG5CZEU1c096?=
 =?utf-8?B?U0RBZ1l3ZllxVmpjb3FnZStWMnB6VmRFaldWNWVUQmtCSjZzUmRFQmtna09Y?=
 =?utf-8?B?clY0bzZvR1h2a29rMFllaVkyRGNROXp5djI5K3pQTDExRnloRXlINkFxRHBv?=
 =?utf-8?B?a1ZHYUR0K21TWUVYRDBld1hoV2tqRU1qRW5YNXZzUlVRWWVTbzZLMEtDSDVC?=
 =?utf-8?B?UjdQakdNUGxpcVEvc0t2RFNBY2s2SzJZOGVqMkhUVi90TkphSXlRYkE2UjRu?=
 =?utf-8?B?Zk5FU1pjTE5tRTM2YkI3NHY2bkZiMjNULzJiQ1JPU2lMd2RNYnVCNGsrbWZz?=
 =?utf-8?B?MllGMktyYWlrcmw1QXVYZEt0NVBQdC82QmtEVytITlhHOFJaSG10MkdIZjVP?=
 =?utf-8?B?YVZxcjROeGs3U1ZFbDFmaXpqL3ljRW9kbTlvd2dLNUc4YkF5a28rSWZZTm5J?=
 =?utf-8?B?UEltK2dTQlZxeDFtalpkZGhjZHRVVzVsRGIweFJ4QUNXM2VlclA2bGYwbkZM?=
 =?utf-8?B?ZndmZEI2VzdWZnpQb3ZUOUtaRXNROHloNVVhVm5lOTJCbnZYbW1RSisybTVh?=
 =?utf-8?B?THh2cFA4a3JvUDQyRXZkKzV2SktvR2F5T0VkbzNuQXJlbXZrM1dxTVBLSmtj?=
 =?utf-8?B?SWJEYThCYU5mMWN4NDk5Qkk1RW85RVpDcVFCUHVKNkg4M285L2RSQ3J3dFd4?=
 =?utf-8?B?ajlydTRlVnA0Q0lyMmtJRHZjYjJrVzZuYkNZNVgwRTd5RVBBNVRoeHViYzY0?=
 =?utf-8?B?cWVHdzhLbjY3TEZEN3N4WTJyZ25MNS9Tc1FML2Vjd0hkdWdtWHhFU3lhclVT?=
 =?utf-8?B?SVUvTjQ0RDVUR1ZrKy9KdXl0U2ZGNE1xOFRoOTl0YXJNN1dtdEJlZGFhYUZP?=
 =?utf-8?B?KzVTQVpTQWExVTlSVGZaSmZISThidWVuandFcnJYWmQrcWQ0SjhWZkJCSnVW?=
 =?utf-8?B?YW40N0ZDUzBETS8vOVJibFREMTFWWEM3SjVOZk1SSjd3Y1Z2U1lHSWp3SE5C?=
 =?utf-8?B?UEw0M1NYR2Q5cE91dVhUWDhISkkvZ01lemNZV2d3MUJmQnllU0x1d3VxbzJZ?=
 =?utf-8?B?TUlIN1ZleEJTNEErQXJLcGl5UEZHYXp2ZFNtaGxpaHFkZHEvNmhnazc3QUpQ?=
 =?utf-8?B?RHV6ZWw4d0ZJdU5ZY2ExRnFqOUJ6ZEJHWi8zYnRPSzFFT0JSYkNHQytEdUY1?=
 =?utf-8?B?djdDWXAzTHBGWmlHUzU2R2lFMlZ5N3VHSFBtMm44L09CdldXM2JrM0VRaVQr?=
 =?utf-8?B?Z2hQNkVkS1ViWEtlTFV1Q2t2OG44bUxWSE01WkJhc1JmYUNOQ1BXV0JTLzhi?=
 =?utf-8?B?UmN2bFNYbUtPTGdaN09sNG9yNzJVamEwS3VpVmZxYVBSY0xvcnZQYmZtamRZ?=
 =?utf-8?Q?A93QmsxwQq22TOhGzfRk9rHs0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e7b978-9e38-4680-07ff-08dbbdf010ec
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 17:51:37.8114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MuxkHYL5wOLVc+dSAzB0akLVQjFCl+tJcBntPS9ueFMLCsp9fDgGD0Hay6wyC46nQZcNwdliBt8OrSpey+GzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342
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

On 9/25/2023 12:50, Harry Wentland wrote:
> 
> 
> On 2023-09-22 16:12, Mario Limonciello wrote:
>> During the suspend process dc_set_power_state() will use kzalloc
>> to allocate memory, but this potentially fails with memory pressure.
>> If it fails, the suspend should be aborted.
>>
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> Cc: Harry.Wentland@amd.com
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 ++++++++-----
>>   drivers/gpu/drm/amd/display/dc/core/dc.c          |  8 +++++---
>>   drivers/gpu/drm/amd/display/dc/dc.h               |  2 +-
>>   3 files changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 373884ca38b9..2acb555343ae 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -2670,9 +2670,7 @@ static int dm_suspend(void *handle)
>>   
>>   	hpd_rx_irq_work_suspend(dm);
>>   
>> -	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
>> -
>> -	return 0;
>> +	return dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
>>   }
>>   
>>   struct amdgpu_dm_connector *
>> @@ -2865,7 +2863,10 @@ static int dm_resume(void *handle)
>>   		if (r)
>>   			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
>>   
>> -		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
>> +		r = dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
>> +		if (r)
>> +			return r;
>> +
>>   		dc_resume(dm->dc);
>>   
>>   		amdgpu_dm_irq_resume_early(adev);
>> @@ -2914,7 +2915,9 @@ static int dm_resume(void *handle)
>>   	}
>>   
>>   	/* power on hardware */
>> -	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
>> +	r = dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
>> +	if (r)
>> +		return r;
>>   
>>   	/* program HPD filter */
>>   	dc_resume(dm->dc);
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> index 293489c41086..a1593d550526 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> @@ -4711,7 +4711,7 @@ void dc_power_down_on_boot(struct dc *dc)
>>   		dc->hwss.power_down_on_boot(dc);
>>   }
>>   
>> -void dc_set_power_state(
>> +int dc_set_power_state(
>>   	struct dc *dc,
>>   	enum dc_acpi_cm_power_state power_state)
>>   {
>> @@ -4719,7 +4719,7 @@ void dc_set_power_state(
>>   	struct display_mode_lib *dml;
>>   
>>   	if (!dc->current_state)
>> -		return;
>> +		return 0;
>>   
>>   	switch (power_state) {
>>   	case DC_ACPI_CM_POWER_STATE_D0:
>> @@ -4746,7 +4746,7 @@ void dc_set_power_state(
>>   
>>   		ASSERT(dml);
>>   		if (!dml)
>> -			return;
>> +			return -ENOMEM;
>>   
> 
> DC code doesn't have a concept of Linux error codes and is
> shared with other platforms. Can we follow a similar paradigm
> to the other DC interface functions and return a bool, with
> "false" on failure?

Sure; I'll follow up with another patch to correct this.

> 
> Harry
> 
>>   		/* Preserve refcount */
>>   		refcount = dc->current_state->refcount;
>> @@ -4764,6 +4764,8 @@ void dc_set_power_state(
>>   
>>   		break;
>>   	}
>> +
>> +	return 0;
>>   }
>>   
>>   void dc_resume(struct dc *dc)
>> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
>> index faf897ac75d8..82013ebcba91 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dc.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
>> @@ -2329,7 +2329,7 @@ void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bo
>>   
>>   /* Power Interfaces */
>>   
>> -void dc_set_power_state(
>> +int dc_set_power_state(
>>   		struct dc *dc,
>>   		enum dc_acpi_cm_power_state power_state);
>>   void dc_resume(struct dc *dc);
> 

