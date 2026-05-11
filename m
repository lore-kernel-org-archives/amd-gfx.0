Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF07CD37BE
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 13:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 573C210E012;
	Mon, 11 May 2026 13:27:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DocmdQql";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011034.outbound.protection.outlook.com [52.101.52.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1038910E012
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 13:27:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrcJyiY6YA9HkG7m5IMwReaEH6O3xTZhfMNSEdLpyC+1yt3EL2NVysrGTLEGFMu6Cpsh+LF53RpptdbvdVEJrsSIL8sRsm4Pzh9BabsxdFu7D24ONxqMAivAQN7zGcJJsBp9s8LZJOZR4gwXWL8DlhpjVkfEEb1QVV/sY0UivluIVKE246P+I24gjOzUjHSP0dqnBJ883FJjcvqz1Z3JNewp89MuUh7fXIlmS9Haai4+NLuJRKC9QIEDTTSr5MCln6KuwaA0jqyDn7hi6gb8xVfoTAgtjjBPDt+dHGw4LmZ8puY/ebGzo72CdSNc1/NV8zVNrj2JasSJNi2dVRfDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIjG2c0J+xYMyecyKw0jHjDLAUV2qNuaMEPjeDWKHaA=;
 b=qq3+4w5dYUavmJmXrtoELQcCWXWERhGxjGoi3YtJ4sXt4bSErrJtwmh8GrvHzUZva2cMbbx6AKMhQWQhiJBcLausUIUUNWL7dzbsjxe09jLF8d5d0YzeT7NSAI3vv2230OIsxV6+gXcPA80oEsRGskUEPQJO/4EkJwWSryYjGtx9ww42aS70DwOc7uAP1wsiqrrHSZgsnGygNEPG2OYnNvZCsaCxNBtxZD1xUg11c7Ss8l/gTvdqgva9mzaoS5kSyWeamjUCfdXEvdhcIYV4X9Z6vQka3YChZpQ6LxtLiJm+bFhrVoGd/x5DHYm3xUJh38pSM8fvDHCSWRmF7Gcvyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIjG2c0J+xYMyecyKw0jHjDLAUV2qNuaMEPjeDWKHaA=;
 b=DocmdQqlDg1n3Qv9CLUk4yVCGMFW30tHtcNMgMHMbXU63wqGn9Btu3FKgkz0GLzmjcCT2klPLu8HaymdA9VYmNsRPP+gAO5k3Le4GA6HeDlo6fHJPoTz+UEf/8s1yt52IvkQeaabXCLIzTfzQVaZuRwLIoLZNxIo36L8iCxz6so=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 13:27:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 13:27:44 +0000
