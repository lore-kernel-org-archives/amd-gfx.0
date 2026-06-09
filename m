Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03B8CD8CAA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 10:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 681DD10E23C;
	Tue,  9 Jun 2026 10:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uifwHcT2";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010042.outbound.protection.outlook.com [52.101.46.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C84010E23C
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 10:41:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kurG6Ib2FAh7NxloMTsnKlNxhlisFA4IGCalofU5GhwaPBWe2hoBD0bYpyjpMmc9CH1sj326alJvFvNojErTAmP0c3NOPGb65qQrRiYSIb3Zi4HImYiA7DKqwr03aP17zDAHusE32ZE4zMbT757zoHyEspPdLx2rV3KXr7eEeiZGeS++THvGLJwwZjmwTDPDNfEBoe/bJLxAo7xJnmwDzqp+HiJSY0HH0iRytsA5FSgE6dtLlSK3CFOMSO4ExYEaoqLkDPhah4FleZpT5YLxPedYUrJuKh19CsWVhFR0tkXFEm4r+jeFsm8Y+p5sonDwmxyeVVPU+n6bGVLmiOkp6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONGbylygMFaSx/sUpj123Nh1E5FraEfgD4Tnqlu8Bso=;
 b=JJYhklaGjjdPx/hNPx6jdccKBOd8RlR4WghCkvPC7F7UJV0Hge11OIDQrwTX9DIvVzG09Ao2YHHjAW4jRYnR1iL21erZWJw3cjBi6kNfIjahnzmXun8Tl+v7qHF/if1Z6B5ju4HlfATS5TfuYxQkXxATDK8bPVxSmDpeOqtDJdahW23P0S33BA4yCGtq0YtLWopurPVx3I3EJEAonCaNnt3iX4kgfVn0fj1I+KkfrD8bdY60Q8CY7ly2c6DpNF9PhiLyp7vJ3R+eA48NLe+Ym4ggLGw0JqaWlsx35WW/qfSfKPF2mVoXmAGyGVXPMuyiW89lC/bdIpcYeMCy4BtjLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONGbylygMFaSx/sUpj123Nh1E5FraEfgD4Tnqlu8Bso=;
 b=uifwHcT2FJZfxbVU6Eh91FFATrh6Y7AiiSoGZ88cLiNzkb2B9ijRdMJQ5k/rr/ZTLNd1ItKD7Dtj+CTWg1n56VQ6aXkzTK08zvFGjwveLMrpjMia/sxIBRFu8NYusIrc/LBjqeFUaeFXKzdxxKdM0Hi5cV2vbVVR/ca42/5ApJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 10:41:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 9 Jun 2026
 10:41:33 +0000
