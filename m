Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229F2C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 17:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD7510E0A7;
	Mon, 29 Jun 2026 17:54:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VxUtXarM";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4034289358
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 17:54:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkjsHYMN3KjImV24USkqvWAJKSig1Wf0SVg0vtIQtXK9oc3J3uC4t9emE9Sjs1KSsB1NjZNIM03oZIwPBE5l2Ovc1CEk4yE+d4GItPi89fRNKOJRurb/7oTQPk4D+qIdqpzfpoFLDRE7S9ebYWaNOG3ruJYzZ2mYvxPkSlZLjEnFor2nBEezY24p2FuCS3NyqbvC46r9K/ZwGZvh0mg5u2Qm30efGt1z93/BfJhQ/CyM+B/2hl6PXnytxRwH7M+KF7pbE7+UakLMlCmmubasPBnbhKzzVlfFdU+IRHUZlcJ6DDOy2KnWpJBdNDF10F6ikiNPozZlXkcFdRltvNKm/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xHp+Vgm+PXYi1k9oLSYqArBAQDc/G1VbnAuqAZSScc=;
 b=Mz2RU7F/bAHcFPkWsGDN9fD9sUNmao112XZYYAKSGz4oUYuMRfxRn8hPgPMjhgTcXjApt+ZiTU6ioiBDumdfoi/quTmz5MEy7lj+Yy5DWlS+EttsZegbhLUXyf5AyELNyhz3Rn2XDEK6YYjqGl85/ax7oILk98ToyaAe1RnVSY/vK5yl7BchozKYf9alRBnlKJPCicL9dodeLVfEaIG7Kenzr4GHwLQn975yoUaUxTA9Xj0phUVODeb+GCxOovB14Ym6pJ9rMJmArPzBOV27h9f9YoekB5sIW2H49GXhLLByqjHhxhHNyGFO3/aVxDNDsbTgIL+EWN0ZZ76U5G+FMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xHp+Vgm+PXYi1k9oLSYqArBAQDc/G1VbnAuqAZSScc=;
 b=VxUtXarM8MS/tSlnlCbcNIpvH87Xt5wsq57b7d5P71DweJMKQzYZTPnMvIYV82zNdqCtVynWguOVfxTzY0U+P9pl8vmzNtMO8nJVMwqQ+RIjzIcStXxRKiGM89CB16xJ5NYLsOCPnTBTZtxes77GPSux4ka4jb6/M3j10jFBlpc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DS7PR12MB8229.namprd12.prod.outlook.com
 (2603:10b6:8:ea::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 17:54:38 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 17:54:37 +0000
Message-ID: <7f1ec051-74e2-4ac9-8ac8-9725ca82bb80@amd.com>
Date: Mon, 29 Jun 2026 13:54:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: use iosys_map for CWSR buffer access
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, Yifan1.Zhang@amd.com, philip.yang@amd.com,
 Harish.Kasiviswanathan@amd.com, Bob.Zhou@amd.com, jamesz@amd.com
References: <20260629005028.2907470-1-James.Zhu@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260629005028.2907470-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0456.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::20) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 692063ae-f3aa-4e27-0c91-08ded6077c82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|11063799006|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: ZPNkdXqcDr0/ClqS9JDCXxMOkuJAGVEpAz47z/huJIc34juRJ+huI0CCiK5ChyQDG7kWxrbHqQO7dwFbCaVZf7aXhJQFj4zyvJNme+8KbRarvyRS+VbVTQERRudsFJW3W/jBR8295L4pxMfSih/BZC84OtMu/RAKGtKex/MdLgNQy6X4pmokl03lDXwN6Lwu+zORPI3fxAaP402bqDihT7D4tMRSZIB1FATNY236l6HDrVNnl3iFdMqTctIyULHldM/CBRP6wCwfs/kM5mUwkjyOdNHW2VHOV+MYvoJcIOLtj1IFmtht9Ciqll2aHf6EKIzlo8bxph+0cB+FrtkuUP40pjAbYEmXYp8M8ZegZFpvldvKK8CqQg3mJbg8s8uvnsKKknOkvo3LZTSx4kB3sbCuRSrayf9k4ncWRsyaht8um997hXYa5W/pyagIwF0Ngl0P8/qiDuKnxa17YSDunCCdXzytAS9HjwfrcUB+F/W1RrBBApxTseZ+OFJGcoDFVmqdgvuHj25iMexy7Df8dpZOuxh0q3ttTwhzctp4pBCwdsJb0EfrJJJG5TtFXBb9SDWuxz4ojFlkfEhKK+sKrXs/vlyBxganauYO++a/KLMdd/Hr70Ii976UF9SLx4+HLS1cxhFTu+2pxSK0iuFBKpXg6B6Ipn4AsmS4WCzjNH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0VacDhpVTZhT1ZMSG1ldllhRStrTmRDTjYzMTNlZm9nK0Q4TWpnV1FYWWtp?=
 =?utf-8?B?bnVIZ0F2eXVhUHFqTks4WkNlOVBKQ3RUQ09kTTdiclZGc2ZvZjdhYkI4ZHdT?=
 =?utf-8?B?aXJmaVk0OGo3SHppMGFCb2tyZXlOVWZrcjQ3WjRLNWZlQ0ZTZmhmenlDK0NB?=
 =?utf-8?B?QlRGS05BL0dSNGNmZSt0Z2dyZ2FKRWhURW1pOGc0TG5PdCtkbjVsR0NVQVNz?=
 =?utf-8?B?S2NEVnJmZ2dRQmhOMDdtSS95LzF0cCt5RWZneUt3Q2EwMXUvbGZNb3U3RDZ1?=
 =?utf-8?B?RjhlVFNVWjNtdGdJNEZIV0ZMdXZrOHdxQmdjZVdrZnE1RUVCcE9KcXN1ME5o?=
 =?utf-8?B?K3U1RDFhNVJzbFI3a1BNM0w3QU5ZMlZaYUovb2YveUpTMDcrQXdLTHRBcDhC?=
 =?utf-8?B?S01YY3c5L3F4cWxiVFF1c0RTNHVTTlpMRGdzZWJzVnZUaGp2aWtpWGRQUWJv?=
 =?utf-8?B?VmJIUDJLUmpxcEpOcFloeGJrcm04UkZPd3dQSTc4M3dzSldnWFk5dGsxWm5U?=
 =?utf-8?B?MkdSRzRoTEN3TnkxSTM5dVd6SGwyTGV3TlJDODNKZ1JkL2VVOVhaR282Y2My?=
 =?utf-8?B?NHJLaytub21ncG9CSmhCZnRDL29sWmJtcklwSDVRSmR6RWJiUGZXaDFoRStO?=
 =?utf-8?B?WUNVTytFeStrY0JpOW45NzdIMmRVWlBXYjdCL0tJWlQwMVo3STVDbVd3dUpk?=
 =?utf-8?B?eEVCRjAwQyttcFhxWStJTDJkQ2VyY1djc1V4bjdzcEs3UVkvTGxDMFNQQ1JE?=
 =?utf-8?B?dmlVR0dqMlhQMFJYT0xPY3JrWWplQ0hjMHl2bjdWUXFPRnVSSHZINVJGZjUy?=
 =?utf-8?B?Vmg2NTcwY3BlOGdpSnF3MitzcXZxbUpaZUpEWlBUNjFlZ2ZhZUZzdE1Pa0tt?=
 =?utf-8?B?SlhDaUc5RW94SXhNSlVmS212VzRsNlJUR2pEM1NaVktTVEdxbWpnMjNyWE56?=
 =?utf-8?B?Sm9IMTNnTU94czluQXl1NjcyeFBDc0JQdkpWa0NaZlU2akxaY2VrOHBWbTVS?=
 =?utf-8?B?M3N2SE9kMmdiQXdsRDlNMWJiZnNtT0l6TTh3eUdPZEp5SVNVZVJxTWJDT0Vi?=
 =?utf-8?B?ZnQ0SEF5Z3phQ3R3dUF1eER2dyt4eHRXVS93WXFXSUE4YThIKy9EU1hmUzRK?=
 =?utf-8?B?YmpSWXJaV3pYTnA0Y3FYMGU1eWpIV3MrNmkvNG5uVzN2WTZPV1ZWMDRJZGlw?=
 =?utf-8?B?Tml2QUpRVTRWWlE4aW1QZjlrWm1sWnVCWVRKVUpnNVY4OXhYSkV3dTMrbUFD?=
 =?utf-8?B?VUV3OXpraFVSZFl6a1E5T0E3SjZaZUlDOFhkcUduVlpXMTFOVkcyN1hTckRY?=
 =?utf-8?B?VFFqYWlIWnh0VE16NU9HbHdabVpuMzBEU0hpZFBKQUxUL2pabkUwN1B3M1lr?=
 =?utf-8?B?VGFmNFZvN3oxckNEOVFmL3FLazlpNXVwNHdlM3ZDL3N3MXd3VmxyQzVJNUJx?=
 =?utf-8?B?VTA1aUI1U0JzVzNlcnlJRUY4bWs2aENGOVozVUNMSGVObTEvd0JOTUZvaEdj?=
 =?utf-8?B?MDRnQ2JwT29mNHg0Y3g5eC92NzlpZ29hTFRYWXZHWDNiSHhmeWozUGlMV2Iz?=
 =?utf-8?B?V1VYMGtBOVVOcW96T2xoY01sb05mYTRWVjNpSHpXaHpMVjY3cjRhL0dkcy9m?=
 =?utf-8?B?OHh3RjNkUithcGt3ZzJ6V2tjRG1NOXNlNU1hTlhQVVN0QjVYSGk2R1lxRHd4?=
 =?utf-8?B?bElBdFNtMm1HMGR1TGJPdzc0NXEyZkhadXFEbDJOWGxMcnhGMGFFa2tZd0FY?=
 =?utf-8?B?UGs3VFRJZGdOTXdXaGVpMzRyUzlTVmxyYkRpTWF4WGNKYm1BTnFicTB6dllv?=
 =?utf-8?B?bHNKcmdhMFpPU1RNVkZOY2I1bStpU0dPWnA3TTg4UkFhb29JZU0zMXRNQkVl?=
 =?utf-8?B?VDVOeElrVlB4Uk92OEhrcWpEVjJDMHBkWmYzV0prNTB5cXpZa2VIbWlia0pU?=
 =?utf-8?B?dDRnNVlrbkFERFNrWjBwMDNBZERSbEdrR1YxYk0wTGRlcUZsWGxZS3lzaXJH?=
 =?utf-8?B?Z2hMdE9BNkx5a2Q0WVM2UCthcEtJaW9lQ1lyMmo5ZnF6TDFEUjJ3MWJYQWNB?=
 =?utf-8?B?NkU4dDAvZk1PV0pKdE9UQmN5Vm9sSHZIZ2VpeFhQRWdwTTN1c1JpQ0RMUGRT?=
 =?utf-8?B?a2pLWGsrMW5sMWJNQlZMUCtwcFdpckUxaytmY3VJMlQyOHd0aEF5QjFuOG5o?=
 =?utf-8?B?eUtKcDV1TjgzZ2daSHZRaFBqTGZQWWxQc21QQk96WGR6WFV1VG5VMnhjdHo3?=
 =?utf-8?B?L2dwQWtCa2tidlJlRzVTdW1nYnlleXU0Ym1qTVgxaVR4N0FDalpzNHJLQVJh?=
 =?utf-8?B?MkRXbFB3elVNaW1GbHB6UDNDMWRzTGZGMDMrN1FjZWxhczM3d2VKQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692063ae-f3aa-4e27-0c91-08ded6077c82
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 17:54:37.7702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onHjI0ucF2+T/CS2ZFqRVRqo4OFMh89phbtdaFaFm8e1sr6TEoZ9elJJXhKHzIcDwzmdYpp1yY3l9psf+RauyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229
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

On 2026-06-28 20:50, James Zhu wrote:
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

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


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
