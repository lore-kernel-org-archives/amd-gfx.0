Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6F7C98302
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 14:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B50910F0E3;
	Wed, 23 Sep 2026 14:27:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LAmyx0X5";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012056.outbound.protection.outlook.com
 [40.107.200.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80FB010F0E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 14:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnNsP4SG9PzN7IqpTl2FE06IGznTTl3s6YKa7BdNCW1Mcz2Un76aOPMEEki8MPnMC4iwzrRvvYLSi9gFI1/XRTH5WNH+JUwbSJkw6eU/PjOZtCTJb2Iao4X8iemMJhHh8gdU4HS0pnAvx5qNulG6X4Zhot3oouFV/FopgxFfobQ6XhxXybq0ENQpj073dHx4LvKktBWpaZXi++NtHwmZTktRCkKXROe+dxB+KmdcS87oe1JU3n7OCq5hq31CJIsnK9BjmW3kqsp9WtI0V6sWGi4tSlUrsXBwv6/Ei2D9OTLAU4pmAsbC5Bkhe4lEjeG9aEk26ZoyjfHY/t+qFiPq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Um0oMwg3V9Lv5AqL+o4bXzdhDUGuexpxswwQAJInCXk=;
 b=QwbKu/gZMgCYtuBSVk+WSRvgahEkMrcnr+wc7VizobBESuxebS6VIvBGFBOHnrkSvvErNQVgAZYRIucjpF3PZEgybEls1e+904uYHjbGO5rlABZXh5nrUQns0ASn8dGq1xUBHQgSH0TR0+20bHYKruEK/IszIu3p8RC7qOYnssD/xLSqD6KBW+KbbRjm/j4K80GM1I8vij20T3FeUU3F+zkForOPfbZZopLHZbqQgbI++bibtBLazLfsCOJ8PlYUBq50WgFEfioUXsRmSdI96Ob5A1fbGAduHPzzJa7nQZWlwKQ6J+7GxXLwHKx3eXiMnLCJNjcjlTAtyZNZMUrW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Um0oMwg3V9Lv5AqL+o4bXzdhDUGuexpxswwQAJInCXk=;
 b=LAmyx0X5weK5CdYh4GMIGxQ8YessXwkngBE3luyc3zvJ5uVqpk9wzwjFlqqpzP53I8+xmJDIAH+97gTqN1QP1CghlncwtPM98oAw8zHdSkJOyd/5YZOP0ZYJEi6bjXMtVqW+LTKbfwIn/AcS8RQdmhNxskoc/lLSpxTVdn5q6wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by SA3PR12MB7857.namprd12.prod.outlook.com (2603:10b6:806:31e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 14:27:43 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 14:27:43 +0000
Content-Type: multipart/alternative;
 boundary="------------7JjL3v4VvkczSJs20kQtS0eF"
Message-ID: <b6d44d11-0c54-40de-bb79-85a4e00979eb@amd.com>
Date: Wed, 23 Sep 2026 10:27:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: add support for lsdma v8
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Likun Gao <Likun.Gao@amd.com>, Frank Min <Frank.Min@amd.com>
References: <20260922135419.2145987-1-alexander.deucher@amd.com>
 <20260922135419.2145987-2-alexander.deucher@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20260922135419.2145987-2-alexander.deucher@amd.com>
X-ClientProxiedBy: YT4PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::26) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|SA3PR12MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef25c33-c914-4fe2-56f6-08df197ed48e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|3023799007|4143699003|10067099003|18002099003|22082099003|11063799006|56012099006|8096899003;
X-Microsoft-Antispam-Message-Info: BfCwXGcCPuNJd5qersya2Rmoka57msGB3hwer4GNzZhjECQwa9iH9XD6nR1wbewfk/8wI1HaBdeWZgttBg2yLa3UDzNQ/Zv+e2cqlQzz6jDk4V4Jc0vHMyyOrdzGkt33GM/tdRvZuOgH2LXYuwS+lNmSQJ7gS4kyYDy4cTXgZDmGx9bHHuSUDvs11JoLaHK4yJTJ5ZRQektZTuuBwjqyvrYaz+L76hjxl6XOsU2EuNyXCVYsdHS7dMUaApCySsVCsq89DRoNANPF/gXh6FlzKGNt5BcmuTcdoodtmcGmGFa1XWLV/EiD3VPfUJXNQDkBu6TNBLxkXWhw1TVA8Xpeo+YcjiH/5StEkDy5sQW1T+WkBwvbFyzmo4+Ivn6iGXLDsOZCI5nYTGH0akyfqe0C+5yFuslsZ7lberFqWb5yuDuJ5dbcTrqVU0shzUyW+LF6dGUfZM326HKZV/E7dtO4d/JbP1Y3Nc8JA8bauqKRAbCxr03f4VhMCVmfqNQF2zwadZ8/pcVDxBAqx2aV/TpGjH8LazMZFSszLpcOJYdW7KPMESq6XohU/Hd9p64tMp1Ar+T/tXJh8RGwvQukKJaB4qJvz35uM/j/kgjWddRlIgBL9XsnTYmsNAEk4Ys8OFzAMjMQ9PjXPr2RUIR4dyRKQ5hu8CvxsCXIxP9uEQ3tG5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(3023799007)(4143699003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qmg1ZW1yRnZXdXlMSTcyYUxWMzdJQmI4M01wODVwMUxsZTRZR3RMZXN1Uy9P?=
 =?utf-8?B?V2xCczF0c3pCbTVjTjJpb2tPbWZJbkFCekZVNVJyWDAvMTZNeXc3OWswQUp3?=
 =?utf-8?B?OFFYN0lMQ1ZVUndkT1NXL3FGdW1oUThTbHJVMElORW9ReGZkaU9XNzM3R0Y3?=
 =?utf-8?B?WlVUZGdRTlpzUWJLZ2JWMlcyTFJoYkxvMGM3YnArMTExSjhlcytDZDVGVjh0?=
 =?utf-8?B?NG1yVmNtbFZzMzhVL3FiYjdZQkNaMkVxbmFRekZqOUVSRnJHaSt0bkJySHEz?=
 =?utf-8?B?Y01MajJhR2pMdzgzSUtQNVhUdmF3UnhwdVdjRDE4MThBT0JJVlNnTEVmSFM4?=
 =?utf-8?B?TTdYbHRVQkxOWmpsSkJ6RWllUjRlWExJQklkaElrV3NYSkNWRkpYc1BqNlNQ?=
 =?utf-8?B?TXVOTXZVUWlWdHpEaUw1OVVLZ3B3a3ZnSzA5dTIvS244dnJ0T2hlK0VPVk9q?=
 =?utf-8?B?UklsSXluL0NsRzMvTGczZEtCRlZYQ29uVEYzYWd4WTFpd0xPSnpTdldwTm5z?=
 =?utf-8?B?b0Zzc0lCRWZvdUZrb1dVNFQ2MDltblBiUnQzNHdHbnMyc2M2RWhZR0V2Tjlr?=
 =?utf-8?B?ajJtVCtjbEVVWnNsV2p2L1dXTVptWTJsYytQRWdJQWdKbkQxdXdrMTN1K0xh?=
 =?utf-8?B?MXU0OEVvYjEra3p4SnBjbk1neWdybUxXeG1xK29sRVJVN2txMm9wYUNJOHV3?=
 =?utf-8?B?MFZzZkx4M25kc010V0hMc3pUVW02VUtSQUhEaTJzY25TZHhmYmFnRHdrWFlZ?=
 =?utf-8?B?ZTlkakd3NWVSanMremE3bHM5YU83S3FGeWxpM2REVUd3a2pyN2NGNnRjUFVh?=
 =?utf-8?B?azZISXI5clhxMld5OUp2dGc0SUE0QUV5TVNUMG1rS1lTb2U4VFpmZDBDZ09i?=
 =?utf-8?B?aU9zVzNnOUx4dWlSczdyRlRoNm1NM1lDRzNmMEkwNlJHZ3Q4K1pZTWJMYUt0?=
 =?utf-8?B?UzEwMXJKM0ZsRHkvTnZQbThhakY0ZFBXT3NTVmFaWW9lakM0bzlGVkhqQnRq?=
 =?utf-8?B?T1pCandmcWZCcUt2WWxOQjd5bUpuUG5obUlTVVc1ZlE5eVd6WE8vS3hIK3h2?=
 =?utf-8?B?NG02MkRXbzZmS21zNHc1dzZTTkEwZ3pmZCtOUkNkZVZYMlZKVlBHVW5tUHlC?=
 =?utf-8?B?dkVCaWJqN2dWeXNxVUxyRHRkQitCVkJkck9EUzdTZmQzeUQwTzExblRkdldj?=
 =?utf-8?B?OE5XTUZwVVdqeksrSVNYSTlja2F3YnNLcFQzbEU0LzZEVTkydGZhOFV2TTgy?=
 =?utf-8?B?S0o0MENSNnREVUNmdStxYW1LZnRHczlQSHNlYjhYYzRvNVBNbCt5NVVvTFJZ?=
 =?utf-8?B?dkZWV0RodXExajlDdG9meXEzVGFrSzRjRytueXJDUWRMeHExTUtsSFBMN3Bi?=
 =?utf-8?B?NnJDT0tWNjZmWXNjYVEwNFMzZm9FYnA0MW0vS1VhOEhEeDl4UEIya2ZOM3oz?=
 =?utf-8?B?UVUwemJPbzlodzNTdnpFUFh0Q25BUFRtcUNVWjB5ZjZCUDFITERidkVZNjlH?=
 =?utf-8?B?UG1jM20xcHBYNnZGUG1RUUFtUDA0bkMyaGd6TVRYVXZzelE4dzBBTVExVk94?=
 =?utf-8?B?T1ZpSStLMzVnaXJuaWFEdk8xT2hwbU1mSit1MzZjNTZtblVLVFZmMWxGb3Zn?=
 =?utf-8?B?TnJJaVBXZDc2blFnRUtTRFhZL2NmWFFQWGtUbWVQU05na0VBQkJHS1JyV1hs?=
 =?utf-8?B?R0JOYW92U0FLODIya1FDZmloZk1IZ2ZDbDFqYzk0WWJYTGswL2lKbTVnNG1V?=
 =?utf-8?B?TWxJd2hVN1BwaEZCWlJMY3ZYY3JYVVBjRGhERmtrdFl0cWxodWtBTHpDU2pr?=
 =?utf-8?B?VzI4bGlBdG9ZNmd4bDA4djJiYkVDcWJWdVZOUDg1aC93aXFIaFhHS2JEUnVi?=
 =?utf-8?B?YVdEM0xBUkRRSkF3MytHbmtKeHJ0YjkrWmp1eFNqNklGYlFYVVhqd2c5c3pq?=
 =?utf-8?B?QnVuWjkyRnlOQ3VIWnEyaHpkVjdWejMxQndJRE5UOHRSZDY4bHJCSXhNaGdT?=
 =?utf-8?B?Skx0RlRUZW9lU3BhT3lET0tDS1Q1ZXNlQXBOYVZQcDdrTUtWWUZ1M3lhWGo4?=
 =?utf-8?B?RmpicTFENW5DMDU0NHdiNlJXZzJyUXhVeUttOVc4ejF3Q2VtTmw2M00xQVc4?=
 =?utf-8?B?S1E2OEcvUHFxNDVGR1RSM2dpMXVTTnp2V29vdzE4cGVBNlFiMzdrSjFUV21D?=
 =?utf-8?B?U09CVEZiSlFvMVR3VjYzL0hKNkJ3WjBSTXI5U1FycVgrMzRFYlNibDdMeFFC?=
 =?utf-8?B?REkzRC9UeHJNM0lVRmZhdVp2aHlsakR6OGZkQUdIWFN6S3F3c1FoTjR0QjdJ?=
 =?utf-8?Q?SjvhndLB1VOL3AbmZG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef25c33-c914-4fe2-56f6-08df197ed48e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 14:27:43.4636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3aIEzqsti/RS/UJyQOs1gqgoXHKfqdFWTwwanLyy6aUJsTLFWr6Tnl0705r0kRZf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7857
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

--------------7JjL3v4VvkczSJs20kQtS0eF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-09-22 09:54, Alex Deucher wrote:
> From: Likun Gao<Likun.Gao@amd.com>
>
> Add support for LSDMA v8
>
> Signed-off-by: Likun Gao<Likun.Gao@amd.com>
> Reviewed-by: Frank Min<Frank.Min@amd.com>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +
>   drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c       | 113 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h       |  31 +++++
>   4 files changed, 149 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 2ea1924571039..83e40f26ddf5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -92,7 +92,7 @@ amdgpu-y += \
>   	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o \
>   	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o hdp_v7_0.o nbif_v6_3_1.o \
>   	cyan_skillfish_reg_init.o soc_v1_0.o lsdma_v7_1.o nbio_v6_3_2.o nbio_v7_11_5.o \
> -	nbif_v7_10.o hdp_v8_0.o
> +	nbif_v7_10.o hdp_v8_0.o lsdma_v8_0.o
>   
>   # add DF block
>   amdgpu-y += \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 564f09c308816..202e0b80e5225 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -95,6 +95,7 @@
>   #include "lsdma_v6_0.h"
>   #include "lsdma_v7_0.h"
>   #include "lsdma_v7_1.h"
> +#include "lsdma_v8_0.h"
>   #include "vcn_v2_0.h"
>   #include "jpeg_v2_0.h"
>   #include "vcn_v3_0.h"
> @@ -3979,6 +3980,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(7, 1, 0):
>   		adev->lsdma.funcs = &lsdma_v7_1_funcs;
>   		break;
> +	case IP_VERSION(8, 0, 0):
> +		adev->lsdma.funcs = &lsdma_v8_0_funcs;
> +		break;
>   	default:
>   		break;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c b/drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c
> new file mode 100644
> index 0000000000000..f1dd02a56810b
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c
> @@ -0,0 +1,113 @@
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
> +#include <linux/delay.h>
> +#include "amdgpu.h"
> +#include "lsdma_v8_0.h"
> +#include "amdgpu_lsdma.h"
> +
> +#include "lsdma/lsdma_8_0_1_offset.h"
> +#include "lsdma/lsdma_8_0_1_sh_mask.h"
> +
> +static int lsdma_v8_0_wait_pio_status(struct amdgpu_device *adev)
> +{
> +	return amdgpu_lsdma_wait_for(adev, SOC15_REG_OFFSET(LSDMA, 0, regLSDMA_PIO_STATUS),
> +			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK,
> +			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK);
See lsdma_v7_1_wait_pio_status() as a reference: please check the LSDMA 
command error status instead of returning success with a silent error, 
and write 1 to clear the error status bit so LSDMA recovers for the next 
command.

Regards,
Philip
> +}
> +
> +static int lsdma_v8_0_copy_mem(struct amdgpu_device *adev,
> +			       uint64_t src_addr,
> +			       uint64_t dst_addr,
> +			       uint64_t size)
> +{
> +	int ret;
> +	uint32_t tmp;
> +
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_SRC_ADDR_LO, lower_32_bits(src_addr));
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_SRC_ADDR_HI, upper_32_bits(src_addr));
> +
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_LO, lower_32_bits(dst_addr));
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_HI, upper_32_bits(dst_addr));
> +
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CONTROL, 0x0);
> +
> +	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CMDPARAM);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_CMDPARAM, CMD_TYPE, 0);
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CMDPARAM, tmp);
> +
> +	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, BYTE_COUNT, size);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_LOCATION, 0);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_LOCATION, 0);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_ADDR_INC, 0);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_ADDR_INC, 0);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, OVERLAP_DISABLE, 0);
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND, tmp);
> +
> +	ret = lsdma_v8_0_wait_pio_status(adev);
> +	if (ret)
> +		dev_err(adev->dev, "LSDMA PIO failed to copy memory!\n");
> +
> +	return ret;
> +}
> +
> +static int lsdma_v8_0_fill_mem(struct amdgpu_device *adev,
> +			       uint64_t dst_addr,
> +			       uint32_t data,
> +			       uint64_t size)
> +{
> +	int ret;
> +	uint32_t tmp;
> +
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CONSTFILL_DATA, data);
> +
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_LO, lower_32_bits(dst_addr));
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_HI, upper_32_bits(dst_addr));
> +
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CONTROL, 0x0);
> +
> +	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CMDPARAM);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_CMDPARAM, CMD_TYPE, 1);
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CMDPARAM, tmp);
> +
> +	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, BYTE_COUNT, size);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_LOCATION, 0);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_LOCATION, 0);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_ADDR_INC, 0);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_ADDR_INC, 0);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, OVERLAP_DISABLE, 0);
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND, tmp);
> +
> +	ret = lsdma_v8_0_wait_pio_status(adev);
> +	if (ret)
> +		dev_err(adev->dev, "LSDMA PIO failed to fill memory!\n");
> +
> +	return ret;
> +}
> +
> +const struct amdgpu_lsdma_funcs lsdma_v8_0_funcs = {
> +	.copy_mem = lsdma_v8_0_copy_mem,
> +	.fill_mem = lsdma_v8_0_fill_mem,
> +};
> diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h b/drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h
> new file mode 100644
> index 0000000000000..648d5cc85c48e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h
> @@ -0,0 +1,31 @@
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
> +#ifndef __LSDMA_V8_0_H__
> +#define __LSDMA_V8_0_H__
> +
> +#include "soc15_common.h"
> +
> +extern const struct amdgpu_lsdma_funcs lsdma_v8_0_funcs;
> +
> +#endif /* __LSDMA_V8_0_H__ */

