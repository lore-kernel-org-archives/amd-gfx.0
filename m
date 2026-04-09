Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E372EA3C59
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 12:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D767A10E7E8;
	Thu,  9 Apr 2026 12:39:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I0uELFrP";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF44410E7E8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 12:39:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zr6SdG3xLPSzf1jLvDnS1uaVpqE37GBoRWPykXUuVf3AWXymmSJSPmzw85smHdTlXkFr/OrstpKrDr2IcKGgOpsqUdGfLqSzXsZBmccCxSTXyb6RfSffva/ciAnw9CPV/y3D1zRzw18y0dx35fujkdMqhAMMi1KkiYcjUkialAicHeiWGZ6p41ubq6KpYmpVfaWHnCTZaUmwp2c6gO5nOgopcON/kbNcgVYNfapitTm2bmL3h9Zeoug6vOkbnKPHkBgSqdZCIacnxBQc9EIV0VWkFqEluTF6Ffa4GFaiqyrqh9sWRCsIzCEOihOq0ExiTQhROtokc5kEViafNdI2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tw8n3LI27eZUkihEfJIEY+cYlghCVO8DTAA1fGweKeo=;
 b=W44+Jh2nfBOX+fsn5wARiPpe5ePuUNL3CsNWOVq8GDWXM+McRyELMD0MZPIxGEUpf0caaZR4Vzh5ie+yp5TH/Rtbik4m2Qt7XoPY71SZSrau5ZDEDNHHkXULX2UJIDzJj9YRkdMr8Zt98ppJTSQyTZbqoFiAVqV7ZRCoZorzUwE+ec2qV9zOTNjCUUKcDVSoEO4VP5h7cw9hrWYet7quY1UyN/Kp+QLcCSQMKfGUTtd/oRTTxJSvTLqYqg3vAm6iriekjJX+qzYCHVl/9rJ0W6RzCDqtIrqSdyIDdUWRprEDFsBdN2POaUxZBiFYDwrQ9BfUYZ8jcahQQDoHi3XY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tw8n3LI27eZUkihEfJIEY+cYlghCVO8DTAA1fGweKeo=;
 b=I0uELFrPDOwUEyDO76sbifqaPkXQp6Q3scO9tU+8Ngf6z65YY0yKvsb5cvblhfviEFa03gsO4+kF2WVaAK+2x/AfRZV2hrA04tHg/55PrhfQItPnDbs41XgrLG+ouTF56VNaoIVrpoxJzTJ5GdR4mUEhq5kgzXBXWiqvZw/M+wk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4c3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 12:39:46 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9769.015; Thu, 9 Apr 2026
 12:39:45 +0000
