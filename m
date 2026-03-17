Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E02F33818
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 08:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45AE9889BE;
	Tue, 17 Mar 2026 08:44:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E1qzqgml";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E340610E489
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 08:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECJr1IoFmf0KdsoO/LIRYo5XRsgGP7cwN1YZziWA9TNXGNihu8fTYPm/yxZxj5bKDofEnLJrxjmMQXhC1K42k38L6Y2Ys1DC1ROjrxIOy2GsUSxvx5bFxZFQAhwM0Yql9BFhJjj0PXX99714YejcjtkSqGKjpaNc+obkpH2ZAf/7FMIwrsP8oXE3lTimqqihjcj9RpFSiah8JjFl9Jezsg4bbHRL3l0+Cb25P9PPYIh+r/jHeDQzzBt6kjLrfZvMC1/32SCj/NTe2WlK/APqryXieSQsHJb2nmaQ7spi2W/3RJTsswq/P4OPt7l/kSouJ1/5HXTu4odl/wf+9rs45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpK+sfkXRW8aDVvoWyuT6gezuDYCbsVwA3UXTpoIPrA=;
 b=if5mvrdf81LbIouN5hcfRFrUpIshoLEOp9VjStTYOvvqpx0/KrBqDYu2LWHg3LG8PyMLwYwZ4Dohgfepuy//5uXRn/cnwJthd/M4JyZBBO/WFnyYIeGVryJ9HPrWe/kAy7qPaIzibnmrois9LXboO69AaXPfWl1jDVecY6HaKUb/up08KiuWe8uDvutDq8bvi3n4gETGLFFaSgh4fl/LyWTdgTRwdaXaCsr3vz9S5tJAledIPZscLDiIt/OGB2+RWYxkB9MQ4z09vQf/bW0P5NNsXqKJJWiSQSAyR0wHzGVfrq02ulAvVYJ+NqbZZUvdm2HJp1KKt2hWXeABmpWXfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpK+sfkXRW8aDVvoWyuT6gezuDYCbsVwA3UXTpoIPrA=;
 b=E1qzqgmlx1KnsNRO2hYiZ88owKlgK8jmgBbm9FByPMmQpqLFF9fw/04i+cFxe8Haw9nP1+kg3phQW7d07ciiNYbEyXSoMVV26wXDeFR7uFEh7Ax1V5Mz74QjGUTSKwXKacsMijC5U9BIWUxUfnyknMekZlpHgfISCEEJICGoCfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Tue, 17 Mar
 2026 08:44:13 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 08:44:12 +0000
Content-Type: multipart/alternative;
 boundary="------------LLIfh6b0TfDvOSf4Za7Jpvk3"
