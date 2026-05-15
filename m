Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E15CD4F47
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2026 15:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0258A10F570;
	Fri, 15 May 2026 15:34:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aHk7Ep44";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012042.outbound.protection.outlook.com
 [40.107.200.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3377210F56C
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 15:34:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DO9DpU1OwFBrJvKQbJ7YHFo9anc4LzOUbwHyCNI5KFwDtkcxARlMZVVSOan1O4gOQSdDEmQD207DzCGdIvMRmdwT/5HWs/FmhuHDpytgdA1qd03uiJWw27oPX5lsAXEGfBbRQarraLZLo2FDuMep56Je4M8+Z/D2Q0X7VIUAQnqoQ8iYf3QgpcEdzo9QzQGCXWdEUH29LukyRVR3ZDjEy6op6UEFQNJ2TJQsteui6pJ83vUbSHovPnZxU0Z8DrLBd70wLZsJMaoL4oncAbC+HQRafQlKyPtHVD3kVcfrqFjzt28ltdYT8yunL+25nluyFQjZnyUxgcFWvT3J16kA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dVMBd2cv4wQU3IKMp/LOZkx5YazI1TfrPmTN82xeY8=;
 b=ia4OiAO33WiuSFHG0NpzpIPAaOSO6PvCNLxWGEnMrMzomIdrc93LtPx5SUAPWlRo0JmDBBPNuxCZUoOaTBndyNWTOW09ta7L2zL7kCb7Pp5hI4B0dsZIi6uow4WDA71BNZcsSJBUHhODftvf0HAaU5w1HcuMuEYIWM1uu5IB4oe5Ad8tSr3SMxL129/3NJchP9TnILoppYzY/+sTooev8LeYwo189nhVJwee35O9oqsYkPtC/5dAUtj5w4f9hu/PUyAzJkFMMxNGv06BdjH/jwTmAaGkgEzpEsp8PVGG5fkcX9atz8c9y3DaEco/4uJSgTInEkUINvYkaHjdu8vOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dVMBd2cv4wQU3IKMp/LOZkx5YazI1TfrPmTN82xeY8=;
 b=aHk7Ep44b0Eg4EcXSGmKkwewjSA8MyplkdPrkMGxHKPdjc6m7iiqDkhWALUpWpOwzDofaiL1NuxvHESIWxmks+wUoWWydySP/p1Z3rvXJ0lJ4stDr260lwwhxZLzD2gaYKLWfI34DlkN0PXJREAzSCx8f8r2/dfC7F/Y4GcWYdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by DS7PR12MB5789.namprd12.prod.outlook.com (2603:10b6:8:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 15 May
 2026 15:34:07 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%5]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 15:34:05 +0000
Content-Type: multipart/alternative;
 boundary="------------PYUM0ySjUsG91n78g4jg042Q"
Message-ID: <0bdc48e6-26ce-4efe-b86c-40d175cd70e8@amd.com>
Date: Fri, 15 May 2026 11:34:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] amdgpu: Add profiler IOCTL interface for performance
 monitoring
