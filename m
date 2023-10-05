Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B62E9270D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 14:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C64E710E419;
	Thu,  5 Oct 2023 14:59:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14BD210E41C
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 14:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4v1LF3BFGz0uEQZDTaKFlBnHLlJMXvZ2IcD29jvfLpFzCimrHWkh758z1+gq+YTGpuckPSt9KcEHUCGfUzbkRtGXsjb4dcObQW4xrlmJu4IIs9EvrRREoBfL6XBCg28lGOxMJF0QLETrQ7x9TKng9w6Cq2L3JkArKmx6aTWrzT26pChaTr9u33dRsb3bcY7U4dq59xvrNhK3YGZrb0tMGXtnEWXl7N+DxddWYuZobsE08RUwrVag/3ks45qo1SjwCWlQ8tnOOPYUjplP5NJGsXUV0E7yaS+nU1qHons+4ezAauFlTtstrbI/iKPFXv0nsYoZYpwQE66K8gJ6vX55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4427jdJQyNtjXK04HeOBr5WGVfSfV/MGYYjol4kdns=;
 b=noWQ5kdgZczqM7veKTSMxnzQY9v1WjmM2K8EdlbDIMn8HdiNxYX1UQPR2rhErmQhLmW6mqdGw6TIDiNirnvIM3uEMivUmClgdBvk+SCuJldzU9hCEB28TxjhwaZwYhbKkiiH+yFkJvqgoaKAXn71XtMunyxCbWUJ/EzFQYmJgLeXDNWQ4cX6r8m7PH/MlB1t4c4bDxel0CpjKrZlN4LASgjsLbfg5wh+RMF4LvDzo0fwxo4TO05QAx6mNYt2koC3vOQJndS+uDQhSd/84lzWQh+TTnyGORPBSyNL+oTsm2RqsiAwSokdQoA/J/eO+sgG+n4I/vF2nyKCbab9vNxw7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4427jdJQyNtjXK04HeOBr5WGVfSfV/MGYYjol4kdns=;
 b=T3iF2D1RnR4pNhl0Y6O+cyu0iDIqpgq5StMC0nisA+RZwXuKGXVUyycRR+JeAmmqNXYKgg3QXY6PHsk0KUFCjGqcaNeZtqhgC4SpTU7XAd21EaO0huMDylMLg3d/8gvCGsww5e71R9cUbu+QCzhBb1p0+KfG9+lt+trOUWzGjIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Thu, 5 Oct
 2023 14:59:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 14:59:35 +0000
