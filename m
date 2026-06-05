Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0523CD6E74
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 12:49:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83DFA112B15;
	Fri,  5 Jun 2026 12:49:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dA5kJWqI";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013031.outbound.protection.outlook.com
 [40.107.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 247B2112B15
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 12:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eftqp5t/JF0w8CzjRueNQLJ1LQvnFndXgtk3Yvr1aLd8Px5AQRjGlLZiZweovcae8cYWKzCGJ658EuhN0avWaAczE+edhWXmRK82Qi9ADrxwdkyY/yGrf0JpufGNxr19XXwE5i+0Mhofp+z5ioHZ6tCcAof7TiSe57C+7vyaoU/ATgPj7O7SMbviDPsy1yT8RhgpRd7bfBXHyfUPEUF5FQBPHviK9PiviQFpRS2RB1NT6UNPuwZALEZfJlsQZC2yi+Ws0I1zH0MApH4zkQ+fePsQ8KjZ2/Y1Phykk1whR45VAmYM+s3M2/+zkckJBSrWgYAPRb0vJVXjxbstsJi7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ark063tygXMFdI0TQTCtkqHpKcTU0ZJ8WMVC78xnCBk=;
 b=T8c9uX2a00XDSgLiqMv8vPoM9lEY0IUsZ0KPtI+laKn9UViQytWAfeCKgKSbea1U9qrZRBb9u2h9S+Q6K0RgEaZOmLyN/7TX/0D2r1qJgVOmCXT92G6AGIQoKLzHPxG5OuCyL3J7Syk3s0dXgjFyGYmasU7J2MXknKFf5UG+ngHHbsZlpmZekYdcbIQpHai0B8zawMHcmwq7qvktuePS+EVGyRhDFt2ChI6FrmpUYIWGUi/FFw0lQpmWh1ycrSPNBsrk2Yji6kZboyeWPJ8s6lLqnawnAaD39SZC88rikphBXqqr1XcY/TCyIKpkOcerVvv2t6G3P5oITBN1qtvdPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ark063tygXMFdI0TQTCtkqHpKcTU0ZJ8WMVC78xnCBk=;
 b=dA5kJWqITgvI6OpME83Mct8yJqSipS9o09hXgz2gWRB32LopgAfHsNURObGfhp+tjbBnCs5rzMRJCba3S9T1PHcAFRN3Z5CjJq32PfZikNUNIBh1TmxcT0zdIrFfO16cdTSaJl8n8omXsXrvAXvoAphkb9Z8OouHSFzH3wPl9NE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 12:49:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 12:49:08 +0000
Message-ID: <1b69b876-a8b9-480b-9399-be6321dc8c5e@amd.com>
Date: Fri, 5 Jun 2026 14:49:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/11] drm/amdgpu: Embed eventfd manager in amdgpu_fpriv
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
 <20260603163350.2678309-3-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260603163350.2678309-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: f5baae55-35f5-43cb-447d-08dec300d5aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: F2Eko/EBa8lHgzUQRQfGcbJAHeGwUMNdC2WXUdwyXr9RVrJkZTYiuhTQKzIUWD/FywNW8R7dBKMhULA0YyaWythBZgXElgt8cthGgBXDLFG49OzOlKYNdgCya3xxBgFB8wkHmRxCL1CksYY7fhnBhsf5YRbv8nkNkHCQv7EGtePDdv/LZTH+HTiGyYx9ltYmSJa1YdfGCbTpstpgtIVKQZcKfRjevXPfvdypcNtcehJl8vkthojpSVoA5NXmeJvsqZPwv5isYSL8HdiDKfPm3AR7EW1FI4fm9/+vg4RpQRK8f/pu9ZvXXTF8c1veUg2eMbnO/d6DvcNPRnK32yatY7X88mKzpfbkpu9AfegAqxTuTstPUuuQgd0gmrtdyKEPrzDnIG9/uasTwibNcyilmg1JLzmQT6nVCLiPNdIfwToBqn6Hox4xP0d5CBgOO8Ap2SAsGrGissfrvpBUoAsybuPhZP5TTS6081S07XmvQBIJqdOppWx9egWno2Mxj0MgnofU35R+Uc9O7XTws8QV1aOdtT5qU+AOFStkEAx2qEGzKZsiNOzCpnWuP4sW7U3DHY/TRKTGvJy0uQiF3qxGr1yQIxQtC4EWxJZ44HwHA5y45pkf96m06CpwmK92kopo82DJ6HOTeW52l3Net1aCC25kpmKigeTkdkzIuXIgAOBMlWUHOa9nSYdAGCsZ5Zqh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDRlb0VqUXd5RHUrc2lROUtpZ1U3NGxHWHU5UGM2RXFvVmdFVzBWVDAyNUxa?=
 =?utf-8?B?R1hMSmhqYkpEVkI2YW9OWG4vTW53R1F2azV2aG9KdU9RT1BDY2plOG15c3Bp?=
 =?utf-8?B?dWYvV01WcWw4Z0pUZExqQTNFbHZRcnIzd3liMDZtK3E2dVR2b0RWaU1aaGd6?=
 =?utf-8?B?ZzFnd1gyaGF1aGVlbGk2L1B2bHA5Y1RRMmFCWjZvVFdwcktPQWRTbWViWlpp?=
 =?utf-8?B?RkQxMEszTlE0cG8yV1lHWUN5bnltOE02VVNEVnRpZjhSYVl1cC9YaXk1bHpo?=
 =?utf-8?B?SVdnM1JIWG40UkdwMUhXa3hwMFhjSW13OUV6eXNsbWFpd1JiamJrZmJBTkFY?=
 =?utf-8?B?OXNvaytoRzk5WDlobnA2SnpxT2JKeHBVRE11SVl6TUN2ZEZ5a0JUMGVGQ2Mx?=
 =?utf-8?B?T2xNeFRCWWp6MTQ4bHE2TERTUThqZTI4S3BWOU9vUjlEM3ZGRnVJMjlKUk9K?=
 =?utf-8?B?cTRhM2VoR0k4TkRaaFZnQlJwQVBEKy9FbGpIWXBjcXAwYm1XSnJoS1RjN2hs?=
 =?utf-8?B?RHd5U1hlbTJxMXRTZkdjcWJDV1FiYVptUHNMaWlpcFE3T3NTNk9xbVRwOS9l?=
 =?utf-8?B?UThqYzB2dk1kREhuMlJWd1o4anpZTnpjcHVma3ArR25hVUtOcnRZY3laeXR5?=
 =?utf-8?B?bVVRSjFBYWR4dzVkdXNzS3cwR25JeHZySmpKSXZxWXRrSnBHdlAwY1BpOTVl?=
 =?utf-8?B?dzZCZEM2NVN0SFVKTm9EVVdLUTV5TEErMXNQZnVCYkZsU0VQVThNUHlKZ2pT?=
 =?utf-8?B?b0ljK0dNc3Y4QkFiTi9vTFZjMm8xb2tRSmxjWi9KaU9aN09nRFFBRndPakgw?=
 =?utf-8?B?ZExGU2FqK1FoaUEwTWVrVnp5NG5mdkNzNFNWd3BPam83K2FWVHh5YWlSS3Ft?=
 =?utf-8?B?S011RDV4L3hZMXhzSk9PT1BUenh2RWJtcVJDcFpXWFpkYlNYNnJaT01Ra3Jl?=
 =?utf-8?B?VmdEQnVQTFNneDZDOFp6czlhVGlTaVJFNWlxVEdmZjlra0hFbjRJcDBNNGFi?=
 =?utf-8?B?Z0FnbndVSzZRY3BFaTRjZFdSVmdsQWM2dTVxTWttb2xlVXh1aURyQjVaa1Bv?=
 =?utf-8?B?T2xxQkZqM2ZGK2dPWXllNk9xMWt5dm1qNTFVeDEva0pKL2pwdVM5QWlyckZJ?=
 =?utf-8?B?cnkvdnJUMHZ2WXk1SHZqM3ZyYmYxUGpmQ1QzcGpMT2J6OWVLTG1ieE16bHBr?=
 =?utf-8?B?RENFU0JLelprZ3NjRmhqR1NSQi9Ca2RoWE5SWmtuRVpCOTBCbmpwYzc5TFNO?=
 =?utf-8?B?SVdjaFhZYk5YZjlOOGZvWlAxZjl1emZ3VWJDRG1nVmhlOHp4eExpRU8zK3Fa?=
 =?utf-8?B?U0tMZDliNWIvUVczOE5SaTZDc2p3SzdxSDJNWHVWZFUvbHgyNkFhSVl2SDFW?=
 =?utf-8?B?NHpqS0ZEZUl5ZGtNNC9ZWEhRNXpUK2ZUNCtUZ1FvTXhFT25uY2VGRm9mL21C?=
 =?utf-8?B?b255bEFwQVJRbkFON0ZwUHdhT1FLZGtCUnFrdjR2aTNDcUt0M1BGZE9rTzlj?=
 =?utf-8?B?UHZtMWVqWEw1Yis1TEhKeHZWemwxMURZT3lKdFl5MktFNkhCc2puUTlUWnZk?=
 =?utf-8?B?RUlPZUQyVjgydFUvMHF3QU9tLzNGU0x0YWg4OVFmSithWVU5Y0dJTlpPT3dt?=
 =?utf-8?B?REJjbGlFeG1nM0xuQkRRNG1LSTgzZnI3UlZjNnl2b1VRcTlEbDZ4andZKytF?=
 =?utf-8?B?UzNsb3NTdnE5QVRlTi9KaWpiY1F3ei9QZVc4UGlpT3JsZmxPVkJWQUxGeTNO?=
 =?utf-8?B?b1NiV0NZS3krMmtYeDlUTE9sQUQ1VDNKR1RGbHBQSXVkTHNHQmNQYXNtZTl3?=
 =?utf-8?B?ZzJYakd6dFF3eWFua0h5M2Q4TEl0OW91SWlnR1F4OWg3cmRyRzU0TG00Sk9B?=
 =?utf-8?B?UUljZ3hOSnNlc09CN1FIOFZVSGd4Y1dsTE1QQU1tODhsYndjVmV5cHIwd1hp?=
 =?utf-8?B?ZXRqMGpFV0h4SWlnb0xOQzNDeGxBSGx3bGp3ZmV4cDRlVFkwQXNuSTNnMVc5?=
 =?utf-8?B?MzFqM2t3MHZTVUF1dmFIaVpPSUxQb1ZyWjVwN1IzRVJSMVJqWlhHcEl4dlo3?=
 =?utf-8?B?cmpPUlFCY0g0L2tlQnYzRWkxUmNyNWJCRzdWR2pxNUpVeVVOUjhOZ2NhM2Qy?=
 =?utf-8?B?OWZtRkFNc0Q3NXpxQXAxY2Y0TkJzdmVlQmx4SDkyckk0SDM2YTZyUFpzZVd5?=
 =?utf-8?B?YnV3eXN2UXdSZlpSMkszbDVJeWlYdTlIYUR3Q0FDb3JFM1o0QVFaOUd2OW8r?=
 =?utf-8?B?NUpFMjNJQWI0SzNtdmlOcXZVczk0QUkzcUlpcWJKOWl2RXJ4UUJyWWtjV0NG?=
 =?utf-8?Q?/QgzZVhmzHG+ac9iFj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5baae55-35f5-43cb-447d-08dec300d5aa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 12:49:08.8066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztk92wRVttf1zICg+3SuxkxVzpe/6mRWnfqUwMX8sTmrdJgssPdGPgHtASaFhos2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691
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

