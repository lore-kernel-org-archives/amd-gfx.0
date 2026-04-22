Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB47DF9B5E0
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 08:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 484BA10E96C;
	Wed, 22 Apr 2026 08:29:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B1fBh96G";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013028.outbound.protection.outlook.com
 [40.93.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C55F510E96C
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 08:29:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwmhCT8JXkoh8pM7sd8BOS+5B3dTYBq4nuHbxPwDR82djDH1S732Irp0SRcRU3XUdQ4hhH0D8qsUSYEJ9y7sTSKlIvMroCwnFHEdGKdEPFfGvY6ryUbWL8u5t50Gw0pXO2sntJT6pcmKeOBkcSWvhkb+HXIlsd4KfYjr/2ZJvQzeTlQ9f3D9vt9ThqGUda3lHV8xO2z0k4htqDq1BTEw+wiNmMX+y2Gbb0UFR+NKshcFIfzWFu/Bba7YfO2YnF5rdeidQ/14WG6ri/vVOgGxx1E3cD2vgvatqGOoP/nzwWNH1qrRMNa/oJm4WUrNfnN7vc+dJeAA0cGD5b7wms+YyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z++6S5reEkOEPSDKhS8SOy9pHK1MVT/dT3aLf9lOZUI=;
 b=a0MtJrHNxfMV/xyizwTHRVTgiYis4k1/9zlFkBef8dMSzown1s7HPpmlXAB0ZejUIzzu24NmphWvc5gMMaFxe6evhVwdyqyIRd+2CdN7w0Q55sBgP39Bndfy/XeQXpU0OpYQ+jkF0wLLKAewRCXFo/+C9RNz2SLUG5WA0bO27Ci/eIJ3BlmuMk5PfxUxAdvzwiJXuuq881nX5gPNqFuFXR0FpvtTlijjCpE33+I8/J5H+hB4oUCktWoWcD8/P90hKUju8ZXQawQiIzaDpHZlKxzEcvjgu+jADDWDQgMj9KbTLhz+yYQEcZacUz91a7cheJvO5qfyO9HjcWoBTLU3uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z++6S5reEkOEPSDKhS8SOy9pHK1MVT/dT3aLf9lOZUI=;
 b=B1fBh96Gwzd3ehhMRRj3NX8DU837Ir5Id5Uzdoq97NWXiueXimSIDATtHQ/EiAuHVB905cExEK9jP8j0CvZRdMmXKJAfB3iK7hQaCMEsVbXWG8uEuvnd5kSxKO7bUuLhS+tUEaFQIN4oO+2TfUD4UrR+lVibSPGq+wFslNa7lfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.15; Wed, 22 Apr 2026 08:29:43 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9846.014; Wed, 22 Apr 2026
 08:29:42 +0000
Content-Type: multipart/alternative;
 boundary="------------n0h6lQqewWVFXPLFfOv0Jj70"
Message-ID: <4a0892be-46b9-4720-9b7e-398aa0a74c87@amd.com>
Date: Wed, 22 Apr 2026 13:59:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] drm/amdgpu: nuke amdgpu_userq_fence_free
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, Prike.Liang@amd.com, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-3-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260421125513.4545-3-christian.koenig@amd.com>
X-ClientProxiedBy: BM1P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::35) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c30b472-2ea3-4865-5b95-08dea0494ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18096099003|56012099003|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: mOeg5ymMKxYFxCPbmcX8pQQXmPJejAj5kMc284UNbKtSO3v0iW61SQJwfIC01XmSUFTb9YPVF0uQ6wA6ZDA2ohpaJCNaw25FmrthVJnL/xoQguQxy8L1QIBUyTMWmHSqgb6Ibww3b5pdgwG1tSE2ew55RaMXUVXa9Zh+PcDUydbbf83tMAjSZzXhMXIyVGjXNf1UPBvT8zzmG6zfTDUYgnTd5jvKnkrbHzAutlm5Ug1aTl84V6z1uKp7ORYBVW6BRqG9VevxtHPy4/+B5RD4aqnL0hNh0sC0DKQnlgv0pEpbXgN9Tr7cmoIdYBmHM3ld6ei9Kla3Flc0AB9ImpLGThjBV2iVppThVMz4QCk6hlcKsAtQrb45JkUd3iIfoCb7Pv2oUcBx2H5HwR32NzTb1wl+N10Jb8wmz6Z8JzJK6Qfghp9RHq1bfZqdDO8H02rCVms0J0u4/R471jJwS/i1ftc68EUF6Z2N8mhETj03il3JwD4VX9whjUFW3TE8TELQbmKX3RXOEfhjdpe4YhaoSYTTI+kSg4EB6UswRUvcWbKgupH4Hv+qHI7pAdg1tXkLTWyTsPcfAggkAAVvmWmTQkCeyEHjKRG0Esv8QsO1fzeKNXWsmh+mpJFP3N8Z0B3tmMGHG89wRdwDFAR5GeRbcyI+735n6zuNLmAoKnbAnDDk4TwBifJqYr8TZdYoZE9uBrQyqRFUFFv0H814odwQAgYPskw3IAaiIjskTG+HxPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18096099003)(56012099003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUE1cG1pVjV1Vmx5UUVZd1lXZEl5elVWWGQxWENyK1pteXVwRnB6RDRXU01o?=
 =?utf-8?B?UzlUSHVMT1lNM3YxaVk2enU3cm5NTmNRS2w5UVJhQjE0SkRwdUk1cTBSZitN?=
 =?utf-8?B?TTRWTTllckkwT0t3YnRRSkxkTmlybTRkVkwraDZLSTIxcklUZDBQcHVjSXVp?=
 =?utf-8?B?SmZEODRRNjhiTTNWYmRwMFVtUWNDOFJqRE5xMUV1emVQZWRqUFMwdWZFNUlC?=
 =?utf-8?B?VlJ2bUlKbE1ldDE3aXZDaDEzemdZelBkMUJMV0pzRVF3b01MODI3NlprazZG?=
 =?utf-8?B?ZzUxQ0FmWHcrOTlWNjlxWjhabnozVkI1bEc1OURObUxkYjdLZVA1SmI1Nk9N?=
 =?utf-8?B?YkVVV1NySWFOT21TeVNTWVk2c2lSdk0xcWUyQjZ4bmE0SWpxQ1VWSjBSVUVY?=
 =?utf-8?B?MlFkVEFpeTZWalcxeGdFUGV1dEdzTXRGd3hrci9HcjFySW40dFNjUmxXRkFj?=
 =?utf-8?B?L1Y5U1hwYUFILzVaZ1ZxN01Od0Q1Nk9CU2Z6OFdhQjdHNWsxbWpqc1lTMHc2?=
 =?utf-8?B?SmV5L3lud3Y1WWQ2ZzdjaWV5UUFibG1ZYWFObk5wcmtHWThaejRZV0hJdGF4?=
 =?utf-8?B?bGJXR1g0Zlg4d3JaMVFhK1cvMVp4eEpaZStFbGNCa2RSWlFaN1FFU0lyTWRy?=
 =?utf-8?B?TDVSVVVycnA2YUI3OVhweU8vUVFNODI1cndMRnlaZGhVS3dNOUxvbVE0ZHBY?=
 =?utf-8?B?Tk1Za3VLcDBEbThyTzNuRlNuQXZvMGVCNlNyQmFTUlNMWU5qcVc2ZWdpSGhF?=
 =?utf-8?B?WXNoemVjY0tYM0dsWE9sWVhSeDU3TXd4TWhEVHdFS0drV296MjZVTGYzTFlU?=
 =?utf-8?B?V2tuNGtRNlBqdzRZUWNncWxHN0NyMnRDRUtCZ2NNTjZVRU8rMm5Ra3lkQlRj?=
 =?utf-8?B?OHZqeWNFL2dHelAzTWNiaDZjR2FXNGhaak1XS2QxVFdaM1V3RGZ0T3ZTdGN3?=
 =?utf-8?B?cVVTRGUvOTliNlFDOWJiU1VubGhkM1d0VE5zMUtMOWY5WEl1YzVURkoreFFH?=
 =?utf-8?B?VjFVYzdJazI2STZFT096QnYvZkZEMncxMDRyWmVORHV1a0Rsd3VDYkYrRm41?=
 =?utf-8?B?NGVBNllWZE9TUUdPdStmRGh4Y3JnaDhFVis5QUNSK0NWa0NMdW43b1hSS0My?=
 =?utf-8?B?d3JNMDU3RFd2ZVZVUlhoSDluVDJSZWo1YkZxSW1Rd0VyVW00TVRUR3BFRVc5?=
 =?utf-8?B?Q1BBOG1ONUEyV0tQM3pybjVVcXVGb0ZTbi8vRkoxSjc3WElWSXYydkFYRFB4?=
 =?utf-8?B?NGZwb21COXFTaUVvajBUNzB4K09iajNNRS9yNHlQTVhGdW01MkhIY3dOdE5Z?=
 =?utf-8?B?MVRtRHJ0eHUwQlcwUktlRTJqVHZ1VHpYdWJpaDdRYllseWFhU2Fhbi81NWNi?=
 =?utf-8?B?aFl6UEhMV3FwdmpZWW5RVU83NDFaY2wrT0lOYkNBbmp5MGpMZlZNUFdFNnpU?=
 =?utf-8?B?QXZNcGJndGh6YWQxSFZNTFY5TFE1cTBxWjRxRkd3TWhJanR6MktkS3JqY0sy?=
 =?utf-8?B?MHJGWi9mam9tOUlvRExzWmNzUVRnMFJ0eGlEdWxoeGdXald4UkUzZEVPUGRq?=
 =?utf-8?B?YURHdDZWV0h4TnRxVDZjeG1FOUdYOG9pMFpOdUI4V3Ztc2cvelBLUlNoaC8z?=
 =?utf-8?B?cFE0UlNpcE5RMFR5WGtIYytkZmxqWkxqTWxYeTUrWENoem9ya2IzSXNxUE9J?=
 =?utf-8?B?M2FOMjFLNkluM1RVTXBFV1huazM0REJ3WUIzN0NVMEtENXNoYlBvT1owNTFq?=
 =?utf-8?B?SHJIR0xUMmxEWWpadUhib1dUT3BIRkpLZWRRQitHWHNJdHlzNWtiM0FWemNj?=
 =?utf-8?B?ZTQwZWM2VXJEK3lvVnk1UjJiemZ1aURHbmRiTm9RRUhUaS8zUHdWZTNpYkRn?=
 =?utf-8?B?YjV2MDJaem1WQ2VpZ2hFSFh6NHQ4OGkvOUwyeXRYZDk3SW1qdVlkSUpJSU5t?=
 =?utf-8?B?RkJOVWQ4SWxvU2lyYTBqOEphd3hCM3Fjbi9nOWZsMnB1bGJuQzZxalZCYW12?=
 =?utf-8?B?OGRPQTRVeWI4SWNJZVJOdE1VVnRWVzNRYnAwNWk2UnR3aTN1dzJ0ekpka3JR?=
 =?utf-8?B?RTZxZHFjQXJINVUrMFMybng1UGdqQzVYdmJUSmhjNVhoaUdsRGtVM1J3ZkFD?=
 =?utf-8?B?ck9yL0UvbHg5NUhzQTlNQSs5TlpUUzVMODFJM0Q4b2Niek9IU2ZkMG9yTnRR?=
 =?utf-8?B?NFVZbkswK2ZmeHJHQzBvWDF6RHpHL3NzU251dXlCRnZFNmp3dWdoaEFDWEtU?=
 =?utf-8?B?RnlqRzNrSGNiSHVnQSsyNUV5TTBpNS9wNlkwQ1h4QkxRdisrRWlNWEcycEJG?=
 =?utf-8?B?Tm5WSDZtUWs1bUZSQmY2OUFoWXBRcVcweUtFNTFmczNlTlBVSnNldz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c30b472-2ea3-4865-5b95-08dea0494ca3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 08:29:41.4625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWVRQyc7Wyj38CPJ/lE7djLOOuNmpswmNHjz0Zz06ONdV6YOKrLdxmkc8wLuKNRLFNAqQc6xfKfQqviYE+vnnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592
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

--------------n0h6lQqewWVFXPLFfOv0Jj70
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 21-04-2026 06:25 pm, Christian König wrote:
> As preparation for independent fences remove the function and do all of
> it's cleanup directly after signaling.
>
> Signed-off-by: Christian König<christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 13 +--
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 79 +++++++------------
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  3 -
>   3 files changed, 31 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index c6546a858597..1b15b51dc3f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3162,11 +3162,7 @@ static int __init amdgpu_init(void)
>   
>   	r = amdgpu_sync_init();
>   	if (r)
> -		goto error_sync;
> -
> -	r = amdgpu_userq_fence_slab_init();
> -	if (r)
> -		goto error_fence;
> +		return r;
>   
>   	amdgpu_register_atpx_handler();
>   	amdgpu_acpi_detect();
> @@ -3182,12 +3178,6 @@ static int __init amdgpu_init(void)
>   
>   	/* let modprobe override vga console setting */
>   	return pci_register_driver(&amdgpu_kms_pci_driver);
> -
> -error_fence:
> -	amdgpu_sync_fini();
> -
> -error_sync:
> -	return r;
>   }
>   
>   static void __exit amdgpu_exit(void)
> @@ -3197,7 +3187,6 @@ static void __exit amdgpu_exit(void)
>   	amdgpu_unregister_atpx_handler();
>   	amdgpu_acpi_release();
>   	amdgpu_sync_fini();
> -	amdgpu_userq_fence_slab_fini();
>   	mmu_notifier_synchronize();
>   	amdgpu_xcp_drv_release();
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index a58342c2ac44..909bdccc2a92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -32,29 +32,9 @@
>   #include "amdgpu.h"
>   #include "amdgpu_userq_fence.h"
>   
> -static const struct dma_fence_ops amdgpu_userq_fence_ops;
> -static struct kmem_cache *amdgpu_userq_fence_slab;
> -
>   #define AMDGPU_USERQ_MAX_HANDLES	(1U << 16)
>   
> -int amdgpu_userq_fence_slab_init(void)
> -{
> -	amdgpu_userq_fence_slab = kmem_cache_create("amdgpu_userq_fence",
> -						    sizeof(struct amdgpu_userq_fence),
> -						    0,
> -						    SLAB_HWCACHE_ALIGN,
> -						    NULL);
Are we not having benefit enough to continue create a cache here ? If 
that is fine that LGTM,

Acked-by: Sunil Khatri <sunil.khatri@amd.com>

Regards
Sunil



> -	if (!amdgpu_userq_fence_slab)
> -		return -ENOMEM;
> -
> -	return 0;
> -}
> -
> -void amdgpu_userq_fence_slab_fini(void)
> -{
> -	rcu_barrier();
> -	kmem_cache_destroy(amdgpu_userq_fence_slab);
> -}
> +static const struct dma_fence_ops amdgpu_userq_fence_ops;
>   
>   static inline struct amdgpu_userq_fence *to_amdgpu_userq_fence(struct dma_fence *f)
>   {
> @@ -146,12 +126,18 @@ amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
>   }
>   
>   static void
> -amdgpu_userq_fence_put_fence_drv_array(struct amdgpu_userq_fence *userq_fence)
> +amdgpu_userq_fence_put_fence_drv_refs(struct amdgpu_userq_fence *userq_fence)
>   {
>   	unsigned long i;
> +
>   	for (i = 0; i < userq_fence->fence_drv_array_count; i++)
>   		amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
>   	userq_fence->fence_drv_array_count = 0;
> +	kfree(userq_fence->fence_drv_array);
> +	userq_fence->fence_drv_array = NULL;
> +
> +	amdgpu_userq_fence_driver_put(userq_fence->fence_drv);
> +	userq_fence->fence_drv = NULL;
>   }
>   
>   void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
> @@ -181,10 +167,11 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
>   		fence = &userq_fence->base;
>   		list_del_init(&userq_fence->link);
>   		dma_fence_signal(fence);
> -		/* Drop fence_drv_array outside fence_list_lock
> +		/*
> +		 * Drop fence_drv_array outside fence_list_lock
>   		 * to avoid the recursion lock.
>   		 */
> -		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
> +		amdgpu_userq_fence_put_fence_drv_refs(userq_fence);
>   		dma_fence_put(fence);
>   	}
>   
> @@ -231,7 +218,7 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
>   
>   static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)
>   {
> -	*userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab, GFP_ATOMIC);
> +	*userq_fence = kmalloc(sizeof(**userq_fence), GFP_ATOMIC);
>   	return *userq_fence ? 0 : -ENOMEM;
>   }
>   
> @@ -299,7 +286,7 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>   	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>   
>   	if (signaled)
> -		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
> +		amdgpu_userq_fence_put_fence_drv_refs(userq_fence);
>   
>   	*f = fence;
>   
> @@ -333,29 +320,10 @@ static bool amdgpu_userq_fence_signaled(struct dma_fence *f)
>   	return false;
>   }
>   
> -static void amdgpu_userq_fence_free(struct rcu_head *rcu)
> -{
> -	struct dma_fence *fence = container_of(rcu, struct dma_fence, rcu);
> -	struct amdgpu_userq_fence *userq_fence = to_amdgpu_userq_fence(fence);
> -	struct amdgpu_userq_fence_driver *fence_drv = userq_fence->fence_drv;
> -
> -	/* Release the fence driver reference */
> -	amdgpu_userq_fence_driver_put(fence_drv);
> -
> -	kvfree(userq_fence->fence_drv_array);
> -	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
> -}
> -
> -static void amdgpu_userq_fence_release(struct dma_fence *f)
> -{
> -	call_rcu(&f->rcu, amdgpu_userq_fence_free);
> -}
> -
>   static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>   	.get_driver_name = amdgpu_userq_fence_get_driver_name,
>   	.get_timeline_name = amdgpu_userq_fence_get_timeline_name,
>   	.signaled = amdgpu_userq_fence_signaled,
> -	.release = amdgpu_userq_fence_release,
>   };
>   
>   /**
> @@ -546,7 +514,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence);
>   	if (r) {
>   		mutex_unlock(&userq_mgr->userq_mutex);
> -		kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
> +		kfree(userq_fence);
>   		goto put_gobj_write;
>   	}
>   
> @@ -871,6 +839,7 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>   	for (i = 0, cnt = 0; i < num_fences; i++) {
>   		struct amdgpu_userq_fence_driver *fence_drv;
>   		struct amdgpu_userq_fence *userq_fence;
> +		unsigned long flags;
>   		u32 index;
>   
>   		userq_fence = to_amdgpu_userq_fence(fences[i]);
> @@ -886,7 +855,19 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>   			continue;
>   		}
>   
> +		spin_lock_irqsave(userq_fence->base.lock, flags);
> +		if (dma_fence_is_signaled_locked(&userq_fence->base)) {
> +			/*
> +			 * It is possible that fence is already signaled and the
> +			 * fence_drv now NULL, just skip over such fences.
> +			*/
> +			spin_unlock_irqrestore(userq_fence->base.lock, flags);
> +			continue;
> +		}
>   		fence_drv = userq_fence->fence_drv;
> +		amdgpu_userq_fence_driver_get(fence_drv);
> +		spin_unlock_irqrestore(userq_fence->base.lock, flags);
> +
>   		/*
>   		 * We need to make sure the user queue release their reference
>   		 * to the fence drivers at some point before queue destruction.
> @@ -895,10 +876,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>   		 */
>   		r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
>   			     xa_limit_32b, GFP_KERNEL);
> -		if (r)
> +		if (r) {
> +			amdgpu_userq_fence_driver_put(fence_drv);
>   			goto put_waitq;
> -
> -		amdgpu_userq_fence_driver_get(fence_drv);
> +		}
>   
>   		/* Store drm syncobj's gpu va address and value */
>   		fence_info[cnt].va = fence_drv->va;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> index d56246ad8c26..d355a0eecc07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> @@ -58,9 +58,6 @@ struct amdgpu_userq_fence_driver {
>   	char timeline_name[TASK_COMM_LEN];
>   };
>   
> -int amdgpu_userq_fence_slab_init(void);
> -void amdgpu_userq_fence_slab_fini(void);
> -
>   void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv);
>   void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
>   int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
--------------n0h6lQqewWVFXPLFfOv0Jj70
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <br>
  <body>
    <div class="moz-cite-prefix">On 21-04-2026 06:25 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260421125513.4545-3-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">As preparation for independent fences remove the function and do all of
