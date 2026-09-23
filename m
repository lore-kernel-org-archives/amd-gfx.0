Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BDAC98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 18:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59AF910E13F;
	Wed, 23 Sep 2026 18:31:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y8wOJtEk";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011031.outbound.protection.outlook.com [52.101.57.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66C5110E13F
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 18:31:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhjZbQRJ5QqpoHr4RQ1O/dF1Xwwh3OZwOj8nZTCMe3nJHokWuHrajoHkOagu4bVmRNmEO8fgMCJFOF7ZIg6zTB0ps8Tdz/4opbUru4fxUr1rUhZSg3K/aw5DKsoQtfJ8gAKjed5/ta5EvAE0JiYn27bJ0GO8Id/j3QALpQcX0/+CL10ouiIeiH/pG62xu05zpnvFyAmyVSDfzluYV5KJB1uWLz3niS8mC1wabw/uPyI7yo2+0NFpY2bT8yPEBkaAxHUw8CpVerw9ErDmMVZvSsEw1iLg1gxe6jnNTBhYiaxs42MXXbp+A0Jr4xvr3MCHSnPVJ+XmXwzj3dR3MpMrzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YbkagNmnbH+yDfnOiwFAgguzwJxS36L4VqvZ2rA2Q4=;
 b=YwEendOdSB9RhMsYUb14r/IZszRZ7XurQGS+0bSfiQgAI/yrVPgRpVbIoWgx+8a3WszCVX2msNPkeJL8tHsehgT4b4jIjID3zs1wFwPpaY/1qlFF6xQYLMkOEVAnMqjR5dGfdpCKd2m28wcVlJHqVYThj6zR6Y51WgOcfltfaRawHwFOFPatQEXions4z64Jl1telpQewowwlcU5E5OqL7DJtP+tiRLoO+q8Nfdil+5BNdvjjoDzIjTBSm+LgT+hxwmLosd48aqNHUBpnqE+pA81zIGKYZaGqmIpFTcn11Q6SbbutX6pflNKv+WlJ316G2qaSSOt+CT0KsCJe9KJ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YbkagNmnbH+yDfnOiwFAgguzwJxS36L4VqvZ2rA2Q4=;
 b=Y8wOJtEknvxNEKzfrYeM0hmREmRnrjM+VkJmo4yxkAw7dE50CsXlKAtJ2pWCVanBLVAniu5nFYK3K2BhkOJG2c5URQLsUvBXug5jLIK+uidj36cfV3zT0pg7Vl8UGx/YRZEnDNj1nl+Sbt2hVM9WWjtyMsIRAT5wD8iqRNc3tC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Wed, 23 Sep
 2026 18:30:55 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 18:30:54 +0000
Content-Type: multipart/alternative;
 boundary="------------PA3xU9vSu30IsrgJNPdScb0k"
Message-ID: <b67c667c-519a-48a5-a1ac-df9363eefab9@amd.com>
Date: Wed, 23 Sep 2026 14:30:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: add support for lsdma v8
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Likun Gao <Likun.Gao@amd.com>, Frank Min <Frank.Min@amd.com>
References: <20260923153303.2807340-1-alexander.deucher@amd.com>
 <20260923153303.2807340-2-alexander.deucher@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20260923153303.2807340-2-alexander.deucher@amd.com>
