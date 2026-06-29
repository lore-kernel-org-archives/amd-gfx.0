Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4F8C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 09:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C7E310E6CE;
	Mon, 29 Jun 2026 09:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RQGJI4br";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 819E810E6CE
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 09:57:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odvNhDMyiLfOYeQmTx1rBqad4jUYmoo/l9/Wknhp/bDJI/bdjOG7Hj2ZJd04ECvEBpiL4N5UVbATz2neNu3azZ6u2jqkXRi0sPzyTEjUX4/K7E6uD5oqsMvJvlKCf/ige+NrpWoTq14nuCFAi4Xxp4saP2vl6aDQoYfktP5GfqAEBYRlCQ0EbyMS0wFJZpdPtgDPZ5rV/8tyVwtx9qdhLYokkfbaF6AGc35CTpHOj7W+Vm9FaXJSL+MOmidBEC2umGKFvwQrE4jd0GfojkXzoVeOmkI9weMSIj5wk1p8ZAjr43YXEwzGAr52x37RIcfOSn5sU2ozyso/uirw70a1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bB6D3qgyhuiN8709YXlfBBwir3CIWkb4VAvxOUse/zM=;
 b=k7JJUs9olOvET3Yo/1t2JhAF04GW0+dmoTfAEf9kzITPyZV5bZFQ/b+O04FuQtngfQjGK4HF4C4fo5oBEMZLwLoXuPuJeYuXh8H0EkhHHDJ1VPsFLhr0m3SR1hiPLyOHE/ceeVPBd1374GdkneK+4iYHhqZXRxAcTkg1kWqJ1F6fIF6ORX1W9HxcNDjXLRLDX5zwB9w3IQg+lnSR6mBtOqXoOyXYhJwvN1cv+ZmFx7oQUkcgLbs+fhPpSWjt4hUmpOlprOdXgJ9kjyxH4GC6PjBEqNou/v9RzpuhtYL8GqUe3eXRDp2O12omVeGnmx8wh0amDwA0Cb4GSnOK6Ciqnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bB6D3qgyhuiN8709YXlfBBwir3CIWkb4VAvxOUse/zM=;
 b=RQGJI4brrLZif4gQmi10jn6cEs0uDXmZFi/NnvD6EgpEEfgyXSRv62rHM2VbbifdDK3wPpGKi6CzMHe2BxWZhXCIj7fq6GsRlWufXSvNNQZEerOOn4GB+xboatcUVtuoBZA8uENikBt/hXNyqU3Hi2my8oZjYcXU05uBMJ5dELE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8518.namprd12.prod.outlook.com (2603:10b6:208:447::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:57:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 09:57:14 +0000
Message-ID: <bdc2d660-2e57-4a70-b34a-d28a78b7536d@amd.com>
Date: Mon, 29 Jun 2026 11:57:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: use iosys_map for CWSR buffer access
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.kuehling@amd.com, Yifan1.Zhang@amd.com, philip.yang@amd.com,
 Harish.Kasiviswanathan@amd.com, Bob.Zhou@amd.com, jamesz@amd.com,
 "Claude Opus 4 . 6" <noreply@anthropic.com>
References: <20260629005028.2907470-1-James.Zhu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260629005028.2907470-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0138.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: f247ab35-c05b-425f-e1b8-08ded5c4cbf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|6123799006|11063799006|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: Vf8G29P2uXiRCwnc1R2o7yuGVhUDXWj0K/FX4UxbvcAIIRLA+wogdfZ3aXCueQTtMsqD570FF3jNaHqRHc7BmOU4pmtr0BChLb1RmdCe+pW3WL3XillHmuCowp/07+EEFm9a34RdcjcmTW+lOUZapKPsk77UykZ5eIAymGwi3mI3js4zVvjNR+KqaUcTeICefxGLiOIDXvzzDtxxD0T7VAkWU3x7q5+FshfJx0rJuXEMusy71mB4mC+DsDVjfU3TFqP4f4tHqLdxLFaRcb/j219XZcywGugjxX4c+YAwbnhHslOcr9tC87UwXxO3nBgG8JJIVmrcdcUkeG+jL/xP171m17mGOpxzt1KENEDjfLDapY+4Ffr+99+ELRPZRloFO6Nl8GJ6MwyvFt9B+x4ma3PpDFlI/pJREYOwLkwdJlx6t8oHsUwCrughtnyf0DEISiCsHN6SKvZcCNJYza8f16VmMXNluCPlaLg+ayRJh4hZZKZGwJr05piQyyJ4TbgoTERrWWzF/LA9UYhNlSG2wE1N28RdJO1HqJRyl7vjRdzhXxb5y+xrTczJMauf+Qn1UMj8uEc+qTLp2oGizKiJKGMFgAvfvaRzcl8L/1fXgTfyzudw4BvU3V2hpdDsKEdgnKT59Ksxicc7XxLrcGYVS7Ojfj9XUp8zPnl+nMZKj4I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(6123799006)(11063799006)(3023799007)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVd5SS9hYjZDbXRuYXdFckZKc2xRak5YeFdxaURRaWJ6STRnbi9wcCtrNjkr?=
 =?utf-8?B?ZzhkOENSVVJnWG1kNEpFQTM5VGl2YWlBbHIvTk9CRGRKQnJaNkU2cDZITnho?=
 =?utf-8?B?UENBZTBKaDdSaWZtSjlNZG9sWGxOS0tGK1NldlRuZXFwSFVvSWVxSU51ekRO?=
 =?utf-8?B?S3lTQ3NnbkJ3OWZRbTJiVFJPcDNDSmltNWVyYUE2RGpOZ3BmS3Bwb2NEMmha?=
 =?utf-8?B?cVlyRFc0ekMwL3lLM21tbVIrSzNPYkMxckVJa252VVVPOElSRTQ3RUE4dFQx?=
 =?utf-8?B?MmxpV1c5STZGVzNjSW5SQVdrZ1V0MDhJTUcraFBhdnMyOFp2RDF2cTlRcWVv?=
 =?utf-8?B?ajR1VUNDSS80R3ZNU0VkSUM4dGUwSWJZZHU3WEQ3cnExUERWczdPd0MvRHdC?=
 =?utf-8?B?SW8yem1jcXB3RXUwQk5FN1lnQnkra21vZ1IxY0RBQy9rR1liZHNLaDRWT1d3?=
 =?utf-8?B?Unc4b0FOajhRdzN5OEtUYVlpL0pPb0hnTlh6dlNPWWdnSFczMmtMRjlRUTYw?=
 =?utf-8?B?dE9Uc0xNV2FWQVo1aEhIMlVIVjMwSXFLekpTUmlqN1FzVEhZOTQrK2lsRnRw?=
 =?utf-8?B?MHJQNVlKOGVULzFGcmhYb0pZZFJ5WlIwUElTbUxpVU1FTTYzSFF3TFdsVHBK?=
 =?utf-8?B?TEFHQWpFYlQzTWpZbitzeTcwR2x2RngrUittYmswNjhWSXpBakRsdnM0VFZ2?=
 =?utf-8?B?T1NndEtJRVRWV0VGdUZYeUVZSnBQU3I1N1B0ci80ZDlGQXhQdjBuNmhVcG9Q?=
 =?utf-8?B?WnNlTzRuOUpKNXBkeHN3YlVweUV6VjlQd2ZzZHhGNmxhczBPV3RSZ1FnZ0hm?=
 =?utf-8?B?SW5waFN2RUFWMVY3K2xpeUx4VFpUbVBHWDU0cGJhdlJOZTdHQ1pmUkcraHIy?=
 =?utf-8?B?NmoxZ2tFQkxUTWJlUHoxZHovanRmTDdnbjFwMHBDWXNNVWhrb0lvM3NWeWI4?=
 =?utf-8?B?L0FiMnM2dTdVOXhZYVJ1eWFCZTNVK1BlUjBLMVE1NlE0TmhSd1pMQmJCUFFY?=
 =?utf-8?B?cTRRLzBiUHZ5Z05hMCtzajlwZ21xOUdvaXFUamNIRGxqc0gySkMzblZlYjZr?=
 =?utf-8?B?ZXVSaWZ3akNaTE51WHJ1T21wR0tHbHkvSExFRFMxazNjMStiYnlZbytEenQ4?=
 =?utf-8?B?ZEhVaU1JRmJqbHBEOWpWYjdyVUt1SmJVTVdwTW9CN1BJVSswU1M0UkpGOWp5?=
 =?utf-8?B?MHpFK1ArQ3JqbGNhOHRjUXlJREpXeDZYSmIxeWtYcjVxVnRMSHI2c0RVRytX?=
 =?utf-8?B?RlpJS3hveXc4OFM3NXpWTVptSGl0dVk1Mm15YXVBZjk0bUdVN1VybnV5S0J5?=
 =?utf-8?B?eXF4MWZTTlhuYXJUYkZ0MlMvUGVjcVhSU3RDK29KYzlSbTZnVmRUdGFpNWNP?=
 =?utf-8?B?M2RKdjJnUFdaY2F4WGdNM1NESnNza0ptZDRWUnJVdlFiVForRHhMRmVndURi?=
 =?utf-8?B?bGF5OWZUTkpUdmpiQVlPS1JrSUpaT29LNFpNbFlYRTJ2cmFsVkhIcjNCY2Ru?=
 =?utf-8?B?ZmlaUXVBTjEwd2RuYi8xZWJncEltQ24rdWVhTzlOUCtJVlNTOWh4c2NKdThR?=
 =?utf-8?B?VVorcGZoNlFTQ0FpWE9GWm1SSExXL3FTMUk2V3dCRHhtK1JkcHZZTTNWbW56?=
 =?utf-8?B?dTEzR1lYWVlYZjM0ZnFTdmhleGREWCsxVUNpRXI2bjNVUE8rUjRJeUxSQUVE?=
 =?utf-8?B?T0ZhNTdrdzNGRHdvNFBQRGhNa0ZVODVJZE1JYVdhUUR5MktMNzYydDl4aW9E?=
 =?utf-8?B?N1BUdFgzampEVElIYXQyQzhDMkRGcWpMd0JQWVNkVUdHQnlKTFBMNTlFeTVZ?=
 =?utf-8?B?ZTBQVjVVTFNPcEpJWDJVTmF0MitnYUtUUXNvR3UrUHNBSW8rSFd0aSt4WUg3?=
 =?utf-8?B?R0hiVStwdFI0RnRHcWhnckx5ZkVNaGIvMmdrNWEzeldjQU9XYlQvTFdqZGdw?=
 =?utf-8?B?NUJWTkhlZitZcm5RR0hyTmpJUHlWVFY4SUs2SmZFQ3VqaVdESE43WXRXNXJX?=
 =?utf-8?B?dmZSWWNXTGR5U3NTUENRdzM3Q3NMakkxdHJ0aGZrTXIwS2lLR2QwSi85Y2pm?=
 =?utf-8?B?WlZKYzNWMEw3clE1eFNNUGJ3eWVHclRMNnNXcVNXVkx2a0hGU0pISVdYdzRL?=
 =?utf-8?B?Sy9MbENqVnNUNS9peHg1cmpmV09ld2ZkWkh2UzdhUko1Ynl4ZkhoY0VPYlMw?=
 =?utf-8?B?d2kxZ1pUbTVXTjQxUkU1SDZJVml1OGlMV1NtRzgyZFRwaDdOUTRxYmtKTDZ4?=
 =?utf-8?B?bTZ0ZjFOQ2RlSnVKQlZyanBnMDJDRHVwUWxjY0grZHBKM0NSM2JEM2V4NUgx?=
 =?utf-8?Q?+Xnzo8PRrQGGR8P3nL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f247ab35-c05b-425f-e1b8-08ded5c4cbf8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:57:14.8494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vu/UWcNtu5O/DGDFc2HAgtQeyZ5h+/3PV0aw9HaBlXL3V71rKP2T02hvuFctzvG8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8518
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

On 6/29/26 02:50, James Zhu wrote:
> After moving TBA/TMA from GTT to VRAM for GFX9.4.2+ in commit
> 5088a1ba6d6d, direct pointer dereferences to CWSR buffers became
> unsafe because VRAM is accessed via MMIO (PCI BAR mappings).
> 
> Direct writes like 'tma[2] = enabled' and memcpy() can fail or
> produce incorrect results on non-x86 architectures because:
> - MMIO requires specific accessor functions (writeq/readq)
> - Compiler optimizations may generate invalid instruction sequences
> - No guarantee of proper memory barriers or atomic access
> 
> This patch converts CWSR buffer access to use struct iosys_map,
> which automatically handles both system memory (GTT) and MMIO
> (VRAM) correctly by:
> - Using writeq/writel/memcpy_toio for MMIO regions
> - Using WRITE_ONCE/memcpy for system memory
> - Providing proper memory barriers and access guarantees
> 
> Changes:
> - Replace void *cwsr_kaddr with struct iosys_map cwsr_map
> - Detect MMIO vs system memory using TTM_BO_MAP_IOMEM_MASK
> - Use iosys_map_wr() for writing trap handler addresses and flags
> - Use iosys_map_memcpy_to() for copying CWSR ISA code
> 
> This ensures correct operation on all architectures while maintaining
> backward compatibility with older GPUs and APUs that use GTT.
> 
> Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
> Co-Authored-By: Yifan Zhang <yifan1.zhang@amd.com>
> Signed-off-by: James Zhu <James.Zhu@amd.com>

Looks valid of hand, but I have no time for an in deep review. 
Somebody who knows the code should take another look as well.

But feel free to add Acked-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 63 +++++++++++++++++-------
>  2 files changed, 47 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index ad4897f094a2..6e559aab4009 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -32,6 +32,7 @@
>  #include <linux/atomic.h>
>  #include <linux/workqueue.h>
>  #include <linux/spinlock.h>
> +#include <linux/iosys-map.h>
>  #include <uapi/linux/kfd_ioctl.h>
>  #include <linux/idr.h>
>  #include <linux/kfifo.h>
> @@ -710,7 +711,7 @@ struct qcm_process_device {
>  
>  	/* CWSR memory */
>  	struct kgd_mem *cwsr_mem;
> -	void *cwsr_kaddr;
> +	struct iosys_map cwsr_map;
>  	uint64_t cwsr_base;
>  	uint64_t tba_addr;
>  	uint64_t tma_addr;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 8e701dcda8ec..7fd65c31afa2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -33,6 +33,7 @@
>  #include <linux/mman.h>
>  #include <linux/file.h>
>  #include <linux/pm_runtime.h>
> +#include <drm/ttm/ttm_bo.h>
>  #include "amdgpu_amdkfd.h"
>  #include "amdgpu.h"
>  #include "amdgpu_reset.h"
> @@ -745,6 +746,21 @@ static void kfd_process_free_gpuvm(struct kgd_mem *mem,
>  					       NULL);
>  }
>  
> +static void kfd_process_free_gpuvm_map(struct kgd_mem *mem,
> +			struct kfd_process_device *pdd, struct iosys_map *map)
> +{
> +	struct kfd_node *dev = pdd->dev;
> +
> +	if (map && !iosys_map_is_null(map)) {
> +		amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(mem);
> +		iosys_map_clear(map);
> +	}
> +
> +	amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(dev->adev, mem, pdd->drm_priv);
> +	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->adev, mem, pdd->drm_priv,
> +					       NULL);
> +}
> +
>  /* kfd_process_alloc_gpuvm - Allocate GPU VM for the KFD process
>   *	This function should be only called right after the process
>   *	is created and when kfd_processes_mutex is still being held
> @@ -1192,8 +1208,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>  		if (pdd->drm_file)
>  			fput(pdd->drm_file);
>  
> -		if (pdd->qpd.cwsr_kaddr && !pdd->qpd.cwsr_base)
> -			free_pages((unsigned long)pdd->qpd.cwsr_kaddr,
> +		if (!iosys_map_is_null(&pdd->qpd.cwsr_map) && !pdd->qpd.cwsr_base)
> +			free_pages((unsigned long)pdd->qpd.cwsr_map.vaddr,
>  				get_order(KFD_CWSR_TBA_TMA_SIZE));
>  
>  		idr_destroy(&pdd->alloc_idr);
> @@ -1501,7 +1517,7 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>  	void *kaddr;
>  	int ret;
>  
> -	if (!dev->kfd->cwsr_enabled || qpd->cwsr_kaddr || !qpd->cwsr_base)
> +	if (!dev->kfd->cwsr_enabled || !iosys_map_is_null(&qpd->cwsr_map) || !qpd->cwsr_base)
>  		return 0;
>  
>  	if (KFD_GC_VERSION(dev) >= IP_VERSION(9, 4, 2) && !dev->adev->apu_prefer_gtt)
> @@ -1516,17 +1532,28 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>  		return ret;
>  
>  	qpd->cwsr_mem = mem;
> -	qpd->cwsr_kaddr = kaddr;
> +
> +	/* Set up iosys_map based on whether memory is MMIO or system memory */
> +	if (mem->bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
> +		iosys_map_set_vaddr_iomem(&qpd->cwsr_map, kaddr);
> +	else
> +		iosys_map_set_vaddr(&qpd->cwsr_map, kaddr);
> +
>  	qpd->tba_addr = qpd->cwsr_base;
>  
> -	memcpy(qpd->cwsr_kaddr, dev->kfd->cwsr_isa, dev->kfd->cwsr_isa_size);
> +	/* Copy CWSR ISA to buffer using appropriate accessor */
> +	iosys_map_memcpy_to(&qpd->cwsr_map, 0, dev->kfd->cwsr_isa,
> +			    dev->kfd->cwsr_isa_size);
>  
>  	kfd_process_set_trap_debug_flag(&pdd->qpd,
>  					pdd->process->debug_trap_enabled);
>  
>  	qpd->tma_addr = qpd->tba_addr + KFD_CWSR_TMA_OFFSET;
> -	pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_kaddr:%p for pqm.\n",
> -		 qpd->tba_addr, qpd->tma_addr, qpd->cwsr_kaddr);
> +	pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_map:%s at %p for pqm.\n",
> +		 qpd->tba_addr, qpd->tma_addr,
> +		 qpd->cwsr_map.is_iomem ? "iomem" : "system",
> +		 qpd->cwsr_map.is_iomem ? (void *)qpd->cwsr_map.vaddr_iomem :
> +					  qpd->cwsr_map.vaddr);
>  
>  	return 0;
>  }
> @@ -1536,24 +1563,24 @@ static void kfd_process_device_destroy_cwsr_dgpu(struct kfd_process_device *pdd)
>  	struct kfd_node *dev = pdd->dev;
>  	struct qcm_process_device *qpd = &pdd->qpd;
>  
> -	if (!dev->kfd->cwsr_enabled || !qpd->cwsr_kaddr || !qpd->cwsr_base)
> +	if (!dev->kfd->cwsr_enabled || iosys_map_is_null(&qpd->cwsr_map) || !qpd->cwsr_base)
>  		return;
>  
> -	kfd_process_free_gpuvm(qpd->cwsr_mem, pdd, &qpd->cwsr_kaddr);
> +	kfd_process_free_gpuvm_map(qpd->cwsr_mem, pdd, &qpd->cwsr_map);
>  }
>  
>  void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
>  				  uint64_t tba_addr,
>  				  uint64_t tma_addr)
>  {
> -	if (qpd->cwsr_kaddr) {
> +	if (!iosys_map_is_null(&qpd->cwsr_map)) {
>  		/* KFD trap handler is bound, record as second-level TBA/TMA
>  		 * in first-level TMA. First-level trap will jump to second.
>  		 */
> -		uint64_t *tma =
> -			(uint64_t *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
> -		tma[0] = tba_addr;
> -		tma[1] = tma_addr;
> +		iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET,
> +			     uint64_t, tba_addr);
> +		iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET + sizeof(uint64_t),
> +			     uint64_t, tma_addr);
>  	} else {
>  		/* No trap handler bound, bind as first-level TBA/TMA. */
>  		qpd->tba_addr = tba_addr;
> @@ -1619,10 +1646,10 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
>  void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
>  				     bool enabled)
>  {
> -	if (qpd->cwsr_kaddr) {
> -		uint64_t *tma =
> -			(uint64_t *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
> -		tma[2] = enabled;
> +	if (!iosys_map_is_null(&qpd->cwsr_map)) {
> +		iosys_map_wr(&qpd->cwsr_map,
> +			     KFD_CWSR_TMA_OFFSET + 2 * sizeof(uint64_t),
> +			     uint64_t, enabled);
>  	}
>  }
>  

