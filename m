Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5880ACD8CA8
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 10:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC4F510E257;
	Tue,  9 Jun 2026 10:59:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yhUf64za";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2155A10E257
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 10:59:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M44FCvaNS7C2TjtV+kOGWyMm9f8B0fMp59Ix+U1w1Bj8vi4jBUj3lvEEgG4U4sUGjUQegq49Bhep0ECP3INgk6duCw4ixUgbfV0Aa2bprq8tM29rIQbpW2prKWqevzuHNNcLUBPW33yNbHcHkobHKHryZJsiC5wNni0TZPuW0IKpxVwh7dWXB90TJ4/qy2Qig3tw8GPVry7NwzNnM0vLtgevuAfBfKLj7FoHAp4xISaNeNCrTiXXVwfPAU69osaEYkB4a8Smf/oEa4ytxx+Gzx+AlI95PvOo2m03JJ8Ji04voKVtIoEBWvDTpxMqJGTs3jivAfZXo1N+QTGJApeSBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehv0JXwrvqXzT16crnoEgfrQh7/GSbEeHTC/nQyJXMs=;
 b=xvkucN6m6QzVQ6OyTrFpinK6WybGb1LMbsiwzzXe2fXelioinW9SqA6YxuIstHAWbVAc8+a/8CDSx8VlEOytGszzZzPiQEyVNK8XKvlajFIBKSblma4Os3B1JpfP1NL1JwTonsJEQyOT8+UikMkfwvhSmYd6WnokqvOvm5PRB7EO7+dwi1RoTG55vVSp87DKXJb+lV50HVRQmoUICVPnU96y/hkrDqc2xgUdsYHRDSEw45y9taS72EF2OHMqxsIRxqbWaaGTq+pshLCs5xWus2AovqLTwuuK/7drhHj2mlh9JCjG0wGpDgTkwChMIQr/7/iR2eTEnUy8jbnTOBaiGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehv0JXwrvqXzT16crnoEgfrQh7/GSbEeHTC/nQyJXMs=;
 b=yhUf64zaQGjVEtSOMoSIXFklkRb8W+yWDNhRgDhYUBN5t7XbXmiyATWCpw/QFczK4O7lgEqWE9HtHcXGsRbXJCSy/BPLUiegs/36wn+nAQqk32TCCMbT2JSuPDNdtBpRlTPab1vkZxbbrBytmCML61WV5X71lFL2oiI2pAz0pu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA6PR12MB999202.namprd12.prod.outlook.com (2603:10b6:806:450::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Tue, 9 Jun 2026
 10:59:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 9 Jun 2026
 10:59:24 +0000
Message-ID: <b3915e50-3470-4ea9-90bc-98524812e5e2@amd.com>
Date: Tue, 9 Jun 2026 12:59:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] drm/amdgpu: move struct amdgpu_init_level and
 helpers into header file
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander Deucher <alexander.deucher@amd.com>
References: <20260608194741.1590055-1-shahyan.soltani@amd.com>
 <20260608194741.1590055-7-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260608194741.1590055-7-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:208:32f::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA6PR12MB999202:EE_
