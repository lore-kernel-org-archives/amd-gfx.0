Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511E8C61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 14:21:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B822110E021;
	Fri, 28 Aug 2026 14:21:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VRi6pf5J";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D0B110E021
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 14:21:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjgBaglqhtK5L/PBg+uaa8mihx10i/Yw4J50g33eOi8NvVoiYkclLTfQfwsargTOKAgfDOGj7jPTc051ZXRlMCIOUryPde1Lx77Bv5kTsn+DTkmANgrkhm26nk7+gtIpyS5O9X77udDHXkzYwPjh1XiMvh3aXjNbB7IiDdzApA0okJxXtg2zeEqwzLEahhfRPrL9NA/bcDFIB40FxcrnNJkdpPeMEZ2LrcZqDmc3hqvZVK5nYOlPfZqyYUtnzY8fQo2GL4gS8xhz6o44nVIGuzfhkyxB7M2ul+uIKCxv9NgLK+A0BROba0kPYLxcQUltbGz7GWCdR5GLh4pNvMuKqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gg/XTLIpi/xa2jDcDf9prFQBeMnZ0FAQFAik7U/Cdc8=;
 b=bGnCK2wfVgw5+kKd3qtJJ42BkwyvW9vqYmTuo16Wllgs4CQl8iPqA7CCDgs/AFsK994XJFW51KmNi+dxheG65OMppcgnAANbcs7+7/KRIPk6ii96+8SdWVcyH9V8Ysu30BwbfVSweENfA4TLuInn1o5nYAPbQjRRA96sFZyud7IGZ1Y9ZU5PYCx1RKr28mbk1ODqbGN6q70wmSNjMjvK5yWfS5Te/pKv9PShqJIxmZpEnT6JaluT2FX306UWtvcW6MRYnuIO6IMjd6wai5l5/nqNAz5mx4jls2pBEKcQN6SI+JnSX/sRF9escoPvG5DAbM3Xovza8SEpmCsIWCGIIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gg/XTLIpi/xa2jDcDf9prFQBeMnZ0FAQFAik7U/Cdc8=;
 b=VRi6pf5JECO2oIjFxd2/0kdFLaedEDOLoEYc6uegNEpBU3g1mjk5YxYT5WCVuwc1ngOfvgtEDI040v1MWpADDrmONatoH5sCGKxSNgABQBSnBi/njXxMWSrG6uYPHK6NXAy/oKg4Bff4t0OtUYX17SKiumdVZl6SkhbDbaP1AFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 14:21:49 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 14:21:49 +0000
