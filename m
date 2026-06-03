Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A0CCD6E69
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 18:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 842071121F4;
	Wed,  3 Jun 2026 18:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sGQ/qOan";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012014.outbound.protection.outlook.com [52.101.48.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 439CA1121F4
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 18:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpEf4Jx3Gu5E7cGNdRETiE+fNzkzwZ1uTfJdjsQejUbhZyfCraVl1dNZWKFolGfdW4KkulunBZv39UpAZ3eAIYYIxd3L9GpAVBoL8rpdvbf5HwQEGvWpLz2h7Wn8dbb0p1DLHvprObIegdVVFzRN3tMDnBm0od4YE0+2zm3DqdIBAYZx0Qf6kjkximM5KZTlfsZ6DnjSlUlVi4xvLXwkV6YaIbFJ94jaiD2RO1sL+djMD0Wb1RuA28khxEsiWivOvTp/Zg57ktyykb6QclBWzZzM7prXr46KiIO1r2KOVlYNaEEaGpfmal3JoA/bU2zPsgQNj+rdbbL4Qqg9/6ZsXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkNE785UTHSygpa+R0THvJJWsKCueu6Zv8POMUAicq8=;
 b=g8vCmuCnIt8b9a7pVaq2ZoHZb6fkfNK6n33YjYdafqS+uKFJnIrjLFSOCFdI5RA4fAyibmsAojNgafeelETKy/6Ek/EmHxCwfn8DHLRz87jnB29iCHnvvcIV3QeXOdapILwMo6u6dnxB3xnnWk8TeQR9whPsEULc0ZndWEPFslrIypxgcs4/R2X8rv/lnMv7zb6pCsbdo/2H5gyTUgBzW0/sm2tORzLsOMe8nFcNHzalBmNH6BJ9w/IHsFguxT3sBhA1ywtcu3Rj3xHGQiTgbNrIEaQ6noC9+cgTNitP8iLW/x58KmX5GpmrnPn8UvMq4p1ohMhTyxcPVJyPVivwEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkNE785UTHSygpa+R0THvJJWsKCueu6Zv8POMUAicq8=;
 b=sGQ/qOanRWiTxdnr0itoKaMnxQC4K8c0HNhaaihouXK2oBtDnKOT/iMr7OPyWGiFb1po+yfCkYgrwPvejvrnwokE2QyAKyRtsWBvYKmRl4zdzQPJ8HLN+BuGXX6L10IqMeo2T3hQkGR+4JxIynmsrHrFh4J1WGlCbXxj6JfzDp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9612.namprd12.prod.outlook.com (2603:10b6:8:278::5) by
 CY8PR12MB7123.namprd12.prod.outlook.com (2603:10b6:930:60::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Wed, 3 Jun 2026 18:00:15 +0000
Received: from DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c]) by DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 18:00:15 +0000
Message-ID: <1390834f-6a8c-415a-8f02-08c51738b5a8@amd.com>
Date: Wed, 3 Jun 2026 14:00:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] drm/amdgpu: nuke most amdgpu_vm_eviction_(try)lock
 uses
