Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41C5CD6E57
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 10:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52023113EB0;
	Thu,  4 Jun 2026 10:04:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gzi8hbGC";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011038.outbound.protection.outlook.com
 [40.93.194.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E4B113EB0
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 10:04:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PA79e8qUoGggswjDebOQRyuqkmJrpZ9EUrKGQCUs8atB9YAmKYsneJHOmF/fy4GWVRidv14xttZhdbJHW1jmvVwVZrjwUunY9FgqgLC5+JTYA0A/9/JK0jJUAikkTNmS9Eh6wrJoI+LDqak4qFZIIqwG9PGarysKgKp4gSl4KCFT4yymKHUWgEorGNnYyprqxM/oNOqrLM7utyDObKaSrlCV4LcnyKOcMvpLiKnhuRvy8C7o/uX8j/15kwSRI5JDw1vSOXQzQjs89ft4wvDLsiWYM9abPTuBGo0EqIey2Si09ybhImzS8tC6WHQjp3CSnQcs+WZThE80vwU0GrnEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dF4IHtNIqh3RhgRwMXRrpy0khZyd1kDyFUD4/xZxzo0=;
 b=Cefv+ChUDHQ1+kZ4yLkHkds/8wcSD0+SW73J5I7E+UAHyeZJ28aPZk6NUrEfRVtGJMp2zJBvM9t06sNDdoFjPh3C3ukFBpR5Ez5R+6gDVXGe9ejrb6lEVfzwegRk5/ePzJh42dmgIWoYyNGFcsbsvr2imxDOiDFSqwHLkzPkQiwp7kpnXzt2I3CoQmHiTaukih6em57AwN7d9i62e9322RSkxuxinU8WcDvDyrT1Nj/591Ki3+Ci6ybdmF4Qk6FGiP624/lwnAMFRfgfXbA1NU9Vhz2kdxQQ1Rq+b+/WIecfxL+x+LeWl7r3cr5e6+uGwd1LBHh86550LYShZGon8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF4IHtNIqh3RhgRwMXRrpy0khZyd1kDyFUD4/xZxzo0=;
 b=Gzi8hbGCi24CO9XvrOjcSUFdqOjsrKwv7lof4sdPSWIEiSZbnGmtjYChHRu5nc0ueokak/k+ZfcpfDjuDlDCN7YP8TN24U5zPV3ex6AJrEbSfupDMYvfNSJd/6XpTZDS6MFToVWzy8izPwhs1n13x7tg3xpNtrlFaBanzR2PZCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by PH0PR12MB999090.namprd12.prod.outlook.com (2603:10b6:510:38c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 10:04:05 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 10:04:05 +0000
Message-ID: <4e052e5f-0ab2-4c50-b649-ba636c97d876@amd.com>
Date: Thu, 4 Jun 2026 18:03:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] drm/amdgpu: split amdgpu_vm_update_range
To: christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, natalie.vock@gmx.de,
 Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Philip.Yang@amd.com,
 timur.kristof@gmail.com
References: <20260529114031.3714-1-christian.koenig@amd.com>
 <20260529114031.3714-9-christian.koenig@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <20260529114031.3714-9-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI3PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::17) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|PH0PR12MB999090:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e4959f3-4251-42fd-8fe7-08dec2209c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|6133799003|3023799007|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /G8gKhyooYCXWkwMukuD3NsZkSo3NFAXYiIFRXwg3oDDc9m5JFJwybQ1LRG2b8m0494MMp9yCLpMcyks0qyqA7Z9mVgE8LR07pqLGnATT9rreoKDJ0CHNPlpPOJleBvqtmwaPVUWThCPRdBE2PKiSBqzSLnFqRd4Ef+wM3yG4tFYaCPHCc4rSelzyKI9WaS3rNz6J+fiB33kB3M0dw5NhCEiRn+EM5x5PUiSOdHry730beu864hqgnuvSTQ5MSV5wTbaeavofYxZ2LzPdnni61JGfKic26KldaVpS7FMahEggf5f79AmEoPDxBvH5xnT1Ar5ktW5tjZESVbla0RFbOQs4gQCa8YXQ1MCK0PzNeUBQO0bMc7Zya50hRogFNbTvb0d0rbO4dHLNIawZDUEbsmgS7/5bms7UrK679Vbv64ngrQn6cgqlvGkM4pYze8onV5KiHeU0Dz7v2YR4XPTITZ+FCFokKJt55qLnedpas3en1k3ZMVVyOlEqTVpskYHo5HBeJHj56FphadthxE3gi7Rn0ji8sVkbtc1LBAesEmDbLDLnZJwGkY/8X3YUdP0wMwAtodYW2l3lmlS/Xmf1yolVvsQF7FN60Ays0l1AgcfJnR/6WNbM+L+edNWYlrB/uz/63agJ5AT5uU6BdbKs2j9BEOSvSNnPi6CTDQJcQn/YvIEOba++dizMrRhFV2J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(3023799007)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUlTcDNZbGwzR21sOFp0NGdUVHNDYVRVM1lFa29BQit0ZXB2TlpHKzF3Mnhr?=
 =?utf-8?B?RXJud0JuODdmTHBFNVVTbjZVSnBIUDh1TkMvRHdBWnVUcFZnMk1PMFpCMFNU?=
 =?utf-8?B?V0hxWTRPYVV1OGhjdlpUa29jVGZ4MVpNNy9EMytBVFJpQkc2NHJjTEZWTlhi?=
 =?utf-8?B?Rnl5eExTcFp3VkJqZXpyKzVldEcxdjBrYXNCbm41RkxSYmhQcmdjd042dWh1?=
 =?utf-8?B?b0Nwa1JkUUpKSGhvK2t0V2dmZkx2ME54MmdHdlMwZjJYaHZ0V0FpTHlGQ1ZF?=
 =?utf-8?B?TkJHUDI0aEtlSjNhUURwb241YmllZmh3K2tpUkozeEdxZG9oK2pyQUh5V2Vu?=
 =?utf-8?B?K0JlOE1XTWVISkZQcGlIc0ZwdU1xV2ltR2RRNXdvQ2pnR2JMbm5CRG81MkE0?=
 =?utf-8?B?SFljOXY1V0ZRWTdtMFFrWnNvRnRUdDAxc2cvemJMcS9saUVMeVJGVjZ0U002?=
 =?utf-8?B?UmtiMFExRC9EeWMwMTNJM1k5a2hScXNsazNJYzNEcWtnY0t1WlJ3QkFLdWk3?=
 =?utf-8?B?eEo0Slk5MGZRak9uWnBndmtxMzlMY2VGTzlvT3VDUE53anJGTDNIVVlGT0xo?=
 =?utf-8?B?RlZqc2RjRSs3Y0FNVFVhcE5aY2dOZWJRNXJ5WldhOVk1SW8vaFYyeDBKajdJ?=
 =?utf-8?B?eFkra25vZVc3MHd4a3J5ZDY1emFBd3pLWHVZMklONXViYUx2T2REeEloelZt?=
 =?utf-8?B?d3Vtd0VTeVc1VHJqMkpyTVZzeElTdlFjd0RXVE42Y3N4UlozSzhSaGJpcDhH?=
 =?utf-8?B?STFrT1VRbzc1SXVLamhGNFByL2NyOWlOcUVKOGNkZFRmanBEa0xuemdHaHNL?=
 =?utf-8?B?djZVbnVxNHNMdkdiamwvRzYyZC8yd1M1bGpiTjNDQ08rYUVaS3RFN1hocXlR?=
 =?utf-8?B?N3NXSWpzNEtqODhVY0ZkNzM3ZVVtaERIU3JVWjFkakxNQW1qd0p2NWVTbWx4?=
 =?utf-8?B?L2U4anI3eDUyNkMwT2NtMlZzb0VhNVVOVHpneXVqRWNETFZWMW9CRU9wQXUx?=
 =?utf-8?B?SHRyZStHNlpIZWJCT0JSSTVmNlk3b0FVZ2tLWk9WM29KbC9PbXJrL1BKalZk?=
 =?utf-8?B?SjZGNG0vc1NqYTlsMmFsbmRRUWR2WTduRXlmQ1lHK3h1L0tKdjliK2N2Yk45?=
 =?utf-8?B?REpQZGxiYU9yZHBEVFo4MUZsRDRXSGVjUlRQdkJrdGM4R2JsLzViaFp0Ulky?=
 =?utf-8?B?S2dwV2RrWnJ0dGEwRWxxUis4L0tyWFYwZVM4RTUwaVZpSFJjKzJBTDk4R0pi?=
 =?utf-8?B?bWZCNW1MMHZQWXdKL3JWaG90NW53b0FkVGVMa0FjbXhXR3hxSFJ2QXFCQ1Ew?=
 =?utf-8?B?c1pFcG4vSjJYNXNhTWlhL21WV1o1TWVUQVZEQ3ZTdnVVb2hDbHd6N1hORHdE?=
 =?utf-8?B?SDBOWUVWNnh5RGZGbkJkR2xWUDRlSGp6ZERGbjFMYU13b0cwTk5hSmI4VXZm?=
 =?utf-8?B?cW5nazdRL3VUd1dyWFNIWlRRQzhvbmxpb2xtUXhJcUxDc21GMmNxclc1WDVq?=
 =?utf-8?B?N2JYYjZxeU83WENYRjltVnpYS2hWTEZsdTZMdmxyMTI1dCtnUG1YQTBoeTVj?=
 =?utf-8?B?Z1FUZjhva2Q1SUdYd2JkWk1XbWg3dnRNYlR3Y1RUR01RYk8zWnJBRUNQdnU4?=
 =?utf-8?B?NTRwWWlsbW5UYXZOMWRJcnlTT1ZLSE1yaHdMMjlFaWFUQUVNdG5TU3pYRUUy?=
 =?utf-8?B?SGNsMVNMdUcrZHIwOExSUHBkTzhmM215RnJUdkI0eWZ4aGNMR0JzSFo1Uk1P?=
 =?utf-8?B?eExLdG5MVm9IOTU3MnVTNDAxaGh0YzZ3RlpUOVhPQ2RpNDA0R0lRTTAzNmFn?=
 =?utf-8?B?L2poQWswVkJ4ZHEvaVM4bXNEUTNkZ1R3VnNxNjhIN0UrN2V3UVBuMUgrMHlR?=
 =?utf-8?B?WGhsd3hmbzBlY0hOcDloSWNCUjdYemFFcS82aFFoNVIrekdJa2JsQ1RaM3d6?=
 =?utf-8?B?ZnlMaW56b3Q0cXV1VXlkR2paVFpUaGpwSWFpZ2lPZVF2RjhvcU04OVlIZEdi?=
 =?utf-8?B?dEhQa3JFT3dVc3VDemtaMU5rL2FVMHhQeU5oM25ROGJGVjlXZU1KQkgybzgx?=
 =?utf-8?B?UGR0SDdvUlphYUo1WFRqa3dHQVJ4NXhDTEFVaWdaTXpCbWlud3RHbFNaUnVO?=
 =?utf-8?B?QmhFdkZJMnIxd0hQNTA4RWtiTnlxekNlMlZSWHJXVERqUUJpbHBlT3dmakov?=
 =?utf-8?B?TTFCaFIySHB6WUJLR08yUjBXZWMrZlFzbEdkVUFhRy9qeGJhc0ROZ3JlZm1G?=
 =?utf-8?B?aG43VWJiT3pRbEo1L0hhODZPdFRhT0ZyM3UwdUpXVFBVNDBES1VJZnVraWxC?=
 =?utf-8?Q?a4Exj7HPkc6vo0hRp+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4959f3-4251-42fd-8fe7-08dec2209c27
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 10:04:05.1829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYopJSsH6QlYzM7VV3kygrec5grbgdQrlNuhcmExP8wdjNNi325sk0LIDdXlblF/5EKKrM3N0srzCIEwCvqljw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999090
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



