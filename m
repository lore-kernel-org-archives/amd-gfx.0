Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B02FF885A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2026 08:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 015BB10E9C2;
	Tue,  5 May 2026 08:16:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D0ALUpW5";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3830510E9BB
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 08:16:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeuEKNXA7yk1fxTlCEXfqBVIE06PiOKgAzCtF1PS4/AXIkG1q4JMJhd6mC54jt/ZZssrQ5/gGtqKqh+zGQ3FYlNSyh11cVAcn0em34WpG3vnJEMxxo+x9EgCUnAsrVoLgV4FrZwySImcxZztGZTmppc9WRtf7m03bjq61DAEvXWfBX4NMA6YQdcODxMNWylm8mrzUGVX2PCnb2Z7cB5vRhekWLLsg09THRYsoQo6TB5TRRfrr7EtfWqmOHLho5yf4z/5pS17OoXEVOGNAYImNBrawFVZF3xjJ6F59i+wH6iZhXf2PJ+QH3x06x4BJENr7EfIQDwTOojXHYnyzOacmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=619LzfUSBsMBsV/lmncQjUijbEVnQrxIOMAUiADXJSo=;
 b=stv4WAlXQ3RJtF/wZD9Hn51SoDjYTqrp19g2aWWaCGCO/dn22dVG3BoRwjnUqc5QsFS285snc1471Pmxp3r5eZGD87WUTm3JsgcKHvyL8JNGateSilZ9FKYK0/+eritmk/RxavP1z+ouuSf44mcLZay5CJKstkdiDqQGpbA7CNXM61IgNsNE9ofKePHSeJCyg2kvOvzMfNgiL77Ki3p+nCFSaW0WNCboJIVVqLNvAxjtKNGOIY3/Hg4XfnJ5U8lxOjxxiyBA0sBmgUa6auQOy1Gn8CtSGbDpP4xAwdh8RuIJIRbamBOeDdNlkPCrFhjHuiXsISHMQ3J5wFa4nZXqjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=619LzfUSBsMBsV/lmncQjUijbEVnQrxIOMAUiADXJSo=;
 b=D0ALUpW5m9Wj5xmtZPYgHLiQUW3zFGeuiKDvreNr2JmyxpEwWIkUipduCfP/+6+AyjyweQO0T2flwGLy2ZA5EDJnd35/IZDiGmWCCnjPmxRRk6YK4AvtzBCs3AjHZ5FxoeNV37iKiGfDc+puMPVzPPbmSkHYb6pDYBekyIRfo4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:16:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 08:16:39 +0000
