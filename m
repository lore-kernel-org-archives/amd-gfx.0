Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50434105D98C
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2026 23:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5CCD10E4DC;
	Tue,  7 Apr 2026 23:06:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q7z57Hle";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010050.outbound.protection.outlook.com
 [40.93.198.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D21710E4DC
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2026 23:06:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBJczXRoemuj43ZGfhOEqm1k+P2dfF7Jw6mj126/w4lZUD0RK74EcXRrWOofjSBjQmFJFTQEjqnEiWppFcqkT8IcKPRkajiKxqo8/iO9fxIgF6XAN32x7WqX61v0XRX09QIoIRkyEmjFpa03Sfawgd7Pk+64/mMsazVoFxsLp9nu17TKqDaIOIM9fgrbd/oQUW4sTm3M+jryjFzymnNUOKuC5rM5PbasmRr9OqdVamOmrnofOqv7MEpVnK5/ISqL8iI53Jc4nPpYmI9IzRB8nlzLvkmGmUHbMuQfq7/ggboKzjwiWHXeEZnHvSDfZLf1vis22s6sE5coVSl1trkrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeFNRtwCQaJ5kivY0npnLQUKBYTcZHZSIrIkpTfEVIo=;
 b=F00bYZhhR3sZkbd9s8wwnhnH8nB4ztTwwnjVa+H/zilE0EfkEXMoI4l0h60c541G2iH8y/18UBLW3SOfAE6WiLmfIXfuXur5SlqwP1Hgx1OoXXznztMFadssKMvjvTXYqrrn8uH8Ziv5W9kibdwzjsbbVS9ogIK1PP3nHrjj6t4vzENH8S6nALZbRI2Teklm1XWrgjnAyYxkGdhEbb/gCMnk3zqtgjugOXrbYank+3Gld8YyMAii6PcR5bjUDZfOga9Miyr5nVkiE5TpfzKJPCnbSacUZAtkqQuxoh9HCZxTi9Ft4v360DTBmJIwKcLijS+hAXrGQcr5Sli5TSmSdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeFNRtwCQaJ5kivY0npnLQUKBYTcZHZSIrIkpTfEVIo=;
 b=q7z57Hle04VHPboQR5FeyasqyreqvRBGT4PM895WERcLC+/Q4c4ijC3DLRX+Z2TjAnCa13KnIEBjsmBwwMSMuaIT47YPVnVA2Ezfa1/cFdhGtIq5TCNBiBZXZN9RKmH1kWtNcfKswEtjTkkGdvU1D0j4cFKpA6GU4s6aNqh7QFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Tue, 7 Apr
 2026 23:06:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 23:06:33 +0000
Content-Type: multipart/alternative;
 boundary="------------CR6aTxfIYFHfZgpn8HLfxnoD"
Message-ID: <85348d6d-b952-497b-a0ba-943158c34ac1@amd.com>
Date: Tue, 7 Apr 2026 19:06:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: extend mtype override to non-contiguous pages
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, Kent.Russell@amd.com, Andrew.Martin@amd.com
References: <20260407133833.463741-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260407133833.463741-1-Philip.Yang@amd.com>
X-ClientProxiedBy: YT4PR01CA0322.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW3PR12MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: b32b229a-98c0-4be2-30de-08de94fa4fb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|8096899003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: qnLFdtY+wsiq2s3hyokayuVh6QreUueDQ5RhHJl8hbYpQgGgDVZs3169bySP3iB4Z/FD2aTqxA8PTB7+7epVGczyUHso9uPV84Ighr60p7VrfBBmERGPvaj596sg54a37n67RJDLwKSHzM1CqKovVG25ynoZukyJDhpEB1GvjUUJaUDqorm7i+jxNrqOTR3lllGZPZumClLsyq1K4Qimj9MVayQeMpPb0As5yD65HVNMOgRlZ2QkdimNShCZN+dBYRwNmkRuT0eWgxS0snhASt7BTd1dWnXvmGIetRjcARjzN70natP4815fNUWLb9FE5vRS6lc/SlcULbEgRqf60mIcqFBdnjbTUaSxeGtnl+49RaQjsTGUm44/p29yTFwzK2ORokL7aeGMwkcY14/AMTfwGPgRWi0AGDCov1TobERTsoq92+tW8xYXvjKv36r2xz6seT8yPhk3425tmAs7UAgNalX1Sbt323WTs/WKLbSAXGB42AGkcCpPQT+FFRyO/uaU7vNqb0F5IlV+MBrk9R1cgfaoJ1cpphuFshLLTCECaz51ff6uhd21BXIsAfQW7vORI5IcfVsVf7wX2fayQgDoWf83MLi2rvpR89JW36Fswcy/e+BSEG63splo8rIvjIX6+AQldKap53Mj17YvYovnQDTnwZxB9+4o3iq+JqeGyPQ1r2b6B47GP9i+xpbkz3x96MsFDiL9Nteg2l4GNI7brunMJfLJv0eWQKPy2QU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(8096899003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDc5VjhWUG9acWxxem40OWtEa0JYdWRTUmlBQXcxdmdwOVNSYXJZRUhnYnVB?=
 =?utf-8?B?Q3A2MnBNUTJVNnpsMi82a1hIQlhRUTJwTnNkWnMyNEJyQlY5SVFISUNhMG1J?=
 =?utf-8?B?SzVlSktNanpabldYZ1VsYUs4NjFxWUkyR1VoeWJSUndLbHorYUNiVndQeXA4?=
 =?utf-8?B?dlpJMFMwWklCaDAvcUt6S0poWVRtTTZENVpDYkt4RkxhdGNFclh5VGRSc2dt?=
 =?utf-8?B?WjFyMTFONG5LVGx1aTJpUyttaXlXTldUOWdpMWQvZmVubC9oUUZORE1vWm9w?=
 =?utf-8?B?VnJHOWxHOTRNaGUvRTVtN3ZZM3Z6bzQxSTh1T3ZtYnpnbjV3U3hvTXNrRlBu?=
 =?utf-8?B?dm1NMEtERVlhajk0Y0F0WWYyRGlZN3p4K3pwWlhrQkF4VUt6WitBWFNhL0kz?=
 =?utf-8?B?ZTd4SzFJb0V1TjlJaGJBZXl0ZXdiTmF1K3VWNURCUEd2Nml3QnQvZS9iWU1B?=
 =?utf-8?B?czcyVzRKa2NIdE5tY1cwQ3BRdE93WmlOUDZqV2VBQTJub1ZjUnBuZVhIdW85?=
 =?utf-8?B?YTJ6UU0wZnpRem1hSGczTWxRcTRpL1ZnUitwdVU0cEYzZnFCNmVaNjVjUVcx?=
 =?utf-8?B?NFZmZ2M5QkhacmZzckNPaDNvdzRRQW5FUlQ4N1poY3JTQ1A3ZzJqMmtoWHFs?=
 =?utf-8?B?bjVZalZJU2hGaDEyKzc4ang1VVgvbVJXTzlTRnhJSENYWjNDMjFXTVVuaHB4?=
 =?utf-8?B?MEJxTUREWG1qZlVtVVA0UGt1K3lwUjdaWXMwbjllc2FDR1FFbHF1Q2NTOXhU?=
 =?utf-8?B?Z1BFYXNzWGRmN0gxWmlNLzlDbnRzLy9ia0Vac1ptMVI2QU1BTm1INHlVckpo?=
 =?utf-8?B?S25ZSldZQ1lqQUprUkhDRjYzMUc5UzliNjFqTkdCN1hnWGQyRURXVjIwejVI?=
 =?utf-8?B?cUxVSHJ4TTlSZ25xZXdtbFN0WnhMQllmOXhHbTJJOEZRSGlOSUZ0bkZHVVBv?=
 =?utf-8?B?OStpZ3pIMkczV3drVE1wSFprc0gyQmQva1h2V3p3STdrNEZvbnhwUzZndXNs?=
 =?utf-8?B?alI3SE9SSGxRSXJPdDExZzBBbTVqTWx6bXZFRCtuSXhkaFJqQ3Z1NTdNMU83?=
 =?utf-8?B?b0lHOFhSZUU1V1BpR1ZTc0k1aWZBYndEa3FWL01ITk5GRnVMVXpuWCtya2pZ?=
 =?utf-8?B?Z2doOW1ZNExhTXlwaytTTVJqMDEwR2JUc1VjU1VsMVdFdUdaUjQvbmU3WTZH?=
 =?utf-8?B?SDhLQWVMLy8zcXZoTjZIdTVWK002YTFGWE0xRitCMkpMQ0VBeDh6V1VQTXhz?=
 =?utf-8?B?ZjRyWm5IaUdhdXhtTTFSV3hCQTErSVVlLzFOdHJGYWJRUE9sdmwzbWNqejlN?=
 =?utf-8?B?bWFDSzE0M0FPaGNoR202NjFHSkhVTVUwdlhSakltTWR4aE1NSm1FWWVoc0I0?=
 =?utf-8?B?emc3WlVsNFQ0QjJQQU8vaXQ4cGNnNHBsZTdYVjlRc1JrUUJpbm1nbVhGM1JM?=
 =?utf-8?B?eTV1TG43SDg4ZGZYR0JUdWJHUUxoVVVvalREYWZQUkR0MzFnZmNMWTZOKzMx?=
 =?utf-8?B?NktlejFzQzRGcmFyTkEzS0J4N2U5Q2J0V2JRUkE0blVaUHJ1a3NJbEVQUkRB?=
 =?utf-8?B?TnRMWDZQeUcya2diY3hPTCtyVmF6cXYyVWFITFlobW9UaTQ3NEU3UmQ1Q0gx?=
 =?utf-8?B?eWQ4Z0VpZThrbS9uNlhuZm9VNCt2TjI3dlNUMXdFVkdTWGMvWmhKb0VIcUhn?=
 =?utf-8?B?Q1FSaXJzdUJLdVhKV0NCTnBWeUtmYUdrbmFuYWZCMDAyQ1BUSHJuRmxrWEk1?=
 =?utf-8?B?bjNWS1IyUXdUNHllMjc4N2ZNeElvUTdLZ3YxSFRHLzd1dlR1NnVlaUo4NmJm?=
 =?utf-8?B?STlEM3JwcVZqd29XS3NrbzJGTUEvcmRYT05Ra1BtRngxV3V6SWkxTTlJNTlv?=
 =?utf-8?B?QVFvbjh1b3MvT05BWmVENDFoREk1SDRvSnVhY1pQbEpDQVc3SHVSYUVPMXpq?=
 =?utf-8?B?bmk0ZGxHTENaWGZRL0J4WGxmaUxHMnRZZi9FaFB1UWdtTm8wSDl1K21KM1dG?=
 =?utf-8?B?UFZSaXB1K2pyME84Rm5waEV3eVJvQUJ6UThxcXNhQTNmbmVVZWZ1Y3ZvWURZ?=
 =?utf-8?B?TXREczdIRVpMKytYOUV5Y0xpTENRcFd3aXd3TVBIczJuWVBnVkwwdnp4R05F?=
 =?utf-8?B?eDBsQzFMMGxKemxDTkUvRlI2bDUvM1VWb3U3YjZ3SFByVG5RdmRqSFNnT2xm?=
 =?utf-8?B?T29CcVpDeUh2Q0RYMUJQRzF2SmlUcGxacVowUElQWHJmOFA0ZTJGZjVhZDFB?=
 =?utf-8?B?bmF3MFNhRzYyWGVGM0lxdkxMMzBYaUs5YWhaZzgrUEpyTlQwZFFnUi8zTzdo?=
 =?utf-8?B?dEh2SURLMU9pNkdGd0pHbnV3bGpkU3lsZk5ucW1nVUUzNTRJaFRTUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32b229a-98c0-4be2-30de-08de94fa4fb6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 23:06:33.5268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7cRK8LcOLXpLa9up40HFzeqsWxGDg1imyLBPY4tyYmPSpKh7VkF/QMI/CS5TnzxadtclqJphFSXk+Ft7cLsgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409
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

--------------CR6aTxfIYFHfZgpn8HLfxnoD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-04-07 09:38, Philip Yang wrote:
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
> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 48 +++++++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 14 +++++--
>   2 files changed, 50 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 63156289ae7f..f8fcbf079bf4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1099,6 +1099,34 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>   	}
>   }
>   
> +/**
> + * amdgpu_vm_addr_contiguous - check if two DMA addresses are contiguous

The function name is a bit misleading. It doesn't return whether the 
pages are contiguous, but whether they are in the same "group" (same 
amdgpu_vm_ptes_update call) by some pretty arbitrary criteria. Maybe 
call it amdgpu_vm_addr_same_group.


> + *
> + * @adev: amdgpu_device pointer
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
> +static inline bool amdgpu_vm_addr_contiguous(struct amdgpu_device *adev, dma_addr_t addr,
> +					     dma_addr_t addr_next, bool contiguous)
> +{
> +	if (!adev->gmc.is_app_apu || !page_is_ram(addr >> PAGE_SHIFT))

Isn't page_is_ram always true on APP APUs?

On the other hand, I think you need a check here that IOMMU device 
isolation is off (adev->ram_is_direct_mapped). Otherwise you cannot 
infer the NUMA node from the DMA address. I'd put the condition for that 
in the caller where you only need to check it once. Then replace the 
adev parameter with a bool same_nid. And while you're at it, you can add 
some more conditions to make the fast-path more likely:

	same_nid = adev->gmc.is_app_apu && adev->ram_is_direct_mapped &&
		   adev->gmc.gmc_funcs->override_vm_pte_flags &&
		   num_possible_nodes() > 1 && params->allow_override;

Regards,
   Felix


> +		return (addr + PAGE_SIZE) == addr_next;
> +
> +	if (pfn_to_nid(addr >> PAGE_SHIFT) != pfn_to_nid(addr_next >> PAGE_SHIFT))
> +		return !contiguous;
> +
> +	return (addr + PAGE_SIZE) == addr_next;
> +}
> +
>   /**
>    * amdgpu_vm_update_range - update a range in the vm page table
>    *
> @@ -1198,22 +1226,26 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   				uint64_t pfn = cursor.start >> PAGE_SHIFT;
>   				uint64_t count;
>   
> -				contiguous = pages_addr[pfn + 1] ==
> -					pages_addr[pfn] + PAGE_SIZE;
> +				contiguous = amdgpu_vm_addr_contiguous(adev,
> +								       pages_addr[pfn],
> +								       pages_addr[pfn + 1],
> +								       contiguous);
>   
> -				tmp = num_entries /
> -					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
> +				tmp = num_entries / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>   				for (count = 2; count < tmp; ++count) {
>   					uint64_t idx = pfn + count;
>   
> -					if (contiguous != (pages_addr[idx] ==
> -					    pages_addr[idx - 1] + PAGE_SIZE))
> +					if (contiguous != amdgpu_vm_addr_contiguous(adev,
> +									pages_addr[idx - 1],
> +									pages_addr[idx],
> +									contiguous))
>   						break;
>   				}
> +
>   				if (!contiguous)
>   					count--;
> -				num_entries = count *
> -					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
> +
> +				num_entries = count * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>   			}
>   
>   			if (!contiguous) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 31a437ce9570..9e1607fb3b2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -708,13 +708,19 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>   		amdgpu_vm_pte_update_noretry_flags(adev, &flags);
>   
>   	/* APUs mapping system memory may need different MTYPEs on different
> -	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
> -	 * to be on the same NUMA node.
> +	 * NUMA nodes. Both contiguous and non-contiguous ranges are handled
> +	 * since amdgpu_vm_update_range ensures updates don't span NUMA
> +	 * node boundaries.
>   	 */
>   	if ((flags & AMDGPU_PTE_SYSTEM) && (adev->flags & AMD_IS_APU) &&
>   	    adev->gmc.gmc_funcs->override_vm_pte_flags &&
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
>   	params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
>   					 flags);
>
--------------CR6aTxfIYFHfZgpn8HLfxnoD
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <head>

    
  </head>
  <body>
    <div class="moz-cite-prefix">On 2026-04-07 09:38, Philip Yang wrote:<br>
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

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
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
+ * amdgpu_vm_addr_contiguous - check if two DMA addresses are contiguous</pre>
    </blockquote>
    <p>The function name is a bit misleading. It doesn't return whether
      the pages are contiguous, but whether they are in the same &quot;group&quot;
      (same amdgpu_vm_ptes_update call) by some pretty arbitrary
      criteria. Maybe call it amdgpu_vm_addr_same_group.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260407133833.463741-1-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">
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
+ */
+static inline bool amdgpu_vm_addr_contiguous(struct amdgpu_device *adev, dma_addr_t addr,
+					     dma_addr_t addr_next, bool contiguous)
+{
+	if (!adev-&gt;gmc.is_app_apu || !page_is_ram(addr &gt;&gt; PAGE_SHIFT))</pre>
    </blockquote>
    <p>Isn't page_is_ram always true on APP APUs?</p>
    <p>On the other hand, I think you need a check here that IOMMU
      device isolation is off (adev-&gt;ram_is_direct_mapped). Otherwise
      you cannot infer the NUMA node from the DMA address. I'd put the
      condition for that in the caller where you only need to check it
      once. Then replace the adev parameter with a bool same_nid. And
      while you're at it, you can add some more conditions to make the
      fast-path more likely:</p>
    <pre>	same_nid = adev-&gt;gmc.is_app_apu &amp;&amp; adev-&gt;ram_is_direct_mapped &amp;&amp;
		   adev-&gt;gmc.gmc_funcs-&gt;override_vm_pte_flags &amp;&amp;
		   num_possible_nodes() &gt; 1 &amp;&amp; params-&gt;allow_override;</pre>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260407133833.463741-1-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">
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
  </body>
</html>

--------------CR6aTxfIYFHfZgpn8HLfxnoD--
