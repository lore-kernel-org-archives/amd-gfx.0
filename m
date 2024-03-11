Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF82C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Mar 2024 06:52:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D542710E119;
	Mon, 11 Mar 2024 06:52:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hCwRAZD2";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C8B510E119
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Mar 2024 06:52:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRd6hfFNjt4rotQ0GHI9nPilJs//szF1gQ5/tJrhV1fhBQ5zxSgalkMwiKo604kwBCFhjLzzxXoZd+04II/bnqqU3uyKeha3B1ry+60RaXpitXSY1n1hMPRRfAlwVI6u8ESsSnJmHdgZ4nWa43voqr1wS/51+rkekv0vFewTwlCt4BVDdJ4abiBwMQNglB6l5PrLGDyosJU5JCWKmvMdFGgop6+eXtfuvKQHcesxix8enJAKPn/LNh1NXGYD8bpLJiWgnzpdJby1iUZvIj+A42S3RwhFSFzYYpUAcyeIJif8fRDzy4SJ1YUmFoLfJAD/dvVENAIa4pjVj7FoGSAwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcfmKo1Eugl34nUEEJVW/v/xKz05rtxTua4K2aCQI6I=;
 b=Ig38FIHIP+HMTyYueo+REyEaBUNga4W+gCVa+KtdCrB1nt+0787uxeWzo1TdI3k8/8/X5N/6VpZX5FFtn0lzYz5JctF/Y0bYODFnQW4sCFgd/kUJ9ncEEJeduWaCPdslMJVoyTXgwC3h8mxyimjtQT+WvXKe/uzcELk4BmbIkB0J1jabIysOydmZ23gUlZxTLYqnkoDMvJtr2ORO/fPqB+rmlVZ+A0B7gAZ0FLXGxv2JrctXezD3s29CuiJhTvew3k3do62DndNv2bqnlTqOmFt1WvBDInc+uPOxENgE0n3bQVUiLPj5xLRNbzEo/iodZ471Ez5EFo838X0x1tOFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcfmKo1Eugl34nUEEJVW/v/xKz05rtxTua4K2aCQI6I=;
 b=hCwRAZD2d3YaSiZfW2kAjgNWQzZhQOEStSs26+DIgWWrkNI1OiddN8SNg+fri0+5DAhLVXTBQeRET9PvWdxva7dguxBvBa5hAQk0DP8gxEc/UKtv+a5SOMDebUxkW0nhoyOsGDmEM7ldMOEViSGoRNEfZEKelhSpg2BHbNt+h7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6935.namprd12.prod.outlook.com (2603:10b6:510:1b9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 06:52:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 06:52:29 +0000
Message-ID: <1cdf5da6-632c-443d-b8a9-7c3c83456cda@amd.com>
Date: Mon, 11 Mar 2024 07:52:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Reset IH OVERFLOW_EN bit for IH 7.0
Content-Language: en-US
To: Friedrich Vock <friedrich.vock@gmx.de>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240310054040.978056-1-friedrich.vock@gmx.de>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240310054040.978056-1-friedrich.vock@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e96f43-1cd0-4dcf-0296-08dc4197d1b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jaLA2qoJSDp8osYJ8lt+XZjycb5ZCMpWpHR8DnW65vCmo5VoPcujo64qm7yomP2Y4fQDUogZ59BNgwlPunfR+Tlj5mGSnANSTeyWA5A5utmzn4in+4u6L0GYroBrDwWW1dJ3oO39dCUDNv1WZ6y0iqDR3bRZxbyytZEjj23CKhNdFs8Tik9kV3ukjXv4hV/4LAsnbvrWxuRtN7Rpsf4XwrPgTrpvZJc+0foaph7B2UqGHbBc/L66LATH2CmcI8qXcVMUd8z2syvamD3Drfw4izt+xfFnRdISfqkdLzaOZFHQQKPUoKyh0+0dosrgrNcgjJuTZDkRUJ5pKPFHNyCUWuazNAhAv55SK84/FmTXZdEqfMnRX5IuFMgtQpKtrLD5BCMjZ6SfQUqAkMkopFF9C1jk2RSarvmuGhoBKlpBoe/qRYvQ7q17sK1RSXHu0vgkfC7BZW6ZBl/vbJxxw/vuKPXYHuDSQuVhacWD3Rmw5Fy0tUEJYJgyiuJQ/VrVqH4q4BG44Z4t6gWfrzIwE+wJ5l39cWoJtzw0QmRGdqFk7nhEpN/9ulrKx5Q+jFOSZ712ticXp+TQs7ts9kPO5YdRXCaAUEaNODmbuQ4GfPLGI1MpWsp7Nq+VVuGOAxfKuj8xAOD+GuKC9+8yrtdc2XFG/ghd0muXqGo9IkwlOjShHe4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnlkTWdwMzVMZDJ0cmx1VGhlbEFrbks2YnFIbTJxaEdDS0JieXp4OE9rbW8v?=
 =?utf-8?B?Uko5VkNFbmQrb3FpSG9icXBDN09rUEpDaGIzMmRHdUc3dTdkRUpsUHIxTmNu?=
 =?utf-8?B?aTNkQXJMRU1iN1ZsSHRnL3djZkV3MGhXck1iWW9vZ09uUG4zNFgwcXc0c1lC?=
 =?utf-8?B?M2VyMzN5SWtRZE9QQlJsZDVwRCs5YjNXeTRHaU02RGpJTEJzU2RzRGdPWmdZ?=
 =?utf-8?B?K05EMTduN3Rzd05jQzQzQ2FGM3RPR21vZkpGam1oL3Q3SVYyelI0cDBQY0FG?=
 =?utf-8?B?aVJDd25UUkNPTGYxeVJRaHMyd0lMR3hyeG5IL2VDcXpETDFITytmRGpldzVK?=
 =?utf-8?B?bk1UU2NUOElFc1MxMlYrUDRJT2NVNXFQQzVuS2FJdWFiWUk0Rlg5b0Y4VXYw?=
 =?utf-8?B?TVU3cHI3em1LdVNLaDl1UHFxUWxYbytuSEpTT0poTzVFQXZXcG5hUk5wNUdn?=
 =?utf-8?B?T1J3NTlYOFN1am9LYlA5ZzVzemdTdzREMDdaRWdsSyt2TVJKN3hpTU5KL0RM?=
 =?utf-8?B?ZTd6aFA2NWE2Tm1VYmtzc3JmczNPdVVucnl5c0dUSitNZ1dFMHZHUCtPcTVy?=
 =?utf-8?B?cnM3Zzc1ZEdudzd1VUNVTTM2eDk2TTBZaExENVBZSDNuYUJncDAwbDhpa3E5?=
 =?utf-8?B?QzRobkUxSVZxUlhraFdHdXFLNGwxMHQ0L1FYVTZNZGN0ZEpIbGZ2dEMxS0ly?=
 =?utf-8?B?cEdQRXZQZ0hRbjBTZHdPWHR2S3R2OG5DNU9YQzU4a3VIeStWUEdLUzVpa3dI?=
 =?utf-8?B?SkUrbkJiUTA0QzFEWFFmZkhRVnoyNXBzK1dnditNc3VPemRocG0rdDJNWHNq?=
 =?utf-8?B?ZTlxNmx4UU1vdnhycWd1UGRLVmJSVm40cTgzeWRmSGUyOFNpNEY5MEFRS3hO?=
 =?utf-8?B?ejk5M0xyQ0RZQXo5cjRpOUpmUVhmVVNxNzFNYmRsUGMzNDRtWHVUWjNZNFpi?=
 =?utf-8?B?SHluQVZjeDFONkR1WHJHT013bnpmUkhsdkovNVcvRXFkd2d1cEJLY0xta2Rw?=
 =?utf-8?B?Qy9qdHVPdkVqbEtiV0pMcFdKRlJnbi9Xb2FvOUJqbDZSeHVjRUY0cUR5TkVw?=
 =?utf-8?B?R3dBVEY0SlBGeEtSY050RVovSXBHU0FkV0dvd3B1dXJRd0o2eTJETVBHR0s4?=
 =?utf-8?B?QVJJeVdyK3FHTy83cXdGeEUrUU1ETnRiQmkyWi95S3J2K3pVOWtOTjlmMm1l?=
 =?utf-8?B?ZmU0djBwY1k3bmd3Z0l5cDVjT3FTN1JGbU8xUCtIZmVLLy84M1duMVR6UEd2?=
 =?utf-8?B?c0JiUkNjVS9USmJmcjFoZjRDYzNYa2w0TFhpVFArdFRwS1JvSS9CcUx0dE5X?=
 =?utf-8?B?OHRsZ2ZIeGdnTktKbGo3Y2ZKWnRQdWZ4bzJIeEhFQ0drbVduSHVkVHpOdjNG?=
 =?utf-8?B?emE5MGRTdGxTWVplaGovR1k1bEpHcS9SUHNoSTFQSnFlMEtHQTlLd2hZN3BN?=
 =?utf-8?B?ZVdpcm1JZWk1emZKUGlicHRrZXFub1JMOHZ6cHhRU3dnY05iNDY4L0NGTDJJ?=
 =?utf-8?B?M3ZpVThXYlVUV2pNNDFkOHR1bVQ4SUVVa3J2NytXVG9IZkd5V3psZFVsOGxn?=
 =?utf-8?B?ODYvQW9LTHNGc2RGbFdsdkxqejJsUEh0NzM5cERmdUUwL21rVlpSR3B3R2kw?=
 =?utf-8?B?M3FSajNpZkFZMTBTOVRsUThSMmtqNmMrRjNiQzA0bmFUaXpYZmRqT2Zqa1Ba?=
 =?utf-8?B?RklwQUFaNzh2S1lyQnVObVRxVFNKZVFLd0xVazNwYm5zNCtzU09jZlYrUGh4?=
 =?utf-8?B?WlpMVHNQYVNJa0lMenFUUndwdGRvS3lxOWxvV0cvMTZ0NEFLQVpkK1hhQWh2?=
 =?utf-8?B?T1l2NGgvbGpzdlRBVTBnZFgxZ0xhenJnRzI0cnNwdGM0S0treGN2dnloWm5R?=
 =?utf-8?B?U3pYdHFKMHI0ZkpNUThHOHllcFB5SlVCejRDMk5lNVpmQlVXdE00L2xrcith?=
 =?utf-8?B?SDBJMURPc3NUbU5TTnNWeHRwclNzWkFOTEhBTkNxcnh6WUxWRENUYVg3UEJn?=
 =?utf-8?B?VCtUSFRydTY4Tm5xZWlwaHZMQ1pjdmREY1pac2VvdzZ0d1VFamVxYkFZUURZ?=
 =?utf-8?B?YmZ2c0szNUprbkY1cVVtaHRlNEg4UDFTbVIvMzFSTGdjQ0FRc2xIb0loUTJ5?=
 =?utf-8?Q?fZuIeMSDAIr9vImq/v7HKZnkR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e96f43-1cd0-4dcf-0296-08dc4197d1b4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 06:52:29.7337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PF5kVUkWvD0NwiqpU5a+dphyRyJ08wi02Gs5E0mq0qaoHgVuS5xFgHNgdIR6w33/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6935
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

Am 10.03.24 um 06:40 schrieb Friedrich Vock:
> IH 7.0 support landed shortly after the original patch for resetting the
> bit on all other generations, but without that patch applied.
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
>
> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>

Reviewed-by: Christian König <christian.koenig@amd.com>

I'm going to pick that up Alex.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> index 16fe428c0722d..7aed96fa10a9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> @@ -418,6 +418,12 @@ static u32 ih_v7_0_get_wptr(struct amdgpu_device *adev,
>   	tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>   	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>   	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> +
> +	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> +	 * can be detected.
> +	 */
> +	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> +	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>   out:
>   	return (wptr & ih->ptr_mask);
>   }
> --
> 2.44.0
>

