Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069E4F8D74B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 14:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F6E810E8BB;
	Thu, 16 Apr 2026 14:06:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xw2qou89";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012060.outbound.protection.outlook.com
 [40.93.195.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EA8810E8BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 14:06:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtaMmjSmLCGmAH7+gaCaJc3OWGnBAsU2Sb5JlAW7y5HIB6cP28PcH6gKN78w/D+LT+fUYlejgkpBU18ayvTfwwtGJuJkyb/kXNujgzkUaSGsQtk75Z9RXcovjVFpvDkDu3gAGACKed5HqvIdhWuBLOA71IQdU2gE8/csbFWK3yNz/X/92I6mpN59sNPJDzfI73Sx2Z6Y7YotQXMoWbLhkd9jHkteTb8HMGyvBn9oJH9r3VQDfb0AQGJWO2yws833ZRcyZXxOIqCRqJ+bbEYWO8Ul9RGCAH6PKM7hcNMpk7jxUQlOf4S2FPuc2P/QssZIPQE//d2gJSQbchKyD+wJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w05s0qjiMURbUCCaXTW6/8v5+bs2Ik2X4kbd/zTAvK0=;
 b=RBHQ2mOzVdP1WVtk5cz1zIl+DoGMPSOw2hiedSL/jSyzOxz3u53jNna5qADcBTzaJLffxKsuAOuGOgwiJzBmyVe+yWi8Rn1fjqUKZ93zxFaQWMfVZErZ0Qz8cFHI+Lsi+J1ANW0RBLa3jWYp15d2wZM7KOjI9lU9TuK8B0t8ezdl1cd23VFUdMH6V6tsbTLRC/Fhl1pw2UiPuMb84KWnorcISd7s/WOaFmdixGkNtAjrQH2KbbkDGz2RqnJOanmWPHmkzvzC7OAJvKF2xptOTbLmL17s0g3wecfcSSWKmsbIZbJzwfRrp72XETwvI3RCPnYUxbszPd64t30TAbv6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w05s0qjiMURbUCCaXTW6/8v5+bs2Ik2X4kbd/zTAvK0=;
 b=Xw2qou89zKlPgoxthv+jCs9dRUxDQSb7nbX2yIRikaK2dg9NGv7s2KlhYgShPK1qwa9Gw35CVWoFGtwi29TBuVAXxQSVqutaH13AJ8Er0PR4aE/jWXdKgABZQCh177cf2hCEDyG2CZftVWY8nHB7SYcIxG6lM19Zg9b8zYi7TFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 14:06:53 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 14:06:53 +0000
Message-ID: <380698c2-f796-4447-9f3c-a7c40c08f700@amd.com>
Date: Thu, 16 Apr 2026 10:06:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] amdgpu: Add profiler IOCTL interface for performance
 monitoring
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, Bing.Ma@amd.com, David.Francis@amd.com
Cc: Jesse.Zhang@amd.com, Jenny-Jing.Liu@amd.com
References: <20260413192947.3145878-1-James.Zhu@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20260413192947.3145878-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0223.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::15) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: ac2a1749-4bfa-4ce1-b561-08de9bc16931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18096099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: jCzeHxkGsYDyipACVKL90gks/NQ6vEhTSSGQB9U1IoSa3FGcwEWw6taB4xG/+AYle/NnBJpTWwnn1Sc9KChFa7jVC6Zkjjra44OpYHCNp30j6/chYzIyV/lm+dGL9GMto8VSvz+n3vUTfozK2qMpRGAYcQQMidtIJ7SpLBIgL+e9Z+hF6rZQ5nQKOaLtVzC70YqvwDB12GaP/vRJjRimDLXt6VJHWz2PK94ez4xGW8RG9IxXhGsclokPmhQb2a22p9j91ay3A90xkmNF9v4GeeyGT601ZngSgXFve8Lnu45ViXac8ZbJ7s489mQHKXUPKEVYubD4fLE1seb9+wyfa2FV4iAQvl2VlqkNrrzOPyqPgCfkABgUHewQU/m4LdZO8ei/+tDS6zAwtXhbiHqyzNHQDiAh+VCC00Dghs8hk9Etr2d72DQAnbxyip6HMD0LzzpLhNxNhrxAMiIgYOjkW38wiqELku0tTtUQZ+XNAxDs2wi/41iH5+aK6niEYbc8l0ML/PXGB/CCQrSgmiH00BC+ddb1SW5qJ7pyPEm8FOL6LCtnUbYnwW+aA2Z6TWMCY/5knOrSXwz21vL9iqIPmoqrb7OU2XaCIhYcy3PWd5n0gC3tlO38VnXozIG/dwJZ1vffxBbL6A0L3bTiwJbW5fyjui6IyuDGwrZ0XqhxEA4TXOu+2hIcYr2WHMH2KrR6I8+W+XlqQAjv9PN5gi19KMbbYa8BcUnIBztyeC2BZT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18096099003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGtKS0lPWlFNeXJrM0NoY0p6SzQzRjczTGE4eFhGaThpYjlTOXpJMmt5R0dN?=
 =?utf-8?B?VDR2cURCcjhGQkRkRURWay84Uk5IWElPcnNUemVWdjI4dWNyem03ekRqWXQx?=
 =?utf-8?B?UDdHKzhrTGFhTjNwdUgrZWh1VkxWNyttL2tUNXJJTE9yK2VmbDA5Y25tOFpV?=
 =?utf-8?B?bEdQRDhGNE11S1YxNWFudktSZDhjYnp1d2VQZXRaSGx4TUVKbHZVeFE2TFRl?=
 =?utf-8?B?ZmdTV2xTM0Zkc0NaTWRZQVNTb1FLcUVTTGdRemV2a2g0aGlUT3c4WkRKdFk0?=
 =?utf-8?B?QWQxMXpTejNXNVdsMEZKZ2dZenZSQUIrTHk4bEhROFlQbnFZWFBGd0FmMEQ4?=
 =?utf-8?B?NDByYUYxZVhKWktQcFpZRGQycnFMRS9NUTVrTTZITlFnNkhJNUJ0ZGI1bFdt?=
 =?utf-8?B?RVZPNkhMekc2enVtaElvMHlBQW5hSENCcHYySTFvOWE2ejF0YlVuNlJ6azZU?=
 =?utf-8?B?SXU2V0N4aDFjd2dlRndFbE9mYmVsa21GeER5VWVlenB0cTdaZnFQdHVqRVpG?=
 =?utf-8?B?UmFWemwvaFVKZndMRFpEVkZXTVpiNlIzZWdoSzNCNC9TcDgvUWFPL0lTZE1N?=
 =?utf-8?B?TGNPNTdSdkxub2NHZzRpbGNGL1JaT1pqUFA4cFNOWnVJTDFrL2ErajV0Z3BQ?=
 =?utf-8?B?UlBHQzNMNUhYZXNhRzNKSmFZNXJ4UDBoRDM2Q0MwZ2xpZGsySGdIaTE1QjZP?=
 =?utf-8?B?VDlWa1hKV2QzSElxWGw3TW9pdTBWQUZNV3JwZENoQ0J3aSs2c0w0STZweVFh?=
 =?utf-8?B?bjNTL2M3dnVuU29OVlU1cERkdnJ2MkU1Qy8vNkJQNDM0UUI2NjNEek93N2Z0?=
 =?utf-8?B?a1czNWg1K1ByMjZBdHRPSytSZmJNeXhnK3NqR0VHQjFEMGhjOVQ4ZERYR3pR?=
 =?utf-8?B?RmtnOWJkeDE0SWZ2dnBTTVVkOEdrYjNsMGFuZEhodkFmcFFwNW1uUFlibXZC?=
 =?utf-8?B?N0pkakxIaXpsZVlvNHVzdE5WMXlXeW1WMEdzcW4zWVF4czZweHF3WlEyWHMx?=
 =?utf-8?B?dXJ2SVVpOG94Nmxzd3ZKQnQ4bFovSmhHTTBzNkNWaS83ZVY4MG9IN2phS2Jr?=
 =?utf-8?B?cHo3TmVub2NBWm9Hc0VVZ3JDbW9GV3FGaWdmZEdsSnZzWEdLVGc0bjNwV2I2?=
 =?utf-8?B?Zlp6L2REVjJER3VMd1ZvNWhYdzY2UnA5K24rU2UwREllamhQMUtocTJ3K0lw?=
 =?utf-8?B?eXoyK090Z29EdXJDL1JxU1p0dzZKRTN2M3YzbzdBbUpaZ0wzNzRsUVhkZFNi?=
 =?utf-8?B?K3NJWldaTE5LSytaclNUUXN4SnFpZzNJamJxR0h3Q1M0NitBSlFCWENLQVJu?=
 =?utf-8?B?Z244NFFJQ3pmai9KL3RzUFM2aEF4dU9ReWs2Y25ySzNGWW5QakN1WWtMeWVX?=
 =?utf-8?B?WFR0RUNNMTg0MUZxM05jS0wrcWVib0VyTDNuNTlYZ2l1VFY0ZzN4Ky9HZ3kz?=
 =?utf-8?B?NjhDMHNtOUh1R2d4VWJ0WWNEN21SWnlKdFZ6UzI5K1VNQlZBV2kvU3VySmpY?=
 =?utf-8?B?UldFTVliMjJmZ3FXSFR3ejA5QVlWaFpkcFp1ZjFJTGlpMStuaHNvZnBlUkhq?=
 =?utf-8?B?a0svL04xbWNZempJaUxNTFB2UmMySk5yak13SzA3Y25IOUNKNkE1ZitXc0ZW?=
 =?utf-8?B?ZmhBVDRLcmhHNmlYYnpHZDhvdXp3RFgxREFOOUtob2hEVVFkbEViODhaM2tr?=
 =?utf-8?B?RWRFTWF0WFZZK0pUWlZEZkRNeHViZHhVNDhZK25ZdFFrOW1Qa1h5TStCZ0Uw?=
 =?utf-8?B?dGo4M1VNQUxmQlZYeG81MlU4K3ljRDNQMDFvYU5kL21jUVVqVUYyeEl2NlVO?=
 =?utf-8?B?OFdJSHB4YktoSXRYWG9OV1JWMklhNkEzUVZKY3dGaTlWNTBOMTNlb3NPRkM3?=
 =?utf-8?B?MTAxVHhpc2ZwUVJFekdoMDZ4Z2M1a2xUcGszeFVSZm9ZeC9JMkw0UlhQZnFq?=
 =?utf-8?B?TExrQy9STnJWakdWSTB1Z2FxM01XUHBJSlJ3VEJNckQ1bVllWjU1bmtNQ1VC?=
 =?utf-8?B?RmdTRkhCOVBVSXJIL3BpUE80THczZEYzY2FLMVNhdmdQcm9USTY3L3ZnTFRW?=
 =?utf-8?B?U0VvakQxQThKYVJ1Sk91eTh5akRLWUZmQlRJU29HaTh6TXpncFpVVlRIdGxa?=
 =?utf-8?B?d0ZMZTBqRWY2NEJaNlN3ZEs1cXBXRlhBeWpEYWdPMGNOeFNuRmNoWEhRd1RI?=
 =?utf-8?B?M2JhNnBTV1JURGlSd1pCZmk2TXJlVENTN0xFNWkxN0VOSVlaeVZqTVk4UWlt?=
 =?utf-8?B?NjZQT0UwZ0NONklvVjBERGJXM1hvSytTRzM2NitGYkQ5Y0k3bW8relF2YUU1?=
 =?utf-8?Q?DhvE5TLXzW3tjaCGZ6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2a1749-4bfa-4ce1-b561-08de9bc16931
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 14:06:53.1121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JiKI3SGYZ329Sw5sNbHE4WGliemA0kz1IRvTcfo+4UT/fxoV3h1SNIlV8ItnnJ24
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754
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

