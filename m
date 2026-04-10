Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505E8F44844
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 12:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E561110E0C9;
	Fri, 10 Apr 2026 12:09:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q+aPDm6Z";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DA9910E0C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 12:09:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocdlFztwpKrmCLmidqVlLQi+fMFq5DHOlycM9EkxwAQ9iOLgauIo4MEc+DKW5eTVZ5YB8QXYPUy9aGgii8zWxXH7Rj3DgP6ZHsnu+Ftp4WKjRWxRhGSdYq/50U/Szc84d4EeP+M/jBdUrrpYCtdkUqCFxX9uMTe/mhlnmH3v+ovYGKXuN9ObM6rO7ukVaG2igUKIzR8hN/h+ELKkLgfFm+JtsHtf/maZASqoBZd1Kx4g4FLUuMah9n2fgFr+Ql6hRqwFj+jFCVPGB6MU7+WNaZJCzMm1nG4FY1INYtH45cGMsDspUpNgz5YGxua5czAncxhrXqOsqXpJbgpMSBmQcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GataM3dy8UxJ9vSG+VfPhATJ0d04dv1TQHdBkcPjihI=;
 b=Ca20NvYBElFqBaFRZ15sp45BWNMR7M4jqJ8YVALunUj9p7PIak/bNMAeYC1V9GNSYHWh1urzIO4KmTinXnG1IIJqxfaMSGDtK293UURH+ZMCJodIh63V3IdYeqlE+CmWBygTR09vMTvQcr4+HCN+SILlqAfveMHhEgRwDzOZib+vpGXiw3hrd1c/3KlBLY6xLHILF4vhX7IHx7faQOql7aScsJeAuAWwAhkXh/CNatDwTXk7AqcH2PoouRmDaaZtLz0xbuKubZP60jtQ8S8mwmEApkAfgT0ArenZXISFVQw3QV18Hgc6q4MsFfBgR4SQLsG8ew99Kuq3jLsfgwvkyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GataM3dy8UxJ9vSG+VfPhATJ0d04dv1TQHdBkcPjihI=;
 b=Q+aPDm6ZhB1XFrn5pDbSWp9/zqfYst6PEjV3hHljEpCcTUlb0brYjJJWnmS/3vgMV1TnuEPy78wv2W9V0TGlTtaiqO/pP2I3Sxft9IvL/Yacm2kjq8MCpvAMOJ4c/PfJ4ksnsgK51NeQumXKz1PnYnRmrD9VtGT/o5U8b2pQm4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8959.namprd12.prod.outlook.com (2603:10b6:303:23c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Fri, 10 Apr
 2026 12:09:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 12:09:45 +0000
Message-ID: <822bdce2-5edc-4ede-9f55-79acf2512e2a@amd.com>
Date: Fri, 10 Apr 2026 14:09:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: extend mtype override to non-contiguous
 pages
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Kent.Russell@amd.com, Andrew.Martin@amd.com
References: <20260409224554.2813645-1-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260409224554.2813645-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0305.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: fd1828cd-d0b5-4f3b-6815-08de96fa0e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: cHWnBp1vkQScWeSG79IFHy4RJsNEU3NpUxVB/ZzQOOpXsOqiZ4O2KWVTRDZXLL1tZISG9BukxG5Miq8zoy6++koDYKO9VCPrRNCuqcLxFV5ZpR8qo/42xIYPhbT2OVDiE1BOjeUV/Hj+xEK0/vyGANocEwv4ft9SXtmhxzJ5KvLguiZr80HP66+n9kDh6cCc1vkcvfUZsPLnrLQPIyk5xREgYiXOH6MpXc0zNA7l5WAbSLhg0vIW7XsKQzldxjX/0bjzkebDek+tJz8hbt/VlO25hkHXAsTUt5bKIUyiIvhr4SsDQfM0DSlhxxx6GAvtbIJ51H69mHd9RJdDbX84KQFE/3n2ZkI2jNmwCGFtn/HPYXhkBqWrDUvBxncGcaaU2juFf4WtsvA8X0L8UvMFbRHsbx64tXcW5tlpg/Qo9rTVhTdtqIoGzBaNP1y8SDG7YsG+QmVcKt3ny/Cr8Kc3u/IhqxA8VGhHHq2WCSeEL1rCLOfFXmjPtYIfEe0dQinqefcZVLYMm7NhvoRl5+RczCzkh6p699MgZNzp0S9QbLWZtapj8wMEFXQMoAMjTP8OGSlMgEtHtNnUZ5dqSYh/DoPH2vevRtjJp8kAOR/prdFEYn0mR0g0PXhMvl4jLu2cmLB/cuYzVCJkQF8DBYQ6H4SaoNc8GSMX9wSbmAr/30knuJUGa0rtgjP7WN7OrhPF+L+fJ1+Zgy/1sgtkrBtGmDaImh6etCx52aTYooGQptw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDRLRFIydGNlNnl5R2Y1YlpRVWt4cTBTMXFhZkxRRFl5L05UOGpvNXRzVHRr?=
 =?utf-8?B?WVNqV3JkNjFDR3RRamQ0NmsvU0p4SEtxUVBKK0JJaGxXTVU2aEs2a1QyeEZw?=
 =?utf-8?B?M1IwUTRteVdUNUUwbGc2b01yMm5OalUzRTg2dER5eldWS3NEVWRxaVN3cnJZ?=
 =?utf-8?B?NDdPV2lYQ2daRzEyNkRzaFluTGtqY2FQUVEvbjRuMHlqTkx0YUFKb3hJMjdJ?=
 =?utf-8?B?OWtJVjR6aDdUclZ6R1VURDh0Y3RJakJCcG5MdjJEam9UOWlzYzIxNzNCdTNO?=
 =?utf-8?B?czRSeFdMMnFHQUdDS3J2UStPYyswRkxma0pKQmdIK0RZNkV0MXAybXMwU2dN?=
 =?utf-8?B?dkRMdzM4STVib2dsbnBZRHdJT2l6T01pZXozSFNXRUJkNnJUSW1DblFuUlpv?=
 =?utf-8?B?Zk9kanZ5SGRiQ1RMU2Z6TVNlU3Z6bzJpRnRNVnlpaDgyYnUvYmFycVBCNnlv?=
 =?utf-8?B?SmZJUzlxM00zNEFJQWxvMTUzWFZvYlB4eXptR2dESFBZdXFRZWxDYVdCRkha?=
 =?utf-8?B?UWsyMGk5cWhUYW5TSjU0bUtKZFJuNGhISkYrK3RqZGlMQVZnaWxxcjdKVVND?=
 =?utf-8?B?TGczQnpaak5wdm1pN29KS2dFMHZOcWZ5YmkyczFKblRNcFRLUlZiQXlkcWE2?=
 =?utf-8?B?d21vZ0N5cnV1Zk5rcUY3Q29VYVJtRkRzR3ZBSlhiNGFLcDUyWGNuSEVGVUR4?=
 =?utf-8?B?S2dsZlAyOGVvRkxzT09TMlhNeUVMTVNERzB1bkd1TGxNc0hENE5DelpabTNz?=
 =?utf-8?B?U0VGSVFnZTdrNFRrZmo1UVMwYVk2aTNhcXdqZGEyaDlHSC9oTkpKQ1V1SW44?=
 =?utf-8?B?SktsTFN1YVlOODkrcktuWGJpNHZRbm5vUEs0bmcwSFVmZzYyNDRCMERCcEpv?=
 =?utf-8?B?emdHT0p4RXRVemJ1ZTdMWld1ZFExS1pFUFY0Y1p4NU1HaDZ0eVVvSjJ4dzFF?=
 =?utf-8?B?UnkxM29Ca1kvZm9mTWxySDJFWkMrS05RdFIydEl3TzJCek5uNTdjc0tmWjM5?=
 =?utf-8?B?TTUwc1lFNFFLQUxhU0wrWTE0N0Zralk0d3kxWk9IODBIL0l4S0VtQTgxRGFS?=
 =?utf-8?B?d1cwMWRaY04zb2kwck4zY1BlVUpQMGI1ZFEycHZkV1Q3SExya1F4SFZmRkJx?=
 =?utf-8?B?OEtjMU13cUVadlJyTEpuUWtiUWlJU0hiOGR3Uk5uanhQbWJ4dSs1WVBFREFa?=
 =?utf-8?B?WmI3UXNnT2xVc3VrSWcrdkl5blY4T3IzVWQzMGhMMFliL2FYdmhaWnBaclhl?=
 =?utf-8?B?ZjdNVHo4ejllYk52VlduOStXclBMTWEvZ0Zpbk93dmpDb1oxOG9GajJ5dmUv?=
 =?utf-8?B?ZDN6WEVIK1VBMjYrOFAweGExUkpycUhXY25YWHhYMEFmVkh0M1BOSzVTNDdD?=
 =?utf-8?B?ejBwSG9MT3ZaSURCcFRRV3BhQXVadzUyVnVVYlFLaTg5THlmbGVTY2U2SCtq?=
 =?utf-8?B?anY3QlZEY3FCQ1hCR2kwWkJmaHU3Mnp3cGdjOUVVN20xYXZVZDJmQTI1QmNp?=
 =?utf-8?B?bUw5bjBaZFU0RWtVTzRBdy9IazFJYVVlazkvUmZCTStFWVhYZW5qZ0VydWho?=
 =?utf-8?B?d0drTXl1cXlsSTQ4VERDdUdCSG9UdUlGWUtpSUowNW5TeWlMMDh6TUV3eXNa?=
 =?utf-8?B?am9VSkVBMHdnRmV5d0tIbzNsZkxJaWx2bzJSWXV3UDR4cWlEVjJzczd5cWRW?=
 =?utf-8?B?Q3VmTWtOZExRdlhDVkNGY2JKU3BOb0NJUkNMTjN3ZmdsWDZ0WmovWmRvWkVK?=
 =?utf-8?B?Z2JLMUhRZUpoYlFua2RwNGVYSXJ5dG1mRHVweDNqS1VMSVYrS3JUbXFWQ0t3?=
 =?utf-8?B?a2NiZU1XcnpqN1NvdHZsb25CL1IvRXlLbmZkZSt0cm9NZ2xoR0w0aVE3N1Zj?=
 =?utf-8?B?Ui9nYkc3QUhxUndGclVBbmVKdHdZa1NqU0ZWS2NuVVBxbVowSWFwS1VRYXhu?=
 =?utf-8?B?ZVBZNTlMQUJnVFpSVTVJSDZOdHdYcEpla2U3RFlPSmlQNTdPclFzR2dqelQ0?=
 =?utf-8?B?aWpnWmlwSDd4bTEzZ2lZUXcwQkNGaVpaUGN0bDZoWFBzMmJMMDY1Z0FKV3F3?=
 =?utf-8?B?amp1MzBPWmpXRDE1aG5BMW1nUjhMeHcvZisrSDhuVkhrSWdySEF2N2JvLzBC?=
 =?utf-8?B?c2UzckYzd3dveUs1RFhLakg4RXQzSGxKMSt5azVkeTJicGNBbUhveTU1czlL?=
 =?utf-8?B?Y1IwbVdFM0E2QVhyM0FETm5STEpiR1lJMCtBa1pHWkwrSnhpbC92WnpWRkUx?=
 =?utf-8?B?WFgvYUoyS1lCalBBcnN1Qk9jdXhkY0sycnAveGQ1c1N4K1RycDVISXprQ2Ez?=
 =?utf-8?Q?WTAHetkUa7IO6NjM1M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1828cd-d0b5-4f3b-6815-08de96fa0e2f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 12:09:45.9173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQj+ET3jEvuNxF/j7WlIFQdh8lL2TbFLC30vpNCgBoBg4jZtBymsCW3xGshp4rIN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8959
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

On 4/10/26 00:45, Philip Yang wrote:
> On multi-socket MI300A APU systems, system memory pages mapped to the
> closest GPU must use MTYPE_RW instead of MTYPE_NC to maintain correct
> cache coherence. The existing mtype override in amdgpu_vm_pte_update_flags()
> excluded non-contiguous page mappings from the override. This caused
> incorrect MTYPE_NC for scattered local pages, leading to cache coherence
> issues.
> 
> The override applies to both contiguous and non-contiguous mappings.
> When pages_addr is set, resolve the physical address via
> pages_addr[addr >> PAGE_SHIFT] before passing it to the override
> callback for NUMA node lookup.
> 
> Introduce amdgpu_vm_addr_contiguous() helper that, on MI300A, treats
> pages on different NUMA nodes as non-contiguous even if their DMA
> addresses are adjacent. This ensures amdgpu_vm_update_range() splits
> page table updates at NUMA node boundaries so each batch gets the
> correct mtype override.
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 51 +++++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 14 +++++--
>  2 files changed, 53 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 63156289ae7f..7b7cbe054d73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1099,6 +1099,32 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>  	}
>  }
>  
> +/**
> + * amdgpu_vm_addr_same_group - check if two DMA addresses are same contiguity state
> + *
> + * @same_nid: true to check if two address on same NUMA node
> + * @addr: current DMA address
> + * @addr_next: next DMA address to check against
> + * @contiguous: current contiguity state of the range being built
> + *
> + * Check whether @addr and @addr_next are physically contiguous. On APU
> + * platforms with multiple NUMA nodes (e.g. MI300A), a NUMA node boundary
> + * also breaks contiguity so that each contiguous batch stays within a
> + * single NUMA node for correct MTYPE override selection.
> + *
> + * Returns:
> + * true if @addr_next continues the current contiguous range, false otherwise.
> + */
> +static inline bool amdgpu_vm_addr_same_group(bool same_nid, dma_addr_t addr,
> +					     dma_addr_t addr_next, bool contiguous)
> +{
> +	if (same_nid && page_is_ram(addr >> PAGE_SHIFT) &&
> +	    pfn_to_nid(addr >> PAGE_SHIFT) != pfn_to_nid(addr_next >> PAGE_SHIFT))
> +		return !contiguous;


This relys on that the dma_addr is equal to the PFN and is a clear NO-GO from my side to that approach.

Question is why exactly would we need that in the first place?

Regards,
Christian.

> +
> +	return (addr + PAGE_SIZE) == addr_next;
> +}
> +
>  /**
>   * amdgpu_vm_update_range - update a range in the vm page table
>   *
> @@ -1134,6 +1160,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>  	struct amdgpu_vm_update_params params;
>  	struct amdgpu_res_cursor cursor;
> +	bool same_nid;
>  	int r, idx;
>  
>  	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> @@ -1166,6 +1193,10 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	params.allow_override = allow_override;
>  	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
>  
> +	same_nid = adev->gmc.is_app_apu && adev->ram_is_direct_mapped &&
> +		   adev->gmc.gmc_funcs->override_vm_pte_flags &&
> +		   num_possible_nodes() > 1 && params.allow_override;
> +
>  	amdgpu_vm_eviction_lock(vm);
>  	if (vm->evicting) {
>  		r = -EBUSY;
> @@ -1198,22 +1229,26 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  				uint64_t pfn = cursor.start >> PAGE_SHIFT;
>  				uint64_t count;
>  
> -				contiguous = pages_addr[pfn + 1] ==
> -					pages_addr[pfn] + PAGE_SIZE;
> +				contiguous = amdgpu_vm_addr_same_group(same_nid,
> +								       pages_addr[pfn],
> +								       pages_addr[pfn + 1],
> +								       contiguous);
>  
> -				tmp = num_entries /
> -					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
> +				tmp = num_entries / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>  				for (count = 2; count < tmp; ++count) {
>  					uint64_t idx = pfn + count;
>  
> -					if (contiguous != (pages_addr[idx] ==
> -					    pages_addr[idx - 1] + PAGE_SIZE))
> +					if (contiguous != amdgpu_vm_addr_same_group(same_nid,
> +									pages_addr[idx - 1],
> +									pages_addr[idx],
> +									contiguous))
>  						break;
>  				}
> +
>  				if (!contiguous)
>  					count--;
> -				num_entries = count *
> -					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
> +
> +				num_entries = count * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>  			}
>  
>  			if (!contiguous) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 31a437ce9570..9e1607fb3b2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -708,13 +708,19 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>  		amdgpu_vm_pte_update_noretry_flags(adev, &flags);
>  
>  	/* APUs mapping system memory may need different MTYPEs on different
> -	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
> -	 * to be on the same NUMA node.
> +	 * NUMA nodes. Both contiguous and non-contiguous ranges are handled
> +	 * since amdgpu_vm_update_range ensures updates don't span NUMA
> +	 * node boundaries.
>  	 */
>  	if ((flags & AMDGPU_PTE_SYSTEM) && (adev->flags & AMD_IS_APU) &&
>  	    adev->gmc.gmc_funcs->override_vm_pte_flags &&
> -	    num_possible_nodes() > 1 && !params->pages_addr && params->allow_override)
> -		amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
> +	    num_possible_nodes() > 1 && params->allow_override) {
> +		if (params->pages_addr)
> +			amdgpu_gmc_override_vm_pte_flags(adev, params->vm,
> +					params->pages_addr[addr >> PAGE_SHIFT], &flags);
> +		else
> +			amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
> +	}
>  
>  	params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
>  					 flags);

