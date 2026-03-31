Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09981061B28
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 02:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7719610E705;
	Tue, 31 Mar 2026 02:22:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0bKOZZGD";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011027.outbound.protection.outlook.com [52.101.52.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D187410E705
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 02:22:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsEM78GdQV2TrYoS5o+X1AH0pIXIKqoVSTtMcMoiRm2M209nXp5SR0vGVciCmtr+UiEOjk4Q1p2l94eHX9DMGKCGYRDi/fSICpYIVVAT1JCnD+yoiBCsaHDKMpESa+YhJfAFyxl2Rjl6KhgNt0wafsz8x4I+Y3X9IBqWd9XfGyX0SWVWJ7bMEYY1IvbrwLUkzF8pCSlbzxpABksCeuegOld2mNeNDP/vf2c5/NBZwTaX7/xjYegZ8AABt/bkHNhsgb9t0H7BTchDzM4oYezU4gizYfB/V3im8MHVPn9/twpFIswEXVDrmZWb0Rkc+59VQRh0WlBfYQpeYAGuai/c+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbrak6t3uxOq2wFU/gnQ+q9bwhvF3SMn9yG6omf+BI0=;
 b=ZSjZoqW1oYW6aob7Ud68hV0syR1XQ7v64Of3ttopHpQckYcc1B+9WeryWnotCm4s6Kj1/Deui6NdUw4VZzFZlZNO5FnUshpPmetS6mqGcALiP0k3bYBYpKlJLIyVo73OwLEsEaysl0rbPAX0R+1mFGZJiSO5LwZmPZQmT+g4YahdF8lYESfvQcySIp1NwtplM1wsagnpysVHMVYdy5Krgmt5ChtBKNe0P0zMg/cldBCsmjbf6Bk3QbsaJX/dFMjumhi613gQmvBrR3WMawAy9RnQ+oOybkITShf/rdxr6Sivm1xvnFYqh1QN7OiJFO7VVe0C6hKFDiS8RiWl2SMv+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbrak6t3uxOq2wFU/gnQ+q9bwhvF3SMn9yG6omf+BI0=;
 b=0bKOZZGDiLpc4c5y3dw1oM2Y6/wjUyECq6oyrnYEZ/bS+wYdUZLrP1LjZt/hFTLEWlJdYribravGKycpfFemfzYs1/lsgYBTqYs23LM81RA6c4JeLxdlu3Eli10HsW6+frrlKnXfP6+LDHHMIh0GX8cQoY9boP+6X/aOTsVNmAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 02:22:49 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::715:65fb:c3fa:9c26]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::715:65fb:c3fa:9c26%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 02:22:48 +0000