To: "Ma, Bing" <Bing.Ma@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Francis, David" <David.Francis@amd.com>
Cc: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Liu, Jenny (Jing)" <Jenny-Jing.Liu@amd.com>
References: <20260413192947.3145878-1-James.Zhu@amd.com>
 <BY5PR12MB4179F4711D276D5EFB60AA99FD062@BY5PR12MB4179.namprd12.prod.outlook.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <BY5PR12MB4179F4711D276D5EFB60AA99FD062@BY5PR12MB4179.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQBPR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::17)
 To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|DS7PR12MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: ba09db71-7e8a-41c3-40ce-08deb29765dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|3023799003|56012099003|22082099003|18002099003|8096899003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info: frdzqWfE7MZO32UhvLhHGY4tpfBxe0Wf/M0UZ9CC9z2Oh4HeBM3W/wHWAu2tCVHLarjJCOmSmdV+ISkXF70cQHAzG+miFXrFzd+mrY/VsGT8FfVxFFrrA5lOWClmgt4wZpzA+5slPLvgn/0MkOkrsa/Nk1nVcum0EqHbTZJOrb437N57kpSohPlnqYMFRwtBiMs36MctpEEgFvd+c0oNXsDkawMvV96pHCapa32dXkpGMqbfuQVRYBrsY7KDl1ClPH6nWWj/9XB01Mpnqj0fmr6QoH/XDFEaMdtWqpL6Xv6k8/hzumfziWJ1rzhMtJzTyPixB/LfWwsr8crDvY9hH8oX9Wt6YopYG1n/c3PM+WW9axWbEfjxofIPj+E03RELNkARDCg8xSLyQUICMnz3jVXbExbAEAs0Yfeju35M+oqgwoMwJOvsd3Zg6F6fj/rVU6k8Hp2JnJtSuwcTFIxGCj8lTqNMBjlYW2x0bxHYKnUPG8XBmJhiuLWUsmmHYOZ08cHIZqZUOVEeOur5Zs+k3Hv5UMkn+4uisHTMvLW/Wit/0bZLdfxof2GO7erS7jHYy8t+7R96p029aKDzejAdK/lI3q27MoavML9ctCboy/4s3hWfQYCjHeMhlCdFbxf4TCfckyqgMFdBAg+PdXzQs67/wjyxpDRbmt79NHvXI/yt/SaS96jAoddrSJFt7T68
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(3023799003)(56012099003)(22082099003)(18002099003)(8096899003)(4143699003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlUyQThuNndFSkhCNFQwa1NNWm1saitpRmFzVTdwSDlxcjQvVlczbG5MRElQ?=
 =?utf-8?B?SnFiUjhHczdzUXZYOFQreHJaM2RwSzNFT2lFaEdualg3TEc1NlNKVDdpKzA1?=
 =?utf-8?B?UXQ0M2phVGM4QWpkNEdyVFBjR2RpaGs5VlRxQ2d5VjZJK05pQ0F2OVBqVGxJ?=
 =?utf-8?B?bTh4ZjQ1dnJ0b012c0pZVC9GOHNJWHVERUQxV1hiaTRJdlFESC9mRVpnNk5E?=
 =?utf-8?B?TXFUZUtpSW1YT1J0dXEwck04TlhTa3IyR0s3M2RqM204REtrTWh4TzNYeEtz?=
 =?utf-8?B?WVQxL0ZWUjVxMHNhKzl2MnhlT01HVDBKRWhxdzdpWFA3cFpkUm9yYkdFcFpy?=
 =?utf-8?B?ejl2OFFlRnVldEQ3dWRUbkJJa0JLaVlaZzB3b3EwRXZvcllkRlV0ZjlXblRt?=
 =?utf-8?B?NE9keHJ0WkQwdUZaR2Rkb3l1WFR5dEFaSHdwN2IveXNFVlRFbkYrWG95YytG?=
 =?utf-8?B?T29INFA0Vy80UDJ1cWRydnh6VUhtVFRSWUtPUTQ3bW5LczZOSnVkQUdlZHJJ?=
 =?utf-8?B?bnFudFdENEQyeU43Wmd1TEZDOFFLbTdkZ3V0SDAweW1uWXRQTzVUM2JyQVpy?=
 =?utf-8?B?Q3d6K1NiR2RZY1FvN0EzT0VnM1JUV3VsK2QwNlJwSzMxTThlRU1TNkxubVZq?=
 =?utf-8?B?VUozMno5QUxPdkxnRjJHYjN0MDFEbmhqT2QwOTJqSGtEbEt0ZHg4OFhqTzZB?=
 =?utf-8?B?eTNaR0g4cWRkTHoyVmRiM0RlQUJYYXcyUVdVMTFTM2lzQTRib0EzRzNRR0U4?=
 =?utf-8?B?akVaQ0NoYnFHNHUzNGJ1NUhKakVONmx4STc5OVBwS2NKell3NkNqZUFaUXUw?=
 =?utf-8?B?Q2JqWjFZenJwcXBuSmUrSGhadGFtcmU2Vk1mYkJRTys0MG1sMmZOWlhaVVpq?=
 =?utf-8?B?SlhMajhWMFlmb0NxVjBNcGpOV3RXclRWd3VRdW94Z0EwNHVTbjFpSFl6TExF?=
 =?utf-8?B?S0daVmxZNm1PTDNEMGdhT2ZoZGdPaEVRcFZKbkNvU3FPQThFUXdsU0dHNDZh?=
 =?utf-8?B?cHNWdDZxT3BPRTRSTGxRK3BqaStscnhWNDBQb2tCRjk2RlArc0NPL0MrWXUr?=
 =?utf-8?B?Ykk2TDZHNk9rS3NNTnZIcTBUek4zYkg1b1ZjL1kxTWxCWDdWMU1KUDhuTStr?=
 =?utf-8?B?QklaRlVIakNndDliSDYya29RNTBMSGM2eFRzb2xOM0lrQ2NsNDBzRDc1UXMw?=
 =?utf-8?B?S3RuaHJWRmluTm5mdllZWVZyNDBydXM1cVdTU0Q1dDJNTkU1TEVITmkxM1lv?=
 =?utf-8?B?NWU0d0JDSlhKTnJtU3lONnpBSEcreUNXdWlsa2t3T2RjRDI5ajJvejNHVWZ1?=
 =?utf-8?B?NUt4UmNabjNXbjNTdXFNUmRTWlVxNk9uM2ZZUGJBcWpYYm95dmdVOC9nMDd0?=
 =?utf-8?B?OEVtWnJieHRFZVJGVjloZ3hIQ3N5NlI4Z2UxV3l6VURhNE9OalMxM01WcmtM?=
 =?utf-8?B?c0c2eDU4ajNYWnpPcUZvbFJiZDNtLzU0aGlySzM2WmFpRGk1L0dTTG1hR3hI?=
 =?utf-8?B?Sk9pSmtsZFRycG1PYWtZeGxBV25ZTWpKbk9hTnVxNTJhbGcxdjdOem5CMmQ2?=
 =?utf-8?B?WitNdDEySUVWVmdpK25Kd21LQUVxN2tEQzBodklsVDZWYjdhV3F6WEpUTEJR?=
 =?utf-8?B?alFIYTZDeWtibS82a28vZUhqN1RWOVo1YVNnYk9mc1RkZWJKMktULzFYOEw3?=
 =?utf-8?B?T3pjRWRHZ3E4TUZXZ2VMTkdCY2h6bVQwM2Q4b0NITW5xUm8rZjBYd0k1TllF?=
 =?utf-8?B?S2tiZ3pEVFhoSStJRWpibjBPMjBXWWs4Q2p4MnFHNXNaTzQzWk0vcXRCcUc1?=
 =?utf-8?B?V2JaNHdpbXFaYVpkZm9BdFNsWTdPRVl1SzMyd3U4VDU0ZU94MzRhZGsvczdh?=
 =?utf-8?B?MHpmUXFnVEJSQ0NKZXhtTktJM3RybzJ1ZkxGL3ZLNSttVGRMYUhQU1lQcHYx?=
 =?utf-8?B?elQwWFZSQXU4SWhMcWwvT1JqenBKSFBjdGluc0V6VU80aS80SDlGRFJhK0J4?=
 =?utf-8?B?OGFMYTFZRmttQ3VseGk2Q2luSGkzOEVBNTdQc1NqQzJqK2haM29CZWwyL250?=
 =?utf-8?B?RE9jRTVCOTRNVG1FcXJ4elVkdTBoSEpWZHlzTHFjWHBrQzFHSVk1WnA5VWZz?=
 =?utf-8?B?RGxLdnZOUy8zUDhsRHhlb1YrZXpwVkJaT1paTEhVNkJxY1QwNy9UZTk2L1Ni?=
 =?utf-8?B?aHFCeFgySmg0L2VpbVpEL2UyWEpxaGRQeFdJWEFWeTE0TTVGT3E1MEw2UFhE?=
 =?utf-8?B?SGpaWjdkNE1xbW16ekVnS2k0aFVtK0ZNY1JWdkFHOTBpTDRFK0VMTkJHZmFP?=
 =?utf-8?Q?IHGEvrjsY77Xg9KVql?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba09db71-7e8a-41c3-40ce-08deb29765dc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 15:34:05.4712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2esRoZDGABqTX0rBMe5NDlLJy7etCf+pjeiR9LOdNksG8COB/BGVwevVwcUcSoOf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5789
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

--------------PYUM0ySjUsG91n78g4jg042Q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ｈi Bing

Thanks! Answer is n line.

Best Regards!

James Zhu

On 2026-05-13 19:55, Ma, Bing wrote:
> AMD General
>
> Hi James,
>
> I reviewed PATCH 1/2 together with the adjacent PATCH 2/2. A couple of real issues stood out on the userspace/libdrm side:
> 1. `amdgpu_profiler_version()` does not expose the returned version value. The ioctl populates `user_arg.version`, but the wrapper only returns the ioctl status and gives userspace no way to read the version.
[JZ] Good point. I will add version return to caller.
> 2. `amdgpu_profiler_version` is missing from `amdgpu/amdgpu-symbols.txt`. PATCH 2/2 adds the three new SPM symbols there, so this looks accidental.
[JZ]Somehow amdgpu_profiler_version　was missing. I will add it.
> Not sure if this is intended behavior for now.
>
> Other than that, I did not notice anything else I would block on at this WIP stage.
>
> Thanks,
> Bing
>
> Signed-off-by: James Zhu<James.Zhu@amd.com>
> Reviewed-by: Bing Ma<Bing.Ma@amd.com>
>
> -----Original Message-----
> From: Zhu, James<James.Zhu@amd.com>
> Sent: Monday, April 13, 2026 12:30 PM
> To:amd-gfx@lists.freedesktop.org; Deucher, Alexander<Alexander.Deucher@amd.com>; Ma, Bing<Bing.Ma@amd.com>; Francis, David<David.Francis@amd.com>
> Cc: Zhang, Jesse(Jie)<Jesse.Zhang@amd.com>; Liu, Jenny (Jing)<Jenny-Jing.Liu@amd.com>; Zhu, James<James.Zhu@amd.com>
> Subject: [PATCH 1/2] amdgpu: Add profiler IOCTL interface for performance monitoring
>
> This patch introduces the foundational profiler infrastructure for AMD GPUs, enabling userspace access to performance monitoring capabilities including:
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
> The version query operation allows userspace to determine profiler capability and compatibility before attempting to use advanced profiling features. Future patches will extend this with additional profiler operations (acquire, release, configure sampling buffers, etc.).
>
> This foundation enables profiling tools and performance analysis frameworks to access GPU performance data directly from userspace, supporting performance debugging and optimization workflows.
>
> Signed-off-by: James Zhu<James.Zhu@amd.com>
> ---
>   amdgpu/amdgpu.h          |  9 ++++++++
>   amdgpu/amdgpu_profiler.c | 46 ++++++++++++++++++++++++++++++++++++++++
>   amdgpu/meson.build       |  2 +-
>   include/drm/amdgpu_drm.h | 19 +++++++++++++++++
>   4 files changed, 75 insertions(+), 1 deletion(-)  create mode 100644 amdgpu/amdgpu_profiler.c
>
> diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h index 53144f59..4ec1f6b6 100644
> --- a/amdgpu/amdgpu.h
> +++ b/amdgpu/amdgpu.h
> @@ -2120,6 +2120,15 @@ int amdgpu_userq_wait(amdgpu_device_handle dev,  int amdgpu_cwsr_set_l2_trap_handler(amdgpu_device_handle dev,
>                                      uint64_t tba_addr, uint64_t tba_size,
>                                      uint64_t tma_addr, uint64_t tma_size);
> +
> +/**
> + * Acquire profiler version
> + * \param   dev               - \c [in]     device handle
> + *
> + * \return  0 on success otherwise POSIX Error code  */ int
> +amdgpu_profiler_version(amdgpu_device_handle dev);
> +
>   #ifdef __cplusplus
>   }
>   #endif
> diff --git a/amdgpu/amdgpu_profiler.c b/amdgpu/amdgpu_profiler.c new file mode 100644 index 00000000..8d4dffe4
> --- /dev/null
> +++ b/amdgpu/amdgpu_profiler.c
> @@ -0,0 +1,46 @@
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> +OR
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
> +amdgpu_profiler_version(amdgpu_device_handle dev) {
> +       int ret;
> +       struct drm_amdgpu_profiler_args user_arg;
> +
> +       if (!dev)
> +               return -EINVAL;
> +
> +       memset(&user_arg, 0, sizeof(user_arg));
> +       user_arg.op = AMDGPU_PROFILER_VERSION;
> +
> +       ret = drmCommandWriteRead(dev->fd, DRM_AMDGPU_PROFILER,
> +                                 &user_arg, sizeof(user_arg));
> +
> +       return ret;
> +}
> diff --git a/amdgpu/meson.build b/amdgpu/meson.build index 3962d32c..d781f2e9 100644
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
> diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h index ef12e725..307242ac 100644
> --- a/include/drm/amdgpu_drm.h
> +++ b/include/drm/amdgpu_drm.h
> @@ -58,6 +58,7 @@ extern "C" {
>   #define DRM_AMDGPU_USERQ_SIGNAL                0x17
>   #define DRM_AMDGPU_USERQ_WAIT          0x18
>   #define DRM_AMDGPU_CWSR                        0x20
> +#define DRM_AMDGPU_PROFILER                    0x21
>
>   #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>   #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -79,6 +80,7 @@ extern "C" {
>   #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL  DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>   #define DRM_IOCTL_AMDGPU_CWSR          DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
> +#define DRM_IOCTL_AMDGPU_PROFILER      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
>
>   /**
>    * DOC: memory domains
> @@ -1695,6 +1697,23 @@ struct drm_amdgpu_info_gpuvm_fault {
>   #define AMDGPU_FAMILY_GC_11_5_0                        150 /* GC 11.5.0 */
>   #define AMDGPU_FAMILY_GC_12_0_0                        152 /* GC 12.0.0 */
>
> +/*
> + * Supported Profiler Operations
> + */
> +enum drm_amdgpu_profiler_ops {
> +       AMDGPU_PROFILER_VERSION = 0,
> +};
> +
> +struct drm_amdgpu_profiler_args {
> +       __u32 op;                        /* amdgpu_profiler_op */
> +       union {
> +           __u32 version;               /* AMDGPU_PROFILER_VERSION_NUM
> +                                         * lower 16 bit: minor
> +                                         * higher 16 bit: major
> +                                         */
> +       };
> +};
> +
>   #if defined(__cplusplus)
>   }
>   #endif
> --
> 2.34.1
>
--------------PYUM0ySjUsG91n78g4jg042Q
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Ｈi Bing</p>
    <p>Thanks! Answer is n line.</p>
    <p>Best Regards!</p>
    <p>James Zhu</p>
    <div class="moz-cite-prefix">On 2026-05-13 19:55, Ma, Bing wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BY5PR12MB4179F4711D276D5EFB60AA99FD062@BY5PR12MB4179.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">AMD General

Hi James,

I reviewed PATCH 1/2 together with the adjacent PATCH 2/2. A couple of real issues stood out on the userspace/libdrm side:
1. `amdgpu_profiler_version()` does not expose the returned version value. The ioctl populates `user_arg.version`, but the wrapper only returns the ioctl status and gives userspace no way to read the version.</pre>
    </blockquote>
    [JZ] Good point. I will add version return to caller.
    <blockquote type="cite" cite="mid:BY5PR12MB4179F4711D276D5EFB60AA99FD062@BY5PR12MB4179.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">
2. `amdgpu_profiler_version` is missing from `amdgpu/amdgpu-symbols.txt`. PATCH 2/2 adds the three new SPM symbols there, so this looks accidental.</pre>
    </blockquote>
    [JZ]Somehow&nbsp;<span style="white-space: pre-wrap">amdgpu_profiler_version</span>　was&nbsp;<span style="white-space: pre-wrap">missing. I will add it.</span>
    <blockquote type="cite" cite="mid:BY5PR12MB4179F4711D276D5EFB60AA99FD062@BY5PR12MB4179.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">
Not sure if this is intended behavior for now.

Other than that, I did not notice anything else I would block on at this WIP stage.

Thanks,
Bing

Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Reviewed-by: Bing Ma <a class="moz-txt-link-rfc2396E" href="mailto:Bing.Ma@amd.com">&lt;Bing.Ma@amd.com&gt;</a>

-----Original Message-----
From: Zhu, James <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Sent: Monday, April 13, 2026 12:30 PM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Ma, Bing <a class="moz-txt-link-rfc2396E" href="mailto:Bing.Ma@amd.com">&lt;Bing.Ma@amd.com&gt;</a>; Francis, David <a class="moz-txt-link-rfc2396E" href="mailto:David.Francis@amd.com">&lt;David.Francis@amd.com&gt;</a>
Cc: Zhang, Jesse(Jie) <a class="moz-txt-link-rfc2396E" href="mailto:Jesse.Zhang@amd.com">&lt;Jesse.Zhang@amd.com&gt;</a>; Liu, Jenny (Jing) <a class="moz-txt-link-rfc2396E" href="mailto:Jenny-Jing.Liu@amd.com">&lt;Jenny-Jing.Liu@amd.com&gt;</a>; Zhu, James <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Subject: [PATCH 1/2] amdgpu: Add profiler IOCTL interface for performance monitoring

This patch introduces the foundational profiler infrastructure for AMD GPUs, enabling userspace access to performance monitoring capabilities including:
- Performance Monitoring Counters (PMC)
- Performance Counter Sampling (PC Sampling)
- Streaming Performance Monitor (SPM)

The implementation includes:
- New DRM_AMDGPU_PROFILER IOCTL interface with version query support
- amdgpu_profiler_version() wrapper function for userspace
- Profiler operation enumeration and argument structures in the kernel API
- Build system integration for the new profiler module

The version query operation allows userspace to determine profiler capability and compatibility before attempting to use advanced profiling features. Future patches will extend this with additional profiler operations (acquire, release, configure sampling buffers, etc.).

This foundation enables profiling tools and performance analysis frameworks to access GPU performance data directly from userspace, supporting performance debugging and optimization workflows.

Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
---
 amdgpu/amdgpu.h          |  9 ++++++++
 amdgpu/amdgpu_profiler.c | 46 ++++++++++++++++++++++++++++++++++++++++
 amdgpu/meson.build       |  2 +-
 include/drm/amdgpu_drm.h | 19 +++++++++++++++++
 4 files changed, 75 insertions(+), 1 deletion(-)  create mode 100644 amdgpu/amdgpu_profiler.c

diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h index 53144f59..4ec1f6b6 100644
--- a/amdgpu/amdgpu.h
+++ b/amdgpu/amdgpu.h
@@ -2120,6 +2120,15 @@ int amdgpu_userq_wait(amdgpu_device_handle dev,  int amdgpu_cwsr_set_l2_trap_handler(amdgpu_device_handle dev,
                                    uint64_t tba_addr, uint64_t tba_size,
                                    uint64_t tma_addr, uint64_t tma_size);
+
+/**
+ * Acquire profiler version
+ * \param   dev               - \c [in]     device handle
+ *
+ * \return  0 on success otherwise POSIX Error code  */ int
+amdgpu_profiler_version(amdgpu_device_handle dev);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/amdgpu/amdgpu_profiler.c b/amdgpu/amdgpu_profiler.c new file mode 100644 index 00000000..8d4dffe4
--- /dev/null
+++ b/amdgpu/amdgpu_profiler.c
@@ -0,0 +1,46 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person
+obtaining a
+ * copy of this software and associated documentation files (the
+&quot;Software&quot;),
+ * to deal in the Software without restriction, including without
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute,
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND,
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include &lt;string.h&gt;
+#include &lt;errno.h&gt;
+#include &quot;xf86drm.h&quot;
+#include &quot;amdgpu_drm.h&quot;
+#include &quot;amdgpu_internal.h&quot;
+
+drm_public int
+amdgpu_profiler_version(amdgpu_device_handle dev) {
+       int ret;
+       struct drm_amdgpu_profiler_args user_arg;
+
+       if (!dev)
+               return -EINVAL;
+
+       memset(&amp;user_arg, 0, sizeof(user_arg));
+       user_arg.op = AMDGPU_PROFILER_VERSION;
+
+       ret = drmCommandWriteRead(dev-&gt;fd, DRM_AMDGPU_PROFILER,
+                                 &amp;user_arg, sizeof(user_arg));
+
+       return ret;
+}
diff --git a/amdgpu/meson.build b/amdgpu/meson.build index 3962d32c..d781f2e9 100644
--- a/amdgpu/meson.build
+++ b/amdgpu/meson.build
@@ -27,7 +27,7 @@ libdrm_amdgpu = library(
     files(
       'amdgpu_asic_id.c', 'amdgpu_bo.c', 'amdgpu_cs.c', 'amdgpu_device.c',
       'amdgpu_gpu_info.c', 'amdgpu_vamgr.c', 'amdgpu_vm.c', 'handle_table.c',
-      'amdgpu_userq.c',
+      'amdgpu_userq.c', 'amdgpu_profiler.c',
     ),
     config_file,
   ],
diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h index ef12e725..307242ac 100644
--- a/include/drm/amdgpu_drm.h
+++ b/include/drm/amdgpu_drm.h
@@ -58,6 +58,7 @@ extern &quot;C&quot; {
 #define DRM_AMDGPU_USERQ_SIGNAL                0x17
 #define DRM_AMDGPU_USERQ_WAIT          0x18
 #define DRM_AMDGPU_CWSR                        0x20
+#define DRM_AMDGPU_PROFILER                    0x21

 #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -79,6 +80,7 @@ extern &quot;C&quot; {
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL  DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_CWSR          DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
+#define DRM_IOCTL_AMDGPU_PROFILER      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)

 /**
  * DOC: memory domains
@@ -1695,6 +1697,23 @@ struct drm_amdgpu_info_gpuvm_fault {
 #define AMDGPU_FAMILY_GC_11_5_0                        150 /* GC 11.5.0 */
 #define AMDGPU_FAMILY_GC_12_0_0                        152 /* GC 12.0.0 */

+/*
+ * Supported Profiler Operations
+ */
+enum drm_amdgpu_profiler_ops {
+       AMDGPU_PROFILER_VERSION = 0,
+};
+
+struct drm_amdgpu_profiler_args {
+       __u32 op;                        /* amdgpu_profiler_op */
+       union {
+           __u32 version;               /* AMDGPU_PROFILER_VERSION_NUM
+                                         * lower 16 bit: minor
+                                         * higher 16 bit: major
+                                         */
+       };
+};
+
 #if defined(__cplusplus)
 }
 #endif
--
2.34.1

</pre>
    </blockquote>
  </body>
</html>

--------------PYUM0ySjUsG91n78g4jg042Q--