Message-ID: <6c5d13e2-b828-4694-8e75-2d2bd3e2844f@amd.com>
Date: Tue, 9 Jun 2026 12:41:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] drm/amdgpu: move struct amdgpu_wb and helpers
 into separate files
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander Deucher <alexander.deucher@amd.com>
References: <20260608194741.1590055-1-shahyan.soltani@amd.com>
 <20260608194741.1590055-3-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260608194741.1590055-3-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0184.namprd03.prod.outlook.com
 (2603:10b6:408:f9::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f01aa15-a2c9-4398-7192-08dec613ac84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|3023799007|18002099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: b/eCshH7Z5z/Ys3RDut6nDjrJEMFX7+bk19n4X487Cejkv/PuQA4spFvXE9rw9ofKI0SLDAeNp82bmI+DaSpkUsMfMN0ywYw9AHsit1NknxfoD4X734O/rO7xOOeLcTNm3sM4Lxk3UvfZCr8EQIhmJtYB/ykWuRfU1V1CRb3WJbarXyHjXtNjV4k/isZZ9v8MTB9/UlLIyBr5976Rn4Wmym4/d3m9ABPr+S+RwWD310PxBGFkDdsXf7wvKf1vSIgfRVviE1VfVdtN40hr5Q0zPkAv6wxmFdlvoJQMKEtDWQoiR5AYf+9Bs1Y/OT9+2ppPEI1x3EfL5DbNpgjDRG7xbEAQ/a8/h8EoU8E1Lf9x85spaMtA1rH1t94GbwTUv853V6AS1JY4aUorV4lzUKzoy0q4PiFezFJg3hSUO8i6cgqsPBE6dpGlfksdUWhAohT1k4d0KBKhiJblveTHNRkvUOTWQR8u9kLCj3r5uBpkHDDiekQMYRfn2KvmgGmTVjoDbZt+pHSLj/D19+/Pf7JEyHByzOhSVRKPSfPeyTLT5b3c+DGnHpgH15x6n7wRXG1xfXAcAHeuIHX5vpbBzkjQBzCdd0XUPJy1gvcxZSzbm3if8k1Kuopl03ZnpZ8DjYb9gUOWjN03nMJ2mkkkFZJXBqAHvCbskycQ3WpoNRSEi1HAWu7VoyZ1Rb6MKZUa7RU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(3023799007)(18002099003)(6133799003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmVlZTRlb09kN2t5amtPYUlmazlsRUdnYXlGTHhLQWlUWncrQVAzbTZVbExJ?=
 =?utf-8?B?dXowekNzZjJaMFkvaEFFQ1RPT2ZsTHh1MGtjSFJYeGE5VzRkNjNzL1YxZFQr?=
 =?utf-8?B?RldaQ1RpYUJ4Y0ZtVGhvaEYxTjAzajJSWGZ1OVhVZFdmT2dRempyNjVGSExy?=
 =?utf-8?B?blY1bU1obkJ2VnUxK0ZSbzdYelVUdHFwdmFwWWZ3SldHRnB6aGt1OW9MNUFV?=
 =?utf-8?B?cHIvVVB1RGdWWW1FRVBGZmxtOVNrM2RaRWxpOEpVRERWaVkzR2R2VkJ0dE1r?=
 =?utf-8?B?RjdVRWlnd0xHb2cxODJFUjF2TmlubjZvL29TTFpwYzM5Y2w4MUp3Qk1GbFRD?=
 =?utf-8?B?a2d2MWwzU0E1eVh0ZEtaRmIzeVVYdjZBdXNOTzhxKzV2R0pPeHJHT2M4bUtL?=
 =?utf-8?B?N3lMNFFrZHpqdnhFM2h6RmQvUFpCSlkycU1UMUFMcTNaODRjSlh5WTdkQ1ZB?=
 =?utf-8?B?UDUyd09FZVo0M1lxeVJyeEQ5R3FOQjNIdCtTZTN4azhCU1dWcklsd21Vc25y?=
 =?utf-8?B?L1ZvSGhPbzZPWkZsdnl1WG12SHdoOUFjNE5weE45MEtINWFTYm1CY0xqTE9t?=
 =?utf-8?B?bnJKYU5EWWVxVCsyaUlodEdVYUpucXMrTnlqUHgvMjNYRUJrOVgvL3o0T3ll?=
 =?utf-8?B?UnJyRWQybXBhbzJlZFBXZW9tbEdib2t1MUtPOUVqcE95NGZaN1FPYkhaR09v?=
 =?utf-8?B?Zm9uaE9MUnhUY2s2SEZxemt0K2lzSmF1T1h2UG1xNXVlWGRaaVEybHJrSERl?=
 =?utf-8?B?ajdqcnhIWU5OUk96T3h2QjFQKy9QNm90ZURVUFk4NUpvMytIeGhFdzl3NU4z?=
 =?utf-8?B?cWttUW9MdHRXSXF5YkdJUFh1UXE5ck5Vblo1UkdENURsZWJTZ1RsNVJLQndG?=
 =?utf-8?B?eWJWbmhwRFNYemVuVlBQaGhZbFVVNEhOZ2xqbUFpVGh5ODI0QTJCam1LYm5i?=
 =?utf-8?B?N1o4bCtoUWtIeHdkNEpuTkRTN0Z0alVlRlRTUENiVExOaTBoTVFPZ2txVkZj?=
 =?utf-8?B?Z05sUmF2M0x0cm1nSkFRMThJNk5LcHFqRkNtOHg3c29mOUdRTHZRaTRVdUda?=
 =?utf-8?B?K3hCSFdjVFFScjFhYUw1Q1ZZR0lENHJ2bWhLaGxkeC9hYStIWnZvdEZNVzdV?=
 =?utf-8?B?bTJmZFlJcC92aTB6VVYvbEdTSUYwS2Jhb201S0JPcGMvbjBmbFh1QU41cFJW?=
 =?utf-8?B?Z3ZhOWx6YW5vaGl2YnArS2V2dmdNd0F0SjVUYWRXajhVUTFRb1lMVGEzcWp0?=
 =?utf-8?B?YVc0U3VKMzBrZU1wM0FMQzNybFdkQXZaT2hrUHVvYzRuMXF2RXlUQ1U1bW9z?=
 =?utf-8?B?L0xyS1o3dmJuOUNvRzhZcmFvc3h3c0xnUGVLb0xITEUwL1dxcFZJVFEzeUFx?=
 =?utf-8?B?VGd6VW5QZnZmWGFsT09YbzlJd2FKVHdleHBaMjNZc2VwS08wbytsNGVwdkVM?=
 =?utf-8?B?d0w5SHdiRkVzUVhZVmEvU3RxYVhFZDhQUWQyNWxMUXQxKzRyM2pFQS9CbG1x?=
 =?utf-8?B?dlpLMVFTU2V3ZFRZNC9hREkzaGFOM0RJVDFzOVRCYld2S1pLUmNsTzhVVWhL?=
 =?utf-8?B?a0cyM2NjSmx5VnBPejVNTFVreXpDbUE4WEh2N1N3ZU15dEs1K2FTTVNXc3cx?=
 =?utf-8?B?dTBkTVA0eklybjd3a1JRbWc5cmpTNDBLc3N5VUdrNDd5S2JEUXhRZENkaUVD?=
 =?utf-8?B?M3krUThWNzlERDhrN1hrNC9IRlF6Zi9hdmozb2hWNWFwZzJORkZLQndib0VH?=
 =?utf-8?B?aTZrR3BWbW9uaXlxd3VBSzUzV0RIR1dnaU81RGFOamgwbVhvWUZyTC82M1gw?=
 =?utf-8?B?NFArQ0VDZ3FHbzV0MDlscTRiL3ZDZUI5Z3V0V01uUFdKbmVUM1JwZUxIVTJ5?=
 =?utf-8?B?WXFlNGZPcFJWUTBoa3JzZzB6dVpkU3c5RVVmWGI3L2taRTJrT25IVS9rOVEz?=
 =?utf-8?B?VUxhL3c1ZXRPTWdZTkNZcS9LNWR3QytZd0JFaUVURmswUXZvTkJzZmU3Y2VN?=
 =?utf-8?B?bnRhMHZIYXp6dk1PVlhxWHRMY3BzcXhzTlNVbVZUM29raHNuZHZlKzJFeDlr?=
 =?utf-8?B?dkpQaXBrNVhGYy9NeURnbUU4YWNzdFF6U0hSTnNoQzZZTmxaYUYweGpKTVFj?=
 =?utf-8?B?WUN0TXZEeklBVlJQTW9HNGVQWUhCSzRaVXRjMTNQY0NoNU5xK3FOQThqWlhR?=
 =?utf-8?B?ai9nb0FycVhqMHJOaHVZaEdvSjlUSmV5anE3d0tFTTg1bVpDdk1ndzMzZURk?=
 =?utf-8?B?NWI4MWZ0M2hQQ0V1aXF0eW5pYzBqZ0svUHBZczdyOEgrNjROemFXQ21ZNmZo?=
 =?utf-8?Q?UuB8vXJnI90Y+0VjWG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f01aa15-a2c9-4398-7192-08dec613ac84
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 10:41:33.5825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxpubHTB99iAViWcHRYyS3gfmXqzAnglWD3NxcqJZMeVg+57SKlYs2PFItgudqcU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273
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

On 6/8/26 21:47, Shahyan Soltani wrote:
> Move struct amdgpu_wb and helpers out of the monolithic header amdgpu.h
> into its own dedicated header amdgpu_wb.h.
> 
> Move functions amdgpu_device_wb_get() and amdgpu_device_wb_free out of
> amdgpu_device.c into new dedicated amdgpu_wb.c file.
> 
> Update amdgpu/Makefile to build amdgpu_wb.o.
> 
> This is part of the ongoing effort to reduce the size of amdgpu.h into
> their own respective separate headers.
> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile        |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  68 +-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  45 ----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c     |  69 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h     | 100 +++++++++++++++++++++
>  5 files changed, 172 insertions(+), 113 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index ee3574797bc2..e6deb24f73bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -71,7 +71,8 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
>  	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>  	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>  	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
> -	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
> +	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
> +	amdgpu_wb.o
>  
>  amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index d7d8664854fd..9a714b4b59bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -112,6 +112,7 @@
>  #include "amdgpu_userq.h"
>  #include "amdgpu_eviction_fence.h"
>  #include "amdgpu_sa.h"
> +#include "amdgpu_wb.h"
>  #include "amdgpu_ip.h"
>  #if defined(CONFIG_DRM_AMD_ISP)
>  #include "amdgpu_isp.h"
> @@ -429,73 +430,6 @@ struct amdgpu_fpriv {
>  
>  int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
>  
> -/*
> - * Writeback
> - */
> -#define AMDGPU_MAX_WB 1024	/* Reserve at most 1024 WB slots for amdgpu-owned rings. */
> -
> -/**
> - * struct amdgpu_wb - This struct is used for small GPU memory allocation.
> - *
> - * This struct is used to allocate a small amount of GPU memory that can be
> - * used to shadow certain states into the memory. This is especially useful for
> - * providing easy CPU access to some states without requiring register access
> - * (e.g., if some block is power gated, reading register may be problematic).
> - *
> - * Note: the term writeback was initially used because many of the amdgpu
> - * components had some level of writeback memory, and this struct initially
> - * described those components.
> - */
> -struct amdgpu_wb {
> -
> -	/**
> -	 * @wb_obj:
> -	 *
> -	 * Buffer Object used for the writeback memory.
> -	 */
> -	struct amdgpu_bo	*wb_obj;
> -
> -	/**
> -	 * @wb:
> -	 *
> -	 * Pointer to the first writeback slot. In terms of CPU address
> -	 * this value can be accessed directly by using the offset as an index.
> -	 * For the GPU address, it is necessary to use gpu_addr and the offset.
> -	 */
> -	uint32_t		*wb;
> -
> -	/**
> -	 * @gpu_addr:
> -	 *
> -	 * Writeback base address in the GPU.
> -	 */
> -	uint64_t		gpu_addr;
> -
> -	/**
> -	 * @num_wb:
> -	 *
> -	 * Number of writeback slots reserved for amdgpu.
> -	 */
> -	u32			num_wb;
> -
> -	/**
> -	 * @used:
> -	 *
> -	 * Track the writeback slot already used.
> -	 */
> -	unsigned long		used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_LONG)];
> -
> -	/**
> -	 * @lock:
> -	 *
> -	 * Protects read and write of the used field array.
> -	 */
> -	spinlock_t		lock;
> -};
> -
> -int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb);
> -void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb);
> -
>  /*
>   * Benchmarking
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5ff224163bab..15a6a9010fc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1058,51 +1058,6 @@ static int amdgpu_device_wb_init(struct amdgpu_device *adev)
>  	return 0;
>  }
>  
> -/**
> - * amdgpu_device_wb_get - Allocate a wb entry
> - *
> - * @adev: amdgpu_device pointer
> - * @wb: wb index
> - *
> - * Allocate a wb slot for use by the driver (all asics).
> - * Returns 0 on success or -EINVAL on failure.
> - */
> -int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb)
> -{
> -	unsigned long flags, offset;
> -
> -	spin_lock_irqsave(&adev->wb.lock, flags);
> -	offset = find_first_zero_bit(adev->wb.used, adev->wb.num_wb);
> -	if (offset < adev->wb.num_wb) {
> -		__set_bit(offset, adev->wb.used);
> -		spin_unlock_irqrestore(&adev->wb.lock, flags);
> -		*wb = offset << 3; /* convert to dw offset */
> -		return 0;
> -	} else {
> -		spin_unlock_irqrestore(&adev->wb.lock, flags);
> -		return -EINVAL;
> -	}
> -}
> -
> -/**
> - * amdgpu_device_wb_free - Free a wb entry
> - *
> - * @adev: amdgpu_device pointer
> - * @wb: wb index
> - *
> - * Free a wb slot allocated for use by the driver (all asics)
> - */
> -void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
> -{
> -	unsigned long flags;
> -
> -	wb >>= 3;
> -	spin_lock_irqsave(&adev->wb.lock, flags);
> -	if (wb < adev->wb.num_wb)
> -		__clear_bit(wb, adev->wb.used);
> -	spin_unlock_irqrestore(&adev->wb.lock, flags);
> -}
> -
>  /**
>   * amdgpu_device_resize_fb_bar - try to resize FB BAR
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c
> new file mode 100644
> index 000000000000..8e5f572077f3
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +#include "amdgpu.h"
> +#include "amdgpu_wb.h"
> +#include <linux/spinlock.h>
> +/**
> + * amdgpu_device_wb_get - Allocate a wb entry
> + *
> + * @adev: amdgpu_device pointer
> + * @wb: wb index
> + *
> + * Allocate a wb slot for use by the driver (all asics).
> + * Returns 0 on success or -EINVAL on failure.
> + */
> +int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb)

