Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E474AC4828F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 20:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6421610E4E3;
	Thu,  8 Feb 2024 20:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a77KpBMV";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E603910E4E3
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 20:43:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LP13PqDN0WD5lJ1eDJOk1Vla6Jsk956Kwk9QSCzsQoEfbZZAPFDECXnCDdstP74L3qL49H6K7pS28ou8ocOtvq6RjMFs2ZK+4tyOhFJ5D3RtxOEaZO1kptxI/trkucoJemvoifLcujUQDAvQ+Y/7/94G5h0YVOBu+hjK3KusGwmSOPSFdpB6vEXRQPLUACNgRJNvK6wDFoA6MedIsx8FTijQX8br/AKg0vC0hDpYJJqzP+xUjhUZx2qKUFB0rowEhySOiVrNEiEAHR3Coy68FGxhfg4+poHTR+0wtT9a8qKgZ7h6qikExwm5elHXDPkNy8PO8IYfcxsSitjXBCwdOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMFioMY2pMOx01BH/GsosUMenb9OWkhhdSB8LX/Rrms=;
 b=WVWcY/Rmy2Lrzz15YKIJfLgl4sRIBR37d6693x2+Wp+hjBqtRb0VUJGEcaY2HZfEHTGqIGfra7myiRGGzM5Kz7VCPlGpuZvpfOyrg+0wx9k2K13rueh4/ZbcOZLBshGVCISrqdczKbdVcIm+uuoIOSi/juWj4CGB0MdG6RtiFyI+A1NAiDXEWBM17oeEamutMfnSdD1Q/SQaptimlzFPHUN41kfZPeNmh7lzVa/wobOXvXpntDwlP7iLpFxgBLGQNM+EJ9h0UcD1XFpOZCG//dtuPpJ/NcnDXUqYNpzV8Cz31SyjjPEoal7RAaPmKIgCnx6LGBa5bkdAvRYN/Y5KqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMFioMY2pMOx01BH/GsosUMenb9OWkhhdSB8LX/Rrms=;
 b=a77KpBMVfS1iNldV9TojTtbfd2F4mZftyis3ihuvlq9gwChKUfFPOb81MctN2WANodg2X8cOxSr6f/fe2BVvuu2O/4gIgVQ5AWCR5TV8FgCCYpASQeEGjPdjJ1kWGx57oUz/XNU1FPepnivj/PaDZqmwWVHKdyLtFUaLX9oL+9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB7542.namprd12.prod.outlook.com (2603:10b6:208:42e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 20:43:12 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7270.012; Thu, 8 Feb 2024
 20:43:12 +0000
Message-ID: <8593f22b-9c44-4c93-a140-1315771062d1@amd.com>
Date: Thu, 8 Feb 2024 15:43:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] drm/amdkfd: update SIMD distribution algo for GFXIP
 9.4.2 onwards