Message-ID: <3f770fe7-b76b-446a-998b-0d6acef1c5eb@amd.com>
Date: Tue, 5 May 2026 10:16:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [[PATCH v2]] drm/amdgpu/userq: fix access to stale wptr mapping
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260505080426.500411-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260505080426.500411-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: cae5ba20-815a-4ae6-357a-08deaa7ea1e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: cVG5MehroO7/q04I2AJ2N1gUk4HPe3FH6ofJW+r5Hne/oU4B0RsOkm29QbCBhLKwizBNEPZk8oCH9TlAekWtsM1xG1Y+rbEBl8bIa0Tsh01p0bSIR27M+1LXt8CTQa3EwmZ6CxQB6JH8a7KpYUsCIpZ8si9U1+N6yoM/XX4yrF3Q5rWPqrqh5ty9mrO3+SpZfwSGZ1hQuCmfb9Vxf9UIDK+6e68KK98NIei6Fq9Uj7NIJoNDcKTe//H03DfHxwkFsy//2KlNjaJxSofs8Y8YWIMbO0j3wu80kZiaWuk63I1ey5m038x1l7Es5UBoz8NLhclFd6rmiwoOHBa3uIdXYVXbFaawMZzYksVqTBuPNyp9+dy28sGcCGgvc8+Vm2QbQcIc3rxRtV9MO+zkvNaOSHgGIv5drD/VlYLW3bGamFPXZBWXNyiDJaXHD1XXdOHIF7Rfu1Eet+g5GK7flFJsJfcGWG1ShJPP2blFFOoJvUVbDG1kwa5NjkQMZzVlnnQBFEuORInIrFcs14ZMpJ4/DsTgWFo8NY9hopZxmgDdupHU+dUTNfhjCo5aDdfAE3+tmsP7Xgq2Z/vwDpdfxA3aYvCHO4K6PCuB9DAN4fXOW5vpjBCndB8iiokOB3Ju+np2nNcvqLjdjN4A3vSsno3JJvb+81qIPCN7xEV3OxqERQzEj/R0UqYHT9kA3tVlnR6a
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjlDdGNQeHBrU0Zab2dQY25rZE0xVFlpd1loR25udTBKYUwwMzZjamFyR0xH?=
 =?utf-8?B?b1VBN082OGM5dUNEdkRVREl4T0p6MjdrWTVNT3V0WEE2UThkcU52WTFMbDFM?=
 =?utf-8?B?Y1prRkhYQWx2aHQ3S0t6ZzFwWTFCTERjVDJSaEFDdFZydHcwYTBOQk5Gb0E0?=
 =?utf-8?B?NUFyL1Y5YVhVamNOYkt4cFNTRjYrOGZjSFpKMHRTM0pUZUl2U3R1UmVBRjJx?=
 =?utf-8?B?WGxEenRweEpvS3ZiUkp1RDVSZFdRNE9iR0dIWXM2R21qRUUyKzA5TUo5UG1a?=
 =?utf-8?B?cDFGNGp5T01iV1pTZnpIZEpkVkVrQ3o5alFxNGtJZm40ZjZxOFlzNWVjSHlW?=
 =?utf-8?B?UVdyRHNtS3pCZFNxbHp2MjgwaDF4T3dnSUpocmxwRXkwVy9tV2RrR0dSLzhI?=
 =?utf-8?B?Qkh3ZVdjZEJuTHR6TXBoc3F4UExNbUNaRDNlZHlDblcrZ29wa2Ric2FYNDJZ?=
 =?utf-8?B?ZnhjSHBwZzJCbEtHQW40V0t0S3I0ZzM2U2NqUFV6NnFpRDArYkcyVnltRTJw?=
 =?utf-8?B?QUNtbXdibTR0ZHh0VVFVcndZc3ArMmRJZWorODg2VEJSNUQ3UXZwcG96SVZW?=
 =?utf-8?B?cE8wdXhOaW16dU5Sb09zQlFhUDRsNmZ5SHJVcCtkSHB4TlplY1V2TENnaGtl?=
 =?utf-8?B?WlI0TXNPbjZJV240QTVDTjI5RG5vYXpVNndnZnBhb0pmOWR1ZHAwdjR5bE4r?=
 =?utf-8?B?ckxvMjlxQnpkZnJmLzlFYmdZUm1wQjdYYnpjM1hBOFRBMjhOL0ZVUjh5QU41?=
 =?utf-8?B?WlF3dnhxY2ZSSnZHV00xU1hXclI3SG9uT2tjcUJ6cHZSeUVtNUprK0tYYmpP?=
 =?utf-8?B?TlNRSTdXZHo5cFl5VWpqaWxKL2NqYVZKVzRVcGlzemtSUnhha1pRK2lGMkl4?=
 =?utf-8?B?TmtMcWx3QStaOHM2M0c4Y3lsZVc3YTRSNmltNzJGdXNVU2R4bXl2L0l0L21R?=
 =?utf-8?B?Mk5qVk9FdDJINzBlVlJPbFhIVG1xRzZkcEVJMVB5TklTUE9pbndEdnFZVHp2?=
 =?utf-8?B?bDVhVm0wWDE3MWRaK3JPZEJ4M3NtdWdqcGd6WkFGTVJXQ0dRUzBIejN1UmpQ?=
 =?utf-8?B?M0h6dzEzcFF2RjRHeXg3Q2NoaUVWTXFadE0rWk5EeDdybkRWa3NlS05kZUJE?=
 =?utf-8?B?WDU5OHRGNlZpVm9WOHgxUlBWVDVQeGJVYVdrRHNJeXdyLytxbFlNOCtYUWdD?=
 =?utf-8?B?VDdEbjlKazY1ZDByazE5TlVDeDRkejlRWVVyV2RaUTNWSmZ0d05sVEdBWW9m?=
 =?utf-8?B?bHVHVi9qQUlLbDJ2V2RqK0QyWmFzY3diZXQ3OWYrc1d0ZmZ3em93bXZXalB2?=
 =?utf-8?B?eEcxNXVndW5Tb25KQWYwSjRXTkt3cDZIVGF5MWZhaStPcGVhMDNKL2xnbGpv?=
 =?utf-8?B?bE5UaWt6d0dVOHE1TWJYT1dxRjVweWp3TFUwVmFWR3U1dWFsZWRJK0NETHJZ?=
 =?utf-8?B?M1ljWVR1M2V5cC84K1hQWnRLOVpnSWZZbUVNbUk0NVg0TTdVNzlTazIvZ1B6?=
 =?utf-8?B?V0p2d1d5djltR2FpQ0hvd3JjdEZrdXBoT3dYelBDcFJrcy9yL2lXV0RRUjJR?=
 =?utf-8?B?OVVMZGtPV1kvMitmVlR0V2s1eExhK0hCeXlWMHBUN0I1SXlHYy9mVjFSTytx?=
 =?utf-8?B?YVkzU0NSb0pxam5kemczTEcxMGJKQXB1ejU3UXVrT2lkMlZjVHlvdFdyZUVK?=
 =?utf-8?B?ZmdtMzhrTzNLNlFFamFMSGgzQzJFRzlONVJ0Q3lsT25vbTFyQ2Vrcno1ME5q?=
 =?utf-8?B?SHZKWmdkaExpNUNBNzUyNTNJSXpOTmJyVXcyVU9yWk1weHg1dldNNjY4YVFn?=
 =?utf-8?B?WER1eFhnNXZvbUtiL0pSaSsvTHN2bUd2NzRBb2RtYVo2UzRxOVV3KzRrUDRU?=
 =?utf-8?B?dGRGcE83QXBYT0hHQzBWb3R6TjBjVWZENW5VNFNHcmF2a1hVRzNHTmUxOXI1?=
 =?utf-8?B?NFp6MUErMmlIcy9BM2JtVThLNm5lSFFpTjcwZzl4S2pQdG5ud1ZCazdwaE5h?=
 =?utf-8?B?Wjd0cGtFSVF6NGRLZjQyZUFHUXZPcktBMXhSYm0xVUlMVlBvN3lXVUM1ajJ2?=
 =?utf-8?B?SzZvT2s5My9LU0NWRzhtWnlibkE2MXBmYm1EOTMwc2FkdUIvSWVPVjJ5cFZ5?=
 =?utf-8?B?UDZERktlclV2VWtMMVRpMzRNMHUvMFM3VnRLQ3RtQ25tZ3NMa3U2clBhTkxo?=
 =?utf-8?B?T21nYWg2U2owRDRmV0gxYnZWV1JCODhGa1VvSmZwY2FVUWxiSE10S0duaUg3?=
 =?utf-8?B?SzRBVE9GNmFscDNqeXBCcWhYYlNhbGs5aURoTkRmanl5aHh3R1ZUbEpHU1dQ?=
 =?utf-8?Q?jP0vMxwOvxsObfRFpk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae5ba20-815a-4ae6-357a-08deaa7ea1e5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:16:39.5313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVO+T/fd/s5rdK4Kz3vHEjfeJ5Ems6G69jwsuxSS0EeN6wpFe284jsXhGZ40v3Eh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214
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

