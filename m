Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B61F8E4B4
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 07:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23F3110E985;
	Fri, 17 Apr 2026 07:25:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z3YZDaDW";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8351E10E985
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 07:25:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzJXUysot+oH6CHkL32zvLuKaiDlFZ2ZHfRVtjcsGuNfb9TwpIXzJpA2HCzBmxV/TpFKfPGA6Fo/2I95CgEss9q07fLcoc26KjqXSHPx26hyNveto+yJjuBmmG6B5yAPAOqcYZdML3VlDKGkdPNc/WU+YuUt21n2fCJqD2SKhz9QBdlQ9G3gkxH3HO+irOD44kLTRQHqzb7FDkBVIZaThjxHQYIQax6YJoPtnywhq5FFX/ApWh22qzooC6/OioDrJByKwn4WTZi1AStfY29Iu04SVzFZXpXA1vLmkqSeYfAYyP/J4q3FDQNycKKN3WC5f3II7gQqpCoJPyvpyCOU0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyxQBN/+AeGWRsfQDJP1JDiK1+i/iqVS/XwkB67JYi0=;
 b=RN5BgvnEkvr/nm60x6pH1x7sMe9k4c92Ep/ndgM1ifq9qoBd9EfU7x1fWXcnjD8lNFCJmpCz5uILjEeCHRwTSYE+sCZn7dcONQhAjMAJmPiW+l3P6G/1moeuZ4Z6Qkv97lKjTSdZzFgy4ZvMF2BV6nbp8i0a3vtkf/cs0/3NouBUVex6OZAjnUPl80FbMLtMpM7DXiD/aJNLuAQTkAtlF/PQL57R4XQF+AfK7S60Nyq+wkEMnYqXr1gIEMP0jVNCgbuXtCHcSaMi2T/rcgkN5w3p9Y9ha6LTpyt93Ehjyag7lF0VsS+O5IlTD3ujRRBgCLDACTq1yp5UyIACNg6o6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyxQBN/+AeGWRsfQDJP1JDiK1+i/iqVS/XwkB67JYi0=;
 b=Z3YZDaDWUkBdBTljiAB2IVQp9u/Hw+xlJ6V4uDq5nSLM/CuYPn0lxSg687trvKwI2i8D2/iYoGAJHK7Ue0N5gySfwpp4rX+xmFmcxXsceM0IbMc0Z0DXoUVyBpNyY8CYkVyTJBTvmvE8saltItbJzBtl3hpTBNj2Zj8DNFpGGJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 07:24:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 07:24:59 +0000
