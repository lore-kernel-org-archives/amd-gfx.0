Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A215EE4996
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 20:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E60D710E2A3;
	Mon, 21 Aug 2023 20:32:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B71910E2A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 20:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFCXtoMSgldEIFoLMtYZqcxJ0tcJwh0Y/KNFouMl7DxEXDTxzd5hQItl/QiF8Lg2xMQ6Ncbb2xTgPDkwqV1VpoRqn+7M+1buROKY1qvKvf/sMFNCQvQB3n3Dr63C6vnZMhDUHM+KMORqnr3WhXKrZKVAcpVV7mTyGiCXXszGSOHGWTQKlehxo95QHA4qcNSUx0JdO+6tmP1Fktf8H094tMrNrRk7j4gCc0hPlEA4HFr+AOA1F2i8Xn3RDVPSzkAJyXMirND1eeFaXXjL3yKD2K3DmQId/SJtxVWmms+YLIuUZpwtygfMLIcMqxv8lnpPjCE7ZlWNk+bu901Tk8U7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzHYTcHgTnVPwNqMXrLInL6U5MUEnXdQB646m3c4YeI=;
 b=gKjN4ibrRlyAzeu3C53aVm/50rUX8Xd62GG+kNt2dpJWDuHKOs3LWnR2ziuUzXMWwZ2cbKrt27BRT/YBJn3uUgfSZIf5WkrrHp5hA80ms9s2bKksLuaKXu8P0MjIef1jDfzV3Ak0Q7rZvNbye85W6eQRN+yEZa/wtFLKJnxj5zqwEjfyKWCfz0QXsOTJwnZ57/h2YIVQQRTlh+/h1/3GC59cqKrdccnQ8M7TIXAkSVY5ABf/Yn+8UJLwDDqS3qZkIPC9U6U/V43kBVTUK9Ov8uMsFahnubNFPonHNzUlkB1i8lQ7S3aCgaVvp2bN9PZ2wV4RzMcgkZcSTeTLgzwGnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzHYTcHgTnVPwNqMXrLInL6U5MUEnXdQB646m3c4YeI=;
 b=aa0xb3ZVdnom/pUdjqIXxANbPbEJwmHPYh6Hcs0gXKlTfjR3YljKzJyKJbl954MgMRmR1C3OZqVEOurGVdm5PsB2pCMGtiQBSHjih8oj0W+iRoyEeo4J821pYGw5KUtb/HtLmj9PuxyXa0taWJimJdsuYzX2FIqNKnQ9UgIGg98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 20:32:13 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 20:32:13 +0000
