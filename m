Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC577FF885A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 07:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77B0010EA59;
	Tue, 28 Apr 2026 07:57:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e7hCE65m";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013019.outbound.protection.outlook.com
 [40.93.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 835CB10EA59
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 07:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4iC0yC0dv1/NwNRs5F3TN4/RnYtjOHokVMjEWfLbfgGq3y02JiqNd/bqHpVstwJDTr+RfZLRfkTUD2Q4dK4i0xbsWChsPDX4oVpQBg7ZP9cy72meGgFcoFHnjywOKG5eSr3x771mUlGH/UBZvUQRLVEhE5tQ/aW5JZnRJrN+Ep6fLxLHk05VjaXNxZfYDZEJPgJwdkeD5VaVvx1wddkggEkTKOKIko6g1g3FuFNIvr7CDOd4u2IWfDEVn4ElLnbuLhescUbq8yGux6cnpF7tAKRgh5wKVgaaHzfPmj7G/VAeY2W6QR5oYy+lfsrFuRUn4K3Ah/JE7B6qDzYGxXmRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mn51t7pNbb7NsrozIesrSjpCjmD2guR27PKnC8Z8HY0=;
 b=G8IAmhJTWBHb1dUs2IojVivI9i01va3XTnW4T0VrfQvV25VbfEW96MQJJWYm7UVSeWFhmtpW+bj328K1+Vb5jfFUsm2udMxzBDoOgQTFeUW4EiY7CTfJTAlUfSaMLKKodYRku4DljtDMBXBesykFRi17R8Uk1Cg3F8Ht+84Yh3JXjVWalXMJmtr4UwwTnLAMPQNRsf/1stsrFQtTcT1An/ZsVjDEUiUNVy5OxYaDjg8zc2CHNU5fzRk++0LU3lYEAAuDPTO2iaV2nWH2KmO4MSIsz3ZN/QYcZBxneGSIwwzdR6FulD7p0XUlR6RcU5tbzyTb4Z/7B7G4GQvkJoasOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mn51t7pNbb7NsrozIesrSjpCjmD2guR27PKnC8Z8HY0=;
 b=e7hCE65miHIRd6egLap454T/3dBumx1DJ4zFgyLFw+zlOLUEJEo8qWeJDAqWtQGgvJpfo7CjTCkabdpxPJOwEAUP1hlRPzV2Iy1Zr/w5mF6+OiqOvx4E4i5ZmVPGDcKWJB3PCTaVlaoDhJvY5nLwQobRJBtYU3mspTGD6pIpggE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SA5PPF6407DD448.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ce) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 07:57:32 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 07:57:31 +0000
Message-ID: <40524d00-b19d-45aa-b658-53273efd9c05@amd.com>
Date: Tue, 28 Apr 2026 13:27:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/amdgpu: nuke amdgpu_userq_fence_slab
To: christian.koenig@amd.com, alexander.deucher@amd.com, Prike.Liang@amd.com, 
 jesse.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260427182723.1715-1-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260427182723.1715-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::20) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SA5PPF6407DD448:EE_