Drop the _device_ part from the function name now that this is a complete separate component.

You might also want to change the parameter from struct amdgpu_device to struct amdgpu_wb, not a must have but I think it would be cleaner.

Apart from those nit picks looks good to me.

Regards,
Christian.

> +{
> +	unsigned long flags, offset;
> +
> +	spin_lock_irqsave(&adev->wb.lock, flags);
> +	offset = find_first_zero_bit(adev->wb.used, adev->wb.num_wb);
> +	if (offset < adev->wb.num_wb) {
> +		__set_bit(offset, adev->wb.used);
> +		spin_unlock_irqrestore(&adev->wb.lock, flags);
> +		*wb = offset << 3; /* convert to dw offset */
> +		return 0;
> +	} else {
> +		spin_unlock_irqrestore(&adev->wb.lock, flags);
> +		return -EINVAL;
> +	}
> +}
> +
> +/**
> + * amdgpu_device_wb_free - Free a wb entry
> + *
> + * @adev: amdgpu_device pointer
> + * @wb: wb index
> + *
> + * Free a wb slot allocated for use by the driver (all asics)
> + */
> +void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
> +{
> +	unsigned long flags;
> +
> +	wb >>= 3;
> +	spin_lock_irqsave(&adev->wb.lock, flags);
> +	if (wb < adev->wb.num_wb)
> +		__clear_bit(wb, adev->wb.used);
> +	spin_unlock_irqrestore(&adev->wb.lock, flags);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h
> new file mode 100644
> index 000000000000..dac9fc3f0004
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h
> @@ -0,0 +1,100 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT
> + *
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +#ifndef __AMDGPU_WB_H__
> +#define __AMDGPU_WB_H__
> +
> +#include <linux/types.h>
> +#include <linux/spinlock_types.h>
> +#include <linux/math.h>
> +
> +/*
> + * Writeback
> + */
> +#define AMDGPU_MAX_WB 1024	/* Reserve at most 1024 WB slots for amdgpu-owned rings. */
> +
> +/**
> + * struct amdgpu_wb - This struct is used for small GPU memory allocation.
> + *
> + * This struct is used to allocate a small amount of GPU memory that can be
> + * used to shadow certain states into the memory. This is especially useful for
> + * providing easy CPU access to some states without requiring register access
> + * (e.g., if some block is power gated, reading register may be problematic).
> + *
> + * Note: the term writeback was initially used because many of the amdgpu
> + * components had some level of writeback memory, and this struct initially
> + * described those components.
> + */
> +
> +struct amdgpu_bo;
> +struct amdgpu_device;
> +
> +struct amdgpu_wb {
> +
> +	/**
> +	 * @wb_obj:
> +	 *
> +	 * Buffer Object used for the writeback memory.
> +	 */
> +	struct amdgpu_bo	*wb_obj;
> +
> +	/**
> +	 * @wb:
> +	 *
> +	 * Pointer to the first writeback slot. In terms of CPU address
> +	 * this value can be accessed directly by using the offset as an index.
> +	 * For the GPU address, it is necessary to use gpu_addr and the offset.
> +	 */
> +	uint32_t		*wb;
> +
> +	/**
> +	 * @gpu_addr:
> +	 *
> +	 * Writeback base address in the GPU.
> +	 */
> +	uint64_t		gpu_addr;
> +
> +	/**
> +	 * @num_wb:
> +	 *
> +	 * Number of writeback slots reserved for amdgpu.
> +	 */
> +	u32			num_wb;
> +
> +	/**
> +	 * @used:
> +	 *
> +	 * Track the writeback slot already used.
> +	 */
> +	unsigned long		used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_LONG)];
> +
> +	/**
> +	 * @lock:
> +	 *
> +	 * Protects read and write of the used field array.
> +	 */
> +	spinlock_t		lock;
> +};
> +
> +int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb);
> +void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb);
> +#endif