it's cleanup directly after signaling.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 13 +--
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 79 +++++++------------
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  3 -
 3 files changed, 31 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c6546a858597..1b15b51dc3f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3162,11 +3162,7 @@ static int __init amdgpu_init(void)
 
 	r = amdgpu_sync_init();
 	if (r)
-		goto error_sync;
-
-	r = amdgpu_userq_fence_slab_init();
-	if (r)
-		goto error_fence;
+		return r;
 
 	amdgpu_register_atpx_handler();
 	amdgpu_acpi_detect();
@@ -3182,12 +3178,6 @@ static int __init amdgpu_init(void)
 
 	/* let modprobe override vga console setting */
 	return pci_register_driver(&amp;amdgpu_kms_pci_driver);
-
-error_fence:
-	amdgpu_sync_fini();
-
-error_sync:
-	return r;
 }
 
 static void __exit amdgpu_exit(void)
@@ -3197,7 +3187,6 @@ static void __exit amdgpu_exit(void)
 	amdgpu_unregister_atpx_handler();
 	amdgpu_acpi_release();
 	amdgpu_sync_fini();
-	amdgpu_userq_fence_slab_fini();
 	mmu_notifier_synchronize();
 	amdgpu_xcp_drv_release();
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a58342c2ac44..909bdccc2a92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -32,29 +32,9 @@
 #include &quot;amdgpu.h&quot;
 #include &quot;amdgpu_userq_fence.h&quot;
 
