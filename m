Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2377C43327
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 18:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2064E10E0C0;
	Mon, 29 Jun 2026 18:37:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z3Ndrate";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011004.outbound.protection.outlook.com
 [40.93.194.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 386DE10E0C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 18:37:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvVtepJxGpZyqIgEX45uByX+gxU/N8dWR1ozZlikExyZexBfnRHwObiwCK/IG08tlziJz2N/JDZ86VrL+5pFWOjkVuebj8G2w9RRnUuwWb7jECbkETUGO9L9KrUaIe2tmaVZULpgFQZCl8bFaqoGLWlskPgpLRnDBTvpXGEtLdW2WdZj6MF23lCUh1YeXzb5uV4bQjX93fLy27rc3zH6+4mdnofB7psxN/cocoUwXLxm/unsG7tVFY/Au4WyGGHjEHNt7BKJvd1w9QudKJgmduWB1a4+e9umLFA9nLhrhL53tVzyvr5om69e85DPgyvCOta37QCLudumVsK1lYkiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hdRuYVA7yvcUA7k2+kccaU0F2GksxBjfveF/KiZfrM=;
 b=R46Jgg0ec0dEd7Jd1QRkHG1D7nA6JYKpCwsNqhg2E8PBaF1dlbgET9M1JvgwHWCGrjJUGYVsXE8328zeExpiEh2keub7+5ZUKplYJa2ajyQlzX02DQl3SuWsbXyo68l3PwpDF3eAslxbryoJygWSDoh52nza3n16M8YFXmIzDt8MAQna8lLn3TFitN5oSEV56fvQOSsXrKs9m+yBVpwd+brvxRoQK1/c/GdpmAFfYC3ghMZQaJEBFpWL7CLi4Y4S+gsJJvdk12XnXenNqAtpUPB9+OaHL6O0dLCZje+bbreazt5FkNLaVNS2odVcfNvrR06aj0pvobhvnyGTp5YN9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hdRuYVA7yvcUA7k2+kccaU0F2GksxBjfveF/KiZfrM=;
 b=Z3Ndratekmo/rze7bIpYgQQXtvM4Vbe0Y7CyjswZaXqbS5EtnbB4cjZTirg/2XNexWsd+VBqNG8tijlByVCp3Dv7u+Z31mBZJnDDHDcU82ZPqFTTBXmn6jO+rMhBzV4fhsEVJLTFA3O2Q1aRoBQGjb7DyxEcXJAFSXO7lhkEruM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 18:37:49 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 18:37:49 +0000
Message-ID: <f0719bbf-55fb-4d26-b717-b161ebde51fa@amd.com>
Date: Mon, 29 Jun 2026 13:37:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: use iosys_map for CWSR buffer access
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, Felix.kuehling@amd.com, Yifan1.Zhang@amd.com,
 philip.yang@amd.com, Harish.Kasiviswanathan@amd.com, Bob.Zhou@amd.com,
 jamesz@amd.com, "Claude Opus 4 . 6" <noreply@anthropic.com>
References: <20260629005028.2907470-1-James.Zhu@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260629005028.2907470-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:806:f2::7) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SA5PPF80B25317E:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d8d960-293f-4b8e-0eda-08ded60d851a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|11063799006|6123799006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0Y5WIQvptUWT0qRqg5SseA/vgnEoaID3TN2iP9h8YnUdw/GCgHCFqpXFmLZskUiPFJxCZKMCWLYx0fTzNGK/Mx5jKM3dQ0Cdooo+CYUJRFNmYtGD4TyWmBMj5sCo/iCpng02KN2Do1C/mAkzUdERKvyHEjTzgYwMk9EDLXKR3wgc3Uf2+hbvi6lw36W2TXFj3BDumc+CMyh3JPk+aPFPux2RHRU2QYvxZPcsUlVcKDz8tInWhgDuz1qZ08DU/iiI/m5XXdmUNMa8ATiRO69F45+JY3vWVqd6YjSCJOzN5IlnqlW52o/G+584gKUm/bLIDtc4oZw+QqYeMSBjLknwIm+h9pknwrWE36z/sSSVht9HWVYyYUmpgG3uKANzpwqtjqHckPXJT3uFqdjsKKmRCSBKFfVave3nIzz/OzcXolC6lN+QeL/tlupfVmKaq3ggw0f2TPWXYCk14AU4BjXuXyFamHSTIonuwzy/dH1v9Py7A8pudBWi7EZM+5KetBAQ1OEcMknt1+hK6jil/xNT17tLBd2JO223WsGPHGfkiiVy44W8lH1EgAPZ84OY+50OMSoJyBZmVBJ3dD5ALih9eKWkw2XCEVb1r8OQ1BtUtJaO7isuHN7JraDPXg9h9FtBrMLwN/E50YQsPW0GFrZUA4iZGAeWS37TqS9HiIIJNKw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(11063799006)(6123799006)(3023799007)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzdZTUVPd2l3WmpHV2Vvd01LN1F1RE5Pd0puVWJjSjhsS0twbUl4RWxDd0xL?=
 =?utf-8?B?eWtlZEFKM0FiUy84OHc3b3N6Tk5PNzZKOTZVZjVFT3VCR2NsNm4xYW1TRnB0?=
 =?utf-8?B?ZTBPSUhPZW0wWGdqNlg2eUIxVTB6elJEanhwYTNFOHEwTG55QUJiaVk3aFFy?=
 =?utf-8?B?QnEzTHVsdVhGYmNhaDJ0MXJKejJFK1kwNnlIaXJxck1MeGJ4MTdIczFYY2JR?=
 =?utf-8?B?SkcvV1NMVEJWd0x6TUdKQnRMbTh3MFNpc3pBazk3VUFYaWV5UnJJNS9Zck93?=
 =?utf-8?B?SmdxSUcydE1qUTBNTk5HZDRSaDdWdFlhUEVnRTgrVUNvY1FoK21kMWlGZUhC?=
 =?utf-8?B?a1VjM0thcWR3K0NlYmJBN1J0WmJ2Wno4Qm5YZGJJRytEUW5NRVdaMWdtcS8r?=
 =?utf-8?B?OXVxQ0U3dnRCMFkwRmdBSStDZHk1WEFqRzhzdGVWVFJTbTFleERvNVlURzkw?=
 =?utf-8?B?QzZxQVpxTXFHMldydWhZRGpMRzlwNHRlQ3RJc1hTaEtGOGU4MVUxQTNsRnIr?=
 =?utf-8?B?dnpOam1JUUluVzZuQ005VVlacElDc3VKWUF2dlJJZVlkdXBwbzYxeDE0MUVt?=
 =?utf-8?B?Zmg2b21VN24yTWRBcWQ5cG1ZazJaeUlBRnR3WWhIcmtHMDdQenppMHFvQWJ1?=
 =?utf-8?B?V2VWeFREZGlsYkpabmQ2WHcrUit2cTdKb3Fyb1lsTldyY1hMb2pvTnR5OTNG?=
 =?utf-8?B?WXVha2pLVGVzclYxNno3S3NqZUJ4aWtRQnozQ2ZpWXBvaXQrZis4ckVKYjVy?=
 =?utf-8?B?VFBYK2lFaitKMmQxbWxmZmZidTF5V2I1Yzc4RDhsU3EwcVEzY1dCbHVCejRQ?=
 =?utf-8?B?ZHdMdmJYWGdWZFFaaks2Y1UvQU9NLzNUd3p1eGZScHRWZnU0bVhzUzVxYmpm?=
 =?utf-8?B?ZXIxOFpyUUhIWENGNjBQMUdrTXo0WWRjTkZpbVptbVhEazRHQWVOcUpCZTZp?=
 =?utf-8?B?UnZLUUpqaVR1M3cvWmNNUVZZaEU3cVRaZFVPeDlWNG9CZFoxUDNjd203bHJP?=
 =?utf-8?B?MHdyVk1pdTJMb2lFOTkrdUZzZTYyblZIZ2tTL1pENDR6U3pad0NFZlRsaXZF?=
 =?utf-8?B?K2xORGk0KzZiSG1RdjBPdUZqQ3prM1AvVGRWcHV5QjZWdWJidnlNV0hiam5h?=
 =?utf-8?B?VjJsanhCREdUZXh4b3JmeFZXcnVzdHdmRmcxR1VMNDlmZGFPR3pic3R2anJj?=
 =?utf-8?B?QlgvVWFpRjI1TVlpL1YwVlpIV215TlZoUHJJRlFWMDVHSDhFL3BWNUN2WjF0?=
 =?utf-8?B?ZC9yWk9sQS9qcy9uWGNvWkV0dkdoM3JJMUpvVW9hK2daZC93QzZGNndnNkpE?=
 =?utf-8?B?TDMvcXFFNXo4T0MxaE53VEI5ZCtVaWhBa2tUWW5qdUxsTU1FR3ZwVUl0MENn?=
 =?utf-8?B?RHY4Q3RkZW9oZ0RUVmNWWnhsQzVub1FjWFlhRW81V3BPdmgvUjZkOFFCRXNF?=
 =?utf-8?B?TlJlZkI0c2s2MDVXelA1QXluSEozY1dVMSt6NjZWeEo1bXhmNGN2UHpPODRW?=
 =?utf-8?B?Y1dYTEUvWFJqeGVUcHc0QUUrdWZRT1FtY2lBMGc3UHBiRW8rUmpuMGxtbHhU?=
 =?utf-8?B?V05aT2hSRmVNK0VmWWR1MGQ5aUpYVmM3VXZ0SUNLR0lzaWZNcEZ3Q3VXbDBq?=
 =?utf-8?B?Tm9sOXYzVjVsa3hNcG9yYjd0VDc1Q3k0WW9CbFg5c2JTWWNiWkY2Vnc2NUVx?=
 =?utf-8?B?d1NNUS9uLys5Z0tCUUpDRFBpWXgvNGt4YjRsQ2RkYVVEWDhlUk1FdkN3bkdY?=
 =?utf-8?B?Q2hLSEU3UlJoTXEvdUxoYkkycVJoZkM0YWhaMnkrMW1sVGg3bG9jMFRwSU9Z?=
 =?utf-8?B?bDRQTC9HQWZaS29SNjJYZ0tERzdYamgwU0YyanVDVW5kSEpqbmNqK2Q5QmdX?=
 =?utf-8?B?emVXdVhRN0pJK05hVkpwOGJLNjExcXMzczFSNWZaZzg0QnozY2RiamFlcFln?=
 =?utf-8?B?b3ErTm9uMEtqK1FqUjM3WDdHUFdkOXdrcE1BTi81VFY0aER0eFd3MExGamNa?=
 =?utf-8?B?cExGRTBuRTQxUFYzeldLd1loSkZKWVBWSExTOG9MVElaNWJRR2xJQktENUVp?=
 =?utf-8?B?ckVlNGNhWDhLWS9veFloWndOaFJGTXhKRkE0OHNLWjRSSVYvOTk3UHpEU1k4?=
 =?utf-8?B?d0NTYnZ6a1pGeFFJWklrSmFJUG96VUtkYzZEZENYcHBpM1ZIQkZBeDhSZlhD?=
 =?utf-8?B?NnBvWVpnYnMrY1c3TFZHQVhUcENENUVYdmVXdGF5RnZHY3AyMkFtOHoreXZ0?=
 =?utf-8?B?dXkyVVdzNDE4WngzUndYaDNqODF0SzZZWDhmbHc5Zks4UjBnZnVFRDNZOXlV?=
 =?utf-8?Q?YnpTHXnBoEFp7qNlWq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d8d960-293f-4b8e-0eda-08ded60d851a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 18:37:49.0863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OqHN+Xl5vR5FL69w59qqTLXX5rtVGAa0kXbAP8Pf+TIuBXVr8cmF4ntBuhogZ4xc5CY5HOZ24LrRMrjLuiuENQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF80B25317E
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



