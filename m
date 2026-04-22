Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD090F9B5FE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 09:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6090810E00C;
	Wed, 22 Apr 2026 09:40:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3JCCKYPV";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C741810E00C
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 09:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w64EnsX3sbZwfKAdD9wVYDXym2AVPSB7Rb5PFn0q1jpNJRVxC+knuIuN7W1wtHk1AsiRg0DpNeC1JRnvn1ryXV0ZB1pwv7odkujY1ervHKRVNokVETRRrrHpb7t9Gv5HsD1Wp/q6CdeIxzb2FUSzRsYTTMxQiXIGWTn8ECQ6ibOBXixlEmTmut3bCxU9BC34mVHGGRdVJecDHgdLuG9/JZUnH8kUv08ltk6r+Lohe4NSp8NwsE5P9OCRBe0Mu5pUrpq06z9dSNpVBDrqutTyVSH1QBDSFx1IRtCs3aCWkCjBqcyMZHsUNtmQphbctqJBF95vxVOXLOyZfJwmLz4SQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWz7Vsdixns+0c0eTvNVO4hWTBKDU2nyAakZFCMn0pM=;
 b=vqPpUjWwTmwqusDOuzmzE9g3B7UDYcXQR7/JBbiMjlvEkm5Hm/K//wdNs74aeXKR6qXZiKwj5efqjU+LeZ5qmaPKSfWpRgcQq39j3qOY6mZgNj9cexOUv1iAvbe49n15I3g4APe/6ceXPK5LnUI4fvfMsTuOthE/w+3HGNpNnxg51kViKhXAYfQEi9mW5sCBvXxEQ47quRVMUOlyHir+chFMM8cScFECDGY2ptHgKXXuG7bkpAuxpDVavqATr3jXPsWvW4jYB61IRDjVl+3e72hylxmZ8K4QFL1Gc9jIdazoEPnPT8wm38qbibu3WMfAzAAD5b4fiqHtx34LDwtGqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWz7Vsdixns+0c0eTvNVO4hWTBKDU2nyAakZFCMn0pM=;
 b=3JCCKYPVS9z77u8MCLqSzLlUEfu0ThagTJ+m3ENxxcfLdsAyLzdckx+wRVqrc/stHtMjSPoa6BeYiXnxCr3hmRvex+Exb/mA8zMdFNArhSGjGcNu9H/TiYzakhAMr5Q8baopMsiTSi9zgfBIZw3j4A5KcvcLtHzJA1zPUWXh660=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS4PR12MB9634.namprd12.prod.outlook.com (2603:10b6:8:280::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 09:40:07 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9846.014; Wed, 22 Apr 2026
 09:40:06 +0000
Message-ID: <e3320914-cd30-4ed2-8c92-783a67a5dad3@amd.com>
Date: Wed, 22 Apr 2026 15:10:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] drm/amdgpu: nuke amdgpu_userq_fence_free
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, Prike.Liang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-3-christian.koenig@amd.com>
 <4a0892be-46b9-4720-9b7e-398aa0a74c87@amd.com>
 <b53997ef-f55c-4813-bca6-2308475db357@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <b53997ef-f55c-4813-bca6-2308475db357@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0203.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::15) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DS4PR12MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d98a2be-717a-4831-147f-08dea053230e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: zJW4QFQO617HNQs2nRXfO4wjJFrG1nP43Wcyll26wT+zLdRQ4mripgeb/KgrShBtgSLpqOLlwTp/ecAABgyEg71J5YLSCQWOjxBoBpUkEb7EPEfckVeU2G229I5cETbyjTaBRPf+zT0nw9/jSyrppr1YCEwUb21JOXfjVFHnJcXvqDiEfJ9Ct2+VbWniRAUDRnPUOu9j0dCz+fkIW/H6ExoVfqn5EDba0sLSK7CkcjVlZhNE5RMX51Kxs2oCE4KfY1+KNl6FWztRMJGWLMdXLz3ro5BTgcfpVEiBI5QXdBWplFDU7RifDKD0/R0SNk7nNZqh72yNErPOGgV7G85eyP/3ezvUgUJAi64ucQc1WoWXMbl3P+2Kar4Sy/xzS9NbJ5Z0iodvC8sFys8QgRgU04lcJ41I5cP786sK5NeAEDkWue7/OipA9jeeqHlidRT9ou7M8kKoORVvLsbYh91WLtoJQ/5FH1vK4TMAUFTW9fGsTb0RCHYqe/b7A4yEb+1yGmTK3RDQVZ53HBHRRVYPdKH//kRu4/O0pRgOnbMyQhpuErzvyY+x1LWHmOmuSWctEUNabuGwLv72TLRJJjHqVI317ACHiDjckHFLmaAiVN4L+bkamPTG7KoE5sQWicIoKB65+/MPXoTgx0TpqXDIxsQS5w8+rDbwWLCfAOolnbwgzrCJEprlEQ9G1hcyOK1Oq+VVsOxp+JrJ8J2LjBT1a+fxg/1j7wYbAXKA7vC0iRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjZoVlpUb1ZQL1lDZ2Z0Tjl1WDhkaGd2TlVaeFBMamEvWUptTTlVUUtpV1VJ?=
 =?utf-8?B?RWdXY3NkajRINTRiUFU3aGRmZU5KRit5QlhTTWJ6MmgrUUg2U2IzQW9MM1dM?=
 =?utf-8?B?YWFKMVFGbXBpSEYwa2Fra0pWOHAvaE0rQVR4YWJXbStzU3R2SEhJaXhhYWJk?=
 =?utf-8?B?N2ZGaVdPZGNDeWxVTE1UNEdDZjM2OS9KcGFPcEl1WWowTEt3YldwMktaQlFU?=
 =?utf-8?B?R1NKZHI1V2Q3TzJTdjNhQXdTekQrcEhhQnk2ejJQNmg2TlIwL0FBdUJ4VC9T?=
 =?utf-8?B?N2Jld1diN1RVeXRYNTNESVg5UlRTOTEvdVpXVGxJRjFia25iS2Jmd2k4d3hY?=
 =?utf-8?B?ZTBmcEpXVlB6UFY3ZUhvOFNWdmErMytvZ2N3bXpXYUhpS0ZKTTFmZVRUWjd4?=
 =?utf-8?B?eUhYQXNWMmJQRXIvOERQOC94bmt6ZkNtaFl6UkRkRnRDWk94M0xhbmljMVpp?=
 =?utf-8?B?bDl4dVViNEJNRXlCYm5JVXhxTGRjNFN1dzdwVEZtcXFTVWhtRHNTNkd0Zlc0?=
 =?utf-8?B?U3BlQmNSMmRTdXIyZExRSHhtUEQvam1ka1hhd1BhNHIzVHVSaVdnTTUyZnla?=
 =?utf-8?B?YWJXVjB1NFFrd1BRaE13ZWVUVzRUSUlGZXZNMEFGN1NlQ1gwYWpSUFgwNS9X?=
 =?utf-8?B?c21RZGpZQXNxM0ZhZzFzZ2tkVVpGOGRxc2x6dDR1c01ETWFWdXVvS2dCcVRK?=
 =?utf-8?B?U2JHSlZKbnhheVBVUjVjL0d1eTJ1ZFI0VHZENDFKT1FsaXJ6RVB2cHY2QTZD?=
 =?utf-8?B?Y0VEMnNSSGZLUDhDVnBrVXVZNXNERkU3R01zaFlma3NMYlk0MTVjVm1CL1I1?=
 =?utf-8?B?UWhGSTBFUDR1VmozSjZ6RDdpRnhvVmhSY3ZyV2I4bmdWSWZtTWdTUnJ5ZXRB?=
 =?utf-8?B?N3F2WWYreVNZZFJZbVdwMlhBbDdveVVVWjRIeFRKdVZKc3JESzdHYVBOdVFY?=
 =?utf-8?B?ZFEvd1JZL0ZRc1owYm1SeERoWElON2tCUGdkRXpoRjE2NXpidlR3dXA5a3FR?=
 =?utf-8?B?TEFsMElUSGwxOHNXay9BTGcrVlpocDhZdS9ZNnBuOFZJUmdXMlMvMys1am02?=
 =?utf-8?B?Qk9QL0tqMStlcVdudllQdTgrQlUvbDRoT3AySG12VGROUHB6d2FBY3VUcktz?=
 =?utf-8?B?L0E5ZUVOUERtL3JXelpsUktSb0NoUU1iVFc2S3N6MXlBMmVnUU41U0U1amFv?=
 =?utf-8?B?dWZ1Nll1QnJINUlWZU54cUVuOVlLeTFaY2Z3WTBwQ0liVVVPZFAvK1NhcGxa?=
 =?utf-8?B?a0NqRC80NUYvV2JGSlZXRkFEbWRPK01BUWtYdkdvelFnS1NOcUsxQkRYZGFi?=
 =?utf-8?B?V3phK2lQRXR3b1JNWXVHTStWWEVMb1RLMzg3V1k5WXNlWXNSS1U0M2Y2eWZz?=
 =?utf-8?B?MHppcDJQU29ZakYrdERrL0FxYm95eThLMDBHUkwvYzN6MVNRWkIyNkgvcE0v?=
 =?utf-8?B?TjJYT1VjdXRQaXZ6cTF2dFUyTXgvaUN0RGZDWlZJZDlWdk54UjltK1FmVnJ5?=
 =?utf-8?B?ZzlWVmdIalBWRWZpSVdxSnJZMi9WalU0d1VteVFLMllKblU0UEtLL3dwdTcr?=
 =?utf-8?B?cXgrYytvUGh1RkYxejNaTHgzSzhiMS9xTExpc2swZmJXWEVwK1QwYXAwaUZ2?=
 =?utf-8?B?d1hhV2V2QjJ0RkFQTEtwTnlBemkySlJydGRwbVlYeDBRU2FGY0dSVjNHQlJl?=
 =?utf-8?B?cm9vb2s1ZFgzd1pYem1venhjblpVL3R0bWppd2NuMmJxVnQ2MEh6a0NVaWlr?=
 =?utf-8?B?TzlTcGwvTTNKdHpnVWJNd1Myc2d2aXMyWllqTWQ2Q1QvYVlYRTF0RjRKYkJk?=
 =?utf-8?B?RlhpNSsvbGxQeENYdTNBb0pvMVBCVXhNOEFhTEJpVXBOWklZbnBKeHdIYWJV?=
 =?utf-8?B?dlpzbm1lSFNQK1BLM0d3L2pSeDVSQWw5YS9vV0ZiZVBYY0hXSGxOb3pJV3pT?=
 =?utf-8?B?RHozYmU2T2w3RlNFSDRPL2JIemdsbzBYaUJUc3RNODZ0VUE4c2RESzhOaTZ1?=
 =?utf-8?B?ZUJaUVcwTFNjSTQ3SjNRdlFZU1Y2L3ZqSWphdWJnb3N6djFvOHlUUFZUNzRM?=
 =?utf-8?B?VXVqSjFnVEhXZ2FINjlCaVMyUjRYeml4eTF4ZE44SFBieWFvT2hoM0tsMi9q?=
 =?utf-8?B?OU0wRlkrdzBhZmMrWGJGY28wNENOS2JwUGphR3lLRGZlb0V5Q0FTbDN4UndK?=
 =?utf-8?B?RXdSRUxlQytZdEU2d3I3akE4SVdQOXUrRXg5cW44UWMyYzNQWGR3ejlDWEFq?=
 =?utf-8?B?dURPM1QyZE5PeEsyOVJQYk1aVi9lUUU3dGpKRmt2ZS9pTTE5R3dUQjZvNXQ3?=
 =?utf-8?B?VHVtSVV0L3ZVbUxUbE9IekxHWEN6dmxOSFBQOVBUWWp2cUVoa1E4dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d98a2be-717a-4831-147f-08dea053230e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:40:06.7879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnmGN3Rvu7YviH/TpC7Yn+8dDv/6dn/F71Xcokl6wMGQqLXm6hQilX3VyyApxoX+K1+qmhpgXjCob5AhpuE6ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9634
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