Message-ID: <d6768636-610f-4213-84c0-8989a4f1f5ed@amd.com>
Date: Thu, 5 Oct 2023 09:59:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/amd: Evict resources during PM ops prepare()
 callback
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20231004171838.168215-1-mario.limonciello@amd.com>
 <20231004171838.168215-2-mario.limonciello@amd.com>
 <12e15ad4-cfa5-4ce9-89a4-f8d1718cb256@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <12e15ad4-cfa5-4ce9-89a4-f8d1718cb256@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0198.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e2d4c4-66ac-4b03-a1b4-08dbc5b3b0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Amaoruf3sQhDsBqYi58Ez36XyhaH0fnC4mQ7NO7Hyn5mLBy1KdqEtvSl+aoltQlXXBK75AlyqkFhzKV9ym/J+XvfVJvLN74sRYvOxKEdbG6frxgzsAnBa8LMkrf9ew0X+HhznOQYbsE8Y0cMqyG0vWeDCvjf8ZJiO1Ac7zN/Z42AR+bW15GR4VYIaLdVwzZj4L7FXV+eXPC73FcmClIS5makFpz8Fb2J+cz0PoxXDrPKMI7SnODAJOT5IakPi5sNja0h6DNh1k3bbfRIiTZAnFKlfT6OsJen+liI7MkOYIV0ZSQ8eLuaNI96ZCYNtjewVs85ub/1Xa6Hu1CoUUxR1fL9nP+LyfQo/h8qiDr7/XilFM1q+dplqebBSmuN5/XVt7BitMSWWN8e0w+rT/VXIUVNrhesh0L+LZFitpWAzyrs60rLT1bdk3iRhWErvig/N68JUKs9vG2rqMYjVahyQeFMOxe5RibwC6WkLbihGYE3XDerkFy+RX7aApUraPBUeT9hUObT2ljwvTRtNs47RLDa4AdVnPW+2fzqax+beeh4yRRWEPTgxOeIQY5fIbhfGyIOSVYS8e2g3EVZzwpCJ8ElSTkexCzJMfbRKxORA20nAeyx+SIan2XpgNvu2r6a
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(136003)(376002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(66946007)(66556008)(66476007)(316002)(41300700001)(2616005)(53546011)(6512007)(26005)(66574015)(36756003)(6506007)(6486002)(966005)(478600001)(38100700002)(31696002)(86362001)(83380400001)(2906002)(44832011)(31686004)(8936002)(4326008)(8676002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW5LTEg1RXFRa2lWbDdJbjNNdWdsV21vcFpxRWwvU084ZkM1US9RdDZTb1pT?=
 =?utf-8?B?a3FsOTJXbWE0WDUzTjkzalU1QWNIZWN1azR4SXl4STM0THlKdnNsQjlJbjNi?=
 =?utf-8?B?bWRQL1l1ZDNKWks2U01MUHROMDFxeFVvcWJCYWEyaVAzU21TOWZnN0RwVGQ5?=
 =?utf-8?B?a3N3UlBBb2M3V0FoVnRQbi9yekJCeTFlb0lvN0p5QkcxM3hpeHZ5WWc4Y1VP?=
 =?utf-8?B?ZTZBcXB6a1ZiLzdRYm5wMkh4RjZhS2NHUGVNa1Y1bEVTRHZ1NHo4dEhvdkdt?=
 =?utf-8?B?Sk1XYzUrUUFDcXVCbVR5a0d1TU1URVVkc2tiLzE5R3ErTGxzR00rK0VEYkQ2?=
 =?utf-8?B?WDhXeEh0d1JhR0RXZkVRclFpL0FZUkgraGZaK3hwNUxpb2t0OXFnTEdqLzdp?=
 =?utf-8?B?YXZzSGxRNzRwTWUwTEFtMVFuRTN0NVV3cGl5NS82dTc2aEtuQ3hORnZPTWhl?=
 =?utf-8?B?ejRaSkt3dGI2bHpZeWJheTFnTEo3bkc2SENieWhXbnhOVlBTVnFWRGxLOHBm?=
 =?utf-8?B?bTNoTGM2cDN1dDJONUJsRkR6SnF4enBHTFZPY2dhR0o3RXZzZlYwN25sZ2xO?=
 =?utf-8?B?T0sydC9wSGM2Q0h5U21hWW1aSDVjY20xRFJqNHNiU3ZyTFVVemRRUG9UWSt2?=
 =?utf-8?B?WWRQcW5tdU9QcUNPZ2w2MjcwRnFlaGsrejdYb1R6SVIwL0REVVhTUVlsNmhQ?=
 =?utf-8?B?UjRTRCtyK2ZmcnlwRC9SR3FZb1FVTG5zK05waFhJUUcrbFlzNWtUbS9IUzNY?=
 =?utf-8?B?K0JYQloyM1Y1K2I2QXFzQWN2QVovUXdlaG5pUk5OQWw4Vk8wMnlKTjViYkN0?=
 =?utf-8?B?bml6Um9kUGNLVWpSNmRwS1N1NkdBZ3FWRVBOT0RhZEx2U3NCSnM3b3k0dWtp?=
 =?utf-8?B?dmdka3hFQ1VKeWg5aWN4ZEtVcmd1ZjdqV2dQTERYZ1lZYzY3MU02aGV0QUEv?=
 =?utf-8?B?YlNLRVZYWnpLZ3pEZktsd2d2RXJQZFU3eWc3NHU2UEN3Y29xWGd3c28xM3Vx?=
 =?utf-8?B?NUlwUGxGNFM5SmgzL2Y5b0JXZFhKWGw2MTNoLzdjSU5DQXVUdW5NQVBJaE5O?=
 =?utf-8?B?U3ZXVWhQZUpxbW0rK2hUeVM5TzR5c2FqekVYelhWT0pzOHhaaTJiaDcrWnFQ?=
 =?utf-8?B?eW9UOThNcnc3ZUM3QmQxNFhCTlpIbUdJbDhma3lmdE5vQ1dDZlhlK0IyaENR?=
 =?utf-8?B?WFVYNXh4elRHRmt2NXFic3VqaGo1cnEzSXFWcGZCUzhPaFpqVW4vSGlwcS9R?=
 =?utf-8?B?OGpONFk2THpWZEo3RTIvMlduK2NLU1RGNS9DV2FrdXBZUmpYKzNkRlNwUXVQ?=
 =?utf-8?B?Ykg2L1NyZFdINGVZUHFKTFJhMHVhZm1WYnBpWE5jR0hMUUltLzlNVW9uUmpR?=
 =?utf-8?B?NE1lckZMOTArWjhmK3hVRkdMS3RvODJxTHhseXhDMkNRL1IvdDRsU3VwbWJt?=
 =?utf-8?B?TWtFamI3b3NSU0Q5T1ZLL1RDdm1WN0NvQ2YrWCsrRWIrcUtnclRQQWlkQXBi?=
 =?utf-8?B?ZHI3b1FTNlBTUHBZZXRyd2lGejUwbVJyQ1EzUW5mWHl5aVVxdytiUlZPVWtW?=
 =?utf-8?B?eWYvdnpQcUx6TGZmUXo0T093a3ZsRGpkNk1oaTc3SDRXbUJNMXdOaHJ3UUsz?=
 =?utf-8?B?cC9WVmd6aEdFbzE4MEdGOGlQbER3NmgzdWMyTmdudmFIL1BVcjJ6WGMwTXJm?=
 =?utf-8?B?MThDakprZTBDWGJ2NmRsTWVlVXYyWXVtOUxPMHZWbHJRNTl3K3g1ZjNUSGsw?=
 =?utf-8?B?RDh6cWxQWlJqY2dmcW1DUzdQTjhHazZlMjFxL2ROYlZLalBIc3VpRkJVZ21r?=
 =?utf-8?B?ZnBzQ3BTVWdIS1llbGxad2x5V3JNWEl3WVkyL1NnUWJ6STIvQk54LzloZGVZ?=
 =?utf-8?B?L2N4SmRkMVQvWWVOQ0llRmJmYXhjWm1UenAvN1FOUkQrbXNhQVE0eEpheldU?=
 =?utf-8?B?R0lReDRkbnlLQWZzSjBpbUdtNnNtUXdGbjRIV0Y1Sktlb0pySCszaGNXTG5I?=
 =?utf-8?B?ZDV2MExzUFZiK0lqOStCbnpnNGJmT0dqbi8zYlRoMzRDUk1nVkRIZW9rNCs1?=
 =?utf-8?B?NG1xK2VCZFltV2VkTVl6cldScTExc1JGMnpPZDBxK0liVit3MkRpekMrem9W?=
 =?utf-8?Q?0s0/YiPiUSRuKriLFpcqJL4tY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e2d4c4-66ac-4b03-a1b4-08dbc5b3b0b7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 14:59:35.9162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gO8pZbhi6fyr3FlvkJYWHcqsD+N2aRcDtw70pDM/zb9fJasVXQg55fk6WEgbOv6njGsLDzZ9+56CEH/Bjx9Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
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
Cc: Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/5/2023 09:39, Christian König wrote:
> Am 04.10.23 um 19:18 schrieb Mario Limonciello:
>> Linux PM core has a prepare() callback run before suspend.
>>
>> If the system is under high memory pressure, the resources may need
>> to be evicted into swap instead.  If the storage backing for swap
>> is offlined during the suspend() step then such a call may fail.
>>
>> So duplicate this step into prepare() to move evict majority of
>> resources while leaving all existing steps that put the GPU into a
>> low power state in suspend().
>>
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 +++++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  7 +++---
>>   3 files changed, 30 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index d23fb4b5ad95..6643d0ed6b1b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1413,6 +1413,7 @@ void amdgpu_driver_postclose_kms(struct 
>> drm_device *dev,
>>   void amdgpu_driver_release_kms(struct drm_device *dev);
>>   int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
>> +int amdgpu_device_prepare(struct drm_device *dev);
>>   int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
>>   int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
>>   u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index bad2b5577e96..67acee569c08 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4259,6 +4259,31 @@ static int amdgpu_device_evict_resources(struct 
>> amdgpu_device *adev)
>>   /*
>>    * Suspend & resume.
>>    */
>> +/**
>> + * amdgpu_device_prepare - prepare for device suspend
>> + *
>> + * @dev: drm dev pointer
>> + *
>> + * Prepare to put the hw in the suspend state (all asics).
>> + * Returns 0 for success or an error on failure.
>> + * Called at driver suspend.
>> + */
>> +int amdgpu_device_prepare(struct drm_device *dev)
>> +{
>> +    struct amdgpu_device *adev = drm_to_adev(dev);
>> +    int r;
>> +
>> +    if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>> +        return 0;
>> +
>> +    /* Evict the majority of BOs before starting suspend sequence */
>> +    r = amdgpu_device_evict_resources(adev);
>> +    if (r)
>> +        return r;
>> +
>> +    return 0;
>> +}
>> +
>>   /**
>>    * amdgpu_device_suspend - initiate device suspend
>>    *
>> @@ -4279,7 +4304,6 @@ int amdgpu_device_suspend(struct drm_device 
>> *dev, bool fbcon)
>>       adev->in_suspend = true;
>> -    /* Evict the majority of BOs before grabbing the full access */
>>       r = amdgpu_device_evict_resources(adev);
>>       if (r)
>>           return r;
> 
> I would just completely drop this extra amdgpu_device_evict_resources() 
> call now.
> 
> We have a second call which is used to evacuate firmware etc... after 
> the hw has been shut down. That one can't move, but also shouldn't 
> allocate that much memory.
> 

The problem is that amdgpu_device_suspend() is also called from 
amdgpu_switcheroo_set_state() as well as a bunch of pmops sequences that 
I don't expect call prepare() like poweroff().

I would think we still want to evict resources at the beginning of 
amdgpu_device_suspend() for all of those.

So it's an extra call for the prepare() path but it should be harmless.

> Regards,
> Christian.
> 
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index e3471293846f..175167582db0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2425,8 +2425,9 @@ static int amdgpu_pmops_prepare(struct device *dev)
>>       /* Return a positive number here so
>>        * DPM_FLAG_SMART_SUSPEND works properly
>>        */
>> -    if (amdgpu_device_supports_boco(drm_dev))
>> -        return pm_runtime_suspended(dev);
>> +    if (amdgpu_device_supports_boco(drm_dev) &&
>> +        pm_runtime_suspended(dev))
>> +        return 1;
>>       /* if we will not support s3 or s2i for the device
>>        *  then skip suspend
>> @@ -2435,7 +2436,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
>>           !amdgpu_acpi_is_s3_active(adev))
>>           return 1;
>> -    return 0;
>> +    return amdgpu_device_prepare(drm_dev);
>>   }
>>   static void amdgpu_pmops_complete(struct device *dev)
> 