X-MS-Office365-Filtering-Correlation-Id: 49248fd5-a2de-4dbc-1ce2-08dec6162ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|22082099003|18002099003|6133799003|3023799007|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: fJUIOAg08oZh7yv0xfE3yZGxJJtL0RBitNiF+kp52bKcBA8O4ynepOwwgv71Y4qx33+kh7VQpaV22yNr9BQpsEh5cC2882GbLz12E59Hd39wWcSQ9OCvAv85bE33UF34MMJwK98hbzpIHa0MnIsInaqkYmfzr4fEHiLys7YARFZKoc3klJBBvC0EQdi7AfETokH855Ybnr1fgBM8MLOpCP5be00I06McewYiw6H/ttNy0xRM5fFBehrRWaEbq9H6jdKpMN4Rzs4jzmAwblr0N76pyszKXurfvsgKg3JPSqswzl+/7xWXhCDGtkkhCiI4C5cqXjA2/D9q6qZ2R7A0nae25+zNq8II5gqzFId6xptLiXv1AbgV/9WTzFMa5ry/BYRT6bovjknItL1iyl5hPR6A0hW+QmMXrp19uZBoUg/V5Qktr4W5OHw+Hap3WGP5VM66rl2cv2nFbdfMkJEQWwHB+uFTHuzUFKJW5iTgjnX/6dHUwjhBe9KPdnIClUg6ZOUMqBFjzUAWDBtTH3U5RjHaNNy5XTAUOsH5orGDQ5sitL0lWfil65n3pMVk9TQX/VFrG2n8JzsVQIqkzks//wzgeaf7Xc/sNg2UrSQK/67Ox6jg8dNpAEkl/NEzbcHnrljPuxjs6DpmGdO0LxegGtm1KjRJWbhHiUWeMRosYTXDI9DrGzBXJu1KlnBguD8L
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(22082099003)(18002099003)(6133799003)(3023799007)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mkk5bVMyV0s1eE9mRFNWelh0MWlnUWdCSElpTVUrSWpYK1ZCSWtROVRLanc2?=
 =?utf-8?B?YTR1OU5TWW1WelY1VHJlMjREdjVjblp6Y29QZnFaTVZLZXArcHg2ZURYZEVr?=
 =?utf-8?B?SXkvM3pWTlUyN1R4UWxaa3JmQUNjU1BVSVBHSEhDTEVDVVdoalVBR1YxMGY0?=
 =?utf-8?B?ak51Z201RlcyLzdnN2dOZWJ2N2JJcmt2QWtyVEwvcEJDZ28yWFM1YVI5dDMv?=
 =?utf-8?B?MFYrWkNoWStTTlIvVUxqdFhISlRtSld3TXVFNVU4WW9BeUNCazR5RmQralN5?=
 =?utf-8?B?eXg3L1FpZzVNeVVobWtZUDE2dHdRRFZZVk9LS0hOS3NkTEtBaDhJT1NUVGYy?=
 =?utf-8?B?dTAxRjl5bUFrTzB0MUh3YlowR2ovZ1ozcHVZeHJnWmFKMFB6UFJDbVNxUzYx?=
 =?utf-8?B?NnEydWVwSnUxV3JPMGN1dkJwR0JjVjY0UHl1dnV6aXZRejU3ZFVpT1B1S0JE?=
 =?utf-8?B?WW1KY0hEN2g3UmozbFdRa0p2MWswcnR6ZnpLcGpEMnp0b3dUMWE1QUlMNWhO?=
 =?utf-8?B?dW5rYUFTTzd4V0h0ajJGZFZqOTRZNEZ0TDRxTlpPY1lSR2RKdGp3N1ZzWjlp?=
 =?utf-8?B?QnZXcTBLa3ZBNnlaaHRNUGRabXJ2SVFXM0xGblFPZVRpL1pvYUc4eCtBWlNo?=
 =?utf-8?B?VllDcWFFa0RsV2pIeFpUMDRhdkNkTk1OQ2F4bVh1Ti8xdzRQSXpPSzFDaVVi?=
 =?utf-8?B?d0lVRmNKMXZ3VXhGWkZxNmNUcCtyQ1plT3RJVDJHS0pXVGNTOVJrRHpoZWNr?=
 =?utf-8?B?VnBiTTdJOG1sWGxsRFVDenF0UlRMRTF2cFc4NTNvd1FDTVhFQzgzZy9JbzQv?=
 =?utf-8?B?RXhKbXFOTHRFU3BQUEtVaFR5MGIvamVIOHZvK1hESUozTzNCNFcxWGtwM056?=
 =?utf-8?B?Qlk3T3dsSHRqK3FBUnkreEw3WENRU2NCcGNKUGd4SnlBR3hOdmgzZlYrR0tO?=
 =?utf-8?B?R0F5TU5pN1Q5UW45d0xCMVozOUhCdWkvWEJqTi9OdWhuc3JuSzRHTHArdVJi?=
 =?utf-8?B?WTJkUmF2OUVKazhkNTlSMldsRmJ4VFRpTG1uelRLU3BtK2FrWEtacURSa1J4?=
 =?utf-8?B?aVJqb2xBQVRjRHBmTnJwQVZaZkYrck1YcHJUMk0xY0NzMkQxWEttR2hHV0tw?=
 =?utf-8?B?MjdnRStCdVpiZVQ2Q1pOM3BacUJ2eTIyMGR4VkhZVHhKTFZjOGMwOWlML1BI?=
 =?utf-8?B?T0R6WUpLTTlzQ3BvZjJLWnFMcDJhSXBPSlp5cnV0MzJDOHFsZERDRFdHUHFo?=
 =?utf-8?B?bWd0QTB3ZisyQ1l3ZGs0WXdRblJtaG9vajBFWjBZdFhMTk5lMGRsZFFDQ011?=
 =?utf-8?B?Zms4Uk1aaDFKU01XREE2eGxnYmhFZHBTeVdtSkpENmMwcHNER2w0ZDgrT0xJ?=
 =?utf-8?B?RFhEMjlSUWVGdmNaUzNqcVJMbVNJeUxiRXJyNy8yTlRMMStiU3pFcUpSbnhB?=
 =?utf-8?B?UXZ5cnhKeE9MRDJFRXZNYU5ZN1dSckZRQUVrWERleGpwdHZHWTYzNXNvWnlx?=
 =?utf-8?B?QXR3Q3IwSUFvdFZEdVFYaGtuQ1dXOS81ZTVzRWxHd3JudHh5dkIyQVE0d1Uv?=
 =?utf-8?B?TG56VGVWbnNaZkNrVG5lUkRGeHFHYW9CQlhWZ3drdDA4bXRFbW4xamVINjhT?=
 =?utf-8?B?cEJlbHhMU0dGdHBqeDNUZi9HSFF0aHE3SkdxR3F3RXoyYS9Cc1d2bFlHRXFQ?=
 =?utf-8?B?TDJpYnhoK21pcEZ4dlRyTVlKUmpIZmE2K21YQmR1Wi9PVW9kbUpXcWJieExj?=
 =?utf-8?B?QU1JY3VCM1RxWmdWTGdzR0l0RDZkRHhhb2lqd21hKy83VnE3eXhXUmJzWEFh?=
 =?utf-8?B?STB1dzdqM0lrbGRla2VoZjlBbG9Zc2Ziai9iTnBXaXU5QVBtbEd4ZW1KclZL?=
 =?utf-8?B?QWdGZnllRmNybVU4b1RvUDVlZjVieFY4OHJ4ZTM3eHlha2xmb24weFBjM3Nx?=
 =?utf-8?B?Z0hFdkJUcUF0bWNCVnBYY2tLV28yTWhkN0cyMFZWYUVLZS81Vi8zMEdDRlNi?=
 =?utf-8?B?Z2hlODk1SjZSYlpzQkJpSEZpWU8rMzI1c29yUG9jWWpDcTVQbkJKMWxxa0NP?=
 =?utf-8?B?UkpRNzdwbDhBdC9DNVd5TmZMYTk0R1E5Ym82WmV6TVBMcVlFRXdmVU1kVGxn?=
 =?utf-8?B?bUk2VVhkQTdFL0RpblpDbWYvY3BNTmJDWVRrbFA5ajZvaXQ4RTh4dnZWVDJ3?=
 =?utf-8?B?VEQzNEZUeGdBK0ZUbS9YRzcwS1V2MmVCNWwzdGdOR0k1UG5Sd1lGWFpPcE1x?=
 =?utf-8?B?YmlRZGhHWEZZSzJwU2ZZRVFWaFp1T3UzditqZXB5KzhlTnJTVTJWUXFJOWhF?=
 =?utf-8?Q?/NkJG+6cv6/Bh6dX5C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49248fd5-a2de-4dbc-1ce2-08dec6162ab0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 10:59:24.2389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m67V1guvyoLtP9O8dA1GSwqTGmNtDjEbaQZtb5kf95e5+JXg6fdn/DrYh33FsQ64
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
> Move struct amdgpu_init_level and helpers from the monolithic amdgpu.h file into a new
> amdgpu_init_level.h file.