Message-ID: <d64995bd-1cec-406b-975f-e14c633ce606@amd.com>
Date: Thu, 9 Apr 2026 18:09:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] drm/amdgpu/userq: create_mqd does not need
 userq_mutex
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260409083355.1326089-1-sunil.khatri@amd.com>
 <20260409083355.1326089-3-sunil.khatri@amd.com>
 <016e66c4-0268-4b22-b285-b54f0c2f88ad@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <016e66c4-0268-4b22-b285-b54f0c2f88ad@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::10) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ2PR12MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 07cff493-696b-4554-1df6-08de96351483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: s/ZFPIULfsA6LktFh8sf1Wr8T7udwjVC1sS02J4p8wR3DELzbI9m5x0cUAj6lPenlmdaTQ26pc/P7X2rDhS+AVdkRCa3chVZUZCNEiaqxvO3bXm4QSkuQ1YMMX329+xMhiU9pr+duDDaS6llGLAXM+Xjqw24Ry61kxzrv3KtaRg4adGNMhbQ+Cv0lOVcw0AVaYbVXDAy7u+nyHpVW8oQVTnv2EdIDpgW4QvEo1BOIcAvutlZ2XvPMbn5ZJh5Wicjiw7Ecu0qXXRxvbBJWJL1fej66lOPqfguvShUoByyP7Z8UwvrLDEgbFfTECXVpxynZjzdH4aLMCzEDCmMXMNpRppoS+Pd1TReDQD0e4tsZ4MIFbyfc5bvDUi1IMLE1xMFILBnMRKDoOhkH3J/5yYw5smbOsXUuOqFbRIwXcPsayS/cEB/S/dLBXfJ/ylsRFQc44MdfMROvP+SxK2AoR/DNFsQP23K42P/88JHdUrQGTkz61cGgp7lzGxYBxI01s5CxhblHyuTBBNgrvUsZaMKivWK4iTz3AnvTv9c+bx3zRMr1ZjVK8cQ0x8zwDP6l++azmBqSG5vQaSyuFcB+BYviKlcKOwYmVptlzS7mH2Os+tPU+wB3s2lYx2AOr2zm5At6b3hztiE4bpUBjiBRLSN6ka81/csoxR4rYzKi+KMGs6TpN0oOuHdhahDPUOSczUur6r9CUyhxaugfNedR6Z6Qp6M1d1HnftXuO1wg4hNtc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UitySTBNeFduWkt6U3lLVHZCa0hzVDV4NjR6UElaWU9LMWJUVGZGbHNjMUIz?=
 =?utf-8?B?TEZiNnJjU2tOOWRTWTVZUUxXVk9rbCtNZVNPNWJpV2lWd0Y0MGIwY0RBb2Fl?=
 =?utf-8?B?UXBhN3A4VEl2ckdjbFdtdndpUHdUUm12LzkrSUEvVndZMkZ5NklMT0FoRXJF?=
 =?utf-8?B?dHZJc2J3V2lwNlo2d0xxVTZNbk9tUHNnaVdGT09JYkgzekl0NzNqTTIrVWlr?=
 =?utf-8?B?QU5vcUY3eStkSXRSYVd4LzB4Rkc3SU8rTk8rNngvMG4wZlFFTzQyNVRQZlJu?=
 =?utf-8?B?b0FrUEoraWF0ZTAraXVoL0FJRFppNjZtMllyeTNJYlhsMnBPandFL0dvVHBT?=
 =?utf-8?B?bGxWMUJnVjQrdkRRR20vczZiSW50Q2xlZHdxUVdUSUtDZkU4SHkwelRUSHQv?=
 =?utf-8?B?ZDR1SUgrZVIwM1lXSHpZODlZSkZMRkFFMEJrNVB2Y3E0TzM1NmJQdUVZbC9q?=
 =?utf-8?B?dkNkb1IyMjdRMEwwVWhoVjRSSUVKR3JJZUlLY0ppU1ZXdmtnS2crZFR0RlRt?=
 =?utf-8?B?SGpuQld3a1QrUE04SkY3UDlJMnl3U01XOXlGdFdrWHhNdmFBenZFdHFaQnU2?=
 =?utf-8?B?VXcvMXBGWVg0NVdIZXJJUnV5VjFSWmg2aDlkRjdRdXNqZndHT0FSQldIWHdU?=
 =?utf-8?B?U0dYUmlLSkNRSnBSRXVuMmxrUVE1RnZyWFBrcTA2cEROelUydnE2N1pHUGVr?=
 =?utf-8?B?ZEU2K3VzbFhrSk1ZQ2tlTEhxcUp6VXNqMU1nQWJ0Z1A3ZUR4OGRtQVhqcTFE?=
 =?utf-8?B?SWljM2pVa2xvbUxra3drQldZdFljNlVnMDNqUVdCRnNaNSt1Sm1lV2lPY1p3?=
 =?utf-8?B?di9FL1lNYys1MUtLZ0J5a0pzajVZcGtqclZSRFR0KytDR2hhc1M1UE1qcXl3?=
 =?utf-8?B?WkpUUWpMcml4MDZBdTdDcWJhNUZFVWd0RU11ZW5uaHQ2dWl3K1IzYlVRYjds?=
 =?utf-8?B?c01aTTVJVTROSkVTMTNIVUowb2FSclQwbGxaRVR1dnM3VE8vTUNjMHRXaEVz?=
 =?utf-8?B?WmFFQmtwNVpsR1NYa3kzbVVlczA5N25lbGFiQkd2d2tkSXJqalloWlc0TzJV?=
 =?utf-8?B?OUt2dGFsN3BDNHV0a1FObHFhOEw3R01Xajk1dlFUWSs3UUlVKytyNEhsRWVS?=
 =?utf-8?B?L0UydEFnZUx6UW54YldUVWlaVGhZNTJLazNoVTFnRFpXNjVsNkVFNlc0Rnk4?=
 =?utf-8?B?L2lJMytIMm5KSS9hTmlFL2JIcGUraGhLTDc1NGhucGJnS2p4ZnFVQUNLTE9M?=
 =?utf-8?B?T09BdUM0dVdnWGlkcTJCQkxHSTJ5eUVpZTNsWHlZTGd6UTlQT0lXZTEvcDAr?=
 =?utf-8?B?TXJ1UjBPYWg0elpESlRQU3U1bmZEMXgzcjZyVld4UzJxcSs0YjZZNEJHdTFx?=
 =?utf-8?B?a3dXZ1paVGp6Tmhvck1BVXNMMFFJVGFSbjB3RldBQXNpd2tyaDVpSnZiUnRR?=
 =?utf-8?B?cW1ZTjVhVll4Ylg0MjM1WDdENGtyMWcvRUpCYXpYc0JYeThtMW1xRmZyVEFu?=
 =?utf-8?B?eHRkNDJrcm1ydGlZc0VxbTZkaER1OFU2cTdNRGt4eTRQUDA0VTBucXhsZzZF?=
 =?utf-8?B?SUVsOUtiUTR5cE9adUlESmVFREcwQmxzSFYwaHJqam05c1RwMTQranQ1d0lw?=
 =?utf-8?B?M0pPOEk5MTY1VEJ0SXMySkdDbjhCUFpvWW9MZ0NwUTdBNW85cjFXOXg0bENG?=
 =?utf-8?B?K2oyTGxvY1FaT0IzeHU4WTRud0pwYUtDa0ZnOW90WXI2Mi9Gb2szZkpzTUo0?=
 =?utf-8?B?Smo2VDRhSklEMlFFemF6cGh0a2JvMkM3LzZnVTFkc1B1bmpXWTJvcm1iNUJi?=
 =?utf-8?B?VmVIVEhvTzB0bllrZmtzYStjM1NMVFIvd1FEYlhFRGE0REhkUWVyd1k4MWx2?=
 =?utf-8?B?cVNlQkRCa05UME5zMXlxc1I0cHpmZHBmWFIzL3kxQ21NdHcxVXc3QUpOT0Fq?=
 =?utf-8?B?WU5majVydjNXMU1ZNkZYeHhvRTNtdWVwRnJOZjJPYTJ1Zy93TlVzbmJNUVdx?=
 =?utf-8?B?N1h5bXhhc25PcGxqZ2RXLy9pY0dLZG9ZbC9HZjdheE9MdGZLK29SSnhuUnpZ?=
 =?utf-8?B?VmdXbDdLY1JzZDVHSjNDYWczUjBHYWd3ek14S0hwTmsrOVJ0Uldza0Y3bU9j?=
 =?utf-8?B?amtXME1WRm9LZHlSeWhETG8yc3k5eDdCbzRqRFVha0xZS2ROSklyL3N6OFh6?=
 =?utf-8?B?N0c2MU95aVZJRS9YbUhkbUsybUlnRExPVUlFRm1QWERkdC9Sb2hHZ1pHaXZu?=
 =?utf-8?B?OGRqUGd3OHRPTDJPUUhmc3JnMEFzV3lDd0p6bFpvZEJnVnVwb1dRemRvdUt0?=
 =?utf-8?B?MlNlRzVkaW5HSUVQZmRzRjZ6WUQ2dUhabzVvM2ZYNllNVERkQ2ZqQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cff493-696b-4554-1df6-08de96351483
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 12:39:45.8246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmSV0D43uX7EEcu1FkqDtztH4jRTClMsNttc3zMS0HX/OMn49L8egnZd4ybeRHQjhes1QHjoTUhOsPj11aSR8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942
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


