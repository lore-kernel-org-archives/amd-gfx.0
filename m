Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6EBEDB7D0
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2026 22:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9728310E4DD;
	Tue,  7 Apr 2026 22:25:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RkFrFMd+";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EDB910E4D9
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2026 22:25:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izMfoRcR2Pk4wF98iF43DPGqg8Q4XhR53mU87OLTNxtsqcr3vKKXOAnmO8ATe60ZF8JHU+PI7FveMnyFzDE+fmtYMYal/xN67Eej3d0yi1hZyhh35KmTzfP/KIEsOyG8L09TnjR+qKQ5ru3Sb1Nwe/6Bk84fzmxDEDAiSco5lKv7fHv6eX1fLPxkHuvdikNSvJ1Nu0VK9Hn3S6enMqqza32xoSJwwMw4ZIkWrFWY6s/myTTFpXIIMOGWF84xRYkj/nxfQjLMadkHNz6QRgp/LcAeipkx5/p6oxCbQgRWmURzah3Ro5naq7TaMNTdWdDRrFh4KtL53ewQVSA8pfV18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/xe70MatPyjaAY7ifVqyQcVuSdG1qh7cIxgIMHCRik=;
 b=rUSDGz90MoIEe1Zi2g1fBTYY+Az2uqPa0MR+YJj+X9uOpHeyiFnqjAYjIBRlAf2yYaL1c6oZSsCmulu6HNk0yoLuvIxc5qX+WrNIRL4RTlcYEI4/BAb1LmRHisZYjSnS7g2UCrusPnLFgSIsi/A4pK9Ox7mmwREDk2Vb10MKQT73qaTD8F4uYu8wFKade/9sOsK56gIufVCCgJJPJQBb60Q8K7PWju9DhCMQS87W9Mydy7HGQr6qB9Kp92bBLBGJo+jiL+GEn4XSx5CWVM0Vmnzy8Qd1Gc9O1hOrXJUXK3w3AVgScvzjdaAdyapLWsioAmvuety6BvBIsYqlsE2Sxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/xe70MatPyjaAY7ifVqyQcVuSdG1qh7cIxgIMHCRik=;
 b=RkFrFMd+nwhVPU9UXETj89aMoOIFrqugzDhsiPUrpmnqbfn8iUWq8G0FY5kU/T9AXzBzChaLVN8vfJNQlLk1ueFz1YujBFP8NK7h9U8FskefWAhifvYJTKgET79qO/2tlKJFMTPgV8kHxzNaN3EWH9/oyXiCpCXgViFosTn3quA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by IA1PR12MB6531.namprd12.prod.outlook.com (2603:10b6:208:3a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 22:25:01 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.20.9769.020; Tue, 7 Apr 2026
 22:25:01 +0000
Content-Type: multipart/alternative;
 boundary="------------Pe1vBchxcNyRWdfRVPZWTipW"
Message-ID: <9a12966c-3a5e-4872-aa83-f7a6c2f47c80@amd.com>
Date: Tue, 7 Apr 2026 18:24:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: extend mtype override to non-contiguous pages
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com, Kent.Russell@amd.com,
 Andrew.Martin@amd.com
References: <20260407133833.463741-1-Philip.Yang@amd.com>
 <55d2743f-9585-4e79-a153-b403a9781aa4@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <55d2743f-9585-4e79-a153-b403a9781aa4@amd.com>
X-ClientProxiedBy: YQZPR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::9) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|IA1PR12MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 196ce170-8964-4d46-6a32-08de94f4823b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WZ+83voPLAoFLgLM4ik0m+z979GW6jGk8n0/HfD6o6MnDsork71CH+wDpGRL43wL6O7spBqdNV2XfCu9B9KkjIEv9Oo+KQPUeimXqHHsnIT6VR4S4cLgqH/CRaKXT4uR+PwyeocZFHFXQhW/zIMicOc2k6nJhtO2Pla+wyd21/42YKQnPTBriIJYw+Q0EzTR6UBj0fPf1QIsNODFw+WOKEP6Dca1LPXtHmXoPIJ/CjrWXLo3wrTvynX/5S+ub5tCXFHxfPfa4zLdQFqPtsAiDVH5VzkpyxRCSq60Ya519xL2uCNGHyx5JQXZXjHrEGaddGzmgpONL3da6fP0BO0z8f65923etL1x3pNX4zYTB5WLM4KsP4DElDth52h1C9wEwg6seazOLI6aXqW4lkT0ljHa+h6rtsvVa/duDvcNGpaXW9TPYKJdESvNtyZe9ptcFGKXn6L/iR/gb7OzAaqSRRZRYACrKj4mQW6A9HkP8qE2S2NZTsvOg+bSjojfXEZIanTA57247SRhATiQ2JGEduAe0biscQI8Hgov+nAf9V8i54VRvr5SMVvdUvgHs2f/uCr2yDxFQv1JJrqzDU1Iymahalcvp1sxUUnUKgAXoR/zeKH7WBgsptDh7i1pSnSxX+Nd90s38/DMR7y4W8bMi0D/pLMx0Du4hGWBzO7tqTSfbiWONDZ/+WmZPvgNjdqmjblKVeGcbCSVauBljzropJf79tAvj6lXvhxQgpA/C8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzBycWhxQzdYSENoRExXT2VjMUZGN2NhbWZxRzllYlRFM3kzL0FGMzJ3R1BN?=
 =?utf-8?B?T3BXT250TCtqU2F2Q05UWVI0cDVJNU84aDVPOEhZYzNpdmxzU3hKeWFLQTFt?=
 =?utf-8?B?bmpWS1l2MDMrVjFaZEVRLytZZm5RdDdzODFCUGVFQlVNMXdtMWRLUFRJWk5n?=
 =?utf-8?B?ek9QbS9pMW50VThucVF4eUdqNnQrNkV5OHc5SURNaUpKaUduRm04TjlSMTh3?=
 =?utf-8?B?ZEk2K2ZRMTc4b1drT3ViSUFYSHZyNjRZMm5sZ3h6VUFjNGZBZkttNDR0RTF4?=
 =?utf-8?B?R2pSTWVTZHVtNHVwZUFNRVNOeit4SFppeUpCSGVZRm1QOGNWNFlmRnJPc3RD?=
 =?utf-8?B?VDh5MWNRazFvYnozOElHWEFzWXF5RjRkRXRENmZkejh5U0VBVGlvaCtySTNq?=
 =?utf-8?B?c1VBVkdsbjl5SUhpekVlM0k2eStvOHdSWGNCSDVheU8vN3FUVktVRjBpT0RG?=
 =?utf-8?B?MnF5SjdpSlhnNEVjQmduVE0vbUU1YUNPcFl0eFVvR2Z4TDlFNVMrOVpQWHJk?=
 =?utf-8?B?cW1DMm1uaEV3ZDRQOWJ5WmJWeE5YQ2Y2TThyNDVWZTVVVGxoL0tWUDJlYXVK?=
 =?utf-8?B?UE1yZHJsbTRzZXlFYWpRTGk4UDIwUzZua2FtdjVVVXFGM2Z6czFzcUVuZXJl?=
 =?utf-8?B?ckVCaVgxV0Q1b0R4QVV0NkZEa1FVM1VaOVMxRWgvdFpZa2c1dXByVkQzM3BO?=
 =?utf-8?B?M0pWdDVwM0cxOTlKZE15SjRKR1dsTGk3VzdxRlUraGVwSHlpc1dadFNZdmp0?=
 =?utf-8?B?VzFhbW0yRnk5dVhXWTN6ZmsvV0dEdHV6ZEdMc1oreUdFTHpGUWJsd0VPVlFa?=
 =?utf-8?B?dk41QXZTWldNSUx0QUFaSHM4WXQ5eGZDdnR4ckNUUnc1aUFUaXprby9nbjBW?=
 =?utf-8?B?UTliQldRakNrdW0zNEZmTWQ0b0hQNWpJNzl6MWR3dkZ3UzF2QjNhZ0NRWlAv?=
 =?utf-8?B?ZmNQbUY2SVV3Ykk5UmJBN1B2MjB1TXBxMTNnb2EwK3VFdWcxcTZEUWF5UDR2?=
 =?utf-8?B?Zk9OYzdNSnJqMW5vSGpGamdWazgvNjhZZ0UveVFrTWUxQjNFcmx6T25EaGlE?=
 =?utf-8?B?NENwVzFzVE9sV2dXOUFYbEM1ZmtLd05WRHBqaHowSzUvRUhXdEZVSkNaLzRx?=
 =?utf-8?B?MTUvbmNYbkZHOW9BeTBOSkZDaHJ1SFRtNDRCODhPeHo2eWJWMURMWXpJOStP?=
 =?utf-8?B?RG9BWnQxY0ZaVXlXeVlMSzJJY21IVlhsdHZzRDJuL1o4TkpTMVdZOWVhR0U5?=
 =?utf-8?B?N2VxeFZmQjVSM1NQZE1LbGlMUEdVSFJ6d0tuM2swS0huVHBwR1J1STY0K3Y2?=
 =?utf-8?B?ZlRXTzZrbEJwN0dTYTdmcC8zK0dPemR4SlpKWlhML1RTSURFZlJiS3ZERmFx?=
 =?utf-8?B?cW1TWnRtdGp4UVJQUFpzM2VGdUJKYXRFbmdmVDRQSTdOTUhUS1llWUl5dlo2?=
 =?utf-8?B?NWpBNDMrU1RXaW1xeVNjdW1aQWlDZzB3UmtESUlsbGMyV25XdHU4RnJJaWV0?=
 =?utf-8?B?ejlJSC9LNld5ZDZLTnlPOGYzNUV2S3lZd1haSXQyQzRwMlAzNjZYRFYzZzFU?=
 =?utf-8?B?azRycjdDUSs4d2wrZXFCbmhHQVhPNEJpNDJNVXVaK0dkYUVCMkliMkRqWlQz?=
 =?utf-8?B?VlVPMXNtQWtTOFlSNVRZdllPenNwdHMxVmNGeHV1TGNGOTJnYTcwVEE5dld6?=
 =?utf-8?B?cFBGcWN0SzRSYkIxdWVFR0VhSnp3SmRkaSs3UTJoNzhKNjFJYUJRYTBUeUs1?=
 =?utf-8?B?K2ZCTVRpNWFSRURyZm16ak5Ca2ovZGdZZDBQNjZya0lLSmVKOXZId0FQdG1O?=
 =?utf-8?B?aW5JTkphOGxUODdTQlRUTGY3T3JHTGpoaTJCdVRweThYYUJSTU5USlRtOE9j?=
 =?utf-8?B?KzlNeXFMV3Fib3FGOExuQkkzb21sK0xhSm5VK0o0YzRON2tVRk5YaUhXNmp0?=
 =?utf-8?B?Q2grVEc2YkM0U0tlNkdpdXpZUGlHTExLZERBblB3aDVOaWU5Nk9aWEpMaWZ6?=
 =?utf-8?B?ZnlWb0YzcVNTQzlRbHNSMXBBWk95dklaMWNzaDZCNUtXVWhZWEJZRmJnbjZS?=
 =?utf-8?B?WnFDTmQxNi9nQm5hd1dGczgxVU9rZ1IxZ2NqY3RaUnczUFNNMWpLZENINXhs?=
 =?utf-8?B?eFdJeUVMSkpCWFh5QU5md0RKOThsMmQyZVI4TDY2c0x1cDdHSG55VGZpYTE5?=
 =?utf-8?B?UCtJMUZDRDAreVI0UmMrN3B0RXpNNS80RGcyMWFaWnZNUlVlNzg4WDc1OEx2?=
 =?utf-8?B?M2tHcG5RRVUzeXJvanlmK243eDJMVEM3RU9wbUx1Vjg0WDk0R24xS0N3S3h3?=
 =?utf-8?Q?zZ6OIXAOQW3vOwcXV2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196ce170-8964-4d46-6a32-08de94f4823b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 22:25:01.3803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nL17S7ebyySiaI2zKAseMXTmngk9piqtytM1u286zInHCHSMmVfrkCZA/AKVf/Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6531
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

