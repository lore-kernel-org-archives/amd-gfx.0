Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA79C88E72
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 11:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E45BD10EE28;
	Thu, 17 Sep 2026 11:43:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z7hQVoET";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0EFF10EE28
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 11:43:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWpldHr2m9TvqDh4lJtzrPQQmIz0knO5lmThFdaILc1srZnmJJkEgw/Z2ENnGbgtwUDZrPkaDw3t6HuV2wtlsgfVfjhJCIwNHU3Hv+XYkRdnnsugD/P02sRuTxCDnTC31GsUUvm1Zz+I3fgiiynwCBQYK52owcPpW/pRYj5zeErzZWRNpbUU0aN0K5Jfr0Rf/i2gP19nQKgO4kM7GGxfgHImoGtKSShw/8RNIPm/bcKGMU/ZSWXP7ei4iluDkWGQNMUIh0sPV/zMChk63om2njvFqta1YOGh8GlPIn0fDYrqclkrL0YegX7461g3VXlrsqN6qO0A51VqqKmMfCQWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnU4lQVx3LQ3UMlR0IkEt6AiAKt9E5D3jvi6kzIF0GM=;
 b=Upp4Y4JwT7n0wu1kWHtOHh/YNABkbKgt/y+G5JyMD+kWWCgK7TUZ8VMHLPA8BiFR1K4TH0xypmU9WCym/J5t/HbHScDFncLy3OlAROeFPb2Q9/N2wlWrv3J1YOqISf9uV3Vh041lUz1zl/Mvj3xqkqKKDZMuKvKXrHK3cgqGC2gm15Y+TqbH8iQ6/iWFsqLx3lJLVB8iEfy45tEmVigQr8DYrUkOlSt06iQDMYr1QlXkp3XrdOPGVSRSQ/7iKCWLYpOvdGBf9YhTnJMraz0QEnBr6AoTzcq7GoBzCYDP5TEmP7IZFHdwoVl9SB7YAj+A0tw9KwkiaTPrdp/vhPC/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnU4lQVx3LQ3UMlR0IkEt6AiAKt9E5D3jvi6kzIF0GM=;
 b=z7hQVoETyFTcDY68ElWxIqJZMEcSEAWj/9wQHQcDsUTeH015wKoIxgaBB/MrMWAetAjD73A4PPhFZnNif3eABrNGB4essGlr/vpuGAAJGuo+LdVRqcOqOp+a/UHy3O384yNF8DpH459Wl84NO7j7EBehoUtCHWt3OLtCJA29s+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 11:43:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 11:43:28 +0000