--------------7JjL3v4VvkczSJs20kQtS0eF
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-09-22 09:54, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260922135419.2145987-2-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">From: Likun Gao <a class="moz-txt-link-rfc2396E" href="mailto:Likun.Gao@amd.com">&lt;Likun.Gao@amd.com&gt;</a>

Add support for LSDMA v8

Signed-off-by: Likun Gao <a class="moz-txt-link-rfc2396E" href="mailto:Likun.Gao@amd.com">&lt;Likun.Gao@amd.com&gt;</a>
Reviewed-by: Frank Min<a class="moz-txt-link-rfc2396E" href="mailto:Frank.Min@amd.com">&lt;Frank.Min@amd.com&gt;</a>
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +
 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c       | 113 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h       |  31 +++++
 4 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 2ea1924571039..83e40f26ddf5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -92,7 +92,7 @@ amdgpu-y += \
 	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o \
 	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o hdp_v7_0.o nbif_v6_3_1.o \
 	cyan_skillfish_reg_init.o soc_v1_0.o lsdma_v7_1.o nbio_v6_3_2.o nbio_v7_11_5.o \
-	nbif_v7_10.o hdp_v8_0.o
+	nbif_v7_10.o hdp_v8_0.o lsdma_v8_0.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 564f09c308816..202e0b80e5225 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -95,6 +95,7 @@
 #include &quot;lsdma_v6_0.h&quot;
 #include &quot;lsdma_v7_0.h&quot;
 #include &quot;lsdma_v7_1.h&quot;
