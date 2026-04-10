Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B2DF44842
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 11:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F170210E93A;
	Fri, 10 Apr 2026 11:26:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oucDh/ut";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51EA110E93A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 11:26:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1QWcQmzzwohoNyraYCnwQ+ZTKMz7eZ90by7xb7gBkr4H2MPHUnSXUjOyiNPIg10XWjIg/JqAfDqRm9XrLZ+ikI+YRG0OdiUUYLlu/03lArgt0IwmYqoz1m+YIpQijwakBhB53pN4qOMuSVzivuaoSefWKGYGj86os4nDS33wysadGxp/vqgIAnF+3RQ9SD+c9V5b51jovmLBx+7UmM+Rml+4vSZvNwbHmGc1EOCZlr7pQHk8McPncLfBkPEpuLERSJi2wj4m/rwx0sz3xGS7lbsWj/Ih64daEf9HG3QeucgmEQtyAc0i0FSAbEYpIwK3JmacTzPpfgcKsyzFjj2yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOoBFpBH7iCPRBb3wpqHBabJYcbZ/ZIKFJZNq1GGwL0=;
 b=ctTLk7rU5pNLH0YGlSMKuPM9fp2m1rErELsm/aYzWmS7LxJqDnjgcyP0+vvLs10keIYlk2DO+GOR1AXViWYfQithfCvj8Os+QBgfxKjc2vc6wX9OUPKdMY2/e8NmEgUM4ttfBH81O9R/CMakIYVHfxcflHUlXbUWkp+oaDGot9vDnnTcwVuUXLhAI5ocy7DgwPSFKSCs31ft9JzuGdgjxMZQrMsNTbQtD9p11uz8j3PHVA3PZdJXEPYDsaMd9W9L2M+PVJAt2oKgDy6hfYEWRaWchvcP9EdXwFwbk9RSMo6KcUh4Wypq9GHT+gbUo7eyTX8M3Zx2eUQnmCi+ibdeHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOoBFpBH7iCPRBb3wpqHBabJYcbZ/ZIKFJZNq1GGwL0=;
 b=oucDh/utD/zEUXSWW/4ooLXJxh4heFiOXlL7F+/OI5Wmt5m7VtJIKgyX4lwYE5LIt3RNseEEyW0Xe3T0HpPpVmf+kkPX+n2Xet1wmmw7z+D0TQbExBYc9w3PFQwi4i4b7P1KrFXj6kD4NLd8P4Yah5aItFEwg7gtlu79bFeGF8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PHXPR12MB999232.namprd12.prod.outlook.com (2603:10b6:510:3cd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 10 Apr
 2026 11:26:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 11:26:16 +0000
Message-ID: <92c191d7-cdca-403f-a622-ddbf0b90ed11@amd.com>
Date: Fri, 10 Apr 2026 13:26:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: extend mtype override to non-contiguous pages
To: Philip Yang <yangp@amd.com>, "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Kent.Russell@amd.com, Andrew.Martin@amd.com
References: <20260407133833.463741-1-Philip.Yang@amd.com>
 <55d2743f-9585-4e79-a153-b403a9781aa4@amd.com>
 <4966b8f2-4d51-405c-beae-889771c298b5@amd.com>
 <8ab95e17-11bf-4ea1-b408-c740c6cefc88@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <8ab95e17-11bf-4ea1-b408-c740c6cefc88@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:208:32a::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PHXPR12MB999232:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7c0cdb-7d4f-4d94-7b0f-08de96f3fa90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: dMOI/1A0GI7JsmQX3VxNk4EeeJejOIJVrh//1OOGyLRBGYzlQS7bpv32Co338b4Xa0hvAxbETI13B0ym45PtmZU54MRoGosLFtHzMo1B+lyu9BoeU2Yfv10SRI53L5T5XhFL1Zo8EEVZGvCKapOyHESoSBAt+WVD85F9yna5vxysy5kOPoQl2bmf7nxw4ie3BXSUNN2rCbuB/TrTP2yPuNbZ4i6QKaLMPXnPWw/bwTwgi46BzC7v7nc/08YSSl/bT/wz5664ZNhQPM16QG5TMyeSdF9E7MFuujW8QRtHRFT1ZFEBnDYnBm7ZCSLlJxH/G0NxGT5TEgryrWx1OgZe8fRf/nL6vc9qL36hUAXqiRA7GbsEi4XxHYAFtCgQYuOTlvu8IZwZEWwUK6GY7+ZNCQz78tXDIYHty7ZSrDZ60TcJVA9Sv41Fk/oFRIE7EhpYAu3ybRNs5vbMLYN9gOW9/ivBpW7d2uYH3BzQE0mdBZIGWFot/jI8MZz82k+6ZOYrixex0chmWRfOmi5UZe2T4xs5n69XvpBaT7Dc7XcPlrjnxwqYllYHtELe93vBdiz2jZOxaZF2zONwF8oyB+zEjPHnTk4NZreK+t2LdtyUn/1nAiWy8Rgw6pjNgVe1ARiVU/2NywNgDAylIPmXpqSR6iogl95NTo1R88NDhhwaiz7xtHzzpcLW7o1NO4V7FNK82mAZor36FImos2RZWPE6IXNX+7s56apOpJ8Yk77t3gI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djR2OWQwK2NCRit5a2F0TnorbXI3NEExUm5tTGswTDFXNnN5MndvZXdyZlZU?=
 =?utf-8?B?L2JVNkVhSXZiQVNYdHRhaVo4eFJmeXc4a0ViUmhuWUpURnQ5c2l3ZSt6ODdw?=
 =?utf-8?B?c0tRK3JhMEhWY05GckNveG5ORFloTmdhb2Zka0pINFpkRFJsK1NYYmpEQk1I?=
 =?utf-8?B?YnlZTDBaOHdQR2pTeFJhc0JiMklHaXE1UXpjY056a1FQOGU4dkRRUjhMUUxj?=
 =?utf-8?B?T0g1Wm1KNm9aS2k2SDc2ZHl1SW15aVlQVEdHWGQ0NlJoR1JzMmpLMjFBa3M4?=
 =?utf-8?B?cmRzbzhsa1RhdTl5a0V1UGg3V0swZ0psRHFqY0cwVHFIVUxTWmY3a3l3MzJ0?=
 =?utf-8?B?eFQ0Z1lGUFhWd2ZSYlRiVjM5TlV6Q2hwMU42bDdMWFBpcEtaRmsyVEhFTnpw?=
 =?utf-8?B?bGJMeUY4L3FZNVJobitlNEVqUTZXNWZnYUFiWFA0TG1LeGpvb1lVU3k4MCsv?=
 =?utf-8?B?NG5uY2xtaWZsaXVlaEdmM2FxUGszVXZkVGZZci8vekFCUXMrbFlockZGemZJ?=
 =?utf-8?B?OEQ1MnpWTXhQcnRIaHJsbEtKQ3VCaFlKMk5hWkxHTnQvWGtCUUNwZ2VwVnZW?=
 =?utf-8?B?RVg2ZGdISnUvSW85cVAydWlTWC9vbmxtUEdqMkdqQ1BvbytiZHc1WHlTVU93?=
 =?utf-8?B?SFNLN0YzblJJK1E2Z1dNTTQ5R3NQMFJHZWxQL3VmZFd3TFI4clFSdWZmeWV3?=
 =?utf-8?B?dGZvdytvVjlBVWdGOXZBb1JOb0tFYkM3aEVaMmp6RjZ6K1dxRDV0cFZOdFJ3?=
 =?utf-8?B?L3pGNDBWWWhwZlBRM0dITUNUK011R0Y0Tkt0Si9VQkFzaTZQY0lwTTRNL3JS?=
 =?utf-8?B?MHNPWCsrd3QzS2V5ZTFNTlF3dHllTkNWTmFuOW5COTU4bjhScVlwOHVLQ3I3?=
 =?utf-8?B?bjA5WHVqNGtvdE9XR1NUWXBhampHTWxXcWFSL1ZkN2VMMEZjdjU5K0kwL0xt?=
 =?utf-8?B?Nml5allCQURQc3A2czQrWnZobENKMEtNRGVEYm1nM2dmSW9TZEFWejVNWWZB?=
 =?utf-8?B?TzJtcGhPOEZMZWxQdU9FMVNJakEwejRNaklGU3lsTEFBZmRMYzlEa004dVFQ?=
 =?utf-8?B?V3JNSm9ZZHZuTkxHZjFXRzVITzJRNDgxME1uRnNQMGdvVzZCdWE5bmZSTkc4?=
 =?utf-8?B?S3FtQytTaW5rWm5KbXpuaWljT1I3SStkWVdVVXlaTHk3K0RWRzc1RzJ6Vkd3?=
 =?utf-8?B?enA2cDFuU1hFRFNla0JDZzRISGdzNkNadTJBNHJEa2F2dzgzWEUrVHkxZVkr?=
 =?utf-8?B?djVCanBnUVhsTHlmVDMrMHdnTHpXUkVuQ2NQQUtwUVJCU2c4UWhERSs1OHBO?=
 =?utf-8?B?b2JablhGWkI5ZHR1dVlZeVFXRHVTMnlueW5vdks0TXF5OUpnUTlycGRKaFJS?=
 =?utf-8?B?UTdBd3VsOWZkVDBsK1lrZEROSVNTZU82RjJiUGoyQThIYThEQkNFdWZFOUYw?=
 =?utf-8?B?RklSc2d1bVdwRVZUZWpvUzNyYStqaU1tV3hyZG5JSTVjS3pPaTk5Ri9EUksx?=
 =?utf-8?B?OU5JQTgxMi92TWgrbnlBSDZVeExqSmtsb1NrY29uSnZ0S1JVWFlXNkdzWTVP?=
 =?utf-8?B?S1Q4NmFEZzRWdy8zazI3OXVqVTJyU1lCbDhmRncyTCtUVjF0OFpVL1ZmbG84?=
 =?utf-8?B?VWoyQ1ZZSDVycXJnV2dJcVRYQUc1TUhiQkRUdFRYNk1nRjZ4elJiMCt6UjlT?=
 =?utf-8?B?SU9mWWhsMEZIL3JSa2N2dlF6S29remRWcGc5VU5oNWYwaU9EWXYvT2JjcGtK?=
 =?utf-8?B?aDZubW1GczE5WVFXb1NsVkpWK0NpZXk5ZUZvWkM4ZnU5ZEdiTDhVdWpGTWls?=
 =?utf-8?B?OHVlWVNldFZTeS9BbXNtNEM5ekMvbGpiSit0Sll0d2Y4bWhqZndqMTJ1WHZJ?=
 =?utf-8?B?TXA2S1hpUEJnR2dER1k1Y3NaT2pDTlF5bGh5S0cvZUprZWwyZE16eStXS3Bl?=
 =?utf-8?B?SkRVMTBvRkVySXZDL3hua3VkS2IvSFJaMVpDZklDZzQ4ZGRnVnlsQ0pjbUI1?=
 =?utf-8?B?cWJXcVh2aXdVZndOTFRVUWlIcHUwVnFsdG4vVXo1ZDM4TERYVXIzOGxldmxZ?=
 =?utf-8?B?MU5tWlpQSVJ5RnU1TkNVK2FJenFIK3FHT2x2Uy95RGoxZkpsUnNKMFhFZjBK?=
 =?utf-8?B?dWw3VG9rVGRteDVKMXBUL3RONW1yYmJTemFjUlpWQzJqaEFoUEVmUFlZRGli?=
 =?utf-8?B?TWNubGp2LzVPZG9yL0U4LzF1Mm5TVzhqbkQ0Zk02YUxIZ0dBcHJ2RVgyVWp2?=
 =?utf-8?B?V3NUUzhFVk56SDlrWWVESURidWpKdUw0dEJWWmFJL1U5dUZyVWwzUGN4VWpK?=
 =?utf-8?Q?rIx/rUHL7HFeYd7eK1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7c0cdb-7d4f-4d94-7b0f-08de96f3fa90
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 11:26:15.9650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/P6Xr+Xjt2jYP5/Pa4GVvtG/A2hFZwx9P4O8X+YSjavQOy0WjQhhsqMF6S1ri/P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR12MB999232
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

On 4/9/26 23:56, Philip Yang wrote:
> On 2026-04-08 04:04, Christian König wrote:
>> On 4/7/26 21:40, Chen, Xiaogang wrote:
>>> On 4/7/2026 8:38 AM, Philip Yang wrote:
>>>> On multi-socket MI300A APU systems, system memory pages mapped to the
>>>> closest GPU must use MTYPE_RW instead of MTYPE_NC to maintain correct
>>>> cache coherence. The existing mtype override in amdgpu_vm_pte_update_flags()
>>>> excluded non-contiguous page mappings from the override. This caused
>>>> incorrect MTYPE_NC for scattered local pages, leading to cache coherence
>>>> issues.
>>>>
>>>> The override applies to both contiguous and non-contiguous mappings.
>>>> When pages_addr is set, resolve the physical address via
>>>> pages_addr[addr >> PAGE_SHIFT] before passing it to the override
>>>> callback for NUMA node lookup.
>>>>
>>>> Introduce amdgpu_vm_addr_contiguous() helper that, on MI300A, treats
>>>> pages on different NUMA nodes as non-contiguous even if their DMA
>>>> addresses are adjacent. This ensures amdgpu_vm_update_range() splits
>>>> page table updates at NUMA node boundaries so each batch gets the
>>>> correct mtype override.
>>>>
>>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 48 +++++++++++++++++++----
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 14 +++++--
>>>>  2 files changed, 50 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index 63156289ae7f..f8fcbf079bf4 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -1099,6 +1099,34 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>>>>  	}
>>>>  }
>>>>  
>>>> +/**
>>>> + * amdgpu_vm_addr_contiguous - check if two DMA addresses are contiguous
>>>> + *
>>>> + * @adev: amdgpu_device pointer
>>>> + * @addr: current DMA address
>>>> + * @addr_next: next DMA address to check against
>>>> + * @contiguous: current contiguity state of the range being built
>>>> + *
>>>> + * Check whether @addr and @addr_next are physically contiguous. On APU
>>>> + * platforms with multiple NUMA nodes (e.g. MI300A), a NUMA node boundary
>>>> + * also breaks contiguity so that each contiguous batch stays within a
>>>> + * single NUMA node for correct MTYPE override selection.
>>>> + *
>>>> + * Returns:
>>>> + * true if @addr_next continues the current contiguous range, false otherwise.
>>>> + */
>>> We can use pfn_to_nid or page_to_nid to get which noma(id) the backing memory is at. pfn_to_nid uses pfn from physical address. You use dma_addr_t that is device dependent. It is not always same as physical address of RAM.
>> Yeah that here won't work at all.
>>
>>> ttm_tt also has
>>>
>>> /** @pages: Array of pages backing the data. */ struct page **pages;
>>>
>>> I think using the pages to get numa id by page_to_nid is more appropriate.
>> That array isn't filled in for imported pages.
>>
>> As far as I can see the whole approach won't work reliable. For imports we only know the dma_addr and not the struct page nor the pfn.
> if adev->ram_is_direct_mapped, then dma_addr equals to pfn, we can use dma_addr to call pfn_to_nid.
> I will add ram_is_direct_mapped condition, this is currently inside override function, and add fast path change suggested by Felix in next version.