Message-ID: <d54c9aa9-6414-4984-8816-84db74de309f@amd.com>
Date: Thu, 17 Sep 2026 13:43:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Use iosys_map for trap TMA BO mappings
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260917090530.666757-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260917090530.666757-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0449.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6c8630-c095-4ee8-a9a0-08df14b0e435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Gi6kJX5d0hXSvJ84c2gbl62lF+BhdfMrboyW+82vIP0a51z+UOo8J7k8LJ6+Ig/NiiR1mML33z4malGRgnRjQBZoD1AjMQqUA1MHkUJO/Ka9KyK+zXHXjhFcEJC71b2Jk3uGR+R+wNNyY0bJyy3146ZP8VcJYePLbQDT6RJ8XwbzWcfbhhiDa+/JOeiVHOAc13wMbrtkwIRFWf4QdQ8kG3mz24XlkTivzEEcN846boLdqzVzxBt/md8ez9vt1a+nzT56/b7gSY8TMNrVFlSWSI21euBFSFWJABc4IXMsGesLgs16ZQqqx2ri20PalFM1C8OCX+U08/ex0R8P7zFubkGYsQ0QyN/mTdlJeHqXDs+BERWWEm377RQ6R2lVbZ7CNY4pCNn2O6X2JdEq6wbDrrnaB91WIiB3I7emvVPUg55z2od/2xSxBt6YOGASVw4zWgrRPP0V9LWCl+rPftsl/Fhform+Kp6r6LvOA41GDD2REaqWvbtFt8iD5SVipKgr5HcHRZFCt592/VnWqoJnKeiHNULDuot55zIM2zx8yktmIIVu47xWsiFfi1+ule7TwJA25bbScCSgpxCVzufAiCzdq/IGXFWmSm5izAczAGHksjw46OHDmiUNPDA5NNU0wylkkZiz7S2f5jR3RihqijbdKNyJ9i0U/3EC5gjlKiQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFcyelFUYzJDbzNuTUo0d3V1aGlVZmJScDdySWpwNHd4WWZzUUVKOUdjYW9r?=
 =?utf-8?B?YTdzem90dUJ4MUY3alZ2ajVpU0NERlFTaGRJOEZkMmEyYUtmekNySFM5MWo1?=
 =?utf-8?B?Zm51bXUzOGZ2dUNFK2lyOWpjVG1JLzBGYzA2My9NS3BoWWdJc3YxaU9PaWcy?=
 =?utf-8?B?YTNheHhPU1ZrUHJrRGF3YzVZbHdpWlZIZG54Kzl5VlpFOEw2ZDlnRUQvb2px?=
 =?utf-8?B?aEdocHE0ZGdicUdSU1dHalo0cU4rdUoxMDd4YVlSVFBCaC82K1JWSC9ZVnRj?=
 =?utf-8?B?YlU2QnNST21lR09wdEMzNFJ6WUhaSGxEMmtHbVJBYjBVQW9jM3BUZUs0M2JF?=
 =?utf-8?B?L2Naa3QvMVJ1VzhNdzN2UmNxWHdWbDY3TmVIRWJWczFGSXJIb09jbml6T1pw?=
 =?utf-8?B?UXhRRzkrUE1QRFV0b3c3VG5pbTRUMURRRlE2MnJudzRwL1NvM0NPT25nZjJO?=
 =?utf-8?B?TW5UQUxHZkRSejRKY1k5S1pQeHNQSkF1RUpaa1NRNGt4eXRXVXd0WXpvb2oy?=
 =?utf-8?B?QWg2VDdpOVNUd29JejUzSVlqek9SRUU3S0hzdnBPZUY0R0FDTG9SR2V4RVZq?=
 =?utf-8?B?STBNcklzVGhNdG0zTG1xbjlZcFNrL1UybUtyOE1nQTdnZHRXN0JCT2VOZFdt?=
 =?utf-8?B?WkZ6UmpHWVZKenV5TkpoV01HQmMxcnVxVStIVzg3Q1dZQmZsUTErZjA0dFRx?=
 =?utf-8?B?UTR6R1Z0UnNqMkxZVVhEUEhrTTFBZjNrcDhoT0VOam5LY1pPZEpyN1RvUXcz?=
 =?utf-8?B?SzJhUVNOTUM4a29sUEZKTkRPdFpNUjdFMTFwUTFqNnhZOFlVV3BhOGU4UXhM?=
 =?utf-8?B?MnBueTFtT0ZlRUVYZHFBTlcvT0xYUHd0N3gycUo0UXBCVXRPSlp2TEJ6QXJm?=
 =?utf-8?B?MGk4VTVNanNQT3BLQTE0bjBYODBIZWhSK2h5clVXRkMvcVc1MzYrSXF2S1Rz?=
 =?utf-8?B?a21VazZDR3NtcC9XaktaWjFCR1BVbG1tcnRnN00wZHM3WElaRFMwUXlFNm1t?=
 =?utf-8?B?dWVlVVpka3JsR25vL01oVHEzcDVIMWkvZGRpU1pubGRGSGhPbUZFZ25tTHRH?=
 =?utf-8?B?M0s4YjdoMFQwNGtXVzJmdE1JM0ZqdGhGVkR5RkVFWTFWMXl5REpYRkswbzE0?=
 =?utf-8?B?YlFaSDBXRVg1dzJIeVFLU1V3UlNxSjBDeXZ1K2xSZ1JkRlovd1d3YzFab2Jy?=
 =?utf-8?B?M1V3eGUzZU5pNEJ1aVFoMmNRYlFybEZtckIybGtMYlBsSVAyaXRLdTEwZHBZ?=
 =?utf-8?B?Zk1ST0JHWGl3SzFRSXArUmZURHF1RVFWZ244bVhRMDZBaW5Oc0lwVVhuc0ta?=
 =?utf-8?B?YlNtc3hsT3R6RENNdEZzZGtsZ1pTMmJ6ZWM4d3Z5UjZ3RElOUlpYRm8xTElz?=
 =?utf-8?B?OUQ0Y3Q4QkRvQmVLZVd4aTBKTzBVTURQRFcxTmZPUFhPOGgxTVJKcWZQK3BJ?=
 =?utf-8?B?UjlFWW9OSy9uNFpMdDR2TkkwanF0b05DakNiUnB4QWZBK2tmaGVEc2FGenoy?=
 =?utf-8?B?MjlLbFhmSW1UaG9aZkxDNUVHRE5aZXdwSHJDM0NUQk9nbk1pY2R3WVorTjhq?=
 =?utf-8?B?Q25jcXdGNnZiVDhoNVVJRW1mbHczT3gxV0FPaElWcDIrdzI2ZGxKc0pJOTFq?=
 =?utf-8?B?S05TNW51RkE0QS9yeWVaZ3Q5aU53YVpvcm9SM0VWNFg0SjViVkZGQ0h3ZklU?=
 =?utf-8?B?c2pOOEJreU9oa2poS3JPcjY1OUZRaC91OTB4djdCTUFPTE1xa2lteEgwNE84?=
 =?utf-8?B?b2FJZk9zWFVFUVMyNTJQa2ZQbEVDU2RyazJxZjA3WWtlTi9RbXNWMnEwc2No?=
 =?utf-8?B?TFlLY0dQQ3BHUnMvV0pJekkxdEdnLys4M0E5N2JTWGtNVXlvS2ZUN2RXODAv?=
 =?utf-8?B?SmhYWjR6emI2QlZ0VjhHWTNhM3E2YllhNHFEUHVlUFJhRDhoakJRYjlpZXRE?=
 =?utf-8?B?NklWTHpJbDgzLzg3RjVDZjhLRmtxbEU4SjllVVdhTTZkak5uNDJwK1dDK281?=
 =?utf-8?B?NlM1dHJjSGtIWDZzbnljdkNPOXlVZ2Z4REpSTHByU2phN2lNTVc5bk1GSnRI?=
 =?utf-8?B?NzdmVU14RUdTVUhUQ0E3ZjA2akNzSmM2Z3hxdjlQNmIyZG1YSHA1NVprYzdl?=
 =?utf-8?B?V1lJZUF4eVNTWHQ0cGNVd1VNcWcwWVBZbkRyUDBnL0F1RUVmekY5UUp5bnRQ?=
 =?utf-8?B?UnZaMHBIdnNyaVVhNlBFTjk1Uy96TFpCRExFbXFFTmxJTnNhY2c1OS9mWklN?=
 =?utf-8?B?K08yUkVOQkc5d0RuL1RzNjRvTjdCbndNTDJ3R2FKVi8zd2ovbmt6UW1VRnYy?=
 =?utf-8?Q?y9GB3uX8k+FMzjQ+5e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6c8630-c095-4ee8-a9a0-08df14b0e435
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 11:43:28.7225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKK89b4iy1G/kv71cVXLczFDnqEqrzY6SZsEP/Pz/OZlJhdwXViV56aG8PAzfgtj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715
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