Message-ID: <b7656601-bbcc-4dc0-bbe7-7ebe8e5ab777@amd.com>
Date: Fri, 17 Apr 2026 09:24:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] Documentation/gpu: Add TCC, update TCP in amdgpu
 glossary
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20260416202643.25350-1-timur.kristof@gmail.com>
 <20260416202643.25350-7-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260416202643.25350-7-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 40763008-823f-4f00-3fd4-08de9c526ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: s7fM+y2REQ34iJrrFS573knXQTe39MkQy5TqpDOXnhq30yz44mwFnfC+m0ZL/Xv8XmTZ7fSZbBMWtjhFIF93mW9iiwrB04fwtIKx+nd5hhxg/YelfTtv5QPBRF1rtwhqi/5tVMePK4DbF1Ind0lynLOG99XqACOKx+IR7ZfkJdsXSemGDM9teCH2oBmzJY3BlXs6DksQMmt0t99Khr7cGLALvvT+hw1nNU/DEHdwSI6Qdsyi6H0foTEB8EjhC8yFJx47wVzVH6EOO2SEHp38mJwh62npUtckLuSUSh/CGM97jAlLpNG4MoV1wcGPRRhhMUdArrU2riSpME+jAMupbRGDqaVeBCU41c+n7MF+lY4TuyKV6cgYMwdcuFEisKWQOcRI4YaOHu7lZ5v+fEDYPyr11OAOnQUJxT42O5rMnndVKxkmFSxPoxQP3REvPx8VSiITIi0sqKZzGKc9u30VNHkvK1YPOtURPalfo3BIr5pfm+UgJ/RfG8D86gVCKoYzJiFeRi6wnAV+mrheAoHrlMJ5sSKe7aAOoMHETeEhm3TnGY2UdpPeKzp4NKUWrE7EL8qThh85tuwU5dCARVkVzFFaXC4XQUUIdXaNOUZ6wk44KWD25998qK5y+5W4QMV3ssAz7zGvYMwfrKtXdq0V/yLU+Ausm08aA3g/Bvyiqj1DHxtLFgJpDn+MpjjpKqRVRzXA90AhkK2dint2ZecvphTlhhsNwhRcD/czeoHKxz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bElLQ21EMmVSVlZJUHlUUEZhcURiS3ZlclNWeElKVTNMaG9jYVhCNk80aFo1?=
 =?utf-8?B?VC83MGZIQndyQ3dXdzVCVmsxa2hzYXl6elZuV3BiSHFySXczeFJsUElWaHpj?=
 =?utf-8?B?VUNCUnFxNmYyNlg5MWJEbEw1bE0xbDc1S3NSNFl6azBkemJCZW9QdHZzaDlm?=
 =?utf-8?B?bUhmU0p2VVRmUWZrd01ZVEphd1FiaDBKMDhiWjFGbk1DeDRydzZaK3o3eWFs?=
 =?utf-8?B?NkFEOHRFbFI1S1ZKSWNpY3o0Qnc2MTJVSlExYmhQL1djc3l3SjZ4NVZsYXhQ?=
 =?utf-8?B?N2ZtdGhuWW1GVEpCSWpaMkxJREp0RUl4WFRoNXllQzRUTDEzRlc4dSs3Q3o3?=
 =?utf-8?B?VWJPUlc2VG9GcnJGUFlweXhLMXp4Wm1BYjZtWHlrOW56NG9jamNwK2ZJT1g4?=
 =?utf-8?B?dkRtdElIR2s2UGpzK0hucVkrUVFRam1ONG05UTFKWVBLNWg0KzN5bUtiZmVs?=
 =?utf-8?B?WWh0bjgwQVpUNnJvMmZxRitjSTI1cForOFd2VW5PcGtWL3l5Tld3dllGYlMz?=
 =?utf-8?B?cHBCZy9yZFFvZk15dWlONkhxWnliZDVOQko1ZnBHSnlPazBoVXpKejRHUy9h?=
 =?utf-8?B?dERneHVUblNVRElJS09WWE5RVXA0NXhTdGtsMU5tMk1MMENhclBnY3pFdTJy?=
 =?utf-8?B?c0xQcVlsbWVubm9mL0VjRGRoT1VTOHFUNm1iRXNva2h2MWZrMDJXQ2JWb2tz?=
 =?utf-8?B?czg2eEJMNGlPbktwMFhwTjhlak0yeTRmeXQySDJzeDQxb2krOUJtazRBSkdF?=
 =?utf-8?B?RlBZZ1M5NGNhNmI4YUI4VjYzb3dsOHJCamJXOXJ3YUw1cW80N2FPTDV2cmR4?=
 =?utf-8?B?bm9sQ203OTl1NFJXUEYyT3Q4ZkZZZHpzdm55Z1BVSmtQUmRsdFlYejc2UlBp?=
 =?utf-8?B?YTZYYVFiOEdNcU81eVgrR05Zb0lBZDQvQWZJbWVleGk1RjRLektVblZRSTdP?=
 =?utf-8?B?NWppcEFtUHpJUHRHMEpuZ016TDdEZEJldEFZeWZTa1JFTXEyd2duUFBINTMv?=
 =?utf-8?B?SWo2OVJtZWlNVDdUVVZYK1pRSFptUHYyYkNNVS9BQlV4eDZ6bEFFcHlvS1FQ?=
 =?utf-8?B?UjZGc0FyR09YVXllYk5sUUkvL01RUytpb2tSZk96UlY0blc3Z0hPbmg5Q0pN?=
 =?utf-8?B?RExjMWpraWdHN1p3K1kwNE9XSzVxaWJyOW0yaXZxallvT09PT3B3dW12Q1Yy?=
 =?utf-8?B?QVc4QmRBb1dBR0FZZUN4QUhPRGVVZ0pKUWRBeW9xN2d4N2tIQVVFaUxCaTM2?=
 =?utf-8?B?N1piNlR0WG5tdkVFaEUwbDY4RisrZEVpbE5wcXFhQjVjUVpBWjJVaUtvM0sv?=
 =?utf-8?B?bUhJNkkrUnpjdE84K1l5Q0xrdHJWc2NWUnJGODlIL3dGSW84ckJDYW5rVlRs?=
 =?utf-8?B?NXJxVURuWGVTZGwvbVNRNlY3bHQ2ZFRIbXBZWEdydzRtek45QjFCaXdja0lJ?=
 =?utf-8?B?WXJyZGV1SmNwNGg2WXVuUFJncDJDbkJEZng5VnV0WlVnMTdBc0YrMi9NcG9l?=
 =?utf-8?B?c2ZYMW9VVW9LcEpNcGJyMjVwbEpaZHhQbjlyV0g2blcvc1JHejk5VThTdEJE?=
 =?utf-8?B?UG5jN0RhMGRmTklBc3RzRlFtVk5sTzJQcmdCc2xaU3pKUEdFQ1AzcDdscHhH?=
 =?utf-8?B?bXl6YzVqTHk5Y3diTUlPSFNEOGMvNGdtMnlxU3lURzlpK2tuZ0FlS1dpNDVr?=
 =?utf-8?B?RUdXUmoybFpsZ2dIemZ6Wk02MXRXeERXRWUrSThYMEF1b1UxN2RRTHpjc1Rt?=
 =?utf-8?B?TU1UMk5yWk5ORWRuWVNWOW5UNkRkTExyWVJZemp6Smt4T0NTeHdpRXBHQVZm?=
 =?utf-8?B?UjhjQ0JBQUJtaks5aDZ0RFJkRGZlMURGSTJQb3R1QkcyelBZMjd1UHljUHIx?=
 =?utf-8?B?ejI0dTZHcXU4TEVhSHhuMGY3WmJFWERLMGcxMWMvOFBFZzF2YVhiTHdhSk81?=
 =?utf-8?B?S0lFUk9vamJMcEU0WFVhZ0NNNmx2QUJoQ3p5MUZWLzhZTGt5b3NsdThJakNB?=
 =?utf-8?B?ZXQ2Q25KNXRZeTZ6aDAyRHR3d2JlbjBEMkFTTVJSN0xoMXFLMzY0bmw0NVdZ?=
 =?utf-8?B?SDM4dmNCeWRMUGhmQVZUby9ocytUR3FkYlc3TmVvRER2RnpPZmV6NzhmbmNG?=
 =?utf-8?B?aUp5R0xZTlh2NU5IaWpSaEp5bVd3a3hxV0FyaUQrS21LN04rUW94Tjh6NWFn?=
 =?utf-8?B?eUZ5Z1RadC9WTStMSUx4M0tMVHppZjFmQ01tR2gvdmQ5L05NTDViWTZ6Tlk2?=
 =?utf-8?B?VFBaR0t4b29JY1FXZlFHblUvRVdsYUlRSWtTN1poWTFLbGtCbCtoMDhCWCtQ?=
 =?utf-8?B?RlJxa2R0MjM2QzJiYTlvLzI5V3NyM0RadUZBZktsVjFpZEdYWHJvZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40763008-823f-4f00-3fd4-08de9c526ed6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 07:24:59.5631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pq8xQeP98qnSea70wUZW2/C8wUTkPVwopyXwUPJ99gJx1lXLpGNGey5Va6VykEV9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698
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

On 4/16/26 22:26, Timur Kristóf wrote:
> These are the L2 and L1 cache on some AMD GPU architectures.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  Documentation/gpu/amdgpu/amdgpu-glossary.rst | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> index 033167025fcca..d553dd599c966 100644
> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> @@ -233,8 +233,15 @@ we have a dedicated glossary for Display Core at
>      TC
>        Texture Cache
>  
> +    TCC
> +      Texture Cache per Channel - L2 cache attached to the memory channels.
> +      May be used when shader cores are accessing memory.
> +      Despite "Texture" in the name, this is used by any kind of memory access.
> +      TCCs may be mapped to TCPs, depending on the architecture.
> +

Good to have, but maybe put that below TCP. E.g. L1 first and then L2.

Apart from that nit Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

>      TCP (AMDGPU)
> -      Texture Cache per Pipe. Even though the name "Texture" is part of this
> +      Texture Cache per Pipe - L1 cache attached to each CU.
> +      Even though the name "Texture" is part of this
>        acronym, the TCP represents the path to memory shaders; i.e., it is not
>        related to texture. The name is a leftover from older designs where shader
>        stages had different cache designs; it refers to the L1 cache in older

