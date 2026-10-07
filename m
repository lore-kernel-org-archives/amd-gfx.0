Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE1CCA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 13:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2F8C10E57E;
	Wed,  7 Oct 2026 13:17:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sBFdLPQZ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013067.outbound.protection.outlook.com
 [40.93.196.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 114DC10E57E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 13:17:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+7CD84MyWv4+Y9Ef8dbl3G3UhiVY4sv48HC8crniqR434qq3O7hIc2Q/Y8csBCjSOe+1bY05em3R8Ehf2GjnmZMXalQI0pAFBpyqD4etC51+6dY3AY1el3R7MNoHG+icNUOCAP540zWzG+XAZ8azQ/oX4A/ZqppgpZmWpspY+nivY/RDandViO4ZE23NIrt6NynLIrtY1MZIhMfBhyuQGMFBFUdpBJwzvyupRrDDRQfJfquatQQp7YsAeElAAiC0/4PLIftd6ab++STS7IO9uCy+kuYq37HKugOUgq0EVclr7VwoIVT3jRsX7GhwD0EAQtwiv0URWjoqRHIPeiEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EpFr4l8oqf0nNVN5C9FJiZLt6cb3z19WRKOgd2oVVM=;
 b=p4l+xK8BG0ni3nEeKl6fkZXIhbq5Y60vHXLbysie80OYzrwBF61ThZUoyUP84oSpIP8LrjhOhFj+MpBAXi+dDZ4np/YjGDfNRwzhqKFeX/bIFomYISL3AlGC3xMDlHg+TiGapNLGkIDBWp5dujqlzy2Z78Nor/+6u8ik2nYiA6RNQ+2N34C1KGQjmsgJyqPJttCpwla+h34jZX/9CwLC7nb2jeEVQw1gAYbtnb+8RPTAblOP/8CMTPo7ulgBjUntLRbBMYrfcfsk7HCj7eMuDw+Nc/IbKxUjENaOFykMyeeMTLX2iU+gDP0PiV4P3WwCtmxhLJjymunb64unaFbaZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EpFr4l8oqf0nNVN5C9FJiZLt6cb3z19WRKOgd2oVVM=;
 b=sBFdLPQZ0u8pOrFQ15k18JVM4NrTQ0M3/0YFUcgTq0ZtNdEPIL5tQS3a+6IXmX1/bxg6v+fWLqnkjB9utu7gZzGfiYD2z+zpRfnNbJkLUA1z3lpdO4MqhVLFDheIG+BQKr1oWOqGXTl0VT7jaUFqgNMKGUqo+STk+v9pjmgd1hE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 13:17:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 13:17:39 +0000
Message-ID: <46bd840e-b7fb-48b3-a940-565a5e90e95f@amd.com>
Date: Wed, 7 Oct 2026 15:17:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] drm/amdgpu: Add ioctl to set level2 handler
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>
References: <20261007110506.1065076-1-srinivasan.shanmugam@amd.com>
 <20261007110506.1065076-8-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261007110506.1065076-8-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a789679-c4c9-4619-9944-08df24755c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|4143699003|11063799006|260925021911599003|10067099003|56012099006|260925021311599003|260925022911599003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: g09cZ7Z41GChzQ3G54yzZxj8UcEGvW46O8ja5G3ga6SaOy84lKw72nE9CqHidM9xW0964YqLKrPk9zO9C597u780JHHVYoD9WEPO1d9JCcAoomWlR+kRtQuUS/94/KVbY0/xY8nRuLKIXK+KQTZrOCDnfM3CM6gWHpw+yHhx92ZaivwtuuSZRm6iiutkjeClArJb+TnWVxLqdhJNaunrcLbWHJErYeYP0odGa7BxThI1GXcCmnV7veEpGLoK8EkVORZ6uf/UdXXC+l49/zCqWWi1fZjKVPB0gKDCJ1YHT0HuU2MxERTpZCm8t3q3ODS2dr5lgOKHUqaZ/F0AB+2AdZLgJ37zQ7YR6vYslm2Pxnxt5qpesnNd/m3ftAyPS9cfRyNNqg77fcyd/K5aX2IrYcIMJxFBZz8ynw97Nbsz24kPszC8FhD2DYrN15y4aPC/S0GWAUeIyPnFjLP1H427QflPC8FJv2dRWPIjMAv2mmMMRu06wIkO/5MyEcy3ftfuscm5uno/oZSR4Wcuwd3x6Lk+Fxdqd+hhSLKWOLutby7dGHteym33VW0HIFNBe+OT/IGRd+iUWpzlJGPqqXKIPwupLejBYq7pLGcZxA6MWsz6HZvj/M3C5wPz2NtW58wuVHKIfq7e1W+evZqMhWi9nM+nXdaBUt8FlOd8eetdqy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4143699003)(11063799006)(260925021911599003)(10067099003)(56012099006)(260925021311599003)(260925022911599003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alVGZ0ZvTHRpLytLSWxuTzJsTU9OdkRVd2hBM0FVTWMyVldaS3RkQmZSeWhm?=
 =?utf-8?B?ZkFlSUFYRUg0eHR2QnFEVloxK0F5S2hLRFJCNDI0RW5FQ1FBKzEwbm1vM1o1?=
 =?utf-8?B?SlVSZzhjR05QRUxUYkwrNGNwOXMxSmNmanExbDlWWUlYc0hGYk5vVHpGOVNq?=
 =?utf-8?B?V2lLSFA3ckFXNCtzZ0ZSa0FzTEh1ODViUnZlZWZuVmZHZ21oSE9yRjdDZVdY?=
 =?utf-8?B?TWRmTmVIYjVBeGlUSU00N1NBU0VxcTVvaUtvZmlnMDZXbUc3TmZTc3IyblBO?=
 =?utf-8?B?ZC9KVVUyZnhLV3NFUVgrUTBSYUFLalR5eTA3ZXNjcS9tM1ZQWVE4ZVZjditr?=
 =?utf-8?B?WDlpUTdCVVg4TVJyTTJlSTJCUEc1Nnlic2pyaUJJdmdMNXdlUVErSHZ5TzNO?=
 =?utf-8?B?b2I4Z0tRb2JBdlo2WUxaU3lYak9yVWphSE5GUUFmOUpRd0ZKTnpMdWVuNHpi?=
 =?utf-8?B?a2hGVEJBNHdRNGNHU1NXZzkzWjJGYkNrRHBRRno5cHBQTE9XRmRHMThWTU1z?=
 =?utf-8?B?cWdhY0JONjcxNFIvK3QxQlJtQVBEVVp5N1NheHVLY3lDNW1DRTlVZzkwVTZQ?=
 =?utf-8?B?ajlJK3Q4SnIzMlNyTVRqZHR0amszaW9HU1RubjAxL1p4U0dnUWpGN2ovWnZQ?=
 =?utf-8?B?MTdsQVNIVlV3NjQ0SkNHU1hnRXZvUk9YNG1EV1E0OEovZmp0NGdVL2xmK1dp?=
 =?utf-8?B?WlNOTE1wcmd3SnBtOEpaSXcyTm05d3BCd1BJZW45QVhmaUx0SlJUZXFkYVN2?=
 =?utf-8?B?MytPa1dWV05hVUdkdllDcXpxRjVGdnlNYmRwRlJMejFZV29ZcWNwZzd5V2tR?=
 =?utf-8?B?N0xRUVNYdTRBRUxRTVdRTHZURmlQV1N4bFFIMG9CZmZRZmREVldoZjk1M25F?=
 =?utf-8?B?OGpDVll0UC9IOFBDRnBYaEVXeFdpZElndW9USWtlbktvVk0yd0c4WS9uSFN0?=
 =?utf-8?B?QkR2N1U2M0Q4YURkSlNmc2xFZk11cjZiSXJOaGhlcVJCOW5sYVFPUzRQa0g4?=
 =?utf-8?B?dStlNVRiSDNWS3dIK3pacnFPVXI5eFpYWHM1b1BaaWpJRmdHekFkSk9vZGZE?=
 =?utf-8?B?WVVydi9Xb3YwMFZOeW5waU9EcVNsNVFybGhuTWVnM05pMW9UamRyT1NLS041?=
 =?utf-8?B?b2RrN1BVZVVRU0tYZ3BwYTlwQytwL0tCNHA4YnQ1Y0FSWnMvQy9ReHRWdVph?=
 =?utf-8?B?R3dwUVRUOHlKaXEzWGk4TjRuVkNzbGIwTUxKN3Q0N25tZDJDVDI0SlFvbnRK?=
 =?utf-8?B?cmhZVXJiSVNaSGNZQVBXZVp0SFBuRDBCWE9sUUtrQmdNbE1wMWZIUk1YYnQz?=
 =?utf-8?B?ejNvZEVxR0taMXBaa3BvL3ZnR2pmR0hSbFgzRk9QNVRSUTRMcDRKdVdOY3oy?=
 =?utf-8?B?N28vUElSalNNbStXQUl0UE9IMEJqamtRVFkrRC9Pc3NoN2EyN3lZVk5YQ2pD?=
 =?utf-8?B?dDBHV3dmTWt1R0QreWJCWEVVRUllam0xbzJraGZZL1QyZHE5TlJoNWpGSzlV?=
 =?utf-8?B?b3NDMkM5OVRGenlCUHMyc3RzSjN5d1dORzZzSmhQbTZtL3QzWEJyQ3VJWEF0?=
 =?utf-8?B?WlZoejlpU2daNlloekFLRmVDSk5BdVFxRFlKbTFJYVNJTCt2bWttUXBjM0o2?=
 =?utf-8?B?MFNWRGtmQ3lxUVZpV3FiSjJhZG5KUU5YL08wZmFEbG1ESHM4aHR5UVBXaXUr?=
 =?utf-8?B?c0VxY21JRldtWFJsbkpuRk5SVXoyMldVdVNJYkR6Smp2OXBTMHl3emZTUm54?=
 =?utf-8?B?cHZBRmR1V0ZRQ3lyeGtoS01udGJWalhrcTZiZU5vYTdVMXQ4azhvQzJHMkor?=
 =?utf-8?B?NVFnMG05LzdUWEhBZENnU0h1bTRVdHQxZFZXdkE2bm00amZLTTBLOUVQa3VL?=
 =?utf-8?B?c2hJTmxwenpoNWdFb1puM3hBQ1hOSUg1ZllXM1l3Nm9YUit5OXdUdjlVOVd2?=
 =?utf-8?B?d3VFQVRtL3lSNEpPS3ZlR2s5NWNtbG1TM2FYN3FNSFJpdC8zVkpibERHeUc0?=
 =?utf-8?B?Tys2TVhDcmh5dEtzcGJ6bk1uTElUZ1VHdnJMbVZqMEp5OVpaWkdUTGd6RkE2?=
 =?utf-8?B?TkdGTFpsaXVYUGxJdGQrOVg3cXhvT0pvOHRUdko1T3lxOW95SWtQSzBKU04y?=
 =?utf-8?B?SElrQktTcmVuSXF3ckRnNTFxM2p5M2pYZy84VnBCUjVwREVXQXFLbXFZcDZx?=
 =?utf-8?B?ZlFpRm4rU29mRmN1aTRpQkI2SExuK2t0cTR1bzZvUEdSbjNKdmkvTGNwdFN5?=
 =?utf-8?B?d0NjdUprWW1ieUdGaUsydkdrWDhiZGozQnExL1dqeEREdUdzMWxaaXRUaHpQ?=
 =?utf-8?Q?GqSgoHSeEI3FBzDLxr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a789679-c4c9-4619-9944-08df24755c72
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:17:39.3762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYH0eiyv6WK8cohbxuy2AOaZgdF12cC0mN0ajxisFnZH6Y6xW28u2Hy2TQ2/1zj4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216
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

On 10/7/26 13:05, Srinivasan Shanmugam wrote:
> From: Lijo Lazar <lijo.lazar@amd.com>
> 
> Add ioctl to set tba/tma of level2 trap handler

Ok reviewing that won't work like this. That interface was rejected upstream.

And since we are replacing this with the VM IOCTL it doesn't make sense to review this change here.

Srini, please squash those changes into your patches instead.

Regards,
Christian.

> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Change-Id: I6e3d326b6772e1e6ca4355ce82743e1714449713
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 105 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |  11 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |   2 +
>  include/uapi/drm/amdgpu_drm.h            |  23 +++++
>  4 files changed, 140 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> index 6b6c11bb5fd7..1db74e1fc97d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> @@ -532,3 +532,108 @@ void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	kfree(*trap_obj);
>  	*trap_obj = NULL;
>  }
> +
> +static int amdgpu_cwsr_validate_user_addr(struct amdgpu_device *adev,
> +					  struct amdgpu_vm *vm,
> +					  struct amdgpu_cwsr_usr_addr *usr_addr)
> +{
> +	struct amdgpu_bo_va_mapping *va_map;
> +	uint64_t addr;
> +	uint32_t size;
> +	int r;
> +
> +	addr = (usr_addr->addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
> +	size = usr_addr->size >> AMDGPU_GPU_PAGE_SHIFT;
> +
> +	r = amdgpu_bo_reserve(vm->root.bo, false);
> +	if (r)
> +		return r;
> +
> +	va_map = amdgpu_vm_bo_lookup_mapping(vm, addr);
> +	if (!va_map) {
> +		r = -EINVAL;
> +		goto err;
> +	}
> +	/* validate whether resident in the VM mapping range */
> +	if (addr >= va_map->start && va_map->last - addr + 1 >= size) {
> +		amdgpu_bo_unreserve(vm->root.bo);
> +		return 0;
> +	}
> +
> +	r = -EINVAL;
> +err:
> +	amdgpu_bo_unreserve(vm->root.bo);
> +
> +	return r;
> +}
> +
> +static int amdgpu_cwsr_set_l2_trap_handler(
> +	struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +	struct amdgpu_cwsr_trap_obj *cwsr_obj, struct amdgpu_cwsr_usr_addr *tma,
> +	struct amdgpu_cwsr_usr_addr *tba)
> +{
> +	uint64_t *l1tma;
> +	int r;
> +
> +	if (!amdgpu_cwsr_is_enabled(adev))
> +		return -EOPNOTSUPP;
> +
> +	if (!cwsr_obj || !cwsr_obj->tma_cpu_addr || !tma || !tba)
> +		return -EINVAL;
> +	r = amdgpu_cwsr_validate_user_addr(adev, vm, tma);
> +	if (r)
> +		return r;
> +	r = amdgpu_cwsr_validate_user_addr(adev, vm, tba);
> +	if (r)
> +		return r;
> +
> +	l1tma = (uint64_t *)(cwsr_obj->tma_cpu_addr);
> +	l1tma[0] = tma->addr;
> +	l1tma[1] = tba->addr;
> +
> +	return 0;
> +}
> +
> +/*
> + * Userspace cwsr related ioctl
> + */
> +/**
> + * amdgpu_cwsr_ioctl - Handle cwsr specific requests.
> + *
> + * @dev: drm device pointer
> + * @data: request object
> + * @filp: drm filp
> + *
> + * This function is used to perform cwsr and trap handler related operations
> + * Returns 0 on success, error code on failure.
> + */
> +int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
> +{
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	union drm_amdgpu_cwsr *cwsr = data;
> +	struct amdgpu_fpriv *fpriv;
> +	int r;
> +
> +	fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
> +
> +	if (!fpriv->cwsr_trap)
> +		return -EOPNOTSUPP;
> +
> +	switch (cwsr->in.op) {
> +	case AMDGPU_CWSR_OP_SET_L2_TRAP: {
> +		struct amdgpu_cwsr_usr_addr tba;
> +		struct amdgpu_cwsr_usr_addr tma;
> +
> +		tba.addr = cwsr->in.l2trap.tba_va;
> +		tba.size = cwsr->in.l2trap.tba_sz;
> +		tma.addr = cwsr->in.l2trap.tma_va;
> +		tma.size = cwsr->in.l2trap.tma_sz;
> +		r = amdgpu_cwsr_set_l2_trap_handler(
> +			adev, &fpriv->vm, fpriv->cwsr_trap, &tma, &tba);
> +	} break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return r;
> +}
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> index 5717e1d662fc..2cf485111e8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> @@ -31,7 +31,7 @@ struct amdgpu_device;
>  struct amdgpu_vm;
>  
>  /**
> - * struct amdgpu_cwsr_obj - CWSR (Compute Wave Save Restore) buffer tracking
> + * struct amdgpu_cwsr_trap_obj - CWSR (Compute Wave Save Restore) buffer tracking
>   * @bo: Buffer object for CWSR area
>   * @bo_va: Buffer object virtual address mapping
>   */
> @@ -62,6 +62,11 @@ struct amdgpu_cwsr_params {
>  	uint32_t cwsr_sz;
>  };
>  
> +struct amdgpu_cwsr_usr_addr {
> +	uint64_t addr;
> +	uint32_t size;
> +};
> +
>  int amdgpu_cwsr_init(struct amdgpu_device *adev);
>  void amdgpu_cwsr_fini(struct amdgpu_device *adev);
>  
> @@ -84,4 +89,8 @@ static inline bool amdgpu_cwsr_has_dbg_wa(struct amdgpu_device *adev)
>  
>  	return gc_ver >= IP_VERSION(11, 0, 0) && gc_ver <= IP_VERSION(11, 0, 3);
>  }
> +
> +int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data,
> +		      struct drm_file *filp);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b2a8a8b37006..7a2b97d9f51a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -52,6 +52,7 @@
>  #include "amdgpu_sched.h"
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_userq.h"
> +#include "amdgpu_cwsr.h"
>  #include "amdgpu_userq_fence.h"
>  #include "../amdxcp/amdgpu_xcp_drv.h"
>  #include "amdgpu_ualink.h"
> @@ -3122,6 +3123,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>  	DRM_IOCTL_DEF_DRV(AMDGPU_SCHED, amdgpu_sched_ioctl, DRM_MASTER),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_BO_LIST, amdgpu_bo_list_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_FENCE_TO_HANDLE, amdgpu_cs_fence_to_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_CWSR, amdgpu_cwsr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	/* KMS */
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_MMAP, amdgpu_gem_mmap_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_WAIT_IDLE, amdgpu_gem_wait_idle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 9317018330ec..eed8a7f7e88b 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -60,6 +60,7 @@ extern "C" {
>  #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>  #define DRM_AMDGPU_PROC_OPTIONS		0x1A
>  #define DRM_AMDGPU_UALINK_HANDLE	0x1B
> +#define DRM_AMDGPU_CWSR			0x1C
>  
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -83,6 +84,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>  #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
>  #define DRM_IOCTL_AMDGPU_UALINK_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_UALINK_HANDLE, union drm_amdgpu_ualink_handle)
> +#define DRM_IOCTL_AMDGPU_CWSR		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
>  
>  /**
>   * DOC: memory domains
> @@ -1695,6 +1697,27 @@ struct drm_amdgpu_info_cwsr {
>  	__u32 min_save_area_size;
>  };
>  
> +/* cwsr ioctl */
> +#define AMDGPU_CWSR_OP_SET_L2_TRAP 1
> +
> +struct drm_amdgpu_cwsr_in {
> +	/* AMDGPU_CWSR_OP_* */
> +	__u32 op;
> +	struct {
> +		/* Level 2 trap handler base address */
> +		__u64 tba_va;
> +		/* Level 2 trap handler buffer size (in bytes) */
> +		__u32 tba_sz;
> +		/* Level 2 trap memory buffer address */
> +		__u64 tma_va;
> +		/* Level 2 trap memory buffer size (in bytes) */
> +		__u32 tma_sz;
> +	} l2trap;
> +};
> +
> +union drm_amdgpu_cwsr {
> +	struct drm_amdgpu_cwsr_in in;
> +};
>  /*
>   * Supported GPU families
>   */