Ping ...

On 2026-04-13 15:29, James Zhu wrote:
> This patch introduces the foundational profiler infrastructure for AMD GPUs,
> enabling userspace access to performance monitoring capabilities including:
> - Performance Monitoring Counters (PMC)
> - Performance Counter Sampling (PC Sampling)
> - Streaming Performance Monitor (SPM)
>
> The implementation includes:
> - New DRM_AMDGPU_PROFILER IOCTL interface with version query support
> - amdgpu_profiler_version() wrapper function for userspace
> - Profiler operation enumeration and argument structures in the kernel API
> - Build system integration for the new profiler module
>
> The version query operation allows userspace to determine profiler capability
> and compatibility before attempting to use advanced profiling features. Future
> patches will extend this with additional profiler operations (acquire, release,
> configure sampling buffers, etc.).
>
> This foundation enables profiling tools and performance analysis frameworks to
> access GPU performance data directly from userspace, supporting performance
> debugging and optimization workflows.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   amdgpu/amdgpu.h          |  9 ++++++++
>   amdgpu/amdgpu_profiler.c | 46 ++++++++++++++++++++++++++++++++++++++++
>   amdgpu/meson.build       |  2 +-
>   include/drm/amdgpu_drm.h | 19 +++++++++++++++++
>   4 files changed, 75 insertions(+), 1 deletion(-)
>   create mode 100644 amdgpu/amdgpu_profiler.c
>
> diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
> index 53144f59..4ec1f6b6 100644
> --- a/amdgpu/amdgpu.h
> +++ b/amdgpu/amdgpu.h
> @@ -2120,6 +2120,15 @@ int amdgpu_userq_wait(amdgpu_device_handle dev,
>   int amdgpu_cwsr_set_l2_trap_handler(amdgpu_device_handle dev,
>   				    uint64_t tba_addr, uint64_t tba_size,
>   				    uint64_t tma_addr, uint64_t tma_size);
> +
> +/**
> + * Acquire profiler version
> + * \param   dev               - \c [in]     device handle
> + *
> + * \return  0 on success otherwise POSIX Error code
> + */
> +int amdgpu_profiler_version(amdgpu_device_handle dev);
> +
>   #ifdef __cplusplus
>   }
>   #endif
> diff --git a/amdgpu/amdgpu_profiler.c b/amdgpu/amdgpu_profiler.c
> new file mode 100644
> index 00000000..8d4dffe4
> --- /dev/null
> +++ b/amdgpu/amdgpu_profiler.c
> @@ -0,0 +1,46 @@
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
> + *
> + */
> +
> +#include <string.h>
> +#include <errno.h>
> +#include "xf86drm.h"
> +#include "amdgpu_drm.h"
> +#include "amdgpu_internal.h"
> +
> +drm_public int
> +amdgpu_profiler_version(amdgpu_device_handle dev)
> +{
> +	int ret;
> +	struct drm_amdgpu_profiler_args user_arg;
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	memset(&user_arg, 0, sizeof(user_arg));
> +	user_arg.op = AMDGPU_PROFILER_VERSION;
> +
> +	ret = drmCommandWriteRead(dev->fd, DRM_AMDGPU_PROFILER,
> +				  &user_arg, sizeof(user_arg));
> +
> +	return ret;
> +}
> diff --git a/amdgpu/meson.build b/amdgpu/meson.build
> index 3962d32c..d781f2e9 100644
> --- a/amdgpu/meson.build
> +++ b/amdgpu/meson.build
> @@ -27,7 +27,7 @@ libdrm_amdgpu = library(
>       files(
>         'amdgpu_asic_id.c', 'amdgpu_bo.c', 'amdgpu_cs.c', 'amdgpu_device.c',
>         'amdgpu_gpu_info.c', 'amdgpu_vamgr.c', 'amdgpu_vm.c', 'handle_table.c',
> -      'amdgpu_userq.c',
> +      'amdgpu_userq.c', 'amdgpu_profiler.c',
>       ),
>       config_file,
>     ],
> diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h
> index ef12e725..307242ac 100644
> --- a/include/drm/amdgpu_drm.h
> +++ b/include/drm/amdgpu_drm.h
> @@ -58,6 +58,7 @@ extern "C" {
>   #define DRM_AMDGPU_USERQ_SIGNAL		0x17
>   #define DRM_AMDGPU_USERQ_WAIT		0x18
>   #define DRM_AMDGPU_CWSR			0x20
> +#define DRM_AMDGPU_PROFILER			0x21
>   
>   #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>   #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -79,6 +80,7 @@ extern "C" {
>   #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>   #define DRM_IOCTL_AMDGPU_CWSR		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
> +#define DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
>   
>   /**
>    * DOC: memory domains
> @@ -1695,6 +1697,23 @@ struct drm_amdgpu_info_gpuvm_fault {
>   #define AMDGPU_FAMILY_GC_11_5_0			150 /* GC 11.5.0 */
>   #define AMDGPU_FAMILY_GC_12_0_0			152 /* GC 12.0.0 */
>   
> +/*
> + * Supported Profiler Operations
> + */
> +enum drm_amdgpu_profiler_ops {
> +	AMDGPU_PROFILER_VERSION = 0,
> +};
> +
> +struct drm_amdgpu_profiler_args {
> +	__u32 op;                        /* amdgpu_profiler_op */
> +	union {
> +	    __u32 version;               /* AMDGPU_PROFILER_VERSION_NUM
> +	                                  * lower 16 bit: minor
> +	                                  * higher 16 bit: major
> +	                                  */
> +	};
> +};
> +
>   #if defined(__cplusplus)
>   }
>   #endif
