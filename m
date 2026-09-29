Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD688CA5FA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 14:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F1EA10E072;
	Tue, 29 Sep 2026 14:07:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zxovtb1N";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013032.outbound.protection.outlook.com
 [40.107.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD6210EEE4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 14:07:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=co4LIHx5IJV+5YmKR8hXvYa1qm7GvkLMgEuqdsudGF1n3h3FE8D79ofwOvhAgbOLHlxBR39ZF1wKq0os7QiAodXveKH4vu4xTQplVQHNZ/cM0DDDvP5wF4I0LuWkOD3xBDtUcBr3INaWYEB4dbtNtWnhPpkSgfkZWro9QhiTxfZaSXDjQEPGk70n2UvNWX430/o/K21iExnUNey0rzO1MuGu9Y8PMC8Yf+radGA/9ct1MBzZgRKXNf9z+OyGsponONq7zYgmGHpenouGPK4oiT9eJ1tejjFtWzptJb5aNGTO9jzxa6sz38phcIbmu4EfJe7CgNamxKRgVi9RVkIcqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9MkoxkNexcZ7AxnQqSVR0BcanAT5w8M2m3kt52UNI4=;
 b=BoK4kKavUUCMjNGmCe/7JDDYxrqoPeok9qlbKwf1R56x0dcb/W0ZXDoiO3gDURiJTZsLnyr7HE8rt7CuJyxRl/gveLvipA8ddiD52kCeOOehCBtyxxryGMpxp31sIRdbGIa4hEWCymXbtPCPCO7xutPDGt8lkhRLmlKjLGj2iOJ9iyiMLO1QlDZ9r4fRVOdqM1xi1bhrfrM/vNTlMAevVcSFyuKeCVdp0tUZU/389PE9IShQxQjFDldQ+Fcw3tyWp7sNn46nl+cxnnrTHUK7AJZUOxptT45WuwEotuQEFNnmM08jfaqHUHatBFCytGe8tT/ioyBfUBd0I/36UPEc+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9MkoxkNexcZ7AxnQqSVR0BcanAT5w8M2m3kt52UNI4=;
 b=zxovtb1NWbZhE6uWtMZPhPK4DQTRd+lbD+UDIa31UMl3InF3JOOGxy0cnDu2cPxm/BX+9dKEVHpb54LUvHcUDVcphfa+hVNiP417CTKEpL8MY2PdEloAK57RhG4jmMZ82z+ZfTz/JRgqdCH2gJMRpDvNwNaP3449j1nXBEL/JbM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by SN7PR12MB7810.namprd12.prod.outlook.com (2603:10b6:806:34c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 14:07:32 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0451.026; Tue, 29 Sep 2026
 14:07:32 +0000
Message-ID: <e2527328-9099-4d04-b9db-f7c738c66327@amd.com>
Date: Tue, 29 Sep 2026 22:07:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] drm/amdgpu: rework eviction lock handling into
 critical section v3
To: christian.koenig@amd.com
Cc: natalie.vock@gmx.de, Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Philip.Yang@amd.com, timur.kristof@gmail.com, cascardo@igalia.com,
 tvrtko.ursulin@igalia.com, Huang Rui <Ray.Huang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260928151041.1857-1-christian.koenig@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <20260928151041.1857-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::9) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|SN7PR12MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: d947bbde-8143-4994-3e47-08df1e330116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|260925021911599003|3023799007|6133799003|260925021311599003|260925022911599003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fRj5AsyOGov0UHUkXLCd1rwhY4K+Pjm7YqNn65oyc1XSVjTMeQ7OVcbui3c2fu87cn62+8K0/qLSOUOjpScahSzukTw1JINFth053/X9QQMqzHclet/3IYWn0sE0FjGodHmmtQ7RFb8HpkzF+8rSXs/qgZrS5FJwJeP4rMjRYcDBSvxw3v2Nk92UzQtkqC4LMUNuayb+sQ6boeEACbGp84jRpKsBPSdGaGHcdYv43CyE2XcoEfd425KycoPl3pLJy9TJBUd//pVoGfqvBW2npN2N0Py0+jV7yVP7i9KDGgRQiJqQ/QaCWE/O0RC1GUUjUYJDsP6hutXontaOoOHbEsaf3YhmR6E8p3DXCGEB0SWTQ3Tcj0ni8q9zGNnlUt1eQq5Cnv5VQEDP2QSKdextyPiGNWF+jtVpJR7M1n5trlE4OFcpH6SW7vfdqjuREkRSIJVx1GTU1IdoOOAR05fyIWS2uuapjv5TMJKrzShTNC8Y25gKFJYEdFaK+n+I+74UigwAyERcnLnh63ybH5bntkVGPwmKbLHjemu13DVQj1qa8CPnP2XaM/PwNEsU8CHcCcYg6i7Lv6fJAdb0HFwA3R9wk1E92V1CmtaRCRKTFBaubGUdvD1pOrHoPdDElfM/2/Y9YLnVjSrZcVJ++8NSexJKW2RLpguLVdXCqob5Lm4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(260925021911599003)(3023799007)(6133799003)(260925021311599003)(260925022911599003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDJMUEVPRm1XVTMzVGltbjROOTcwZ3d4emgvTUUwTVRHelJ4U3NkeTFxTTdV?=
 =?utf-8?B?emZDaXV1WjdoQmhQa2l3TjltUHkxRE9CV2NMai9vcXRITEs0dUFIelBjTWlr?=
 =?utf-8?B?UmlNN1Q0RW1PMENGenAzN05uWi9JTDlNbkd2aGxoRXhYdVR4TTFUZ1NvL1E2?=
 =?utf-8?B?cERkcjQ2YWVvSDVnMWVKMnZJUHhTUzQ1d1BvM2NRWTZpdld3UUtUcE5JOWxk?=
 =?utf-8?B?eDU0bXQwUnhUU09RbUs4RW5sRXkvNXBjME1KNk5qbjd5VlJkeFRoakhGRy9z?=
 =?utf-8?B?cmhMNmZSZHdSOEZLV1BwejVKcHFEOTd0UlZkRlJIUGptclg5aWdDYUJoVWZl?=
 =?utf-8?B?VHAzVXJXZkVRMlBza2tjRE4yMTZWZkUzRU9uNlBYcm9XRlREUXdUNFlEWHdt?=
 =?utf-8?B?Szc1dldCOXdHWE40dTRUZUxERTRXaExYWm9POWtMUTVidjJ5cldiTkcwWFZj?=
 =?utf-8?B?bTRrVjNQWkU2OFVvbXZkQ0s3Z2diVkVnYlJkWmQwNGpNT0FmT3RYQXVCNE5n?=
 =?utf-8?B?c2RLOXhnc1BhNU93anFOWEVvcVhIQkxZNVlJUVlPSnYzK0JxUlA1dXZ5YVdE?=
 =?utf-8?B?QmNLQ1dqZ3RLQmhwRUpqQ0ZUNkFnWEhjYlZ3YzBsN2pyMy9VYUxDM1FOSnpO?=
 =?utf-8?B?SEk1RUJ0R001MXAzc0FVaXd3eGsySEVoaE11MlJsNU5KbmhPblFVUWtkd2ZJ?=
 =?utf-8?B?SHZEY0xIcVZpMG96QU5rc2wrdlYzR1N0bTNCUGpnNXRxaDV4SFFQd0Jza1RG?=
 =?utf-8?B?RnhuWjg4c1Y5RDlOaEwrZmErdzZMTDdJQzZIdnV1NE1OWWZuVWZvNTN4VmYr?=
 =?utf-8?B?N1YvczFseFdYckVBaGxaWWtoeGlsVHpGRkxMOGF0NnJTM2hjS3FvSENJdys0?=
 =?utf-8?B?dUZlbkVVVXVGblh5ZVFRU3hnb1JkOXhYeWJOWnlDcmRNL0hZQ2pSZHBOUmdI?=
 =?utf-8?B?ckVvV01XMzMvaGdFd3BYUWdSem4xWE93TnRaZmdKWjhWQUVnR2s3eThJclFY?=
 =?utf-8?B?c0hIeFJxUHFJb2ltcmhad1hoMUhRdDdmV2ZKOHkwMjZ4ZXlWR2x5V3Vqbjhh?=
 =?utf-8?B?L1BxczhVY2ZJRW9hYmdta2xTNUNDbkplRHhSRkQxVVlucVFGWXlYNUN1bGFv?=
 =?utf-8?B?VklpTVNFRHZaNUx3bVlBa1FSdC9WaWFyQTRCbGNROC9mMEdaR2VCQnY5aVhM?=
 =?utf-8?B?UDlpVEFEb1VSZUxnWkpBUC9IVVNWdWZHbGQrWGRFaG5pejM4RWJsUEFsb0VR?=
 =?utf-8?B?M2FDSWRMMjZBRXp3S1lvWXR6U2U3OGJKN00ycEF2azNwRUhwV3o2UGhySUto?=
 =?utf-8?B?OVVMWjVOMERKQ3EzazVGVU0vb3dIaElSVVlJSDlCbm1vK01BbTY3MHR4ZHB1?=
 =?utf-8?B?bWl6MkpLS3JhUm83TUI5ZEtoTjRFR2ZnSHZuK3VIZUx2NERkbVE1aFBRLzI4?=
 =?utf-8?B?aE5ucCtXMnNMendlYXVUa0JBSk9RVnM1bG8rWHdWVW90WkJCSFNPT0hUeGgw?=
 =?utf-8?B?S0pGZ3JDSDZEMmhoeEd2WEtBR0wvZXArcjBUL0xCUVhERHNJT0Q2a3dlWDE5?=
 =?utf-8?B?RWJNY3F1TVc3WkR1ZkFTNW4xRHAxbzZOc1JialZ3Y0RxOWlFSmV2OEZzTjZY?=
 =?utf-8?B?QjF1cHd3Ulphdk9zWXNLSnhMNWtKb2ZwbUVRSndYVi81dEF4Ni90cjExemZz?=
 =?utf-8?B?U0o1MWhra2g4anpnOHZDVDYvWndwcnFJMU90MEVoY0JsaUF1YkpBSXZjZTRH?=
 =?utf-8?B?dmZIRXFQT00wTE1qUFZTVXVXT2NQOUNmdUNBRldGYSswZEJSYmlYUE9JOEVi?=
 =?utf-8?B?UXlVa2dZS0YyUkZUa2w5TGt4ZkFtL0RnZzYrQmZMN29XTUs1R1N3azNYU1BL?=
 =?utf-8?B?VFVhelpXSXZqNjVsQXRDZzNkMVpReFVYUkoxM25jbXlnOWdvOUlXTWExOW1D?=
 =?utf-8?B?bzl1bE0wSlBGOTh3YVRRRE1LLzFGaUl3bFhvMlZpeUJRMWFzakNZUGtjNnVp?=
 =?utf-8?B?RHFSS0tScDRZY3FHbTFxN2FuQ0dUYUFFaGRmR1M5dkZPekREZlZ6YUV5amFQ?=
 =?utf-8?B?eHZUK3pCTHpyczBSeXdnYTNnbDdxQmNldEhtQU9mbFVrL3RIV1FZZjJNYmJM?=
 =?utf-8?B?aFJGSko4alVQVWt0aldFWE5pYXBJbCt3dUdReVozRGFnU2RLTVpudWdKZmtM?=
 =?utf-8?B?RnhTanR6T2tSWk5NeExxd2RTSDdNM0ViaFNFQ00yVlYxV3NaQVp4d1NCNG9u?=
 =?utf-8?B?cDRBTkhodnlCb3RSc2RnRGRHTVNQSFRiVFdvVEV3S3dPdVF4bnlvQ0NPMHpx?=
 =?utf-8?Q?EdAr30BFgfg1HEYgBx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d947bbde-8143-4994-3e47-08df1e330116
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 14:07:32.2995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /I/AHdc1cAZcs/xKIe4SwpnCO08R1MkGzEOGV2zO/R8TVk7KAWKF9FWH0HlekHKN8rUB0TL/PzaH9tphL3N6vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7810
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