On 5/5/26 10:04, Sunil Khatri wrote:
> Use drm_exec to take both locks i.e vm root bo and
> wptr_obj bo to access the mapping data properly.
> 
> This fixes the security issue of unmap the wptr_obj while
> a queue creation is in progress and passing other
> bo at same address.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 95 +++++++++-------------
>  1 file changed, 37 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 501e2e10b4a6..14db2124ff81 100644
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
> @@ -65,55 +37,62 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
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
> +	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 2);
> +	drm_exec_until_all_locked(&exec) {
> +		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(ret))
> +			goto fail_lock;
> +
> +		wptr_mapping = amdgpu_vm_bo_lookup_mapping(vm, wptr >> PAGE_SHIFT);
> +		if (!wptr_mapping) {
> +			ret = -EINVAL;
> +			goto fail_lock;
> +		}
>  
> -	ret = mes_userq_map_gtt_bo_to_gart(wptr_obj->obj);
> -	if (ret) {
> -		DRM_ERROR("Failed to map wptr bo to GART\n");
> -		return ret;
> +		obj = wptr_mapping->bo_va->base.bo;
> +		ret = drm_exec_lock_obj(&exec, &obj->tbo.base);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(ret))
> +			goto fail_lock;
>  	}
>  
> -	ret = amdgpu_bo_reserve(wptr_obj->obj, true);
> -	if (ret) {
> -		DRM_ERROR("Failed to reserve wptr bo\n");
> -		return ret;
> +	wptr_obj->obj = amdgpu_bo_ref(wptr_mapping->bo_va->base.bo);
> +	if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
> +		ret = -EINVAL;
> +		goto fail_map;
>  	}
>  
>  	/* TODO use eviction fence instead of pinning. */
>  	ret = amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
>  	if (ret) {
> -		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin wptr bo\n");
> -		goto unresv_bo;
> +		DRM_ERROR("Failed to pin wptr bo. ret %d\n", ret);
> +		goto fail_map;
> +	}
> +
> +	ret = amdgpu_ttm_alloc_gart(&wptr_obj->obj->tbo);
> +	if (ret) {
> +		DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
> +		goto fail_map;
>  	}
>  
>  	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
> -	amdgpu_bo_unreserve(wptr_obj->obj);
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

