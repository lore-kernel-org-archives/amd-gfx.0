Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9604EF9B608
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 10:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B06810E9A0;
	Wed, 22 Apr 2026 10:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PxQmjijl";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012030.outbound.protection.outlook.com
 [40.107.200.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6600910E9A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 10:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qn39ULnTnR9IfaVARzQAlfFj4HVWAgE7ot4MPVSJZjQyxviihQ8Nrrc45c1/bbpPm564WginqVoSvAAgu6UEh2TvBshmqZfT5pBxRgR61dVrrQl5sLNigcabNbM79WiBO7YBsCkdF7rfxaBP64G9+BZ/568ylOA3GxSamWc1Nj6s4h5wYTwUIRjPe5TI1XdX7ysnUMquIxAWBHOCmgb6azK19/lIc/1AMb5YSld/P5Ie+fhbL4/Ngm6nsazcX6p9ocNR2cxNo1nsqj/GQnRM6umZ6vZYi0Kuy5/S4Ibsb2g5D791EGvf/FbJwT4fuC+wG+FDYAgXS8HvVJiyLHDzyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBaEEaaWx6GhLw2LnYKDQQrYT9gdf5H4fUUCxaAb4WA=;
 b=ppCVOSXnk1EK8N2tqX2z7X0zkRJ/75ExM4V86ONXdA0Nmi1mndwo0R8GgKSznPS5OdwHHasOmyklxbLQl33zbhonC94kgBtOKjOdf3jirX+P87mjQIb4eJINyXl/lW+iD/TaorRtKSi2RgwcSsb5h3Ex+GD7IAXLtp6uBXn9xB+gF92TxOCvk6l5YyEb2yOUkWpu6MUH9ScJAnqfPqmSHtKmlA6+gEsHuQN8E7kPPJBQGpoVk0j/1hm6UUthu2JjGGxSx0n3Pzo8jMTTdRbfwKXjjk6jM3GRkwNVcXeRtHNkPw4Hwn5j4DUJq6BSE7AfoiqKcK1gvsK4ahZRVYxbbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBaEEaaWx6GhLw2LnYKDQQrYT9gdf5H4fUUCxaAb4WA=;
 b=PxQmjijliMQPp4aAr87TClC3Fi8YaTXhCVYNGw3KbqmwshjmjkhxZQMggscUUwpJqiaVdlPUH1qJq7wQg9VpxrMyRC25rnZo6HFFerogRbiKHcN+BPZCDWVKwUSLydzAI6/rzCOzrsJeL8RtvElh2u1V2zCiZHwWjSQWLyftuBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8814.namprd12.prod.outlook.com (2603:10b6:8:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Wed, 22 Apr
 2026 10:12:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 10:12:37 +0000
Message-ID: <ffed97ca-b8f4-414c-964c-3153df1d87e7@amd.com>
Date: Wed, 22 Apr 2026 12:12:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] drm/amdgpu: nuke amdgpu_userq_fence_free
To: "Khatri, Sunil" <sukhatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, Prike.Liang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-3-christian.koenig@amd.com>
 <4a0892be-46b9-4720-9b7e-398aa0a74c87@amd.com>
 <b53997ef-f55c-4813-bca6-2308475db357@amd.com>
 <e3320914-cd30-4ed2-8c92-783a67a5dad3@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e3320914-cd30-4ed2-8c92-783a67a5dad3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:208:32d::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: c99e584b-0686-4c5e-8043-08dea057adba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: ny3tHcRnMqNjf4kqv9vSt+zL07whHoVEGYJg105T8e6wUDnIvlhPYO20C6JDLmVS/erVv2qbpp1mJp22Bg2VPWE8T73mf5olwY/5eoo/PhAL/ZODWOOcKtASh4vfPm74qwxCWkMH/CGVSEg93Qub1TneA89e2+5jDoIXogYQuddrhNI+YBmr6oGeMVQfOh/ue+YCx+f34B1J1xeub4t7qdX1ds0E58TVvg3vFEElaOs4ZrSMlNoYmlL6sc4kbXP47Oirg4hXNc9lf6ZaWriMJ+e+NJ1xazMP2lbJYRCop+ET579xUGOC+0cg6n7xxjhW7lkmpfNFCHhQS9cybskSKkiCTX5vSaPH0PHdjrQzqpQmSVS+s19f76QrDgj4pqcU1VsV6hRH9orvRqveeB8DqN194kbnXvnwt9OTyxCyg1Xm/Jv1LNzhrfRs2854YpjB7OgBE6OBeeJWLlmyJWDWJr2VMU7ek+RjajXeNrRYncBH82TOSSIoz/obYHi3Ol5XlT5DuhIwdGfZtXyUlHk/R81x0foP11XPJEq6pqLNA/08m+SVne8LnkZWGR+p0goa9waSnwNsJOVk0hTKuIpgrOWcvIX78u1W7ojc7tE/YJopjFhm3rjuW6PqvNX/A4/EIAsaw8Pq1F9QUytbhA/nBlhumkFTnxiwp/KM8SlKRTN1iPtlT4EeqtZN+xMmtnbNIMdLocXzBtXkhgiLGJFKG//x6chfxwqYgBTzHmXZWBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlZIdGt0aTZEZ0F6d2pPZnE4M2Rxa3FpOXA4NDJYTzhEQTNhZk1neE9JSXZo?=
 =?utf-8?B?b1YvNGJGRmZmQUw1WG9IdWN0NGxMQ01tTWkrQXArR1FGay96NTA4YVRndCtD?=
 =?utf-8?B?bXFOVmsxWmxya0d0ZDE4ZGMvVm1iYmIzSElQWkZOOCt0U2J2eWtJYWtrRjd3?=
 =?utf-8?B?SFprSnMxdU5XVjlMdVl5ZWlMa3R5NmxySnpEY2RXZXFWSU1iaVlodjU3N0RK?=
 =?utf-8?B?ODFxWFV1dmVNUWFUSDlwNnQ0SUpUN2thSE9CVEpSdDNqVTBzNVd3Z2dGTTZK?=
 =?utf-8?B?WmFPS0QrZkxyanpBZEJWcmFYSUd2UGFVcnc5L1U5bDVpbUdYVTlRUmNBdmtl?=
 =?utf-8?B?Mm9GL0QybGsxMWVXcHJGUndXSDcwY2dEUmJjUTBHMUlmb2txUXh0em9sVjRq?=
 =?utf-8?B?QUFHeGxoTEF3Q0tLdmNTd3pVdXMxck5HRGNrVFNSWVVGaDVhMEhtRVlRTXNr?=
 =?utf-8?B?NXE3OUM4QnphY3FzMG43WUdOOHE4bmZteHUwSHNqV3BSVUZtU2pha2tqeTJP?=
 =?utf-8?B?cTVHc2dJSjJOc0d2YzhZYnV1SzBIWmlzOUJyMHRGOE8wL3oyYmM2bEZhb0s4?=
 =?utf-8?B?TmJFY0pscVVXNklsTjk3NGlxOWEzTUJKTGJhQ1d5Ri9MWDdJSXYwVlRDV2lH?=
 =?utf-8?B?NTNIbGs0ODdBM1pGdmJzVnhTMDdVY1RvcUZjcVd0Mnc3MEJGclhkM3RXNHVs?=
 =?utf-8?B?aCtLdnZGM1FsUFpJQkhYUmk2Q3JTbytlbUcrbWFlK3ZxWnNkbk1URlBvME5i?=
 =?utf-8?B?dnJWSlcxbTdkVWh0R2xlaWRvR2Naby83S2V5QUh5OU12eHcxZGNlcExnSTJt?=
 =?utf-8?B?RGlyK1d1ejV3cklzMy8xRnh5OU5Ib3dSVTltNEJWYmEwMUR4Q0U2Z0hhSUlC?=
 =?utf-8?B?bE8vcVlPZ0dTN2h3bmJubFVDRG5zUURPeFFKbDZyaVhVMHEzNGRhV0NJZkFt?=
 =?utf-8?B?eDZzMlRnTVJYOTMwcUNkQ3d4c1FET3hXZEVMWElkNFVGSzR1Qktkbjc4VE91?=
 =?utf-8?B?aHQzbkUwOWZMRE1BYmM2WUpvai8wd04vK2FrcEROVjdNcmZpN1UxZVYwVkhj?=
 =?utf-8?B?WHd4SCtBWk9NOVBxTkx5SEkzY0Qvem9lRENSbFZZTGg1SXZLV1NWUnBxMmpx?=
 =?utf-8?B?bE5rcDNka3dqUVpqMkZSbUpaMkhPaURrVGxzOGh1Ulc0NTEranNOblVrbTYx?=
 =?utf-8?B?TGdIZnhRTFdYNkszQ3ozVFl6RCtNZHplL1A2QTN2bm1aemxYaGdGbUZRaHRB?=
 =?utf-8?B?UmtoNkpKSmdaRmcyVG5VQ3FUbUhJRndJemZmMitsZE93dUEwaldhRk5tZzVT?=
 =?utf-8?B?MVBOU3JiR1F4TldhTVRndUkzRlhuMXp1dzNJQkdFTldWOUhNZUcydGtMem9P?=
 =?utf-8?B?Y0RVaXZObmtjcEgyMDFWb2ZzbUoxN2o2WXI3N0NHcWh6N0JzWEYxWjVnL1hz?=
 =?utf-8?B?SVVuR0xiSkxlK2kraXFkczRHT0VaM2hhK2ZXMEpLb1dDYnA3QldGSGFNTmYx?=
 =?utf-8?B?SVhyUS9TTmVKYU8xNGlnNkh2eXpROHlCT25QalpRTmFRcFliNzZLcDJMTXVK?=
 =?utf-8?B?c3p5STFEdDJTTHF5WWpGUjZXUHdhek5WTjBONGtOa253T0gxekVBMkVxaFFH?=
 =?utf-8?B?M1VlTHBHQlFkL3dBdjZnM0NBTjJQUU03YzlSKzZEVWlSdVR4SUF0Y2VobkE5?=
 =?utf-8?B?c3MxMllOOU1LaVovS3pZcmZXTE1WK1JReEhrVjJiK1BPb1RLcXBGS290V3d4?=
 =?utf-8?B?UTRXa0NxcHV4TTZlTXp3VHluQ0h4MkgydzR5TVdPZ0ZpN2dla3MwNTV0bGNU?=
 =?utf-8?B?UWNWYW9RbmlXT1AwZTF2ckNYR1JOUkoxemVDbmJ5WEg4SWdRZVlNcVVMZ0Nw?=
 =?utf-8?B?SHNjVTVOalFJQWN1S0NVTDZYelNDb3VUMWRlQmJLYUhvWjVNWFRUTGlueSsv?=
 =?utf-8?B?K2lOdk94SUF2elg2d1VpdTJ0bDNKWkdreXM3TlNlTXdHb2hFcEVyUTNEVXRV?=
 =?utf-8?B?U2RFd2dkbFNSeFE4UXdHOWV2ZHV5d3pLdTN2K1Q3bFk0UFBJekx6Q1NDZ0Uy?=
 =?utf-8?B?R0FrRnhXeXd3ZGhSV01zRmZXcFFrbHFLVWt4OCs2dngzOUlMcmZJeHBJOXQ5?=
 =?utf-8?B?MVdEYzh6QVFMNUFrcnZTbWtteVFkTFdrQ25CUGFWdVZrV2lwYkhnQkNrcTNl?=
 =?utf-8?B?eVVpMnZJL01BN0UyS3c0L0NTMzlPRmhEYkVGSnZjMSttQ0VzNWFkc2tBTWxh?=
 =?utf-8?B?b050b0FTQUxVYmY5UTB4NjFwZEtQa09MNzB2Z3Y5Z0hZWkhFY3hxZmxhaG9X?=
 =?utf-8?Q?vjPdizUXv6IA1Qii+0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99e584b-0686-4c5e-8043-08dea057adba
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 10:12:37.2273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QYT8YY5mIxgAIJ6LR/e0brq35uufmA3yX8lfOQzWgU+SA7pF85P5HkvfAf63mt2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814
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

On 4/22/26 11:40, Khatri, Sunil wrote:
> 
> On 22-04-2026 02:56 pm, Christian König wrote:
>> On 4/22/26 10:29, Khatri, Sunil wrote:
>>> On 21-04-2026 06:25 pm, Christian König wrote:
>>>> As preparation for independent fences remove the function and do all of
>>>> it's cleanup directly after signaling.
>>>>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 13 +--
>>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 79 +++++++------------
>>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  3 -
>>>>   3 files changed, 31 insertions(+), 64 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index c6546a858597..1b15b51dc3f4 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -3162,11 +3162,7 @@ static int __init amdgpu_init(void)
>>>>         r = amdgpu_sync_init();
>>>>       if (r)
>>>> -        goto error_sync;
>>>> -
>>>> -    r = amdgpu_userq_fence_slab_init();
>>>> -    if (r)
>>>> -        goto error_fence;
>>>> +        return r;
>>>>         amdgpu_register_atpx_handler();
>>>>       amdgpu_acpi_detect();
>>>> @@ -3182,12 +3178,6 @@ static int __init amdgpu_init(void)
>>>>         /* let modprobe override vga console setting */
>>>>       return pci_register_driver(&amdgpu_kms_pci_driver);
>>>> -
>>>> -error_fence:
>>>> -    amdgpu_sync_fini();
>>>> -
>>>> -error_sync:
>>>> -    return r;
>>>>   }
>>>>     static void __exit amdgpu_exit(void)
>>>> @@ -3197,7 +3187,6 @@ static void __exit amdgpu_exit(void)
>>>>       amdgpu_unregister_atpx_handler();
>>>>       amdgpu_acpi_release();
>>>>       amdgpu_sync_fini();
>>>> -    amdgpu_userq_fence_slab_fini();
>>>>       mmu_notifier_synchronize();
>>>>       amdgpu_xcp_drv_release();
>>>>   }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> index a58342c2ac44..909bdccc2a92 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> @@ -32,29 +32,9 @@
>>>>   #include "amdgpu.h"
>>>>   #include "amdgpu_userq_fence.h"
>>>>   -static const struct dma_fence_ops amdgpu_userq_fence_ops;
>>>> -static struct kmem_cache *amdgpu_userq_fence_slab;
>>>> -
>>>>   #define AMDGPU_USERQ_MAX_HANDLES    (1U << 16)
>>>>   -int amdgpu_userq_fence_slab_init(void)
>>>> -{
>>>> -    amdgpu_userq_fence_slab = kmem_cache_create("amdgpu_userq_fence",
>>>> -                            sizeof(struct amdgpu_userq_fence),
>>>> -                            0,
>>>> -                            SLAB_HWCACHE_ALIGN,
>>>> -                            NULL);
>>> Are we not having benefit enough to continue create a cache here ? If that is fine that LGTM,
>> Using all those kmem_cache instances was a bad idea to begin with.
>>
>> See the idea of a kmem_cache is to reduce the number of CPU cache lines and memory you need for certain number of objects when the object size is not a power of two.
>>
>> So for exampe two objects with 96 bytes only take 3 cache lines and 192 bytes instead of 256 bytes and 4 cache lines.
>>
>> But that difference is so marginally for most use cases that you absolutely don't need it.
> 
> Thanks for the explanation. Also if i am not wrong in cases where last no of such objects are often created and deleted kmem_cache helps in reuse and helps with internal fragmentation too.

Nope that's not correct. See kmalloc() and co also uses kmem_cache underneath, they just round up the size of the allocated object to the next power of two.

As long as you don't give special flags kmem_cache object storages are also shared among users, e.g. when one driver creates a kmem_cache for an 96 byte sized object and another driver does the same they will actually share their allocations which each other.

Regards,
Christian.

> 
> Regards
> 
> Sunil Khatri
> 
>>
>> Regards,
>> Christian.
>>
>>> Acked-by: Sunil Khatri <sunil.khatri@amd.com>
>>>
>>> Regards
>>> Sunil
>>>
>>>
>>>
>>>> -    if (!amdgpu_userq_fence_slab)
>>>> -        return -ENOMEM;
>>>> -
>>>> -    return 0;
>>>> -}
>>>> -
>>>> -void amdgpu_userq_fence_slab_fini(void)
>>>> -{
>>>> -    rcu_barrier();
>>>> -    kmem_cache_destroy(amdgpu_userq_fence_slab);
>>>> -}
>>>> +static const struct dma_fence_ops amdgpu_userq_fence_ops;
>>>>     static inline struct amdgpu_userq_fence *to_amdgpu_userq_fence(struct dma_fence *f)
>>>>   {
>>>> @@ -146,12 +126,18 @@ amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
>>>>   }
>>>>     static void
>>>> -amdgpu_userq_fence_put_fence_drv_array(struct amdgpu_userq_fence *userq_fence)
>>>> +amdgpu_userq_fence_put_fence_drv_refs(struct amdgpu_userq_fence *userq_fence)
>>>>   {
>>>>       unsigned long i;
>>>> +
>>>>       for (i = 0; i < userq_fence->fence_drv_array_count; i++)
>>>>           amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
>>>>       userq_fence->fence_drv_array_count = 0;
>>>> +    kfree(userq_fence->fence_drv_array);
>>>> +    userq_fence->fence_drv_array = NULL;
>>>> +
>>>> +    amdgpu_userq_fence_driver_put(userq_fence->fence_drv);
>>>> +    userq_fence->fence_drv = NULL;
>>>>   }
>>>>     void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
>>>> @@ -181,10 +167,11 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
>>>>           fence = &userq_fence->base;
>>>>           list_del_init(&userq_fence->link);
>>>>           dma_fence_signal(fence);
>>>> -        /* Drop fence_drv_array outside fence_list_lock
>>>> +        /*
>>>> +         * Drop fence_drv_array outside fence_list_lock
>>>>            * to avoid the recursion lock.
>>>>            */
>>>> -        amdgpu_userq_fence_put_fence_drv_array(userq_fence);
>>>> +        amdgpu_userq_fence_put_fence_drv_refs(userq_fence);
>>>>           dma_fence_put(fence);
>>>>       }
>>>>   @@ -231,7 +218,7 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
>>>>     static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)
>>>>   {
>>>> -    *userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab, GFP_ATOMIC);
>>>> +    *userq_fence = kmalloc(sizeof(**userq_fence), GFP_ATOMIC);
>>>>       return *userq_fence ? 0 : -ENOMEM;
>>>>   }
>>>>   @@ -299,7 +286,7 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>>>>       spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>>>>         if (signaled)
>>>> -        amdgpu_userq_fence_put_fence_drv_array(userq_fence);
>>>> +        amdgpu_userq_fence_put_fence_drv_refs(userq_fence);
>>>>         *f = fence;
>>>>   @@ -333,29 +320,10 @@ static bool amdgpu_userq_fence_signaled(struct dma_fence *f)
>>>>       return false;
>>>>   }
>>>>   -static void amdgpu_userq_fence_free(struct rcu_head *rcu)
>>>> -{
>>>> -    struct dma_fence *fence = container_of(rcu, struct dma_fence, rcu);
>>>> -    struct amdgpu_userq_fence *userq_fence = to_amdgpu_userq_fence(fence);
>>>> -    struct amdgpu_userq_fence_driver *fence_drv = userq_fence->fence_drv;
>>>> -
>>>> -    /* Release the fence driver reference */
>>>> -    amdgpu_userq_fence_driver_put(fence_drv);
>>>> -
>>>> -    kvfree(userq_fence->fence_drv_array);
>>>> -    kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
>>>> -}
>>>> -
>>>> -static void amdgpu_userq_fence_release(struct dma_fence *f)
>>>> -{
>>>> -    call_rcu(&f->rcu, amdgpu_userq_fence_free);
>>>> -}
>>>> -
>>>>   static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>>>>       .get_driver_name = amdgpu_userq_fence_get_driver_name,
>>>>       .get_timeline_name = amdgpu_userq_fence_get_timeline_name,
>>>>       .signaled = amdgpu_userq_fence_signaled,
>>>> -    .release = amdgpu_userq_fence_release,
>>>>   };
>>>>     /**
>>>> @@ -546,7 +514,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>>       r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence);
>>>>       if (r) {
>>>>           mutex_unlock(&userq_mgr->userq_mutex);
>>>> -        kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
>>>> +        kfree(userq_fence);
>>>>           goto put_gobj_write;
>>>>       }
>>>>   @@ -871,6 +839,7 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>>       for (i = 0, cnt = 0; i < num_fences; i++) {
>>>>           struct amdgpu_userq_fence_driver *fence_drv;
>>>>           struct amdgpu_userq_fence *userq_fence;
>>>> +        unsigned long flags;
>>>>           u32 index;
>>>>             userq_fence = to_amdgpu_userq_fence(fences[i]);
>>>> @@ -886,7 +855,19 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>>               continue;
>>>>           }
>>>>   +        spin_lock_irqsave(userq_fence->base.lock, flags);
>>>> +        if (dma_fence_is_signaled_locked(&userq_fence->base)) {
>>>> +            /*
>>>> +             * It is possible that fence is already signaled and the
>>>> +             * fence_drv now NULL, just skip over such fences.
>>>> +            */
>>>> +            spin_unlock_irqrestore(userq_fence->base.lock, flags);
>>>> +            continue;
>>>> +        }
>>>>           fence_drv = userq_fence->fence_drv;
>>>> +        amdgpu_userq_fence_driver_get(fence_drv);
>>>> +        spin_unlock_irqrestore(userq_fence->base.lock, flags);
>>>> +
>>>>           /*
>>>>            * We need to make sure the user queue release their reference
>>>>            * to the fence drivers at some point before queue destruction.
>>>> @@ -895,10 +876,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>>            */
>>>>           r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
>>>>                    xa_limit_32b, GFP_KERNEL);
>>>> -        if (r)
>>>> +        if (r) {
>>>> +            amdgpu_userq_fence_driver_put(fence_drv);
>>>>               goto put_waitq;
>>>> -
>>>> -        amdgpu_userq_fence_driver_get(fence_drv);
>>>> +        }
>>>>             /* Store drm syncobj's gpu va address and value */
>>>>           fence_info[cnt].va = fence_drv->va;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>>> index d56246ad8c26..d355a0eecc07 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>>> @@ -58,9 +58,6 @@ struct amdgpu_userq_fence_driver {
>>>>       char timeline_name[TASK_COMM_LEN];
>>>>   };
>>>>   -int amdgpu_userq_fence_slab_init(void);
>>>> -void amdgpu_userq_fence_slab_fini(void);
>>>> -
>>>>   void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv);
>>>>   void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
>>>>   int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,