Message-ID: <b26458f2-d0ad-42e8-a0a1-77d7c5fd15dc@amd.com>
Date: Tue, 17 Mar 2026 14:14:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] drm/amdgpu: fix some more bug in amdgpu_gem_va_ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-10-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260310191327.2279-10-christian.koenig@amd.com>
X-ClientProxiedBy: MA0PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::12) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: fe280de6-891d-4976-4e6e-08de84015d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: /jJhc5BeyK2AoR1Z+WH8F9gm0TgdpBpTd/E2MxTpGGS0333mMx+4TXuPIWTIowrKNdTQbxabNh7lInM6wHL4TEc6yt7pctsH+ttk6/4V6s2jhiJI7B6+DOtHGLwxUmLnSY8TDfKrcvCOmxJn5gpzW8a1wBZycBFmQNGHuj0EWZs45VG+6SJMfVFhQ+jj+YdivB18R0YXQJ76AsiBAGrMv8zcr8v5wvxE7F7ufu6Za/O9OEspX+GWE245RLaPg4N9ToQJqo608elBc1ok548h0wDYYqD34Z1kNP3YD8XHb/QrY8n3X/7f0Pbo9jB/YXBhzeRh5mzw1c9X02Lwo0XW/8v+KB9rnx0nTjgs1ocpdsm8m7nfDKPTSC+T6tyAhik9BKpI7JGzmf37oR7yVk05bcqVdyfTYBQYpUn6JgBKb2+gasTqnDpWsGAQvY7HAkFWmQcWcxk02ZhvtS1NbYQwf7kzDqMqWeQQIs96R2vCBICUsfcCuvzS4sptL5HABHarTogVh+t1gypYR6JaZuZWy+OFy229HnSPgQGOU0u0LZE6YOWMh9UpJvN6VeJe5GbxuxiBPxjv+gxqq948ePr4KNbyay9iGsX5dZoJAcvzbPERN7Yanrc+AcBXsCGB1Os0vLNjsrZfzYD/t02xBRQZuGsgJLkGILQ3L0G1sI/eUB7lhpUOJsEQLi7VRSHn3TxVksssYThD4t+uDQ51p/EILvvrfEoUz1z4Ixw10502fUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWRyQk0zR01mSG9GOWxMcG1VKzR4N3p3Q3NlMEpiRkdhTlFmamttaXhhQkg3?=
 =?utf-8?B?aGRRQUhmZlltM1o0S1hPRGEyM1d0cHZXZ2pvcktDQ2pnNzR0Mkx1YTVwRlh3?=
 =?utf-8?B?RGoyRlJaRXJ5TzhPcFVrRWczSXFCMitOOUV5dDFpV0RTS0RIT0x3VFR6eHlI?=
 =?utf-8?B?cFpjRk9IaExLYW9vSFdSZ1MrdUNCMzRscUxWKzNPQUVYTGNqNWloZGJVbU1O?=
 =?utf-8?B?RnVTVitla09OckZLcFd3WUZDMVFDUzdGelJHU2xySzBIR0ZtSGdpYWMxQWhE?=
 =?utf-8?B?UmF6dWdib3ZwUkkwWjBsc25vRUFWcTZaZVlud0c5K1JmVFVWOFF5VUppK0dq?=
 =?utf-8?B?d2daSUFrMit1WW1UVnpraVJEMDBXN3NZMXhLdXVOb2xudk9FeXNqeDJ5cXRQ?=
 =?utf-8?B?V2N0VUczeDJORXFkYTVTU01KRVBrMW1Ha3hiUW9kcG4ycVRJWkEwalUvV3hV?=
 =?utf-8?B?bVJId2xhbmNweDdjVUZHR21ZbEdFcVhCRVo1VU1ROWhLN044SDV6ZFdjKzhT?=
 =?utf-8?B?bEpzUlFqR2V0SVFFbnFqS214Vkt6bERpeHZ1bDV0djdqT1FXbGduTStTYnRM?=
 =?utf-8?B?VzFtcXRiUEE4Y1Uzd0JkTmFuelFlb0duaThQcU9WTGYyUWhNdVM2R3FNaGFs?=
 =?utf-8?B?VEtNZ080UHBRWE5FK0syb1h0MUN0cHQwVEZaODFQNTBVQUhVa0pvS2gzbzlj?=
 =?utf-8?B?QkJ0N0JwcW9WeG9CcmNKU3JKQmVlZUJRbklvVEJ5VkVIY3VoMGEwZ1g5czhE?=
 =?utf-8?B?Nk9Ra1hqNjNnMkFVUzVYcWZzaWI0R1dJTnRFb1paNnUwV0dkZnFOanBqZGw4?=
 =?utf-8?B?UzFxaW9GRU45dWp1Q2dXMjFOSFF1S0xOMXAxekphbzJvMi9TK0lTSVliR1pS?=
 =?utf-8?B?amRsQ21UWTI4WkptRlFobzc4TkpKdno4SWpLWEMyK2ZhSXMxQU9YQTVhdGNQ?=
 =?utf-8?B?cXE2S2xvR2Zadi8vQWdnVS9RelExZ3ZYSUs3TmxUMGFEOWx0WWNSRnhLaGMy?=
 =?utf-8?B?cDBYVnNGMHRXSGdsZzhQakRLdFg5RkZGS1VaNE9NWXRLUnRoSWlVeXo0bVha?=
 =?utf-8?B?NVpSUElwUlZNTWlzREQ0bGtNYThmWXVubGdlQzJIb0NKSDVRRk5XNmcwRHFI?=
 =?utf-8?B?VFQxbXFmNFExblJZcWVub1gwTlF5U2VLd1JWRVBUVklaNHI1NFhvdWFsRVBT?=
 =?utf-8?B?REhzNGM0WndXZU5xbzRWbXF6bnNCRkcvMU1raHZmV29scWVsOEhQeEtlQUU3?=
 =?utf-8?B?dHdWeUhiK2tRemZjRXQrSkllWVp1QzdBZFF0a3p1aDQyYzdteXVnQVBqdmQw?=
 =?utf-8?B?OGJZbXA5b25OeEt6S1VhVDlIdVp1Zk1MNGRUSlBDRkRKMkVlK1YwUVpsb1Zv?=
 =?utf-8?B?Y3Z0dUgrRk5BdzEzMkFYMkpkbkVPek5EVVg0MVcrcTR5Y0tKV0VBUUU3L1dS?=
 =?utf-8?B?QWU3eVlPNGNyT25PRzlNL2FjdCt1T2RDSTF6eU9FOEtoZG1MSm83SXVMbFdq?=
 =?utf-8?B?V3RhV1c0M2s0QXhRNHQySE9Ibkd0OUdSL0FWRzBJdlNvbndqSENaT0ozQXZC?=
 =?utf-8?B?Yk4rQm45THJHUjhNVkF4Q3FtMlo4RlcvUk1xSnBaTkxYUzllNzcwUzhuZkx5?=
 =?utf-8?B?ZUxRb09SSmovVEZ0RFZ2M1M2Z0p2VktMT3NuRlNtMUZvNEZTVnl5NWV2czJo?=
 =?utf-8?B?ZW5CbC80SURZdFdPVU9KbDZDWnpVWmlVNEd3UzVCb1c3c2VRaW5DOTh0eStx?=
 =?utf-8?B?VzRTdXZaTDVDK2liQ2xvb1ZRbi9VMS9OV0FZc21TQXp5cWZpS0dVTEV0TzJD?=
 =?utf-8?B?Q21HdzFVeVVKekE2Nmw3SVBiaDVRbEdVenhhMUNUcU5OSEtGRnpVdnFTdXhX?=
 =?utf-8?B?eG9vaWFCNm40Q3NvYnBtVGdFVWcvMUwrT0hTSGM4UWtsZFRFRms3U3Rwdnlv?=
 =?utf-8?B?K3Q1QVl2TTVjRGY4OHhYT3BMQWdoVDZsTG9HYXViUW1aOThJYVlDTk5OQnhC?=
 =?utf-8?B?d2pkNzdMOGlnVEtLN3hKeGZKdkZyS1kyQ1ByaUNWL2xCM2ViVi9ZSXBDaS9x?=
 =?utf-8?B?R2FrVHhXajdFUkJwM3l1NXA4OHZGb0NzaGFjbHBMUEtNYnJCcDd0M3RFOXdV?=
 =?utf-8?B?d0YxUWVGMGZvNXJKVGdNOFdESmVyT3dCTDY5MWVtdnFxdEN6YlpUYlJwSHgr?=
 =?utf-8?B?QWZBR2hnQ3lLeEgrQ1lCWjZsZ0lWWGhKWnhQVUhwcy9QTFYvZDh3OSsyMzJl?=
 =?utf-8?B?UnhRRHpEZGR5dGhnTFFXalNJQUN6VHZqKzg4Rmh2RTU5SWtZemZWSzhscW1m?=
 =?utf-8?B?OEhuc1YvR3BteGlPTTl2QXhkY3h5aDlyb281d0dNVllhT04reUZHdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe280de6-891d-4976-4e6e-08de84015d3c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 08:44:12.8886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTMGXO9PP4QEn5ZhluKF/gNXiwPon7Vp0WpzWAOlS8Qwr9F78KsKAgTcJjwsf8odgrZIRhCIqFEoIPw18wwtWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451
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