--------------Pe1vBchxcNyRWdfRVPZWTipW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-04-07 15:40, Chen, Xiaogang wrote:
>
>
> On 4/7/2026 8:38 AM, Philip Yang wrote:
>> On multi-socket MI300A APU systems, system memory pages mapped to the
>> closest GPU must use MTYPE_RW instead of MTYPE_NC to maintain correct
>> cache coherence. The existing mtype override in amdgpu_vm_pte_update_flags()
>> excluded non-contiguous page mappings from the override. This caused
>> incorrect MTYPE_NC for scattered local pages, leading to cache coherence
>> issues.
>>
>> The override applies to both contiguous and non-contiguous mappings.
>> When pages_addr is set, resolve the physical address via
>> pages_addr[addr >> PAGE_SHIFT] before passing it to the override
>> callback for NUMA node lookup.
>>
>> Introduce amdgpu_vm_addr_contiguous() helper that, on MI300A, treats
>> pages on different NUMA nodes as non-contiguous even if their DMA
>> addresses are adjacent. This ensures amdgpu_vm_update_range() splits
>> page table updates at NUMA node boundaries so each batch gets the
>> correct mtype override.
>>
>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 48 +++++++++++++++++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 14 +++++--
>>   2 files changed, 50 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 63156289ae7f..f8fcbf079bf4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1099,6 +1099,34 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>>   	}
>>   }
>>   
>> +/**
>> + * amdgpu_vm_addr_contiguous - check if two DMA addresses are contiguous
>> + *
>> + * @adev: amdgpu_device pointer
>> + * @addr: current DMA address
>> + * @addr_next: next DMA address to check against
>> + * @contiguous: current contiguity state of the range being built
>> + *
>> + * Check whether @addr and @addr_next are physically contiguous. On APU
>> + * platforms with multiple NUMA nodes (e.g. MI300A), a NUMA node boundary
>> + * also breaks contiguity so that each contiguous batch stays within a
>> + * single NUMA node for correct MTYPE override selection.
>> + *
>> + * Returns:
>> + * true if @addr_next continues the current contiguous range, false otherwise.
>> + */
>
> We can use pfn_to_nid or page_to_nid to get which noma(id) the backing 
> memory is at. pfn_to_nid uses pfn from physical address. You use 
> dma_addr_t that is device dependent. It is not always same as physical 
> address of RAM.
>
> ttm_tt also has
>
> /** @pages: Array of pages backing the data. */ struct page **pages;
>
> I think using the pages to get numa id by page_to_nid is more appropriate.
>
For MI300A APU, iommu is not enabled, dma_address (dma_map_page) is same 
as pfn (page_to_pfn), otherwise the current override path will not work 
correctly with pfn_to_nid.

