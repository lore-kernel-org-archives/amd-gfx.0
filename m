Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAC7FF885A
	for <amd-gfx@archiver.kernel.org>; Mon,  4 May 2026 13:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026C610E38B;
	Mon,  4 May 2026 13:05:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UnYb01OR";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5A3A10E38B
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 May 2026 13:05:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+QgYcMB+KxpbttWpKywGs3q+uWKL/6FpvT77WMvor17/4jnt6x6NE+eH6zsT9+ew2UF8xWCjZO8gQyyw9BRO2ST5vKE2KEaXm9jLj+DBYDrP3/f9UsJwG6n4s4DQmeVUIlo7pDjT7xH/83bBq2WzFJqgwwvTDc9HnMCov4xHHP286qyMCRHCT15l6BGgThyiWBCxpIuw9pSDObmTKnZKGc4aHB3IIC5ps02cOaTeNbRCDGcur5mzU9Q/AE9fqMi4F14rm1tIRjwBYWsWwWHqy5xx5JY0O6Kw3y0JQ6zBg9VdQQ/L1XGFRL0E92JCLOxYC+kV9My+XgaCdMh0W33Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAsxirdlST1omibA/2Yk6aTI0dvK7MTgU16ImD/6PDU=;
 b=XOOk7YtFiZkv94CQOsDfncKcbDFRHjP31yGfHCFecGDaHhgNeLL4lcsadAk82zRLQFSSwJf1PoM1UojvpsANC8f9GcXnmuROhPTTpF/b2HbtAAddgzrTHhjgqHY92pWDDBnKvW/dOQUVIvN2NlEwbSjJXNqReLx/dGIZbxeCsa+IeIN64td10e2PrTshHp/CmwODGPjlgxXUUA+t+D920nPTCLUJ79ygkx1FuWQNQ3fPzvvKPZMXi/3/lVE4OAvjHNx7rhERlNc16w92KkHn7pLeDNxnxTeOw10HSsUgl+UxLRrpXr33lMjv5HluVys5RUMPGuFOfCE+6B2bmJRCnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAsxirdlST1omibA/2Yk6aTI0dvK7MTgU16ImD/6PDU=;
 b=UnYb01ORUIRC/gK9l3pTnXdaYGFKfDO599CzjpeaIkofT/IW+heKRWJur3MUfwQvFTQnt77xv9FbP2qtBf5VEcfMXB4i4ADBhcL0jnzNZIBeLzyHZoe0OW11NJMLebdc8Xp8DTuhsvR0qHZ5F/T2GASJTplFPJ+2b8Y4VFdvdvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB9475.namprd12.prod.outlook.com (2603:10b6:8:251::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 13:05:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 13:05:49 +0000
Message-ID: <ff00838c-128b-40be-b215-4f21012376cd@amd.com>
Date: Mon, 4 May 2026 15:05:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: fix access to stale wptr mapping
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260504125645.91836-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260504125645.91836-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0303.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: 25503146-387d-4d4a-50c0-08dea9dddca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: aZB77A3fWWObeHH3mx1M9Z5G8Qd5u+beONMriHPdPXf3IF/qATR5xRknrwA3cWtv7RQY1GLO+iB3ahbxa1RajlrijZXWog2EbffOe+6BFp1bkeufrpT+urvVBUpgxH64eOPGPOz5LlUdNNcyPD4gCsaItDw4SJJUpxrRfel+map7roH7TYrFAHQ9f5V6Tvh7to+trjxYgt5D3MUq040ca8ox1DO+UulWf5zeb8JRHg1bUqcqA8CjFWsHItefQ6GWX7oPMvyW4mk55NPhXkzJWSigILyx/mqHoVyTva9puIotbjetJXvxkewZehNdeY5SzGwzn7ZF5S9PFPnMrP93uCRSESueF/f/jd6w9Zn8ATnBTug2ktnIyZVjcFn7vLuzFrTFKd/FJcXKVRMcAWPt9YSVOQN4PjPMWthx0bzwQDl4WAzy1X4bBxCbu5PrFFGvlE32KhVoZOWSd26T5zsks5uqeMrfauLnB7YwqfUSg+8MElJc3xTuUK23xlcH+HMbg4auPeKYVDUsGoW7GW99YQ7vqvLcztIlScOGE2fyxs0ERwm6SF+hdYriRCYHC/7C4WMXoGRbT7GWtfTl6eFjkbQgYMynWofN4pIlvDy2ldfQPbdnLOOuUJOI8ApP7O37/U6LQoqC2kmOh1Nhn3Y1Fu4FktnFVI316UcHJMDajaP2LsF5+KLO58NUtITSIAj6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlpPRGUzcVVwSUVVN2x2TnptVkNxQ1RBRVBoTXFCMlcvVnpyNjFBVUc2amJR?=
 =?utf-8?B?VUl0UFlVWkExbmZuSWpJRGVUanE1TW4rS2pWNGc1OHRjRUJJVGJ5Y0FVcnVH?=
 =?utf-8?B?amtEeDErb211bXBMN0VMdjF1RjhRdW5YZFl4OUdhZWNNUkpVL2k0T0hIbGxt?=
 =?utf-8?B?dTRTS3N4eUdDSVg4SERCaHpTajZrcDJHaURqejZUNW9GZ3J3NXlPQnhzRnh4?=
 =?utf-8?B?NzJ2aW5HMWlmV1d2WmVyWWp4allmS1BpUkxsa0cxaFBJL09FZmV1MVNKb2dH?=
 =?utf-8?B?VWVMeWs4YUhLYjNhVWNFcUNMQ2tnNE5MZDVSaTlheVRKTzQxVUpvVk5wRVd4?=
 =?utf-8?B?QnFFK2YxNVFCWFBubVhoaXNLcTUxRDNXY2xPR3drRktJVC90ek9paE1HaTkr?=
 =?utf-8?B?T1NubTFPNXF4T1hqWGpHTGoyUHg2VmFIK0tkNXBKSEZienVoZHFUSjJjVGtE?=
 =?utf-8?B?RHFvcDE2VjJQbnJaK2hVQWdoOHJlRzR5ZWF0ZFhKWmg5V3lEVGxneVR3bEFZ?=
 =?utf-8?B?YTdXVm1lb3RobEpDbG9BSDIvN3pKYWZVdk5UTXo0SU5TSUtjc1N5K3pka1lH?=
 =?utf-8?B?Y2djWHpRSzFFUkR2YnM5dW03d2oydTB1Z2VDRVlsTk9PZFlDUDJicUFrc0tv?=
 =?utf-8?B?SnNib3plSDlPL2JEUnk1WGxYODF5RWFNdXRaenRHK2VOU010dGxTazhDQ1ZN?=
 =?utf-8?B?aldnbkdybDFBWmc4Q2U0V1ZhRzBscDAxSjBlVk1HeElNWmV4dEdYLzMzdzN1?=
 =?utf-8?B?U3FoVWlkZ24vbldObTVuTVV5STVDaGR6aTRDb3E2U1BrVHRHN0IxVEx4dk1M?=
 =?utf-8?B?VnRQS3NnVEx0elA0VnZXVGxwRjVjeUp5US8raG9pUE1MUE1USS9xanloVWZz?=
 =?utf-8?B?elRlWHRWZW9lR1kvOUtTOS9zWngvbWZDMy9Ga1NkSlYvaVNBUFU0WDJBd3FI?=
 =?utf-8?B?dkFMREhvaTlWUGZjVTRLM3VkZWltTnB1dE5IUE5WYzdkMkQxc1VXWFlITEVF?=
 =?utf-8?B?OFprc1FBbzdrblJBc0dGVmE2clNtbkRVVUdpSGhaVU1pOTExbCtCdHZCRS81?=
 =?utf-8?B?c1IrZFVuTlRKQktIdFZiRGVlbXVEZzQ5RkFiT0Z6eENRQkJja0d4YXZIaW5s?=
 =?utf-8?B?czk5c2JRdEpFZTNWNHZ0SG1oQUtEcGdJTWg4L2cyNVJrL1dhVHJ1dDVjUktS?=
 =?utf-8?B?MjVGZ2tvMEV1WVJnK1BXeFBzcGo3djFsVlozQjUyTWVPSkJ1OFFXMmZhSi9C?=
 =?utf-8?B?d3dUSVdNK25nc3luQVU1VnovL1FqNEVabG9YQmR2OFlHb3FYdndMZWc5U0ZS?=
 =?utf-8?B?cXRjUFFaMVJMYTlBcWR4UVZTdFBFWThqTTdLUUpzclQ5Qnk2M3ZPY0xVL2x3?=
 =?utf-8?B?MWVsa2xMbWhWUDh2WHpFZHQyU29YNzhCdDRLd3lTNjBOZVRITS9Wa2ZiTGo0?=
 =?utf-8?B?VmhXTXdISUIwdDRmWnNtdXJhRTRRTmlMQUtwdzhvdGN2d3VGbHFLMnFvTXhO?=
 =?utf-8?B?SGtxamd5QmYxUUlwTEdQMUVyZ2hDT28vRUZmemhlTXFtWElZM3Mwa0tKSlNZ?=
 =?utf-8?B?ZXJodzk1alJVdmxNeERaenZveXo5K2dtcGt0SkZKSE1zTWNtS1EzSnNMYkpx?=
 =?utf-8?B?ZkxiR0dFUlNDSjBoWE9OQzhuTGxxNG40d0pVMWJkbS9KRUJ3SkN6SEs1b1A2?=
 =?utf-8?B?WUFsN05xYnRuODRVZUoxNGVFWUdkSjRxZnhkTTRMNi84eTRnZDhYaTlLbHc1?=
 =?utf-8?B?WWd5aUVwVFR2aW1uck05TG92TzBEaGE1emU5emhSZ1pSRi9WT0pFZ0NEdzVE?=
 =?utf-8?B?TDhRWjFFeHJaMCt5ODJINTJQZ0E2bWxTUURFK2UzUG1GSUlxZmJzUXNQbXF5?=
 =?utf-8?B?b0s0RmxleEhOcVlLejVIVmp0cVZDZFd6d0lxUlhXVFBTT1JOTXovSFNjVlVr?=
 =?utf-8?B?Tm50clFueDZScHFscFBHYVl5cEdNZHFMZU9iVlEzd25DVU9hTHRDME9yZXBu?=
 =?utf-8?B?SVF1MmpMWUxIMWp3VE9aTjZENkdhY2pIb1ZZQ0sxQ3YzMjN2Q2wxT3B2OWVN?=
 =?utf-8?B?eEo4NkVRVDJ3eDA5MThIK0RSY243NWpQSWxyMHdIWVhIQXpKNTg5aHcwQ0RE?=
 =?utf-8?B?Q1MwRytyZ1RWUVpSSVNlM3VoM3NCT0FjSjNnYW0xZjdkcy9xTE0zSTdEUUFX?=
 =?utf-8?B?Ym1zb0FreldpOUFVV2FRYktpZzBUZW5wWTVoZlZ4L1BmWjNhdTEvTjVTTXgz?=
 =?utf-8?B?ZERxTjdGRTNwejYvSnFoMkxxNTZ1WmorUzlMVmdyLy9IY1BlQ21mblREb0lu?=
 =?utf-8?Q?8v2f5nwjJ3Af2ycLwc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25503146-387d-4d4a-50c0-08dea9dddca4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 13:05:49.5472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knHaUJL9PAwKxVAGemWqFhgurVyz+5DgxfcFjS1K67kwee5PFLvi7jwvZvN/Lro4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9475
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

On 5/4/26 14:56, Sunil Khatri wrote:
> Use drm_exec to take both locks i.e vm root bo and
> wptr_obj bo to access the mapping data properly.
> 
> This fixes the security issue of unmap the wptr_obj while
> a queue creation is in progress and passing other
> bo at same address.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 122 ++++++++++-----------
>  1 file changed, 57 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 501e2e10b4a6..3d4f83015488 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -30,34 +30,6 @@
>  #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>  #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>  
> -static int
> -mes_userq_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
> -{
> -	int ret;
> -
> -	ret = amdgpu_bo_reserve(bo, true);
> -	if (ret) {
> -		DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
> -		goto err_reserve_bo_failed;
> -	}
> -
> -	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
> -	if (ret) {
> -		DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
> -		goto err_map_bo_gart_failed;
> -	}
> -
> -	amdgpu_bo_unreserve(bo);
> -	bo = amdgpu_bo_ref(bo);
> -
> -	return 0;
> -
> -err_map_bo_gart_failed:
> -	amdgpu_bo_unreserve(bo);
> -err_reserve_bo_failed:
> -	return ret;
> -}
> -
>  static int
>  mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
>  			      struct amdgpu_userq_mgr *uq_mgr,
> @@ -65,55 +37,75 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
>  			      uint64_t wptr)
>  {
>  	struct amdgpu_bo_va_mapping *wptr_mapping;
> -	struct amdgpu_vm *wptr_vm;
>  	struct amdgpu_userq_obj *wptr_obj = &queue->wptr_obj;
> +	struct amdgpu_bo *obj;
> +	struct amdgpu_vm *vm = queue->vm;
> +	struct drm_exec exec;
>  	int ret;
>  
> -	wptr_vm = queue->vm;
> -	ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
> -	if (ret)
> -		return ret;
> -
>  	wptr &= AMDGPU_GMC_HOLE_MASK;
> -	wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAGE_SHIFT);
> -	amdgpu_bo_unreserve(wptr_vm->root.bo);
> -	if (!wptr_mapping) {
> -		DRM_ERROR("Failed to lookup wptr bo\n");
> -		return -EINVAL;
> -	}
>  
> -	wptr_obj->obj = wptr_mapping->bo_va->base.bo;
> -	if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
> -		DRM_ERROR("Requested GART mapping for wptr bo larger than one page\n");
> -		return -EINVAL;
> -	}
> +	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);