To: christian.koenig@amd.com, natalie.vock@gmx.de, honghuan@amd.com,
 Alexander.Deucher@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260529114031.3714-1-christian.koenig@amd.com>
 <20260529114031.3714-12-christian.koenig@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260529114031.3714-12-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0147.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::19) To DS4PR12MB9612.namprd12.prod.outlook.com
 (2603:10b6:8:278::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9612:EE_|CY8PR12MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 797d5960-134a-4678-3302-08dec199f6eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 1/QpxrTZgtTVLH64u3CbJC9VXH1tPON2EWjXStvoFz+tYSEzE8y6lv90db6NVjVswkF/W7WcscnL/WwD4QaxPo9O5ym5CbGHPNYIQcTgcjSM+sEkIXNIou8swFcYuCRBdZ+0HLEdyS82RhAHIFCd0Aa0/Im5i/ATk1ilpRVn8P0fT1juzEMMcXPvgQE3JNbgMjEtmI8RZ2KWJ3QJlLyzbTRsP4wX0QaXLnxUeooiu/myEFcOKpj52TR4QJ/PzTx1akIHAlqEvj8JC2kzUphX6M0amFHDRUDiPch+Jwn1KjcSpSxCHoKg3Ov9fMuTuduvsJdrBJnzEgWv3Jz4FyBxgVeWAfjPbVBDNVKxC7Fe9I8qWAn3uVDABMYjMiwlTMPh4EUg20aTz0OxxferkGZPM4poQZsfKIqNdJ2bsZH9+ZwehvQDSp4SwKI/jsdUXXDg4IyPhRbTAZwN1MIqi4oRO5z5ddNHlsF58K79+f/1CnhGSIygakmHPZQyXwKTPk8mSwCLjocwu2K1QqHVeQk/uRgh90DaHQo7VefK9Fla+DcwOX2tq3zix7nFcfe/qNL6jX1toGHe/Lke8Yx0VpmsXW7FbQwUqcLzBN2T8ErAyRTB6FDt26pJxn84H+IOChjdVL2UVzKDV226NmdkM0AH2CYdBUqT7mughP5gA3ey1jr/PW4BK7WAfuoAVXTiwQKR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR12MB9612.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWdpZlFxSld3VHhOaEYwcHJTQS9xaWVEOHRDbENCeC9DMEgrVWlxQUY1MHJo?=
 =?utf-8?B?ejBnT0RBNEpGV1QxWW9ORFRYUXBKb2U5T2hXS1FreElRdFFRYlBqVlRQSE8r?=
 =?utf-8?B?eGtxWHJsRVB4Yi9MajBPanQzNXd5YjBWTDVXUFdPRFl0aGlUQ0hwWTNQQXVB?=
 =?utf-8?B?UVFyNTFTM3ZaMG9xRkYrSlQxQUVnMmVsdTY1UDVDVEllUVpxRXJZUm9laVdF?=
 =?utf-8?B?c2lieUVsSlBDTmZ3VlNhUmxRQmhhSDRQcjk0ckhGeThpYlRKSjBUbFVBaWJY?=
 =?utf-8?B?cWhqUXpZc0NHZWZWZzFkcGxEc1JoaFVYTW9zMXZLbFdydWFNNzVOZjhncVNj?=
 =?utf-8?B?aVF2U0VJb1N4TXlrQ3d0Y0luVDlQQzlpR3l5Njl2Y3ZpNUxBdGlMNVhoTWJp?=
 =?utf-8?B?MmhCVjRLTkQ2anJFbjRVWlhuVUNTVnovRzluK0Jvd2JTbGVvV2RISjBJNjcv?=
 =?utf-8?B?RE1INmtRZTlUbXVKM0lHU2RXYmUxa2Q4SUdDWEFHMDN4WitZWk9va0JORmhQ?=
 =?utf-8?B?VEhjeENnMzNLaGZoK0c4aVdWdVZyKzgrNUdTWjJydm5UV3htTUx3a2YvZ29R?=
 =?utf-8?B?aEplZkFiMUdMMHNLL2VxbkF3V3kwcGY3NVZaMlIzbDZndTFJVzhRdVhmU01E?=
 =?utf-8?B?T3lrbHNhU2k3TGtqUk52OXhtTm12MG5VRS9YTURmUG9oVnUvTjlXZG9CM1hr?=
 =?utf-8?B?bkovTDBFUUtteDRmL0R4dWw4VkVQL2RwM24zcXRXbnl6QUF2QWVjN2I5cTVn?=
 =?utf-8?B?cEdqN0ZMZ0R1bUgwd25BQnhrcWVSTnB6RHh2d0pXb3dReTF4TklOQm9COHh4?=
 =?utf-8?B?S0Zsc0MzUExqTFBXK01Bc29MMVNmaHBxVmtjeTlhY0V6eGdDSWNxeDRjYWZu?=
 =?utf-8?B?UHowWng1bEk5OGxWRHBSU0tRdVo1T0hsQk5OdWQrNlJKZVVJNGdMaXdCaEQz?=
 =?utf-8?B?LzcvWUhvdkx0cWg4Z1QvNDAvdzNwSGlTUFBPTk5iQnRTQjh1Vnl0RjFWczh4?=
 =?utf-8?B?K1VvRHk4bDBYenRPNTRyNWRuQUNvR1FYVU5ZbzhLczRPL2x2amwzQmtJSFZz?=
 =?utf-8?B?dng0Z0pzMCtWL0JmZ0RpZmFKczFsdUdPMVB5NGNKSnh1bWZhdzNDSTQ3bWUv?=
 =?utf-8?B?TnAzYk0yQU0wYThsSzVhbFM0dVF1WWk1UnlKNU9hTGdBME4wYVBSdnptc0RL?=
 =?utf-8?B?QzRQK2tBWm5UMDNWSkNoNjFSa0tFZllESU5DR2hXN1ZyS2JaS0cxaCtxVllW?=
 =?utf-8?B?UU91OXloZFgzRFRuMEpEdk5CMHl1UUtFdnF0VWVFL0I5NDQzTkI2anY4T3R4?=
 =?utf-8?B?WUxYYXFNdFpyZkxBSW52dVVaMWQ3Qzl5ZERNeXJaN1Rla3VkcnZhcEhqQW1j?=
 =?utf-8?B?VnowOERTUVZZQzJLSFdpNlQ4WGxVSDRlSHc5Q292Q3NxMHZJb2pRWk1yQklH?=
 =?utf-8?B?UURZZ0NwUXcxSWYwQTVQeGFlTlBQREswSG1VcnloWGdpY0xraHI2c2FOTzU0?=
 =?utf-8?B?ZWtyZmhvOWVIV2JOZVh3V0U3eTZjUXAzWFhKV3ltbVQ2Um9OOTl3UllYWm54?=
 =?utf-8?B?VlQralRzTjB0Y2ZBSldxK2RET0xPaXZMb2R5QnorME02blE0eWJnaE5tMVJH?=
 =?utf-8?B?SjlGNXdxR1VkSkVRdG95VkFUSkVUOHA5Rm4vcWJZaEQ0Nk50aFNYcGNsbkFO?=
 =?utf-8?B?akpGei9IS0J2MTN5MVFtbW1XOVl2QURuS05CVnJOaVZBWWo5OVpZamlHOTRu?=
 =?utf-8?B?VHAxZmI0OEFQR2N2emRqd24ya3lISVNDYnVlTnJvTjQzV2VlaEhnRE54UHkv?=
 =?utf-8?B?ajhhZENJdTRLQTMyOGQ3VCt6R2ZYQ0FQb0d4Yzdjd3JDM3RuZUJDdUZLK1ZE?=
 =?utf-8?B?Q3RSaVhOYUlmMjB5ODFCVlk4V05yNm9WMENEK2tHOUZ2cGtzdzQ4YXNidXIw?=
 =?utf-8?B?UFlvVzU3eWdKZHhueW1FSU0yMWdVdGc4eFE2VWhuYkJTemluajBnbmFSdjVY?=
 =?utf-8?B?NW80NFIvSUN4NHZOVXkyVnZBaFpvMXlqcFdGMU50NHUyOGNLeDk2YXVMeTVT?=
 =?utf-8?B?R1FYVm54RkhOSzVWNjNjNHBLRWJzUHM3N1V5bk0ya004eTFWemN1UmdYK2JS?=
 =?utf-8?B?anVLajFGR2g2Z1J3MEFRRzgvZFFPUGRZK0RYeGNTK1FFQXcrKzFVVG0rTVJk?=
 =?utf-8?B?V0NsNWZMTGlGVkZJZEFwUmtCY1AzSlFEd1FvVUFJTkJrSXByMWFqM1pNTG5n?=
 =?utf-8?B?OEtCMVE2d0pmc1h6RmxGekhwSDVFSzhNZDE0VUZOODRhd2VOcC9BWkFGVFM5?=
 =?utf-8?B?V0RuMVQ0d2pFZkd5a3Nuelphc0dDT09OSDA4Y0EwUUFJc0xSWTRXZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797d5960-134a-4678-3302-08dec199f6eb
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9612.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 18:00:15.1980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANrpwcCFV0GxWuTwboYhFOJjhut5OkxlrX9V+FVRedejvhQSQ8qcj2HOUWA4xTyXCp1mlP39Fz7Mi0k5ivhP0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7123
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


On 2026-05-29 07:24, Christian König wrote:
> Use scoped_guard/scoped_cond_guard instead.
>
> Saving and restoring the GFP flags is not necessary in those use case.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 29 +++++++++----------
>   .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |  9 ------
>   2 files changed, 13 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index f81ddc6873a0..3ac083c9f77e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -616,9 +616,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	 * As soon as all page tables are in place we can start updating them
>   	 * again.
>   	 */
> -	amdgpu_vm_eviction_lock(vm);
> -	vm->evicting = false;
> -	amdgpu_vm_eviction_unlock(vm);
> +	scoped_guard(mutex, &vm->eviction_lock)
> +		vm->evicting = false;
>   
>   	list_for_each_entry_safe(bo_base, tmp, &vm->always_valid.evicted,
>   				 vm_status) {
> @@ -676,9 +675,8 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>   
>   	amdgpu_vm_assert_locked(vm);
>   
> -	amdgpu_vm_eviction_lock(vm);
> -	ret = !vm->evicting;
> -	amdgpu_vm_eviction_unlock(vm);
> +	scoped_guard(mutex, &vm->eviction_lock)
> +		ret = !vm->evicting;
>   
>   	ret &= list_empty(&vm->kernel.evicted);
>   
> @@ -2308,9 +2306,10 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>   bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
>   {
>   	struct amdgpu_vm_bo_base *bo_base = bo->vm_bo;
> +	struct amdgpu_vm *vm;
>   
>   	/* Page tables of a destroyed VM can go away immediately */
> -	if (!bo_base || !bo_base->vm)
> +	if (bo_base || !bo_base->vm)

This is either a mistake or a deliberate logic fix that would justify a 
separate patch.

Regards,
   Felix


>   		return true;
>   
>   	/* Don't evict VM page tables while they are busy */
> @@ -2318,17 +2317,15 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
>   		return false;
>   
>   	/* Try to block ongoing updates */
> -	if (!amdgpu_vm_eviction_trylock(bo_base->vm))
> -		return false;
> +	vm = bo_base->vm;
> +	scoped_cond_guard(mutex_try, return false, &vm->eviction_lock) {
>   
> -	/* Don't evict VM page tables while they are updated */
> -	if (!dma_fence_is_signaled(bo_base->vm->last_unlocked)) {
> -		amdgpu_vm_eviction_unlock(bo_base->vm);
> -		return false;
> -	}
> +		/* Don't evict VM page tables while they are updated */
> +		if (!dma_fence_is_signaled(vm->last_unlocked))
> +			return false;
>   
> -	bo_base->vm->evicting = true;
> -	amdgpu_vm_eviction_unlock(bo_base->vm);
> +		vm->evicting = true;
> +	}
>   	return true;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> index 16710017e8ca..7276d987e9a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> @@ -141,15 +141,6 @@ static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
>   	vm->saved_flags = memalloc_noreclaim_save();
>   }
>   
> -static inline bool amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
> -{
> -	if (mutex_trylock(&vm->eviction_lock)) {
> -		vm->saved_flags = memalloc_noreclaim_save();
> -		return true;
> -	}
> -	return false;
> -}
> -
>   static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
>   {
>   	memalloc_noreclaim_restore(vm->saved_flags);