On 09-04-2026 05:25 pm, Christian König wrote:
> On 4/9/26 10:33, Sunil Khatri wrote:
>> Reshuffle the code to run create_mqd outside the mutex.
>> code here is mostly setting up software structure init
>> before actually registering the userqueue in the xa and
>> to the driver.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++---------
>>   1 file changed, 7 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index cf8c8dfde721..2408f888c4d9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -793,14 +793,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   		goto clean_mapping;
>>   	}
>>   
>> -	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>> -
>>   	r = uq_funcs->mqd_create(queue, &args->in);
>>   	if (r) {
>>   		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
>>   		goto clean_fence_driver;
>>   	}
>>   
>> +	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>> +
> Mhm while this might work it looks a bit questionable.
>
> What exactly is uq_funcs->mqd_create() doing? I though it would only be initializing fields.
Things done here
a. Allocate objects needed for creating queue, validated the mappings of 
various parameters of the queue.
b. Call mqd_init for various IPs: like below, which set various 
parameters for mqd and but still not call any fw functions.
    1. gfx_v12_0_gfx_mqd_init
    2. gfx_v12_0_compute_mqd_init

Irrespective of that, we could make this mqd_init function with 
userq_mutex. I think it is safe.

Regards
Sunil Khatri
>
> Regards,
> Christian.
>
>>   	/* don't map the queue if scheduling is halted */
>>   	if (adev->userq_halt_for_enforce_isolation &&
>>   	    ((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>> @@ -812,7 +812,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   		r = amdgpu_userq_map_helper(queue);
>>   		if (r) {
>>   			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
>> -			down_read(&adev->reset_domain->sem);
>>   			goto clean_mqd;
>>   		}
>>   	}
>> @@ -828,9 +827,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   	if (r) {
>>   		if (!skip_map_queue)
>>   			amdgpu_userq_unmap_helper(queue);
>> -
>>   		r = -ENOMEM;
>> -		goto clean_mqd;
>> +		goto clean_reset_domain;
>>   	}
>>   
>>   	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
>> @@ -838,8 +836,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   		xa_erase(&uq_mgr->userq_xa, qid);
>>   		if (!skip_map_queue)
>>   			amdgpu_userq_unmap_helper(queue);
>> -
>> -		goto clean_mqd;
>> +		goto clean_reset_domain;
>>   	}
>>   	up_read(&adev->reset_domain->sem);
>>   
>> @@ -851,12 +848,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   	mutex_unlock(&uq_mgr->userq_mutex);
>>   	return 0;
>>   
>> +clean_reset_domain:
>> +	up_read(&adev->reset_domain->sem);
>>   clean_mqd:
>> +	mutex_unlock(&uq_mgr->userq_mutex);
>>   	uq_funcs->mqd_destroy(queue);
>> -	up_read(&adev->reset_domain->sem);
>>   clean_fence_driver:
>>   	amdgpu_userq_fence_driver_free(queue);
>> -	mutex_unlock(&uq_mgr->userq_mutex);
>>   clean_mapping:
>>   	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>>   	kfree(queue);
