Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17C0C43458
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2026 07:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ADE810F6B5;
	Fri,  3 Jul 2026 07:44:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oK9498WJ";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D42310F6B5
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 07:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zd+rBEyXwjlaSVlZLUww+mASI3C/HhcZ5QR0S8zQADveudD9AAcbhzOqlcUkr5ISH0IMD5eQ4ysFY624l9lmoWxX6qoQJEgzaa7rpWS25SMhzMTLAbSzKVNgQdAWj8fWr2/h4lLHdzMmHOCTXQ8ZDn2yhMTBFe6Me3bcV6NP/bagsMpeCjGW6rUghK7Y2nbi2DPF4M6rGRniDzxWsRcCCTpS+H1uDPZayHB6S1tTg2q6QLMBwfewrnrsK943WppX+6wCpRaBTcNp/+EjJUuk5RyCc55RGjfNu52RXEH4qBfF4Ygc8XC+5wFZpc1SrjcO2UG7lnHykWckwR+NfM1Zbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8eeEh7kPtf9jZ9ga3zgLIcaiWaOlM8g4buWK0t12XE=;
 b=l4uOcNRi61NVGSWQ5chS1m8Hmg3o5HokZW3y3CsGZxq73VV2/niDmtViGK1ddoJ1qBpT81RoCLxqJZyTJpYS6Z2FejmmErIZiR/gOVh5Hh29xnMtSPVaSUN5LtE4OvX4G+iHIxHJp8KFscah2cbA2Vj8lU45Ijk+M6E18ZkpN+6m7y9I/a6Pv72AE/A6WBVN2VluVlF7FNSOlxbR1wQqNo0cpaAqTW/WLV6Jc1D0SObROOz9UpOcT6yxIanpbK96yLYU50CJVTXkui0yaoXf37TiLdXGIUzqLbacISgzFLAPW/CJGn/SZRrVi8u0ck2PaSK+RrEDHyBDMOI7yhQShQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8eeEh7kPtf9jZ9ga3zgLIcaiWaOlM8g4buWK0t12XE=;
 b=oK9498WJrYdn8dIBL++rrnDcx8PxGmBFqruDqMgbI74kCsZQSZMhwlBqmH9rkFkK36h2areOh5Wpt0cpk3jB0J7MQ54W2g5dURxF2IfJmNxkOFz0JC56X3pwgUnfQ6V4oPOQG4SLvo9y1DN8epuSMETlYpS0fYsoWQ535P730Mk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8903.namprd12.prod.outlook.com (2603:10b6:610:17a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 07:44:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 07:44:10 +0000
Message-ID: <3f732fbc-5a36-4818-9247-4539ed791872@amd.com>
Date: Fri, 3 Jul 2026 09:44:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] drm/amdgpu: Drop vm_manager PASID to VM mapping
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260703061833.3163913-1-srinivasan.shanmugam@amd.com>
 <20260703061833.3163913-4-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260703061833.3163913-4-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c406b22-ee91-42b9-ef9c-08ded8d6de92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: lzVhZ8VQb0Ir12IjOdBihWibHU2lWsfo/neloW+YBrYynJAHLsEn5ZXpY6vo6Y5mYl4gogg3bDTORrLQK3D3jOvmAm0rFMXhaxIjof21BtihqcQJvd9yABGWsYOvn2BFirP0wU5f7G7cyhfM4Uq2+yyFZlzQJf9AAG5vaZ1+ZVSslQIkv9RB/gQFDpALeyuYQKPczSMRTqn6nir8TTivsHTyhsQRa3k/uv/Lx5uqHQYej4bzOUnkIrpb5B9TWRS6xEWNXI0EDxjMQlUo1PnZUMJ2RtefbJ6vxuRu+4t9vJ2cp2g5ye5kHn9d3gjdnEdIY9lV95DkxVvqJ/QXXS85nwyBI0avU7xm/Nhhok4yz0VcsG4YaOuyMdzIaELntFHrFwFKkpHYiYlHAPyO/8th9Lv9GueO40uNHJLYNYukiEljK/DTkMJv7qtvtgSih6VZp/vusgYo3ZyfEdkVTGgPeea06/p85szG1zcHOoCKo0jH9jCfh1sDJXTaqV+SMq1wulsw6Dlq1b1AxXvOSho31hElFKRj2ZBvYEc9fBFqw08CBkFrDebQzj5DVmVSDA9GZJoteLIfsif0i08ZwBc+++nbAhpvBV7yaKwH6NZSIoNfl6utvtSCGJC7sZLKCym3iIJMT7oT8V3dxbFIcDTy31th2slnAy4zTQP7NX6CKL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGl0eko4anBLQjBjTlJvOTFYa2p4TWdoK0dpWXQzcmtrOFJTNGdFOWRKQjJy?=
 =?utf-8?B?MllIWStzOEtHYjR6RzdDdXR5dDVhT1hhRXdiTE1qYlV6K0JGa1I0TFRUTzJj?=
 =?utf-8?B?YUlsRkRjSXhLL1FPZ1FuQUI5TjQ4aEhhcU1lS2J5Tkk4WnFsVzdXSThoVlVF?=
 =?utf-8?B?T3JBU2NseGp1Qk9oT3dqOUk0KzU0Q1QrVEZFOW8ydTJnZjlsMUp1Z0QvMTlR?=
 =?utf-8?B?NEI1YVZnd1h6Z00ybWkwakw5SW1SVFM1QzdjNVIzaGpPS1J5UHJPM2hSTUFk?=
 =?utf-8?B?UDNrNHJmRUpnS3g4VUNySlhvaVVFRHk1dnNMK1dkQ1NuZFBSSllFNGY0amxR?=
 =?utf-8?B?c3lGaC9NUlI1c1JPVGZLczJUVDZjcnNBUlVYYk5pbThaR2FBTHQwaFZJN1RD?=
 =?utf-8?B?VXo4ZlBpdjBVWE9WQ1B2b2V1SGVreTJpa1JGUTR4WVdoblVCcE1BaWpYaTBt?=
 =?utf-8?B?NmVBcTVMSFkvQlNwa3FXc241NU4xK2ZhMHV5V2N3cFZBU0ZRd2FnNFpkVE1o?=
 =?utf-8?B?RHZra3oxSjJXa1JDcENLZktuQXN5SlVlNnd1SER0ZFVtKy90SG5rdmRpNXpX?=
 =?utf-8?B?S2grNnF4TEV6QTRMMllkZTZYdDJhb1Q0cjdYU1pNYmxobC92bXMrM1ZhZ2Uv?=
 =?utf-8?B?dXY2dzN2VmVUaFZDZWpmVlZXN3hNOGtLbi8zYWY2YW5wSUwwaWNIbXQyOVRC?=
 =?utf-8?B?STRiSmFuMkgwRUxBVzhyWkFBWHEvcEN4QXVsSWZNdDBodFdMM0VwVVRIMnJj?=
 =?utf-8?B?aXk0MEkzWnpTSzRVSXpLVDFodHJNU0Q4VDhzYTBjMUpvd3lnQVNJMU5zdnUv?=
 =?utf-8?B?K3VPd0dWT25hWVJ6bGwrQnpMekw4NXJlQmxha0RoR3FsVmNMVUZvZXNCSHdy?=
 =?utf-8?B?YjRUTGJ3d0xPYm90Y3hqU1RIcHpvaDF6TTM0dXUyUEl2dHBpc2I0bE95S1JT?=
 =?utf-8?B?M1M3aTJXKzRONE5sdzJ5UjhmOHRRVzVId0dpQVI0RVdzNW9jRm1FMHhuNEJW?=
 =?utf-8?B?TDBsc0dQZW0vNmhvdEJNMHZJS21SZkk0REtaRFl6ZGRUejJscmxiTW9EUnVP?=
 =?utf-8?B?ek8xSElWMTdJK1RuSGZ3Vlc2NmpHNGg2WUVJNStFeDRIUmhLTGdTOXBNeENX?=
 =?utf-8?B?RFk5aDFCSkJqN1ZQNFhqUUZKVlI3d24rcnc2OUJwY0ZxdzQ2WjhIWFRlK2pI?=
 =?utf-8?B?L3NnL1dIQUk1a1JQWXlZQlpHTTFrVkFVZmFaOWNDNE9WTVRGZTJtbVdRUThH?=
 =?utf-8?B?RHQyR09FL3B5L3hZWktiTEc5MkxXLzlvNHVGZTVweHhhYU1ldlhNYVpLKytN?=
 =?utf-8?B?Y2FFRUV0MUcvdFhLd3hMWkhRaU00MW12ak9VSHFWYitFbGtWaEV3S05NNGJy?=
 =?utf-8?B?Tml2Z2NjV21GZVE0a1dXaG9UenNDc2pqZmUzdVpzZmhXU0VnTjV5UDdydS81?=
 =?utf-8?B?TW1uVzA2ckxzb0Q1OUVyZUUwS2l1ZWpQb1BoZE9rcEZGWndxRzl4ME9pYkJS?=
 =?utf-8?B?NDBpUGhaanVveGdpSFBwcGFCRG1ja0F3Z2V5ZEtjU0o0NE5yN3FqdUowa3dh?=
 =?utf-8?B?WHFINjF0VkFMVTltVnFhKy80YkxDMjVnK2I4bW13SXVJU2R1UlVZWmZvdmNo?=
 =?utf-8?B?aGc2ekxVa3Z0cGJ3WmtRTWFNeGloYkI2R0JnUllSdVF4bTVYR2ZkTjkwNEdu?=
 =?utf-8?B?QmhhTmhMSnhSYVhGL0VCU1BkSWhPbDBiMXloVW05S3hRa2FnU3orRjB3c0lv?=
 =?utf-8?B?LytvYU03NUx5SGVBcHJPdjFqNnE3SlQrUzllZHc5SHNYSTFObjRjSFhqczBt?=
 =?utf-8?B?QkxSSzErSGhxWk9naDhFcW41MW45WTUyK1ExM2tOWDRtaUp6RXhDOVhGL3Jq?=
 =?utf-8?B?NlI1WE1SQ3BjSVhOMlVoMVpmUFdkbURtaHRCSnRjNjFEV0Q1Q2V1anBmdTRt?=
 =?utf-8?B?TGhTbCtrWlBjcCtEUzN0Z21GeHBOSHFnY2NNUm1Wbm8wZGNZajE2S1Y3Q0Rh?=
 =?utf-8?B?UzdsMU5NZDdQeXhMTVRySDB3MWY4YmlCZ1QxZ0RXQkkxWHlsM2tBS2JweFJL?=
 =?utf-8?B?QW5uN1JyZkRrTHBBUEJHZ2RRODArUHhNU3A3NmhNamwxVzBZd3J0QndpTzFk?=
 =?utf-8?B?Z1ZVUTB5VDZZUm4zbEVoVUR4aHpLWGpTNkZsUzZRR0haNmlCeksvczM2M01r?=
 =?utf-8?B?akNHUFZ3bkhRZjUrcDdDcE50OWI5bm41V1I0ZnlUcUt6L3B5SkYvQkdXT1Az?=
 =?utf-8?B?Vkh2bitHMFdmdmMyYlZDU2JmalhpWm82Z2JEVW9PRXFjbE14clYxR1o1V29K?=
 =?utf-8?Q?0sHyywbQfxPMWhqAzB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c406b22-ee91-42b9-ef9c-08ded8d6de92
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 07:44:10.3840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTZeG+UwPnY6tCITG4tD/wVTireA9UTp5zcJdJDqrvMfdSuhXAcTgXnWmSikZtLu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8903
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