Content-Language: en-US
To: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Joseph.Greathouse@amd.com
References: <20240208041401.1870940-1-rajneesh.bhardwaj@amd.com>
 <c14611b8-b524-4520-b6e5-ca67118c4b12@amd.com>
 <c14bd877-742c-4a53-aad6-a6d7061569de@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <c14bd877-742c-4a53-aad6-a6d7061569de@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: da2ddd0b-ab55-4045-65ee-08dc28e69108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9DohHxnmDVHXIvLVLpOVqoM3oBdg5SU5MGavZxjE3j/UbS7QBVK34Mw6veuSDe9cIuGY14X5/TNYahrZOxDZTW20QAnUslnP+GHL10siIqmNY2p+9mQDX5RfTDvTfQrR89zMemRRSgJYraUf6W4xnW91nn/Z4OqWbCeHKVZiPEByAKVnnDXZRm/cz0LOZwRDz+7918SjXlOl4BA6YcMgbELRQmF+8/E0bivl+oux8l/GAxMD6kHUi6MwstoGtWBV4NM12eEUrsNLUkQAAL0vHDd8pgEr/fbHDIGc94rNKq9UNJ+UF0I8sxH1afh+1P2pgDU2fK1+tVuE+fSJw9y33+IE4PfBQaD1adORiRp67o9lL7buzWIWtrKyiws9mLIEw11LcmAWkC51N7D+E3etlCAKDlxTZ5srDCdTEHAfTiPSY7Tq2Ki030+GdUqJ+M/jV6WjyGGJ2dIrXDI8EqkcDZJTLAsxYBacw8TYWt/uRUomU0Gy3skDeNgps4TlmUdkguYold6c6m3l7ksOYRxau+BePED9Qss6mkEVWKSfHQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(966005)(478600001)(6486002)(31696002)(26005)(2616005)(83380400001)(66946007)(41300700001)(15650500001)(86362001)(2906002)(8936002)(4326008)(5660300002)(6506007)(66556008)(38100700002)(8676002)(44832011)(316002)(66476007)(36916002)(53546011)(6512007)(36756003)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGdjOGxrNGJpanYxRkQyeGxmaFJ6cXpkamFsTVNMcUxTb0ozYkhHRU1LWkMr?=
 =?utf-8?B?VUloc1JRTjYrUTJ3R2lxWWdEKzFxajNrenB2OWhyNUc5VS9XWkxOMndwRVRq?=
 =?utf-8?B?TjFRcmp2S2M1VXU3bzhHdm1ISVdiYmVPOHJUMDRqRGJBRDBQTkVSd0JRR01D?=
 =?utf-8?B?QzhTNDl3aWowNno3TmdQSVBEbHlneGRnMGNLaVlwVzNIeWNOK0t0WThoOW1o?=
 =?utf-8?B?dGZZb0F5V01DU0wzcGZlSGlDZXJzNFdDdHcxV2dkZ3dyaDNuSXZoUlJ3NHhy?=
 =?utf-8?B?UTdNVG5VbURIN1JSK2RQeTg1OGhNRDFjazlMa1l4ZzRxeFZ3VnJCQTJ4Y3B4?=
 =?utf-8?B?SlJHWVJuTTZFQmhWNGo1MjdUOTgyd3lYTWtkQmtFUUwraHlTczNUczI1S2Jo?=
 =?utf-8?B?T1RzY0tibUFUVlMvb3gxSW9KY3p5VE5qOHVnTEozWURheWJMclN0eG1uN2U0?=
 =?utf-8?B?SURGdnJRMHhTdjA4OHpOa3ZiSHFQWEpaOFVaOGdNZG1zTHlsUDdGU3pHWSsr?=
 =?utf-8?B?NUJvZ2hZdmFrTll2Sm5ONVZJU2RSQThTZTVkMnRySE9ML1ZaVVpnNXQrMTJ2?=
 =?utf-8?B?bm5PK2cvOS9FWEgzQUY5Q3RDckFLT2w0Yms3S25OK2RtU0hMVnVENDJjY1Uy?=
 =?utf-8?B?YjRkbHd2MUZ0TzV0M01wbmhLa2hzUUh2TFRrNjc0ODFZNkxxN084RTVvNEg5?=
 =?utf-8?B?M0RoMkNOaFZ2bWVUMUdqSVo2QlVKOTh4T09lTFdkYUlKZnpxRUVnRUJyaVhN?=
 =?utf-8?B?NHh6MzFCcHhFbVlUZVdkU3preHllMG9VVTVPM2dHR0FIY1pTUTRGcnZvRlJR?=
 =?utf-8?B?TXEyVXpITWV6R2hZK1pOaUdyMUZXY3ZMUFhwT0NldVlqRXhxSUNWUFNkQnYr?=
 =?utf-8?B?OWt6SWRCZlk0TU9UZTdzcTcydTRJV1hseFBYMjMzcEQvejZIN2NzTGovNjd3?=
 =?utf-8?B?MGhOb1RmSWVaRUk5SHcvS1NORDBXY1BTSEpSTnNkdGpTTWRlUVBCMHBuaEx1?=
 =?utf-8?B?SEtNd0Z0WG0rRlVWM1dzRHZqYVEwd2gwOGhBSnRhOHltTXl1NjgxRDM1K3dG?=
 =?utf-8?B?dFRmcU8vYWtHOXF6bmRBeklna2x6cm0xNVVjTzMzMFNoNjdiNHpPcFQxZjVV?=
 =?utf-8?B?M0p5VGFSdzI5TlFSTlByZ3pYd2JPRDZDb3RLb2lsQ3Q4SytYUlBkTDJiSTk0?=
 =?utf-8?B?RFgzWjY5V2lvWjFQOEJFTk1Qb1JPOUJGMTk4c0xNY3JDY0FIekNtNEJLaW1x?=
 =?utf-8?B?eUlUUGFSd3lIZ0RPWnZzQmRuek5iUksvLzJUa1ZLbjM1Y1N1Wmt1azI1eGZL?=
 =?utf-8?B?dFlpN0NLWDlUcis4WTlRMSt5YUY5MmNoaGtmcDQrQXgzVU9HZE40TURaRFNy?=
 =?utf-8?B?M3VKcitQd2hTdnZFekZkQUtVNThqV3Y0Y1hrdC9nemJ5bnFacWdNVndveFNa?=
 =?utf-8?B?MGkvOVdLVFUrOUNyOEtHcEtFZk1KSGNSREdaTE4xb0s2WTdFMGNsT0NxT0Zv?=
 =?utf-8?B?WUNPYk41MldPTG9jNktjTFMzeHUya1hpU0thYUZnbmNwMHowWlZ4M0c4alRz?=
 =?utf-8?B?VDV4QlpsN2ZsN0VBZTBvbGE3VEREbWJOSlZxYU9SVlAveEpMMXBoRmVkTHpj?=
 =?utf-8?B?T0psVnphdnZIalJZL3BXVFZqOUh4WnNja2RyblhydlBnbmEvaTRzdlIycitU?=
 =?utf-8?B?MDhiZXVvTGx1UEU3WXhyekpWQldzQ3NQd0xYazIxWUpESUZ4SSsrTzNubGxP?=
 =?utf-8?B?eEJuQm1RMUJsNFdxa1orY3NpUllsRXE5RWc4ajdoaGFINUt3dytiTGRBekpn?=
 =?utf-8?B?R2IwZWlOdTFTYWRUTTNqa2F2ZlBiWG52bjZ4bmRnaTJKTEZzSVZjai9XYnU1?=
 =?utf-8?B?MnVnUnViRjFvZWtnMkJKeTJIRU11UnY4S1RPMitWM016b0Y1dzNIU1U4T3Bp?=
 =?utf-8?B?MVpOTE1wMi85NU1HZDQvT1RFd09MYUpyR1A3QlZabHdkeEFCM0lqRlF2aWdE?=
 =?utf-8?B?dDVtdFI5bHQ5UGdxOFlsSDNMMmJCOEN0RWZlR2dseDBBWTB1TlhxcEVENTdF?=
 =?utf-8?B?TVU5L0lnNm9Gc2dQWmRFMHdRQ1c5eU50MHVJMVdvOXhWV0Q1Q0JvQy8wWG1R?=
 =?utf-8?Q?ld+PcbdKOOH6wWv+dWWNeDiy2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2ddd0b-ab55-4045-65ee-08dc28e69108
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 20:43:12.2681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAldE5w1nydOueHox5IPgB4+8HdOaoo8LAsl7lICK2uadg56HXOF0Id8xIhZTMD0ReMWMtwDZrP6YqSzYYB68g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7542
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


