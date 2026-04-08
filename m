Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22E4FD5F94
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 08:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7695C10E553;
	Wed,  8 Apr 2026 08:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D00XMEA1";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81AF910E553
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 08:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyeV7uemG2mi1ZBSwPI0/J4E0LcZQ39Bk6PImbJ0fwl6MI3n9A6LdbCbV19yRk88GIs7Tzkns2YCMtoy9S6RxRAV1qFnpizo/TLvt46V+386Om46zCu13BOLtUoIbJrWG/KAww2h3aOMbcxBRKHSJ8hIZMOraeWdWcddMc89Fzn2LGy7Lq6kDF38qvRwlC6R000yodGbZrjL7pnJuBGcxl3SGxgd5nFSOqcez0Wc4BGBz5NRje6W01tttA2xubcw4Woh7zHhMrYCP4WLVSaenlPGer7KVe1cEOcfo5P5Gc/V8xc51Luq4vwAXnBPKz9mZNUkzZZLT5inkW7sj6g4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YroEyHpDlhID9x3hxTeH8BHVJXZVncnrHNBk2eg0RUA=;
 b=X4V677oHJ8zJOoyyJpupjYR2xbRNu90kMKfdQSDJ57g5O+ZFFy1XMQ/cHdpBQX5igRc29nttNnptPivZ3LYCfRj91A5bPGhqJCThVhlELvfu3cdqkvccxpuL4kYn64ZcEOoJikq4ULFT58gufVGFR5ZMRLuJ2ocAi2CRQoWkYnptTQM3geeqRm1LITAuBdzBdJyhTvbhDwaTX5gIKOfcHJHjgHxh+FqkF5N1rIpgpB/sGmRXirHmCG5U+t5EzfuNpmh/ypFuoAHKguWVhNiL0wFYvBnCfYNxG68ezLvT/uwYEqbty3RppZkOtIQ7FiUdx7FxrGI7wHm/YEVk562OgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YroEyHpDlhID9x3hxTeH8BHVJXZVncnrHNBk2eg0RUA=;
 b=D00XMEA1JWy0zp0NGRXvFymF3pczvvNSFwEJ95sOEhRHsBOPOt/d3D+P2d1ugO/bvhPWxhD1SRJULrDVEAoa/N2vhU78LzJ/aR0adKQ1pgxk6+qHaxok4QncW0tc4IFUxK1wMxgaiTTUtZO8AJWms5QVT5ZQSmro6yaxTTkxSdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.14; Wed, 8 Apr
 2026 08:04:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 08:04:55 +0000
