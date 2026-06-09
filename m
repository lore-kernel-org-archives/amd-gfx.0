Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9095CCD8CAA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 11:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26E1210E269;
	Tue,  9 Jun 2026 11:03:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m1c6E8Xq";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013016.outbound.protection.outlook.com
 [40.93.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10CBB10E262
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 11:03:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URA/07R81FsLaHdzjvlR4wzd7vhEhMo0Wc3ulv21ODUa+YAM4mDYNpijcSI5pklne5sZvOuAs1z/cJf2prAe3dTpDbaOiIX9pp06a+VUGjRJxcPfhTO/o7CQZTIrO5UjFNu0oL+nXM3oyAkqNpSSynM4hRHbG2xh1YpiL5akRcUOK1clOwcRwU15abAgjmixnc8h5EEeLQckuliuxtgdcdg/DLwbBBVAathIWFpya3oYvaZqbkEBfJS4BYQMlDY2ufSFIb9YB9JEEuxwHQKJsCtDo4Du0QuRpHGPT3DkgewKK6EJeOdhRaLLPJ8aP5OkKiQqnb8aPDHrWrdmc0JV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLXUea/y6HLBKIDUE5Hzxf8uonid+oodBsEE6R1S7xQ=;
 b=yOMoyOOQN16vrbUb5nF1arN4NGVjKRaSKocMvYaQCha6Z1trKO7wYSn5UJpH8W5EoHfJsBwW12G7cFfKltqWhCqG9riamIaEIs63TsHFhUpO8We9rDmsIdaO5LkGrd/+t3is1XZRlt92Q0ATIwRbd91J0bLgpoRwf7oigtT56Ofgqo+8vazeF8wq6x0nz5Pu9zI0PQ4gVrvhAUtmsTzQo0lPY8KObjEq2rn+MWR39ejmciuHKS8Ktn5qFb5cWoV33S3W9v0eQxo1Um/ZzLCktNSTyHuYoK3UQ3hs3ecXpyX+v4Zs1tOf+2fCp3V70Xo73xSKs5IeikjgYZNlkTv57g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLXUea/y6HLBKIDUE5Hzxf8uonid+oodBsEE6R1S7xQ=;
 b=m1c6E8Xq1D6FsMJ8PAiRR7ROnRKEZd9F4NLn/RSNSNGdTIFovIPeZW7cPyD68PlEvTJKkttVnxxRXfgqewT7SUAr+hTooGwnpLfztiQ0RIyZL2vWhr1TwKckTV0oEcphk5bdfWyjyyrRT2pzq8vd1pSMCjU9TALTtT/2LLpqRJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA6PR12MB999202.namprd12.prod.outlook.com (2603:10b6:806:450::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Tue, 9 Jun 2026
 11:03:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 9 Jun 2026
 11:03:03 +0000
Message-ID: <df032b0e-f129-4ff4-8005-f3420269e330@amd.com>
Date: Tue, 9 Jun 2026 13:03:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] drm/amdgpu: include amdgpu_video_codecs.h only
 where needed
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander Deucher <alexander.deucher@amd.com>
References: <20260608194741.1590055-1-shahyan.soltani@amd.com>
 <20260608194741.1590055-12-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260608194741.1590055-12-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA6PR12MB999202:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dbb62aa-fb1b-4a8a-5520-08dec616ad78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|22082099003|18002099003|6133799003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: FWgkV2aVPF4P9V74VbMJRrqmHTJSscRnfgqmbcJKYDj7P80kUHoFonbZXtUYUdCyvBu8/PsOo8ctjOX8c8ZM0FvuJCetXWxIz4TpmkMOWRKEBwA0rgP5lx+AF/ZfwCY8Xtqmceq1wxlcOEMnLwSPzGvcqAo9wEZtq4TLPFDLyLVgrdUvFvg0dEpHMH8vOPLumfI3PVhTDzRvSTApzA2U/OA3Ghot17+KV36td0W+puIBXNa9cOSSkNiKyX7LZ2XjJxbb/Pct5+SwUFeNwH+6lfiUIq4koxh3frYl19OVlF/ddANo3oCQiQyfwlGtWA1goiy0WboXGfnmIMAnNJY8hJauEiMkA2dMPytZdmKw/SxSP+3FiRC+QVpd6NP4f+MPwhz3n1TKuyUZiTfbRpO/bL2VZCl/HQQiNkD1L0JIAD33bckP1zrEF0eQRHiHNw72qVrh8anbPKVwqDzMCNUKBw0sdTnUiw66s7VbRTxFCEkJNyhaDjTBVLUxAA7UmoZoDczZNbfMyKoNXJ5A+v+ahmVCDB079e4c57I357yfP+k6e1aORDQ4rBcaVKN3HHazPWl7cYThBOUvb4o7Tgxu/EMItGmNsN83xSgCsc+o7AQ1hpBhHHIjKlUL1T1m+0stxD88Fux0cOK4Dy0SOe8C7pVS9aFgDl+Xu/lQQTk1z4W4MfXwW5WNk76H/JuYkHC/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(22082099003)(18002099003)(6133799003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEFCTEZqdFdCZWxLZnUrZUduaStQMjBRdGxseDN4MytrYUpsM1A1VnExTDdB?=
 =?utf-8?B?L01uQTJqeXl5dkxQMTBBS3RBTC9lVHp3cXo2MzVuR2gyRlQyS2lrQll6S3or?=
 =?utf-8?B?VTdVUXpnS0lKNU8rUzlnZ01EOElEQ1ZNMmZwdEQ1ZDl1eW53MDkyeGdhWjQ4?=
 =?utf-8?B?VURuOHBKTEpoRm5LTG9UM0RpSFNCaG1XVUF0Z2RKR2lKTlczQm4xS3o4U28v?=
 =?utf-8?B?VXBGc2V2RUorNEFMeS9LMXRLSUpaT0NXb002VXN6ak9wWEVPODM0b3NoMTk4?=
 =?utf-8?B?TEoyditTT3h3OE1lZVlvMDRKeVNWZ3hsbmpWbGJiKzR5eS9xS1YxNFBGY2lV?=
 =?utf-8?B?cXg4SGVxajI0MEpCdWVxM0dYVDBwcjdmeUtWU0tvMnoxNlo5MzMwd2Y2clRS?=
 =?utf-8?B?NFNSS2hLMGR0Wm55K29WQ1BrTzFydVQ0RmNmR0hUOWpoTm1vWi9lMURab0o3?=
 =?utf-8?B?cjhJY3FpVDVRVndtWlJ5MlkvdkdUM1Z3K0hVNHpkWW8wdmdnNXd1cUsvQzBW?=
 =?utf-8?B?cy9TdVNXNHZSY1ducTdzakR6Y29aajlEaXpQU3poZkxUOFVFTkRWd2p0Z3Qw?=
 =?utf-8?B?ZS9YZVJzaVRMeXV3WHZFRE1PTisxY1RvdXdKcFhQbVovdW5RM3cyU05rOUpo?=
 =?utf-8?B?WUp5MGMwTlFOMUZPZitseUFib3pNVmQvcS9CYUlDYk1QRG92Y2Q3YkhsQlRE?=
 =?utf-8?B?c1pyQ2VBZEI1NDNTcjZDVUtlVzQ2bHZLQUdxWnpCSGFMOEoxMHcrS29uaWlU?=
 =?utf-8?B?eXNiQms4SEFRRjlaTnlNNkRNbG44TjNUeDhhUzg4RG5SejZ6a3d5eEF4dkZX?=
 =?utf-8?B?Tk1pRVpackJtdFJ5V0Z4emVBQU9SNlFiVThYYjNYU1gxeHFTZG8vc3RVMXhl?=
 =?utf-8?B?aHdWOEdRSm1UbFJYdnk3QXc3NHhZM0FEeUhKeU1HUDlmOG1iUGZ0V0RpQk5v?=
 =?utf-8?B?MS8vdUp2NDM2c2ljQ0cxbVVYSGhxRzB3c3dNei9iZ0RsbHBGampvSEJQODhV?=
 =?utf-8?B?YnVOSGo5ZWlNY0VReWczQ2tpZXF2ZjdUTnVJZmxVeDRuajg1TlJPa2tRMGRr?=
 =?utf-8?B?YzF2d1laL1lYN2JSZEhaVzBWN0ZkV2k5a0FRMVEra3FEKzUrYi8zNHViNlQ1?=
 =?utf-8?B?Sy9QTHNLT2xQYTFiWHBJamhZc3RYSVhKNC9KREMxUFdwYkJEY0JaWm1wTzlG?=
 =?utf-8?B?aFVBVndyODZpZGtZelkzdlBNWDFxNWErVFdNb0dhbHlxVnFsMkp0NkpyTGlH?=
 =?utf-8?B?NCtYYndIV3V3NEJGZHZwNStYVnFCMFRoWEprU1FDanZ2czZzTTNWV2c2eG9W?=
 =?utf-8?B?Nm96Zm5FZ1NxSEdxUWs2dFlZQmZlcmxYSUw1Y2VuQ0ZkYTY3QTB6d2dNSjBx?=
 =?utf-8?B?VlJTVTU3NU55MTgxY1NkSE5QL0xDeEFuL1F1Q0JUNVRoRTFwbVB2QjRnMWNT?=
 =?utf-8?B?UTRaQ29RWEdFVDJOaW56b3J6Yjl4YWhsSlpDQWRHVEhieWdHSEVxUjFGNlJy?=
 =?utf-8?B?cmNQRksxSWtEZjZsVmxHVVp0S3lGeXZhQ1diczZxSzlYSnR5ZzVwOU9yYzMx?=
 =?utf-8?B?M3RrNHU1MXFFTjJVVi9nbHJ0MVIzNTZaSWk0Y1hnV1FJRjYvaWd6Z1I5Tm5z?=
 =?utf-8?B?ZVlmSjdaVXhGcVcwTmNJMDNsWHhFOU1tdHRLOWVWTGVBSlhxbC9GTlNKaVZa?=
 =?utf-8?B?ZXEwVGJBVmZHa2dWNkF6SUEyZEhkSHZFeG8zQU85SlF0OUNxWVdoOEdHK1VT?=
 =?utf-8?B?K3NIUHVMYTJvNTdhT2JnbEVqakxMTytqQkw0SDZMTTU1a0wzVERIQVQ2Ykpk?=
 =?utf-8?B?UFo0b1FpK3FLMVorTGhkTUh6MzJhcFRxczFxV1ZZU0RheVVLZEtmK1M5UURq?=
 =?utf-8?B?Y3B5QlN3cXlnVHZTeXBLNS84a3hwOHg3TE56OG81VkVweDU0K1gzcFZxaklG?=
 =?utf-8?B?dDdLRkxua1dGUnBPbGJHUmYxZm5ZL04yVVZRL3ZKUVVRVThmQnBxank5NkM2?=
 =?utf-8?B?eklIWXd3ekJGeEJYSERDeWczMTVmSmpuL01la2F6TFdVRWFRUWxQSXNkTnc5?=
 =?utf-8?B?d0RIS1Jld1h5Mm1hc0JDRUxmNXV3Rmh2dnpkamFZa1BldzNQNkRmaW52QzdF?=
 =?utf-8?B?N0JpRWhUN1l2TUNMYnRpVkhVaUxLZncwSUxsUndGU2o3UWRFL3ROelZxMjgv?=
 =?utf-8?B?Sy9tRFExRFNjUHV4WU9OSXM0UG1BRWhnd2hwaGNxWHhNaVhWK1JLeklnUG5L?=
 =?utf-8?B?RktqVlp5RXRJcCtQd285TzZwRjZQWVN5T2UwblEwNjFhYlRQWmF6KzQwN2Ev?=
 =?utf-8?Q?eo5p14kKh3kj8ZtgVa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbb62aa-fb1b-4a8a-5520-08dec616ad78
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:03:03.6871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1w8B6xSaxeo+GOrPtDzEFgenKOL0CjszhC+O1oQq5Ze9lANeRH/A8N6ZAfwzmTY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR12MB999202
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
> Remove #include "amdgpu_video_codecs.h" from amdgpu.h and add forward declaration
> of struct amdgpu_video_codecs.
> 
> Add #include "amdgpu_video_codecs.h" into files amdgpu_kms.c, amdgpu_virt.c,
> cik.c, nv.c, si.c, soc15.c, soc21.c, soc24.c, soc_v1_0.c, and vi.c.
> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/cik.c         | 1 +
>  drivers/gpu/drm/amd/amdgpu/nv.c          | 1 +
>  drivers/gpu/drm/amd/amdgpu/si.c          | 1 +
>  drivers/gpu/drm/amd/amdgpu/soc15.c       | 1 +
>  drivers/gpu/drm/amd/amdgpu/soc21.c       | 1 +
>  drivers/gpu/drm/amd/amdgpu/soc24.c       | 1 +
>  drivers/gpu/drm/amd/amdgpu/soc_v1_0.c    | 1 +
>  drivers/gpu/drm/amd/amdgpu/vi.c          | 1 +
>  11 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a733ebb61300..fc1775ffa956 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -116,7 +116,6 @@
>  #include "amdgpu_ip.h"
>  #include "amdgpu_acpi.h"
>  #include "amdgpu_mqd.h"
> -#include "amdgpu_video_codecs.h"
>  #if defined(CONFIG_DRM_AMD_ISP)
>  #include "amdgpu_isp.h"
>  #endif
> @@ -329,6 +328,7 @@ struct amdgpu_reset_control;
>  struct amdgpu_coredump_info;
>  struct amdgpu_uid;
>  struct amdgpu_init_level;
> +struct amdgpu_video_codecs;
>  
>  enum amdgpu_cp_irq {
>  	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 24526e92f9b8..23b3034753d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -46,6 +46,7 @@
>  #include "amdgpu_reset.h"
>  #include "amd_pcie.h"
>  #include "amdgpu_userq.h"
> +#include "amdgpu_video_codecs.h"
>  
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index f8e58d12e39a..749de39e8e3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -34,6 +34,7 @@
>  #include "amdgpu_ras.h"
>  #include "amdgpu_reset.h"
>  #include "amdgpu_dpm.h"
> +#include "amdgpu_video_codecs.h"
>  #include "vi.h"
>  #include "soc15.h"
>  #include "nv.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
> index 29954c7d61b0..72d03a15d68b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -36,6 +36,7 @@
>  #include "cikd.h"
>  #include "atom.h"
>  #include "amd_pcie.h"
> +#include "amdgpu_video_codecs.h"
>  
>  #include "cik.h"
>  #include "gmc_v7_0.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 72edf5326b05..09bf861d2d17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -36,6 +36,7 @@
>  #include "amdgpu_psp.h"
>  #include "atom.h"
>  #include "amd_pcie.h"
> +#include "amdgpu_video_codecs.h"
>  
>  #include "gc/gc_10_1_0_offset.h"
>  #include "gc/gc_10_1_0_sh_mask.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index c26cb3e8bff6..e003fdfaeceb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -35,6 +35,7 @@
>  #include "amdgpu_vce.h"
>  #include "atom.h"
>  #include "amd_pcie.h"
> +#include "amdgpu_video_codecs.h"
>  
>  #include "si_dpm.h"
>  #include "sid.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 49b9d81cf8ca..3dbd684b8007 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -78,6 +78,7 @@
>  #include "amdgpu_ras.h"
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_init_level.h"
> +#include "amdgpu_video_codecs.h"
>  #include <uapi/linux/kfd_ioctl.h>
>  
>  #define mmMP0_MISC_CGTT_CTRL0                                                                   0x01b9
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 93c002e511c7..20dd530be3ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -33,6 +33,7 @@
>  #include "amdgpu_ucode.h"
>  #include "amdgpu_psp.h"
>  #include "amdgpu_smu.h"
> +#include "amdgpu_video_codecs.h"
>  #include "atom.h"
>  #include "amd_pcie.h"
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
> index 265db9331d0b..0f470aafcafd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -34,6 +34,7 @@
>  #include "amdgpu_smu.h"
>  #include "atom.h"
>  #include "amd_pcie.h"
> +#include "amdgpu_video_codecs.h"
>  
>  #include "gc/gc_12_0_0_offset.h"
>  #include "gc/gc_12_0_0_sh_mask.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> index 5f05c8e68297..db26ee4854ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> @@ -29,6 +29,7 @@
>  #include "gfxhub_v12_1.h"
>  #include "sdma_v7_1.h"
>  #include "gfx_v12_1.h"
> +#include "amdgpu_video_codecs.h"
>  
>  #include "gc/gc_12_1_0_offset.h"
>  #include "gc/gc_12_1_0_sh_mask.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index a256320b92f3..9c2c313ebc6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -34,6 +34,7 @@
>  #include "amdgpu_ucode.h"
>  #include "atom.h"
>  #include "amd_pcie.h"
> +#include "amdgpu_video_codecs.h"
>  
>  #include "gmc/gmc_8_1_d.h"
>  #include "gmc/gmc_8_1_sh_mask.h"