Regards,
Philip
>
> Regards
>
> Xiaogang
>
>> +static inline bool amdgpu_vm_addr_contiguous(struct amdgpu_device *adev, dma_addr_t addr,
>> +					     dma_addr_t addr_next, bool contiguous)
>> +{
>> +	if (!adev->gmc.is_app_apu || !page_is_ram(addr >> PAGE_SHIFT))
>> +		return (addr + PAGE_SIZE) == addr_next;
>> +
>> +	if (pfn_to_nid(addr >> PAGE_SHIFT) != pfn_to_nid(addr_next >> PAGE_SHIFT))
>> +		return !contiguous;
>> +
>> +	return (addr + PAGE_SIZE) == addr_next;
>> +}
>> +
>>   /**
>>    * amdgpu_vm_update_range - update a range in the vm page table
>>    *
>> @@ -1198,22 +1226,26 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   				uint64_t pfn = cursor.start >> PAGE_SHIFT;
>>   				uint64_t count;
>>   
>> -				contiguous = pages_addr[pfn + 1] ==
>> -					pages_addr[pfn] + PAGE_SIZE;
>> +				contiguous = amdgpu_vm_addr_contiguous(adev,
>> +								       pages_addr[pfn],
>> +								       pages_addr[pfn + 1],
>> +								       contiguous);
>>   
>> -				tmp = num_entries /
>> -					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>> +				tmp = num_entries / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>>   				for (count = 2; count < tmp; ++count) {
>>   					uint64_t idx = pfn + count;
>>   
>> -					if (contiguous != (pages_addr[idx] ==
>> -					    pages_addr[idx - 1] + PAGE_SIZE))
>> +					if (contiguous != amdgpu_vm_addr_contiguous(adev,
>> +									pages_addr[idx - 1],
>> +									pages_addr[idx],
>> +									contiguous))
>>   						break;
>>   				}
>> +
>>   				if (!contiguous)
>>   					count--;
>> -				num_entries = count *
>> -					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>> +
>> +				num_entries = count * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>>   			}
>>   
>>   			if (!contiguous) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 31a437ce9570..9e1607fb3b2e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -708,13 +708,19 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>>   		amdgpu_vm_pte_update_noretry_flags(adev, &flags);
>>   
>>   	/* APUs mapping system memory may need different MTYPEs on different
>> -	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
>> -	 * to be on the same NUMA node.
>> +	 * NUMA nodes. Both contiguous and non-contiguous ranges are handled
>> +	 * since amdgpu_vm_update_range ensures updates don't span NUMA
>> +	 * node boundaries.
>>   	 */
>>   	if ((flags & AMDGPU_PTE_SYSTEM) && (adev->flags & AMD_IS_APU) &&
>>   	    adev->gmc.gmc_funcs->override_vm_pte_flags &&
>> -	    num_possible_nodes() > 1 && !params->pages_addr && params->allow_override)
>> -		amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
>> +	    num_possible_nodes() > 1 && params->allow_override) {
>> +		if (params->pages_addr)
>> +			amdgpu_gmc_override_vm_pte_flags(adev, params->vm,
>> +					params->pages_addr[addr >> PAGE_SHIFT], &flags);
>> +		else
>> +			amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
>> +	}
>>   
>>   	params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
>>   					 flags);