On 7/3/26 08:18, Srinivasan Shanmugam wrote:
> VM lookup users now resolve DRM PASIDs through the global PASID xarray:
> 
> 	PASID -> fpriv -> VM
> 
> The per-device vm_manager.pasids xarray is no longer needed.
> 
> Remove PASID registration and teardown from VM init/fini paths, drop
> vm_manager PASID initialization/cleanup, and remove the xarray from
> struct amdgpu_vm_manager.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 25 ++-----------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  4 ----
>  2 files changed, 2 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 9092ff227a55..74836240edbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2647,14 +2647,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (r)
>  		dev_dbg(adev->dev, "Failed to create task info for VM\n");
>  
> -	/* Store new PASID in XArray (if non-zero) */
> -	if (pasid != 0) {
> -		r = xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, vm, GFP_KERNEL));
> -		if (r < 0)
> -			goto error_free_root;
> -
> -		vm->pasid = pasid;
> -	}
> +	vm->pasid = pasid;

What do we actually still need the pasid in the VM for?

Regards,
Christian.

>  
>  	amdgpu_bo_unreserve(vm->root.bo);
>  	amdgpu_bo_unref(&root_bo);
> @@ -2662,11 +2655,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	return 0;
>  
>  error_free_root:
> -	/* If PASID was partially set, erase it from XArray before failing */
> -	if (vm->pasid != 0) {
> -		xa_erase_irq(&adev->vm_manager.pasids, vm->pasid);
> -		vm->pasid = 0;
> -	}
> +	vm->pasid = 0;
>  	amdgpu_vm_pt_free_root(adev, vm);
>  	amdgpu_bo_unreserve(vm->root.bo);
>  	amdgpu_bo_unref(&root_bo);
> @@ -2773,11 +2762,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>  
>  	root = amdgpu_bo_ref(vm->root.bo);
>  	amdgpu_bo_reserve(root, true);
> -	/* Remove PASID mapping before destroying VM */
> -	if (vm->pasid != 0) {
> -		xa_erase_irq(&adev->vm_manager.pasids, vm->pasid);
> -		vm->pasid = 0;
> -	}
>  	dma_fence_wait(vm->last_unlocked, false);
>  	dma_fence_put(vm->last_unlocked);
>  	dma_fence_wait(vm->last_tlb_flush, false);
> @@ -2873,8 +2857,6 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
>  #else
>  	adev->vm_manager.vm_update_mode = 0;
>  #endif
> -
> -	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
>  }
>  
>  /**
> @@ -2886,9 +2868,6 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
>   */
>  void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
>  {
> -	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
> -	xa_destroy(&adev->vm_manager.pasids);
> -
>  	amdgpu_vmid_mgr_fini(adev);
>  	amdgpu_pasid_mgr_cleanup();
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 939f639cd8bf..f63364f128bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -481,10 +481,6 @@ struct amdgpu_vm_manager {
>  	 */
>  	int					vm_update_mode;
>  
> -	/* PASID to VM mapping, will be used in interrupt context to
> -	 * look up VM of a page fault
> -	 */
> -	struct xarray				pasids;
>  	/* Global registration of recent page fault information */
>  	struct amdgpu_vm_fault_info	fault_info;
>  };