Message-ID: <450e8b51-4326-41a3-a504-d0dc630009d8@amd.com>
Date: Mon, 11 May 2026 15:27:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu/userq: pin mqd and fw object bo to
 avoid eviction
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260508103910.2442183-1-sunil.khatri@amd.com>
 <20260508103910.2442183-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260508103910.2442183-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:408:e5::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 563dff33-478b-4d25-2561-08deaf6115a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: ljGciFa9Ms+uMszXuq/JGKyd3Nm+TYxDDHe2ckHg89J7zYssnudYqcCvYWUhn1fPOqQ73VEeNkM3x2+JAV3mVyppeIUFF32v+HCGkRR6xrz03qmPh4XHi7Gm7YtS1NIKVHQhyUzejzkrwqrOs8ftu+jpibNuf6uVHzrNWYOfrGtODEAzbujavA3ZGsqzavVw3oQFMhDLikvLVIBvZSIa6DeGQ0LOE2+xy/Z7WQFMQ7g7cvNicR8J8uObQSXbXm2caLwSHmmaRZi+2snDAE7BSHGqYZ2ClSVFeqiN4jNEPxLaROe5DaFAdxY1YmvSXBg/aaHTcVbGvurSf1mXsFIPFmti4YMxhhvpA19KEYNB9byOeEnoEkp9FDMtZBvrlDnOf+RzCw83xG92CwRmHEgBgr5ctzd2hfMMnGTtqCSfyMRZb5drZIG2gs/mcwJqDlwcxPIgEmnbw8x73+V3cLUUe0/jHD7FAn/TZE5gMVheFeLsTC7MRI3wbEjc1dVUYv+KgBYlMB6lJwcje+SlSFsqjhYRrZAWnkxZQiUD2BltysW3eDQvJXrm0h+O5zCKNeUxYVbdhFxyLLXCM/wUcbOHLgrjQ0jMIVdaD+ES3LBHMAN/vkb+a1pz9EZK7DJJiOAKutIgVXUlmR2FVHQrChunkYDZxF0rEdSZ3tVQ/0Rkh14UFuskFDQlZUXeo4JhSbDt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Kzg4U3RvR3FQM3BmVE80WEVqWnh6VlpnSXNPSG4rRHVYZE4wcEo0ZnBhYWU2?=
 =?utf-8?B?RHgrcVVNUFl3RUhjbGhhTElDbGFnQnBhNS8vRkZYbVBCc2trR1VnWTdsbkFR?=
 =?utf-8?B?QTF6QnI5Z2tIMVhMZ2c3UDVQb0JQSDF5ZGw1Q0wvbnc2bVVrdEJrN3J1YWE4?=
 =?utf-8?B?RjJReGRpQU9GSEt4NEFGUDd1VWtsV3JIQi9zTU56WGRqaVhSUXhwUnFsbFIr?=
 =?utf-8?B?eGdiaS9peEdWOU9wWHoxVHN4Q1RPbXNlQXB4akRDZTdPZW9hU1p1bWFUeGtj?=
 =?utf-8?B?Z2cwdnlqQUhzT0lreGVFeUpsZlpUWVltSG96R1orSzI3M3BkVG55YlQzTmxi?=
 =?utf-8?B?L1Z2enV1cEJ5T01PS0RTdStwcjhadHVMLzkwRWZXR2FWZU9HS2l2bUdsMklk?=
 =?utf-8?B?dnNnSFU0cmhGdTBYcVovNTh1Z2locW5VQzdaaDd4QndkdDBvaG41aW9oLzBD?=
 =?utf-8?B?V0UzZ1dSeVloc0Jzb3hSbktkTEpPZDNHbms3L2JDZkV6ZEF5bHhieklPYU4v?=
 =?utf-8?B?M2owUjBWbWVKem1LcyszQWNiSEJlcENHb1V0UWd3cVNaZ1pxWWxWUy9WN2Vx?=
 =?utf-8?B?bE9GYytnQzlVbFBuNC91VFIzdDd3d0ZKTE1wOXVScEZwcjNUNDVPVG1oTlFx?=
 =?utf-8?B?ZFhBa1FYU3htSTZ3cHE4NS9DRG80NHZmUkxHa2U1NVU1UHJvSkJqczhMaXFp?=
 =?utf-8?B?SFcxSmJxNFZUL2lpWk9EWWc3UEdTZnVQRkFFdnBaWDgzZEM0YnFPejlqbWk4?=
 =?utf-8?B?TFNGSE9wY2g4U1hFVmEyRWVXTEd5MWJQZlAvT0JmTWlsTlNqT0x0cVNoL24z?=
 =?utf-8?B?ZE9UN1N2N3F5UWNRdlB5dDNpbmc3MVVSUGZEeGNRbkNtcGlvRk5oUWFkMEp0?=
 =?utf-8?B?dU5nT0s2eDluYUdENWtGaXUrNHAyams3SnlUcXFDU1ZZVU5palprYy90Vkpk?=
 =?utf-8?B?L21Ud2pGbFliYVBCNEFFT2o3QUpnSURJSHJWWndCUGF1em8xWTdiWnNzWms4?=
 =?utf-8?B?ZXNYVVNqOVhCbkNsRUFWMGROQkdrVmgvMEx0RnI4a3BSdFJJcWcxM2NVc3Uz?=
 =?utf-8?B?YmJSaHZuby9wNUYxSGhVS2svSGkxbUtxZGNkYzQ3UGQ0QnF2a3Y3VWRNaHUy?=
 =?utf-8?B?b1VUSTRnQmJWU0JsR1hFSTRvUDRhMXErVEJscSttRk5UOFZ4Z3MyL2wwSjdz?=
 =?utf-8?B?VklQQnVSSWIrWW1mVVBMTW1lenN3M01BdmpNN2w5NkF0N0xzbWdkaC8wN09t?=
 =?utf-8?B?QTkraG9JSTdOK0lTbU12eTR5NUZTd2svUmJzTUQ4aTJzK3ZlRStFWEkxWm13?=
 =?utf-8?B?QXFEVCtNOTVlckZzR0w0Q1FxQUJ3bEF5TjlqaFdteVE1U0lzYmF5L2JjMUF1?=
 =?utf-8?B?cmVibzhYbzNyWWp4VkhrL3hYS0xYWEFyV20zV09lenY3L0ZNYkV2bWk3c293?=
 =?utf-8?B?bjZrUnVaNVFnTnlUWDlBbTYwYW1Lb2Q3RXFGRGpFdDlOc2ROMzFUQnNSWTcv?=
 =?utf-8?B?b2ZmcXFqczJpQ0JvOUJZOE9RdmhqZnBUQlVFeENvbjljWGxObmNBK0RlamJP?=
 =?utf-8?B?L1NBY2VQMVQxU0ZlZW5ZU1k0Ymo5bGJoWjdkTlFDM09TbERSd3lRKzZRdG5I?=
 =?utf-8?B?Nk1pQ2V0Nzhoekt3c252QWdTUVp4RUpiaENuV2lXRmxGZXFzYkg1RFU1OUFj?=
 =?utf-8?B?MEtQdndPbGF0aWM1NHpmNUxGQ0tBZEZMQXZ6S0Z0aUtkNE1mR0JqMG5iVysz?=
 =?utf-8?B?RDJrNzJ4Mlp0ZGszZ2tpK0plaFdGS2VKWUpwQjFVT1NSeEFtb2lGV2lkSk8z?=
 =?utf-8?B?ZDJSNjlXV3BJc0VRcDliWVBYdmU4VUZWd2FkUllkTndma3VPS0J2enJ6ZEZr?=
 =?utf-8?B?OW9abHQvR1dtN0xvSE5vSk0zZXZ1bE8ybkV3Z0E5aUhoSkVMNHhCaXV3Zmpm?=
 =?utf-8?B?cnBnWjA2aDNadldUbFA5eUhKL1FZdmlSU0plb2lnSWdXeTM2KzhFeWJsWkxo?=
 =?utf-8?B?TWFIV1VSVmNlVkN5REk0OUQ4VzBGTC9WMVdLK0VUYWtMV2ptQ0V3emovSTha?=
 =?utf-8?B?QmRTNHZwdkZDS2lMWjJCWDF0b2wrODNvMnFoSkcxWmdoNS90N2lqQmZ3YjVi?=
 =?utf-8?B?d0VKTHB4UEVSemlzVS9DWHdCZmY2ODZ3SjBhUDloS0NyWWNnSFhlcWVDL3pC?=
 =?utf-8?B?a25WekN2ZkRFWGR3OTBiTzhNZk9QS2ozT09kWVlkVTFMMDYxZmFCVTQwWWZ3?=
 =?utf-8?B?ZTFUMEo5NEhkN0s3ZHlpaHU3SUhTOFBuaHMzUzdnOWZRVDNGWUxjbGNLZkhP?=
 =?utf-8?Q?sAYfTM7guriOjNr0ht?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563dff33-478b-4d25-2561-08deaf6115a2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 13:27:44.4961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGZ5d4EVaJMMy7D6pSc4i0bVlzSnug9OCKT8P21Ul6BRMul6/FgTguWuXye0bEQD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949
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

