Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4F3C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 08:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C68E010EBF9;
	Tue,  7 Jul 2026 08:34:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m7dOwu6f";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6F4C10EBF9
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 08:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcTt6FjwDlAoIRc3oW/uOcs1vfdKafWoMHUOXlQS5gsXDRuuxLHfwNBXMp5kcvRSf2V1/ZnH7ig6dC4UA5wwnHUyPEQeVRyxUK9WIwi2E0awTEZRNJxMfxlIZIw32h0YdhevzU6SsruZf5iJJvVTqlY5oJ2/hg5vKMkGTVRX2KmbhXippB94aZ7Ibqs/XEup0d3BnO43bcwxJYrT3YCj+oLLHKg73N/n3R2pzSohsziwsOLb1w5F4vdQ4aAy2FDP4J20AdaZU8Pvap/Ji2YL5IQ32gBg4eU7evWf2ucNCFx9bh0v4TgZ+45cA+k144dgmzUO2UKVvJfZeVEIerZWUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BagNfYDTa1AyKdnpbaG+T30NdTGxFmSqPEG+0nJ7FfI=;
 b=g+AZTSHFBsFTBPK7fVdPzrICUmdOdwSWUePKx2MERNSas7TkXw9zGk3oPeCBX33xL1dMVlXPGUVINCXVkBTEqOZEjOD7q5UShk9jZByqZkRF2zIbHKreW4PSkrseEGm9bnWvfOVwMW54uT+KfUlQ2KEyjQdxibAql8dAxEW7c6N9R9LYWqokbbiR5L/vJ9nKX5yTh9zsAxxIenllnZRqNxm/MKuC2LnLQlTs1CXf9+TWpNoH8HLaVGGU6ekbuOENXo5eDWYUg7vZWgH2L4tY8R8xNAB0RGNJL12tqiSq/bwnnni0ChCP5PGb20lW1uga8JRddgwd5EgLkUTt9fZKlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BagNfYDTa1AyKdnpbaG+T30NdTGxFmSqPEG+0nJ7FfI=;
 b=m7dOwu6fiavaHIl+beidXTT7IvhnIdiWbGbTZRYGUw4C5hZFe/V9Ze4KMKlvJJf/aP94+ejlOwOGW8ZBUYeuEho7vgGE/zyFd/dZAU8kDvfyT+5FE0qspziohY97uB/pYvZo3LqCmeHaqyhLxAl5z7VFpSQ4U8/TMYwPYxeUJlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by SA1PR12MB999086.namprd12.prod.outlook.com (2603:10b6:806:49f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 7 Jul
 2026 08:34:49 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 08:34:49 +0000
Message-ID: <55819ad4-f2fa-46e7-886c-146d2d199cc4@amd.com>
Date: Tue, 7 Jul 2026 16:34:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] drm/amdgpu: rework eviction lock handling into
 critical section
To: christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, natalie.vock@gmx.de,
 Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Philip.Yang@amd.com,
 timur.kristof@gmail.com, Huang Rui <Ray.Huang@amd.com>, honghuan@amd.com
References: <20260529114031.3714-1-christian.koenig@amd.com>
 <20260529114031.3714-13-christian.koenig@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <20260529114031.3714-13-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|SA1PR12MB999086:EE_