Message-ID: <81a10a74-3f14-4948-b103-f1b5ee8b590d@amd.com>
Date: Mon, 30 Mar 2026 22:22:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add CONFIG_GCOV_PROFILE_AMDGPU Kconfig option
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20260326213751.5741-1-vitaly.prosyak@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <20260326213751.5741-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0342.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::11) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH7PR12MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: e3797e87-de6a-48ab-0409-08de8ecc669e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: O90StlDMeF8Nm3zZgmoi4Z7i/sM9LyuTQW85ply8dRPsw3hv83HilgYXq4LVl9rsHRxU1Kf8psspBGXV/XVtZeFGs4X6WrNPZVUhFgLi3a/PiuJHOKhl0B5KiIuydQL8yZCo8REng8TT1WY8+q9JPJ25WlawS/ENbyIGd++6WXl6CeUbeqltEzIOk2dG0srowM9mOS3HMiLu3ojhEVwtfdqQT6mDyJTt6FXHiyulHf37Ild1s6OrZw4eqRvVLWMZul551W9I3IzJtLU4ka2yR4G3TWTUmS5CT0uCT5yFmb+sbkhJn6Rd7lSm7Vk+nHp2c1GjhILITRI4SkurDO59nKzcRfiIFeawYwJJcL83q+Uyu0jwbHQ9me2MjLdzds2yKgfHxFmreP7lZw/jB61gtkVIdC69Ib/x48zB4GFwsdAfoEwj0UP7Lm6iGBSjTvdNjpdV7NWaltM7q0aQ1oWqDJ0iWClC3X5+zfMpTxIcme0aeymtTmuHhZ4kX3c9PRGmKPzShaCZgW93r6xOSC2Zl4qaIDN5NFANdVJf7M91bsq1PHBAXBQBouEM9iF091kA8ol8xKV1D/20jIDxNDkx15UnZfEqRaoGIdKdGORwnEEsjS6vKv+KL0zHaYHziTQs2taUEYCVkyoji1Hlmri63g8sNW/nRj4kECIUkHsEGXgxHMj8C1DTpU2XuaNE0f4Uu0B6unoO+kbkrv1bP3K4UVjuhXwyPj51l3fnQ1xBSVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnVxM2VveEN1ZlFuMTVjWU16cFQzNEhnSVFXQkk5Z0NMNG04Vm4wNkgyVXdG?=
 =?utf-8?B?c1dWbnUzQkh6RFN4K0RpU1pDeGQxSkN1RUhBNVZkWm91eFYzWWlLdk9KT3RC?=
 =?utf-8?B?M3Z3NCt4dFVFYmRTbWxRMDVoS2c4ZEZSOVpmUUpub3BBZkljbUZxcFc1aE5F?=
 =?utf-8?B?MXNXcUtaSXBGemlRT3hFTC9BVHVmTVVOc2hLckJqSmFISEM2NnpCYW5sOW1i?=
 =?utf-8?B?OFNqNXVhUHNsNWVKVGl4STh5MU9DZEtXQm81eTZTWUd0RnRFcCt1MWJPWW52?=
 =?utf-8?B?MGx0RUkrS1J2YXJBMHRhTnYyS0RHRm1zcGF2amJPOEJKcDhXWDFib3dRNng2?=
 =?utf-8?B?UDd2UEtVc20vczViQlkweFdIcy85QWlJYk1xbE9TckZtYkhWQlE3L1cxYU1q?=
 =?utf-8?B?bm9DQVRJTkZyVHJLUm5KRUUybDNPakswYTlTbWN1VkdadldQQ0E2a3k3ZW9y?=
 =?utf-8?B?SmttWEZCZEkzSzJiUGFuZHo2T1JTM2psL1gwQW1zejRURU01MXpkSXFQQ0R6?=
 =?utf-8?B?Z1F2Q250dHZPRzlCV1V1RDVLWEtoNXFGU1N1ZklzWkJLenFSRFRQQVh5Wm5m?=
 =?utf-8?B?SGZoN3ZtSmhtVVlTNVp0MjZBRk9Za3RPVUJ6ODNrYlZ4SnlPNVJtQitESkNz?=
 =?utf-8?B?TUYzbzlVb0V0QmI4Rm81WFoyMWdxR0IrYWpRL3AvQ0RRN2o2ZU92Und4NTFx?=
 =?utf-8?B?NVV6emU3SzNScXhzWEttdEUrdjVMTVhTTmdEN0lnNmVINXRGSnlEUXF3bjBP?=
 =?utf-8?B?TFY3ZzRhaHRZN1lPNjQwMHNuQnRsengvK3hTRnUyeDhRVjd6TzBFa0NGZU1a?=
 =?utf-8?B?ejZ3ZEE0b3hIOXFVUnZnenRaeGNWQ0FtbUVEYzZid3gwQThFVjBONTg2dmRr?=
 =?utf-8?B?anduMEt2T21CSEJWcHYvSWg2ampaNG1UZ0xiQ3R4K2JxMVVkaXpZY1ZPZjhC?=
 =?utf-8?B?UUJMWFd2Zmh1RHd6RDdyWFJCdEFRbVRjWFdpZW85RDNyT2doSzZuMFVUWGpU?=
 =?utf-8?B?Rjd5R09UMUhLZUpPSTBwTGl5bklTcDFZSlZiaXYvbnJycTlLZEFVbWNNa2lx?=
 =?utf-8?B?Y3hqS3RzdGwyZzVZY1ZCd3JVcDh2c1BiOERPdEYrSnN6WngydEMxZmRLdi8v?=
 =?utf-8?B?Z1RsY21CWmMzdWFsalZPb2hGTTNlN1ZkaGlCUTlMaXEzaDc1d2lRNjhuY1ZR?=
 =?utf-8?B?VWorbCtQWFkxZ1BzYmZQNTNTQURLc0ZFWEZPQ1V5TEROamV3ck9IdnA1VlVQ?=
 =?utf-8?B?SWR0QlJob0dZcEhIZC9vSkVmR2dTK1pZNk1hYnd2eE5wR0I0eXJydk5DUGZV?=
 =?utf-8?B?VjU5SmpscHBhelo1dUJrTTNQK0l5a3ZMbklMeWhFRmt2VktpVXR6OFhaVE0v?=
 =?utf-8?B?Y2liMnp5MXoxeGdSZWNaM1d1Y0szMUJNRERHTkpxZnZMaHlwSVFGWUVoZkNS?=
 =?utf-8?B?V0phZGVzb043dUFiVGpRemh3dUVQOFdubmwrcGRjSFNUZjNHVXB1TXkwTGdR?=
 =?utf-8?B?dThSYUpMVXdvckMxR05aSU01RkZCV3N2bkpJMnBJYTN3RFhwcFBPZzZRdUIx?=
 =?utf-8?B?cUFpQ1J3Wk13YUhZaFpTYTFPSkRtT2grTkxGYWpUQVE4YWVXT01yNWpMZXVQ?=
 =?utf-8?B?RUV6MklDcmJuZjc1d1N3K29EaDlPZzJCQWg5alY0M0l3bUlRbXBWMWYvR0h4?=
 =?utf-8?B?SmdMaTFYd0FYK2xJL0ZMdVI2MllkU01xSmpxTC9lNW9FYTYyaFBQR1A2amhB?=
 =?utf-8?B?RFd4b0E4U09kTUUzb2hpdlY2ekZ6aEFEbG4yUE9ySEtkUUIyanlqdC9idDF4?=
 =?utf-8?B?Q2NCemdyaFllcW10b1UwaEgzRHhQcU1VcmdSRnlTNDg4VzkrYWJ5K1ZET2Mw?=
 =?utf-8?B?azQyVzhBNDE4SWdrTzFOU3FpRHk2NjQ2Y0VFRU5wbzYzSTBHZHFCQ3VSRVdm?=
 =?utf-8?B?eWVwOW03SFYwTDA3UTN3ZTdYbTdmSndmNWtwN1NDZDYza004QS9jOWNtUEN5?=
 =?utf-8?B?Z1BnNTFxamozQ2cyWElNZzNHbnBoM21rbE54Y0tQQmhUT1I0WE51UnllaVVi?=
 =?utf-8?B?QW04RXJwU1AwTG9RaURNTEU5clRtYTRuR0Q2K2NUVGlYZVc0QzloMkdUY25z?=
 =?utf-8?B?RndvLzlBWXFkZ2RzY2M5bEd4VEJ3OU80M2hxK09NakNRV0JUQ09VS05obVhy?=
 =?utf-8?B?TmltQkRRaFVrUFI5WnRHaCt6ZVNmbVBoRHlGUjFvbHo4ODA0dEI2TERXaDJ2?=
 =?utf-8?B?ZzRuUVNjcjExY3Y1Ri9YVkwvbUoySjIwK3N0SlUzOGJ2Nk50ZVVlSkE3WGJH?=
 =?utf-8?B?Q3ZKU1dZdStXYnQwWFYzZlRKYlpSM1o3ZWtGUkNWRXU0aVRxNXVhUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3797e87-de6a-48ab-0409-08de8ecc669e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 02:22:48.1157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UmjNffmj2pfOFJSTvyK1zs7Swi3jbmmKr+sUBS4WdrGWMd8i9NqFLMomdCzvzBF4iySrvKcD6vDm2y4UOTIcPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7210
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

