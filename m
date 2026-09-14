Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86AFC88E64
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 08:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5495E10EBE0;
	Mon, 14 Sep 2026 08:04:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ci96wyFb";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25E5210EBE0
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 08:04:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrRP/STriZxbKB0VyDZub53nRVCyW4hf5ILT6WmC7RQ3/P28iH3cdMCItl4Z3CfeCpZ22HllbVnZqAq6BxehOpFAvr6Xu88u8Bhehg2iQeTB/miRL4MxGfyinzJrFin8f0nnB/aWQEA8OblBytEiHEgG9sZS1s6Da/CiT5CbWUIfsRW/cNou/J/I3R2OO2GLY2APBvv414RnpHE/t5I6f8dBm9Qp/Z/3CWLvtKujvIZ/ym+9XoOb3F4QvLXqw8ItGab8tfT9Uh4y1WX3fAPlLwrtfCgRY4xVJyRC2PGzv9RJmFhHzL31YBcGhWyLl/V4HhPufsYlbKE24sUnoWR0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPh1vsmw9F2c91Wl2Z4Nlf5SVvCADaPXPeD942qMuWo=;
 b=PZr4oWrLkZOkONnw5PdXhxX+Zu1kiZQAmkU3W/MdbmwDq8w2RD74Y13/JXVkng69BYXP6N31HTRXiYtsAaVwiPbnzN4DftbU3B6fB1222E/wu1N5wlpyROyonFdS9YkWsLiv8s3r1TXnNoI9pqz8EsI5LNsf+3XhK3B+NrMshGOgGcIYt4pfbtktO47q6vo6IdUwKK9jTurtEyj8NeTbP65rjdGHwW7fKh6SVaaVlQPvxeSqZgDSwmGNtHQIB01jlOoJqdQG3w4FU3Vv9Wo5q+9A4RzMveo1HuTsLlVSusUiCbvplI/23HhMGG5Bf8D3tByCPwefq+qA6Vafc5eVsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPh1vsmw9F2c91Wl2Z4Nlf5SVvCADaPXPeD942qMuWo=;
 b=Ci96wyFbd4v3McNECOa/s6BP+AJge/kS6WPvgO3kCp1KX/Saa10SmuYHF/xewW37L73hyIc6Bq9BeCI3cXGbLTJdhPduI/El4cEhgV95e+n4e3N9zWRhF7x0cDv6hIhkKITP3roMmQZ9qp/SQtVJLaCnfhUPjjw/O4XMlDaUlFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 08:04:44 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 08:04:43 +0000
Message-ID: <3d040b4b-a9f7-4819-91e8-5caa204f57f0@amd.com>
Date: Mon, 14 Sep 2026 16:04:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: nuke most amdgpu_vm_eviction_(try)lock
 uses