Put that into amdgpu_device.h

Thanks,
Christian.

> 
> This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
> separate headers.
> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 23 +--------
>  .../gpu/drm/amd/amdgpu/amdgpu_init_level.h    | 51 +++++++++++++++++++
>  2 files changed, 52 insertions(+), 22 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_init_level.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 9473626ea96f..07962b06168d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -115,6 +115,7 @@
>  #include "amdgpu_wb.h"
>  #include "amdgpu_ip.h"
>  #include "amdgpu_mqd.h"
> +#include "amdgpu_init_level.h"
>  #include "amdgpu_uid.h"
>  #include "amdgpu_video_codecs.h"
>  #if defined(CONFIG_DRM_AMD_ISP)
> @@ -621,25 +622,6 @@ struct amdgpu_pcie_reset_ctx {
>  	struct pci_saved_state *swds_pcistate;
>  };
>  
> -/*
> - * Custom Init levels could be defined for different situations where a full
> - * initialization of all hardware blocks are not expected. Sample cases are
> - * custom init sequences after resume after S0i3/S3, reset on initialization,
> - * partial reset of blocks etc. Presently, this defines only two levels. Levels
> - * are described in corresponding struct definitions - amdgpu_init_default,
> - * amdgpu_init_minimal_xgmi.
> - */
> -enum amdgpu_init_lvl_id {
> -	AMDGPU_INIT_LEVEL_DEFAULT,
> -	AMDGPU_INIT_LEVEL_MINIMAL_XGMI,
> -	AMDGPU_INIT_LEVEL_RESET_RECOVERY,
> -};
> -
> -struct amdgpu_init_level {
> -	enum amdgpu_init_lvl_id level;
> -	uint32_t hwini_ip_block_mask;
> -};
> -
>  #define AMDGPU_RESET_MAGIC_NUM 64
>  #define AMDGPU_MAX_DF_PERFMONS 4
>  struct amdgpu_reset_domain;
> @@ -1436,9 +1418,6 @@ extern const struct attribute_group amdgpu_vram_mgr_attr_group;
>  extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
>  extern const struct attribute_group amdgpu_flash_attr_group;
>  
> -void amdgpu_set_init_level(struct amdgpu_device *adev,
> -			   enum amdgpu_init_lvl_id lvl);
> -
>  static inline int amdgpu_device_bus_status_check(struct amdgpu_device *adev)
>  {
>         u32 status;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_init_level.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_init_level.h
> new file mode 100644
> index 000000000000..60e75cc88bfd
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_init_level.h
> @@ -0,0 +1,51 @@
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
> +#ifndef __AMDGPU_INIT_LEVEL_H__
> +#define __AMDGPU_INIT_LEVEL_H__
> +
> +#include <linux/types.h>
> +
> +struct amdgpu_device;
> +
> +/*
> + * Custom Init levels could be defined for different situations where a full
> + * initialization of all hardware blocks are not expected. Sample cases are
> + * custom init sequences after resume after S0i3/S3, reset on initialization,
> + * partial reset of blocks etc. Presently, this defines only two levels. Levels
> + * are described in corresponding struct definitions - amdgpu_init_default,
> + * amdgpu_init_minimal_xgmi.
> + */
> +enum amdgpu_init_lvl_id {
> +	AMDGPU_INIT_LEVEL_DEFAULT,
> +	AMDGPU_INIT_LEVEL_MINIMAL_XGMI,
> +	AMDGPU_INIT_LEVEL_RESET_RECOVERY,
> +};
> +
> +struct amdgpu_init_level {
> +	enum amdgpu_init_lvl_id level;
> +	uint32_t hwini_ip_block_mask;
> +};
> +
> +void amdgpu_set_init_level(struct amdgpu_device *adev,
> +			   enum amdgpu_init_lvl_id lvl);
> +#endif