On 2024-02-08 15:01, Bhardwaj, Rajneesh wrote:
>
> On 2/8/2024 2:41 PM, Felix Kuehling wrote:
>>
>> On 2024-02-07 23:14, Rajneesh Bhardwaj wrote:
>>> In certain cooperative group dispatch scenarios the default SPI 
>>> resource
>>> allocation may cause reduced per-CU workgroup occupancy. Set
>>> COMPUTE_RESOURCE_LIMITS.FORCE_SIMD_DIST=1 to mitigate soft hang
>>> scenarions.
>>>
>>> Suggested-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
>>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>>> ---
>>> * Found a bug in the previous reviewed version
>>> https://lists.freedesktop.org/archives/amd-gfx/2024-February/104101.html 
>>>
>>>    since the q->is_gws is unset for keeping the count.
>>> * updated pqm_set_gws to pass minfo holding gws state for the active
>>>    queues and use that to apply the FORCE_SIMD_DIST_MASK.
>>>
>>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c        | 4 ++++
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  | 1 +
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 4 +++-
>>>   3 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> index 42d881809dc7..0b71db4c96b5 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> @@ -303,6 +303,10 @@ static void update_mqd(struct mqd_manager *mm, 
>>> void *mqd,
>>>           update_cu_mask(mm, mqd, minfo, 0);
>>>       set_priority(m, q);
>>>   +    if (minfo && KFD_GC_VERSION(mm->dev) >= IP_VERSION(9, 4, 2))
>>> +        m->compute_resource_limits = minfo->gws ?
>>> +            COMPUTE_RESOURCE_LIMITS__FORCE_SIMD_DIST_MASK : 0;
>>> +
>>
>> This looks OK because we don't set anything else in 
>> m->compute_resource_limits. If that ever changes, we have to be more 
>> careful here to not wipe out other fields in that register.
>
>
> Yes, Should I change it to below and send a v3?
>
>  m->compute_resource_limits |= minfo->gws ?
>             COMPUTE_RESOURCE_LIMITS__FORCE_SIMD_DIST_MASK : 0;

I think you need to do

	if (minfo->gws)
		m->compute_resource_limits |= COMPUTE_RESOURCE_LIMITS__FORCE_SIMD_DIST_MASK;
	else
		m->compute_resource_limits &= ~COMPUTE_RESOURCE_LIMITS__FORCE_SIMD_DIST_MASK;

That way you can clear the resource limit when GWS is disable for the queue.


>
>
>>
>>
>>>       q->is_active = QUEUE_IS_ACTIVE(*q);
>>>   }
>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 677281c0793e..f4b327a2d4a8 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -542,6 +542,7 @@ struct mqd_update_info {
>>>           } cu_mask;
>>>       };
>>>       enum mqd_update_flag update_flag;
>>> +    bool gws;
>>
>> Instead of adding a new bool, can we add a flag to mqd_update_flag?
>
> Maybe, I initially thought about it but then I chose the bool approach 
> since  those debug flags are generic KFD non per-Asic flags while this 
> bool is per-Asic request so I felt they didn't fit together. On the 
> other hand, those flags and this bool are both quirks anyways so maybe 
> they can be together.   Please let me know your preference.

