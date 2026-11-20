Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6560606A325
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 22:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aMlTuV9E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C39C10E20D;
	Fri, 20 Nov 2026 22:02:05 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71C3A112D23
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 22:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNwUmtIo6KMF4+XiR5ddnh0HiYdmi1ZaclH2CNq3JD/R6raOlhJYSRucOsjgZKhLjeoX671OJEj2PNiTy7PCInukqybYMEu7rD7vyw/yJom0Mp3Bf2QcpLrDw0GNwJpepbQ0gRQMCfn8Eh+7g6/NzsT7cV9a/xKgv00aQfYHo0vYYD/UsQ3y7kWjQjth0+f0mzQ22bpajWuKpj/0QpKzalZIG312QMipYNK6Otv8lxkAT4BEUXoBx+EJvrGfFrC84QXqzeBqimUu4tZgJBOtfPHaEIERG/ndesYUh7aSasyLFQepJwFPOsq+FPhCcjLoTPFENu0pwaf+QhqNym48KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HWZsW39VRf5DNuQxslw2fKouEbZ77MLl3yiy6gSPo4=;
 b=qrnoU6qqKQRMR/3Y7CSzusZJS0VN8rRHBjcvgm7Dy9GNOocMmLeJXZlK9yM2AKsl3FgyrpoYNk4s1guxXj1VOcVxSbGZ0ZYXfgaPLZhvn0nBfDnYeTFiBCi1HHbVPCj+qKrZBAhRetf+5Nk2QrWaUNuHRoG3/SxA4+j1mtmChSwMntijVnWnLWDDxKwvpDCJZOD3uOOtQpxwJW+3qUOluJTmTLHaD4F3dnS/INxAdbB+p5+Qh4nTF7wRtV38f4Kk8T025F2E91cVU5WDfBGAxd4nEfOZd8ChgkXyJl6VxBGOq+fJjoJpJ4KS14APfIcUW5Kkvcdwxo9H+iREK5uD2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HWZsW39VRf5DNuQxslw2fKouEbZ77MLl3yiy6gSPo4=;
 b=aMlTuV9EVg8V6J3oPxUu8dAB7PzoGA5A2xGWSGcKw/dNi2cSv3/tMrDRuNWAaAL+vkpcQSoICbE0AuXBW9YKwP4k8/GnmXPFAXbZ8VINrjCAO/4GcxQUh94XBbvpSmqottP0OQQ+t9L4eJmeO6H7Tk8MAX/a0F4XZc8urpqEJrg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8SPRMB0063.namprd12.prod.outlook.com (2603:10b6:408:242::10)
 by BN7PPFCEE68E7BF.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 22:01:55 +0000