A gentle reminder on this patch, since I have not seen any feedback yet.

On 2026-03-26 17:37, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> Add a Kconfig option to enable GCOV code coverage profiling for the
> amdgpu driver, following the established upstream pattern used by
> CONFIG_GCOV_PROFILE_FTRACE (kernel/trace), CONFIG_GCOV_PROFILE_RDS
> (net/rds), and CONFIG_GCOV_PROFILE_URING (io_uring).
>
> This allows CI systems to enable amdgpu code coverage entirely via
> .config (e.g., scripts/config --enable GCOV_PROFILE_AMDGPU) without
> manually editing the amdgpu Makefile. The option depends on both
> DRM_AMDGPU and GCOV_KERNEL, defaults to n, and is therefore never
> enabled in production or distro builds.
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Kconfig  | 17 +++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/Makefile |  4 ++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
> index 7f515be5185d..7fb0b93bc1ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -103,6 +103,23 @@ config DRM_AMDGPU_WERROR
>  	  Add -Werror to the build flags for amdgpu.ko.
>  	  Only enable this if you are warning code for amdgpu.ko.
>  
> +
> +config GCOV_PROFILE_AMDGPU
> +	bool "Enable GCOV profiling on amdgpu"
> +	depends on DRM_AMDGPU
> +	depends on GCOV_KERNEL
> +	default n
> +	help
> +	  Enable GCOV profiling on the amdgpu driver for checking which
> +	  functions/lines are executed during testing. This adds compiler
> +	  instrumentation flags to all amdgpu source files, producing
> +	  .gcda/.gcno coverage data accessible via debugfs.
> +
> +	  This increases the amdgpu module size by ~50% and adds ~2-5%
> +	  runtime overhead on GPU submission paths.
> +
> +	  If unsure, say N.
> +
>  source "drivers/gpu/drm/amd/acp/Kconfig"
>  source "drivers/gpu/drm/amd/display/Kconfig"
>  source "drivers/gpu/drm/amd/amdkfd/Kconfig"
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 6a7e9bfec59e..db66c6372199 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -27,6 +27,10 @@ FULL_AMD_PATH=$(src)/..
>  DISPLAY_FOLDER_NAME=display
>  FULL_AMD_DISPLAY_PATH = $(FULL_AMD_PATH)/$(DISPLAY_FOLDER_NAME)
>  
> +ifdef CONFIG_GCOV_PROFILE_AMDGPU
> +GCOV_PROFILE := y
> +endif
> +
>  ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
>  	-I$(FULL_AMD_PATH)/include \
>  	-I$(FULL_AMD_PATH)/amdgpu \
