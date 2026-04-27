Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F11FF885E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 11:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98EBA10E6D8;
	Mon, 27 Apr 2026 11:23:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vW3P8mBd";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EA6F10E6E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 11:23:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmgdLbwbnAa4HbP2xTxDus/LPsmy2y1bJZi04ONGeznTVo84VaKhSOWf92/Wae98Pvut6acPgDz9eH/OJ/CcObwwrkjqkwnIS7cmPNmNXKroA7uYreBPyEf6WPCd68lNJytB9ku6jJ17XRNhq2BZ41nXT6ty8vy/0DvkTJok8YSIk0j0dCWcNjnUUBusPSnhQpFQljKZCUl8vsnYIlEMCROBQJXLJsMyptNKdZiu63S0+3zm8z7zHbTmEzyZETKILhGk3fmLiCt0QSvKVOjevqX/XOebxO8MRnVQ70zFI0vRXFtxL9GgiSGmYuL8tQPeMyPKo6MTReIP9AeoMfWCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XjYjcP35ghwkAskLKSNErBynJQBcgqVnXdFPSOvsLg=;
 b=sur6XUHqyINpw1fIWpwyaBJ5fl2aOyiVoAhpevvWvU+T7NBDUeZMRFJDmJBromXx3ezdrqoX6HA7VPbLjAsyaozD3iiFbUqpC+yDTiMmM0P6qH8YKG4Yup6WHsrz2n8WhnlXD+oTRa8gmcR60tEUJgPLYI4wedReoFBcYKvUcCA6r3vE3g82N7Hwzbikdm/v2OpEGPzTZwfr6Ig0t7klFNHfhqupqyyBAxHeBx2L9IqfPEGiVoRdvshxGqQri751irgUGkTQfeUb2zmPQ2Bh3KW0o/G4c+BmREfzGpX/jLg+F0Zx4yyRfkk5sTqiVcy5+xMJyPf2JRwYmwzfGy4gPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XjYjcP35ghwkAskLKSNErBynJQBcgqVnXdFPSOvsLg=;
 b=vW3P8mBd0BNintgY1c9rPM/e0yVfaqwh+epdf8QITrW2L8LjMU6rJR1cfZ7jINoZ/ok3J8IKZbO9cXtPjoRp6iDhDp8Fo4Q98nydNSjRAj2ahkYtFJ3bMx3hTTfC9ojB2PXX8hZUCsBPEckvJhFBNHiNM84vK1op1OHZ2WjnU/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB9129.namprd12.prod.outlook.com (2603:10b6:806:397::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 11:23:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 11:23:49 +0000
Message-ID: <5db71d7e-6524-4746-916f-e91c38bd7d5c@amd.com>
Date: Mon, 27 Apr 2026 13:23:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: move VM PTE MTYPE override to per-PTE
 granularity
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Kent.Russell@amd.com, Andrew.Martin@amd.com
References: <20260420133705.3721315-1-Philip.Yang@amd.com>
 <20260420133705.3721315-3-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260420133705.3721315-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:408:ff::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f66c1e-da86-49e6-08fd-08dea44f7426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 8/iTjyE/gGwVDinS9PjttriseQYIhzR8H5LTNXilAHDvkbS0JvP8damQhl21i8GeRUcPD4ZYYEw2EZt8f941yFPpbu63QAKEXnzqj4dV6cGU+ZCt1CrC5l6CLpzYP4kT2nUbJfID18MIUiTBNRgseNnYuRd7IAkmkHsQKC10Dvue4pFNVD4O2+6uuMFng5CS6tIJpxfo2UFzsulaPCfdtHDMSE6cVaOQiYSwhU5EqMAfUNzKjbTwqGB8gahaOuJ1wh6IkVRI2IT2SNA9Nf+bJVqRp33X11viD2iP+QHdekC6KLgTn4MTg/mFz2RGKPApmLdlI01/MuvHqi78nvKqAFLUU4d7DAcsErEMkzFM/v7gxlISwHBYTeprd3iyeOFIe6KBVnzp0xps/JPhdBZmKvi7mBMymljBXMNaYpFaMV5kpOq8bCRYPzD2XQktsb4IkhFhAv4tIyThswFezRvGExtPzRphIK+1UyTHsUpX/CGh4VxEYNXHF3SdglJDw4IxYFU6r0KPn6nBkHA1IlmzDlfi7g34gM8zo2xdKPdhfPbTL4UTCY9rnIN93dxDfKXIPiXDxIiEKGdJHYu7Ajt/G2biUaLz3AS3EWbrYtoah/Dvs6UarPepMY0/16kdELAsB2Jd8kmBNYr1qjDJkjKAh2HKUvcl62Y8wB59ck9isZm7byXmfHa4Vex9JSMnuDZHFu/+qK6nR4ch4meGzkXvgXVoqbi+fJUXtfOuuOZRQ40=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlR2Q2t4V2ZzcHpNR0lSS0NoeGNKakdJSGxDbVBHQWdhTEVGWTZlRjE3WGpL?=
 =?utf-8?B?S0xDeGlvSFgxVzkzWW8yRTdLblRmWWFtb2VxamhQNVFUY1VUbFQxQ3NaNlBp?=
 =?utf-8?B?a3NJclVzTndmNzREQ3I2M2tRRkNyN096eVoxQysrK24vQTRTNzZFaExNQ0dP?=
 =?utf-8?B?VU5NWS9NM0lhazFobC9FaHJTUjVtdGgzS3Y3cXcyemp4K1NPaktobUMrZnFk?=
 =?utf-8?B?SGhzNmY1MmExbkZSWGQ2YlllRkRQVnZpSGo2TTcveENZYmVnelZQYkd5ZVNh?=
 =?utf-8?B?VG9aZzdDUFpMMlNrUit1cTVzaFhwU0hrTEV2eE83Q0V0d21SNmt2aUZKRTlX?=
 =?utf-8?B?eEMwTVM5ck9SbTg3Vk1sN21lNlBRQzdwMHlLVDhDNHdFVDd0Y01kK3VxeUN0?=
 =?utf-8?B?NUpSTG9DeE5QYzFWQTc0SjR4Mk9GbldaTW8wdngxZU53RkpQT0lGQXJ5QlNZ?=
 =?utf-8?B?YUxoQ2J5SmZjQ2RaanRiWFZYSXUwb1Z4YzF3Z3B3d284dGx2cmhjVkVDU3pj?=
 =?utf-8?B?ek9YT2ZTMlZFazRrd01oZlNoUGtieStXOFJ4RXc5eDUvUXNUTXBjaGJVNUFT?=
 =?utf-8?B?T3lCM3l0NmpLM2VMTVN2TlNvSi9pMnp1anRsb3FPejVVNmVyck5EWEdia0d5?=
 =?utf-8?B?MTNtaE4zRVgxV3I3REZ5K1VNSTcyaFM4U0ZaWGNXQWZFVCt0MTBqb3FaZ2N6?=
 =?utf-8?B?akhTYVlPN3QzTHVndTRJTTZTdEVGcElKS21PUFFuREttMWM0WEoyNm1RWkM1?=
 =?utf-8?B?a3k4ZDBuVHMxZDg4SXhsZkNhR0pFbTJBNkNUWG5oRFNuQ1RLVU5KNlIzUUpr?=
 =?utf-8?B?TWM2RlJpQUs1VEkvcTh1TTdPV2FUSWZ6YS9wT2ZDYTNFMlFWalp2d0Vua0N2?=
 =?utf-8?B?M1VteEltK1lLMzFLZFNsYWxTd0FSR2Fqd3N2OTFFbm1lVkdHNTVwdU93RjRN?=
 =?utf-8?B?cGZjOVRhSWwrRExpbkRDQUFYVFFWSUVlZGxYejBLTjdtZ0x0RTA5a3NmSWc5?=
 =?utf-8?B?bWhuaDVHcDNCTVlCY0J2NmtxaU1MQ2tHT1l2a1VoVFhLSEhPa2RaajEvZHdF?=
 =?utf-8?B?eU9ONG5CRFJnS21CNmcvcDZaK0V1K2dBdE9JanlRQ0V1Q2FRb1ZuN3lzVC9y?=
 =?utf-8?B?YUlJZDVtdHhNRWZEVDc2SFc2Q1QxZld0cWZvVGRxN21yd2thbUNMc2hjNmE1?=
 =?utf-8?B?Sm5RQWk0aW1sNG4vTEVXQkFxcXdXR09jRzRRUkM0MGQ0LzJVTGN4amFsMDdU?=
 =?utf-8?B?RWh2RCtLZlkvVjNYZjdVWEdJaS9uOEozeGJPSzdjRmhVMXAyNWVVVHBlWVl2?=
 =?utf-8?B?dkNCVi8xNVB3d0VqUE5PSE1KSFl3R1JaRE90U2dIVzRQRlJ1bFZyV3JKTjFm?=
 =?utf-8?B?d1JUZG5oQWRaS2hNY3Vic24yc3hKc1J5YVo5WlRtTyt3Ujg2cEFlN0lyTTR4?=
 =?utf-8?B?QVJyM3o5OFBOWU4vTEc4YTNweTE3alZuay9qL1NTbDU1c2lkU3hWV3FIUVdZ?=
 =?utf-8?B?SHVkeFkvWnZwRFpwZzlpdkhvTEltYnZnd2dHMVlaTi9HSDcxRTZKd1dCT3dE?=
 =?utf-8?B?eGVqaXFmWDJjMy9oMHMySkpnNTZ4ZVJ3SDhaZm1YOWZ2d0tIMTlxK0oybnIr?=
 =?utf-8?B?NjY4dkQyT1Vab2U5dTY0L3RRbEgvTVlpSG95a2xYQUlPMjJObmtYQnd6RitR?=
 =?utf-8?B?dTZNNTN5ZU40TCtqQ0VZN2NuRGZONW5Dck5YTWpBSEFmWFlNa1RxKytjN2Ux?=
 =?utf-8?B?aWthT1pVWEVRcGd3bkU4L1JEUllhcy9sYkZvWFF6aGJUbHZYOVM1eWdCVkNu?=
 =?utf-8?B?cUJJVUhtVmJkekdxMWNnVzhlaERBRHFGeDVLNlpYelIxeXZaR1F2WTR0Nkl4?=
 =?utf-8?B?eWg3OVRvQkpxbUZEK0Evc29BaU1acTBXM3dyUGNKT0NNUGRQSTRIQTlWNzR6?=
 =?utf-8?B?bWxycmU2eERFUDNjSWs0bWlkWXVvNDdjMnoxbG5FS2g3RE1Jd3RHc2JtZUlF?=
 =?utf-8?B?TDZISE9SdCtKYVRuajh4UGJVZ3ZGZ0JtMjNVRUxGUW4rWXZCd3FydG9KVTJu?=
 =?utf-8?B?dmVDa2xVWGQrQ1MrVW96VURuK2trcWdCcFYzSU04QVdlTGgyL3ZCVitUaUZN?=
 =?utf-8?B?ZEdLenptNnA5UFh6SzExdTFBbCs0N3NGNFNQMml0cjYxQ0NmMVN2OVRaMFUz?=
 =?utf-8?B?NDduSS9zdFdsaE41T2JpdXJvaHVzZ01oa3l2THVmSnorZW84UUpLVDM2a1k5?=
 =?utf-8?B?cG1ocXdCcWUvenJiQ0FGRGsxQjF5L3pIS1pibUdSUHBTZHNMaXpmbXJyRlBO?=
 =?utf-8?Q?VwGKYeT/DSAoKDnNkp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f66c1e-da86-49e6-08fd-08dea44f7426
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 11:23:49.4228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luAgRBfx5E6MEzTzvttpP2zyV/roYhHOtuYiFmmYaSmvafZuulqp08oHu6nej7Y8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129
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

On 4/20/26 15:37, Philip Yang wrote:
> Refactor the NUMA-aware MTYPE override for VM page table entries:
> 
> - Move the override_vm_pte_flags call from the centralized
>   amdgpu_vm_pte_update_flags() into the individual CPU and SDMA update
>   backends, enabling per-PTE MTYPE override including for scattered
>   pages (pages_addr path).
> 
> - Move APU, IP version, and direct-mapped eligibility checks from
>   runtime (gmc_v9_0_override_vm_pte_flags) to init time
>   (gmc_v9_0_set_gmc_funcs), selecting between gmc_funcs structs with
>   and without the override function pointer to avoid repeated runtime
>   checks on every PTE update.
> 
> - Guard allow_override on whether gmc_funcs->override_vm_pte_flags is
>   actually implemented.
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  | 11 ++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  9 ------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 11 ++++++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       | 35 +++++++++------------
>  7 files changed, 41 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 6ab4c1e297fc..c6d7a9e54eb3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -365,6 +365,8 @@ struct amdgpu_gmc {
>  	bool flush_tlb_needs_extra_type_0;
>  	bool flush_tlb_needs_extra_type_2;
>  	bool flush_pasid_uses_kiq;
> +
> +	bool override_pte;
>  };
>  
>  #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 63156289ae7f..532b78701bbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1163,7 +1163,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	params.pages_addr = pages_addr;
>  	params.unlocked = unlocked;
>  	params.needs_flush = flush_tlb;
> -	params.allow_override = allow_override;
> +	params.override_pte = allow_override && adev->gmc.override_pte;
>  	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
>  
>  	amdgpu_vm_eviction_lock(vm);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f33ea7f8509b..a0435468d0bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -296,10 +296,10 @@ struct amdgpu_vm_update_params {
>  	bool needs_flush;
>  
>  	/**
> -	 * @allow_override: true for memory that is not uncached: allows MTYPE
> -	 * to be overridden for NUMA local memory.
> +	 * @override_pte: true for memory that is not uncached and gmc override function is
> +	 * implemented to allow MTYPE to be overridden for NUMA local memory.
>  	 */
> -	bool allow_override;
> +	bool override_pte;
>  
>  	/**
>  	 * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> index f078db3fef79..b31ff6f56f0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -88,12 +88,21 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
>  
>  	trace_amdgpu_vm_set_ptes(pe, addr, count, incr, flags, p->immediate);
>  
> +	if (!p->pages_addr && p->override_pte)
> +		amdgpu_gmc_override_vm_pte_flags(p->adev, p->vm, addr, &flags);
> +
>  	for (i = 0; i < count; i++) {
> +		u64 oflags = flags;
> +
>  		value = p->pages_addr ?
>  			amdgpu_vm_map_gart(p->pages_addr, addr) :
>  			addr;
> +
> +		if (p->pages_addr && p->override_pte)
> +			amdgpu_gmc_override_vm_pte_flags(p->adev, p->vm, value, &oflags);
> +
>  		amdgpu_gmc_set_pte_pde(p->adev, (void *)(uintptr_t)pe,
> -				       i, value, flags);
> +				       i, value, oflags);
>  		addr += incr;
>  	}
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 31a437ce9570..883cc275f354 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -707,15 +707,6 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>  	if (level == AMDGPU_VM_PTB)
>  		amdgpu_vm_pte_update_noretry_flags(adev, &flags);
>  
> -	/* APUs mapping system memory may need different MTYPEs on different
> -	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
> -	 * to be on the same NUMA node.
> -	 */
> -	if ((flags & AMDGPU_PTE_SYSTEM) && (adev->flags & AMD_IS_APU) &&
> -	    adev->gmc.gmc_funcs->override_vm_pte_flags &&
> -	    num_possible_nodes() > 1 && !params->pages_addr && params->allow_override)
> -		amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
> -
>  	params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
>  					 flags);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 36805dcfa159..2eb64df6daa9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -257,6 +257,9 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
>  		}
>  
>  		if (!p->pages_addr) {
> +			if (p->override_pte)
> +				amdgpu_gmc_override_vm_pte_flags(p->adev, p->vm, addr, &flags);
> +
>  			/* set page commands needed */
>  			amdgpu_vm_sdma_set_ptes(p, bo, pe, addr, count,
>  						incr, flags);
> @@ -275,8 +278,14 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
>  		p->num_dw_left -= nptes * 2;
>  		pte = (uint64_t *)&(p->job->ibs->ptr[p->num_dw_left]);
>  		for (i = 0; i < nptes; ++i, addr += incr) {
> +			u64 oflags = flags;
> +
>  			pte[i] = amdgpu_vm_map_gart(p->pages_addr, addr);
> -			pte[i] |= flags;
> +
> +			if (p->override_pte)
> +				amdgpu_gmc_override_vm_pte_flags(p->adev, p->vm, pte[i], &oflags);
> +
> +			pte[i] |= oflags;
>  		}
>  
>  		amdgpu_vm_sdma_copy_ptes(p, bo, pe, nptes);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index e7b78027002b..aca7841173f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1204,21 +1204,6 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>  {
>  	int local_node, nid;
>  
> -	/* Only GFX 9.4.3 APUs associate GPUs with NUMA nodes. Local system
> -	 * memory can use more efficient MTYPEs.
> -	 */
> -	if (!(adev->flags & AMD_IS_APU) ||
> -	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 3))
> -		return;
> -
> -	/* Only direct-mapped memory allows us to determine the NUMA node from
> -	 * the DMA address.
> -	 */
> -	if (!adev->ram_is_direct_mapped) {
> -		dev_dbg_ratelimited(adev->dev, "RAM is not direct mapped\n");
> -		return;
> -	}
> -
>  	/* MTYPE_NC is the same default and can be overridden.
>  	 * MTYPE_UC will be present if the memory is extended-coherent
>  	 * and can also be overridden.
> @@ -1231,11 +1216,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>  		return;
>  	}
>  
> -	/* FIXME: Only supported on native mode for now. For carve-out, the
> -	 * NUMA affinity of the GPU/VM needs to come from the PCI info because
> -	 * memory partitions are not associated with different NUMA nodes.
> -	 */
> -	if (adev->gmc.is_app_apu && vm->mem_id >= 0) {
> +	if (vm->mem_id >= 0) {
>  		local_node = adev->gmc.mem_partitions[vm->mem_id].numa.node;
>  	} else {
>  		dev_dbg_ratelimited(adev->dev, "Only native mode APU is supported.\n");
> @@ -1344,6 +1325,20 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
>  static void gmc_v9_0_set_gmc_funcs(struct amdgpu_device *adev)
>  {
>  	adev->gmc.gmc_funcs = &gmc_v9_0_gmc_funcs;
> +
> +	/* Only GFX 9.4.3 APUs associate GPUs with NUMA nodes, local system
> +	 * memory can use more efficient MTYPEs.
> +	 *
> +	 * APUs mapping system memory may need different MTYPEs on different
> +	 * NUMA nodes.
> +	 *
> +	 * Only direct-mapped memory allows us to determine the NUMA node from
> +	 * the DMA address.
> +	 */
> +	adev->gmc.override_pte = adev->gmc.is_app_apu &&
> +				 num_possible_nodes() > 1 &&
> +				 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
> +				 adev->ram_is_direct_mapped;
>  }
>  
>  static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)