Received: from LV8SPRMB0063.namprd12.prod.outlook.com
 ([fe80::6cb:fff:7dc4:2fc0]) by LV8SPRMB0063.namprd12.prod.outlook.com
 ([fe80::6cb:fff:7dc4:2fc0%4]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 22:01:55 +0000
Message-ID: <ecac4e13-0da7-428a-a1cb-db75990cd20b@amd.com>
Date: Fri, 20 Nov 2026 17:01:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: clear root PT after setting vm->is_npa =
 true
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com, yangp@amd.com
References: <20261119184620.1090706-1-shahyan.soltani@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261119184620.1090706-1-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0214.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::20) To LV8SPRMB0063.namprd12.prod.outlook.com
 (2603:10b6:408:242::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8SPRMB0063:EE_|BN7PPFCEE68E7BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 1890a3a9-b260-4f93-b39d-08df4751e3e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|6133799003|22082099003|11063799006|56012099006|261026140227099003|261028144727099003|261026121527099003|261021123027099003|261022075727099003|261022105027099003|261102123227099003|261009223027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: fu4rSIusN6xyKmeN70ektiYZFS4xPykYyjtNqhWLLF9+qNas01NvE/T0C4x7YINiLLM3SAdLa6OzgdNNd93s7OAk8fu3NeswmH0TwTMAKKt95ahTlmiM0FwokFY5t5xNovw8JQBg8UUxKPRDjFtZRa8x4uHFk9gLSkR77PlyoTPgOIAK/fbtoZQU0raCSdOZGoKzfOPel0O49yZz2nqNpxH422Z8ZfGRd9knJMLI253JV8OYh5eKPWbONVQfAeJyIU68HwaRmGQvIyifVmn3c2kcdqaOgc3h/81jJRN1GbuHlGxSn7AEU7bkmbyinYn6rqmjSajk+vp9cJlSv5aYS8yfOsxAhGP8kSIbSAkluz31fUIsImL0GxySon3a9od9x9dqk4265LMSqQNaK20js7tXwVVGRuIHdK5issdCouEis5Cr4jeBLrK4LDl2FSdzkdC/HaLppaKwwIK1CM9LgtdeZ7DOmFAzjsdyFk9ioVkhP0nsHTk/80DXPypHHTMEObml2v+Oh/2DDRKTaVkbyInkB6Cmz4VLTz5N8nTCQneppzN+jca3lIye+UcLHengj+6/f7dDyjNeMV8ZIiidJnu6uR0A0sLBgVwokAbS11K1YjSaoqfLUP009hPAwNujZ7PePAQGmQfW1KADNerm/utuFyGHJPKtVYzHn3E2l2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8SPRMB0063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(6133799003)(22082099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261026121527099003)(261021123027099003)(261022075727099003)(261022105027099003)(261102123227099003)(261009223027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUR2d2lQTWZkc0UwR0F2SjdOb0s5eEI0QWs4TjdSNEZPN3UyeTgySCtRcXdJ?=
 =?utf-8?B?dlRyL29kMWtSS296WDc4Q0dmdXJuRmQwQ2IzcU4yYUhHWDhzdEdvYlp5WjdR?=
 =?utf-8?B?RWtDNDJVVGg3blkzNnR4K0tVbW5vL3lRdlZtcGp4b0pMeWduU1VSWXhrVFpS?=
 =?utf-8?B?RGZxa1hKVC91c3RMWmNwampyQUQ1TEp2R2J4SlRycXB3NGdJM1VGVEx2ZlN3?=
 =?utf-8?B?Rmc0UHZJZFp6KzNqbXY3cHhSVGFqMjN6QzIzUEUvM1hjd2EzeFNYYnlOVUUr?=
 =?utf-8?B?RnRlcGVSUXh5cHkzODZ6QTNUUlgxZHBBQ3hxUGd2ZGVDSHBpNUxPUngyRWRq?=
 =?utf-8?B?d0UrdjZkT1V6S21WTG81bWRHZHJDbkNTY2FScGpMb3VtK25aUHM5Mk1YLzNE?=
 =?utf-8?B?K2FRT1hOSzBHTlFGaVFrSkh5TEJTV0xyWXc5bjQ2cmJwWEJpbGRXQ2R4ZG9z?=
 =?utf-8?B?OHVWSnM3NVhFd0o1eHRFSDM4T1RpNEV6RVhxamxlVjM5blRwcDBDUXlJRGFy?=
 =?utf-8?B?OE43TWlxMkw3QTNiL2JtS1QwRkRLTG1kZHRncVVvTmY2RG12aGZJaGRrZVk4?=
 =?utf-8?B?ZUg2TjZTanpHbGpvMTd1TzJ4VWF5YUo0UTRnUXBId0dkYlA2T1pVRVBBNzdw?=
 =?utf-8?B?Y1lFYzV4SnZFdjlDd3V1OHJpc1ZrV3dnbEhLbkc1M3p4b2theDMvSGlPVEJM?=
 =?utf-8?B?R3k3b1pDOERyL2JtWXQzMGZ6Q3FCNjFOS2srMHpKYldEdjBYRER3Y3hkWFdm?=
 =?utf-8?B?RENoRXo3WnBYbERqdWlycTRXWGVncUJjOE9aTXZOaFh0eG1PZHNxQkg2RWxx?=
 =?utf-8?B?UGFaVTVKSG43TTl1RC9SSGhrb2dzTXJjZis1eU93dU1pci9QR1NSZHVicVJn?=
 =?utf-8?B?dnJLN2NsZ0pMdXRDS1lGRlpEYUFRMWNDYW9wZEp0Z0ZmcEVxUUcyK1hGS3Nq?=
 =?utf-8?B?ZUdDdmZjVDRaSncrRW5Sd0FNVEZTR3U5MUZkdkF3OVBINS9jc1p3Q1ZnZ29Q?=
 =?utf-8?B?ZTZNNTQxSW92Q1JHc0doRkx1Q0FkMGNHcEQrNXBGRTViN1VVUEU4S21jR21v?=
 =?utf-8?B?ZmRvWHA4b3R6Q1FVL3UxVmp0emxYb2Z6L2c3bGJPYnNmUzBiQzNBTzNJVlQw?=
 =?utf-8?B?Q2ZXMVkyd3I1Y01HUER2Q1NaeFptd1BtbktCZks3T1dWZ2R6R2pmZHJ3a2cz?=
 =?utf-8?B?NDRibFpaWVZwZGNteDJ6S0ZFOW9qcXVKNE9OUk9kUDg3aDVCNmFYZ3NuV2tv?=
 =?utf-8?B?b3FFME5zOWtqdlhNQzViRlNSaC9tVXAwUFZDNzBRMmFoUlMvK1BYVGpQWHdG?=
 =?utf-8?B?WWx3RkNneHQ4UzJRQTRZdHpEUFdqbDVyRFFaamZpQjF1ZFlvQ3dOZEp0MWw4?=
 =?utf-8?B?SGV2Z3dYNEpHUDduQ1pZZ29nK0NjMXVDL3M2RHFtTUFvSi82blUrYWF2L0FY?=
 =?utf-8?B?YWVrb3RhWkhFc1RyVGRIcGNQNlBzeTNtSDFsZC9hWnVkMXdjSUZ5eEVJUjNM?=
 =?utf-8?B?ZXVVYVlxaUxoUDVoTTUwOTVSaElaaHE4MG9ZOG9NVWxKWG1PeXhpai8vMCtS?=
 =?utf-8?B?enRUMnNOQjlsZG1pUE5OcjhHNEVMSkE5aUhVTlcrWUhud2ZLMmt6Wkh0UEJ1?=
 =?utf-8?B?YTIzVjRFUko0a0tTSnZoeUtlVkRlSGoyZEIzRHJHZHcyWVpFbUxHV1hRb3g0?=
 =?utf-8?B?eHJTOUExOWpJTjkxZ0lZQzZtWEFwdElaNlNwMkhkTEtCSm03SzNzd1B6UFBD?=
 =?utf-8?B?M25pN2xTTmQ3S282aVdvL0V1SHIrdCtDQTFuS0lGVWpjT2VhOEFPaGlhajRF?=
 =?utf-8?B?VmNHbTFqT1lMbmZSbnY3NUJwVnVMNW9RcDgyNGZFbWtyMkkzczJQUkEzOGU5?=
 =?utf-8?B?eXNSMG95U2lPdTVCQ2tIVGRNYk1aYkg0M1U2MnZWVXhZWHUwMHM0U29rVGU3?=
 =?utf-8?B?bDlCWlpnNFByNEpNaDhxWGMxOCtoMTRMM3JTUWFINEZ5Mmc3UEJZRC9lRzB1?=
 =?utf-8?B?dHRzMTNkSUE3THBRalUyWlcvNE43KzFGaWJ1NzUyV2ZObTJ1TnVDb0hYNXNG?=
 =?utf-8?B?Umpyb28reklFVnhoTisyd0o3b2tlVXQzRkF3UFFhYTcxMVpZNHFsV1pxTFY4?=
 =?utf-8?B?UHUxMHE2VGdCazBlbEI5NGxrSmVxcmNCVXZ0QnBwUmgyVG52bG5VdUV5N3d3?=
 =?utf-8?B?M0pISGVaQ1ZvNFlDSzFINm9vbG1YUlFvMis4WERXSzE1N2Ria3dNVkZZaEM0?=
 =?utf-8?B?VFROZWV3allmMC9kVFUwTmZQMXlDVVpnUEE4d2FOdDRtQ3hSaCtYSWpXUEZJ?=
 =?utf-8?B?eUxreTNWNGFjV0lCQVdzVVEzZGFkK1lqbTdLSVF4OVdTVTJsNEpLQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1890a3a9-b260-4f93-b39d-08df4751e3e5
X-MS-Exchange-CrossTenant-AuthSource: LV8SPRMB0063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 22:01:55.3570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xj09wawKDp4k9bgdFN5iifTOL27wGQtpMv40wUfkhC3uTP52bW9dz0uEUxQKklagHz8TPZ65WtG3pqlIn1so7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFCEE68E7BF
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-19 13:46, Shahyan Soltani wrote:
> Previously, the root PT was never cleared after setting vm->is_npa =
> true within amdgpu_vm_make_npa(). This resulted in the flag
> adev->gmc.no_retry_flags to never be applied for the NPA VMs.
>
> Call amdgpu_vm_pt_clear() after vm->is_npa = true is set and the bo has
> been pinned/validated. This allows the root PT of the NPA VM to be
> cleared with the correct value.
>
> If the pinning or reservation of the bo failed, the vm->is_npa flag will
> no longer remain as true. This is to avoid conditionals outside of
> amdgpu_vm_make_npa() that depend on the vm->is_npa flag to determine if
> the VM is a correctly initialized NPA VM.
>
> Warn if the VM already has mappings, since clearing the root PT will
> break existing mappings.
>
> Remove the redundant second setting of vm->is_npa = true.
>
> v2:
> - Add the WARN_ON sanity check regarding an empty VM (Felix)
> - Change the return handling to only set vm->is_npa = true upon a
>    successful pin (Felix)
> - Add the heavy weight TLB flush after the root PT clear (Philip)
>
> v3:
> - Remove TLB flush (Felix)
> - Move WARN_ON sanity check to start to return early (Christian)
> - Reserve fence slots for amdgpu_vm_pt_clear() and amdgpu_bo_pin()
>    by replacing amdgpu_bo_reserve with amdgpu_vm_lock_pd()
>    (Christian)
> - Use goto error handling rather than calling return when applicable
>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 36 ++++++++++++++++++++------
>   1 file changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 94b1cfe05e3e..d9e3916feea6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2820,23 +2820,43 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>    */
>   int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	int r = amdgpu_vm_make_compute(adev, vm);
> +	struct drm_exec exec;
> +	int r;
>   
> +	/* Check if VM mappings are empty, clearing would break existing mapping */
> +	if (WARN_ON(!RB_EMPTY_ROOT(&vm->va.rb_root)))
> +		return -EINVAL;
> +
> +	r = amdgpu_vm_make_compute(adev, vm);
>   	if (r)
> -		return r;
> -	vm->is_npa = true;
> -	r = amdgpu_bo_reserve(vm->root.bo, false);
> -	if (r)
> -		return r;
> +		goto error;
> +
> +	drm_exec_init(&exec, 0, 0);
> +	drm_exec_until_all_locked(&exec) {
> +		r = amdgpu_vm_lock_pd(vm, &exec, 0);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(r))
> +			goto error_unlock;
> +	}
> +
>   	r = amdgpu_bo_pin(vm->root.bo, AMDGPU_GEM_DOMAIN_VRAM);
> -	amdgpu_bo_unreserve(vm->root.bo);
>   	if (r)
> -		return r;
> +		goto error_unlock;
>   
>   	vm->is_npa = true;
> +	r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo), false);
> +	if (r)
> +		goto error_unlock;
> +
> +	drm_exec_fini(&exec);
>   	vm->need_tlb_fence = false;
>   
>   	return 0;
> +
> +error_unlock:
> +	drm_exec_fini(&exec);
> +error:
> +	return r;
>   }
>   
>   static int amdgpu_vm_stats_is_zero(struct amdgpu_vm *vm)