On 6/3/26 18:33, Srinivasan Shanmugam wrote:
> Tie the eventfd manager lifetime strictly to the drm_file (amdgpu_fpriv)
> by embedding the manager instead of storing a pointer.
> 
> This removes the need for reference counting and avoids destroying the
> manager from IRQ context
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 +++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5d7bfa59424a..a75c68195df9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -104,6 +104,7 @@
>  #include "amdgpu_fdinfo.h"
>  #include "amdgpu_mca.h"
>  #include "amdgpu_aca.h"
> +#include "amdgpu_eventfd.h"
>  #include "amdgpu_ras.h"
>  #include "amdgpu_cper.h"
>  #include "amdgpu_xcp.h"
> @@ -455,6 +456,8 @@ struct amdgpu_fpriv {
>  
>  	/** GPU partition selection */
>  	uint32_t		xcp_id;
> +
> +	struct amdgpu_eventfd_mgr	eventfd_mgr;
>  };
>  
>  int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 24526e92f9b8..f5719500527f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1460,6 +1460,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  		goto out_suspend;
>  	}
>  
> +	amdgpu_eventfd_mgr_init(&fpriv->eventfd_mgr);
> +
>  	pasid = amdgpu_pasid_alloc(16);
>  	if (pasid < 0) {
>  		dev_warn(adev->dev, "No more PASIDs available!");
> @@ -1556,6 +1558,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	if (!fpriv)
>  		return;
>  
> +	/* Drop all subscriptions before fpriv goes away. */
> +	amdgpu_eventfd_mgr_fini(&fpriv->eventfd_mgr);
> +
>  	pm_runtime_get_sync(dev->dev);
>  
>  	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)

