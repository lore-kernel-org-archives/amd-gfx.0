Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785DEC021A4
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 13:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 352E710E44A;
	Mon, 24 Feb 2025 13:41:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PZd8a5iM";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EEB010E051
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 03:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpsvZCPMVCrUFrYN3NBgXI68SyrSjVZuPrwQ4MKENpLdFIZvacIwTE4xII//foCV+Bu2F0uFG+lj96T9Hufa69glsVgd1PzBrp/cxL5ctZpRkWuRCB8+OwEmULAEs9nAzIfBbc8k0wFTks0DmjtH3+R8o09QH0YHR0k7IBRzu+H9wVlpeO3yMOSjQjMLBA5M4GhOUwWB2/alCGF/scc66I017qP762uW3Q5AfQ4ONyOVhpx8DkFw1FpuSWFfRIUy8V9oe972qTl/fvGsUJ9vw5zpJV8XqNx757ZzOi8t9BVrFJQEWbZCXzCO57Os5+2HTBFj4/sdat/3h15pVscNWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vz0OdHzXgcR0lefaT8QCiKwTWB5CsW//0zMQgpoyYu0=;
 b=H+cVgTBHsV3+KSS5oxeVi3KuBlScYSNPxEh9UxVDHIIaDDbs36BUyaOj24CA7J4DsrYQ7AR42BBw3umAkGRu1VPi+qROuWr4qUbPtj13HJ2bFJTJN/5LQ3FN46rQ42fcgdYmXGYOKECvE5icNIqDZHQhfoSInqGvXF80xAnf/Tmq1nwr2EOt7FYePPiz2lQbxuxVTNWwcWg7WAZ0fzgQDU+9nJdl7n0Pqj+0W5TSmuEfmp0nxDSKFvlzwkEYukAopLZcJNJ4ZUvGqakEKclaqEwG7DD9Tei0eS3+EUFpQarenXYv3PEPAqDCrHT8FvVZSaxbQqMhFqHafH5fTnttBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vz0OdHzXgcR0lefaT8QCiKwTWB5CsW//0zMQgpoyYu0=;
 b=PZd8a5iMwfCT6FpfgSOjM0LE1OvF5xJx4+l2RjHzOufwHHyNs72TgA3WsqN9TD9ROnDEbvGRk/pu/G8Q+UMF+kpc5GijFwj67tiIDBqRisM82fFKJv1rgxeDAFaBcFXEdcP7mSbP6onO0ZQiuF2JpNbCxYEYvTIhYAKd9R4A7z4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB9503.namprd12.prod.outlook.com (2603:10b6:8:251::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Mon, 24 Feb 2025 03:53:45 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 03:53:45 +0000
Message-ID: <3d751cf6-d33b-4e6b-aa28-2eaa39cfe6c0@amd.com>
Date: Mon, 24 Feb 2025 09:23:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: update SDMA sysfs reset mask in late_init
To: jesse.zhang@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 Tim Huang <tim.huang@amd.com>, Jonathan Kim <Jonathan.Kim@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20250224024635.4101253-1-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250224024635.4101253-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:4:7c::35) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB9503:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f65813-2650-4a9c-fb16-08dd5486d65b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVFCR2lZOXNJR1J2OGE4QjhFcE9rQnhqNFZrVHcydFByUjl4OGNRNkhuNDEw?=
 =?utf-8?B?SVJHc01adWtQcmE1STJqRm5sakRkd1NERStkME5hL3gxNmlaTXFMcTFETFNl?=
 =?utf-8?B?cDkvdVZHbGltL1dPTkhrWDhoam5wcDFpNlUvLzZDc0Rjd0o3bmRJamNyalU1?=
 =?utf-8?B?OWUvb3pBYUZPa1lJcEdNelYrbG1UVmFHRWkrL3VETWJMWkRhaW1mUThIb1FS?=
 =?utf-8?B?OXJUdnRMeTJRNnBCYlRiNnVEZlFhZGUzRnJiQ2UrSU9mYlI4aXg0KzlUNEpS?=
 =?utf-8?B?SjlHOXo2TENKaGdjLzhwdXZ5VGEwWitLellqRElNNWJTK0tEbXZVLzNiNHZI?=
 =?utf-8?B?R1pxZmx1U0NvYmhmZks3UThyc2hvK3RyWVA4TE1wOXNSQUJubXRvQUV2K2JF?=
 =?utf-8?B?YU1wVTdIbU45Rnl2bXVNT1lOWFh1MVBZdTlMSXV5U3pVZUpxRCsrR08vOVow?=
 =?utf-8?B?bS83cEJzOGlmUlE0MnU1OVdTSzFSTXEvWnhabHFja0FVcXYrZHJ0VXpoTjIw?=
 =?utf-8?B?YlE5QmJtZUJSSDIwL2JjN2hLWnJhTnFqbk9oc3RUbWwwZ2VxZndaRzRiNzRE?=
 =?utf-8?B?M2U5K2xVaTlwZVpibG5NVG1xWXBYdkp5Z3NUaE41TEZxWUcxUlV1blRhYXBs?=
 =?utf-8?B?aGhVZ05zb3VCMTdQTTVtajlZTkN2OWhVakU2dXoza09TWjNRUFhyMGREZExr?=
 =?utf-8?B?emFQODdkcUg3YWN4UlQ2bGRIQXEyVWhRSHFVL2l3ZUNHZ1J0N2Rkd1hQYjVF?=
 =?utf-8?B?QXhqcVM2eFlRMnIwdFlOU3lMS0t5UDN1Q1lCQUlZY3ZRYUlmYlZobG1teWY5?=
 =?utf-8?B?SlMvendRelNEZkFHMWtXbHY4Y0ViWUt0b0pEU2tNb3ZqZUNQSkZXRTdsOGxT?=
 =?utf-8?B?UDRsVmwzUjZKMFVSOHo1TkhhYUh2Q3lkaDYvWm9mNm1GOHphb2NCOVBRS3NS?=
 =?utf-8?B?a3VVczFYOWcxczAyNXU0blZva29XNFgwY3BWemkxR0FuSE51YTltTDJycWJ5?=
 =?utf-8?B?WFM4Ulk1bWVsQUhtY0RKUE92dElkN1ZoQ3RIT2p4RkJhL3hSWE1XVjY2Y2dL?=
 =?utf-8?B?ZksvZURvQ0FEdHQ0Y3M5UUV6NVF5ZUhtQURXY010dTF1MW1CTmNLck12aGh4?=
 =?utf-8?B?ZkpPaWdmTmF6ZGZpZ1JXeC9XRjcxc05lbktzd3ZJbERjd3VVekNZNkdicTRH?=
 =?utf-8?B?NEtISnpHK0VlUFBaUjJVMkpXZjVFRFg0VkVOY0s3eHFJTkZkWi9pTHl4Q3ZX?=
 =?utf-8?B?YWlvSWFUVVF2cGVIQXdNc0VBVjlNUFJkaXJwMGZPZlpUeTV3ZDVxL1hUWFdC?=
 =?utf-8?B?cjAvUTBHbzQ1c2sreEZQL1VFWlRxTVB1QTNQTS9ybTJ4VHlzR0ZXTXZDamxH?=
 =?utf-8?B?WmNBdm4xOTdxUHVPaktyU0VUcm54Q2ZOV0hJanJTb1NjTEovR2NaYnl1OHNS?=
 =?utf-8?B?MTJKMzhWcU9Kb0ZqdEZESEJ3OHFtdGQxODJENndiQ1NDbUR5OTFMRWk0cHJa?=
 =?utf-8?B?ZFVNRk1pUnR5SGJBcUpyVkdBbVY3R1M1MXczQThaaFd4YzNJNUFsb2lMOW95?=
 =?utf-8?B?TS93dEJZSTlYYUdtdE9wLzhVNnpOWFcwbksvTDc5Z2poOXk4blBESUd2M29m?=
 =?utf-8?B?eFV3YXYwdEZEMFRtbGdBUXQ3OFlqU3BnTVo1elYrWms4aGR5djBuRlRIbzYx?=
 =?utf-8?B?Ynd4Nk4zUmEwNGNjZ3NOcDExMjlyN1NRUzg4MWNIU2dSLzhYY3VnTnNaNVpR?=
 =?utf-8?B?a2hPK3NMY0xpaVJFMGRERFBlWm4vM2Joa0srYmk2TDZuemN3QWZlcE5vSTRJ?=
 =?utf-8?B?SjlhMUN2RG5DYnpXTWtYWXVFNjcxOHcrY0xkNG1uQmxrSW1oL0dZOWlaWGM1?=
 =?utf-8?Q?KuWJYeSuBSJiQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3B5RVpULzg2bkNhRTg2QlVJUm84R2FUMWZld0NSRkdPbWVJY3RPZzdYb1FY?=
 =?utf-8?B?bGNxT2NPVlREb3NRdWVpRC8zUHBBamRiTUlQa1NoV05XVFRXaHNiT1k5eFpu?=
 =?utf-8?B?SkhyT0NWK3k2V0gxcU1RTVAxSEl1MjJORi9xRXV5amJPNEcrRnIwNjVZWE5G?=
 =?utf-8?B?cFdES09hMlBJUGw2U1laYk5QczgzeCtocE9kTXV4NzFRem9MNE96NXgxUUpR?=
 =?utf-8?B?ZnRFUjVtMUh4Tktza294OW9lZGt0NjUzU1NGTDFPTjgzRFpOR1lsSEljWjEv?=
 =?utf-8?B?aDVrcUsvR3NRUG9pQmU3eEIvL25qUU1ReTU3ZWN1cEUvQUlwaG9hN1RVWFNM?=
 =?utf-8?B?U28xQjFTanRpK05XM1BVTm15clYzTVNTVXZlK3laS1dmbjZGOVE5ZXRkWHZo?=
 =?utf-8?B?Z2Nram9QYm9Zd1EzdkVjYTAxMmFGWmpxUEM4THN4ZmxENG9ETVJ3VkdKTC91?=
 =?utf-8?B?VXA4eUF5YXNDa0VuTldLNnhLSk94RzJ5cVdiN3dnN0JGQklkdGx1QnMyLzhy?=
 =?utf-8?B?bk9UNEpncGJ4MzlkZXpMY3I4Vk9GMWVxOER0Y3lZNU9PMW5RdnE4b3d0UWds?=
 =?utf-8?B?dlBRRytCWDBzSFBmSTcveWthRElTclY0Slg5MzhEUFgrdlFXMHRKUlBDMjho?=
 =?utf-8?B?V29pR1ltNXA2WmVCU3FXb0N0c1hpbGxNczh3Q1VBNFZ1VUliRGZibW9OZ1JS?=
 =?utf-8?B?eGJaRWlKWUh1ZnJXNVZMRjJxVEFCVm1laEE0WFRRY0JCSW84MEIxbkVnRUNO?=
 =?utf-8?B?eFVXU0xWTThUa2xwK0U4RmlsMXMwRDhmbjc2OHFDQVMvdEJTb3FETG1nUFJR?=
 =?utf-8?B?UmtaRURmZGNncEl5OUVsbUFKcjVsRkcwc0ozSW93T0hkNlVsUTcweUErK08y?=
 =?utf-8?B?eDBocXgvWkxtUVFzSUs1N0ZKcjR2ZlN1ZXhidUdyWHNSUnlvUTFtcWZ5WHAx?=
 =?utf-8?B?WTFFUWNPSWpvUFNISVIzZE8xenUvMVZsZG9PUFQ3emdtMWFZeVJKOGJtRSty?=
 =?utf-8?B?aXdVSTNtQ2l3bnZYZWNRQ1dvNzQ1d0hXQTA1MGFmUnFnMlJyMmJzaTU1QktD?=
 =?utf-8?B?bzdSQ1U4b1RFTDJLRlVLNE5lUHJqNDBkQmR5bXkraUdPRlFBaW13cVJmb2VM?=
 =?utf-8?B?M1lpVU9iaXo0YjlaZWR1UjNXMitpak5lT3BWWTllQlUxa2tpeDZMaExoV2Fm?=
 =?utf-8?B?eHhSbDNzRytyVWpoVDd0dlY4SkN2cStoK3JvaTVCcTAxLzI5QTVPc1ptK3JC?=
 =?utf-8?B?aHUyR3R6NUdRcDkvc0RnYU5GTG9KSERFRCtJdjZZSE52SUx1MUplS01IVEJV?=
 =?utf-8?B?L29WY0d1SzQ5eTVIaEI0RDQrRXZiTzUyVmxyVkJtMWpBSlhRWWk3REZTcFlB?=
 =?utf-8?B?VlhQMmxaNElRaloxZWVGL2ZmMEFJbnVXcE1ZTDM1eG5PM3JxRXNURHU3Z2Va?=
 =?utf-8?B?QUgyWFByZzBSNER2VU04aGtLK1ZLNjBsODVHUk1NQnZ3azZRa0dXQXRQbGtu?=
 =?utf-8?B?M3FjK2dianRvYkFtaHNuRHFIY05NbnpScWw5NjVONnJqRGtJTW4zMTBSZ0Y2?=
 =?utf-8?B?VW9pTmVoUHhIdFV3MWF3UGlaYWZkR1BiNXZkVHlVTkJVTFNMbzVHRlg4b2Fk?=
 =?utf-8?B?V0p3Uk13Qk5ZbGtQR3g5cFNHTzE1ZWlFb2hocmFuSVBUZklrOHVLMXBiZjRo?=
 =?utf-8?B?QTNwVjdJYTQrOWJDNlNnUDY1OHVYVjRNVVJzbHhMMU9hNDgxQVlwUHZZTDdo?=
 =?utf-8?B?dXBUdDFqZU44VDUzWEpzSThrdVEwTU50K3ZkeGlFQUZOcTN4M3FIOG5JWEQ4?=
 =?utf-8?B?ZVdHOTBMckU2cGppQXZxN2wzR2VCSmlIb2xMVUZuUzd6ZmxtODdlVGI4V1JE?=
 =?utf-8?B?WS8vM21BWmFXY0ZNWWw1cHZ2cmZKV25WM1RpN1FqOGlXNjR0ZFB3YTZPYUsr?=
 =?utf-8?B?OWdkS1huWjlpSGxCMy8zUXc4bEt4ZlE5OHlqc2RKOXR5VTA1NlIzb1VPTUJ2?=
 =?utf-8?B?UkdoZFFzZDRSYXplM2oxRjg1M3hZOXFTM296SmxLall5bWxGQTYyajJlNXpJ?=
 =?utf-8?B?OHpaU2FOK0dlTXhoTEFtNGkyN2p3Qy9XaTMydVgwa2Q3SmQxZVlWbVErM2ZP?=
 =?utf-8?Q?Se44uFHAOvDOJlrHLYHK02Mqq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f65813-2650-4a9c-fb16-08dd5486d65b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 03:53:45.8626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzKDaHqvLJOhhq7vVYAfkyvF14UeF9w9L57LvSaJf5rPU6dY7gG1vSOFBxP/RL64
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9503
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