Message-ID: <60f44d5f-bb03-379d-992d-1b7715e6e685@amd.com>
Date: Mon, 21 Aug 2023 16:32:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: Rework memory limits to allow big allocations
Content-Language: en-US
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230821192001.12370-1-rajneesh.bhardwaj@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230821192001.12370-1-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5174:EE_
X-MS-Office365-Filtering-Correlation-Id: d775d195-65b2-483d-f218-08dba285b376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6azTvglJ2bqHzVmYkbacbPZJN6bFY4Oyy7PyC5vR4k2LaG5Qh6kK+WUQfdAs4LuH2/HYUIq7NB0f5T+B7a7EBVwzKUutR9gIsHJBPhxRdKbVvTcmgZ33xD3a1hGzz9FIueA9IY8e0IO5Xdq91cpBDZcIl59qF9L3rS7fdPIk3xKMONqE/VbjGwU7ncF4jtnXZp5qpBaIGO8QE+U1VZHSySaFIr0kpEVcuv87dumWlB62pE/eJt5z0ddw/u/zFbvvlcrePDXL7hGbBj8CtFHWzppPMG5Ov3KHcKE0lw21p4+qvuL800hNIyWYpyGzhEYnduGLi/dYOSwsdMawEdxGNiS0CVsVr2KoBB0UqTQR6MV4lbeBUhMWPvK4QEYAbhU01jhuLjUryg2obEy8qsnYgR6td4S6DN3Qb1jBNbPSdSLl3RUDY2OV647JbkZN1aDEPxWPUbIupz7CtPOQAa3ZRWjL7vhiWc6ECUazDuWxtpy0cP+oyBojtymvqvxh/P8N3vWl52CwcY04lKMP2kFvHv0esSOT/GHOO+sDSfevz0FEE6wG6jXFLc3TB+ChRNcJEcg6xC2J82NW/cZCD8EZcf4DQHanO6O8+c946tpa4jHUXw730O4dyewgtVYmr/fk7myrxE3yCPlsjb9rMFTDhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(66476007)(66556008)(316002)(66946007)(6512007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(36916002)(53546011)(6506007)(6486002)(83380400001)(2906002)(86362001)(31686004)(31696002)(44832011)(5660300002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGxzbTNDc1o5eFJXWnBxRzRMemlSRDdSRENDKzBLUmxDcy9DWjJ2NjRaRzBk?=
 =?utf-8?B?Sm80MlI0SmNLakZ4cVBMNXlzdWgvUmxSU1Bvb3pSS0puL2o4dlhUVE83N1VL?=
 =?utf-8?B?YTJTaVA2VDJveWJzRHEzUkpWUjhuRStVc0Rsb2cyeWVscUtWQjdveGhaNGJU?=
 =?utf-8?B?TmR4TmJtemJkZDBYWlhDL29Qa3JWc2Z1Q1NhOWJsdjFiN2c1aDJSWW53TzlF?=
 =?utf-8?B?UWNERFRocEdCN2JWVFdYSTZDZ1ViTUNwN3R0UjEzd3d6RFg0a2xjckI1K2hj?=
 =?utf-8?B?U2FPQjhhaDJiOGJXcVdXM0wvSmxIRWpadndVRGF2L01jeTFHMEkzSmxzRTBK?=
 =?utf-8?B?cklVTmlRVjFpODVEVlNHcDlDbmdlS25kZis3bTlMMnhCUE8xQnQwVEtZcm10?=
 =?utf-8?B?KzdpanRMZ29mMk5qWEpNTlBkSVJBV2FyTVVHN2FLUDNCa283UG9vbDBkN3RD?=
 =?utf-8?B?dDNrcjdHT093Y0ZlY2FPZVErMldJaCsxd2kyczE4M1BSYktQeDFtdDdwT05X?=
 =?utf-8?B?dVhuVFVCTXMyRlVIZU5GejltVzU1YWlGdkdYLzJKTmh2ZURkRjFhRVp5RGZj?=
 =?utf-8?B?dDFFRGhRcGhBbE40TkFYVGNEcXBoTUc3ZjVTQndRNEs0N25hZTBuUjI3Wnlh?=
 =?utf-8?B?MzBVdjdvS0tpZUxhUTNwQS9OSzJwc2NHSDNWRk1lcWdtQTlsTGl0SmRHblVr?=
 =?utf-8?B?OXY0bjNqSW5WZEhZeHdMdmRRTTVoRlcvVDNvUTBFK0NSNU9CQVVBMExJL0pm?=
 =?utf-8?B?SjBDakZ2ei9TWkdvQWN3UklYM1B6WU1SZk1ieVlpeGk3TkgvMUkxcG1zdVNH?=
 =?utf-8?B?VC9INjNZY3NGQ0JkRlA5eVE0T29YMWlEZHFsbHdQT1BNbWNURlk3ekN0ckUv?=
 =?utf-8?B?bGpiUEwvcllqZ3NOam0yZDNQY0JQSThuNmZLUFBWSWp3eWZoTjBsUVNSOU9N?=
 =?utf-8?B?Q1FkVHhybG93STFDK2FNU0s4YUZHVzlyOGdMSG9qbEl2cHBxUWpWcFJZdEFB?=
 =?utf-8?B?S0FuY1MrZ1FJNVlvUWY0ems4WHpNSkQ2NXNMSE96dURYYjk0VVFmSTgwK0RW?=
 =?utf-8?B?SHZrVW5mV0dOdTR2ckMrZVJ1Y0Z1VFU4Ykt3QkxsUnJ4U2x2ak5oS0ZHL1Vt?=
 =?utf-8?B?WVlrSWlrMmlFSGxCZ1lXanJMNUJjVFdOeXA0bDlncHZ6a0I3eEM4V0JYMFdO?=
 =?utf-8?B?YVRPNi9HZ2YzRVpFZWdvOXc2bmZWYUN6VGpxQlpKSi9KaFlyTTFBUkFBUEdt?=
 =?utf-8?B?U084M3pRa3NTLzZrZFIydngvN2hUU21lc3EyUDE3VzBVa1V0UU9zVmZ3K055?=
 =?utf-8?B?NkhMZnV2OHdoblhwelJnS1JwNmJGR0ZSSjM2V2F6Wm1qRWdUb256WXpzZnQz?=
 =?utf-8?B?Uk5CU0VQWWtqN2RaTUowUHZnUm1RMnZ2V2N4T0Nuc2dUVVVqdDFHSU1jdEJw?=
 =?utf-8?B?b0dubnFHdjlSUm9sTVl6L1djUGpFUkM4ZnVRVy9EK3orbDVGd01YY3Z2RFB5?=
 =?utf-8?B?ZjhNMXNYYVJubXJIMis1YUI2U0kvMFp4ZzRGTERpU3piazFNMFdqWS8yMERt?=
 =?utf-8?B?cXhKQWprdVcrT1hOek42ZEJwOGljRDBuYXBXUHBZdVExUWRwN1ltenh3R1R2?=
 =?utf-8?B?VTVlQ1lVeEhRZUhzMFVycFpSSWxxUzJEUWI5M3crT3hGZ3pJZWNNd2RDNStN?=
 =?utf-8?B?TXQ1Z1V0aFNuU0hPQWpFOUhrTlo2T3FKSjlTamZXZ091WitQVUFENEMxQjlq?=
 =?utf-8?B?QkJEWDVVTExYSkRjRlJQZUNUYStDM3ZIWXd6aDZyNjJ3UHFBQlNEQjF5N2Fu?=
 =?utf-8?B?cWJ2QmN5WU4yTVB0NmhJYkZINzBWNnBpd2xmUTR5T2ROMmUzeUdRRFlHNnQw?=
 =?utf-8?B?dmg2dGh5ZGlEd1NBRm9DeG1oblBFUDVnREQzbDI0NmdjWGFqOEEwYU1oUXo5?=
 =?utf-8?B?bGFjOEsrWlBTK21kZXI0MU14OUFRbDhmTDllV3FQZ29DZzNsSEJPZGdOeFo2?=
 =?utf-8?B?a2l2bTBBZnQ0ZytZcHZSRDBKSGhWN0VMR3JhbmkxTlhLeENqWkNobUw2VHRr?=
 =?utf-8?B?ZEhNZU1wUnZMY2k4T2YzelVKTlRkWUxZZnlkYURlU2lqY1NwTWkvQnlFQ1Yx?=
 =?utf-8?Q?byEcLQnA8kE3zLHsr/dLZYrQ3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d775d195-65b2-483d-f218-08dba285b376
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 20:32:12.9767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ot46lKFoTnBsvR3l+PzJj5yr2QJR/QQRe8KZJPMQdeeOW0ZWsv8Q20OMe9Wd5s5l+Onr3UkGmr5felYp/Yb+Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-08-21 15:20, Rajneesh Bhardwaj wrote:
> Rework the KFD max system memory and ttm limit to allow bigger
> system memory allocations upto 63/64 of the available memory which is
> controlled by ttm module params pages_limit and page_pool_size. Also for
> NPS1 mode, report the max ttm limit as the available VRAM size. For max
> system memory limit, leave 1GB exclusively outside ROCm allocations i.e.
> on 16GB system, >14 GB can be used by ROCm still leaving some memory for
> other system applications and on 128GB systems (e.g. GFXIP 9.4.3 APU in
> NPS1 mode) nearly >120GB can be used by ROCm.
>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  5 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 25 +++++++++++++------
>   2 files changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 9e18fe5eb190..3387dcdf1bc9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -44,6 +44,7 @@
>    * changes to accumulate
>    */
>   #define AMDGPU_USERPTR_RESTORE_DELAY_MS 1
> +#define ONE_GB			(1UL << 30)
>   
>   /*
>    * Align VRAM availability to 2MB to avoid fragmentation caused by 4K allocations in the tail 2MB
> @@ -117,11 +118,11 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>   		return;
>   
>   	si_meminfo(&si);
> -	mem = si.freeram - si.freehigh;
> +	mem = si.totalram - si.totalhigh;
>   	mem *= si.mem_unit;
>   
>   	spin_lock_init(&kfd_mem_limit.mem_limit_lock);
> -	kfd_mem_limit.max_system_mem_limit = mem - (mem >> 4);
> +	kfd_mem_limit.max_system_mem_limit = mem - (mem >> 6) - (ONE_GB);

I believe this is an OK heuristic for large systems and medium-sized 
systems. But it produces a negative number or an underflow for systems 
with very small system memory (about 1.1GB).  It's not practical to run 
ROCm on such a small system, but the code at least needs to be robust 
here and produce something meaningful. E.g.

	kfd_mem_limit.max_system_mem_limit = mem - (mem >> 6);
	if (kfd_mem_limit.max_system_mem_limit < 2 * ONE_GB)
		kfd_mem_limit.max_system_mem_limit <<= 1;
	else
		kfd_mem_limit.max_system_mem_limit -= ONE_GB;

Since this change affects all GPUs and the change below is specific to 
GFXv9.4.3 APUs, I'd separate this into two patches.


>   	kfd_mem_limit.max_ttm_mem_limit = ttm_tt_pages_limit() << PAGE_SHIFT;
>   	pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
>   		(kfd_mem_limit.max_system_mem_limit >> 20),
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 8447fcada8bb..4962e35df617 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -25,6 +25,7 @@
>   #include <linux/pci.h>
>   
>   #include <drm/drm_cache.h>
> +#include <drm/ttm/ttm_tt.h>
>   
>   #include "amdgpu.h"
>   #include "gmc_v9_0.h"
> @@ -1877,6 +1878,7 @@ static void
>   gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
>   			      struct amdgpu_mem_partition_info *mem_ranges)
>   {
> +	uint64_t max_ttm_size = ttm_tt_pages_limit() << PAGE_SHIFT;
>   	int num_ranges = 0, ret, mem_groups;
>   	struct amdgpu_numa_info numa_info;
>   	int node_ids[MAX_MEM_RANGES];
> @@ -1913,8 +1915,17 @@ gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
>   
>   	/* If there is only partition, don't use entire size */
>   	if (adev->gmc.num_mem_partitions == 1) {
> -		mem_ranges[0].size = mem_ranges[0].size * (mem_groups - 1);
> -		do_div(mem_ranges[0].size, mem_groups);
> +		if (max_ttm_size > mem_ranges[0].size || max_ttm_size <= 0) {

This gives some weird dis-continuous behaviour. For max_ttm_size > 
mem_ranges[0].size it gives you 3/4. For max_ttm_size == 
mem_ranges[0].size it gives you all the memory.

Also, why is this only applied for num_mem_partitions == 1? The TTM 
limit also applies when there are more memory partitions. Would it make 
more sense to always evenly divide the ttm_tt_pages_limit between all 
the memory partitions? And cap the size at the NUMA node size. I think 
that would eliminate special cases for different memory-partition 
configs and give you sensible behaviour in all cases.

Regards,
   Felix


> +			/* Report VRAM as 3/4th of available numa memory */
> +			mem_ranges[0].size = mem_ranges[0].size * (mem_groups - 1);
> +			do_div(mem_ranges[0].size, mem_groups);
> +		} else {
> +			/* Report VRAM as set by ttm.pages_limit or default ttm
> +			 * limit which is 1/2 of system memory
> +			 */
> +			mem_ranges[0].size = max_ttm_size;
> +		}
> +		pr_debug("NPS1 mode, setting VRAM size = %llu\n", mem_ranges[0].size);
>   	}
>   }
>   
> @@ -2159,6 +2170,11 @@ static int gmc_v9_0_sw_init(void *handle)
>   
>   	amdgpu_gmc_get_vbios_allocations(adev);
>   
> +	/* Memory manager */
> +	r = amdgpu_bo_init(adev);
> +	if (r)
> +		return r;
> +
>   #ifdef HAVE_ACPI_DEV_GET_FIRST_MATCH_DEV
>   	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3)) {
>   		r = gmc_v9_0_init_mem_ranges(adev);
> @@ -2167,11 +2183,6 @@ static int gmc_v9_0_sw_init(void *handle)
>   	}
>   #endif
>   
> -	/* Memory manager */
> -	r = amdgpu_bo_init(adev);
> -	if (r)
> -		return r;
> -
>   	r = gmc_v9_0_gart_init(adev);
>   	if (r)
>   		return r;