On 22-04-2026 02:56 pm, Christian König wrote:
> On 4/22/26 10:29, Khatri, Sunil wrote:
>> On 21-04-2026 06:25 pm, Christian König wrote:
>>> As preparation for independent fences remove the function and do all of
>>> it's cleanup directly after signaling.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 13 +--
>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 79 +++++++------------
>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  3 -
>>>   3 files changed, 31 insertions(+), 64 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index c6546a858597..1b15b51dc3f4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -3162,11 +3162,7 @@ static int __init amdgpu_init(void)
>>>   
>>>   	r = amdgpu_sync_init();
>>>   	if (r)
>>> -		goto error_sync;
>>> -
>>> -	r = amdgpu_userq_fence_slab_init();
>>> -	if (r)
>>> -		goto error_fence;
>>> +		return r;
>>>   
>>>   	amdgpu_register_atpx_handler();
>>>   	amdgpu_acpi_detect();
>>> @@ -3182,12 +3178,6 @@ static int __init amdgpu_init(void)
>>>   
>>>   	/* let modprobe override vga console setting */
>>>   	return pci_register_driver(&amdgpu_kms_pci_driver);
>>> -
>>> -error_fence:
>>> -	amdgpu_sync_fini();
>>> -
>>> -error_sync:
>>> -	return r;
>>>   }
>>>   
>>>   static void __exit amdgpu_exit(void)
>>> @@ -3197,7 +3187,6 @@ static void __exit amdgpu_exit(void)
>>>   	amdgpu_unregister_atpx_handler();
>>>   	amdgpu_acpi_release();
>>>   	amdgpu_sync_fini();
>>> -	amdgpu_userq_fence_slab_fini();
>>>   	mmu_notifier_synchronize();
>>>   	amdgpu_xcp_drv_release();
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index a58342c2ac44..909bdccc2a92 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -32,29 +32,9 @@
>>>   #include "amdgpu.h"
>>>   #include "amdgpu_userq_fence.h"
>>>   
>>> -static const struct dma_fence_ops amdgpu_userq_fence_ops;
>>> -static struct kmem_cache *amdgpu_userq_fence_slab;
>>> -
>>>   #define AMDGPU_USERQ_MAX_HANDLES	(1U << 16)
>>>   
>>> -int amdgpu_userq_fence_slab_init(void)
>>> -{
>>> -	amdgpu_userq_fence_slab = kmem_cache_create("amdgpu_userq_fence",
>>> -						    sizeof(struct amdgpu_userq_fence),
>>> -						    0,
>>> -						    SLAB_HWCACHE_ALIGN,
>>> -						    NULL);
>> Are we not having benefit enough to continue create a cache here ? If that is fine that LGTM,
> Using all those kmem_cache instances was a bad idea to begin with.
>
> See the idea of a kmem_cache is to reduce the number of CPU cache lines and memory you need for certain number of objects when the object size is not a power of two.
>
> So for exampe two objects with 96 bytes only take 3 cache lines and 192 bytes instead of 256 bytes and 4 cache lines.
>
> But that difference is so marginally for most use cases that you absolutely don't need it.

Thanks for the explanation. Also if i am not wrong in cases where last 
no of such objects are often created and deleted kmem_cache helps in 
reuse and helps with internal fragmentation too.

Regards

Sunil Khatri

>
> Regards,
> Christian.
>
>> Acked-by: Sunil Khatri <sunil.khatri@amd.com>
>>
>> Regards
>> Sunil
>>
>>
>>
>>> -	if (!amdgpu_userq_fence_slab)
>>> -		return -ENOMEM;
>>> -
>>> -	return 0;
>>> -}
>>> -
>>> -void amdgpu_userq_fence_slab_fini(void)
>>> -{
>>> -	rcu_barrier();
>>> -	kmem_cache_destroy(amdgpu_userq_fence_slab);
>>> -}
>>> +static const struct dma_fence_ops amdgpu_userq_fence_ops;
>>>   
>>>   static inline struct amdgpu_userq_fence *to_amdgpu_userq_fence(struct dma_fence *f)
>>>   {
>>> @@ -146,12 +126,18 @@ amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
>>>   }
>>>   
>>>   static void
>>> -amdgpu_userq_fence_put_fence_drv_array(struct amdgpu_userq_fence *userq_fence)
>>> +amdgpu_userq_fence_put_fence_drv_refs(struct amdgpu_userq_fence *userq_fence)
>>>   {
>>>   	unsigned long i;
>>> +
>>>   	for (i = 0; i < userq_fence->fence_drv_array_count; i++)
>>>   		amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
>>>   	userq_fence->fence_drv_array_count = 0;
>>> +	kfree(userq_fence->fence_drv_array);
>>> +	userq_fence->fence_drv_array = NULL;
>>> +
>>> +	amdgpu_userq_fence_driver_put(userq_fence->fence_drv);
>>> +	userq_fence->fence_drv = NULL;
>>>   }
>>>   
>>>   void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
>>> @@ -181,10 +167,11 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
>>>   		fence = &userq_fence->base;
>>>   		list_del_init(&userq_fence->link);
>>>   		dma_fence_signal(fence);
>>> -		/* Drop fence_drv_array outside fence_list_lock
>>> +		/*
>>> +		 * Drop fence_drv_array outside fence_list_lock
>>>   		 * to avoid the recursion lock.
>>>   		 */
>>> -		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
>>> +		amdgpu_userq_fence_put_fence_drv_refs(userq_fence);
>>>   		dma_fence_put(fence);
>>>   	}
>>>   
>>> @@ -231,7 +218,7 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
>>>   
>>>   static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)
>>>   {
>>> -	*userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab, GFP_ATOMIC);
>>> +	*userq_fence = kmalloc(sizeof(**userq_fence), GFP_ATOMIC);
>>>   	return *userq_fence ? 0 : -ENOMEM;
>>>   }
>>>   
>>> @@ -299,7 +286,7 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>>>   	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>>>   
>>>   	if (signaled)
>>> -		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
>>> +		amdgpu_userq_fence_put_fence_drv_refs(userq_fence);
>>>   
>>>   	*f = fence;
>>>   
>>> @@ -333,29 +320,10 @@ static bool amdgpu_userq_fence_signaled(struct dma_fence *f)
>>>   	return false;
>>>   }
>>>   
>>> -static void amdgpu_userq_fence_free(struct rcu_head *rcu)
>>> -{
>>> -	struct dma_fence *fence = container_of(rcu, struct dma_fence, rcu);
>>> -	struct amdgpu_userq_fence *userq_fence = to_amdgpu_userq_fence(fence);
>>> -	struct amdgpu_userq_fence_driver *fence_drv = userq_fence->fence_drv;
>>> -
>>> -	/* Release the fence driver reference */
>>> -	amdgpu_userq_fence_driver_put(fence_drv);
>>> -
>>> -	kvfree(userq_fence->fence_drv_array);
>>> -	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
>>> -}
>>> -
>>> -static void amdgpu_userq_fence_release(struct dma_fence *f)
>>> -{
>>> -	call_rcu(&f->rcu, amdgpu_userq_fence_free);
>>> -}
>>> -
>>>   static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>>>   	.get_driver_name = amdgpu_userq_fence_get_driver_name,
>>>   	.get_timeline_name = amdgpu_userq_fence_get_timeline_name,
>>>   	.signaled = amdgpu_userq_fence_signaled,
>>> -	.release = amdgpu_userq_fence_release,
>>>   };
>>>   
>>>   /**
>>> @@ -546,7 +514,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>   	r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence);
>>>   	if (r) {
>>>   		mutex_unlock(&userq_mgr->userq_mutex);
>>> -		kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
>>> +		kfree(userq_fence);
>>>   		goto put_gobj_write;
>>>   	}
>>>   
>>> @@ -871,6 +839,7 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>   	for (i = 0, cnt = 0; i < num_fences; i++) {
>>>   		struct amdgpu_userq_fence_driver *fence_drv;
>>>   		struct amdgpu_userq_fence *userq_fence;
>>> +		unsigned long flags;
>>>   		u32 index;
>>>   
>>>   		userq_fence = to_amdgpu_userq_fence(fences[i]);
>>> @@ -886,7 +855,19 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>   			continue;
>>>   		}
>>>   
>>> +		spin_lock_irqsave(userq_fence->base.lock, flags);
>>> +		if (dma_fence_is_signaled_locked(&userq_fence->base)) {
>>> +			/*
>>> +			 * It is possible that fence is already signaled and the
>>> +			 * fence_drv now NULL, just skip over such fences.
>>> +			*/
>>> +			spin_unlock_irqrestore(userq_fence->base.lock, flags);
>>> +			continue;
>>> +		}
>>>   		fence_drv = userq_fence->fence_drv;
>>> +		amdgpu_userq_fence_driver_get(fence_drv);
>>> +		spin_unlock_irqrestore(userq_fence->base.lock, flags);
>>> +
>>>   		/*
>>>   		 * We need to make sure the user queue release their reference
>>>   		 * to the fence drivers at some point before queue destruction.
>>> @@ -895,10 +876,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>   		 */
>>>   		r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
>>>   			     xa_limit_32b, GFP_KERNEL);
>>> -		if (r)
>>> +		if (r) {
>>> +			amdgpu_userq_fence_driver_put(fence_drv);
>>>   			goto put_waitq;
>>> -
>>> -		amdgpu_userq_fence_driver_get(fence_drv);
>>> +		}
>>>   
>>>   		/* Store drm syncobj's gpu va address and value */
>>>   		fence_info[cnt].va = fence_drv->va;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>> index d56246ad8c26..d355a0eecc07 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>> @@ -58,9 +58,6 @@ struct amdgpu_userq_fence_driver {
>>>   	char timeline_name[TASK_COMM_LEN];
>>>   };
>>>   
>>> -int amdgpu_userq_fence_slab_init(void);
>>> -void amdgpu_userq_fence_slab_fini(void);
>>> -
>>>   void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv);
>>>   void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
>>>   int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