I'd prefer to used the flags. They are currently used for a GFX11 quirk, 
now we can add another flag for a GFX9 quirk.

The GFX11 code currently has an implicit assumption that no other flags 
exist. That would need to be fixed:

         if (has_wa_flag) {
-               uint32_t wa_mask = minfo->update_flag == UPDATE_FLAG_DBG_WA_ENABLE ?
+               uint32_t wa_mask = (minfo->update_flag & UPDATE_FLAG_DBG_WA_ENABLE) ?
                                                 0xffff : 0xffffffff;

Regards,
   Felix


>
>
>>
>> Looks good to me otherwise.
>>
>> Regards,
>>   Felix
>>
>>
>>>   };
>>>     /**
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> index 43eff221eae5..5416a110ced9 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> @@ -95,6 +95,7 @@ void kfd_process_dequeue_from_device(struct 
>>> kfd_process_device *pdd)
>>>   int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>>>               void *gws)
>>>   {
>>> +    struct mqd_update_info minfo = {0};
>>>       struct kfd_node *dev = NULL;
>>>       struct process_queue_node *pqn;
>>>       struct kfd_process_device *pdd;
>>> @@ -146,9 +147,10 @@ int pqm_set_gws(struct process_queue_manager 
>>> *pqm, unsigned int qid,
>>>       }
>>>         pdd->qpd.num_gws = gws ? dev->adev->gds.gws_size : 0;
>>> +    minfo.gws = !!gws;
>>>         return 
>>> pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
>>> -                            pqn->q, NULL);
>>> +                            pqn->q, &minfo);
>>>   }
>>>     void kfd_process_dequeue_from_all_devices(struct kfd_process *p)