Will rebase the amdgpu drm svm on this series.

Regards,
Honglei

On 9/28/2026 11:10 PM, Christian König wrote:
> Taking the eviction lock is actually just one step which we need to do
> in the critical section handling.
> 
> Rename the functions to reflect that, use the update parameters instead of the
> vm to save the GFP flags.
> 
> v2: rebased and reordered
> v3: fix rebase artefact, fix error handling in amdgpu_vm_pt_alloc
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Natalie Vock <nat@pixelcluster.dev>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  8 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  1 -
>   .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   | 43 ++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 40 ++++++++---------
>   4 files changed, 54 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 29a66e39f3d60..7b9494375649f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1170,11 +1170,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
>   	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
>   		struct dma_fence *tmp = dma_fence_get_stub();
> @@ -1258,7 +1256,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   error_free:
>   	kfree(tlb_cb);
> -	amdgpu_vm_eviction_unlock(vm);
> +	amdgpu_vm_end_critical(&params);
>   	drm_dev_exit(idx);
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 0f6634b749746..98cdd7e3475fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -289,7 +289,6 @@ struct amdgpu_vm {
>   	 */
>   	struct mutex		eviction_lock;
>   	bool			evicting;
> -	unsigned int		saved_flags;
>   
>   	/* Memory statistics for this vm, protected by stats_lock */
>   	spinlock_t		stats_lock;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> index ca86eaac75235..8ebb0b033291e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> @@ -51,7 +51,7 @@ struct amdgpu_vm_update_params {
>   	struct amdgpu_device *adev;
>   
>   	/**
> -	 * @vm: optional amdgpu_vm we do this update for
> +	 * @vm: amdgpu_vm we do this update for
>   	 */
>   	struct amdgpu_vm *vm;
>   
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
> @@ -126,21 +131,37 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>   			    struct amdgpu_vm_update_params *params);
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
> index 1cdf2b854f261..c03327f1242d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -505,52 +505,51 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   /**
>    * amdgpu_vm_pt_alloc - Allocate a specific page table
>    *
> - * @adev: amdgpu_device pointer
> - * @vm: VM to allocate page tables for
> + * @p: see amdgpu_vm_update_params definition
>    * @cursor: Which page table to allocate
> - * @immediate: use an immediate update
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
> -			      struct amdgpu_vm_pt_cursor *cursor,
> -			      bool immediate)
> +static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
> +			      struct amdgpu_vm_pt_cursor *cursor)
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
> -	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt,
> -				vm->root.bo->xcp_id);
> -	amdgpu_vm_eviction_lock(vm);
> +	amdgpu_vm_end_critical(p);
> +	r = amdgpu_vm_pt_create(p->adev, p->vm, cursor->level, p->immediate,
> +				&pt, p->vm->root.bo->xcp_id);
> +	r2 = amdgpu_vm_begin_critical(p);
>   	if (r)
>   		return r;
> +	if (r2)
> +		goto error_free_pt;
>   
>   	/* Keep a reference to the root directory to avoid
>   	 * freeing them up in the wrong order.
>   	 */
>   	pt_bo = &pt->bo;
>   	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
> -	amdgpu_vm_bo_base_init(entry, vm, pt_bo);
> -	r = amdgpu_vm_pt_clear(adev, vm, pt, immediate);
> +	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
> +	r = amdgpu_vm_pt_clear(p->adev, p->vm, pt, p->immediate);
>   	if (r)
> -		goto error_free_pt;
> +		goto error_unpin;
>   
>   	return 0;
>   
> -error_free_pt:
> -	if (vm->is_npa)
> +error_unpin:
> +	if (p->vm->is_npa)
>   		amdgpu_bo_unpin(pt_bo);
> +error_free_pt:
>   	amdgpu_bo_unref(&pt_bo);
>   	return r;
>   }
> @@ -838,8 +837,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			/* make sure that the page tables covering the
>   			 * address range are actually allocated
>   			 */
> -			r = amdgpu_vm_pt_alloc(params->adev, params->vm,
> -					       &cursor, params->immediate);
> +			r = amdgpu_vm_pt_alloc(params, &cursor);
>   			if (r)
>   				return r;
>   		}