That is seriously not something we can do. This relies an specific HW behavior in common code and is clearly a no-go from my side.

Regards,
Christian.

> 
> Regards,
> Philip  
>> I think we need to re-iterate the whole idea of MTYPE override.
>>
>> Regards,
>> Christian.
>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>> +static inline bool amdgpu_vm_addr_contiguous(struct amdgpu_device *adev, dma_addr_t addr,
>>>> +					     dma_addr_t addr_next, bool contiguous)
>>>> +{
>>>> +	if (!adev->gmc.is_app_apu || !page_is_ram(addr >> PAGE_SHIFT))
>>>> +		return (addr + PAGE_SIZE) == addr_next;
>>>> +
>>>> +	if (pfn_to_nid(addr >> PAGE_SHIFT) != pfn_to_nid(addr_next >> PAGE_SHIFT))
>>>> +		return !contiguous;
>>>> +
>>>> +	return (addr + PAGE_SIZE) == addr_next;
>>>> +}
>>>> +
>>>>  /**
>>>>   * amdgpu_vm_update_range - update a range in the vm page table
>>>>   *
>>>> @@ -1198,22 +1226,26 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>  				uint64_t pfn = cursor.start >> PAGE_SHIFT;
>>>>  				uint64_t count;
>>>>  
>>>> -				contiguous = pages_addr[pfn + 1] ==
>>>> -					pages_addr[pfn] + PAGE_SIZE;
>>>> +				contiguous = amdgpu_vm_addr_contiguous(adev,
>>>> +								       pages_addr[pfn],
>>>> +								       pages_addr[pfn + 1],
>>>> +								       contiguous);
>>>>  
>>>> -				tmp = num_entries /
>>>> -					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>>>> +				tmp = num_entries / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>>>>  				for (count = 2; count < tmp; ++count) {
>>>>  					uint64_t idx = pfn + count;
>>>>  
>>>> -					if (contiguous != (pages_addr[idx] ==
>>>> -					    pages_addr[idx - 1] + PAGE_SIZE))
>>>> +					if (contiguous != amdgpu_vm_addr_contiguous(adev,
>>>> +									pages_addr[idx - 1],
>>>> +									pages_addr[idx],
>>>> +									contiguous))
>>>>  						break;
>>>>  				}
>>>> +
>>>>  				if (!contiguous)
>>>>  					count--;
>>>> -				num_entries = count *
>>>> -					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>>>> +
>>>> +				num_entries = count * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>>>>  			}
>>>>  
>>>>  			if (!contiguous) {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>> index 31a437ce9570..9e1607fb3b2e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>> @@ -708,13 +708,19 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>>>>  		amdgpu_vm_pte_update_noretry_flags(adev, &flags);
>>>>  
>>>>  	/* APUs mapping system memory may need different MTYPEs on different
>>>> -	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
>>>> -	 * to be on the same NUMA node.
>>>> +	 * NUMA nodes. Both contiguous and non-contiguous ranges are handled
>>>> +	 * since amdgpu_vm_update_range ensures updates don't span NUMA
>>>> +	 * node boundaries.
>>>>  	 */
>>>>  	if ((flags & AMDGPU_PTE_SYSTEM) && (adev->flags & AMD_IS_APU) &&
>>>>  	    adev->gmc.gmc_funcs->override_vm_pte_flags &&
>>>> -	    num_possible_nodes() > 1 && !params->pages_addr && params->allow_override)
>>>> -		amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
>>>> +	    num_possible_nodes() > 1 && params->allow_override) {
>>>> +		if (params->pages_addr)
>>>> +			amdgpu_gmc_override_vm_pte_flags(adev, params->vm,
>>>> +					params->pages_addr[addr >> PAGE_SHIFT], &flags);
>>>> +		else
>>>> +			amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
>>>> +	}
>>>>  
>>>>  	params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
>>>>  					 flags);
> 