X-ClientProxiedBy: YT4PR01CA0429.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::19) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|CH2PR12MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: 9460360e-8066-4ba4-b93e-08df19a0cca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|3023799007|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: +jFIquOYhxkN0me07n/2vbGVZWDSvUtq0lj2sAreS5Z4yQeUdScjw2/W9BF/8Q5muagCncScJz5UEnYVjWJzDLIfXaWyRGluFDY2yt/lvj42rF+WMVNzjEpkDNcXoZQAII8WdCYqRLhf+sVF67MkhBMFfIKADYvfyIMkGbGzth48kayGq3C6nQHdUCmDSfDHThOX7UXQT+12uJMCiatEF/mp2r5/QI05QtLoFxF/5m8ra6R4OG/iV6V+a0K8z5j1m0HU8oW4BffDyxDCswC8cKhhNrmHWFpLr+22o87F8W9i7pIgCZghuKwPYTu0efYK24dai/O2dnp1RiJSxBxHyKi7bt/bYMZSfQUZ2TKlOgajhNwmPOtvONnjx+ABk9vSjCQ8t85rCJh/SEiW+t2lSUgNOOiu6lncoI5z9H6SbUIeiHS7xOdIM8jZyn6ASyvRX7sY68nA9s0gV7HQfRPFhs50ppILhedBLi7pA/j7ciHgNHnddUUD2Q9rAXlh2AVznL9elEMHnkJ69ilbJObKwQo1oKjZV9oFFQP37FHvDNrq6yf8YYN+w4ztm5SsqNJGIurHIfczcjuLt5YvmH1W+tjbwkFnjicRLn9Ce0UN/g2d8VFFXzESpcO4wj/Gz8QuF11kvN0EYcduKHSdrBtBImh5SLU/nv7srd3TcRtjVz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(3023799007)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTczUnR1U3FNNnVLUmQ0VnBqWFBTYjg5V1FlWFR0M0d1U0RFRjd4VTFVL0g1?=
 =?utf-8?B?blJTNWI1aVNNcitQaWVoVTRZWGRMcVg4eWtIb1FQZURFbWVNdlIyODZVdVFn?=
 =?utf-8?B?eUZhaFRrRzZ1YnpSMUUwRUJ0bkQ1ZVV4VmpoOVg4UjIreHVEYndyZ3FsMER3?=
 =?utf-8?B?NFJTTmxxaWNVd3NwbUJmcGVDK3NJc2F3YTlhNjVxWEJhSmdPTEdsdU5CTXAv?=
 =?utf-8?B?cmtQMTdCTDR4MlRMeHhYOThINkJQWDRIVE5iOFRvbEEyUTlPNTZhYnNLclhn?=
 =?utf-8?B?bHB3a1RNbFl4Nm5ldytYNVQzR01pQVpNNldQdUs4T0dwZmxhS2JSTEg1amVG?=
 =?utf-8?B?MndyTUYxbVpDU0hGVkd0b2ZjMFk3cXdDamprZElNb1lYMEVvcE9ybjExaUp1?=
 =?utf-8?B?dlR5WjgrQnlpdnJMWkRTS2JwZXk1bGtKRzFDY0lXaHVLUGYwTlQ4MHlMRHpK?=
 =?utf-8?B?S1l2SWgvYjJ4TlZ1bDBDNzRkSFVCV3hRTFdGUnJpa0N6REVDY1hnbTBkM24v?=
 =?utf-8?B?RGpYOGllWjZzQkxXWVEzRyswY2ZSVHJKMERkWllHZlg4SFhtN0U3MkpiVjI5?=
 =?utf-8?B?dDIxYXN4TExmYTJzSE5LWVVxZVFLeXlpRXQxU0owdkJSaVBLdlRLZ1BHeU1u?=
 =?utf-8?B?WCtQVGd0L1NBc2pETWRyUUh3cS9xbUYxTVErSlFBUGVlaXZMMzFlSDJTcy9U?=
 =?utf-8?B?Lzc5S1AxWTllWERqbVUyVEtoQWl0RG9XM0Rmd2YrcEVIdlNESGpwc3VkNXFh?=
 =?utf-8?B?QnVCbFhidzZRRFYxZ3pNWWRZV0QvTXkxeTU2NzlGV1FSWW9iUXc5cWhhbWtI?=
 =?utf-8?B?U2NtNmhaTkx6NDNDS0pVSXBZRFNrTEMxcUlWZllzTCtMWitvOHlpMzJoN205?=
 =?utf-8?B?QVVNQnpEd0REcFBjWVJBOXQwelZJdG9mZ1JvZjBpVUltQmp4R1FKRVBBRHdK?=
 =?utf-8?B?Y0FyYlJBUVZubXhYUDU5Z1Q5RVprUi9jcWVFWlQxaXFmc2g5VEVjRmtMMnhL?=
 =?utf-8?B?VnBOWGh1b2Jwakx0SW1IZmszQ0JPaE1XaTh3SGxBM2ZLQzdaa3VuL1JqMWRY?=
 =?utf-8?B?Y2o5ZCthQ1ZkV2pjZm9RNzBKVmowRDZhZ3JMTnl3c2xpdC83UEpSVHJJV09T?=
 =?utf-8?B?dFlQWTRDaHgzck9mQlpTT25nNlJFVFNvZDZzb2QrRnBmM01uQXJqbHpLWkNq?=
 =?utf-8?B?cms1bk5Wc2thVy91cDF3VXRHbHdDM3ZmWG5OQlNkNVhFRks3U3hUMnNsZmRC?=
 =?utf-8?B?OFpGTkZnUHdiNTdQczR4VytreFNqMVJkbzBoaGZVWVJiWUl2U0xFSVd6ajht?=
 =?utf-8?B?V3FNUTRUbFE5NGpDdlRqRWNoOUZCbEpadEpQM0lZNm5ORjg1TVg0QmYycDVB?=
 =?utf-8?B?WWVCcWRDNmduVWwrWityc2RLMmVaTGVMVzNNa1ZNZHZBdEFETkJUMFNGZU1r?=
 =?utf-8?B?Nytxd09HelljM1MxSFYwWk5GZzNONzB1SHJ5ZWZXVGNpTXRkV3QxMXVRaElC?=
 =?utf-8?B?bmp3OFBvZUN0Uk85a3plV3BmbEo2TTBEczdoQWtWQTJ6L2hkYUlhZDhzU0xI?=
 =?utf-8?B?UDd2ekxwT0I0ajNLWlF2RWltZ2VsdGhnV2VxK2hsd0JZQjFJcGpFZ2x5WHZT?=
 =?utf-8?B?VEdDWUk3aVIzNFdPWFJuSUFrTTVDM2xOUFk3dFFaOW9WK3FLS3VkNVZnSk1m?=
 =?utf-8?B?Uk9EeVZtU0xFcjdkRnlZK1dsSnBweTJPT3UvNFZqZ1Y1U283N05Ed3lVR3ZL?=
 =?utf-8?B?QUV6UUwxa1l1OW9kRDNEWmc1MDVKWlRiS3NrbFZvRW81TTF2Uk9VZTRVbUVT?=
 =?utf-8?B?QUtFZjgxZi84U1cxSjF4OUdTQjQzR2llM1J5NFpZNnhKMGo2RGRLczR1OHlp?=
 =?utf-8?B?U2hvMktkenFHSUhSQVhqYUtQZU56SDhZRkVXNVhjZnBsRGxPMGN0Nkxub0JM?=
 =?utf-8?B?YTMzRGJuMGpjSkpYck5EbTQ1ZEVXZitjR1d3WFdVUG84ZlF3Y0hGZzBhR1M1?=
 =?utf-8?B?S3o3MGN0bVpib2N5b0pOQ2gwQkt4NXlpS1NLSWdZYyt1VC9veVpNdXlUbm5Y?=
 =?utf-8?B?Y0JHWHNkQ3pTSG1tVFJOcmFQN2E3MXlBcGQ5VVZCd0dTcHc4cjRNUzB4WlFX?=
 =?utf-8?B?TkswTzJPSlN6OEQrRTM2VGNPdG5aRGdlOTZWaFdObGFXOVhyK28wUVpWTHFt?=
 =?utf-8?B?UXVxUDZXcUJsem5XTmYxUUZma2ovZEExWUVKV09iQ0hIbUZpZk9vRUVITkN6?=
 =?utf-8?B?cmY4VFdPWjRuNkJ0L2tNd1JEaE00d1I1N1B3UEN6bTFScHJjeTlWcUc3VWY5?=
 =?utf-8?Q?SZC9RFEFbpZABO5dJq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9460360e-8066-4ba4-b93e-08df19a0cca3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:30:54.4165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSwDiP6KYpu5lDk+ouV39I7SVSWk1j06GDKZsMut9ti+ZptZUWrDUZQFxi8Anf7G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280
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