This should probably be 2 instead of 0.

> +	drm_exec_until_all_locked(&exec) {
> +		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(ret))
> +			goto fail_lock;
> +
> +		wptr_mapping = amdgpu_vm_bo_lookup_mapping(vm, wptr >> PAGE_SHIFT);
> +		if (!wptr_mapping) {
> +			DRM_ERROR("Failed to lock up wptr bo\n");

Please drop that error message. It can spam the logs when userspace intentionally gives incorrect values.

> +			ret = -EINVAL;
> +			goto fail_lock;
> +		}
>  
> -	ret = mes_userq_map_gtt_bo_to_gart(wptr_obj->obj);
> -	if (ret) {
> -		DRM_ERROR("Failed to map wptr bo to GART\n");
> -		return ret;
> -	}
> +		obj = wptr_mapping->bo_va->base.bo;
> +		ret = drm_exec_prepare_obj(&exec, &obj->tbo.base, 1);

Using drm_exec_lock_obj() should be sufficient.

We don't need a fence slot for this use case.

> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(ret)) {
> +			DRM_ERROR("Failed to prepare wptr bo\n");

Same here, that this can fail is normal handling. The worst case is OOM and that is already printed in the logs.

> +			goto fail_lock;
> +		}

We got all the locks now, so the drm_exec_until_all_locked() loop can be closed here.

