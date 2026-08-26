Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A3DC61DC2
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 08:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D46F10E271;
	Wed, 26 Aug 2026 08:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I2Ga9ds1";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD9D610E271
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 08:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDM2q9IHxkFRx9M+VlFuEMWeciRTbFt4bGPMFArwQWashzZ2jzesNKcFQUX7rRYEJfVGXdXxNEWF/gP3jxZR7uDo5wJ7JVdv+2VKXMVX97uYOqlnoaOdHW93de/jyJbmvVlbbDqJsdSx/3ldgNsS8xEDlwrblVFVhEWdpES6q3A7B1jTpU0zqnU+ipwWxHvLyrdhDljT5LR/tC0Th4FofRQA2tg1D/Wwt7GZj9hppf0I9Sc4GVIiYslv9FD/XsgJ8sZH76t4Uo7nZIU4EumaMV5Qt/T4nvYRERw7z9mLMpeCZRhstkO+JHQ+oEuygkXrRfB4u5+8saWYcURjN9JH/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/A/JEbM8P+3jMPdypR2QC0lpeEmaB9rGujFxTNaEPM=;
 b=sJ4pU4Nn+Q4QQ55TTeA2OCh9jKpjn/HYalZeA8QeShrSOuBoSb9EbrsFudbiD0qr8/J3+Hna9m7WGfKfkk+RnVJRcfyXQXOB0dWl36NgvKWtFzzSVJvcMPC5E2MeGg6dNALb7ySNWru8JyGEizh5Vm1w8OqQ3uL/WnQ+kuJEM4ZJ2xG3ASelh/r79RG65GNQEZKWUeCAnaAotzHk5h0ZRKt9bkonVP09h/fE9Blnhu6hzxFkXhzilunxlCQILx1wzguE6tt2Jk4ftyELaqwk64xVcOdC0dsrhlRQvx3VPXph66ERADYk6F7QO7dKm9V15ebxL64lsPpuG026E3MnQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/A/JEbM8P+3jMPdypR2QC0lpeEmaB9rGujFxTNaEPM=;
 b=I2Ga9ds1SSs2mYSbQ48h3ynzkDHHWa/b9MknuLiknR62lgaiX3VdW9LNG6zLk7dfi1yN5Kbfn9NVZcgY8piBYs4gJZ+vViCrMd8YVGC5UxTj07/qWCnSgycNkgUR8wE+R1EpdDYN3fAzcTajdKdLYledh5w3sjmUPl6UNN0rlrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 08:58:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 26 Aug 2026
 08:58:14 +0000
Message-ID: <7fdf5073-24be-4460-8018-eb2090584b15@amd.com>
Date: Wed, 26 Aug 2026 10:58:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amdgpu: bind BOs when the eviction fence is
 attached
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Perry.Yuan@amd.com,
 Prerona Ghosh <Prerona.Ghosh@amd.com>