On 6/28/26 19:50, James Zhu wrote:
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
The correct tags would be Co-developed-by and Assisted-by.
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 63 +++++++++++++++++-------
>   2 files changed, 47 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index ad4897f094a2..6e559aab4009 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -32,6 +32,7 @@
>   #include <linux/atomic.h>
>   #include <linux/workqueue.h>
>   #include <linux/spinlock.h>
> +#include <linux/iosys-map.h>
>   #include <uapi/linux/kfd_ioctl.h>
>   #include <linux/idr.h>
>   #include <linux/kfifo.h>
> @@ -710,7 +711,7 @@ struct qcm_process_device {
>   
>   	/* CWSR memory */
>   	struct kgd_mem *cwsr_mem;
> -	void *cwsr_kaddr;
> +	struct iosys_map cwsr_map;
>   	uint64_t cwsr_base;
>   	uint64_t tba_addr;
>   	uint64_t tma_addr;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 8e701dcda8ec..7fd65c31afa2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -33,6 +33,7 @@
>   #include <linux/mman.h>
>   #include <linux/file.h>
>   #include <linux/pm_runtime.h>
> +#include <drm/ttm/ttm_bo.h>
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu.h"
>   #include "amdgpu_reset.h"
> @@ -745,6 +746,21 @@ static void kfd_process_free_gpuvm(struct kgd_mem *mem,
>   					       NULL);
>   }
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
>   /* kfd_process_alloc_gpuvm - Allocate GPU VM for the KFD process
>    *	This function should be only called right after the process
>    *	is created and when kfd_processes_mutex is still being held
> @@ -1192,8 +1208,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>   		if (pdd->drm_file)
>   			fput(pdd->drm_file);
>   
> -		if (pdd->qpd.cwsr_kaddr && !pdd->qpd.cwsr_base)
> -			free_pages((unsigned long)pdd->qpd.cwsr_kaddr,
> +		if (!iosys_map_is_null(&pdd->qpd.cwsr_map) && !pdd->qpd.cwsr_base)
> +			free_pages((unsigned long)pdd->qpd.cwsr_map.vaddr,
>   				get_order(KFD_CWSR_TBA_TMA_SIZE));
>   
>   		idr_destroy(&pdd->alloc_idr);
> @@ -1501,7 +1517,7 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>   	void *kaddr;
>   	int ret;
>   
> -	if (!dev->kfd->cwsr_enabled || qpd->cwsr_kaddr || !qpd->cwsr_base)
> +	if (!dev->kfd->cwsr_enabled || !iosys_map_is_null(&qpd->cwsr_map) || !qpd->cwsr_base)
>   		return 0;
>   
>   	if (KFD_GC_VERSION(dev) >= IP_VERSION(9, 4, 2) && !dev->adev->apu_prefer_gtt)
> @@ -1516,17 +1532,28 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>   		return ret;
>   
>   	qpd->cwsr_mem = mem;
> -	qpd->cwsr_kaddr = kaddr;
> +
> +	/* Set up iosys_map based on whether memory is MMIO or system memory */
> +	if (mem->bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
> +		iosys_map_set_vaddr_iomem(&qpd->cwsr_map, kaddr);
> +	else
> +		iosys_map_set_vaddr(&qpd->cwsr_map, kaddr);
> +
>   	qpd->tba_addr = qpd->cwsr_base;
>   
> -	memcpy(qpd->cwsr_kaddr, dev->kfd->cwsr_isa, dev->kfd->cwsr_isa_size);
> +	/* Copy CWSR ISA to buffer using appropriate accessor */
> +	iosys_map_memcpy_to(&qpd->cwsr_map, 0, dev->kfd->cwsr_isa,
> +			    dev->kfd->cwsr_isa_size);
>   
>   	kfd_process_set_trap_debug_flag(&pdd->qpd,
>   					pdd->process->debug_trap_enabled);
>   
>   	qpd->tma_addr = qpd->tba_addr + KFD_CWSR_TMA_OFFSET;
> -	pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_kaddr:%p for pqm.\n",
> -		 qpd->tba_addr, qpd->tma_addr, qpd->cwsr_kaddr);
> +	pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_map:%s at %p for pqm.\n",
> +		 qpd->tba_addr, qpd->tma_addr,
> +		 qpd->cwsr_map.is_iomem ? "iomem" : "system",
> +		 qpd->cwsr_map.is_iomem ? (void *)qpd->cwsr_map.vaddr_iomem :
> +					  qpd->cwsr_map.vaddr);
>   
>   	return 0;
>   }
> @@ -1536,24 +1563,24 @@ static void kfd_process_device_destroy_cwsr_dgpu(struct kfd_process_device *pdd)
>   	struct kfd_node *dev = pdd->dev;
>   	struct qcm_process_device *qpd = &pdd->qpd;
>   
> -	if (!dev->kfd->cwsr_enabled || !qpd->cwsr_kaddr || !qpd->cwsr_base)
> +	if (!dev->kfd->cwsr_enabled || iosys_map_is_null(&qpd->cwsr_map) || !qpd->cwsr_base)
>   		return;
>   
> -	kfd_process_free_gpuvm(qpd->cwsr_mem, pdd, &qpd->cwsr_kaddr);
> +	kfd_process_free_gpuvm_map(qpd->cwsr_mem, pdd, &qpd->cwsr_map);
>   }
>   
>   void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
>   				  uint64_t tba_addr,
>   				  uint64_t tma_addr)
>   {
> -	if (qpd->cwsr_kaddr) {
> +	if (!iosys_map_is_null(&qpd->cwsr_map)) {
>   		/* KFD trap handler is bound, record as second-level TBA/TMA
>   		 * in first-level TMA. First-level trap will jump to second.
>   		 */
> -		uint64_t *tma =
> -			(uint64_t *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
> -		tma[0] = tba_addr;
> -		tma[1] = tma_addr;
> +		iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET,
> +			     uint64_t, tba_addr);
> +		iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET + sizeof(uint64_t),
> +			     uint64_t, tma_addr);
>   	} else {
>   		/* No trap handler bound, bind as first-level TBA/TMA. */
>   		qpd->tba_addr = tba_addr;
> @@ -1619,10 +1646,10 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
>   void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
>   				     bool enabled)
>   {
> -	if (qpd->cwsr_kaddr) {
> -		uint64_t *tma =
> -			(uint64_t *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
> -		tma[2] = enabled;
> +	if (!iosys_map_is_null(&qpd->cwsr_map)) {
> +		iosys_map_wr(&qpd->cwsr_map,
> +			     KFD_CWSR_TMA_OFFSET + 2 * sizeof(uint64_t),
> +			     uint64_t, enabled);
>   	}
>   }
>   

