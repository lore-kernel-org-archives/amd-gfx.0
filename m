Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE522CFD2F6
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 12:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6198F10E62B;
	Tue,  2 Dec 2025 12:00:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zYk/OoaA";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010054.outbound.protection.outlook.com
 [40.93.198.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6DF710E62B
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 12:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbHJe/TOXXqfmhm5NJgNpihVXo43Jnlc0MvvKG0x+rbq2eUV+gNsu1pRjYPlDBUSfaz6pGAehf2XLRZRxvFdhOr6JpUXHYkXAZfie/N8vG/+NSsZ1gmDfUNqhD/GIDtP34pqzJyyzeYHV9xFSWrk5HnaCE6e6wIPK9U1U4EtUty7wWHQnicreELjZZJUceiGYiCGjyPUoEZss0gSe5lytaz1Y2sIIl89Tqne0H3xeU49CIZxbvqdVa2qDzKpmzOK5x9f/6RXcZ4ZlZ0JJQtxICdx3AU4JATNMR87puHw1sGx097eA4x3lp/s3ZeGjvNcA7uF8T2IppLfHWNaoiNuiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXG+BTbGTbO0wN6jFUxa4MEiTJQPc/TnWX99OB6f9sA=;
 b=xGVlJJtp4Y4MwyV/w49pkzjCucr+B395rsIbIa/Mbk9VyQPVLWRUTflBYQKYHkDNtio48Tug7D2FSkmBcoQpwYsapfFkO3jAfxWLb0dMdX64QN73LNCgJLb4M0YovhqrFFow16jCXmv6J63KebFrmtza08IdEgyP287CscubRhgsmTZBZfcGTyrPGv4+2GT3UsbBWNzYrVQcln7w/Bd47NeV2EFCljQs2JN5dEUTagsjfeGMrLNVBezOMwjmZhPhNKhq7yaDW4UEvxTbxiXnxJpLKciBnDZZ0ATxNbsdpjnZJ17rS3k7MgTragyTFBJ07AHjxDjfNAe46BOTJQh03Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXG+BTbGTbO0wN6jFUxa4MEiTJQPc/TnWX99OB6f9sA=;
 b=zYk/OoaAmJRrbAKHSzUwOzlZsOjmvIXxzFaO6c1PzJEfIx7B7hXZgcu/g8OLZEJ3RRh0ytnzdKP3kvX3SbUgeykdGplX5ZyPPeylBNfJ23dm62Os7Oecq8GR9CrHlMAReT3U1+Ax+PuAh2mQZXFXDjHZVOU0NwKO8RvArY3xmFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 12:00:39 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 12:00:39 +0000
Message-ID: <93f048c4-614c-4804-aebd-630a090c57a5@amd.com>
Date: Tue, 2 Dec 2025 17:30:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add a helper for processing recoverable GPUVM
 faults
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251201195014.3759849-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251201195014.3759849-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0113.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY5PR12MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: ce08aab5-51c0-467a-0f7f-08de319a6929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dW95QlFhNjd5RFIxNG40YUM3aUEwYUREQzc0RHJQKzdXVi9QZ1RuVGNVb2Va?=
 =?utf-8?B?VGs1cTRpc1JRejl2SEptbkVkaEZ1TjZhNm12S0RlakwvN0JQR25oWVVTRlhU?=
 =?utf-8?B?MjI3blRQTGVZSVVlL2E0OFBSK3JMNXdnQndxRGpvYWxPaExJeWkxNldZRnNn?=
 =?utf-8?B?ZXJLM2RnS0VhbC82cFJsZHE5MkkrQVczN09JcGNvVHdMV3pEdVdzSi8yRi9T?=
 =?utf-8?B?M01XUm1iWlgwYXpGbFVZcWpHak1BckRKK0NxYVpLRUtxTDQ3QVJ4enNLTjhV?=
 =?utf-8?B?YjhleW1TelpST1prZzlwOGlKZU9EWVkyUTBZd1gvK2FqMlFGdEFuNk5OSlVF?=
 =?utf-8?B?ZnJ5dytHMmdZNDFGbThVME1Oanh0N2ROTTRLeFJjYTlKMHFXbmVpaCtHTnMv?=
 =?utf-8?B?RkJLRXAvVzZkZHFzekRQT3A3YVo2SjBld05wN3VZOGZ1bmxmTjhQcldsc1Bj?=
 =?utf-8?B?Nk8wOTFNbFRvK3Z5NS9hU3BIdkpkVUxmd09CTENkSS8rRkNmQi9MM3JuNnA2?=
 =?utf-8?B?T3hrSWhwTVhTVVgrd0ExQ1AwUm5lb3JmQnlJMXJ5ZFFIa2N5WmtHd2FPTktO?=
 =?utf-8?B?TUdNS0RmUEhIT2JPNTNIR3NiSlFORnFyL3B4cmNiQ0srWloxekxHWnhrZ0ZC?=
 =?utf-8?B?Z3UyNUFqZk9qcUExVDB1ZnR2elNJQWh4ZUx4U1pNMUo3SHlKbDB4T0tEQWUy?=
 =?utf-8?B?YUNtVHV1aklzVzVBUWJYcVVsZnBQcjlRTHFrZks4QjRMalM2YlV5bjE5d2Rs?=
 =?utf-8?B?bnR4bVlORnBKekJENlBRK1V6V21TVGVPbjB1VXJlRHBHQWhUNEpWb3hyQnR2?=
 =?utf-8?B?d1FFeEtqK1RmV2ZDU1JhbkFSUkFxV1lzcXhJZkdOYWpJQjQ0a25WWFNXYVR5?=
 =?utf-8?B?VkRlWXY2U1pIWHZlNG9mc1R2a2kzUWRjOEhJeE1kdzM0QTRMcnZaYWQ5N2x5?=
 =?utf-8?B?NjU0UkRSY0lhbFU2dWNPaGFLaytrNnNRM2pzekZ1djVHMkRSS01sOS9PTmFp?=
 =?utf-8?B?MUlZM3FMY1BsWWFLTWFsNCtKejlCV0NaUUhYMWNwY0ZPUXJybUNUQ1FROVVJ?=
 =?utf-8?B?eFpmTTlNQTY2N0xXQUMzRGlUVlpxL28veHBXRGFERmk4dTJ3TVVaMEloK3Ju?=
 =?utf-8?B?TEkvWjBmbnkyeFBsVTJJdldMNzFGRGREUlgvdENwWlhxcVJDZDAyNDA5d2lR?=
 =?utf-8?B?Z2xsMnpzN2E1bkd2SzBobnJYM3N5dVNRVmtEZ0J4c0h0bm5YbU1GcSs2Q0hF?=
 =?utf-8?B?dUJESVp6aVd3eE93QmhVdUs2Q0k1aWZaVGpvR0hCSm44N05uUVZ6aEJIVklO?=
 =?utf-8?B?U2lZM09sY25NdHloWHVTbzRNaHpHMExaUHJORWNrVlJ4Q0p5eG0vdXZ1WHg5?=
 =?utf-8?B?cWpDRFRIalROTmlmcHdteCs2cFZKanc0VTA1ajRoRXFiV2lka1hvT053L0Rw?=
 =?utf-8?B?TTFPNFpaeDczN3QyNmtDMElGTWNWc1ZaTldsUnZPWEM4OXZIUGxYRXZ4bmRv?=
 =?utf-8?B?dFd6am50b28zTk44aXF2YXBNR0VHcXJGa2NwMEc2T0xPbFphZndBTXVoQTZh?=
 =?utf-8?B?ck9zOGdDcjVLNmI3ZDRVZ2N5MTZaZFlmT2JVOTJDOCtTdFZ4MFM4aUwwQkVO?=
 =?utf-8?B?dXJkNVFIUWt3NjJzdExJbXdRdTlZbk5CWmdxbFlJamMxZHovSmtCVmw5ZTJM?=
 =?utf-8?B?UThPS2dhQXhWcGhYK2krWHQrUU9waGoxazlIYkRzT3JtWGE4dTdBcmZ1dlFY?=
 =?utf-8?B?RVNFYWVOTWtNTERPL1RuQ2dGNkRPS001QWFVLzNGU1VGbUZ4ZGR5bEdIMnFs?=
 =?utf-8?B?VlJoRTBEQkpmaUh3WjlyZmNRMFljQVlmTUR5dmlQSkxIR0VEb1J3eVdLL1pC?=
 =?utf-8?B?ZjNWaWNZWXJ1Q0NUbTM4TWZHWUpjdTF0S1V0ODR2MmF1eGJJdmV3Q0kwejBm?=
 =?utf-8?Q?RXzOF7Rt7UNMS/uBMqrFYUe7ucPPDswk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXpiY1VUalEzYjRYdmoxekZHSWE5Z0lFQXE1NXAzVUdOczNCcG5qUkY4Q2NS?=
 =?utf-8?B?aS9sQkU1ZU5vNlAwSEE3Q1NvZFJOaDhCN1JuMktMMEt1ZjRzRWMwQU43Z2w0?=
 =?utf-8?B?Yjdzck9iNHpGZ1k4dWlUZ3J3dU1OWFpDM240VzIzVGxnRVZacHZqUENtT1hD?=
 =?utf-8?B?RDBQZnNqRXljN2hLYzJnOUZFL0VyWUQ1MTZNeE81V2FvTjNNRjlMVkF4Wm9J?=
 =?utf-8?B?RUozNHpEMS9zN0Z3a1h0ODl3STB0QVUvTVM0a2tpeC9FVC9VSmNzZnVoT3Bm?=
 =?utf-8?B?OW00UEhHbGxoMFFETWwwT2ZreWtOUnBXSm56Nk5tRXhGMUpwL0Z5ZElSbGpn?=
 =?utf-8?B?T1RVNU81VHRFNC9uVHkwUzQzZFR3UEk4blRVdWlRTEU0d3JnQWpGczY2YzZo?=
 =?utf-8?B?c0xxei9VZ3pCSm9GVmlvQ3pjQUFaOEdoS0d3VEhwa0hmTTFiLzBkVVdNR1R2?=
 =?utf-8?B?NWxjejlyQVlzckE1OVJjMUxoMkJXdWZUOThNTDVkbmxUbC9IS0puWSszaHRC?=
 =?utf-8?B?aisrcDRXcTh3cGQvMkpzSityV2kwczNXMldndmFIK3NXaGdNYlFoUlUxVmNC?=
 =?utf-8?B?UjRGMkdicW5XWXBJU0M5aXFBaktzL05HZkFJdkxpNHNCVjdKYXcwZFFVb0hI?=
 =?utf-8?B?bmNIQUZRQzFVYnlPaC9UZHRNelFINTRybTBIWThDVEROZkdpS0grQzgwRGo5?=
 =?utf-8?B?VlFWVFZ2TXowVGRuSjF0L2dGVFdEam9LMTcvTUpQTHFHNzM2NURpWDNkSzh6?=
 =?utf-8?B?WnZvbHdTVXpaeTZBNlZmNUJzemhTaGZHS3RKYTN5MzA3U1FJYnRvN3o5Mkph?=
 =?utf-8?B?SXBhM2RRRWhRcFRHV3JOSy9Bbi8rNG1BSVlEL1ZiTC9qTlA2aGNXRVpFclpi?=
 =?utf-8?B?R29hU3Q0c1R4V01vZlh6aHJoRjg5Q2Q4bFhSNDZTeUxJQnhydzdBWGxCL1FD?=
 =?utf-8?B?RWJhMFBQVW91ajFuVVRQMTV1eUlSRGxiRXBFYU5VNkprM2tkS2hjLzRMRkJW?=
 =?utf-8?B?dDFva1NNU2VaZGpCbHRRbkp0MnhUYUx1ampIZEhKd0JFZjJQUlhOTVdKcWxE?=
 =?utf-8?B?eEdPNGd2SHR6Z3B1aFdHbE9BRzF2YUxvVnF2dzFLNWJ5UkdLNW1TbjBGOXhq?=
 =?utf-8?B?TG16R0xDYy9uR0h2M2NUVTRvTzhSRGQ1dzN1cnQ5ZktPZzFiL284NFNVczRE?=
 =?utf-8?B?YVVhcWZhdXZLUCt1SEFQTzU0Q2F2UUdibDBwSHZaRnlGRlMzTlRsVTRad2k1?=
 =?utf-8?B?SU5ua1graGRMNVJPQ3VBaXlVK25XTE5sT1FNSzhsYkRtcHpTeEdZOEsyRita?=
 =?utf-8?B?U083Z3d0ZTlZM0lMenVyTmhnR21nWFVEWEl6bVJaUSs0VkgwdDhCN1d3SEJr?=
 =?utf-8?B?b3Z4UTU3eUNBWDNhZ0cxamU5aXdhQys3WnA5Ujd4MXJkNFNkQjdHMmVBY01R?=
 =?utf-8?B?NUxrbGZLbldwNEQ4UXRZeEpRaUpzVjhLdTBRSUJqSWJQaTFKYk5wS3pLVG1X?=
 =?utf-8?B?NzdlcTZMd1lDNTN6WVAwRXNrZUdtUVZMQnVtN0Jqdk1WSUEvbjIrUHRTZlFV?=
 =?utf-8?B?aCtQRFppRmRucGkxUGdJdWkxakRhM29vQVQyM1RxVU9KUnpFZGpMc2I1M1Mr?=
 =?utf-8?B?M0dDNjRIR0h0ZlFualozc25zNm5Ta3ZieklvV2lZK3c3RStBbkp2NGkxTCs0?=
 =?utf-8?B?NUs2WW1uVEI1ajdVZnByOEhlZk8xUThpMHdXRWprQ2RCbHI0V0VNTnBtaytz?=
 =?utf-8?B?OXkwSlFyWnVnYSsvTGxCdGdHMWdpWVN4cEw3L0lIUWltdFhudzZSbXRuNEh5?=
 =?utf-8?B?b056VUluKy9zVWl3OXY2alU3Y1IzWlpWZ053d2pYSjZnNlpUUmttTmordzVy?=
 =?utf-8?B?R0pocHlyZ1I3aGxFMy9NYXJKUHNRZXZyME9HRS9DYTRIcHgrMENsVTlmZ0to?=
 =?utf-8?B?SmtxVy9GbXQ5bzkyZXJ5OEh1bm01L0g5T3huVXF0YTdIQ0M1OHlhak9XcE10?=
 =?utf-8?B?Zm1rMTQ4Y2FIQjZtVDJCK0hFaTRaQ1EzK0loL0hlakk2a2tsZHhGd2ROT0RZ?=
 =?utf-8?B?bVArU0FMbFdOaU1FdFNtN0RyRmJ1a3pkN1h4bHpoL1JQOThWMDdwaytkdWdM?=
 =?utf-8?Q?ugfpborOWJE0Rj7bNuaaymjqb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce08aab5-51c0-467a-0f7f-08de319a6929
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 12:00:39.6058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQLkA/mHpPOGriVKDqomRtqAPGsUGx6rZW+Z9BAdTe0cD5UsV4iFM9Af4IHBhD4W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083
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



On 12/2/2025 1:20 AM, Alex Deucher wrote:
> Add a common helper to remove the repeated logic from each
> gmc module.
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 48 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  6 ++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 23 ++----------
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 23 ++----------
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 23 ++----------
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 43 ++++------------------
>   6 files changed, 69 insertions(+), 97 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 4abed753fc2df..8ac92e7bed315 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -524,6 +524,54 @@ void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
>   	} while (fault->timestamp < tmp);
>   }
>   
> +int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
> +				  struct amdgpu_iv_entry *entry,
> +				  u64 addr,
> +				  u32 cam_index,
> +				  u32 node_id,
> +				  bool write_fault)
> +{
> +	int ret;
> +
> +	if (adev->irq.retry_cam_enabled) {
> +		/* Delegate it to a different ring if the hardware hasn't
> +		 * already done it.
> +		 */
> +		if (entry->ih == &adev->irq.ih) {
> +			amdgpu_irq_delegate(adev, entry, 8);
> +			return 1;
> +		}
> +
> +		ret = amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
> +					     addr, entry->timestamp, write_fault);
> +		WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
> +		if (ret)
> +			return 1;
> +	} else {
> +		/* Process it only if it's the first fault for this address */
> +		if (entry->ih != &adev->irq.ih_soft &&
> +		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
> +					     entry->timestamp))
> +			return 1;
> +
> +		/* Delegate it to a different ring if the hardware hasn't
> +		 * already done it.
> +		 */
> +		if (entry->ih == &adev->irq.ih) {
> +			amdgpu_irq_delegate(adev, entry, 8);
> +			return 1;
> +		}
> +
> +		/* Try to handle the recoverable page faults by filling page
> +		 * tables
> +		 */
> +		if (amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
> +					   addr, entry->timestamp, write_fault))
> +			return 1;
> +	}
> +	return 0;
> +}
> +
>   int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev)
>   {
>   	int r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index b62fa7e92c79d..e8e8bfa098c3e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -425,6 +425,12 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
>   			      uint16_t pasid, uint64_t timestamp);
>   void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
>   				     uint16_t pasid);
> +int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
> +				  struct amdgpu_iv_entry *entry,
> +				  u64 addr,
> +				  u32 cam_index,
> +				  u32 node_id,
> +				  bool write_fault);
>   int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev);
>   int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
>   void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 47558e572553a..0b385a15194d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -115,27 +115,10 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>   	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>   
>   	if (retry_fault) {
> +		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, 0, 0,
> +							write_fault);
>   		/* Returning 1 here also prevents sending the IV to the KFD */
> -
> -		/* Process it only if it's the first fault for this address */
> -		if (entry->ih != &adev->irq.ih_soft &&
> -		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
> -					     entry->timestamp))
> -			return 1;
> -
> -		/* Delegate it to a different ring if the hardware hasn't
> -		 * already done it.
> -		 */
> -		if (entry->ih == &adev->irq.ih) {
> -			amdgpu_irq_delegate(adev, entry, 8);
> -			return 1;
> -		}
> -
> -		/* Try to handle the recoverable page faults by filling page
> -		 * tables
> -		 */
> -		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr,
> -					   entry->timestamp, write_fault))
> +		if (ret == 1)
>   			return 1;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index ba59ee8e398a8..7a1f0742754a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -114,27 +114,10 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>   	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>   
>   	if (retry_fault) {
> +		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, 0, 0,
> +							write_fault);
>   		/* Returning 1 here also prevents sending the IV to the KFD */
> -
> -		/* Process it only if it's the first fault for this address */
> -		if (entry->ih != &adev->irq.ih_soft &&
> -		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
> -					     entry->timestamp))
> -			return 1;
> -
> -		/* Delegate it to a different ring if the hardware hasn't
> -		 * already done it.
> -		 */
> -		if (entry->ih == &adev->irq.ih) {
> -			amdgpu_irq_delegate(adev, entry, 8);
> -			return 1;
> -		}
> -
> -		/* Try to handle the recoverable page faults by filling page
> -		 * tables
> -		 */
> -		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr,
> -					   entry->timestamp, write_fault))
> +		if (ret == 1)
>   			return 1;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index dfb06baea1ff1..145fcefd1c783 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -110,27 +110,10 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
>   		hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
>   
>   	if (retry_fault) {
> +		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, 0, 0,
> +							write_fault);
>   		/* Returning 1 here also prevents sending the IV to the KFD */
> -
> -		/* Process it only if it's the first fault for this address */
> -		if (entry->ih != &adev->irq.ih_soft &&
> -		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
> -					     entry->timestamp))
> -			return 1;
> -
> -		/* Delegate it to a different ring if the hardware hasn't
> -		 * already done it.
> -		 */
> -		if (entry->ih == &adev->irq.ih) {
> -			amdgpu_irq_delegate(adev, entry, 8);
> -			return 1;
> -		}
> -
> -		/* Try to handle the recoverable page faults by filling page
> -		 * tables
> -		 */
> -		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr,
> -					   entry->timestamp, write_fault))
> +		if (ret == 1)
>   			return 1;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 778ad7ac6d086..97a04e3171f2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -583,44 +583,13 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   	hub = &adev->vmhub[vmhub];
>   
>   	if (retry_fault) {
> -		if (adev->irq.retry_cam_enabled) {
> -			/* Delegate it to a different ring if the hardware hasn't
> -			 * already done it.
> -			 */
> -			if (entry->ih == &adev->irq.ih) {
> -				amdgpu_irq_delegate(adev, entry, 8);
> -				return 1;
> -			}
> -
> -			cam_index = entry->src_data[2] & 0x3ff;
> +		cam_index = entry->src_data[2] & 0x3ff;
>   
> -			ret = amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
> -						     addr, entry->timestamp, write_fault);
> -			WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
> -			if (ret)
> -				return 1;
> -		} else {
> -			/* Process it only if it's the first fault for this address */
> -			if (entry->ih != &adev->irq.ih_soft &&
> -			    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
> -					     entry->timestamp))
> -				return 1;
> -
> -			/* Delegate it to a different ring if the hardware hasn't
> -			 * already done it.
> -			 */
> -			if (entry->ih == &adev->irq.ih) {
> -				amdgpu_irq_delegate(adev, entry, 8);
> -				return 1;
> -			}
> -
> -			/* Try to handle the recoverable page faults by filling page
> -			 * tables
> -			 */
> -			if (amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
> -						   addr, entry->timestamp, write_fault))
> -				return 1;
> -		}
> +		ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, cam_index, node_id,
> +						    write_fault);
> +		/* Returning 1 here also prevents sending the IV to the KFD */
> +		if (ret == 1)
> +			return 1;
>   	}
>   
>   	if (kgd2kfd_vmfault_fast_path(adev, entry, retry_fault))