--------------Pe1vBchxcNyRWdfRVPZWTipW
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-04-07 15:40, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:55d2743f-9585-4e79-a153-b403a9781aa4@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 4/7/2026 8:38 AM, Philip Yang
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:20260407133833.463741-1-Philip.Yang@amd.com">
        <pre wrap="" class="moz-quote-pre">On multi-socket MI300A APU systems, system memory pages mapped to the
closest GPU must use MTYPE_RW instead of MTYPE_NC to maintain correct
cache coherence. The existing mtype override in amdgpu_vm_pte_update_flags()
excluded non-contiguous page mappings from the override. This caused
incorrect MTYPE_NC for scattered local pages, leading to cache coherence
issues.

The override applies to both contiguous and non-contiguous mappings.
When pages_addr is set, resolve the physical address via
pages_addr[addr &gt;&gt; PAGE_SHIFT] before passing it to the override
callback for NUMA node lookup.

Introduce amdgpu_vm_addr_contiguous() helper that, on MI300A, treats
pages on different NUMA nodes as non-contiguous even if their DMA
addresses are adjacent. This ensures amdgpu_vm_update_range() splits
page table updates at NUMA node boundaries so each batch gets the
correct mtype override.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 48 +++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 14 +++++--
 2 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 63156289ae7f..f8fcbf079bf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1099,6 +1099,34 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 	}
 }
 