On 2/24/2025 8:16 AM, jesse.zhang@amd.com wrote:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
> 
> - Added `sdma_v4_4_2_update_reset_mask` function to update the reset mask.
> - update the sysfs reset mask to the `late_init` stage to ensure that the SMU  initialization
>      and capability setup are completed before checking the SDMA reset capability.
> - For IP versions 9.4.3 and 9.4.4, enable per-queue reset if the MEC firmware version is at least 0xb0 and PMFW supports queue reset.
> - Add a TODO comment for future support of per-queue reset for IP version 9.5.0.
> 
> This change ensures that per-queue reset is only enabled when the MEC and PMFW support it.
> 
> v2: fix ip version (9.5.4 -> 9.5.0)(Lijo)
> 
> Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 37 +++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 4fa688e00f5e..ba43c8f46f45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -107,6 +107,7 @@ static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *adev);
> +static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev);
>  
>  static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
>  		u32 instance, u32 offset)
> @@ -1374,6 +1375,12 @@ static int sdma_v4_4_2_late_init(struct amdgpu_ip_block *ip_block)
>  	if (!amdgpu_persistent_edc_harvesting_supported(adev))
>  		amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__SDMA);
>  
> +	/* The initialization is done in the late_init stage to ensure that the SMU
> +	 * initialization and capability setup are completed before we check the SDMA
> +	 * reset capability
> +	 */
> +	sdma_v4_4_2_update_reset_mask(adev);
> +
>  	return 0;
>  }
>  
> @@ -1481,7 +1488,6 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
>  		}
>  	}
>  
> -	/* TODO: Add queue reset mask when FW fully supports it */
>  	adev->sdma.supported_reset =
>  		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
>  
> @@ -2328,6 +2334,35 @@ static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev)
>  	adev->vm_manager.vm_pte_num_scheds = adev->sdma.num_instances;
>  }
>  
> +/**
> + * sdma_v4_4_2_update_reset_mask - update  reset mask for SDMA
> + * @adev: Pointer to the AMDGPU device structure
> + *
> + * This function update reset mask for SDMA and sets the supported
> + * reset types based on the IP version and firmware versions.
> + *
> + */
> +static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev)
> +{
> +
> +	/*
> +	 * the user queue relies on MEC fw and pmfw when the sdma queue do reset.
> +	 * it needs to check both of them at here to skip old mec and pmfw.
> +	 */
> +	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +	case IP_VERSION(9, 4, 3):
> +	case IP_VERSION(9, 4, 4):
> +		if ((adev->gfx.mec_fw_version >= 0xb0) && amdgpu_dpm_reset_sdma_is_supported(adev))
> +			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +		break;
> +	case IP_VERSION(9, 5, 0):
> +		/*TODO: enable the queue reset flag until fw supported */
> +	default:
> +		break;
> +	}
> +
> +}
> +
>  const struct amdgpu_ip_block_version sdma_v4_4_2_ip_block = {
>  	.type = AMD_IP_BLOCK_TYPE_SDMA,
>  	.major = 4,