-static const struct dma_fence_ops amdgpu_userq_fence_ops;
-static struct kmem_cache *amdgpu_userq_fence_slab;
-
 #define AMDGPU_USERQ_MAX_HANDLES	(1U &lt;&lt; 16)
 
-int amdgpu_userq_fence_slab_init(void)
-{
-	amdgpu_userq_fence_slab = kmem_cache_create(&quot;amdgpu_userq_fence&quot;,
-						    sizeof(struct amdgpu_userq_fence),
-						    0,
-						    SLAB_HWCACHE_ALIGN,
-						    NULL);</pre>
    </blockquote>
    Are we not having benefit enough to continue create a cache here ?
    If that is fine that LGTM,&nbsp;
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt">Acked-by:
      Sunil
      Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a></p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt">Regards<br>
      Sunil</p>
    <br>
    <br>
    <blockquote type="cite" cite="mid:20260421125513.4545-3-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">
-	if (!amdgpu_userq_fence_slab)
-		return -ENOMEM;
-
-	return 0;
-}
-
-void amdgpu_userq_fence_slab_fini(void)
-{
-	rcu_barrier();
-	kmem_cache_destroy(amdgpu_userq_fence_slab);
-}
+static const struct dma_fence_ops amdgpu_userq_fence_ops;
 
 static inline struct amdgpu_userq_fence *to_amdgpu_userq_fence(struct dma_fence *f)
 {
@@ -146,12 +126,18 @@ amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
 }
 
 static void
