Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFDFCD4F25
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2026 17:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5521A10F589;
	Fri, 15 May 2026 17:17:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ap2s1HdN";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013040.outbound.protection.outlook.com
 [40.107.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 612FD10F589
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 17:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vpl7VlW/c5MBB2iKaS6q0tY9Z13WmHr4Eayu6fiu9iNwchw/VwZGGUGZFyU72prBb7MR+nljkRB3fZxMYmSRMVmyfmaY8KDUG/DbBjkYdTQYoPk+PORhaSm8R/nxdg1RGXIzi2Vc5rHjWWoW78Wmx5OQ+E6eRV4mHD1VENqf/Om2VX8zgFEsyBIRn3Lw/6lxLhsE7uUuPrYxklDEb327q8OQ2BBEx8YJjTXBXOWl2SN1Kf97g8Rh/SVP1HqBwRkQcTGYyNRcwT5/UwDoJh6PihAMiFquynQoI6NyLyKeD9b5eDoJ3cwJIQGX4LQdbiveii053szzzhg+Mex7QSYKVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEnihfAsRcuygco7xc38eFsyz3l7f1hfsROaRG8eufE=;
 b=tdk7VwmHshqhXx+i2suVUuVSmIlKarrrk50nxVhBjRtA7QmZuCZWYVdzqVbzKPNlAWMsnFPWTzaXwH5jTOlrqGnpKQPOs+/OWJNX1zxncZlVSl9mTTqBwrgGkmPkYZJVW+JQaUEdtedgcs9i34Qt8CBbXhP5nE2n0uDZ25E4SJji//AAYg9q7wtOtnLu2MJTUB+F5w/kdopEg/YFNb76nBarn3DisGsucLrk0dykgxuAhkvslD+iRL6buRChW2/pRiAT+VhmnN2lTlqUcmEiLFrqeaYPVSRZ+MasJtj7JtYlicNjMpkL1X8jPryMFKD2uHwcyGLcQ66a0r7UOI5Cqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEnihfAsRcuygco7xc38eFsyz3l7f1hfsROaRG8eufE=;
 b=Ap2s1HdNjONOQdL7hrPmKItyKGN7MCO7H4KDG669chxohS8Ke4B9oRMfdrcI4fWlw7dNUl30Sbyul38aFWFfqyc9CQ2cqPeyyCfCiNJMd0YY3PpnVR29cgEndkXTReSbP07mVkZ6TBB+4TV4NAagSFmWXObPR/q4oeFL6wmB4/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by SN7PR12MB7154.namprd12.prod.outlook.com (2603:10b6:806:2a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 17:17:05 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%5]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 17:17:05 +0000
Message-ID: <f5267fa8-3052-4469-9d91-ce991504eee6@amd.com>
Date: Fri, 15 May 2026 13:17:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] amdgpu: Add profiler IOCTL interface for
 performance monitoring
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Bing.Ma@amd.com, Chris.Freehill@amd.com
References: <20260413192947.3145878-1-James.Zhu@amd.com>
 <20260515171341.3703839-1-James.Zhu@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20260515171341.3703839-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0004.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::17) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|SN7PR12MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: 4623bdd2-a515-4b6e-8768-08deb2a5c970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|4143699003|3023799003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: qH/dXiiMWN0dQwGqscSkTwKmI4qJScxrblB0D5FiVBVPHl173Sn1inFyiKQeM9h0g0boAerbjLt18cLk1HZvY/3fd56hCK2drrpR7xCHWbz4ZHjEXltEv/oOprxWnrRsKNZxcItO9bnUN+P0kwzy+GZsmutfMmVjniGmyIwZOYfkxQZHfJoUqSoYLjK+bYceMvjyIXqTN34Km3ZRyuuNwDLLHdaKJkxEOgEwPMeoCb4eEMUTMgP8T4HixgT1rwRxU5obzKVSZQS3CX7jbDgQCoXs+N+BrMfPQXyfrmd1FRhKm8QVjcXdbQM74s1nvRyhalQA/H2Xy/2OilPe7YdED1jgvDSb3S1WlPSFK/7vyzWgImk6zTiRsisoO0K9vON5sua9c+7rkEj7Rgce3Zj4cgma4Og6Rm/HGeNQQrV3UuCC3XvQJSaK+87xuC68s9OBtGIK5Qe9mLmorEAoAfmE3pGwOlSG2rPfp21MEOT5vwNbN+mqTw/aeZQjkYRF1OVjw8AucdJvSrU2GDfeguiNbLfX1DYnMxbR0z5+gPSUEnitJq7AsTOvhDSRVPj1AHeDMhpu309ZH7QcfLdFrkZu7qtPKHwSa+xFS6rjgN/VZ6xhut8qouym3DPljZw6EzQWNxeoanFP54iFZxrZrrVDR9JF0fvSg/RHBwDf3BxY8cH7+lamP77EUwCPNjxvnR3p
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(3023799003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1FrTm92K211Mlk4QlRwN05oMkVsT3ZnV21PZENvUTg3cEZZc3BXTWxRU2tC?=
 =?utf-8?B?K3p0U1drV1FHM2FheVFua2daQUhDKzJyYUVXcEpxWGJzL3ZsZmJyOC9ITlQ0?=
 =?utf-8?B?cFEwT2hwYmYwNjFUbDE3UzJWYkJhK0lleHVNUys0UStvRFdtdjZXbHpkaWNF?=
 =?utf-8?B?S05aeVRsWU5aWnJVM2ZrZjg1OENiV3Y5WmY1K2tub3hrT3Y4Z1RDUUxFdU9I?=
 =?utf-8?B?Q25VRlNaYjdIT1FzL1dGNHFRNU5rWXVwWnpLVWhkN2E5aXZFalRwQ3JxUWdw?=
 =?utf-8?B?ejF3bit2UWRLc2NYVXQ0ZnhJNmZhWXRyVGtRM1dlaTA3RGZiOGF5N0hKT210?=
 =?utf-8?B?QnorYklGeVozMS9BS0xZZDBUU2UwUUEyYkUzNFlHa3c1Zy84d3ZKVHN4QVpY?=
 =?utf-8?B?Wm1xNEJrQkVIVG9JN1Jwam5HZ2UrMUNMVVpNN0crYVNXU3VpZ3ZNcTQzZnZu?=
 =?utf-8?B?Wnl0Nnh6L0pld0JlU3JPRjhHMk9DVGR5bUM3YXl5Yk91bXd6bVB0TW5jbXJz?=
 =?utf-8?B?OXZRM2VuU0FtWmI4ZTBMZXJHRCtmeTFrbmxZcFNYU3oyTkJ3VVBTSENqTkVu?=
 =?utf-8?B?RnV0STJ3ZjIrL1hxZE9BY1NyRlRUcmNlb0xHT3hlanRramFibVhsYTB1VUVV?=
 =?utf-8?B?Z1BUMmVIdWIzWWdOL1VtcUlFaGlDUTUyVG8yc3A3dXNuemtMdW1tRGRRTU5r?=
 =?utf-8?B?aFhjc1ozc3d4VTZNTFZDTDFKVmhkMXZHNlBxTkJocHVPRTQzTEdHU2cxZFd4?=
 =?utf-8?B?TkdwR2oveHdhdnBJcjI2U20rYnNVTVp5dU5rUmlpdk5WbDM3WW96YzBsRE5y?=
 =?utf-8?B?OHFDUWlhNFp3SkVjK3FsMFZaZ042RVJqcEZTWlRIdmNWUlR4blQ5R0d4UzEx?=
 =?utf-8?B?V0FOaitMTFllMkdYV0ZuMTR0akE4ekRFUzQwRGhla2IvU1FudThuNmdIbTEw?=
 =?utf-8?B?STJJY1JweDZVVEo5cHUwWWFtejNzcXVObkFGeGFueGNabjZ2ZllySVhlRFli?=
 =?utf-8?B?dG1vSnc3d29kYjFhY3FCTnNDdTlTQ1hYQmZ2VnVWNlJhYzBYKzN6aGRCWktK?=
 =?utf-8?B?RzludDdVSDBpbzU1L3hFKzJzRmQ3eTUzR0pKTjZaM3psWjBRUG0wN3lmZzBu?=
 =?utf-8?B?QncwNG5qaWZPM2RZN2JiTTFnYm5nNTNGN2c2ekhyUHZQcUl2N281Y0dqbERG?=
 =?utf-8?B?OUlld0FCYS81eDREbkZqMXlMb1A2SUxmR3Zvd2VzYmZXWlY5S2tWUGgxdHUy?=
 =?utf-8?B?TUg2TW9oQ3h1VG9KZDBxL0VGaDVER3h1UHNxR1Q3VncwR3FVRm9lVWc5ODRD?=
 =?utf-8?B?SDZ4TkphSk5Xa29SR0NCNTREbDhZTWF5ME1peDNpaURFN2hZRkdwaXRCbXlm?=
 =?utf-8?B?dXpnK1REcjUrQ1JhQTZkSnBuSkFUT2I3d3g2eGtuMDhrTnQyYkdic1JLLzh3?=
 =?utf-8?B?ajhEVlpaYWliZndBc2dmMEtqVVNKclIvNlRSK1hGanYxcVJhK3VESTdVU1pJ?=
 =?utf-8?B?UlRGMnhEandUNnJ1dnFKaGhsUVpxRFBjdHFnY3VRMHZBelJLY0N4RXFpbVJt?=
 =?utf-8?B?bUpVallZQ2tBZWx0c0UvMGliNDBxZC9mQnZGYjU5dnBpL3hqNjFadTFObmoy?=
 =?utf-8?B?UmtPVm5zWjBDWWszVnkzWjh6N3RmWkxYYnhTMG1qZ0kyT1V6cFZvanZ5ZTR3?=
 =?utf-8?B?a002eUpBUGRpMUF0aVRPZGp4bHM2QVJZQnNJampoUWJTZzREV1V5bllVZGQr?=
 =?utf-8?B?eE5yVzk1ODd5azhYOTl4dGVNRE9JYVZyWUhSZzcxN0xvQTMramMyaThtMUov?=
 =?utf-8?B?N0ZBa005VWNJVFVad09tcnZ0SHMxeTV6RG9hOFd2THR3RXFiWVlzamJHRUJ4?=
 =?utf-8?B?QUVBM0lOL29wdHViR2l0RDUxZWxZVHpiLzN1QWFBeTYvRmljQ3dmcnZzU1Nx?=
 =?utf-8?B?b0RUdCtKd1poS0diYWVqVjAyMlRzWVF5UWQ4TG42T29ZQUVoK3dMSmZMN2lD?=
 =?utf-8?B?OVZrbElPbUY4bVJmNXYzTEdUc3lFRzlkYkIxMkQ1emoveXBSMStESm5haEpJ?=
 =?utf-8?B?ZnR3bWFCdGNKdSsrbnQrU0pmL0lwdzlQcHJMUk1FSkkxWmhRcVMyd0tpQnM1?=
 =?utf-8?B?UVpqVC94cktVT0dGV1Y1VFZYY0xiSU5jMUJUSVB3ekp2Y3lvUkZITW55SFhi?=
 =?utf-8?B?MGd6RmJVR1E1c3RhRkc5MzJNQjhBMkU0MHkvK0tINjhHL2xMcEZaVklHTW5t?=
 =?utf-8?B?VjFBZU1TcE9WRFBoTGYvQjduMG11TkpzajBvMFRxSmxIYkM0b3VsbHIrVU82?=
 =?utf-8?Q?VX6UVrFK/ZTtjJvgkf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4623bdd2-a515-4b6e-8768-08deb2a5c970
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 17:17:05.4739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBzoT4cdmvZxG59L+zuvFmPPp5ojg91A78eyfLiBQHPELMO4ILuPJbcUxVEdI0ra
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7154
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

drop this version.

Thanks!

On 2026-05-15 13:13, James Zhu wrote:
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