--------------LLIfh6b0TfDvOSf4Za7Jpvk3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11-03-2026 12:43 am, Christian König wrote:
> Some illegal combination of input flags were not checked and we need to
> take the PDEs into account when returning the fence as well.
>
> Signed-off-by: Christian König<christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 76 +++++++++++--------------
>   1 file changed, 34 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 88a21400ae09..98276b55ad3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -30,6 +30,7 @@
>   #include <linux/pagemap.h>
>   #include <linux/pci.h>
>   #include <linux/dma-buf.h>
> +#include <linux/dma-fence-unwrap.h>
>   
>   #include <drm/amdgpu_drm.h>
>   #include <drm/drm_drv.h>
> @@ -741,11 +742,10 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>   	struct dma_fence *fence;
>   	int r = 0;
>   
> -	/* Always start from the VM's existing last update fence. */
> -	fence = dma_fence_get(vm->last_update);
> -
> +	/* If the VM is not ready return only a stub. */
>   	if (!amdgpu_vm_ready(vm))
> -		return fence;
> +		return dma_fence_get_stub();
> +
>   
>   	/*
>   	 * First clean up any freed mappings in the VM.
> @@ -754,7 +754,7 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>   	 * schedules GPU work. If nothing needs clearing, @fence can remain as
>   	 * the original vm->last_update.
>   	 */
> -	r = amdgpu_vm_clear_freed(adev, vm, &fence);
> +	r = amdgpu_vm_clear_freed(adev, vm, &vm->last_update);
>   	if (r)
>   		goto error;
>   
> @@ -771,47 +771,34 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>   	if (r)
>   		goto error;
>   
> -	/*
> -	 * Decide which fence best represents the last update:
> -	 *
> -	 * MAP/REPLACE:
> -	 *   - For always-valid mappings, use vm->last_update.
> -	 *   - Otherwise, export bo_va->last_pt_update.
> -	 *
> -	 * UNMAP/CLEAR:
> -	 *   Keep the fence returned by amdgpu_vm_clear_freed(). If no work was
> -	 *   needed, it can remain as vm->last_pt_update.
> -	 *
> -	 * The VM and BO update fences are always initialized to a valid value.
> -	 * vm->last_update and bo_va->last_pt_update always start as valid fences.
> -	 * and are never expected to be NULL.
> -	 */
> -	switch (operation) {
> -	case AMDGPU_VA_OP_MAP:
> -	case AMDGPU_VA_OP_REPLACE:
> +	if ((operation == AMDGPU_VA_OP_MAP ||
> +	     operation == AMDGPU_VA_OP_REPLACE) &&
> +	    !amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo)) {
> +
>   		/*
> -		 * For MAP/REPLACE, return the page table update fence for the
> -		 * mapping we just modified. bo_va is expected to be valid here.
> +		 * For MAP/REPLACE of non per-VM BOs we need to sync to both the
> +		 * bo_va->last_pt_update and vm->last_update or otherwise we
> +		 * potentially miss the PDE updates.
>   		 */
> -		dma_fence_put(fence);
> -
> -		if (amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo))
> -			fence = dma_fence_get(vm->last_update);
> -		else
> -			fence = dma_fence_get(bo_va->last_pt_update);
> -		break;
> -	case AMDGPU_VA_OP_UNMAP:
> -	case AMDGPU_VA_OP_CLEAR:
> -	default:
> -		/* keep @fence as returned by amdgpu_vm_clear_freed() */
> -		break;
> +		fence = dma_fence_unwrap_merge(vm->last_update,
> +					       bo_va->last_pt_update);
> +		if (!fence) {
> +			/* As fallback in OOM situations */
> +			dma_fence_wait(vm->last_update, false);
> +			dma_fence_wait(bo_va->last_pt_update, false);
> +			fence = dma_fence_get_stub();
> +		}
> +	} else {
> +		fence = dma_fence_get(vm->last_update);
>   	}
>   
> +	return fence;
> +
>   error:
>   	if (r && r != -ERESTARTSYS)
>   		DRM_ERROR("Couldn't update BO_VA (%d)\n", r);
>   
> -	return fence;
> +	return dma_fence_get(vm->last_update);
>   }
>   
>   int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
> @@ -832,7 +819,6 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   	struct amdgpu_bo_va *bo_va;
>   	struct drm_syncobj *timeline_syncobj = NULL;
>   	struct dma_fence_chain *timeline_chain = NULL;
> -	struct dma_fence *fence;
>   	struct drm_exec exec;
>   	uint64_t vm_size;
>   	int r = 0;
> @@ -884,6 +870,10 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   		return -EINVAL;
>   	}
>   
> +	if (args->flags & AMDGPU_VM_DELAY_UPDATE &&
> +	    args->vm_timeline_syncobj_out)
> +		return -EINVAL;
> +
>   	if ((args->operation != AMDGPU_VA_OP_CLEAR) &&
>   	    !(args->flags & AMDGPU_VM_PAGE_PRT)) {
>   		gobj = drm_gem_object_lookup(filp, args->handle);
> @@ -973,11 +963,13 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   	 * that represents the last relevant update for this mapping. This
>   	 * fence can then be exported to the user-visible VM timeline.
>   	 */
> -	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !adev->debug_vm) {
> +	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) &&
> +	    (!adev->debug_vm || timeline_syncobj)) {
> +		struct dma_fence *fence;
why to declare it here within the block. If i am not wrong we should 
have declaration first thing in the function as it was before?

Other than that small nitpick looks good to me.

Acked-by: Sunil Khatri <sunil.khatri@amd.com>

Regards
Sunil khatri


> +
>   		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
>   						args->operation);
> -
> -		if (timeline_syncobj && fence) {
> +		if (timeline_syncobj) {
>   			if (!args->vm_timeline_point) {
>   				/* Replace the existing fence when no point is given. */
>   				drm_syncobj_replace_fence(timeline_syncobj,
--------------LLIfh6b0TfDvOSf4Za7Jpvk3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 11-03-2026 12:43 am, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260310191327.2279-10-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">Some illegal combination of input flags were not checked and we need to
take the PDEs into account when returning the fence as well.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 76 +++++++++++--------------
 1 file changed, 34 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 88a21400ae09..98276b55ad3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -30,6 +30,7 @@
 #include &lt;linux/pagemap.h&gt;
 #include &lt;linux/pci.h&gt;
 #include &lt;linux/dma-buf.h&gt;
+#include &lt;linux/dma-fence-unwrap.h&gt;
 
 #include &lt;drm/amdgpu_drm.h&gt;
 #include &lt;drm/drm_drv.h&gt;
@@ -741,11 +742,10 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	struct dma_fence *fence;
 	int r = 0;
 
-	/* Always start from the VM's existing last update fence. */
-	fence = dma_fence_get(vm-&gt;last_update);
-
+	/* If the VM is not ready return only a stub. */
 	if (!amdgpu_vm_ready(vm))
-		return fence;
+		return dma_fence_get_stub();
+
 
 	/*
 	 * First clean up any freed mappings in the VM.
@@ -754,7 +754,7 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	 * schedules GPU work. If nothing needs clearing, @fence can remain as
 	 * the original vm-&gt;last_update.
 	 */
-	r = amdgpu_vm_clear_freed(adev, vm, &amp;fence);
+	r = amdgpu_vm_clear_freed(adev, vm, &amp;vm-&gt;last_update);
 	if (r)
 		goto error;
 
@@ -771,47 +771,34 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	/*
-	 * Decide which fence best represents the last update:
-	 *
-	 * MAP/REPLACE:
-	 *   - For always-valid mappings, use vm-&gt;last_update.
-	 *   - Otherwise, export bo_va-&gt;last_pt_update.
-	 *
-	 * UNMAP/CLEAR:
-	 *   Keep the fence returned by amdgpu_vm_clear_freed(). If no work was
-	 *   needed, it can remain as vm-&gt;last_pt_update.
-	 *
-	 * The VM and BO update fences are always initialized to a valid value.
-	 * vm-&gt;last_update and bo_va-&gt;last_pt_update always start as valid fences.
-	 * and are never expected to be NULL.
-	 */
-	switch (operation) {
-	case AMDGPU_VA_OP_MAP:
-	case AMDGPU_VA_OP_REPLACE:
+	if ((operation == AMDGPU_VA_OP_MAP ||
+	     operation == AMDGPU_VA_OP_REPLACE) &amp;&amp;
+	    !amdgpu_vm_is_bo_always_valid(vm, bo_va-&gt;base.bo)) {
+
 		/*
-		 * For MAP/REPLACE, return the page table update fence for the
-		 * mapping we just modified. bo_va is expected to be valid here.
+		 * For MAP/REPLACE of non per-VM BOs we need to sync to both the
+		 * bo_va-&gt;last_pt_update and vm-&gt;last_update or otherwise we
+		 * potentially miss the PDE updates.
 		 */
-		dma_fence_put(fence);
-
-		if (amdgpu_vm_is_bo_always_valid(vm, bo_va-&gt;base.bo))
-			fence = dma_fence_get(vm-&gt;last_update);
-		else
-			fence = dma_fence_get(bo_va-&gt;last_pt_update);
-		break;
-	case AMDGPU_VA_OP_UNMAP:
-	case AMDGPU_VA_OP_CLEAR:
-	default:
-		/* keep @fence as returned by amdgpu_vm_clear_freed() */
-		break;
+		fence = dma_fence_unwrap_merge(vm-&gt;last_update,
+					       bo_va-&gt;last_pt_update);
+		if (!fence) {
+			/* As fallback in OOM situations */
+			dma_fence_wait(vm-&gt;last_update, false);
+			dma_fence_wait(bo_va-&gt;last_pt_update, false);
+			fence = dma_fence_get_stub();
+		}
+	} else {
+		fence = dma_fence_get(vm-&gt;last_update);
 	}
 
+	return fence;
+
 error:
 	if (r &amp;&amp; r != -ERESTARTSYS)
 		DRM_ERROR(&quot;Couldn't update BO_VA (%d)\n&quot;, r);
 
-	return fence;
+	return dma_fence_get(vm-&gt;last_update);
 }
 
 int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
@@ -832,7 +819,6 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	struct amdgpu_bo_va *bo_va;
 	struct drm_syncobj *timeline_syncobj = NULL;
 	struct dma_fence_chain *timeline_chain = NULL;
-	struct dma_fence *fence;
 	struct drm_exec exec;
 	uint64_t vm_size;
 	int r = 0;
@@ -884,6 +870,10 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
+	if (args-&gt;flags &amp; AMDGPU_VM_DELAY_UPDATE &amp;&amp;
+	    args-&gt;vm_timeline_syncobj_out)
+		return -EINVAL;
+
 	if ((args-&gt;operation != AMDGPU_VA_OP_CLEAR) &amp;&amp;
 	    !(args-&gt;flags &amp; AMDGPU_VM_PAGE_PRT)) {
 		gobj = drm_gem_object_lookup(filp, args-&gt;handle);
@@ -973,11 +963,13 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	 * that represents the last relevant update for this mapping. This
 	 * fence can then be exported to the user-visible VM timeline.
 	 */
-	if (!r &amp;&amp; !(args-&gt;flags &amp; AMDGPU_VM_DELAY_UPDATE) &amp;&amp; !adev-&gt;debug_vm) {
+	if (!r &amp;&amp; !(args-&gt;flags &amp; AMDGPU_VM_DELAY_UPDATE) &amp;&amp;
+	    (!adev-&gt;debug_vm || timeline_syncobj)) {
+		struct dma_fence *fence;</pre>
    </blockquote>
    why to declare it here within the block. If i am not wrong we should
    have declaration first thing in the function as it was before?&nbsp;<br>
    <br>
    <p>Other than that small nitpick looks good to me.&nbsp;</p>
    <p>Acked-by: Sunil
      Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a></p>
    <p>Regards<br>
      Sunil khatri</p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt"><br>
    </p>
    <blockquote type="cite" cite="mid:20260310191327.2279-10-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">
+
 		fence = amdgpu_gem_va_update_vm(adev, &amp;fpriv-&gt;vm, bo_va,
 						args-&gt;operation);
-
-		if (timeline_syncobj &amp;&amp; fence) {
+		if (timeline_syncobj) {
 			if (!args-&gt;vm_timeline_point) {
 				/* Replace the existing fence when no point is given. */
 				drm_syncobj_replace_fence(timeline_syncobj,
</pre>
    </blockquote>
  </body>
</html>

--------------LLIfh6b0TfDvOSf4Za7Jpvk3--