On 5/29/2026 7:24 PM, Christian König wrote:
> Split amdgpu_vm_update_range into two functions.
> 
> amdgpu_vm_map_range() is for mapping PTEs into a range and updates
> which can be done while holding the VM lock.
> 
> amdgpu_vm_unmap_range() is for unmapping PTEs without holding the VM
> lock in MMU notifiers.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h   |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 112 ++++++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  14 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  35 ++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c      |  16 ++--
>   5 files changed, 120 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 44fe40f9e8df..653ffa9ca0f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -47,7 +47,7 @@ enum amdgpu_ib_pool_type;
>   /* Internal kernel job ids. (decreasing values, starting from U64_MAX). */
>   #define AMDGPU_KERNEL_JOB_ID_VM_UPDATE              (18446744073709551615ULL)
>   #define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES         (18446744073709551614ULL)
> -#define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE        (18446744073709551613ULL)
> +#define AMDGPU_KERNEL_JOB_ID_VM_MAP_RANGE           (18446744073709551613ULL)
>   #define AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR            (18446744073709551612ULL)
>   #define AMDGPU_KERNEL_JOB_ID_TTM_MAP_BUFFER         (18446744073709551611ULL)
>   #define AMDGPU_KERNEL_JOB_ID_TTM_ACCESS_MEMORY_SDMA (18446744073709551610ULL)
> @@ -63,6 +63,7 @@ enum amdgpu_ib_pool_type;
>   #define AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST         (18446744073709551600ULL)
>   #define AMDGPU_KERNEL_JOB_ID_VPE_RING_TEST          (18446744073709551599ULL)
>   #define AMDGPU_KERNEL_JOB_ID_RUN_SHADER             (18446744073709551598ULL)
> +#define AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE         (18446744073709551597ULL)
>   
>   struct amdgpu_job {
>   	struct drm_sched_job    base;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index edc8b1ca2d3e..b5adfcacc55a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1080,11 +1080,10 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>   }
>   
>   /**
> - * amdgpu_vm_update_range - update a range in the vm page table
> + * amdgpu_vm_map_range - map something to a range in the vm page tables
>    *
>    * @adev: amdgpu_device pointer to use for commands
>    * @vm: the VM to update the range
> - * @unlocked: unlocked invalidation during MM callback
>    * @flush_tlb: trigger tlb invalidation after update completed
>    * @allow_override: change MTYPE for local NUMA nodes
>    * @sync: fences we need to sync to
> @@ -1097,23 +1096,26 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>    * @pages_addr: DMA addresses to use for mapping
>    * @fence: optional resulting fence
>    *
> - * Fill in the page table entries between @start and @last.
> + * Fill in the page table entries between @start and @last. Allocate and free
> + * new page tables as needed. Can only be called while holding the VM lock.
>    *
>    * Returns:
>    * 0 for success, negative erro code for failure.
>    */
> -int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			   bool unlocked, bool flush_tlb, bool allow_override,
> -			   struct amdgpu_sync *sync, uint64_t start,
> -			   uint64_t last, uint64_t flags, uint64_t offset,
> -			   uint64_t vram_base, struct ttm_resource *res,
> -			   dma_addr_t *pages_addr, struct dma_fence **fence)
> +int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			bool flush_tlb, bool allow_override,
> +			struct amdgpu_sync *sync, uint64_t start,
> +			uint64_t last, uint64_t flags, uint64_t offset,
> +			uint64_t vram_base, struct ttm_resource *res,
> +			dma_addr_t *pages_addr, struct dma_fence **fence)
>   {
>   	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>   	struct amdgpu_vm_update_params params;
>   	struct amdgpu_res_cursor cursor;
>   	int r, idx;
>   
> +	amdgpu_vm_assert_locked(vm);
> +
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>   		return -ENODEV;
>   
> @@ -1138,7 +1140,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	params.adev = adev;
>   	params.vm = vm;
>   	params.pages_addr = pages_addr;
> -	params.unlocked = unlocked;
>   	params.needs_flush = flush_tlb;
>   	params.override_pte = allow_override && adev->gmc.override_pte;
>   	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
> @@ -1149,7 +1150,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		goto error_free;
>   	}
>   
> -	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
> +	if (!dma_fence_is_signaled(vm->last_unlocked)) {
>   		struct dma_fence *tmp = dma_fence_get_stub();
>   
>   		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
> @@ -1158,7 +1159,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	}
>   
>   	r = vm->update_funcs->prepare(&params, sync,
> -				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE);
> +				      AMDGPU_KERNEL_JOB_ID_VM_MAP_RANGE);
>   	if (r)
>   		goto error_free;
>   
> @@ -1234,6 +1235,77 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	return r;
>   }
>   
> +/**
> + * amdgpu_vm_unmap_range - clear leave PTEs to unmap something
> + *
> + * @adev: amdgpu_device pointer to use for commands
> + * @vm: the VM to update the range
> + * @sync: fences we need to sync to
> + * @start: start of unmapped range
> + * @last: last unmapped entry
> + * @flags: flags for the entries
> + * @fence: optional resulting fence
> + *
> + * Fill in the page table entries between @start and @last with a fixed flags
> + * value without allocating or freeing page tables. Can be used without locking
> + * the VM.
> + *
> + * Returns:
> + * 0 for success, negative erro code for failure.
> + */
> +int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			   struct amdgpu_sync *sync, uint64_t start,
> +			   uint64_t last, uint64_t flags,
> +			   struct dma_fence **fence)
> +{
> +	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
> +	struct amdgpu_vm_update_params params;
> +	int r, idx;
> +
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +		return -ENODEV;
> +
> +	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
> +	if (!tlb_cb) {
> +		drm_dev_exit(idx);
> +		return -ENOMEM;
> +	}
> +
> +	memset(&params, 0, sizeof(params));
> +	params.adev = adev;
> +	params.vm = vm;
> +	params.needs_flush = true;
> +	params.unlocked = true;
> +	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
> +
> +	amdgpu_vm_eviction_lock(vm);
> +	if (vm->evicting) {
> +		r = -EBUSY;
> +		goto error_free;
> +	}
> +
> +	r = vm->update_funcs->prepare(&params, sync,
> +				      AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE);
> +	if (r)
> +		goto error_free;
> +
> +	amdgpu_vm_update_leaves(&params, start, last, 0, flags);

A quick test update:
Since the amdgpu_vm_update_leaves update the PTEs to insert a dummy PRT 
PTE, use this func to unmap GPU mapping will cover entire PDB0 range, 2M 
in my local test, it will umap extra ranges, causing GPU fault errors on 
the xnack off platform. Blocks some basic features, many cases failed here.

and it seems like the parameters in amdgpu_vm_update_leaves is start and 
end, maybe need "last + 1" here.

Regards,
Honglei


> +
> +	r = vm->update_funcs->commit(&params, fence);
> +	if (r)
> +		goto error_free;
> +
> +	amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
> +	amdgpu_vm_pt_free_list(adev, &params);
> +	tlb_cb = NULL;
> +
> +error_free:
> +	kfree(tlb_cb);
> +	amdgpu_vm_eviction_unlock(vm);
> +	drm_dev_exit(idx);
> +	return r;
> +}
> +
>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>   			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
>   {
> @@ -1362,11 +1434,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   
>   		trace_amdgpu_vm_bo_update(mapping);
>   
> -		r = amdgpu_vm_update_range(adev, vm, false, flush_tlb,
> -					   !uncached, &sync, mapping->start,
> -					   mapping->last, update_flags,
> -					   mapping->offset, vram_base, mem,
> -					   pages_addr, last_update);
> +		r = amdgpu_vm_map_range(adev, vm, flush_tlb, !uncached, &sync,
> +					mapping->start, mapping->last,
> +					update_flags, mapping->offset,
> +					vram_base, mem, pages_addr,
> +					last_update);
>   		if (r)
>   			goto error_free;
>   	}
> @@ -1565,9 +1637,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   			struct amdgpu_bo_va_mapping, list);
>   		list_del(&mapping->list);
>   
> -		r = amdgpu_vm_update_range(adev, vm, false, true, false,
> -					   &sync, mapping->start, mapping->last,
> -					   0, 0, 0, NULL, NULL, &f);
> +		r = amdgpu_vm_map_range(adev, vm, true, false,
> +					&sync, mapping->start, mapping->last,
> +					0, 0, 0, NULL, NULL, &f);
>   		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>   		if (r) {
>   			dma_fence_put(f);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 3e86a2a470f0..561f2873d2ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -529,12 +529,16 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
>   				uint32_t xcc_mask);
>   void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
> -int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			   bool unlocked, bool flush_tlb, bool allow_override,
> +int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			bool flush_tlb, bool allow_override,
> +			struct amdgpu_sync *sync, uint64_t start,
> +			uint64_t last, uint64_t flags, uint64_t offset,
> +			uint64_t vram_base, struct ttm_resource *res,
> +			dma_addr_t *pages_addr, struct dma_fence **fence);
> +int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			   struct amdgpu_sync *sync, uint64_t start,
> -			   uint64_t last, uint64_t flags, uint64_t offset,
> -			   uint64_t vram_base, struct ttm_resource *res,
> -			   dma_addr_t *pages_addr, struct dma_fence **fence);
> +			   uint64_t last, uint64_t flags,
> +			   struct dma_fence **fence);
>   int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>   			struct amdgpu_bo_va *bo_va,
>   			bool clear);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 6f5415d5a1bc..ac3f3e31e2e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -553,7 +553,6 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>   			    struct amdgpu_vm_update_params *params)
>   {
>   	struct amdgpu_vm_bo_base *entry, *next;
> -	bool unlocked = params->unlocked;
>   
>   	if (list_empty(&params->tlb_flush_waitlist))
>   		return;
> @@ -561,7 +560,7 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>   	/*
>   	 * unlocked unmap clear page table leaves, warning to free the page entry.
>   	 */
> -	WARN_ON(unlocked);
> +	WARN_ON(params->unlocked);
>   
>   	list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist, vm_status)
>   		amdgpu_vm_pt_free(entry);
> @@ -801,24 +800,17 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   		uint64_t incr, entry_end, pe_start;
>   		struct amdgpu_bo *pt;
>   
> -		if (!params->unlocked) {
> -			/* make sure that the page tables covering the
> -			 * address range are actually allocated
> -			 */
> -			r = amdgpu_vm_pt_alloc(params->adev, params->vm,
> -					       &cursor);
> -			if (r)
> -				return r;
> -		}
> +		/* make sure that the page tables covering the
> +		 * address range are actually allocated
> +		 */
> +		r = amdgpu_vm_pt_alloc(params->adev, params->vm, &cursor);
> +		if (r)
> +			return r;
>   
>   		shift = amdgpu_vm_pt_level_shift(adev, cursor.level);
>   		parent_shift = amdgpu_vm_pt_level_shift(adev, cursor.level - 1);
> -		if (params->unlocked) {
> -			/* Unlocked updates are only allowed on the leaves */
> -			if (amdgpu_vm_pt_descendant(adev, &cursor))
> -				continue;
> -		} else if (adev->asic_type < CHIP_VEGA10 &&
> -			   (flags & AMDGPU_PTE_VALID)) {
> +		if (adev->asic_type < CHIP_VEGA10 &&
> +		    (flags & AMDGPU_PTE_VALID)) {
>   			/* No huge page support before GMC v9 */
>   			if (cursor.level != AMDGPU_VM_PTB) {
>   				if (!amdgpu_vm_pt_descendant(adev, &cursor))
> @@ -864,14 +856,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   		mask = amdgpu_vm_pt_entries_mask(adev, cursor.level);
>   		pe_start = ((cursor.pfn >> shift) & mask) * 8;
>   
> -		if (cursor.level < AMDGPU_VM_PTB && params->unlocked)
> -			/*
> -			 * MMU notifier callback unlocked unmap huge page, leave is PDE entry,
> -			 * only clear one entry. Next entry search again for PDE or PTE leave.
> -			 */
> -			entry_end = 1ULL << shift;
> -		else
> -			entry_end = ((uint64_t)mask + 1) << shift;
> +		entry_end = ((uint64_t)mask + 1) << shift;
>   		entry_end += cursor.pfn & ~(entry_end - 1);
>   		entry_end = min(entry_end, end);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 37b5166e9a14..d0ea20dea3e1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1372,9 +1372,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		return -EINVAL;
>   	}
>   
> -	return amdgpu_vm_update_range(adev, vm, true, true, false, NULL, gpu_start,
> -				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
> -				      fence);
> +	return amdgpu_vm_unmap_range(adev, vm, NULL, gpu_start, gpu_end,
> +				     init_pte_value, fence);
>   }
>   
>   static int
> @@ -1489,12 +1488,11 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
>   			 pte_flags);
>   
> -		r = amdgpu_vm_update_range(adev, vm, false, flush_tlb, true,
> -					   NULL, gpu_start, gpu_end,
> -					   pte_flags,
> -					   (last_start - prange->start) << PAGE_SHIFT,
> -					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
> -					   NULL, dma_addr, &vm->last_update);
> +		r = amdgpu_vm_map_range(adev, vm, flush_tlb, true, NULL,
> +					gpu_start, gpu_end, pte_flags,
> +					(last_start - prange->start) << PAGE_SHIFT,
> +					bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
> +					NULL, dma_addr, &vm->last_update);
>   
>   		for (j = last_start - prange->start; j <= i; j++)
>   			dma_addr[j] |= last_domain;