Message-ID: <4966b8f2-4d51-405c-beae-889771c298b5@amd.com>
Date: Wed, 8 Apr 2026 10:04:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: extend mtype override to non-contiguous pages
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Kent.Russell@amd.com, Andrew.Martin@amd.com
References: <20260407133833.463741-1-Philip.Yang@amd.com>
 <55d2743f-9585-4e79-a153-b403a9781aa4@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <55d2743f-9585-4e79-a153-b403a9781aa4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR19CA0021.namprd19.prod.outlook.com
 (2603:10b6:208:178::34) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 426186f2-c496-45d8-20a8-08de95458561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: WZVDaGthM5s8WlGmmm3MVLVPytMvJIhVZleAIpiym/nxhcP41mon3navCaTH8GY1omsIYIEx3y1cPmcJyWCrrAtQlD3AuuzTjVwt/qfO75q94Sh4XMbhnIjIrdnpG8/nWzrwdop0wH5X+O7q/Q8ebAUvhgZIdijAK9j728r1lXcUwE5DC20fsIQKMjcvxFjIFVcX/h1Z5nhb33qq/SaESrliKFH2rt6egkfH9/D0FyiMQyJ3MBWDt6pZjBojPWXfUJsSvEq4tIzaKTzss+ntW0GKHjD+N+igDuoXibl5ekBHLGNT/pzH47jZLHv+hM3KWnmsWgl+CyRW5IFCiPMyBOsFQw89FSDWn05N1oSEAWzmSCG0lSov5VIKxZ0alYSl/LKpfW3u/Eey5n5zQLydMZ85odQKQT1FuPccZItdjdGqrc1zZZrT3zmObyNyHH14fnV5aDhv67oVF7sT53sFHcHy2bbwgtXsrCnr39aNiWJ0HVNUpPlx4q8oePJYVSzxa+8g83CCm7qof7WnjV8xaP2mW9QQ41OwlQG4fXDocfo+jnsejH1rcx573xwmV7muMnDXPTbpfRLdLeUlLiHV8+HwrMSK6LF4Ea/7czYaKDY7YGz6wpwBw9k5CWK9J8HpkDQtYxS12gLhDT7Wb4Ztbn1n/8n2DJc0y7zM3ihb+v5vQKhLjIWXrBqF9yrlYjgU5u24NjliRHwqlw/e3u7p0SSeOzadxER/DT5jqMeu1sg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0tlQy9idG9OcGR1dXYwbHc4anhzZzI5T0I4ZGlBdzhpWGlMWmVteFgreG51?=
 =?utf-8?B?N2t1K2lCR0xYMXJETEMxZ3NNWkY1VmJvcEJWeGpJMUFRN24wbk9ha1NiSU5r?=
 =?utf-8?B?bG1mZnFpY3d3WE52Tms5RGVXRWovTHBCRWozSXVWV01pUDBOWHR2R3lRSWcr?=
 =?utf-8?B?b1BFQytLNmdVRU5DbzN2YXJBQm45RGJtcnhvbVBNYkFRcEVvdXpkV0JVcVA5?=
 =?utf-8?B?elNPaGRQbVY2cVNvYm10NTVOTFRtVmRvczE2TmUxRUs5MFBwVVdxY1VGeVM0?=
 =?utf-8?B?bVZBOGJPcTFLMjYxWENMODFFdkljejFURllrVFF2RUxMUVRwVkZ3NjBPTUJU?=
 =?utf-8?B?ZUFESUxXeHhTY1pMcWVRS2pMdXZQOGZxbVB0N2ZjR29hc1M0V203R2UrUjNv?=
 =?utf-8?B?LyswbUJTZS9jaXhjcWt5UDhMTGphZlhCQ215ZmFCaFlOcjJSbURYc1FZMllB?=
 =?utf-8?B?a2hNT21oRzA1N0hBYmVROXJYK3o3QmFJY0VVK2tCTFJvM0VNRDZCVERUUVY2?=
 =?utf-8?B?a0k3cWRrNHBoNExmYWhrU3ptY0VxWENra1ZTemJtZ3Z3QmNzcFZhcy9PZ0Q0?=
 =?utf-8?B?TUxNOVl1ZjlwVkdNLzh4QmdEZ1lNa2VMOTl0RVdCdlVLNU0rUTFvcDdPKzc2?=
 =?utf-8?B?SUIxbTZlTlZLZnBoZWptTGMvdFUzaUlCeXA2SXNOV0NBaDJrQUcwWFZqOHhU?=
 =?utf-8?B?WUIvejc2ek8vWUpjN2J5TGtJYUZ3d3VSaFNJMVBweUF0OHNKUXdTM2ZNaWpr?=
 =?utf-8?B?RW1aN29zL3JrR052TUFXMkN2UVl6MXV6QXgrWjZwZWVGOVhhUFRGd1Z4YmU5?=
 =?utf-8?B?NWMzODJQczlEN0dUTXEvZSs0YVZPNmY2MGVOUlI0cXJVRTVSWFFzZUlnK2x6?=
 =?utf-8?B?Ly9EbjM3dVlLQ3lNOGt0WXdjTDBFbk80azJuU3FWcSs1c0J4R1JJMU1kMkRM?=
 =?utf-8?B?Lzg3b1hvV2VnbS9lOTlIOGhuaE1HK00rZGdUQ3pnMnhQOXhidG5keUJCNUZ2?=
 =?utf-8?B?TGZhYW53QmMvOTdFSHhJNlh2ZG40blQxNFNkZlZ5eGZKME5hVUJpbkdxYlk5?=
 =?utf-8?B?SlNnRlRESGhNL2tYSWJEY0dvNkxLaVJVMzQyVytETHZ4amduOHdKMDhQUE5V?=
 =?utf-8?B?NFg3bGMzRWFYRVNrSUk0L2dmRW4rSjdRay9EV2lHZ1QvN3cwNnFnSWVDU05n?=
 =?utf-8?B?dVljdXFwQ1RUaXN6SWFnL1VhV3kweVpwRHdXOHcva1A4N2xqcGNFbEUvQVZH?=
 =?utf-8?B?SmdOWUwrSUdHK0NPTmwwRnYzVnZsak9oNEt3UkpqUGcxamRqT3l1cnMvYUJa?=
 =?utf-8?B?YlNMQks1UmswR0tncm1USm1SaG1TSHJWTitQZmt0LytJWXFJc1NraEV6bno2?=
 =?utf-8?B?QUM0c2dybklJc1JHemNGZDl0cWNVZnpIaW5LVmNuSnAvQVk1NXdmZEhSbE9P?=
 =?utf-8?B?aGJiS2xXNU1WbjZmY2YwM3BKeFdDVUREUTJBeXNwNCsySThPd0tMSnFYRE5h?=
 =?utf-8?B?OWNjcnJQcEQrZWt3OHpzU1ZyYW8ydEtpUUxkZXRQL2NRSWNCNjV6ZDZjZGFQ?=
 =?utf-8?B?UDU5cGZKbTUzSWNZeitCTTViMGxsSHVrSG9YR0tMUkxVbkJVRk5FMUpaa1J3?=
 =?utf-8?B?dklpR0lJbElRVnh4WFRhNlY5SDNSanNIcEZPcEdBYkZrcWt2cUVGRkhreDZJ?=
 =?utf-8?B?UFEzdW9zTDF4aGpLTkRXcGVTVFdDWU9mVlFrcGs5ZitpYU5jc0R3aHpHTDYz?=
 =?utf-8?B?b2F4cGdodGtaWC9MYkMwYm5ZZ0V1MmxjWkZ0T2JUbkxjSzBBUkJvUjBEb0lh?=
 =?utf-8?B?YzRVZFoydENCanhYS1dsRlROcVpQdVBsRFdQencrNDkvaTNTMk8wWE45R0NG?=
 =?utf-8?B?TmZrY2U5M2dsRjNCYndaYXNYTWs2WklLaFdKVGVKcmZzUmc1d2oxdmxISnRp?=
 =?utf-8?B?NEh0SWNjZkVCYjNpbkN4a2pUMGZZUm9JcWpLUGZ5cjBtZzVkLzNCRWxTYmdn?=
 =?utf-8?B?MlBxZUpUY2xSOGNmNkFvalRVNmlNV2FRcnlEdHg3YWlNRDNSOXR2T3d1VlBn?=
 =?utf-8?B?WFVseWVsNUNTd1RkdVJtbW9WRFU2R2VCOVU5OWtCOHBtMUNIZUZ3elVUL0or?=
 =?utf-8?B?b0szZmVQTmdEM3dwY09TckJpSkNJSGdmeVEzZE1raHVUS09SbUV5YUlValhh?=
 =?utf-8?B?WU05R0h2UzFrWXlTK3hsY0ZsaHBoSUtpbklFWDNiUXFld2lpWVJmNXlyVmF4?=
 =?utf-8?B?SlpUa2xTQW10YnBTYzZyQTR3cTRpeXFkdU9ncFc3OG9GbmxFR1ZvVXVLNlZO?=
 =?utf-8?Q?R3EpmkWWqyplfa1Qpb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426186f2-c496-45d8-20a8-08de95458561
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:04:55.7850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ev1apePr5h0i6SKqB2oPKONZEReSHWuXpdfTVPsakNxZk/5H4PfNFcJ5zZldqEiz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358
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

