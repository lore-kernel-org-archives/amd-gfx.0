Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93600D3E79C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 08:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 230F210E798;
	Thu, 11 Dec 2025 08:19:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yWvd5rl2";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010031.outbound.protection.outlook.com
 [40.93.198.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61E9210E798
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 08:19:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whK32E4AkdgG6Ny8bXaKJMc7A1Ek8UZx/a4PvU+YS6HILkIaFuFtlhSQJxYz0+0EshTdNCvp9At/q9S7kHPI7RukZvbgnWsVfUgAsoUq3ZC9mM3p+Ar5ypQRvymbMdrTMAa4SrdBxgveg7JUt83q2KwV6s0iUKSPUk13qCZc0Z5LAErzmZd3NgIIztbCPVswyTNQVnpVIemWbZrfq4LV3w4HN+EKmyUta9llhZB4wOxqh2twRlO0iHasTBoRcCrSzsLq0BFOYp4AO1Ngb5GHrj8jvGddSICLUNyvi2q7iM9tNLwFnydG5H/M4WTQcYhE1Knz/DZSXqfd2ykiWG98Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TN/RGd8ewS1+c1+24xVB9gYl9ouCoBeEz8ZR66MYRqE=;
 b=fJFR7CLrO6ABkYtxcxIZoqJaMg6d+R/xNvSgIDgT8GXhMUez630vjKHXNiN9Kloknv2qATkHN5s3Z0qX/Bp0DN8ztXHjElYOxBH1J/W09PXGM4MF2cF0bABorqZAOaqXxUAztdNlMmPvqakBl1AFyrN9LttvcrFLVAFJSfirPe0j/6OzZMx5R07mQ3rKICJY+IbJ7QNAKdiZiz889onacKN0BPj+J0zUK8xjS/Jvnjww74ZdmMiFFEEOFPVUU/GkgLcL/QP5m4fZHb2d//mp+nJYUv2PnmbxiTKbIkiplhz1EEf5vdZiquUo4jFguJ3MLZAzyuyjj6XZb/IYow8AUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TN/RGd8ewS1+c1+24xVB9gYl9ouCoBeEz8ZR66MYRqE=;
 b=yWvd5rl2QvWjlSDdw/QCzsmPVKiWLGZvAZYB7I2Oa/MchcqoZqe/m5lweV7WpuluLRWpPzzNQfR5m28ScRmSc3OWick619f7sTzqkRE4fERZxfr/02VLg99CIWMf0vIRWxUq+o3VIy7lRPU/35Bs4lAfug5S039bSkfMTJmqFB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH3PR12MB9341.namprd12.prod.outlook.com (2603:10b6:610:1cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 11 Dec
 2025 08:19:37 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 08:19:37 +0000
Message-ID: <e0a8b4b7-1d42-4652-a82c-7ef663c4584f@amd.com>
Date: Thu, 11 Dec 2025 13:49:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: add PP_PCIE_DPM_MASK support for navi10
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, alexander.deucher@amd.com
References: <20251211051657.652580-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251211051657.652580-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH3PR12MB9341:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db106a6-d6de-41de-1f4e-08de388e05ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFJXZGZ6cVdMU3JCTXY0eTBWZWVmU2dhckxNS2JGY0IrTUJUbnRxTVBXelgv?=
 =?utf-8?B?SUFWdEY1N3RLd3kvblBIUm1GOHFjQ1JXNEl3V3FRMGZhd1kwUXBHdHE4cndR?=
 =?utf-8?B?NkFod2JUOGlkbWdMaWIvek1jclNCT2pubVppVjJUcTgxV3kzdWc1OXhDNlBl?=
 =?utf-8?B?UHRqWld6V2JSU2VyU2dwQmR6OUVudWh1bkdVZWdqamlFTUdScGl5R3JkUjlY?=
 =?utf-8?B?Y3RyYTVqZHJmdVR6RmV4VnhoS2VaTUI5NTFYRG9ObXZENVdoOTE2TTRibldH?=
 =?utf-8?B?VzYreHRvdzRQRFRDTlY2MmFIMGlzUHJCcENndWtZV0lhTVVsYnBlTjFnR1V3?=
 =?utf-8?B?NXc4QlBLQ21kcEdicE5HL0NqTUpwYTJrSDZNdmJkb2dLV2x5b0RkVXFLOXo3?=
 =?utf-8?B?d3FkNDVJdXI3Q2RxL2l5RStmNGJrZ2pXZUpYbm5SSzY5aUtwNjBsaXFJVGJa?=
 =?utf-8?B?eFpaUkoxMnZUYUJmNU12TTFJQk9rMnp0VmkwSit2OGwrdHI5bk9JWlZQaHlF?=
 =?utf-8?B?by9idHVIM0hLbHIyTVhvMFhscVlGSFUwM2s2LzAreVhGZko5WXBkVG0xZGQ4?=
 =?utf-8?B?RzRLRWUyTkVlcFFCMDBJYnRLTzc3UXVvUExUcXY0Wi9rVnV3T2RvZ3dFbmR2?=
 =?utf-8?B?RU9XZ2lYOGVZcjNlTTNtSFNIQkN5TjFNWjh0b1F4WHhaUEQ4aHRYc1NIeldG?=
 =?utf-8?B?TU9kUlJ0a1EyWnhFMUZTZFFxcDJoMEF1VDd5L256a015bExBUXJuVnpGR1RZ?=
 =?utf-8?B?Tlpua0Q5Ujd1Vm8vNlhBWlpqb2pLVmNJbXMvRmMzMzg4bFE3bkpnZFlxdit1?=
 =?utf-8?B?SE1LTEJBemI5U2JsRkRBblVNQU9BZ01rSGJkdEJ3dXBiTVdibFJic3NOTy9C?=
 =?utf-8?B?a0pqV05PeXBVL2wrdENtcU9xNFlzb2lTNHBzSWVqUXFEY1dmM2wwMGpTYVJr?=
 =?utf-8?B?SHVTR1pSMXhUUGxPYUpMV2FnK2RmQ1JhQ1l6a3pLOTMyUU5jTDlkN0dJUXdp?=
 =?utf-8?B?V0NMcDhrN1FYbWR0YmVIMjE5dTFjWDZTSVRqakdLaTdIWmJXWnpBNm42bTVy?=
 =?utf-8?B?QWVpOFExV01majVpQWpWVUlwdVhTQkRFMTJLVVpIcXdzWGF3ZlNmU2dXd05p?=
 =?utf-8?B?RVFuRGE0bFEzQk5RanEzMkJML0FCdjY1QzA1L1FoR1BoWTI3S2FKQWNaQzFI?=
 =?utf-8?B?eEdHZHcyeDZ1dmpqeGhMajEzbmQ2WWNKOTdlSXlHRG1LYTZreVFydU9yZ3lW?=
 =?utf-8?B?T2p6MDZZbitCMDNER3krS2VVNnNXTWNnZDlaUDNQUHBpbG45RUJVaDJnRU84?=
 =?utf-8?B?ZEJNR29GS3VZOVBzRTRrL3dJV1B5RzhkaGdTTUp0aGNUSnlIVTFDMlc4dUt0?=
 =?utf-8?B?c2c1SkhxaVR4RVlnek5uNjRuNXVlMjhOOHBJTFIzcGR5UmNaWmJiZzA4SHJ3?=
 =?utf-8?B?czVrbytTcHFEd0RhZU1xNjBpS0lTamR0MUd3RnRSRFpEYWJRcWQ4Y0o1TXFZ?=
 =?utf-8?B?ZjUxWWdPZU1hUWl6ejE3bk1NM3ViU25BUG5PSEZEVDhZa0RaUXZqeFJobTVr?=
 =?utf-8?B?bWVFUU5hbDdRNi91Qm00RmVHOEJRL21mTG02SHcxVWNreGloaVdzRHhDTGU5?=
 =?utf-8?B?TXlXeUgxblZ5L3E2dXJoRGxvNGx4YVhqN3RhbDBqRXV6NWxIMVMxSUxPbzgz?=
 =?utf-8?B?NXIzOXRFYUpsVmgzekd6RlNuUXJmU2QxbUJPZ2FwOGJUWDJJN2wzZENaL3Bo?=
 =?utf-8?B?bFdseHFMbGNFYmk0VzF2bFhoN1hPRjFQZnE5WjhMRUY1N3lTbndIVkFVL2Vs?=
 =?utf-8?B?TFBkRTlQQWNQOGNCWFY5WDNxRHpWSmR3SzlWL2lNSDlSSGFWaUwxWSthanJK?=
 =?utf-8?B?OFgvb3VvSjhRc2ExVDg5eXRJM3Y5OVpYQjZ4TTNiNWJyVjMwZFRYWmpRaUdn?=
 =?utf-8?Q?qlaIembVAY2A66P0MYK4KOmyClXqXkMU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a01qMEpvY2JnRkt0dGNrNGkyTG9aTDU4RklST05qRjc3dzN1azlxZzNydmpG?=
 =?utf-8?B?VXZqWFNZUk9nSGU5MWVYenNSdXVGMytKb0tBR1pLdmFxeGFTLy82aVNaS0M1?=
 =?utf-8?B?YWcycm9yL1NxbitPNThWVEV5Z0JDTDRCV2pPcnBqMUF0VTRQS2RkZzBBNFlV?=
 =?utf-8?B?WUpkUWtQcStGSFVObWVCak1iMXJoTnJrMFVCdmE4WEk1MFMvSi9YcklzaDlH?=
 =?utf-8?B?b1pCQXJia3RjamlxVlRQM3JPRnFJREk1MlA5ZWxLU29tWmNOcmYyc3FhVzF2?=
 =?utf-8?B?UVJ5ZzFLZVdxUTZBWnhqcjRPbmtNRzFSWVRwZ2gwRGVsZ05RQ1loYWxyTlZu?=
 =?utf-8?B?RWR3clJ5Z2FOdFFQRWYvUENBTUZ3ajhuU3RQNVFhQ2lOVGtacGdtNGpEZjVl?=
 =?utf-8?B?dDFVeVd6SGw2L1JlT0U5c0NCZWRaZTBGM1VHZExjNUZrcHZqbVhXVzhqaVRy?=
 =?utf-8?B?RVlLTkRjMkJ2cjIyUUQ2N2FDRHI3KzBDdkVyWkhzVTYzTFgrMm1lTDlVQXUw?=
 =?utf-8?B?VTlvZCsvdUd2bHJIbHd3RlFOUTFSdVc3OCtoUXpxSHE2cS84Skh0QXdvM2RB?=
 =?utf-8?B?UEIrUS8xMjlPUjEwRjA2WG5URW5aWXVBdEE3S0FEZ0ZTV3BCdE1wbU9ndlBS?=
 =?utf-8?B?cVAyRGlmRVRQSEV0c09oODNUd3kyL0VVdXVKVndjbXJNL0RWdDQzZkIwOEJI?=
 =?utf-8?B?Y05YZTdsMyt0ZDJ5ZktleWRxUGlVWURDYjFzd0Y1YTlOVnY5WEZRNzFwUm1B?=
 =?utf-8?B?Sk5EVXB4RDNzaUVLWGRoRkZQNm85QkZLNkxrdVVZOEdNR3RqdU5yNmVhVjNL?=
 =?utf-8?B?SHp2REFNTWp3SVBKZUtBVjNSaG0yOGQwWHU2TG8yR21rZ3phL0Rjbzl1U3Zw?=
 =?utf-8?B?TEowUjBDUEt2OXB2bW56Z2kyUkl1UlZaTzlSOTlZdEY3cVZoY1RMUVZ0Z0ZF?=
 =?utf-8?B?UWZmYkFWNnJuandickNWQ3ZocldNZ0g0STZaZDIvOGdLUGdadnYxVlNibWIy?=
 =?utf-8?B?M1EvekVpMDN4QndPRnZveHcySmZFZk0xTUFxS2llaUxOTGdjbStKeDVRd05Y?=
 =?utf-8?B?MnB0MkVMZktQRnRRd01abjA2c2dYdVQ1R01mVGkxVTY0ZG1NeUR6clNsQTNu?=
 =?utf-8?B?aVl5dkJFZGk3UkdROEZobU43WEpUbktOOXdpOG9FTlQ3S21ZYThiQUMwaGZw?=
 =?utf-8?B?cHhycVE2R0haUzdPM3VES043SjRlN01zOU0yWjhlTzRVd2g3bTZndEF0a0FI?=
 =?utf-8?B?NTh5UU1ocTdHNEU2c09mMzRDUk1HMVQrR3AraklHWW1SSExwSU1QbkVwSHJl?=
 =?utf-8?B?L1Z6UVBlTFlmMGpuSC85S1VZVUVKZ0VNbFZiZGNPT3E2VFVWeWNUTFF3alBN?=
 =?utf-8?B?SHRvaUF5RGY0ODY2YUhSS29RQnNKQnVkei91THpTbjlzdVljTVF6N3Y4QUlS?=
 =?utf-8?B?UTQ0OVBLRm5Eakh3V0c3QUFuTXBSbC80eVNzalk2TWlWZEMrRk9nUnZ3OXYw?=
 =?utf-8?B?QVRuZFJDY1poWmg5TnM4ME83Mnd1OTB2WFJBSHU2WmZwOWs5RVMwRFprZi92?=
 =?utf-8?B?amhMcW5xYVRkMm1lUzZzQ0RmMHNnenA2ZjM2NnZybGRWNXN6b1B5Njc5VW56?=
 =?utf-8?B?T0tWL3llUjdmZDRQY0s1TFI1bS8yMzlzNGtPUVFxYXBZY2VzY083Y25oMnN4?=
 =?utf-8?B?Q3JPSG9yWEd4TEtpaSt0T0tCNE4zMkNvTFhxcDJkdWNzckhoY2VFZVBZUkgv?=
 =?utf-8?B?ZExHUE90ZXZJRlNWa09tdWxvcEJDSkFMRldsZkRYYzVwMll1bVZ6Ni9Hd0xJ?=
 =?utf-8?B?c1VRYjhUSUJUbHJTOGVodnNVdm1MWTZrdmoxWllGcmdjMnZOTlZlMEwySjRz?=
 =?utf-8?B?VHpnYndDNUVpeCszY3d6WFArR2xYRS9MWXl6djQyN201Rm45NWV6YUE2MVZJ?=
 =?utf-8?B?MncyR2xNWkNyME1EOWVLMVhUSFRiVzYzTVVSSS9sUDhScjQxMUxhS3A1TnZi?=
 =?utf-8?B?c2s0MVE3U2JVQWtvazBkL01pUE1tck1tSGJEbEZRSDhlTmJLOHlRaGZuN2NW?=
 =?utf-8?B?dzNRTmRUUHhaRytPVGd0OVVFY09CMjkxWTlmU25WS2xuYm01U2ljK3E2bHpN?=
 =?utf-8?Q?/KeVwllr42ilhRNlTh9kJGPux?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db106a6-d6de-41de-1f4e-08de388e05ec
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 08:19:37.2496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xxf7ee8l2rfGShx1Oaovde019LBu8vYTEYFog8H07unisWZDvrPjwjmE+Hh7JI0i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9341
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



On 12/11/2025 10:46 AM, Yang Wang wrote:
> add PP_PCIE_DPM_MASK support for navi10.
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 66 +++++++++++++------
>   1 file changed, 45 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 0c26fe6fb949..fab19174343f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2192,39 +2192,63 @@ static int navi10_update_pcie_parameters(struct smu_context *smu,
>   					 uint8_t pcie_width_cap)
>   {
>   	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
> +	struct smu_pcie_table *pcie_table =
> +				&dpm_context->dpm_tables.pcie_table;
>   	PPTable_t *pptable = smu->smu_table.driver_pptable;
>   	uint32_t smu_pcie_arg;
> -	int ret = 0;
> -	int i;
> +	int i, lclk_levels = NUM_LINK_LEVELS, ret = 0;
>   
>   	/* lclk dpm table setup */
>   	for (i = 0; i < NUM_LINK_LEVELS; i++) {
> -		dpm_context->dpm_tables.pcie_table.pcie_gen[i] = pptable->PcieGenSpeed[i];
> -		dpm_context->dpm_tables.pcie_table.pcie_lane[i] = pptable->PcieLaneCount[i];
> -		dpm_context->dpm_tables.pcie_table.lclk_freq[i] =
> -			pptable->LclkFreq[i];
> +	       pcie_table->pcie_gen[i] = pptable->PcieGenSpeed[i];
> +	       pcie_table->pcie_lane[i] = pptable->PcieLaneCount[i];
> +	       pcie_table->lclk_freq[i] = pptable->LclkFreq[i];

Can this be simplified if *_cap is taken care while assigning it here?

	pcie_table->pcie_gen[i] = min(pptable->PcieGenSpeed[i], pci_gen_cap);
	pcie_table->pcie_lane[i] = min(pptable->PcieLaneCount[i], pcie_width_cap);

For DPM enabled case, now the table will reflect the proper values and 
further check is not required.

For disabled case, all levels may be assigned as

	pcie_table->pcie_gen[i] = pcie_table->pcie_gen[lclk_levels - 1];

once pcie_table->pcie_gen[lclk_levels - 1] = 
min(pptable->PcieGenSpeed[lclk_levels - 1], pci_gen_cap) is done.

Thanks,
Lijo

>   	}
> -	dpm_context->dpm_tables.pcie_table.lclk_levels = NUM_LINK_LEVELS;
> +	pcie_table->lclk_levels = NUM_LINK_LEVELS;
>   
> -	for (i = 0; i < NUM_LINK_LEVELS; i++) {
> -		if (pptable->PcieGenSpeed[i] > pcie_gen_cap ||
> -			pptable->PcieLaneCount[i] > pcie_width_cap) {
> -			dpm_context->dpm_tables.pcie_table.pcie_gen[i] =
> -									pptable->PcieGenSpeed[i] > pcie_gen_cap ?
> -									pcie_gen_cap : pptable->PcieGenSpeed[i];
> -			dpm_context->dpm_tables.pcie_table.pcie_lane[i] =
> -									pptable->PcieLaneCount[i] > pcie_width_cap ?
> -									pcie_width_cap : pptable->PcieLaneCount[i];
> +	if (!(smu->adev->pm.pp_feature & PP_PCIE_DPM_MASK))  {
> +		if (pcie_table->pcie_gen[lclk_levels - 1] < pcie_gen_cap)
> +			pcie_gen_cap = pcie_table->pcie_gen[lclk_levels - 1];
> +
> +		if (pcie_table->pcie_lane[lclk_levels - 1] < pcie_width_cap)
> +			pcie_width_cap = pcie_table->pcie_lane[lclk_levels - 1];
> +
> +		/* Force all levels to use the same settings */
> +		for (i = 0; i < lclk_levels; i++) {
> +			pcie_table->pcie_gen[i] = pcie_gen_cap;
> +			pcie_table->pcie_lane[i] = pcie_width_cap;
>   			smu_pcie_arg = i << 16;
> -			smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_gen[i] << 8;
> -			smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_lane[i];
> +			smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
> +			smu_pcie_arg |= pcie_table->pcie_lane[i];
> +
>   			ret = smu_cmn_send_smc_msg_with_param(smu,
> -							SMU_MSG_OverridePcieParameters,
> -							smu_pcie_arg,
> -							NULL);
> +						      SMU_MSG_OverridePcieParameters,
> +						      smu_pcie_arg,
> +						      NULL);
>   			if (ret)
>   				break;
>   		}
> +	} else {
> +		for (i = 0; i < lclk_levels; i++) {
> +			if (pptable->PcieGenSpeed[i] > pcie_gen_cap ||
> +			    pptable->PcieLaneCount[i] > pcie_width_cap) {
> +				pcie_table->pcie_gen[i] =
> +					pptable->PcieGenSpeed[i] > pcie_gen_cap ?
> +					pcie_gen_cap : pptable->PcieGenSpeed[i];
> +				pcie_table->pcie_lane[i] =
> +					pptable->PcieLaneCount[i] > pcie_width_cap ?
> +					pcie_width_cap : pptable->PcieLaneCount[i];
> +				smu_pcie_arg = i << 16;
> +				smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
> +				smu_pcie_arg |= pcie_table->pcie_lane[i];
> +				ret = smu_cmn_send_smc_msg_with_param(smu,
> +								      SMU_MSG_OverridePcieParameters,
> +								      smu_pcie_arg,
> +								      NULL);
> +				if (ret)
> +					break;
> +			}
> +		}
>   	}
>   
>   	return ret;

