Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA13C606A32A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3dgaxKZg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 433B110E896;
	Thu, 19 Nov 2026 13:48:03 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012035.outbound.protection.outlook.com
 [40.93.195.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC6C10E896
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 13:47:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZV32D0a/IIgh/GzRN2HEdQLgcEgEcTazEi1QR7MKgJIKbjwQ4q/3BpCck0qEMurlX+l+9zJjo2JHZL5CJY7Hl7UnmELz0P75297vXUk6cNNwuKAvvlZoSFTrBmx2YRwYSTtoi5ATN/T9PjE8ehDerBM57Gcq7addc0a8vOVNCwIh+RCN07MRhFN+V+vS1/asMuOC6prMVb6b9AKXCM9iJ5/mk58lUc18tqw94QTEnZCWHqEJDkDWVON7OjAF5GuzgJraXaHURUSZfJMaJ4paeobh5hKj4e4rHWbS6LlqKbp+UrZTOD1RPWUM18nByMt/5nP/x66Lib4AQTiyEEydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97Y6tQRvJ6/Pw4URPeH5JhYYoIQdzlr3QeW1e8xd/Gw=;
 b=QmKQf4jRazJ7metzdseiXbiDu5F/yPKNWTd/T1zXR3vK7/L7K64VieT7us3TR525Mp0LI6gFIcIgonnlqP+8n2oUOklbiTY0KDdytNw2nMg/uSNntzs1Tdkhef5Ch4QIDYclf7q1B4NcIw/XDRicU16bixF02M2AXQAv+WY7/7ixRwMAMQgMotf8G43VbQCWdKA+Ir+JS4J5uhmHwUF2BJXPWO5Lx/ZwErw6k4HyFpL9bMpFThfa1GDThke1E+012CLp2lnhk+11B4Y7DWwFyfNYeCk2xEbN3Kx8b1vJaqDw7FhpJXLwNeTglJZio0kZNreq93StmT/lTXij09sIMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97Y6tQRvJ6/Pw4URPeH5JhYYoIQdzlr3QeW1e8xd/Gw=;
 b=3dgaxKZgoueAKppcwYdLixJYCQMZY5k7/Yte24gqUbs4ZdpoUpNrO3QQSQG4mjjxrpPSy2KDANHg7u86yMCCesqIQ1Be+NFx8Z7LExuSIwhI9E5Iz/e1sDEmRrT7QnmnYjGw69Dsk6y1z4pe4E/S0hpcZK3zsvUKtsIX0AGaY1s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 13:47:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 13:47:53 +0000
Message-ID: <06a01e26-0126-472c-a80d-a93a0b92050e@amd.com>
Date: Thu, 19 Nov 2026 14:47:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] drm/amdgpu/object: get rid of amdgpu_bo_fence
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>
References: <20261118185225.1857845-1-benjamin.cheng@amd.com>
 <20261118185225.1857845-9-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261118185225.1857845-9-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: b6011349-ab34-4913-4b5b-08df4643b55f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|261026140227099003|4143699003|56012099006|11063799006|261021123027099003|261022105027099003|261028144727099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: ys9ecsvI2de5QAqmTSP20AvJpQZ25fscQgXy+pSg94/NDePRR1i0FbFw93bMIzQGtgLU8TEZ3araX1/Rryd3BO3+Qk9NCNr/zZHSsoojE7r0rbCw5Puq6BJVwgKCkMx7EJz+SeafZSkUv5H9KERdtdbXgeLfonJFD8vcV9am+LdRVRojo51PuuaMzXDNj2XSqSrVbz8XD8/g7G4VpO/SreJIbOuL/WucM+YL5QDQprEKZiJ6U4kDQ7TCtFvjtN+kt6fTLtXdvHRB8ryzX7UMfDPa3m+skn5/PwXcmIigYpTcyuAXLMRS1ekZErMsKx3pODHNS7u7bfcsj6mfQ4EwzdTKvnbcI9q/L8g3HtDeMufUoKmvEHGMozQvXWIrZsWYac48zXXnh/qca5uKxJudNJsVu03bsjyMelvjv3EYmiGNkcn0IWsnMEuWvFaWoTSVlkMC5eaQ10aAGuG44Bnq9Hmndm48fX2dlEdGDwyecOmGYzjEIFe3OPAiHSM/nXh/L7mKs70bNto2jjfyuZdWjYQYhMy9X4zmbgBxkio++szWh0Hj5WJrXVCLNi7ZzguWMm4mQ3NAtLPzWbIN5GSuNK+CSk7ksXkXH+qAunStnOpjPBg8Z+5tOU3he3Oq/tf5HtVwMsqLB/HrGDUbZGT95pee+bXRKgZ7th9zziNw8yM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(261026140227099003)(4143699003)(56012099006)(11063799006)(261021123027099003)(261022105027099003)(261028144727099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1hMeTlNRDNubTR2Z1BMK2tBL0I1c1VXcExwTXVoejhVM0pZWEFzNzJvNUpG?=
 =?utf-8?B?THYwcW5mYk5RSnJ1MHdyY2hWZnl0dldMSFRGWlgwUjdtVzF0dGFwTlF2Mlp4?=
 =?utf-8?B?MnhqQjBDQU8wbnVZZWxnclpZQ0dhUlZjdm51d0g4aWdxdFUwalVRYVBsb2pD?=
 =?utf-8?B?QjhsL01HUVlxMnk0U3FCM3Fnc1RmTjYzSzBOU0N6cmhMVWlPSVpUMlpneDhq?=
 =?utf-8?B?YjdpdE9XVnowZWZWSHVvZnNLOWNIWGttWW5laE51eXZJM2RXMHExQ2dmd0lH?=
 =?utf-8?B?TWFMNklQNHAxVFh6bzYxeWhYOHppNGU4UEFoL01tNUJmTnhRc3JZN3pzUHBp?=
 =?utf-8?B?M0RzUCtCRElSdi9nVytKbTltRXM3NHBYZjdyakV5YVVEUHVDVlZWa05vQS85?=
 =?utf-8?B?b1RkWi8wQzVYQkxUdjBtYXFFZ2hZOUorSllHK2VuZ0RkVis3NjUwUXFzMzhV?=
 =?utf-8?B?Z0Q1SXpJcWM5WC9JdGhnZmlHeEI0Q1NueUJWajNDZjBGd3owMXVJdkpRd2dj?=
 =?utf-8?B?WVBDYXZ1aU1QcE5NMWFWNThuL0drTEtDQlJnOE5ZWnhwd0FaQlByZjlyZExV?=
 =?utf-8?B?YUlOMEdPOFRmOWY3R2RXQWtneldEMEprUnFGanF5eVlLMXp1aVBtTG94MG16?=
 =?utf-8?B?eEhncUplckZKUG04ZTBLaFZGQU44MmlBaW02OEhKdnp4cUQweUhpcmZyY2w4?=
 =?utf-8?B?MnFVS3VQVFJXaWp1ZWE0SGJuRGF4eExpYTE0dVNOMVVqdTJqbW1SZFQ3V0RU?=
 =?utf-8?B?cS80ei9YeVEra2FPcVlLSzhBT2RwMkduQTdMMEJzVXpVc0hLYVRBSjdSMCtQ?=
 =?utf-8?B?RGI5ODNoWERlYks0VzRYcGFnQ1FJZVdMSVhrWkNkRXVad2NxUHp5U3BkNVRR?=
 =?utf-8?B?QXNHbVlVSU53S0ZlZ0pyd0FzTitKRC9VYWU2QW4xN3JwQzg2TUcwcVFGL3pD?=
 =?utf-8?B?MWhDVkh6anBMUWNOSEd3MVc0RTB5TWxQbFFlemJ3cTJIYSt2WU91bFB1VUVW?=
 =?utf-8?B?Y21aVGZwdmVCeHZ2em80RU0yWWRCdmFNNmNkcVZBcFRlMm9aWFFWREVRZ3hE?=
 =?utf-8?B?K2tYZDRZRk1vbVgzdDJGRVlBcW5TZW5Uc0gvdCtpZkk5SHdrUUVyallybjhl?=
 =?utf-8?B?dHhKbFdxS1ZqMXVydnI0Q1RPOTBKWUdkS3plbm5iQUEzWDhONS9ZRzRiREox?=
 =?utf-8?B?aG1LR1RRRmsxR3VXcldqTjlyRyttbCtyN0tjaUJEcFlWZXBKSGxxWmZwV1Bv?=
 =?utf-8?B?eTg2S2RrRDBGcDNjUE1ySW1PUXNlZWRXSXdoMTQ2WVY5cTl1ZU9SVitjRFB1?=
 =?utf-8?B?L2hJaEsvM0VPejFFMXlqandTUktvT3dac2pFOGtjSzdtblBBZUplNVV3Mmxq?=
 =?utf-8?B?WVNRTUVEWUtEaGlXKyt4NTVSYXptODRDTUIzdW5PZ1pYd29xaTM4eGxXcDF1?=
 =?utf-8?B?MlZRSy9HYUIxd005UFZMOFBOUVhJSHpDTXQ1dHpuOFltTVorbWhmZmRUa085?=
 =?utf-8?B?SE56dzZnZGtKTXVRUXdqbUowd0drc1d0L1JXWVlBMy9OSm9Fai9OYzAwYTg1?=
 =?utf-8?B?OVFlbTFDVlVWVnMwckE3VFBZZFViUG85R25CQmJmK3AvekVUcjFVekxxdDZz?=
 =?utf-8?B?TGoyaFhCczFlSHgwbE8vVHFVZDF0VThMQzVEY2RaTlJFZUJ2UWVwc1lzZ1Nx?=
 =?utf-8?B?bDhaSlZDVTZ6SlBrZHFCeE5VbmZlUWJXbnEyb1pDbVg5M3ZEN1FTaGJGWnpz?=
 =?utf-8?B?dEtJQ2ZrRytoV1NleWxGSDZSK1FHK3YzTGR0akZNVEIzWXJPdkV0b2xpY2V1?=
 =?utf-8?B?YlRxZzY4aVhUZ3lwZW9DOHZMdVc3bXYwUWRFaWFRdk1ONUpYSFgyRnJYTEtn?=
 =?utf-8?B?RXRtM3l5emdqRWV0YmxoU2RpMUw1cXE0MFphUHRaSEg1a3JmeVBGaXBYNlpw?=
 =?utf-8?B?MHpHUmd6UlpkUm9XQU5UWFBDdEErM1VwcmtEaUJxR1BlTlFPd2lRMXRnYnph?=
 =?utf-8?B?dnczbDk3TCtqSDQ4NGtlNk96SWNhSFJvcWhwUDB0TGtkMnI2aVVRUy9zT3RK?=
 =?utf-8?B?dC91ZTBnNzRURVBQb3lydzcvSGVWWDVFUlBDSkxxdDl5cnR4Wnk5MjlvOEt4?=
 =?utf-8?B?ZiswMXBnRmdibzVvQnN2TWtkMUJla29Wcm9Nb09KQmozdDRqcGRjZnhUeGEw?=
 =?utf-8?B?bHMrU1VsMlAzV1dyeCtQR0M0MC9nYTFsTFBkWmNSbVRpdktvc0dvemxJNHU0?=
 =?utf-8?B?bDl2QlNGU3JCYW5waURaZTMweUsrV3ZLcVd6ZGZVdk1SNEJJRzB1TmdoNlhy?=
 =?utf-8?Q?ltIZ+2uptHwOKx327b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6011349-ab34-4913-4b5b-08df4643b55f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 13:47:53.2207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2acKDyKAvNkxuLzIm7QXwnB7B+KtJBLM3ySrgR5yhBOrDY1LJisSseqD2cXZZph
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 19:52, Benjamin Cheng wrote:
> All uses of this function have been removed, so we can now get rid of
> this function.
> 
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 25 ----------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 --
>  2 files changed, 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index d4651f2d437c..ba9b5ed71cf7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1463,31 +1463,6 @@ vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo)
>  	return 0;
>  }
>  
> -/**
> - * amdgpu_bo_fence - add fence to buffer object
> - *
> - * @bo: buffer object in question
> - * @fence: fence to add
> - * @shared: true if fence should be added shared
> - *
> - */
> -void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
> -		     bool shared)
> -{
> -	struct dma_resv *resv = bo->tbo.base.resv;
> -	int r;
> -
> -	r = dma_resv_reserve_fences(resv, 1);
> -	if (r) {
> -		/* As last resort on OOM we block for the fence */
> -		dma_fence_wait(fence, false);
> -		return;
> -	}
> -
> -	dma_resv_add_fence(resv, fence, shared ? DMA_RESV_USAGE_READ :
> -			   DMA_RESV_USAGE_WRITE);
> -}
> -
>  /**
>   * amdgpu_bo_sync_wait_resv - Wait for BO reservation fences
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 8e67a8e60572..33a1bfce79e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -305,8 +305,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>  			   struct ttm_resource *new_mem);
>  void amdgpu_bo_release_notify(struct ttm_buffer_object *bo);
>  vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo);
> -void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
> -		     bool shared);
>  int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
>  			     enum amdgpu_sync_mode sync_mode, void *owner,
>  			     bool intr);