--------------PA3xU9vSu30IsrgJNPdScb0k
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-09-23 11:33, Alex Deucher wrote:
> From: Likun Gao<Likun.Gao@amd.com>
>
> Add support for LSDMA v8
>
> v2: fix wait_pio_status() per Philip's comments.
>
> Signed-off-by: Likun Gao<Likun.Gao@amd.com>
> Reviewed-by: Frank Min<Frank.Min@amd.com>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
Reviewed-by: Philip Yang <philip.yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +
>   drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c       | 138 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h       |  31 ++++
>   4 files changed, 174 insertions(+), 1 deletion(-)
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
> index 0000000000000..d19d7f8add50e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c
> @@ -0,0 +1,138 @@
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
> +	u32 error_mask;
> +	u32 reg;
> +	int r;
> +
> +	r = amdgpu_lsdma_wait_for(adev, SOC15_REG_OFFSET(LSDMA, 0, regLSDMA_PIO_STATUS),
> +			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK,
> +			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK);
> +	if (r)
> +		return r;
> +
> +	error_mask = LSDMA_PIO_STATUS__ERROR_WRRET_NACK_GEN_ERR_MASK |
> +		     LSDMA_PIO_STATUS__ERROR_RDRET_NACK_GEN_ERR_MASK |
> +		     LSDMA_PIO_STATUS__ERROR_INVALID_ADDR_MASK |
> +		     LSDMA_PIO_STATUS__ERROR_ZERO_COUNT_MASK |
> +		     LSDMA_PIO_STATUS__ERROR_DRAM_ECC_MASK;
> +
> +	reg = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_STATUS);
> +	if (reg & error_mask) {
> +		dev_warn(adev->dev, "LSDMA PIO error status bits 0x%x\n", reg & error_mask);
> +
> +		/*
> +		 * write 1 to clear only the set lsdma error status bits
> +		 */
> +		WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_STATUS, reg & error_mask);
> +		return -EIO;
> +	}
> +
> +	return 0;
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