-amdgpu_userq_fence_put_fence_drv_array(struct amdgpu_userq_fence *userq_fence)
+amdgpu_userq_fence_put_fence_drv_refs(struct amdgpu_userq_fence *userq_fence)
 {
 	unsigned long i;
+
 	for (i = 0; i &lt; userq_fence-&gt;fence_drv_array_count; i++)
 		amdgpu_userq_fence_driver_put(userq_fence-&gt;fence_drv_array[i]);
 	userq_fence-&gt;fence_drv_array_count = 0;
+	kfree(userq_fence-&gt;fence_drv_array);
+	userq_fence-&gt;fence_drv_array = NULL;
+
+	amdgpu_userq_fence_driver_put(userq_fence-&gt;fence_drv);
+	userq_fence-&gt;fence_drv = NULL;
 }
 
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
@@ -181,10 +167,11 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 		fence = &amp;userq_fence-&gt;base;
 		list_del_init(&amp;userq_fence-&gt;link);
 		dma_fence_signal(fence);
-		/* Drop fence_drv_array outside fence_list_lock
+		/*
+		 * Drop fence_drv_array outside fence_list_lock
 		 * to avoid the recursion lock.
 		 */
-		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
+		amdgpu_userq_fence_put_fence_drv_refs(userq_fence);
 		dma_fence_put(fence);
 	}
 