References: <20260825075346.536983-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260825075346.536983-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ec54b8-f886-4107-1db8-08df03502998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Is8AWgEUP26gyT7HvVMV3nPmGWiNj/eFmEitGrGaCvxJaG3KxHlY1Gc2Mv3seNLt0wqwUHWWqx5OVZK2vFNM64k5bEOe/TBq2Iri82CnDowlC87507jdQ/JiIpeCHLXfH1nI3k9Aa43zmGaG5q4YgDKiAttKVVT+n1G/vc/wcEmJWrJFdBLXSzjQUEjuZXHOrvYhP5eaCJtRjw1xvyno3FPS2rl4Lsx1YGaSI3bQDHpPXCMcyND5z5U6zWC15yMhn80Ucz/BGlJmuHQ9oOVMRMchXqZ74FDvY4pYfYvONPuCr/9tM+mZWlbEa6ZLJ7SLJHeDtV0mFQ+hNli/bdhTR5BCboduc3bXkooG0ALr1UMQKkIuK1Z6jmx/OMcmVGd5BY0kThO6pcwRP+Eu7ZCDOUVPPzeKSWCaOaZHnIuMhWFibkLRdXQhA5QWsxEZWZNb3CTJIiAAB0MbwNH9tdfedHJzyswSVSKfnWThg2uDu6CDuWCKM8l35QB6rm7xQ6Dyc4R+0Ek0RlEYQNCz29gIi2/FGL4o1SaKA8wwupviwJsgzs7qzKGu1RwI7DMr41TNAhMdIO20+B+3q8UmFF7wTxCTonlcUV63j3dKuvWw38G9ZToEMduIQXyY8MaDHRqZ+hAsOzywJ90zqCNO/MZ2tIkqTcnHMhJRRuu82Rs/Nmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXBnMkF5b090MXQwSlgvcWhWRzM4b3J3c1VpMlFOR0lFL2lzTVR3NnRCZGky?=
 =?utf-8?B?a0QwaGlNaHVjQmtTSkZUL216MEcxVlZQWkpNRkl2QnRlZURLNk5PUXZXc3Rn?=
 =?utf-8?B?aDJKZnA0QWRRaVV4MFNuQ205RmNMVEJtRnRId3VvYTZaTmpaVnFFT2Y3bHJE?=
 =?utf-8?B?RTJJTjJ6cHNKeVZZWE9jV2xaanA1aEhZbFRiMFNxRFl4U0hBdStTS2x4aHNJ?=
 =?utf-8?B?NkQ2U0FDaEx2eWNTcmpSNFloYXphU21RVU52RDl6bXRaU1RQNUFHeXJ0dVpJ?=
 =?utf-8?B?UHlCandBR1drZGkzOW9SVXRudGFmUHYxVU9rbmZXQTN5V0NoeWRGVHJ0dlEv?=
 =?utf-8?B?cjdFSU1Ta2M2cjZVOHlaUzFHU1lhS0JNU0V2cXE5TGRiSmF5L2J1WnVJNkJW?=
 =?utf-8?B?SWdtOTNzUHZrY2RXdXR4UmFQcVFaWjZrSnBKempQS3U0dHd3U3RBbk1hUitm?=
 =?utf-8?B?SUxmYjl4UGJZSk0zYlN4aDRXSEJnR3M3OVhWcFRodm9XQkYvNXMvcG8xOGow?=
 =?utf-8?B?aVU3UG9FMWZsNktrZGZjTHNqK0hqaHJwK3oyeDhlUDd0djRVS2d6NDBRQUpn?=
 =?utf-8?B?ZWxEd2hSeWE4N3hpWUttMmJ5R1RsNzdVVm5JMTZ2eFNMRDZuVnFzODk4WHls?=
 =?utf-8?B?NGxyRlRBUGEvSHZUNmsxdzVRZ3hGY1kzV3dTVG95bEl4dDBKcHRwV3QrUzkr?=
 =?utf-8?B?Q1c4QzJvSXRoTExFZW1PRWZoVzN6Vy9CRU1XemJjUUpadWRHeVhjblFrNjlK?=
 =?utf-8?B?NHByWk9RN1BmeGFkZlAxd0V5NlNjTGVocGZoQ2dIUFdhaWNQMzRQVm9qbC9K?=
 =?utf-8?B?Nm5qRGZDK1dpYXc1cXlsQnE3bU1pUWxSWmQxUmRnVk9pMzBuZnpGVUoyUTFY?=
 =?utf-8?B?V1lyVEVlNkxhWXRnUDA0WHJoRHBVdjRLaXIxSEE4Snh1aG9VV2lTTkFQTDNH?=
 =?utf-8?B?S1FxN3lhaS9QdlVLYnl3OEx5VEI3U1VvbWtvVzFNcGhXNWhGcWE4MGhCZXVY?=
 =?utf-8?B?TC9oRVR6cEU3aFBGd2tNRmlHZCtXc0hZQnVYR0t3NmN1QkJFL08xb1NGOEJh?=
 =?utf-8?B?em12R0RSczFsSkpuRFAvL0Y4SFRoUFNmK0hxckxpMXFQY3VYR2pGYzJYRllz?=
 =?utf-8?B?TmhSVFl5b0p4VGVsZTVWcmx3YlVqdFRyS2tJQ254bno4bi80b0xNYkxYV29s?=
 =?utf-8?B?cUdhbHpiaTFOdHNQTkRxOUlwZFpIa1RaS1NsNURjSkorRlp3TFZaT3NtcmJy?=
 =?utf-8?B?MUpudGFmTlphSTRBVGYxcVN4aUFFR1BpM0RPa1ZFZ3R5dXVycTBmQTR3UExZ?=
 =?utf-8?B?cjJTelAzcTRtK3VBS3dteU0yTGtVQWZNdURUQzlQUVF4dU5MdmNXQ1N6S2pW?=
 =?utf-8?B?UHNsaXZleHJNS3p6OUZ0MENGMWNXMWYxWnZXaWN5OFVBbTlFazRmOFI1bmhs?=
 =?utf-8?B?NEs3ODk4TG1aVWpKQVQyQnhaSWpEZzBkV1BySWFnU1VyQ2k3WkI1RVlncTd1?=
 =?utf-8?B?Q09jZWJpOHd5dXpLQmxrQzBvQ01qY0EzV0JOUlJCeUxxM09rbHNPd1ByWVpt?=
 =?utf-8?B?ZWRUZVRMYWd3eUd0Ui94aDl4TEhvVCs2OXR6ZWg5Y0tpTGlhMlIrbkxuNTgv?=
 =?utf-8?B?VE84ZnpRVHRsRldhTnhZUWpFemRQeFJHaXpCbUl4WWpaZTNGdGVvUmFRZTll?=
 =?utf-8?B?SGNKb0dIaktpeWY5K0ZUbU1PajI2L2FvajlSRnN1K3JjbnBENmRhcURZWk1j?=
 =?utf-8?B?TGZaY2dDSGltT1ZQNVpEdkowL3Z4Z0pQZ0N6YmwwN2Zkdko3VENibzdPL0hm?=
 =?utf-8?B?b0xYT3Fqcy9iaHZxYjFCbEU5NnZWUGFCa1orWGVVQ2ZwcVBDdDJMMDRacUVJ?=
 =?utf-8?B?NTQ3R0pjZ2JrOVF2blF0c3FKM2cwMDBzZVBPa3Z5MkFWQlp5bVBScU1rblhE?=
 =?utf-8?B?emFLUGJQMUVIZW9WQWh5ajdaV2NEUnFEdUJaWjZJNkhBWEI5NFJWMHJxZWlD?=
 =?utf-8?B?NEZrbzIwOG16c1R6MkNYUHlycnk5YkI4U2F1WXhseDhMdkpKdVA1K3BaVGtB?=
 =?utf-8?B?ZFJQbXZKZHgxRjU5MTVDandoZFRZVzhRb3N0bGlZL0toVnZuTkJvbVpGWWd5?=
 =?utf-8?B?dlI3d0lLYks5K1FXMFh5Ry8yY2dwT3FrUEw3bmVpbXh3UDJnUDVleXhOTXpZ?=
 =?utf-8?B?Q1Z5YkpxRC9pZEtTN0tqOHlzZVFmSlZNUE5ReEMxbmpRS1lhSHRmMzUzZTIv?=
 =?utf-8?B?Ky8xN2FYTDJGSVFHczlDTWlJMGZDMzJBM1N0eGh2TWhicWsyYkJKSG5yTVRT?=
 =?utf-8?Q?PvPl2Wdg9FeQ85sE0z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ec54b8-f886-4107-1db8-08df03502998
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 08:58:14.2778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itq+12IZAW9UPGBqJoTo18ko/CsjpKrEiHof5lPJcOFjlb5AP/EYSQik0/ZaPt62
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8240
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