Message-ID: <c711ddad-cf07-44a1-b741-8c6b556d7a83@amd.com>
Date: Fri, 28 Aug 2026 19:51:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] drm/amdgpu/sdma: Remove unimplemented soft_reset()
 for SDMA and SI DMA
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260828120729.25908-1-timur.kristof@gmail.com>
 <20260828120729.25908-3-timur.kristof@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260828120729.25908-3-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0296.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21b::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e156c92-99d9-4b1f-9800-08df050fb2f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ssSW85+yxbJGnEhCnXrvZPOkteho+82s6wQDj16WMFr4qCkc0gaDmI5D5kMtvF2U0R1zbbJXxVNcbZ33NP/whNQXBQHNLfHvcROeGM1pMH0CnrJuLwJMIfi9pHHonRaoKVcbP4hfu0rCkKtm07WuZuM9D2wGuUM3cevv6sJN2X+U5lQe83y0JYGKWC83wLI8WW2Awb3kSWo0mlCzdp1tz7g6KR4ap/vXJkzhYG9dJwprfl/Gh/2QFO4Kah800BiwBZtL9aV2nScitQthYNwf64CKfnQDSBBJoXZPPpvPlskELpKWw3HXtwZInm0WVnF5gbd8B2uhYUvjv6PrF1s08/MnFvSAJoBa6VpiaZVRWPYPmPbTjFkq+IehP1nCTtOyOSY+SuGBeYU/qtlrEFGUOrIm8AgaOchBM+pV47ke/TeZDY2QG5vqd4YtleUwXY0gMWbyhBaXii0ygZkz4rNMbpTUIXk8IpHig2mR7UrMj/XyxMnMQDX83IlMF2qa1Zp07CJ8dQLLbcF13cQFSnL5xsnn/Uc22WNVv2LYFY5bRv8f4V55trDYdzrLzHRVScbvGpqXK2BczSzaeCNmAyrJ8UQEEel/lkFzdv8AzGKnkYpdbO65HMV7KeTUyAx44vER62SCbTQzAH1CeKuGYsexQOq6Teq/I9T7SfWG1TU7mJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHc0K0gvbkNjUEs1TGFOY1VhS0RDSXFlSGlTS0FnMDRsdkUrTTg4RkxUQWEv?=
 =?utf-8?B?Ny9Gam1KWnZ0N0ExWGs0VzhzK3hxZzF6YmhJY2s3NU5VM2VlNTBva2h2VjJR?=
 =?utf-8?B?R1BKZ2hMUTcycVRlRlptVXh1bVBTeDY2RDRwdURXOEZyYjZ2SC8wSWZoYUNX?=
 =?utf-8?B?WTAybzVSRFlRK2UyU2did1hOdDMvUDRNck9ad3lNQjZPWVpDUVNCODBZVTBQ?=
 =?utf-8?B?L1NvT1V1aVVqVm92eWEwdWphbE5CWjBweWpyaTdOQ001cDk2WnNBcUVWYWly?=
 =?utf-8?B?SVIvZm8vTW9BWUp5VWtDaytoNzRmeURVSE00WXp1VHF0azJGQ3pDZm5ZWGhG?=
 =?utf-8?B?UkxXQ1NOMjdoQ1BvNTZRNWpuUEdOeVRZaFlPZVdOaGFkUlNxQ0NhNXhWTVh6?=
 =?utf-8?B?Sis2aVpQOTFIOTFTb3pLY2VXSU9FRTFKaDRLb25mNDEzb0NzN2EzeDVreFJn?=
 =?utf-8?B?NlJqbFJia01yNVpmcGlLRGx1QlpXK0x0b2xQUDF1LzVMdnIwbGhSaTlJdmNC?=
 =?utf-8?B?eGthZHVXRXM2QTFYajJ3VnhUN3QvTU4vUGQ3WW1sMXVPbmo0c1l0UVdiZHVC?=
 =?utf-8?B?RGV4MkNCSnZ6d29vcUF4bXlkQjVwVUVaWXJUUkhoR0lmS2d3SnZVZVowem9Y?=
 =?utf-8?B?MitQeER3Rzk2S3Y1TFZtQ2pGeXRCVW8zTGM4QXlGU2NJOVpackVSdUwvdnhw?=
 =?utf-8?B?R2dxTDVzTVAraUJQcnd5SEM5NW9mZGRLUXkvU01qN3dEQ2Vwc0xJV3d4K2Yx?=
 =?utf-8?B?aFFkbG4vQmtqNU1XUC9Qc3UzNnQ2dTZaRzZVeVNtUlk3Vmp6dFQwck9vcERX?=
 =?utf-8?B?QmZSQ0FkTXZHVGprenBJdFg2Z0YwYjVJalZnQVlNb1RxT3p2ZXNWUkpHd0E0?=
 =?utf-8?B?eVpNbHVtK2VTelFuZVYwZnZKTDJyOXA1aEgyRW9WcDZFZWhTUnpBdURWcmxu?=
 =?utf-8?B?cVFsM2xjRVRkSUdzQUNnOVJqSzl6V0sxK2lnWmVteVVJQ0NlYzBIQWJmaE5n?=
 =?utf-8?B?Z1FRSzBOY1BGUnNLTHpJK2tkakRHeHliemxETks3ZkV0Ri9Fdno4OXV6c0t1?=
 =?utf-8?B?eHdPTVdTazkzcHJ2TTZDbXRndC92R2ZFVFI2UkhHdHRvVE4rSlpsOTZxNmxw?=
 =?utf-8?B?ZXJMR2FRZ2hZaXhWVkhadHdXUmZiWmlFZWdzNy92dmpjWXB2czJyaktqTzR1?=
 =?utf-8?B?d3k2dFdDQ2N1R3ljTnVTVDladytOU3F6RW5OemRtVXVsamZDWlQrSGg1a3Vx?=
 =?utf-8?B?Zjc4N2Q4SG9qeUlDZmdwTVVaYWVRK3NPWWRCRmw4Vm1vMGJVSjhoN1I5NUhM?=
 =?utf-8?B?d0o2bXZRUkI1THRrWjM2T0lQWTZRWWZ1UHREU0dFQU9NeWhvR21XMUFla0pm?=
 =?utf-8?B?cVJneTQ4UVRReWhsamVFU2lQSVpMZnRxSWkvRnRWMmFzMEphRmtBWEdzTXNX?=
 =?utf-8?B?bW9jakFJNlA0azhveENFUWFWd2x0bUJZclhCdmFHaSt2U29zUjlWSWFmdk1W?=
 =?utf-8?B?WGFpelAwbmU5Ynkvald1QXdSc0NvbEpNMVJDUmZPVUlGSWUrbEdtZlZ0NTZK?=
 =?utf-8?B?dzM2bTFybkF4eXRTSElqeVNEdzNXcUlKbDRkVnUwRlJEcFNmbC85ZzBsekZF?=
 =?utf-8?B?L2F0KzhwdzRDZWlaMFZYYnBRcWhYSUhIL0kyQTBEVmtkUEk5Qms0UXZ0aVE0?=
 =?utf-8?B?Mk9iWElFNllybVRLYTNka0pUSVIvdUo3ZFQ0RDJnNmI5RGZCZDU4UGhQbExl?=
 =?utf-8?B?NndPVUFMMU5JdkQzMGZlcFJpdGs3cEFoT0RoV1dSdGJKaWxEcGhyNnVtL3Bp?=
 =?utf-8?B?QVFRaXYxTGR5MW1lTnhEWEhQeWFOZ0RST1RIVDh0di9ZTzl0bDhIVThzcTNR?=
 =?utf-8?B?QThOZTVzSHVXK1JHOENrejhEOW04R204UVhpU1VYOVdldFBaS09UYmQwZlZz?=
 =?utf-8?B?dnZqVXBybjU3NHFsMDJjNWVhaXN5clpBZXpHeXdnZDM0bndBUUQwUTVRRUs0?=
 =?utf-8?B?WGdOQXJBTnVFcjBOdktLUDlsVVNWN2JFR0Z6MXRtZlBaV1Y3d2RtcGZDaDFF?=
 =?utf-8?B?NDRFUElMQjZzUTFZcGo2WjBCTHhuNHBkaGNVdVBmOUtTSDhJZnJoTFJGVDNV?=
 =?utf-8?B?UW9zOEo2NWxoc0VVLzFhRElJZUM5Zk5QTURiZWVtTCtsZ1gvWnlQZ0s5Zjc0?=
 =?utf-8?B?L3BKMml4RGxzdW1mZTRqaGE3aXd0Zjd3RHBUUitWMTQrRlpZdWNrK0Q1S1BF?=
 =?utf-8?B?NHFneHdsWE15bFhPdS9kNWR4bTBmeTBQaVgyL3d0bmYvUnBGa1BxVHVMZjdT?=
 =?utf-8?Q?uowKYTioSqV0H1exnY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e156c92-99d9-4b1f-9800-08df050fb2f9
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 14:21:49.6689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giaFhZZXQ+w6DxhzFkSUqeR9ALGYTB158EmriIPgoVqZCh0i+9qSb91vD7hcUgL7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940
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