>  
> -	ret = amdgpu_bo_reserve(wptr_obj->obj, true);
> -	if (ret) {
> -		DRM_ERROR("Failed to reserve wptr bo\n");
> -		return ret;
> -	}


> +		/* mapping now should be stable since both the locks are held */
> +		wptr_mapping = amdgpu_vm_bo_lookup_mapping(vm, wptr >> PAGE_SHIFT);
> +		if (!wptr_mapping) {
> +			DRM_ERROR("Failed to lock up wptr bo\n");
> +			ret = -EINVAL;
> +			goto fail_lock;
> +		}

Doing that again is unecessary. We are holding the VM lock above while doing the lockup.

>  
> -	/* TODO use eviction fence instead of pinning. */
> -	ret = amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
> -	if (ret) {
> -		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin wptr bo\n");
> -		goto unresv_bo;
> -	}
> +		wptr_obj->obj = amdgpu_bo_ref(wptr_mapping->bo_va->base.bo);

That is now unecessary as well.

> +
> +		if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
> +			DRM_ERROR("Requested wptr bo size is larger than one page\n");

Same, please drop that error message.

> +			ret = -EINVAL;
> +			goto fail_map;
> +		}
> +
> +		ret = amdgpu_ttm_alloc_gart(&wptr_obj->obj->tbo);
> +		if (ret) {
> +			DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);

That error message is useful.

> +			goto fail_map;
> +		}
> +
> +		/* TODO use eviction fence instead of pinning. */
> +		ret = amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);

Oh! The piun needs to come before the alloc_gart! That's wrong in the existing code as well.

> +		if (ret) {
> +			DRM_ERROR("Failed to pin wptr bo. ret %d\n", ret);

That error message makes sense.

Regards,
Christian.

> +			goto fail_map;
> +		}
>  
> -	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
> -	amdgpu_bo_unreserve(wptr_obj->obj);
> +		queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
> +	}
>  
> +	drm_exec_fini(&exec);
>  	return 0;
>  
> -unresv_bo:
> -	amdgpu_bo_unreserve(wptr_obj->obj);
> +fail_map:
> +	amdgpu_bo_unref(&wptr_obj->obj);
> +fail_lock:
> +	drm_exec_fini(&exec);
>  	return ret;
>  
>  }