X-MS-Office365-Filtering-Correlation-Id: 1404ab29-4775-4422-7920-08dea4fbcd08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: MlNwwuoVv9BKT5svAuk0z+PFTCLzj7Sm0mO2xHNdNb0dYX6R5BC6JOUVySMrCIPF1pnaqGhhCJJq9KV7z4/fck8/HW1GEZdnTukLjYk5HqDMDv/Eq/yJYwblDvS+Hj/ioPiK2xLIhMQ0b0EnJRZ6TjEFQOvMHgLOlWNkxFN3BPtnLyq5ennow/thC3Lfe/kB50VYfQ+BCsFS5ZeEdYslXtWwAFsEqexZT7hs3BqYchL/vnPfoI5U+Kal14jgXrE4HIkeFpz6QZhXpp6HCp4ukI03xQ5OYfCYnoBvuGKruT5cwZifq0a3Q1pNiO55Z3wCi24gUuK+HyGp/KfTElRH1w0bM8SOwO8V5yZ6rI0fx0nZJa37cINn7GcY14E3A8yNXffsx/t1WOOH98YwliZ3FuUfWf6U3sSG16UZbV9C9h48MQ+GYASxTdG7e6nk4r61y3zquQvcv17/LV3//l1ZCJyQ9uPw1AU4yeAbHzMqcbAnFSb4uDQwLW9OIlTWrtRhgb9p9OEH8wP/tTBtxNPF0eLjH+Waf5xS31/XELr3bYRce21lu1v4MGS1JBLRuwUXuSTi9pY5WooZK3oT32scSb5FGCglJAcKx3GJgf7acEfLb9UR4tV1wABrSYPwX6ttYOresrsLzZnrHujiyrjWode/pkJeGzR5pYS8d5UviIkCTgNZoj/68Dl5JZwLrKv1WniJdf3youbupqMQPirkq2aKFFxpjo9MSj+oyUxim3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW4vMk5jVStsZXBwS3l4SmcvMk1qcVZxRjNJYmlsQURMZGU4cUJndnI1MFZm?=
 =?utf-8?B?YXdYSythcFpCM3NPaWJBNmJKMENhamFHUXBxWHF2bmdROUVJMHBOeitOS3pz?=
 =?utf-8?B?Wkk1N3hjZ2owMnVsTm9SYXlOaXQwV2RFMWdlaE5qVEwvL1dLbTRkd3FOL0pQ?=
 =?utf-8?B?bnkvZDlkNFlaUWRWNmlPc3lDdEwvU0t6aWk3YXRoRGlQMm04TmNQOVhmMGdL?=
 =?utf-8?B?Umo5QXBxekNMbCtZdWxwVE1Sczg2ZkV4bnk1MGVwMWczVkkzbnRHdm00QXR3?=
 =?utf-8?B?Yi9mRXhqUDRPTnJyMFhxR21DMW00L3lDclFDNUhGdEhlNWNpYmc0WE5hZFZT?=
 =?utf-8?B?UzR3b251L3FuT2d1T3lKMTZMRFVJNlhxakUzMUdLbjhoQzZrNmRiK2hHbE5k?=
 =?utf-8?B?VTREc29ic05ORVNGNml0MkNlQU1TYitPNDFTRjhvWnJJT2pEQmR0dlZMVFFS?=
 =?utf-8?B?ZzZRTHkxQlFvUjgyekFHM0lsd2U5YWRxWmVRalRkUTFyRnJVaUNGbm1VaFFI?=
 =?utf-8?B?MG1SMEE3a1VBZE0wNkd0SlU3NU9OaWptOS96dnFacGdVL21jTGprd1NkdFkw?=
 =?utf-8?B?UkZEZlhKc2tHWnFFK1dFWVRxZEhpYTNGUDBMS01pd1RuVkw1WG9ucFFaTjA3?=
 =?utf-8?B?c0tsRUlJazh0Q3Iva2VUSThVL0I1K3RLSEYvWEVYbG5VM0FyYVFWcmFQeC9k?=
 =?utf-8?B?d1ZST3VBSGE0TERzVm5KUW5xb1VZazFDcWxYRmxLeWVFTCtpYkkzN0VUVS9V?=
 =?utf-8?B?SldPMy9JSEV6Z2JNMmYvRVgvYm91bWtBZmtRL2dkQXlBUlpnMlorVVIyUU9a?=
 =?utf-8?B?dVROOUFEZHgwN3AzRnNoSWlWUUxYeHhwejYvN0YwTUcwd2gxdWd5aGlNNG1D?=
 =?utf-8?B?VFQyZXpGaHB5QlhqK0xxRUlXWDNyaG1FNnk1Y2twN0xJNEQvaFJycmJtbnVK?=
 =?utf-8?B?d2t2NlVNUmQ1N3FpZUFnSm1wR1FxTmdLWUlncUFVQlNYWFcrZzNKb080c0tp?=
 =?utf-8?B?VnkxcUVGQmJvUWErb3FyWWdYSVZGWlZTTDE2bUxxUTltSVV2WWVhVkx4U3Iy?=
 =?utf-8?B?OGJlYWxTVXRkMkJnRXAxRmtwZWxOTDIwWUlJWC9WZEJoNmFSdkszOHFZUWd1?=
 =?utf-8?B?WTZvV2I3aGZHaXVTemxQa2NIM29IRDBhaGZxeXVrbnhjSVBiRG0yN2Q4UlVy?=
 =?utf-8?B?aGJXS3FWQmlEc0lwdWxLMDJoMU5tMEQyNVA4QkFJVTgzRThQUTd0VjBHb1hG?=
 =?utf-8?B?cUJrNXJiZTQ1U2ZPWnlueFBpU2Qvd3RheTMvalVPb1pWdkhqeGxjZk4weDBz?=
 =?utf-8?B?QWlJQVpUZGVmR3A5akVDZFRYUFRrZ1lEb1MyQ1UyU0xhV3lpaVl1WDdEcW1Z?=
 =?utf-8?B?UDh4RENySVVyejNZK2U3ZXFkRVdubzVxd3BoZVZ2MjhuSEp6a2E0c3p3S1FI?=
 =?utf-8?B?WXR1V2Q3MmxIc0djdDQrOVFXRjNJa1JJLzBwTG9CU2o3aDFnWHdsSjdKd3NN?=
 =?utf-8?B?aTFMcWQ0U2swV25KOTdjR2JvbENWdjlwRjRHclBiMXloS2k4WFlKdnpuYjB5?=
 =?utf-8?B?MzFiYjloRkVPV0RyRFdxYWgxTVB5R1psTVl0ejB6OU5KY2lRRks3cjZxZmpP?=
 =?utf-8?B?d0xmcGh1SWxraDFnYWRMUGdlN2lITGI3cHlTVFkrK0MvaDNxVDdrdkZvcStv?=
 =?utf-8?B?RXo4WTVWME1OV0JoT0pmbkZsM0hMNVpDenBaTExyTzJ6d3ZzSWtaUTBvNFk2?=
 =?utf-8?B?bUVxY0sxcDdTWFowQUdmekNWZlgwT252OW94dTlodjd4YVZ5WGJqNy91bU9Z?=
 =?utf-8?B?L20rcEVORDQ1UGpFcE1zdVJzeFJWUm5vOE1FWkJLbnNJd1BQRVNWNHZCZzBW?=
 =?utf-8?B?TnJSY2NhajJHUEQrMFBGWkkveGZlc05Bajczd0tsSTdyTWpveHRQZWwwcjQ3?=
 =?utf-8?B?LzIwUVRwTHA0ekZnS2VyY2FxU1JYK2Rka3V3clByNVdJaFErcDB6SEVoT1ZE?=
 =?utf-8?B?cUZmUk96VDhzd2FmSVlPbzVja0UyQzl4REpocTB2dnYrZkp2cmtOUjUxWk1J?=
 =?utf-8?B?TXFRS3hUMXZlNkw1T3FPUitCWVpYRUorYVVwRVNOd1V5cEluanVERFRPbjFS?=
 =?utf-8?B?WTdVVzFZTDJUMlcrd0R5R09teWNIRzVDK1NrUjlzZFg4Q25CaEtpTy9GTmhR?=
 =?utf-8?B?Y1FIL3ZwaXVtOGszQWhlNHdXYzg5MXdROVpPakgySnliS2IxRjV3eE52b1VP?=
 =?utf-8?B?MHhBWFhCV0N6M0IwYlJ5Z05KdU9yclZ5amNaYzF6bi9lc3RHSHI5TW5IeXRS?=
 =?utf-8?B?ZzdWMUh2QUsrcndOMFVhbUVjK0RZbGJMdUsxRW5HUWpUVGRaVHUwdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1404ab29-4775-4422-7920-08dea4fbcd08
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 07:57:31.8345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lg5IVfyAbjUXrV0gvuVQuD0PWNBwDBXhnXFerNAm76boRP8+ecmWGvEBpSsgmH1sQkbJ8frn/UqoO4CfIWrB1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6407DD448
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 27-04-2026 11:57 pm, Christian König wrote:
> As preparation for independent fences remove the extra slab, kmalloc
> should do just fine.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 17 ++++-------
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 28 +++----------------
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  3 --
>   3 files changed, 9 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 8f66f197f645..2b268cdf076b 100644
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
> @@ -3174,7 +3170,7 @@ static int __init amdgpu_init(void)
>   	/* Ignore KFD init failures when CONFIG_HSA_AMD is not set. */
>   	r = amdgpu_amdkfd_init();
>   	if (r && r != -ENOENT)
> -		goto error_fence;
> +		goto error_fini_sync;
>   
>   	if (amdgpu_pp_feature_mask & PP_OVERDRIVE_MASK) {
>   		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
> @@ -3185,11 +3181,9 @@ static int __init amdgpu_init(void)
>   	/* let modprobe override vga console setting */
>   	return pci_register_driver(&amdgpu_kms_pci_driver);
>   
> -error_fence:
> -	amdgpu_sync_fini();
> -
> -error_sync:
> -	return r;
> +error_fini_sync:
> +       amdgpu_sync_fini();
> +       return r;
>   }
>   
>   static void __exit amdgpu_exit(void)
> @@ -3199,7 +3193,6 @@ static void __exit amdgpu_exit(void)
>   	amdgpu_unregister_atpx_handler();
>   	amdgpu_acpi_release();
>   	amdgpu_sync_fini();
> -	amdgpu_userq_fence_slab_fini();
>   	mmu_notifier_synchronize();
>   	amdgpu_xcp_drv_release();
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index a58342c2ac44..f3d0595e3e61 100644
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
> @@ -231,7 +211,7 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
>   
>   static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)
>   {
> -	*userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab, GFP_ATOMIC);
> +	*userq_fence = kmalloc(sizeof(**userq_fence), GFP_ATOMIC);
>   	return *userq_fence ? 0 : -ENOMEM;
>   }
>   
> @@ -343,7 +323,7 @@ static void amdgpu_userq_fence_free(struct rcu_head *rcu)
>   	amdgpu_userq_fence_driver_put(fence_drv);
>   
>   	kvfree(userq_fence->fence_drv_array);
> -	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
> +	kfree(userq_fence);
>   }
>   
>   static void amdgpu_userq_fence_release(struct dma_fence *f)
> @@ -546,7 +526,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence);
>   	if (r) {
>   		mutex_unlock(&userq_mgr->userq_mutex);
> -		kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
> +		kfree(userq_fence);
>   		goto put_gobj_write;
>   	}
>   
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