+#include &quot;lsdma_v8_0.h&quot;
 #include &quot;vcn_v2_0.h&quot;
 #include &quot;jpeg_v2_0.h&quot;
 #include &quot;vcn_v3_0.h&quot;
@@ -3979,6 +3980,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(7, 1, 0):
 		adev-&gt;lsdma.funcs = &amp;lsdma_v7_1_funcs;
 		break;
+	case IP_VERSION(8, 0, 0):
+		adev-&gt;lsdma.funcs = &amp;lsdma_v8_0_funcs;
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c b/drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c
new file mode 100644
index 0000000000000..f1dd02a56810b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c
@@ -0,0 +1,113 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the &quot;Software&quot;),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include &lt;linux/delay.h&gt;
+#include &quot;amdgpu.h&quot;
+#include &quot;lsdma_v8_0.h&quot;
+#include &quot;amdgpu_lsdma.h&quot;
+
+#include &quot;lsdma/lsdma_8_0_1_offset.h&quot;
+#include &quot;lsdma/lsdma_8_0_1_sh_mask.h&quot;
+
+static int lsdma_v8_0_wait_pio_status(struct amdgpu_device *adev)
+{
+	return amdgpu_lsdma_wait_for(adev, SOC15_REG_OFFSET(LSDMA, 0, regLSDMA_PIO_STATUS),
+			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK,
+			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK);</pre>
    </blockquote>
    See lsdma_v7_1_wait_pio_status() as a reference: please check the
    LSDMA command error status instead of returning success with a
    silent error, and write 1 to clear the error status bit so LSDMA
    recovers for the next command.<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:20260922135419.2145987-2-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">
+}
+
+static int lsdma_v8_0_copy_mem(struct amdgpu_device *adev,
+			       uint64_t src_addr,
+			       uint64_t dst_addr,
+			       uint64_t size)
+{
+	int ret;
+	uint32_t tmp;
+
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_SRC_ADDR_LO, lower_32_bits(src_addr));
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_SRC_ADDR_HI, upper_32_bits(src_addr));
+
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_LO, lower_32_bits(dst_addr));
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_HI, upper_32_bits(dst_addr));
+
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CONTROL, 0x0);
+
+	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CMDPARAM);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_CMDPARAM, CMD_TYPE, 0);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CMDPARAM, tmp);
+
+	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, BYTE_COUNT, size);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_LOCATION, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_LOCATION, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_ADDR_INC, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_ADDR_INC, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, OVERLAP_DISABLE, 0);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND, tmp);
+
+	ret = lsdma_v8_0_wait_pio_status(adev);
+	if (ret)
+		dev_err(adev-&gt;dev, &quot;LSDMA PIO failed to copy memory!\n&quot;);
+
+	return ret;
+}
+
+static int lsdma_v8_0_fill_mem(struct amdgpu_device *adev,
+			       uint64_t dst_addr,
+			       uint32_t data,
+			       uint64_t size)
+{
+	int ret;
+	uint32_t tmp;
+
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CONSTFILL_DATA, data);
+
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_LO, lower_32_bits(dst_addr));
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_HI, upper_32_bits(dst_addr));
+
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CONTROL, 0x0);
+
+	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CMDPARAM);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_CMDPARAM, CMD_TYPE, 1);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CMDPARAM, tmp);
+
+	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, BYTE_COUNT, size);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_LOCATION, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_LOCATION, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_ADDR_INC, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_ADDR_INC, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, OVERLAP_DISABLE, 0);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND, tmp);
+
+	ret = lsdma_v8_0_wait_pio_status(adev);
+	if (ret)
+		dev_err(adev-&gt;dev, &quot;LSDMA PIO failed to fill memory!\n&quot;);
+
+	return ret;
+}
+
+const struct amdgpu_lsdma_funcs lsdma_v8_0_funcs = {
+	.copy_mem = lsdma_v8_0_copy_mem,
+	.fill_mem = lsdma_v8_0_fill_mem,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h b/drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h
new file mode 100644
index 0000000000000..648d5cc85c48e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the &quot;Software&quot;),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __LSDMA_V8_0_H__
+#define __LSDMA_V8_0_H__
+
+#include &quot;soc15_common.h&quot;
+
+extern const struct amdgpu_lsdma_funcs lsdma_v8_0_funcs;
+
+#endif /* __LSDMA_V8_0_H__ */
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------7JjL3v4VvkczSJs20kQtS0eF--