--------------PA3xU9vSu30IsrgJNPdScb0k
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-09-23 11:33, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260923153303.2807340-2-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">From: Likun Gao <a class="moz-txt-link-rfc2396E" href="mailto:Likun.Gao@amd.com">&lt;Likun.Gao@amd.com&gt;</a>

Add support for LSDMA v8

v2: fix wait_pio_status() per Philip's comments.

Signed-off-by: Likun Gao <a class="moz-txt-link-rfc2396E" href="mailto:Likun.Gao@amd.com">&lt;Likun.Gao@amd.com&gt;</a>
Reviewed-by: Frank Min<a class="moz-txt-link-rfc2396E" href="mailto:Frank.Min@amd.com">&lt;Frank.Min@amd.com&gt;</a>
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a>
    <blockquote type="cite" cite="mid:20260923153303.2807340-2-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +
 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c       | 138 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h       |  31 ++++
 4 files changed, 174 insertions(+), 1 deletion(-)
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
index 0000000000000..d19d7f8add50e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c
@@ -0,0 +1,138 @@
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
+	u32 error_mask;
+	u32 reg;
+	int r;
+
+	r = amdgpu_lsdma_wait_for(adev, SOC15_REG_OFFSET(LSDMA, 0, regLSDMA_PIO_STATUS),
+			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK,
+			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK);
+	if (r)
+		return r;
+
+	error_mask = LSDMA_PIO_STATUS__ERROR_WRRET_NACK_GEN_ERR_MASK |
+		     LSDMA_PIO_STATUS__ERROR_RDRET_NACK_GEN_ERR_MASK |
+		     LSDMA_PIO_STATUS__ERROR_INVALID_ADDR_MASK |
+		     LSDMA_PIO_STATUS__ERROR_ZERO_COUNT_MASK |
+		     LSDMA_PIO_STATUS__ERROR_DRAM_ECC_MASK;
+
+	reg = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_STATUS);
+	if (reg &amp; error_mask) {
+		dev_warn(adev-&gt;dev, &quot;LSDMA PIO error status bits 0x%x\n&quot;, reg &amp; error_mask);
+
+		/*
+		 * write 1 to clear only the set lsdma error status bits
+		 */
+		WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_STATUS, reg &amp; error_mask);
+		return -EIO;
+	}
+
+	return 0;
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

--------------PA3xU9vSu30IsrgJNPdScb0k--