X-MS-Office365-Filtering-Correlation-Id: cf324610-7c8d-42b2-b80d-08dedc029bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|4143699003|22082099003|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: fZ1wl/0phL6KkwyRbmIonwtIQhQyBiaUZl+R3mtcXiqfY1rnewrmpKHH3spr4THnfEAJh7WxS/ua98yAY9pEPvuH6d9Jc3yxXGnuCx8vccYBpXDyR1urEYjVdRJ0pisgMH8jOuvZba12qPnJIz76C+XXR8mYo7jbKQc8DoPZvbYl4AMpYu6ycpGVXMtL2BvVSXNjRGe9EFIrRWEaLwBc99eYpOAgYhoYlm6SDsiCiA1eNCaF0pOnvIiXkTPdjiFLyA1utNIYCRdhl7VtDdkky25Ok1OV1clkfzpEoEClLmp3OQEt4PVVEfHLkz+iz82urJNLkD64+VNvxTYB8Jh7cuYutfYiUFVCRE8pD5eJpAinp9D00U6KtWzHqUGl+uYCcLkLN7WhudulmZDKMKl2YOypmLymv1LeyMV5u+7CBxflbLSWt3wtUgLs7Ao4PHcs9OI4dCCwN7EXXibC7OuxfxPXgrHbndytjhbyRgd+OmAlPJyNkGOhzih/mkNtOOkuA8F7TDTZGzJQYxJxSHob7yAgOgDIK8YyaH1B0AImNyg+VL5JStWRvq4hEK8hbFFdeeUZypGcrLb0mJwSNjqc6tq+IpFC6wDzk+6ExoLjQzOU763gIDBPlgFQuoGmIzeOliqyXSrdcASsBY7AvtTYXdS1n3Wehrq1knFU8eMlIFw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm9pUE5LV0NsV1ptYW5FL0JQU0t3QlVDd3Fzdnpxb0tuYVFXQUJqTDJKVDJs?=
 =?utf-8?B?bm5XcUlpQml1TEJ6cUQ0WnhuNTZNSWdXaVNwSTVSUllmTHRyajJiR3UrVm1V?=
 =?utf-8?B?UTI4TlNLbEZqSlNCcVJiNmJqTjB0bngzdXJmUWI3OG5UdzQrYysxWmxjWnZ5?=
 =?utf-8?B?Tzg5NXd0YjR0M1d3L2hFNkR1REc3MVZnMXJsUnBoMlJhL3ZINC90d0tpQlJ3?=
 =?utf-8?B?TkRNK2lOeVZhaklGSWNCemFxbDFUYXdqVGxtZTFJL3lxNU9mZjEvT3F0OU5R?=
 =?utf-8?B?YXVBTHdDcGdJckVuOWRWYXUyVmVMVUVmR3ZxV3NSNnR2U0xySnlqOEpCdVVw?=
 =?utf-8?B?ajhwNVRFK3RvSVhhRTRjWWpsM3BEWTExemRwODluREhwNlA5eTkvRXFJZ3pC?=
 =?utf-8?B?NDRqSkx4dk5XSG1FemY2RU9COWxTTVgrSktPb3dUKzc3N1doRUNkOWRwQjZk?=
 =?utf-8?B?ck5uY0RkTG85UlVNbllNVzAxR21YbDV6ZzZwSFlBMUJkNHVoVC9aNjVFQVB6?=
 =?utf-8?B?V21tSkFTNHowWG4rcFVMSXQ4bnNrUkdmZlFxUDZGTHdwS0hJYTdMdTBES2hI?=
 =?utf-8?B?N2FmMlNJaloxaVMyWkYwcENISlo1OHdpUjM3V0VCNUUwVzZCeEpqUHBNU1Bx?=
 =?utf-8?B?VzVEV3R5NUFGc1hhOEttOEhTTGNUdGtSaVZRdm90cU9YdkhsK0FVRzdHTTlM?=
 =?utf-8?B?S1lPM2pLbngvckZCVitjbkI3V3lXR0prNzdKeCtjN2lvc0FqdFBxMWNOanlC?=
 =?utf-8?B?azhSTXBENjBIc29pK2pNU0MvTjNzbTdrRW8wVnBkY0FjNFlwZkJ5V1hpeHgw?=
 =?utf-8?B?ajNhNEd0Wjhhbm41dUFUUWxBZGNsSGYvNzUrajFUUWtBMWRrbU9XdGFSdThO?=
 =?utf-8?B?ZXV5Ni9uUUd1TkIzQ2VSNFpLc3J2andZbVdkNnVNS0xKSmNHOEhBdmJ3K2t2?=
 =?utf-8?B?ZzJGeG4rSHhYMEhKOFRlY04vR0g5OXBHYVpCcjdYT2Z3c2lHZ3BhU2JGM0F2?=
 =?utf-8?B?SGJ3LzFwVDRCYmVJajEwZGlMMnZENlJON0psdG1XRjlHUEQvSDR1eTNvRmt0?=
 =?utf-8?B?N3JhcnZ6VTdzSVduZnp1WDI1cGZOWTdTRGpvaVYyL3QzdC9FT3VFRGhBbmRC?=
 =?utf-8?B?VVhiV0dwSS9tNUVHWEpiWHpYcjYxaWVnRERMNG9hRjd0TEFOc0xtTWlsVm41?=
 =?utf-8?B?b2hrYkQ5NlFsUEE5TkJWODlkaHdMaUQ0ZTZGQjg1VVF2dGdRZ0dDRTVzQklF?=
 =?utf-8?B?K3JYQzVkYWNPODlwKzQ4dS9MUlZ2azhtRGdsZ2V2Yk1GUHF2U0NIU1lnTEF6?=
 =?utf-8?B?Q28wUG9NTElDaWpyTml5UmtuMFd2VThvSVNkc2FCRHgxMkdMSXMxdHgreE9v?=
 =?utf-8?B?S2JuUyt5cEhDb3FMZktHYS9TMWhxdUtVaVFCcGlkODEzdmVNWHhUWDRSbVFN?=
 =?utf-8?B?M2xjdnRMZkxoUFBhYWwwTXBIbkpLcmRuc3BvbTJCLzVPMUJzeUdFZUpmckpG?=
 =?utf-8?B?VSs3MTg2MEhMalBwV09jRmRCZnFQSXVHMUFBYjgzUTFZZkhGU05hSTV2cHhG?=
 =?utf-8?B?eWNmT1dhQmtWR3ZwbXlaOTJ0UnlhNFNXOEZJSFFpVVhWaDdNcUxXMDFHSUFX?=
 =?utf-8?B?ODhhcGpUV1YrRkRVaXRVTDJCRWFZaGFybG5lU3lQaHVtZVB4RytobTBTS2w5?=
 =?utf-8?B?d21NSndhNDh2WGROTUhOTVN0VXJ0Sm12bkpIejJLdU54dk5vSjRJKzIvdC9C?=
 =?utf-8?B?RVdkTlhSUjhYSWZCb0dadS82Rnl3cUttczZFQ3JDZDFHQ0tQQ2xoUzhHT2Mx?=
 =?utf-8?B?dWdrMXdlMEZvZjNSckV2WnpqdWZ2SzYxTjRMWnpIeDBmWUNtU3RTUG9hNENI?=
 =?utf-8?B?dGlIT2tHaE1aUSs4SW5rMG1OMUZ5TG5PTGcwVllEK2I2SHdvU0ZLZXd0UXJZ?=
 =?utf-8?B?elN6Q0xYcTd3MXR4NFFNYXE4eTFJdE1iOWN3MnZlcTRFd3JwR0llVTNGOElX?=
 =?utf-8?B?dWFhYXlyNmNUMExlcjJVcUVXcjRMYmdQQitRMkRDRG9KQXJTd01KZys1YVFw?=
 =?utf-8?B?SVR5OGFSNTVZVldpcHNEL3h4aFBNVGVBNjErSVlRY3ZBTTF4UW5ubVVRQk1G?=
 =?utf-8?B?OENuVnJsdEFIY3lLWFJYRVhrUElKOU5wK1dGSVBpc1dzbmpXU0JKcTJsY3c3?=
 =?utf-8?B?Y3VucEc1N0FMaFd6WUdldU9rWENxZHphOHU5L09RSmJ1My9oWnRrQndsY3p3?=
 =?utf-8?B?aS9PTWVBblNUUEg1K2NmckExeUt4czRsM0FMTGI3WUtJQlVEVEswTnFFdXRn?=
 =?utf-8?Q?dBgSoZYni+k/BFolLk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf324610-7c8d-42b2-b80d-08dedc029bbe
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:34:49.6269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7dWnt54YmHhoa/hWgB68xO06/hYuYSkyPr2WiLJVi/D4PF8QDUjpJVUc+qeIg0QgaFfn3wDAJM8x63+94ivUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999086
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
> Taking the eviction lock is actually just one step which we need to do
> in the critical section handling.
> 
> Rename the functions to reflect that, use the update parameters instead of the
> vm to save the GFP flags.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 34 ++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  1 -
>   .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   | 41 ++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 28 ++++++-------
>   4 files changed, 58 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3ac083c9f77e..d4e207db83c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1143,11 +1143,9 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	params.override_pte = allow_override && adev->gmc.override_pte;
>   	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
>   
> -	amdgpu_vm_eviction_lock(vm);
> -	if (vm->evicting) {
> -		r = -EBUSY;
> +	r = amdgpu_vm_begin_critical(&params);
> +	if (r)
>   		goto error_free;
> -	}
>   
>   	if (!dma_fence_is_signaled(vm->last_unlocked)) {
>   		struct dma_fence *tmp = dma_fence_get_stub();
> @@ -1229,7 +1227,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   error_free:
>   	kfree(tlb_cb);
> -	amdgpu_vm_eviction_unlock(vm);
> +	amdgpu_vm_end_critical(&params);
>   	drm_dev_exit(idx);
>   	return r;
>   }
> @@ -1277,11 +1275,9 @@ int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	params.unlocked = true;
>   	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
>   
> -	amdgpu_vm_eviction_lock(vm);
> -	if (vm->evicting) {
> -		r = -EBUSY;
> +	r = amdgpu_vm_begin_critical(&params);
> +	if (r)
>   		goto error_free;
> -	}
>   
>   	r = vm->update_funcs->prepare(&params, sync,
>   				      AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE);
> @@ -1300,7 +1296,7 @@ int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   error_free:
>   	kfree(tlb_cb);
> -	amdgpu_vm_eviction_unlock(vm);
> +	amdgpu_vm_end_critical(&params);
>   	drm_dev_exit(idx);
>   	return r;
>   }
> @@ -3113,30 +3109,26 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   		goto error_unlock;
>   	}
>   
> -	amdgpu_vm_eviction_lock(vm);
> -	if (vm->evicting) {
> -		r = -EBUSY;
> -		goto error_dev_exit;
> -	}
> -
>   	memset(&params, 0, sizeof(params));
>   	params.adev = adev;
>   	params.vm = vm;
>   	params.immediate = true;
>   	params.pages_addr = NULL;
>   
> +	r = amdgpu_vm_begin_critical(&params);
> +	if (r)
> +		goto error_end_critical;
> +
>   	r = dma_resv_reserve_fences(root->tbo.base.resv, 1);
>   	if (r) {
>   		pr_debug("failed %d to reserve fence slot\n", r);
> -		goto error_eviction_lock;
> +		goto error_end_critical;
>   	}
>   
>   	amdgpu_vm_update_leaves(&params, addr, addr, value, flags);
>   
> -error_eviction_lock:
> -	amdgpu_vm_eviction_unlock(vm);
> -
> -error_dev_exit:
> +error_end_critical:
> +	amdgpu_vm_end_critical(&params);
>   	drm_dev_exit(idx);
>   
>   error_unlock:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 21c78b18f4df..7db3c3577949 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -286,7 +286,6 @@ struct amdgpu_vm {
>   	 */
>   	struct mutex		eviction_lock;
>   	bool			evicting;
> -	unsigned int		saved_flags;
>   
>   	/* Memory statistics for this vm, protected by stats_lock */
>   	spinlock_t		stats_lock;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> index 7276d987e9a6..29c74920f3b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> @@ -93,6 +93,11 @@ struct amdgpu_vm_update_params {
>   	 */
>   	bool override_pte;
>   
> +	/**
> +	 * @saved_flags: Saved flags for GFP reduction.
> +	 */
> +	unsigned int saved_flags;
> +
>   	/**
>   	 * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
>   	 */
> @@ -130,21 +135,37 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>   
>   int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   
> -/*
> - * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
> - * happens while holding this lock anywhere to prevent deadlocks when
> - * an MMU notifier runs in reclaim-FS context.
> +/**
> + * amdgpu_vm_begin_critical - start the critical section of the update
> + * @p: The update parameters
> + *
> + * Serialize all updates, check parameters and make sure that memory allocations
> + * don't enter the reclaim path so that we don't deadlock with MMU notifiers.
> + *
> + * Returns:
> + *
> + * 0 on success or a negative error code on failure.
> + * Even on error amdgpu_vm_end_critical() must still be called to clean up!
>    */
> -static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
> +static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
>   {
> -	mutex_lock(&vm->eviction_lock);
> -	vm->saved_flags = memalloc_noreclaim_save();
> +	mutex_lock(&p->vm->eviction_lock);
> +	p->saved_flags = memalloc_noreclaim_save();
> +	if (p->vm->evicting)
> +		return -EBUSY;
> +	return 0;
>   }
>   
> -static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
> +/**
> + * amdgpu_vm_end_critical - end the critical section of the update
> + * @p: The update parameters
> + *
> + * Restore the GFP flags and drop the lock.
> + */
> +static inline void amdgpu_vm_end_critical(struct amdgpu_vm_update_params *p)
>   {
> -	memalloc_noreclaim_restore(vm->saved_flags);
> -	mutex_unlock(&vm->eviction_lock);
> +	memalloc_noreclaim_restore(p->saved_flags);
> +	mutex_unlock(&p->vm->eviction_lock);
>   }
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 6026d6f27842..cf1697374416 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -478,42 +478,42 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   /**
>    * amdgpu_vm_pt_alloc - Allocate a specific page table
>    *
> - * @adev: amdgpu_device pointer
> - * @vm: VM to allocate page tables for
> + * @p: see amdgpu_vm_update_params definition
>    * @cursor: Which page table to allocate
>    *
>    * Make sure a specific page table or directory is allocated.
>    *
>    * Returns:
> - * 1 if page table needed to be allocated, 0 if page table was already
> - * allocated, negative errno if an error occurred.
> + *
> + * 0 on success or a negative error code on failure.
>    */
> -static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
> -			      struct amdgpu_vm *vm,
> +static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
>   			      struct amdgpu_vm_pt_cursor *cursor)
>   {
>   	struct amdgpu_vm_bo_base *entry = cursor->entry;
>   	struct amdgpu_bo *pt_bo;
>   	struct amdgpu_bo_vm *pt;
> -	int r;
> +	int r, r2;
>   
>   	if (entry->bo)
>   		return 0;
>   
> -	amdgpu_vm_eviction_unlock(vm);
> -	r = amdgpu_vm_pt_create(adev, vm, cursor->level, &pt,
> -				vm->root.bo->xcp_id);
> -	amdgpu_vm_eviction_lock(vm);
> +	amdgpu_vm_end_critical(p);
> +	r = amdgpu_vm_pt_create(p->adev, p->vm, cursor->level, &pt,
> +				p->vm->root.bo->xcp_id);
> +	r2 = amdgpu_vm_begin_critical(p);
>   	if (r)
>   		return r;
> +	if (r2)
> +		return r2;

Maybe need:

	if (r2) {
		pt_bo = &pt->bo;
		amdgpu_bo_unref(&pt_bo);
		return r2;
	}

>   
>   	/* Keep a reference to the root directory to avoid
>   	 * freeing them up in the wrong order.
>   	 */
>   	pt_bo = &pt->bo;
>   	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
> -	amdgpu_vm_bo_base_init(entry, vm, pt_bo);
> -	r = amdgpu_vm_pt_clear(adev, vm, pt);
> +	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
> +	r = amdgpu_vm_pt_clear(p->adev, p->vm, pt);
>   	if (r)
>   		goto error_free_pt;
>   
> @@ -802,7 +802,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   		/* make sure that the page tables covering the
>   		 * address range are actually allocated
>   		 */
> -		r = amdgpu_vm_pt_alloc(params->adev, params->vm, &cursor);
> +		r = amdgpu_vm_pt_alloc(params, &cursor);
>   		if (r)
>   			return r;
>   