On 9/17/26 11:05, Srinivasan Shanmugam wrote:
> Replace amdgpu_bo_kmap()/amdgpu_bo_kunmap() in the trap handler code
> with ttm_bo_vmap()/ttm_bo_vunmap().
> 
> Store the mapping as struct iosys_map and use iosys_map helpers for
> memory access. This aligns the trap code with the modern DRM/TTM mapping
> interfaces.
> 
> Using iosys_map allows the code to use common DRM mapping helpers
> instead of directly accessing memory through raw CPU pointers.

I'm really wondering if we shouldn't rework amdgpu_bo_kmap() into amdgpu_bo_vmap() and use that everywhere?

We can of course start with backward compatible return the kernel poiunter and then switch other users of amdgpu_bo_kmap() over to iosys_map one by one.

Regards,
Christian.

> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 31 +++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  2 +-
>  2 files changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> index 29eba2968350..eb842fe8aed1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> @@ -427,29 +427,29 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (r)
>  		goto err_exec;
>  
> -	/* VM resv already held — kmap directly, no separate reserve needed */
> -	r = amdgpu_bo_kmap(cwsr->tma_bo, &cwsr->tma_cpu_addr);
> +	/* VM resv already held, vmap directly without a separate reserve */
> +	r = ttm_bo_vmap(&cwsr->tma_bo->tbo, &cwsr->tma_map);
>  	if (r)
>  		goto err_tma;
>  
> -	memset(cwsr->tma_cpu_addr, 0, AMDGPU_TRAP_TMA_MAX_SIZE);
> +	iosys_map_memset(&cwsr->tma_map, 0, 0, AMDGPU_TRAP_TMA_MAX_SIZE);
>  
>  	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TMA);
>  	if (r)
> -		goto err_kmap;
> +		goto err_vmap;
>  
>  	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TBA);
>  	if (r) {
>  		amdgpu_trap_unmap_region(adev, cwsr, AMDGPU_TRAP_TMA);
> -		goto err_kmap;
> +		goto err_vmap;
>  	}
>  
>  	drm_exec_fini(&exec);
>  	*trap_obj = cwsr;
>  	return 0;
>  
> -err_kmap:
> -	amdgpu_bo_kunmap(cwsr->tma_bo);
> +err_vmap:
> +	ttm_bo_vunmap(&cwsr->tma_bo->tbo, &cwsr->tma_map);
>  err_tma:
>  	amdgpu_bo_unref(&cwsr->tma_bo);
>  err_exec:
> @@ -524,7 +524,7 @@ void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  err:
>  	drm_exec_fini(&exec);
>  	/* TMA BO not pinned — release CPU mapping and free */
> -	amdgpu_bo_kunmap((*trap_obj)->tma_bo);
> +	ttm_bo_vunmap(&(*trap_obj)->tma_bo->tbo, &(*trap_obj)->tma_map);
>  	amdgpu_bo_unref(&(*trap_obj)->tma_bo);
>  	kfree(*trap_obj);
>  	*trap_obj = NULL;
> @@ -569,24 +569,24 @@ static int amdgpu_trap_set_l2_trap_handler(struct amdgpu_device *adev, struct am
>  					   struct amdgpu_trap_usr_addr *tma,
>  					   struct amdgpu_trap_usr_addr *tba)
>  {
> -	uint64_t *l1tma;
>  	int r;
>  
>  	if (!amdgpu_trap_is_enabled(adev))
>  		return -EOPNOTSUPP;
>  
> -	if (!cwsr_obj || !cwsr_obj->tma_cpu_addr || !tma || !tba)
> +	if (!cwsr_obj || iosys_map_is_null(&cwsr_obj->tma_map) || !tma || !tba)
>  		return -EINVAL;
> +
>  	r = amdgpu_trap_validate_user_addr(adev, vm, tma);
>  	if (r)
>  		return r;
> +
>  	r = amdgpu_trap_validate_user_addr(adev, vm, tba);
>  	if (r)
>  		return r;
>  
> -	l1tma = (uint64_t *)(cwsr_obj->tma_cpu_addr);
> -	l1tma[0] = tma->addr;
> -	l1tma[1] = tba->addr;
> +	iosys_map_wr(&cwsr_obj->tma_map, 0, u64, tma->addr);
> +	iosys_map_wr(&cwsr_obj->tma_map, sizeof(u64), u64, tba->addr);
>  
>  	return 0;
>  }
> @@ -638,16 +638,13 @@ int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
>  				    struct amdgpu_trap_obj *cwsr_obj,
>  				    bool enabled)
>  {
> -	uint64_t *l1tma;
> -
>  	if (!amdgpu_trap_is_enabled(adev))
>  		return -EOPNOTSUPP;
>  
>  	if (!cwsr_obj)
>  		return -EINVAL;
>  
> -	l1tma = (uint64_t *)(cwsr_obj->tma_cpu_addr);
> -	l1tma[2] = enabled;
> +	iosys_map_wr(&cwsr_obj->tma_map, 2 * sizeof(u64), u64, enabled);
>  
>  	return 0;
>  }
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> index 6d4664469bad..57e338c91f0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> @@ -42,7 +42,7 @@ struct amdgpu_trap_obj {
>  	struct amdgpu_bo *tma_bo;
>  	struct amdgpu_bo_va *tba_va;
>  	struct amdgpu_bo_va *tma_va;
> -	void *tma_cpu_addr;
> +	struct iosys_map tma_map;
>  };
>  
>  struct amdgpu_trap_info {