On 4/7/26 21:40, Chen, Xiaogang wrote:
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
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 48 +++++++++++++++++++----
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 14 +++++--
>>  2 files changed, 50 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 63156289ae7f..f8fcbf079bf4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1099,6 +1099,34 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>>  	}
>>  }
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
> We can use pfn_to_nid or page_to_nid to get which noma(id) the backing memory is at. pfn_to_nid uses pfn from physical address. You use dma_addr_t that is device dependent. It is not always same as physical address of RAM.

Yeah that here won't work at all.

> 
> ttm_tt also has
> 
> /** @pages: Array of pages backing the data. */ struct page **pages;
> 
> I think using the pages to get numa id by page_to_nid is more appropriate.

That array isn't filled in for imported pages.

As far as I can see the whole approach won't work reliable. For imports we only know the dma_addr and not the struct page nor the pfn.

I think we need to re-iterate the whole idea of MTYPE override.

Regards,
Christian.

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
>>  /**
>>   * amdgpu_vm_update_range - update a range in the vm page table
>>   *
>> @@ -1198,22 +1226,26 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>  				uint64_t pfn = cursor.start >> PAGE_SHIFT;
>>  				uint64_t count;
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
>>  				for (count = 2; count < tmp; ++count) {
>>  					uint64_t idx = pfn + count;
>>  
>> -					if (contiguous != (pages_addr[idx] ==
>> -					    pages_addr[idx - 1] + PAGE_SIZE))
>> +					if (contiguous != amdgpu_vm_addr_contiguous(adev,
>> +									pages_addr[idx - 1],
>> +									pages_addr[idx],
>> +									contiguous))
>>  						break;
>>  				}
>> +
>>  				if (!contiguous)
>>  					count--;
>> -				num_entries = count *
>> -					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>> +
>> +				num_entries = count * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>>  			}
>>  
>>  			if (!contiguous) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 31a437ce9570..9e1607fb3b2e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -708,13 +708,19 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>>  		amdgpu_vm_pte_update_noretry_flags(adev, &flags);
>>  
>>  	/* APUs mapping system memory may need different MTYPEs on different
>> -	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
>> -	 * to be on the same NUMA node.
>> +	 * NUMA nodes. Both contiguous and non-contiguous ranges are handled
>> +	 * since amdgpu_vm_update_range ensures updates don't span NUMA
>> +	 * node boundaries.
>>  	 */
>>  	if ((flags & AMDGPU_PTE_SYSTEM) && (adev->flags & AMD_IS_APU) &&
>>  	    adev->gmc.gmc_funcs->override_vm_pte_flags &&
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
>>  	params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
>>  					 flags);

