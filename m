Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1EEE77173
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 05:11:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C91B10E3CD;
	Fri,  6 Dec 2024 05:11:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z1OWQJ9O";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57D2010E3CD
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 05:11:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcfMag9HJO+OfT4W3kBQ5PK/EwF1qb7e6OXH/FbhsVAs/eVwuZhko1IxB/gkx1CLNDEYpdBPX7VsssjG5tY0cCWNtFdoIysor4uAMmJJ2vtuXElRG3oceE5p4gYwZBkMpx3gSoamDDOf3dLO/c0Zf8q3JQOuWdhgbVqT+1bwhY/etmXvrw8xwa/9kgpo5yMwxKhLvK/xdOJq+sLopxemeOTzEpko+MP6bjxKcOV1EZ56DuqNUWBW4EOLvS8WIbt8rjMm+DABump3sd7Vcw0lBbOSun0uXIiQhwsGobEdKqBqmgjcMuLjaCWBrL9JrEW9HCP+rSm06DNbOwVtea0dKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+eorMn8O/HUrOF27sJrQMjmkvrKlyrwqB6vlYv7Q1U=;
 b=hgIgSVCMj/IeDjBxKApP5NlWyj5eXsJxHpglJG4QIAbRARFOYuMh0KmQFbN0LC+qdjdogiDN/dmWwJISlaKryE17uqwktRdqjUrx5vXNiTFBGEMgeMTX4teryeUdVj3bwqw+uQThNL8T6bOu6kIju7gPwuZv9u86Jn6OphCAKWjymUIofqrODWtvGKugpRifDAG4NFPTVvIFQHk4LMzuUsLf8Q4C/kBcQ9Ep2dJPsTdPAOASsNT/HCFTcLo9rhiNRedLL53JY74oP4cFaxWFPS/AUl1OnwUVW0PXXyWO0burmIZ8yYWk+Ln1RIbg7BeYvR5rFnnmc96nDEAJ5WlLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+eorMn8O/HUrOF27sJrQMjmkvrKlyrwqB6vlYv7Q1U=;
 b=z1OWQJ9OpD0npkDi/xC2E9JbB/hzq4ouXh6p4SNt6DUZKsqGX+5s2EdgpyD7YoHDZ5HTPivQ+HhqOlkes8u6RXCsxyFcmmx+N8ll+FXLN438OVZrZuBPuPS9abjQh4VBjnawb0VKvyrPUUaSQ03t5AAYFU8xsOZeG745l94djp4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB8184.namprd12.prod.outlook.com (2603:10b6:a03:4f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 05:11:15 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 05:11:15 +0000
Message-ID: <d13e29a4-96bf-4bc8-a898-06eea1b87c78@amd.com>
Date: Fri, 6 Dec 2024 10:41:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu: Fix ISP HW init issue
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com,
 benjamin.chan@amd.com, king.li@amd.com, bin.du@amd.com
References: <20241205201705.578136-1-pratap.nirujogi@amd.com>
 <20241205201705.578136-2-pratap.nirujogi@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241205201705.578136-2-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: a928c88f-1119-4bb8-0933-08dd15b468a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Skc5TnpxWnp6bStPTERBZmpWZFJyY2FEK2Jac1JRYTV0NjZIQVFiM0JxMWsx?=
 =?utf-8?B?YVZ6YzVOcUhIbEo5cCswSjBPbzRjU05XRUVpWWkxUUJpWEtJb2pKZUZobDdq?=
 =?utf-8?B?dUs3V1dRVEVXeVpyUE5ZVll3ZXI2OHIreFdCZzZFT2t4Q2tPT0hxcklpTGFM?=
 =?utf-8?B?bnlNNzlIRlpoZ0EwNlZicHY1NllMQ3ZsbHVhbWNwbVhyb2RydzhBZWJEOFZl?=
 =?utf-8?B?MHVWbjFMdXhZUXZ4Z3U5MmJ5djJYMGdyZXNpTEVXdEJiclljaVhwU05OOTF1?=
 =?utf-8?B?RVFyQTZ2MWpZT2pRbDc5T2VUTFJXMGtNUFJWSnRveDg1eXphTnFISnp0RjJx?=
 =?utf-8?B?M0ppVUpPd2hFTm9FVTM1emtOUnlBNkR2VS8wdjFWU01rQnY4b2EzNGNzeVZF?=
 =?utf-8?B?TGZEK0d5QVh4Sm0vcTAvVDZmUnRZTzRLQnRxR214R0VoOW5UcCtlRlRZcHNT?=
 =?utf-8?B?L2ZzNG5hd2dVWEczSkhFNG90RjlrNDVEbmlReDJqTzIxUXQwTkhlbDR0L1pL?=
 =?utf-8?B?V2p3S21pQUhDNUFMK1Ezdk5jRnFpZ01XRXhCS1lRa3l1S0drMEJCMi94MHBS?=
 =?utf-8?B?VEhMSDBTNm1zcmpzZFE1QjhOSDRHQW9mMHM0aURaY3N2L3libFRzczZaMCta?=
 =?utf-8?B?c2lyVEJjWVphejlMUG1McFZUVlRHNzVXWE9KQVRIVXAyZTVDWUdhMEF3U2M4?=
 =?utf-8?B?MDB0VHg3TjZTci9FWDBiRDJYYTd1R2lZck00T2d4amZnVER0UU1KVTlKOGhT?=
 =?utf-8?B?MXNRNG9vSWlDY2N6RzhteERhTVUwcDhFK0lib1FrZjVZSHFjNTZUYzd5YnZ3?=
 =?utf-8?B?eXRqc2ZHTzFFdWdlSHZqWHBJekhxRzJNVlJNRWxNeFBoN0thc2FwOFRld3cr?=
 =?utf-8?B?S0FUQ0RsQ1ZSZVIvVjQ3cEFrY3VPTTBJVUJmak1rczdUTFVzKzZwUGJkTDBw?=
 =?utf-8?B?TVBkSEtPK0J2UjBDNXFWbEkycjNGZ0NZSDFzRERWeXVYT0xNUnNxdFh6N3FK?=
 =?utf-8?B?S3RHNzc2Ni92bG5EWi9UVldKU0dDRWtlcnVkV3JEdlR1TzdBN3ZodnR6Q1Uw?=
 =?utf-8?B?MkdXb1lPMnpDZysxbnJNSklkWlBIWTJVQ0ZQdjMvYlZwVGFMQTN2MkVrWW5U?=
 =?utf-8?B?NWdwME4yd3NXRE1LM2JEMWlpUUpES3lSK3JXZktZU2ZrdXd0bFRyZGExVnBx?=
 =?utf-8?B?N2wvRG5oUnJrS1ZITys4VUIvaGZLMzBKenVSK3V1RjROSWdSVXBJclpZT2VX?=
 =?utf-8?B?OE1qNnJCL1RydTl2UlE2V1BXeFRjdXgvazdJOVN2a1VwN1k4dGEvalJrWUt2?=
 =?utf-8?B?OEVENW8vU1FSNFp5NVhKSkx6RXlVY2pNSkxwMUR4NDExOWsrS0RhSjB3dWFP?=
 =?utf-8?B?cFhUeTltajZ5MWFUSzRkUVhQOEIxQXJZVEZVajcrUk5sdVVESVd3TDR0SXFS?=
 =?utf-8?B?N3R3WlNHRzBUaytudTl2K1MreGJHQTFHWHZkVllCTUkwNDExVGdtTmYvZ3pl?=
 =?utf-8?B?T2VGekRmUUY4ZGNOYTJEQ1F0OVFqSmd3R0hJZll3ZGVVa255L1BqSjhxV2xq?=
 =?utf-8?B?QjJ3Rmp4RlFTR1Nxb09CT3Q4QlljOWxvNnhKRU44aktpbVlUZ1d6TVFKbHdl?=
 =?utf-8?B?OFIrcm13MGVvKzFiQmtzN0t3MDZjSVVMcXp5aE4xOHcxckRKT21EL1RmalBm?=
 =?utf-8?B?SyttVTkrK2M2L010bnBNV2p5anh2THNSczkwbDQvZWlkUitUTHZlR2tGTHE5?=
 =?utf-8?B?RDhMRkMyZlI3SXdBZlppVDhraHZlVXdtcW5WdHUrOGNPNDJPaEdWeDdyeG1O?=
 =?utf-8?Q?sYvlN9pCjklLQLeoxS+L3Czl3gBwqFSzGXZ3o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0VtRTdUaVhOMFhtejRPWTBMbCtZLzhvRktDTXJsc0M4bjIrSzlraWZ6eURj?=
 =?utf-8?B?NDlUa0JZSGMydmJzYVV1TWMwa2QyVHk3Y2tFem5RSlVnZUV1UWcyNC9UR0ll?=
 =?utf-8?B?UWNuSzZVM3RueFdkaTR2S1lpMGI1dVBpU3NTQnpJUE80Q0s2bnk2UGVkcHNt?=
 =?utf-8?B?amVLdktQWWZYY1ZIZE8va0Q4TjZpK2N4N2dIMjNjS0VGckdMZDlYd3VmdTdP?=
 =?utf-8?B?NjJhaGV3VkpUa2RwR0pZaUVyZ2FlNG9ncG1IeVhMT0pyS0RQMXl0WUFpb2JP?=
 =?utf-8?B?Z0lZNnpTVWQyY054NEJTbXBuUzVJcnNrS28yaU9STVcrRUVaREN2RGVNdXdq?=
 =?utf-8?B?QXNxUnJIWVluTWdRQlY4cXZzb3NWOFpjUmtUNFhCcnpDNHV4SklRbzAvZW5S?=
 =?utf-8?B?MFE4L29QRUsrRmhxaDlLa1l3VGU3QlB0cWpjZ2ZjQ1JQSGFoUDcyLzhJRXhr?=
 =?utf-8?B?aGxFK2loZmNIU3dXU3JLUXJnVmJaZW51TzZaVVNMMzc0MHdHdFh4dUJTaG1Y?=
 =?utf-8?B?TmMrQjFWY0lNWldzZ0FQcW05UXRpc2IyWW1tenliNWhvRXppd24vYkVLR0pu?=
 =?utf-8?B?MzJSaXBvdTFnWXEyYzA0akZXSFo4UnphRVk3SEREYUlaLzJWSU1CM1RYMSt1?=
 =?utf-8?B?VUlYakVNZHNvNWdkRXFtWlpwQVVOQlFsTTBYa1VGMDg1cVVhRUYva3JQdVZH?=
 =?utf-8?B?K1FCaVdYZkY2OXBFSHdTRDh4VjltNjN0Q00vV1BMSTF5VW5IUTA1VmU4anBH?=
 =?utf-8?B?NGs0Vkkrb1ZMNURVTko5em4xSXlseW82d1UzcDBPRjMybHEwZXI0U2hYTERI?=
 =?utf-8?B?K1RNbEVSbEJaY0ltWGpUeGNyS0ZKR1FEV2VKTTg2UXhqZE0vRGZ6M3o5VXB1?=
 =?utf-8?B?dHI5ZlBnTmFUbkFhV3NFb3Q3ZUg4NXhKS09Fc0tiMllaTko5bjBsREc5MjNR?=
 =?utf-8?B?VDZhdzJkZjdhblZrSTZyMHNLMXZ6TnpHaDhrRFBKWlIzNTQ0UHM5RWRyTVha?=
 =?utf-8?B?UzNQdFh3UyszaXlsUktuREJVcDRTYWEyTkY5RjJPSGJZdGhaSmZsdlZXZXFD?=
 =?utf-8?B?cFhLVnphbWNXMlFnT213VW5Id08zb1FXTUYzU2wzNkxWSERjUktaZCsvUDRG?=
 =?utf-8?B?bG5iVHh4NnhxMGZvKy9JVithTWN6R3gweUx3R0drWGlWcmtzUUx2d05PRVpT?=
 =?utf-8?B?TXJDemk5UmlyNXFxejlmdlpFRWRxRW0xSksrVTc2R3VtUHhSejUvMlJjOXVy?=
 =?utf-8?B?b1RwTDF5bCtubEpUdlFRMDZqbm4wTm0vRzRzTC9yb0xUNkpySDUzQm1XS3Yy?=
 =?utf-8?B?MGtHcTRwZmcxU1laSXFsaXNYWTluU051U0tlMGNBUElNSTVaUmNFQzQzWUxP?=
 =?utf-8?B?T2FxSEpEcVpjNHBsQ2FEZE9LVjFPQWw4SWlqNVA3aXlHRzRNRTFrbHpmdlVV?=
 =?utf-8?B?c2RuQUp6REFuTFFqSVVtT0tiblhwT3pzeUFWYUZxWmtsb3JBcDlBR0NiN2N1?=
 =?utf-8?B?bmVtVFdJT05TeGdjUmp6YTNFS3NGeTRGRmFCWWVrY0hRWmcxbTJ1SE9iSkxw?=
 =?utf-8?B?NEZrSGhOWXBXTldpUFRCaTA2SDgwT3RBWVcxd3RIUUhlMkdQaVpjc1dGM0dQ?=
 =?utf-8?B?bHZyUzhZL2NsNUVhaGdKWkRFOTBRVWlSVlhUZCtkYlVQVFJ2NlM0STBDczVw?=
 =?utf-8?B?TmJhQWJpSjhlTktib1VQaHNaNEdQTEdxaUI0WEtidU1WdlpqL2RYVGh4TzlS?=
 =?utf-8?B?cjBUWXU4QVdIMVBwaVJlOWg2K25tNElCT09RaHMxd1VmMUN0Z2lIeHlBdTNZ?=
 =?utf-8?B?cXB5bS9sR3ZmZ1IwbVYyeUpIbC9jRGwwL085NnRkUWRRbGtBRE5uaUFSWVU5?=
 =?utf-8?B?cHVFeGhSRWpyNnZseVhPYndTOGNTeFlCNTJkVytyaXRvRmt5TmFBVE50WEV0?=
 =?utf-8?B?ZHNNTmtOTHBEWDl2aGJQeUlpZGJuclZ0bGZxSk16cFFnVTZNV1RaQnJWTVQr?=
 =?utf-8?B?aDg0MUp2bWhYQ2J5Nlo5bkp0Z3RyU0FPWFVkeGlIUjMvZ3NUTkp3eVFEdXFr?=
 =?utf-8?B?azFCdnVjQkUwZnI0R3ZmQndGeXIyRmhxaXUzTW1GaWx2UzMzUW96VHptY1Zt?=
 =?utf-8?Q?MQ+d+yYhDXNSS9EUrWuTy8Xgh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a928c88f-1119-4bb8-0933-08dd15b468a7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 05:11:15.4364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4h3bWRl/7Kh72rUNPc3KQ16RvFaiyR8+eY0NK756qO3339yxIwLVwKY+MeZf6le
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8184
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



On 12/6/2024 1:46 AM, Pratap Nirujogi wrote:
> ISP hw_init is not called with the recent changes releated
> to hw init levels. AMDGPU_INIT_LEVEL_DEFAULT is ignoring
> the ISP IP block as AMDGPU_IP_BLK_MASK_ALL is derived using
> incorrect max number of IP blocks.
> 
> Update AMDGPU_IP_BLK_MASK_ALL to use AMD_IP_BLOCK_TYPE_NUM
> instead of AMDGPU_MAX_IP_NUM to fix the issue.
> 
> Fixes: 14c11b71985c ("drm/amdgpu: Add init levels")
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 735a01c58cd7..b5208a16d7d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -144,7 +144,7 @@ const char *amdgpu_asic_name[] = {
>  	"LAST",
>  };
>  
> -#define AMDGPU_IP_BLK_MASK_ALL GENMASK(AMDGPU_MAX_IP_NUM - 1, 0)
> +#define AMDGPU_IP_BLK_MASK_ALL GENMASK(AMD_IP_BLOCK_TYPE_NUM  - 1, 0)
>  /*
>   * Default init level where all blocks are expected to be initialized. This is
>   * the level of initialization expected by default and also after a full reset

