Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A835ECD8CAA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 10:55:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4396410E258;
	Tue,  9 Jun 2026 10:55:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XQwHgxwi";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35DD710E256
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 10:55:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAWkmvT5A46IWttcJga0iH/svXLLzVq4y+AOrQu9+UbOq5BD8hfldrc7/WYDNlzkY9h9AIUPJxxrUyqzACA7deDY+NxH6yAMvjJeNXk3iHqd1AfeXGWUqfxHCCbqA0W0sbBEUJKG1Jr8wmkRYAe3NxQkdY35zxWBPIGVGJ5DhqAtanukT0lAKBQpmXutIfXoV5c+dGu8ebYXlIIb8VAQGm+dso5xAfrt8KgLIBIi8PL1GNl1klb4Pr09atDV2s/3qbggDlaU0IlcO56ya7NHGIKXd8UYZ4r8U931eEDXLe16Mb5uyi1jFCghaEoLR1FmBjRSqo5Gj4kyojGcB24iPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tB3gYTgCdO8gvo8PGjpSe2/4yCPqpvfXiCvwvcXqA4=;
 b=CT9iPJrFnqw3nIBQXRF9Texhe806biJsSBsDZRzeXoqL1JCBh6Rh0DV75+pPFoYHXrul3N4CF1aNjfMwQrRnA9dauAG5jGIP+x9UQo3WbhsMzzoFbLOnoL+GsdLZuWW+Vb5Fyx3Bx+suHQCg64cUWu/0tnR33jMjYkVOKKgZpiupxf5VNlPZxv4RY2sXBUFmEafVrKOVeRhCyBwm90aYhFqXnZvvsx/wD+/FEsJ3Ome6h68bUx1esvA8EqQL7t/MErBpjyiyvaowaQYFNTTRitEptqnLfmJ4uku7YPnpqt7l99iBUsJwZZsRDqupaHNPabV4beOSNG4NCDPj82rZsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tB3gYTgCdO8gvo8PGjpSe2/4yCPqpvfXiCvwvcXqA4=;
 b=XQwHgxwil8G/o4AzrA9RQTZY0uIKXjldhgegaewLCsW3hGSjnDlaOSOoeItkiBpW9Xafi7MxyHLLdqzLuhU3F29sa6dPZbmcPzaU3YIg1vZNDRR6tuw6xtf88qwQuw+MJcXlVCe3kWuCGms70cmuIiV6LIuEN9AdfZpiBGLrBWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8718.namprd12.prod.outlook.com (2603:10b6:a03:540::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 10:55:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 9 Jun 2026
 10:55:07 +0000
Message-ID: <d355f1c8-5ca1-41b5-8ba9-6c98417a4acb@amd.com>
Date: Tue, 9 Jun 2026 12:55:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] drm/amdgpu: move struct amdgpu_video_codecs and
 helpers into header file
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander Deucher <alexander.deucher@amd.com>
References: <20260608194741.1590055-1-shahyan.soltani@amd.com>
 <20260608194741.1590055-5-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260608194741.1590055-5-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:208:91::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ef0ca3-09e5-41f4-cef8-08dec61591a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|3023799007|11063799006|56012099006|4143699003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: t5LuOqjt285gTFqvV2RXoL+5XDuoYZ/g1LldpVz1FiZQaYZ5tI8shmsehFBvjrz80t7nOJcNgPBZhTGLYi+KzZoeNNPDR9Vjyl4zXhRfAahs439ydBbn4nEld7vnGdjYC0gTsnYbzLBTS/LMgkk/zFAH+fnX+XGeaI04EaF8sz+ylisEZj2zM21Fa1DcmROnf2CNV7/t+QRMmf4dXZtQV6xNZXzZU6eyM6w/KYqXQvSwv/dzGuUPongezKMxjJvef4RJ0erHBB5FF5FPMZpClogv03mICrlz3iQlv/4C2FdnDcidN/XmWLiyfJ1Bgz90NbsE2myxBLHo0DZTwaQmwBNOKwMpfITbwAF0ALSs33YqCTIJ7EQAXD97WTkgsjFNwPi9B1pxbMrxvVBJGzQV4oH6LQ+Dzq2SkWDCQD+uDgxzKLqn57WoG22Kdg1R8altgt2Cz80JUX+htG7iGQvliglvhLjYDMONJSX9kU1f06t+hzb6fYdp32nBXboYpQuQ6r4v+5y0erF7/mUoQjrke1eNm4fBhx9I9xG6S2pggRfEZ+sLrSNZZ7fMZc+2jzZ5bx86P+aIdF3iKtWI5OtejzOg2e371og4Ed9TxvcLSHPFGaE8Y9jfoSyNcA5JtQr78Uzd8YwID+Gf1po7uuRACJEBv2S08DEH7UbnpPflnkYisRd3yhV76plKUjoNnDvO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(3023799007)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXhseXZsRmVMeXRnRk1IOUNuY3NwVkdzR2pod296ZDdDWGFnZDdlVnhwbDl2?=
 =?utf-8?B?SzB1QlE0Z2g3QkFFVlJyNDNsdFl6Qks3Z2tZeGZRdVZYUnJPQjlhYUpPcWJQ?=
 =?utf-8?B?RWRwdUZrRlhsU1dRbHc0Yk1ySTZOSmJBZG1xM1JnQTZQdjJhSllBdE1NWWZk?=
 =?utf-8?B?QktiaFA0ZFVWN1ZvYi8xNHFPNWh2OGhnY3NOY2FyK21LWjhOdnRSN0poVUFR?=
 =?utf-8?B?aEcrRW5lUkMzalRDajVSQU5uOWQzRjlpaXp0K21ZQzljTVlTL3NxdzBzTThm?=
 =?utf-8?B?SHNLaENBcE9FYXFIaXl1SG1CRC9CYlJxYXh4azhrTFRIQjVOVjdDZEduSEty?=
 =?utf-8?B?S24yQ1V5ck1odjhKa3ZnT3hxY3NDNUdXR0pCbFQzTktmWTB5eEloTVdVUmoz?=
 =?utf-8?B?ODMrbDVBR0w5RVlFSCs2Ylptc1pDMk44c1QxK2ZBQVBpa1lBMFhuQ3dBTFdj?=
 =?utf-8?B?U1ZIRjVwU2dDQ2RpQmxPUWNueXkyQTJwZkdhdCtndHdXVE14N2t6WE5YbEZ0?=
 =?utf-8?B?VHdFYzBRcTl0Y1Y5UW1jR1U1UWpmNVBtZTRRZG1sRll1TUo5U2M0K0Z2TkRX?=
 =?utf-8?B?c2JQVWp6TVlNM3ViTFFXaWJmNGFMRDQ4NDVOclJ3WGp0ejYwanhQMmNYZXl5?=
 =?utf-8?B?QnhXUVk3aWx5c0pzYTJqR2FSUFZNVVJvRzRzM2JUSnhZbmVRSDgyS0FWT0hL?=
 =?utf-8?B?aWs2eHY0NHAyRi9wQkJyNkZVVStMRVJDUVVQY0dUOGVBU3Y3VHVHZUgrU0VJ?=
 =?utf-8?B?WENXU0xwTlVpR2M1azVRQzRRL1pONUYyeWVaK2dyK20ydml5dk1OSXJFOFA2?=
 =?utf-8?B?aTU3Y3ZiMGpZN2laYThYbG5UYkx2bjMydFk4aVpWRWpYK1J0YzNGSmQwa0Jr?=
 =?utf-8?B?TnBiT3d1b1Z3YW5VM1lTZzd6eXZjaGlRTC95MXhlSnFMdDhTUDZDaWV2Uk9R?=
 =?utf-8?B?Y1laQjZzNFh2U0xzWEp0WEpqWnhQdk1pVWlqdnlZNXlWNjhBSUtxV2t2ejFK?=
 =?utf-8?B?eHYwSVN6T2JlK1d5dUJnOUVONmc5anJXaVlObWhITldOMFhSUTZsSHgybUUv?=
 =?utf-8?B?czk2elBpeS9jN2Vtb0h0czFDQklPU2RkSmVUVXg3UG1yakpsakJKOGVOZWJM?=
 =?utf-8?B?ZElEMVc3cXdVeStNdW91cFIrbFR5Y1pRMDNGSjdwbXQ4TTQvdENFUU1tT056?=
 =?utf-8?B?d3JGSXRQaHpJSERGTmJ6SVl4WmlLb1ZXVFVHYUQzRkhTUUw1Qkx3REhmbXVE?=
 =?utf-8?B?MFZzUytGQjgxOHhGeFpWaEdkOUxGeDJNOWZnMm1GRXdxcHBUaDhqYktXTlZw?=
 =?utf-8?B?N01mb1Y3eFhvRS9BeVVFZGdEa1FZdnczQlYzZWlxMVo4ZzBhSHVCZmd6ZERz?=
 =?utf-8?B?MVcrcWJqUFN6WTQ5Vk9OVUt0amZ0SHFhSU01T3JhUlZJdGgydjdITWxHcWtY?=
 =?utf-8?B?Y3UxU1ZyWHBMRElBYXVldkdrb3R6ODIrUkIxWHNRVGg5cUZNZHk0QzlCVklH?=
 =?utf-8?B?bmR2dWx4RERNUm44a1ZSbnJHYVlUUDdCZzIwd2h6dmFhWkxaWXB2bnVzVXBx?=
 =?utf-8?B?b3hXQSs3VC9yRVNqVjA2OW1tYlU0aHpoWFEvSU9UaDEzems5N2xORTRUN2RD?=
 =?utf-8?B?RzZlRXZ1cWJ1dFo4bFdTTVpJdWNOOEF6L1R0WmVZZVc0eDNVdERhQVdrQ3cy?=
 =?utf-8?B?bzZ5YWo3WldNd3MyK0swYm9sQWZ2QWV5aFR3YnowRWpwSXBnRUIyODRQVlB6?=
 =?utf-8?B?c0hlVEFFZ3ZFeE9acjFqajlIZFBLQytKZHVmckJINW1sWGVVWnBoZHg2M1FL?=
 =?utf-8?B?Wjk2Z3ZvRkF4ZkxDRFhGRE91QjBWZkkxNGR5T0xkNjcrZTZQRmZaUURwWFFz?=
 =?utf-8?B?MWQrU3pXRTB5aVNnZlBMblNZK1R0UEdnMnk3eTJWSFFQUlQ0UG1Pd2xtMCtU?=
 =?utf-8?B?dUVYYWRtMTl4aWZDS2VPVkZZd1U0di9QbTZONW9NaWZ1TjE5b1lKWXBaend6?=
 =?utf-8?B?QkIzOEZEVVNEUXo0NXBvMlVQaGVzM3J3RG14SXl0WlZDamRuNDRzTXMzQndU?=
 =?utf-8?B?Tk9CWnNSTnh3bWdTS1ZrZ0FTbDFHeFBOYlBTVVRHY0swTVRrV1RFbksyaHZ3?=
 =?utf-8?B?c2lwYXBoeHp2ZlFvaVJWTWw4aEQvd3UxdnpkR3FiODZkdXBlZWo1Vldoa09p?=
 =?utf-8?B?THhoM1VDRDhwRDFxdEdMOVNTbjZCVFNLRXBrV2JaOWhIUm5uMlRtaUNlcjI4?=
 =?utf-8?B?SHpCb2d4cVpkUlhaeS94SE0vWVAxcTdJdVlsYkhUaC9XQ0EzeVhiM0RNV2g1?=
 =?utf-8?Q?jsGxincRPbkVmVzXuo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ef0ca3-09e5-41f4-cef8-08dec61591a7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 10:55:07.5847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2JjxrulhFjpHyt1JAEGj1tF4Za1Gjqo2vTUUH/NZDcHkUcpe66mvn77YK52JCtq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8718
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
> Move struct amdgpu_video_codec_info, struct amdgpu_video_codecs, and helpers into a new
> amdgpu_video_codecs.h file.
> 
> This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
> separate headers.
> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 21 +--------
>  .../gpu/drm/amd/amdgpu/amdgpu_video_codecs.h  | 47 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 20 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_video_codecs.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 0f8743254fe6..8fb70731ea58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -115,6 +115,7 @@
>  #include "amdgpu_wb.h"
>  #include "amdgpu_ip.h"
>  #include "amdgpu_uid.h"
> +#include "amdgpu_video_codecs.h"
>  #if defined(CONFIG_DRM_AMD_ISP)
>  #include "amdgpu_isp.h"
>  #endif
> @@ -444,26 +445,6 @@ struct amdgpu_allowed_register_entry {
>  	bool grbm_indexed;
>  };
>  
> -struct amdgpu_video_codec_info {
> -	u32 codec_type;
> -	u32 max_width;
> -	u32 max_height;
> -	u32 max_pixels_per_frame;
> -	u32 max_level;
> -};
> -
> -#define codec_info_build(type, width, height, level) \
> -			 .codec_type = type,\
> -			 .max_width = width,\
> -			 .max_height = height,\
> -			 .max_pixels_per_frame = height * width,\
> -			 .max_level = level,
> -
> -struct amdgpu_video_codecs {
> -	const u32 codec_count;
> -	const struct amdgpu_video_codec_info *codec_array;
> -};
> -
>  /*
>   * ASIC specific functions.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_video_codecs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_video_codecs.h
> new file mode 100644
> index 000000000000..3b2a6cb8632d
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_video_codecs.h
> @@ -0,0 +1,47 @@
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
> +#ifndef __AMDGPU_VIDEO_CODECS_H__
> +#define __AMDGPU_VIDEO_CODECS_H__
> +
> +#include <linux/types.h>
> +
> +#define codec_info_build(type, width, height, level) \
> +			 .codec_type = type,\
> +			 .max_width = width,\
> +			 .max_height = height,\
> +			 .max_pixels_per_frame = height * width,\
> +			 .max_level = level,
> +
> +struct amdgpu_video_codec_info {
> +	u32 codec_type;
> +	u32 max_width;
> +	u32 max_height;
> +	u32 max_pixels_per_frame;
> +	u32 max_level;
> +};
> +
> +struct amdgpu_video_codecs {
> +	const u32 codec_count;
> +	const struct amdgpu_video_codec_info *codec_array;
> +};
> +#endif