@@ -231,7 +218,7 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
 
 static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)
 {
-	*userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab, GFP_ATOMIC);
+	*userq_fence = kmalloc(sizeof(**userq_fence), GFP_ATOMIC);
 	return *userq_fence ? 0 : -ENOMEM;
 }
 
@@ -299,7 +286,7 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 	spin_unlock_irqrestore(&amp;fence_drv-&gt;fence_list_lock, flags);
 
 	if (signaled)
-		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
+		amdgpu_userq_fence_put_fence_drv_refs(userq_fence);
 
 	*f = fence;
 
@@ -333,29 +320,10 @@ static bool amdgpu_userq_fence_signaled(struct dma_fence *f)
 	return false;
 }
 
-static void amdgpu_userq_fence_free(struct rcu_head *rcu)
-{
-	struct dma_fence *fence = container_of(rcu, struct dma_fence, rcu);
-	struct amdgpu_userq_fence *userq_fence = to_amdgpu_userq_fence(fence);
-	struct amdgpu_userq_fence_driver *fence_drv = userq_fence-&gt;fence_drv;
-
-	/* Release the fence driver reference */
-	amdgpu_userq_fence_driver_put(fence_drv);
-
-	kvfree(userq_fence-&gt;fence_drv_array);
-	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
-}
-
-static void amdgpu_userq_fence_release(struct dma_fence *f)
-{
-	call_rcu(&amp;f-&gt;rcu, amdgpu_userq_fence_free);
-}
-
 static const struct dma_fence_ops amdgpu_userq_fence_ops = {
 	.get_driver_name = amdgpu_userq_fence_get_driver_name,
 	.get_timeline_name = amdgpu_userq_fence_get_timeline_name,
 	.signaled = amdgpu_userq_fence_signaled,
-	.release = amdgpu_userq_fence_release,
 };
 
 /**
@@ -546,7 +514,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &amp;fence);
 	if (r) {
 		mutex_unlock(&amp;userq_mgr-&gt;userq_mutex);
-		kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
+		kfree(userq_fence);
 		goto put_gobj_write;
 	}
 
@@ -871,6 +839,7 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 	for (i = 0, cnt = 0; i &lt; num_fences; i++) {
 		struct amdgpu_userq_fence_driver *fence_drv;
 		struct amdgpu_userq_fence *userq_fence;
+		unsigned long flags;
 		u32 index;
 
 		userq_fence = to_amdgpu_userq_fence(fences[i]);
@@ -886,7 +855,19 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 			continue;
 		}
 
+		spin_lock_irqsave(userq_fence-&gt;base.lock, flags);
+		if (dma_fence_is_signaled_locked(&amp;userq_fence-&gt;base)) {
+			/*
+			 * It is possible that fence is already signaled and the
+			 * fence_drv now NULL, just skip over such fences.
+			*/
+			spin_unlock_irqrestore(userq_fence-&gt;base.lock, flags);
+			continue;
+		}
 		fence_drv = userq_fence-&gt;fence_drv;
+		amdgpu_userq_fence_driver_get(fence_drv);
+		spin_unlock_irqrestore(userq_fence-&gt;base.lock, flags);
+
 		/*
 		 * We need to make sure the user queue release their reference
 		 * to the fence drivers at some point before queue destruction.
@@ -895,10 +876,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 		 */
 		r = xa_alloc(&amp;waitq-&gt;fence_drv_xa, &amp;index, fence_drv,
 			     xa_limit_32b, GFP_KERNEL);
-		if (r)
+		if (r) {
+			amdgpu_userq_fence_driver_put(fence_drv);
 			goto put_waitq;
-
-		amdgpu_userq_fence_driver_get(fence_drv);
+		}
 
 		/* Store drm syncobj's gpu va address and value */
 		fence_info[cnt].va = fence_drv-&gt;va;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index d56246ad8c26..d355a0eecc07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -58,9 +58,6 @@ struct amdgpu_userq_fence_driver {
 	char timeline_name[TASK_COMM_LEN];
 };
 
-int amdgpu_userq_fence_slab_init(void);
-void amdgpu_userq_fence_slab_fini(void);
-
 void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv);
 void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
</pre>
    </blockquote>
  </body>
</html>

--------------n0h6lQqewWVFXPLFfOv0Jj70--