On 8/25/26 09:53, Yifan Zhang wrote:
> From: Prerona Ghosh <Prerona.Ghosh@amd.com>
> 
> DMA-buf imports are created in TTM_PL_SYSTEM and land on the VM idle
> list, so nothing binds them for a VM using user queues: amdgpu_vm_validate()
> and amdgpu_userq_bo_validate() skip idle BOs, and amdgpu_cs never runs.
> AMDGPU_GEM_VA then programs PTEs without AMDGPU_PTE_VALID and the first
> GPU access faults.
> 
> amdgpu_evf_mgr_attach_fence() is the right place to fix this, but it only
> validated while the eviction fence was unsignaled. At amdgpu_gem_object_open()
> time the fence is still the permanently signaled stub installed by
> amdgpu_evf_mgr_init(); a real fence only appears after amdgpu_evf_mgr_rearm().
> Natively created BOs hide the bug because amdgpu_bo_create() already
> validated them.
> 
> Validate imported BOs even when the fence is signaled, and unwind the
> bo_va if that fails.
> 
> v3: validate inside amdgpu_gem_object_open (Christian)
> v4: fix amdgpu_evf_mgr_attach_fence itself instead (Christian)
> v5: restrict the extra validation to imports so that resident and pinned
>     BOs are not migrated or failed on every GEM open
> 
> Signed-off-by: Prerona Ghosh <Prerona.Ghosh@amd.com>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> Assisted-by: Claude:claude-opus-5.0
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 11 ++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  9 ++++++++-
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 4c5e38dea4c2..c2f9380511a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -101,11 +101,16 @@ int amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  	struct dma_resv *resv = bo->tbo.base.resv;
>  	int ret;
>  
> -	if (!dma_fence_is_signaled(ev_fence)) {
> -
> +	/*
> +	 * Imports are created in TTM_PL_SYSTEM and this is the only place a VM
> +	 * using user queues binds them, so validate those even when the fence
> +	 * is already signaled.
> +	 */
> +	if (!dma_fence_is_signaled(ev_fence) ||
> +	    drm_gem_is_imported(&bo->tbo.base)) {

That still doesn't make much sense. When the fence is signaled there is no reason whatsoever to validate imported BOs.

We are still missing something here which explains why that doesn't work as expected.

>  		amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
>  		ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> -		if (!ret)
> +		if (!ret && !dma_fence_is_signaled(ev_fence))

That check is superfluous.

>  			dma_resv_add_fence(resv, ev_fence,
>  					   DMA_RESV_USAGE_BOOKKEEP);
>  	} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index f754a4a3a1c2..3118b3036564 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -264,9 +264,16 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>  	bo_va = amdgpu_vm_bo_find(vm, abo);
>  	if (!bo_va) {
>  		bo_va = amdgpu_vm_bo_add(adev, vm, abo);
> +		if (!bo_va) {
> +			r = -ENOMEM;
> +			goto out_unlock;
> +		}
> +

That should probably be a separate patch.

Regards,
Christian.

>  		r = amdgpu_evf_mgr_attach_fence(&fpriv->evf_mgr, abo);
> -		if (r)
> +		if (r) {
> +			amdgpu_vm_bo_del(adev, bo_va);
>  			goto out_unlock;
> +		}
>  	} else {
>  		++bo_va->ref_count;
>  	}