On 5/8/26 12:39, Sunil Khatri wrote:
> mqd and fw objects are queue core objects which should remain
> valid and never be unmapped and evicted for user queues to work
> properly.
> 
> During eviction if these buffers are evicted the hw continue to
> use the invalid addresses and caused page faults and system hung.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

We should probably use the eviction fence instead of pinning, but that can come in a later patch set.

Reviewed-by: Christian König <christian.koenig@amd.com> for now.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 06b7b4228065..813df2d87dc3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -504,16 +504,20 @@ int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
>  		goto free_obj;
>  	}
>  
> +	r = amdgpu_bo_pin(userq_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
> +	if (r)
> +		goto unresv;
> +
>  	r = amdgpu_ttm_alloc_gart(&(userq_obj->obj)->tbo);
>  	if (r) {
>  		drm_file_err(uq_mgr->file, "Failed to alloc GART for userqueue object (%d)", r);
> -		goto unresv;
> +		goto unpin_bo;
>  	}
>  
>  	r = amdgpu_bo_kmap(userq_obj->obj, &userq_obj->cpu_ptr);
>  	if (r) {
>  		drm_file_err(uq_mgr->file, "Failed to map BO for userqueue (%d)", r);
> -		goto unresv;
> +		goto unpin_bo;
>  	}
>  
>  	userq_obj->gpu_addr = amdgpu_bo_gpu_offset(userq_obj->obj);
> @@ -521,11 +525,13 @@ int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
>  	memset(userq_obj->cpu_ptr, 0, size);
>  	return 0;
>  
> +unpin_bo:
> +	amdgpu_bo_unpin(userq_obj->obj);
>  unresv:
>  	amdgpu_bo_unreserve(userq_obj->obj);
> -
>  free_obj:
>  	amdgpu_bo_unref(&userq_obj->obj);
> +
>  	return r;
>  }
>  
> @@ -533,6 +539,7 @@ void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
>  				 struct amdgpu_userq_obj *userq_obj)
>  {
>  	amdgpu_bo_kunmap(userq_obj->obj);
> +	amdgpu_bo_unpin(userq_obj->obj);
>  	amdgpu_bo_unref(&userq_obj->obj);
>  }
>  

