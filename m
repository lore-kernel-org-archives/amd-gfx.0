Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF7A109E546
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 04:37:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A12C10E94C;
	Thu, 26 Mar 2026 04:37:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4bW8bBYB";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013054.outbound.protection.outlook.com
 [40.107.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE83B10E8FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 04:37:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMH9GQuo6IaDHe71TSIlfwHHga0saZygIfvY305Lu7O14JDDsCe4BL9RIri2bGWNXuw04n+xgU2d7gnnTnmf6vpe0VCKmhCkOk0U0Z/4EyP1UkXjyCrVT69eMgt+DpBbnanKI+mqqsFH0Y4flh/OViNLnhrkzLE5R7q1xJjv1G3xw45T+F4TWBrkPIJRTtD9rKccJYjI6u/wY48fMg0Ia9wtyWrbCm0ZuTza6d2bdQRoGDjobRBqepuqOhcGkRDF9f1LIJR4ZLBLtEN0YWFzerFPj3UcoRXIKvT9o/+fL25cKEBOzPHx2xFZZjHtc1zTqDlhg6D29ixDaC7uUnhLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CTn7v1JjdHHKOxgpno2s/pG0ITQCqapjzKaENgA2iY=;
 b=mAItUO2T8A8Td/3pTgeg37rQIidNreqVP3OTmyq5wuG+Twr4p88Jkj29yJASg0whrUmiTMKjrqjujiWBNvD2pz57MlygfcYJEd/9R1VJyKMqalV3ZMTdeNKndboeTNgJHgHxnSjUb/CdnKJVaNV391e/5BX1fKCsUoblrVd5L0pZPOHqrtqckvlRLFLp7vyeaFJfLqFioHZGJHcHX+nW9xZ1Px053qcJ4ejt4ea1FO/ZnhhtIrcowmqj9W0h64Ni8S7mygFYoaBeZSo+jcI1ku/BVxnREeHuwVZ1fBf7cvdNwiRTltH6n8wZZ+0srAEWQYOYRw2UXZKs5SAcz8p2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CTn7v1JjdHHKOxgpno2s/pG0ITQCqapjzKaENgA2iY=;
 b=4bW8bBYB6cQqQztF2h7NNe80ODPQiul6/FRIdlIUgP3/7vuGlHHlLowH6esOnHIhUZMkcb4Y8OMB6rcUmllFoY19PLP70pTfRlQ/JayS4BnIBkzULShBBOeka1Io7UGX/oD2QDPLTEcN+L/TES2AcUpLP0xWS6xz7UKOdW4/m2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Thu, 26 Mar
 2026 04:37:07 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 04:37:07 +0000
Message-ID: <a35ca9d5-354f-4b98-a186-3a4797176b55@amd.com>
Date: Thu, 26 Mar 2026 10:07:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: correct mem_busy_percent display due to
 calculation errors
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
References: <20260326020445.1187519-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260326020445.1187519-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA4PR12MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: feea7e1b-c2b9-4352-3294-08de8af155df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: OrDgDkBdMkeBOkiTz81/yToO6zaceqse6nhZWUSwc5s/7J7iZ+vMewVYVSzDaJSB0Treu1aQqIZZA3imDNNdo+C6AcykINREAAJHZXzIs2Vso2UydURhT3Du6ovgy4aR20LrVlXLHQDNdD9flQfqFgUjwV3vi3qV5IbK7c1Gnv7kJRMqrHqRqnIFY8b7Ad1bWSxOdkDOCwgv+VtRnowtXAlLAEGQ2O9BGmuuzAGdKGu4jEEHtyr68n8WXwhVa+bF0wk6K56C3Vf9kOCv3mM2tOS1StEg9Ry26tO0DztPkdfsgAOIZBKdcMKCpj7u3DqFKafvIchOMWL9bJxzlVtC3J7VwV67m9Pok4Z9GpBx8gWXGT+GD7otUNcvp4ej1PUzVyXhrHX28+wNwN56w+hbGl+zh0/e6T+I3n+vh8CyEGP4b/YtEkyMK83U4ra2yRyn/KMzqhVdRYWrY5EELoNyyCxbBbk6TsJrWjDgcb3CGlg0D0FxeUjkIIPc9cM9cnjDOVfZJDSGfrnWgUFP02GpuZSiGWRuwT8U07Eey3xQE2dcIkqSCuffnwJyn8R+eFHaaq65eaXXnMbmtrj+5WGy6xgzOiKcNqLKX0zhZqmTHjktC9iFTSkrqeFq+Vgbohs20ezhTtFgLE7GNRl/mY8QGcWukITOJ4rc/VEDqWCpztHbBx5SXiN6jzjF8KjEXoi4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEtESnJFaUlteCtTYTV1WElmbVVuOE1BZ1dLMVllUS9VbmF4ZW5rcUdIK1VW?=
 =?utf-8?B?UEdhaTBhOWJ1VmlCSHJWOEUvKzNMdXNXcEVBc2hQVmxsRzdOTDM4L3NPZFl4?=
 =?utf-8?B?aFRFSVRBQlpVcC9PY0RMakFBb2RLajhxYVBCN2ZEN1E5MFo3ancraXF0b3R1?=
 =?utf-8?B?MEhDaFM5dDVwa01Zc2k2NDh3YVJKSDQzWHZ1UEVxK2o3Wk1oeUF4NFFuSWx5?=
 =?utf-8?B?aFR4YTEwbU4rRWs5ZmNOQUIxeXFKNElKVVpGZ25rQnZiU0VnVTZOcUl2S254?=
 =?utf-8?B?RDlEZWhxNzNxL1EwRjliWG0ySytWeWxhQWR5alRIb1BpN3IxSi9BQktmVlk3?=
 =?utf-8?B?c1JGTDdJaE85UDlaTHEvT3JZTWRuQ1VhRXJVUEdwdVdFOTZZcDdHcUJ5a29m?=
 =?utf-8?B?UlhsMUcyaVpOdkQrNTNqZmlseDVmL2FBbkJuWFQwRm9QUEZKOXo5bitPYUlW?=
 =?utf-8?B?VDF5N0k3VjNjUzlXb1FvU3Ewa1lKMFRuM1FNY21iQXFrTjRzK3RiTW1tWDBX?=
 =?utf-8?B?YTNkSVdObkdtSnMyUUxNQm9oRWZWbUtNUlZvNWM2SDQwY3lCZTVldXcxK2RF?=
 =?utf-8?B?RlE3WTNqN2hMQ1BTTkkvZWR0a1R4VVdsZWF4U09YOWVranU3czIwWGt2dTJ2?=
 =?utf-8?B?ZVcxNjJLU0VLQ0FtU3NBeUR6R09rWDhjSVF1clVHNGlRYjNyK3JxOVhYMFRD?=
 =?utf-8?B?MkpGZlpuT2pzZVBhWjVBVGZOMEVjZTk4KzBlQ0tlWmRkVDBQZEgzTnJqLzg5?=
 =?utf-8?B?RExsUE4wNTNKUzF2ZmlzWnF4T1ZBQ2hDRWZHK3pVNVVkckxkWTZqMUVPTW9q?=
 =?utf-8?B?ZFdwZVlIbnErN3ljMGdkRk85elgvYkI1MlFwRDU3Y0VsUm5qaks1azUyRkpY?=
 =?utf-8?B?MmRaNzErc3VjN3BaeE1NeGFzVE9aVUJocWRHT2RtRGR0Z1BwZFNqZnBTa2o5?=
 =?utf-8?B?eUFVMmgzazQwRXdlZmowMTl5T1NwdXgxa3pNSzkrRmNnSFhENENsTGdIdGNm?=
 =?utf-8?B?aFFOeHhTeFNTR2FFTE1wV2k2SnpKaTBNbTFpV25OZGo2N2NLWmp4SEF6Q1Ra?=
 =?utf-8?B?TkJHb0taanUybk5IenRLY0k2aFZycGFtTEhpeTM1b0M3VTQwMUl4WG9wSlQ4?=
 =?utf-8?B?ZDNCRXk1eXBUUzYwWncxRXYrSFc3anRXTkNrR0owMkNUSHJFdVVRWWlvLzNI?=
 =?utf-8?B?V093MHNJampWTUNTRnpaYVFDcUFCZUhJSnF4dHo4OVQ0d1owMCtwZWZwK0hk?=
 =?utf-8?B?SGw5bnQ4UUR0QmZHWW9MSmZaQmhzR3l2eXBpalRRVEhFd2pqdzlHdi9CY2c5?=
 =?utf-8?B?dU8raVFMeVIwVmY3NUxXOHVVRkdOQi83U1UrOTBFLzFTR1lPNlI4SllESHVS?=
 =?utf-8?B?dVFONEIyT2xNTlNqejNieEplNW1CT2Jad1JQTDJuYThoMnJpdHM4Y0o4dk5R?=
 =?utf-8?B?dW9Makt1ZWNVRjBLeitTajVMT2NuZ3g2ZlI4TTYrcUpPTnBkRG1URmZxNU9E?=
 =?utf-8?B?eHlTWE1WS1RBcWNiZ01GeEZYNER3TjRUM2dra0NXMEpsa0lya1N4MXJIVDFW?=
 =?utf-8?B?TnZLUnExblNsdi9kdDllOU9tQWpWZlU0TVh0dmJzUzRYRzg3Qml2Vmh0S2xG?=
 =?utf-8?B?N25pQjF6NklKd0htZ0VwWExpSkFTOUZYV3Q1RDlLazBUMEg5ZFY5VUlKb1BM?=
 =?utf-8?B?Y1BjNWNaR042V093YkR6eXRzdDV2S1l3aTJ3ZmQ3Tk5OZE5SUmxRWiswWVd3?=
 =?utf-8?B?WDA5TXEvOFdLRlBUQlBFbVBXMjFkY3htMkpEU3ZSYXhaWWFHdmVDaGoyZFRL?=
 =?utf-8?B?TUVmSFlFWmM3UUYvTVM1SEhQeTNxUXBXbDRBVTRGY0VFci9PS2VaWXBycDBq?=
 =?utf-8?B?cWpjZk5VZGU3NWtTSEl3WWhQSS9XdE9jYzNTMzRxMEo2TEp5YXFWZmZneWtx?=
 =?utf-8?B?QjVGNEE3eWFKTlhWK1RwZVdTUktOM05CMm1ZNS9hRUttekhHU1V2d2x3N1Zz?=
 =?utf-8?B?WHYrZGUzMmErNFF0SnA5SnNXbldvM2pqN2JmT21VWTR4Y0t6RjFSbDk2QUpj?=
 =?utf-8?B?a3VnK1RtajEwZHMzUjljdSs2T3VsV2ZYY2lTcFZaVnJBeVF5L2JoeW9mSDRS?=
 =?utf-8?B?clVYZFpGSCtxOE1GM05HSFF5MTAwTy94dWUvZ05uSGtTNHZ5ekRtTGpRQUFN?=
 =?utf-8?B?VkdoY09qWjlqcXNDcG1WRFd1dmhGZ0F3VGUveSs4VGZXK1NUYkhML1pCRXdy?=
 =?utf-8?B?dlo1bHZxSkFONHM0YlZ6aklObXMxYzhmTjk2dGNxcXdBWkdxZVZmTnE2S0tS?=
 =?utf-8?B?VFBCOTFWdXpxWDhUeWVTc0VaZU5sYnR4OUVKeVEyU0RZdmhlczFBdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feea7e1b-c2b9-4352-3294-08de8af155df
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 04:37:06.9773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zrUDRBee45jvKCjLJD6uC7tLSS5w/fVMt4XblIdQ7KA+WUYtqq2njYtY3eaEKlQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9788
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



On 26-Mar-26 7:34 AM, Yang Wang wrote:
> PMFW may return invalid values due to internal calculation errors.
> so, the kmd driver must validate and sanitize the returned values to
> prevent issues caused by firmware calculation errors.
> 
> For example, values 0xfffe (-2) and 0xffff (-1) are treated
> as invalid and clamped to 0.
> 

The problem with clamping is that the issue takes a different direction 
after that.

Presently, the issue is reported as garbage values reported in activity. 
With clamping, the issue could get reported as 100% activity with light 
load or 0% activity with a heavy load. That will take the debug in a 
different direction.

Instead, isn't it better to keep this as some errata and let user apps 
filter out garbage values? The previous or next sample could reflect the 
activity correctly. Later fix can be added to newer firmware, if that is 
an option.

Thanks,
Lijo


> this applies to devices with CAB (Cache As Buffer) functionality.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4905
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h   | 17 +++++++++++++++++
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 10 +++++-----
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c    | 10 +++++-----
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c    | 10 +++++-----
>   4 files changed, 32 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 609f5ab07d8a..365946c43e11 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -2164,4 +2164,21 @@ static inline void smu_feature_init(struct smu_context *smu, int feature_num)
>   	smu_feature_list_clear_all(smu, SMU_FEATURE_LIST_ALLOWED);
>   }
>   
> +/*
> + * smu_safe_u16_nn - Make u16 safe by filtering negative overflow errors
> + * @val: Input u16 value, may contain invalid negative overflows
> + *
> + * Convert u16 to non-negative value. Cast to s16 to detect negative values
> + * caused by calculation errors. Return 0 for negative errors, return
> + * original value if valid.
> + *
> + * Return: Valid u16 value or 0
> + */
> +static inline u16 smu_safe_u16_nn(u16 val)
> +{
> +    s16 tmp = (s16)val;
> +
> +    return tmp < 0 ? 0 : val;
> +}
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 9be7a2af560d..16f69b548ca4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -774,13 +774,13 @@ static int smu_v13_0_0_get_smu_metrics_data(struct smu_context *smu,
>   			*value = metrics->AverageGfxclkFrequencyPreDs;
>   		break;
>   	case METRICS_AVERAGE_FCLK:
> -		if (metrics->AverageUclkActivity <= SMU_13_0_0_BUSY_THRESHOLD)
> +		if (smu_safe_u16_nn(metrics->AverageUclkActivity) <= SMU_13_0_0_BUSY_THRESHOLD)
>   			*value = metrics->AverageFclkFrequencyPostDs;
>   		else
>   			*value = metrics->AverageFclkFrequencyPreDs;
>   		break;
>   	case METRICS_AVERAGE_UCLK:
> -		if (metrics->AverageUclkActivity <= SMU_13_0_0_BUSY_THRESHOLD)
> +		if (smu_safe_u16_nn(metrics->AverageUclkActivity) <= SMU_13_0_0_BUSY_THRESHOLD)
>   			*value = metrics->AverageMemclkFrequencyPostDs;
>   		else
>   			*value = metrics->AverageMemclkFrequencyPreDs;
> @@ -801,7 +801,7 @@ static int smu_v13_0_0_get_smu_metrics_data(struct smu_context *smu,
>   		*value = metrics->AverageGfxActivity;
>   		break;
>   	case METRICS_AVERAGE_MEMACTIVITY:
> -		*value = metrics->AverageUclkActivity;
> +		*value = smu_safe_u16_nn(metrics->AverageUclkActivity);
>   		break;
>   	case METRICS_AVERAGE_VCNACTIVITY:
>   		*value = max(metrics->Vcn0ActivityPercentage,
> @@ -2086,7 +2086,7 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
>   					     metrics->AvgTemperature[TEMP_VR_MEM1]);
>   
>   	gpu_metrics->average_gfx_activity = metrics->AverageGfxActivity;
> -	gpu_metrics->average_umc_activity = metrics->AverageUclkActivity;
> +	gpu_metrics->average_umc_activity = smu_safe_u16_nn(metrics->AverageUclkActivity);
>   	gpu_metrics->average_mm_activity = max(metrics->Vcn0ActivityPercentage,
>   					       metrics->Vcn1ActivityPercentage);
>   
> @@ -2103,7 +2103,7 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
>   	else
>   		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPreDs;
>   
> -	if (metrics->AverageUclkActivity <= SMU_13_0_0_BUSY_THRESHOLD)
> +	if (smu_safe_u16_nn(metrics->AverageUclkActivity) <= SMU_13_0_0_BUSY_THRESHOLD)
>   		gpu_metrics->average_uclk_frequency = metrics->AverageMemclkFrequencyPostDs;
>   	else
>   		gpu_metrics->average_uclk_frequency = metrics->AverageMemclkFrequencyPreDs;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 5cc15545da6e..34a5973b9a06 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -784,13 +784,13 @@ static int smu_v13_0_7_get_smu_metrics_data(struct smu_context *smu,
>   		*value = metrics->AverageGfxclkFrequencyPreDs;
>   		break;
>   	case METRICS_AVERAGE_FCLK:
> -		if (metrics->AverageUclkActivity <= SMU_13_0_7_BUSY_THRESHOLD)
> +		if (smu_safe_u16_nn(metrics->AverageUclkActivity) <= SMU_13_0_7_BUSY_THRESHOLD)
>   			*value = metrics->AverageFclkFrequencyPostDs;
>   		else
>   			*value = metrics->AverageFclkFrequencyPreDs;
>   		break;
>   	case METRICS_AVERAGE_UCLK:
> -		if (metrics->AverageUclkActivity <= SMU_13_0_7_BUSY_THRESHOLD)
> +		if (smu_safe_u16_nn(metrics->AverageUclkActivity) <= SMU_13_0_7_BUSY_THRESHOLD)
>   			*value = metrics->AverageMemclkFrequencyPostDs;
>   		else
>   			*value = metrics->AverageMemclkFrequencyPreDs;
> @@ -815,7 +815,7 @@ static int smu_v13_0_7_get_smu_metrics_data(struct smu_context *smu,
>   		*value = metrics->AverageGfxActivity;
>   		break;
>   	case METRICS_AVERAGE_MEMACTIVITY:
> -		*value = metrics->AverageUclkActivity;
> +		*value = smu_safe_u16_nn(metrics->AverageUclkActivity);
>   		break;
>   	case METRICS_AVERAGE_SOCKETPOWER:
>   		*value = metrics->AverageSocketPower << 8;
> @@ -2092,7 +2092,7 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
>   					     metrics->AvgTemperature[TEMP_VR_MEM1]);
>   
>   	gpu_metrics->average_gfx_activity = metrics->AverageGfxActivity;
> -	gpu_metrics->average_umc_activity = metrics->AverageUclkActivity;
> +	gpu_metrics->average_umc_activity = smu_safe_u16_nn(metrics->AverageUclkActivity);
>   	gpu_metrics->average_mm_activity = max(metrics->Vcn0ActivityPercentage,
>   					       metrics->Vcn1ActivityPercentage);
>   
> @@ -2105,7 +2105,7 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
>   	else
>   		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPreDs;
>   
> -	if (metrics->AverageUclkActivity <= SMU_13_0_7_BUSY_THRESHOLD)
> +	if (smu_safe_u16_nn(metrics->AverageUclkActivity) <= SMU_13_0_7_BUSY_THRESHOLD)
>   		gpu_metrics->average_uclk_frequency = metrics->AverageMemclkFrequencyPostDs;
>   	else
>   		gpu_metrics->average_uclk_frequency = metrics->AverageMemclkFrequencyPreDs;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 28c1b084fe62..aaec3a251e0f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -660,13 +660,13 @@ static int smu_v14_0_2_get_smu_metrics_data(struct smu_context *smu,
>   			*value = metrics->AverageGfxclkFrequencyPreDs;
>   		break;
>   	case METRICS_AVERAGE_FCLK:
> -		if (metrics->AverageUclkActivity <= SMU_14_0_2_BUSY_THRESHOLD)
> +		if (smu_safe_u16_nn(metrics->AverageUclkActivity) <= SMU_14_0_2_BUSY_THRESHOLD)
>   			*value = metrics->AverageFclkFrequencyPostDs;
>   		else
>   			*value = metrics->AverageFclkFrequencyPreDs;
>   		break;
>   	case METRICS_AVERAGE_UCLK:
> -		if (metrics->AverageUclkActivity <= SMU_14_0_2_BUSY_THRESHOLD)
> +		if (smu_safe_u16_nn(metrics->AverageUclkActivity) <= SMU_14_0_2_BUSY_THRESHOLD)
>   			*value = metrics->AverageMemclkFrequencyPostDs;
>   		else
>   			*value = metrics->AverageMemclkFrequencyPreDs;
> @@ -687,7 +687,7 @@ static int smu_v14_0_2_get_smu_metrics_data(struct smu_context *smu,
>   		*value = metrics->AverageGfxActivity;
>   		break;
>   	case METRICS_AVERAGE_MEMACTIVITY:
> -		*value = metrics->AverageUclkActivity;
> +		*value = smu_safe_u16_nn(metrics->AverageUclkActivity);
>   		break;
>   	case METRICS_AVERAGE_VCNACTIVITY:
>   		*value = max(metrics->AverageVcn0ActivityPercentage,
> @@ -2146,7 +2146,7 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
>   					     metrics->AvgTemperature[TEMP_VR_MEM1]);
>   
>   	gpu_metrics->average_gfx_activity = metrics->AverageGfxActivity;
> -	gpu_metrics->average_umc_activity = metrics->AverageUclkActivity;
> +	gpu_metrics->average_umc_activity = smu_safe_u16_nn(metrics->AverageUclkActivity);
>   	gpu_metrics->average_mm_activity = max(metrics->AverageVcn0ActivityPercentage,
>   					       metrics->Vcn1ActivityPercentage);
>   
> @@ -2158,7 +2158,7 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
>   	else
>   		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPreDs;
>   
> -	if (metrics->AverageUclkActivity <= SMU_14_0_2_BUSY_THRESHOLD)
> +	if (smu_safe_u16_nn(metrics->AverageUclkActivity) <= SMU_14_0_2_BUSY_THRESHOLD)
>   		gpu_metrics->average_uclk_frequency = metrics->AverageMemclkFrequencyPostDs;
>   	else
>   		gpu_metrics->average_uclk_frequency = metrics->AverageMemclkFrequencyPreDs;