To: Junhua Shen <Junhua.Shen@amd.com>, Yu.Huang@amd.com
References: <20260911164801.50175-1-christian.koenig@amd.com>
Content-Language: en-US
Cc: christian.koenig@amd.com, Honglei1.Huang@amd.com,
 timur.kristof@gmail.com, natalie.vock@gmx.de, amd-gfx@lists.freedesktop.org,
 Huang Rui <Ray.Huang@amd.com>
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <20260911164801.50175-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0008.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::20) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e778046-8e48-4a73-d171-08df1236d5dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: isL4hcX9FiM9GGYHK0KlMcAAhPJYhjOouUL8rjToxXi/WT/FViffPP8FsXfejQ7K6a+3wD34MmhOtuUIKkhsjo2Uh77Q2iQP7T4RJ5OF2gd0cXjJGTk7PhfzH28QqY/EhYfyigjmmhvhAbPJWwbOT1SFmBLTkgxbEiXyr2owuqBH78ZR24NCaGBUSaLE5LggSh79av4dq2NlR2vXAuJl19wp75Yz9H3Ys3rxOf2xPENGDSmZQiG1rUAzSe7AT2/NLzLwubwfM0yIH6QG2ii49txYFt1sy9HTUQf0Xzs/ZI9xSgbAngFvTwLllIjYXI2LY4u+tmFdsD/RuAKjF/49Cvs+qAu/yS1MbnDTomLSlaTxyYWY5NBTGJUEsGJsmV00SSSGnMSGQEZxC/P+C2NTqt6owzq9RpOdPbs4N60ws5Wv9McrKsQcGB6Gck22/K6IIXtzvjSf1xJqKXahg+k4XvtcpF8UBscZXaMCsBcBTTug3DJYithunl5x0MdhnrtLMlcb+rGSIfhchmVakdcbbT/zghHgsRsaEU7K3NU/omTQVte5mjsM6pNTTbTlhtnThqgk9XESzA0vkEUZAV6lTEKukcFt0Wm8h7fYTpqKFQefcIOrJN0/qWfMmphOZPGqI6WnDU6/7GeoFwR2moCmKJx6Y6tD38Xds1MhYMMPC2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVhjMFpobDFoV3lLZ08zcUwyNzd0MG9yME5PY0NYSmRBeEJiNlh0UTlZRFZX?=
 =?utf-8?B?N0R6SlJLZmhvQnRoVVlDUjFZVk9hTFV4bUtieDI2cFZERVlaWURNTVdPd1ky?=
 =?utf-8?B?cGNZbnpPaHNEWWZZYlJTMmx6bG1Bc2NMblhQQ0pDSG9zS3ZwNFdaU004eGE0?=
 =?utf-8?B?UXlGNVZPM0M4cnJjejFlUGFRNGlBSXdWQUlLRjJ4OWl6R3h1VE5mTFpJTW5l?=
 =?utf-8?B?UjQybENrQmNhS3gyczlyOVlEWm1XQlpRUlFqQWhPaTdFS1U2MTlXdHhMSE90?=
 =?utf-8?B?QzBkOTZBWlVYNFB0NEVzc2V5TWVaeVprZncySFV0eENNemh1alc4S1d0U1k2?=
 =?utf-8?B?QjhhSkRabWxJQ3V3S1FwU3c1RlU3L3hRelNUY09ISTNoQUk1UXZ4a2hIcnNm?=
 =?utf-8?B?aXd6MzF6SE51ZURhU3AzaHpuN2tzSjBSNTZFV0hsY2VyM3lTZnlLd0F5cmdI?=
 =?utf-8?B?Zy81aEtEbE5nWTZKZXlnK0VQZG9hb0ZDWWRyTGFQS0VDa0ZHOGUxR0NsOHl4?=
 =?utf-8?B?dXg1R1pYdEpBdkJmTXBXUWFHaFhvTWVaZ051elZvUDA0dyt0SU1ONEIvcE1u?=
 =?utf-8?B?RmNVdGV1cVV0T0NXTkZnYTdNSEI3VDQ0V01mZWdQTHVNWFRPMUhJQy9yRTVJ?=
 =?utf-8?B?eWRqeHRERktoRThmaFFDVEFzVmFSSk81YmJjUXp3OHUxRUJLYjJqUnRJYkZQ?=
 =?utf-8?B?L3dBWjJXb0RHaStJUjdwUitwMCttSXhNTlFzVFFGS1YrT3FzOHpsT2M5TVpG?=
 =?utf-8?B?VEdDalpHNWlYd1kxQXNmYk5mMFh5WWp4eFpXaUlYRHg5Ylp5NVFwY0laYTgv?=
 =?utf-8?B?S1FrUzhEU3M3UEZYdndYcUFrMXdMNUxMN2o3TjF0NHlRVmlJSmNDYjVnMXRn?=
 =?utf-8?B?bnZ5LzNOMWg1cjB3emh1ZUQxaEtQZ1kvbFdSdWQraGRvNHFvZURKWHFlQmd6?=
 =?utf-8?B?QmlybG96WE4xNWVqdWhPanFhUGNIb0VMZ1I5WlkreEJZMG1rNzVtSXk3bElo?=
 =?utf-8?B?aXNZckhjb0ZET1kyQnVoU1YreUpJLy9CcXdhb0NlSWNRcnVqWjRVSTFoTGwx?=
 =?utf-8?B?ZlhzczRHNmJKM25QQjdHNVZoSENxSmJUUWp0RW45dk1ZRWo3UWN1SGozZUtl?=
 =?utf-8?B?TW0xQk9YR0FyaHBhcWxsVDM2M1J2ZFVXVGJNb1FNUHBWQ3lJSkQ0a0p0b1Bo?=
 =?utf-8?B?bEg0eVBJNWJxTnl5VWtLam1vMVBkWFQ3YnJjN3ArZ0FKL3ExZVhzWjdmVGN4?=
 =?utf-8?B?OUxrUjRwWUVVWlBBMU5yNXd2UXdzQzY4Zk03NG4xU3lsWVNlNWpYcEVwbjZB?=
 =?utf-8?B?YU1EQzZyMFlVaFZYTVUxcnZIbDBjR0tqRXgyVC9FQS9aWWc1T2txTHNPM2NF?=
 =?utf-8?B?VWprTUZNc0ErZlE5d3Y3a205cGFlQXdsVGRwVEFzSU5UL3dXdmNKK3V5cXht?=
 =?utf-8?B?QjhHSm13MWVoWVdjU1VKZmZGUFQ2dHNKUjZsQjhJcGt3OTFKbFRrRkJkb2kz?=
 =?utf-8?B?VW9xNHdFckpGNUE3T3JqRDNKZ0RKOCswa1BQcmN2cnh5bExzNUFlNEt1WjVs?=
 =?utf-8?B?QXVTWFR4Y096ZVdEcXV2TFErLy91c0E5a1ZpTy96c3hnNXphaDA0aEpBdHBH?=
 =?utf-8?B?MU1LTTdhdytJTk9TR1duVWcyQkQvaHM5emxtZ3QvUm9uOE9MTHpvTGF0Q05w?=
 =?utf-8?B?aWtWdWVzeGhnQ0YzUVYxa3RtOW0rWjlYRk5scUl6VVBDWnM3Y1ppUFNCVTlX?=
 =?utf-8?B?OFFDVDBDd0hMNXJ2Yk56UjlYWGpKNEJZZEl1WThmU2hza05KRDJNKzdYT0RN?=
 =?utf-8?B?TVRzZC8rU1B6b3FDcnNKQmZEN2ZHdjR4THAzQmRpaExuRHh5djdpZjhNV2Vt?=
 =?utf-8?B?WEVDeW41elVNSGxlNDBZYVFoVWR2QXpuWVo0SXgzWm5HSkRGeGtaU2ZsNmZK?=
 =?utf-8?B?a0tqeGNNeGRFMWNWWlovQmRwb3NNaFVwWTYvZFgxbjNwUGFiUlFZdG1VdnV2?=
 =?utf-8?B?aEp3enpnSWthQ0s2cFlSNVRBU0dlN05OdmZuTFVlQmpoVFlPUWgyZEZSVzl5?=
 =?utf-8?B?UFZIbTg1U0o5ZitUbGhHWndTemxEdjMyOSsyT0g0MDdHSWdkTmdXbzZXdXRY?=
 =?utf-8?B?YzlIZW5oY3lWUXFqZHpQY0lpdGRMNDkrd0dZRFJ0dFYrUnczTFJFelhsbXhm?=
 =?utf-8?B?aVFrQkkzV3NyNUJlN1Fid1NaaUpZL1NMSk00VmdGcUQ0N3hiQjRKV0FyU0Fs?=
 =?utf-8?B?TFlOTldKM1Uva0FrOWdzTlhGUVVrUFBwTHE0YmxVbElMTmtnUDIrL1RLR0Ns?=
 =?utf-8?Q?Cs8kPpriuQNgwPA4jo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e778046-8e48-4a73-d171-08df1236d5dc
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:04:43.8200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNn6B92w2tjWEWq7vk4sbpItaSRh/bfc9y1OpIvKs+Mq6HQOxP/NGaWbtQZgHKif1nbW6G7qxF5K1qb9IOrrqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863
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



Will rebase on this series, and forword Junhua and Yu, casue the rebae, 
fix and testing are a relatively big work, requires multiple people to 
cowork.

Regrds,
Honglei

On 9/12/2026 12:48 AM, Christian König wrote:
> Use scoped_guard/scoped_cond_guard instead.
> 
> Saving and restoring the GFP flags is not necessary in those use case.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 27 +++++++++----------
>   .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |  9 -------
>   2 files changed, 12 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 47cde54594693..7ced26c9c651b 100644
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
> @@ -678,9 +677,8 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
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
> @@ -2274,6 +2272,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>   bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
>   {
>   	struct amdgpu_vm_bo_base *bo_base = bo->vm_bo;
> +	struct amdgpu_vm *vm;
>   
>   	/* Page tables of a destroyed VM can go away immediately */
>   	if (!bo_base || !bo_base->vm)
> @@ -2284,17 +2283,15 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
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
> index 447195cc45932..ca86eaac75235 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> @@ -137,15 +137,6 @@ static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
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