On 28-Aug-26 5:37 PM, Timur Kristóf wrote:
> These functions are not called from anywhere
> and don't do anything. Let's delete them.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 8 --------
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 8 --------
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 8 --------
>   drivers/gpu/drm/amd/amdgpu/si_dma.c      | 7 -------
>   4 files changed, 31 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index a0f19f7b39e6..bf71f99f7307 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2046,13 +2046,6 @@ static int sdma_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   	return -ETIMEDOUT;
>   }
>   
> -static int sdma_v4_0_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	/* todo */
> -
> -	return 0;
> -}
> -
>   static int sdma_v4_0_set_trap_irq_state(struct amdgpu_device *adev,
>   					struct amdgpu_irq_src *source,
>   					unsigned type,
> @@ -2398,7 +2391,6 @@ const struct amd_ip_funcs sdma_v4_0_ip_funcs = {
>   	.suspend = sdma_v4_0_suspend,
>   	.resume = sdma_v4_0_resume,
>   	.wait_for_idle = sdma_v4_0_wait_for_idle,
> -	.soft_reset = sdma_v4_0_soft_reset,
>   	.set_clockgating_state = sdma_v4_0_set_clockgating_state,
>   	.set_powergating_state = sdma_v4_0_set_powergating_state,
>   	.get_clockgating_state = sdma_v4_0_get_clockgating_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 1a2810b6f27c..72ea9db939b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1646,13 +1646,6 @@ static int sdma_v4_4_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   	return -ETIMEDOUT;
>   }
>   
> -static int sdma_v4_4_2_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	/* todo */
> -
> -	return 0;
> -}
> -
>   static bool sdma_v4_4_2_is_queue_selected(struct amdgpu_device *adev, uint32_t instance_id, bool is_page_queue)
>   {
>   	uint32_t reg_offset = is_page_queue ? regSDMA_PAGE_CONTEXT_STATUS : regSDMA_GFX_CONTEXT_STATUS;
> @@ -2104,7 +2097,6 @@ const struct amd_ip_funcs sdma_v4_4_2_ip_funcs = {
>   	.suspend = sdma_v4_4_2_suspend,
>   	.resume = sdma_v4_4_2_resume,
>   	.wait_for_idle = sdma_v4_4_2_wait_for_idle,
> -	.soft_reset = sdma_v4_4_2_soft_reset,
>   	.set_clockgating_state = sdma_v4_4_2_set_clockgating_state,
>   	.set_powergating_state = sdma_v4_4_2_set_powergating_state,
>   	.get_clockgating_state = sdma_v4_4_2_get_clockgating_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 1a022a251011..0da54c335822 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1518,13 +1518,6 @@ static int sdma_v5_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   	return -ETIMEDOUT;
>   }
>   
> -static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	/* todo */
> -
> -	return 0;
> -}
> -
>   static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
>   				 unsigned int vmid,
>   				 struct amdgpu_fence *timedout_fence)
> @@ -1902,7 +1895,6 @@ static const struct amd_ip_funcs sdma_v5_0_ip_funcs = {
>   	.suspend = sdma_v5_0_suspend,
>   	.resume = sdma_v5_0_resume,
>   	.wait_for_idle = sdma_v5_0_wait_for_idle,
> -	.soft_reset = sdma_v5_0_soft_reset,
>   	.set_clockgating_state = sdma_v5_0_set_clockgating_state,
>   	.set_powergating_state = sdma_v5_0_set_powergating_state,
>   	.get_clockgating_state = sdma_v5_0_get_clockgating_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> index edebd9109fd4..1df30779dcbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> @@ -594,12 +594,6 @@ static int si_dma_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   	return -ETIMEDOUT;
>   }
>   
> -static int si_dma_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	drm_info(adev_to_drm(ip_block->adev), "si_dma_soft_reset --- not implemented !!!!!!!\n");
> -	return 0;
> -}
> -
>   static int si_dma_set_trap_irq_state(struct amdgpu_device *adev,
>   					struct amdgpu_irq_src *src,
>   					unsigned type,
> @@ -726,7 +720,6 @@ static const struct amd_ip_funcs si_dma_ip_funcs = {
>   	.suspend = si_dma_suspend,
>   	.resume = si_dma_resume,
>   	.wait_for_idle = si_dma_wait_for_idle,
> -	.soft_reset = si_dma_soft_reset,
>   	.set_clockgating_state = si_dma_set_clockgating_state,
>   	.set_powergating_state = si_dma_set_powergating_state,
>   };