+/**
+ * amdgpu_vm_addr_contiguous - check if two DMA addresses are contiguous
+ *
+ * @adev: amdgpu_device pointer
+ * @addr: current DMA address
+ * @addr_next: next DMA address to check against
+ * @contiguous: current contiguity state of the range being built
+ *
+ * Check whether @addr and @addr_next are physically contiguous. On APU
+ * platforms with multiple NUMA nodes (e.g. MI300A), a NUMA node boundary
+ * also breaks contiguity so that each contiguous batch stays within a
+ * single NUMA node for correct MTYPE override selection.
+ *
+ * Returns:
+ * true if @addr_next continues the current contiguous range, false otherwise.
+ */</pre>
      </blockquote>
      <p>We can use <span style="white-space: pre-wrap">pfn_to_nid </span>or
        page_to_nid to get which noma(id) the backing memory is at.&nbsp;<span style="white-space: pre-wrap">pfn_to_nid uses pfn from physical address. You use dma_addr_t that is device dependent. It is not always same as physical address of RAM.</span></p>
      <p><span style="white-space: pre-wrap">ttm_tt also has </span></p>
      <p><span style="white-space: pre-wrap">	/** @pages: Array of pages backing the data. */
	struct page **pages; </span></p>
      <p><span style="white-space: pre-wrap">I think using the pages to get numa id by </span>page_to_nid&nbsp;<span style="white-space: pre-wrap">is more appropriate.</span></p>
    </blockquote>
    For MI300A APU, iommu is not enabled, dma_address (dma_map_page) is
    same as pfn (page_to_pfn), otherwise the current override path will
    not work correctly with pfn_to_nid.<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:55d2743f-9585-4e79-a153-b403a9781aa4@amd.com">
      <p><span style="white-space: pre-wrap">Regards</span></p>
      <p><span style="white-space: pre-wrap">Xiaogang</span></p>
      <blockquote type="cite" cite="mid:20260407133833.463741-1-Philip.Yang@amd.com">
        <pre wrap="" class="moz-quote-pre">+static inline bool amdgpu_vm_addr_contiguous(struct amdgpu_device *adev, dma_addr_t addr,
+					     dma_addr_t addr_next, bool contiguous)
+{
+	if (!adev-&gt;gmc.is_app_apu || !page_is_ram(addr &gt;&gt; PAGE_SHIFT))
+		return (addr + PAGE_SIZE) == addr_next;
+
+	if (pfn_to_nid(addr &gt;&gt; PAGE_SHIFT) != pfn_to_nid(addr_next &gt;&gt; PAGE_SHIFT))
+		return !contiguous;
+
+	return (addr + PAGE_SIZE) == addr_next;
+}
+
 /**
  * amdgpu_vm_update_range - update a range in the vm page table
  *
@@ -1198,22 +1226,26 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 				uint64_t pfn = cursor.start &gt;&gt; PAGE_SHIFT;
 				uint64_t count;
 
-				contiguous = pages_addr[pfn + 1] ==
-					pages_addr[pfn] + PAGE_SIZE;
+				contiguous = amdgpu_vm_addr_contiguous(adev,
+								       pages_addr[pfn],
+								       pages_addr[pfn + 1],
+								       contiguous);
 
-				tmp = num_entries /
-					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
+				tmp = num_entries / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 				for (count = 2; count &lt; tmp; ++count) {
 					uint64_t idx = pfn + count;
 
-					if (contiguous != (pages_addr[idx] ==
-					    pages_addr[idx - 1] + PAGE_SIZE))
+					if (contiguous != amdgpu_vm_addr_contiguous(adev,
+									pages_addr[idx - 1],
+									pages_addr[idx],
+									contiguous))
 						break;
 				}
+
 				if (!contiguous)
 					count--;
-				num_entries = count *
-					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
+
+				num_entries = count * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 			}
 
 			if (!contiguous) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 31a437ce9570..9e1607fb3b2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -708,13 +708,19 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
 		amdgpu_vm_pte_update_noretry_flags(adev, &amp;flags);
 
 	/* APUs mapping system memory may need different MTYPEs on different
-	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
-	 * to be on the same NUMA node.
+	 * NUMA nodes. Both contiguous and non-contiguous ranges are handled
+	 * since amdgpu_vm_update_range ensures updates don't span NUMA
+	 * node boundaries.
 	 */
 	if ((flags &amp; AMDGPU_PTE_SYSTEM) &amp;&amp; (adev-&gt;flags &amp; AMD_IS_APU) &amp;&amp;
 	    adev-&gt;gmc.gmc_funcs-&gt;override_vm_pte_flags &amp;&amp;
-	    num_possible_nodes() &gt; 1 &amp;&amp; !params-&gt;pages_addr &amp;&amp; params-&gt;allow_override)
-		amdgpu_gmc_override_vm_pte_flags(adev, params-&gt;vm, addr, &amp;flags);
+	    num_possible_nodes() &gt; 1 &amp;&amp; params-&gt;allow_override) {
+		if (params-&gt;pages_addr)
+			amdgpu_gmc_override_vm_pte_flags(adev, params-&gt;vm,
+					params-&gt;pages_addr[addr &gt;&gt; PAGE_SHIFT], &amp;flags);
+		else
+			amdgpu_gmc_override_vm_pte_flags(adev, params-&gt;vm, addr, &amp;flags);
+	}
 
 	params-&gt;vm-&gt;update_funcs-&gt;update(params, pt, pe, addr, count, incr,
 					 flags);
</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------Pe1vBchxcNyRWdfRVPZWTipW--
