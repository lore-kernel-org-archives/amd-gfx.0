Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79535CD98F2
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 12:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E6AD10ED8A;
	Thu, 18 Jun 2026 12:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XKyi1qLL";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013054.outbound.protection.outlook.com
 [40.93.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 515F810ED8A
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 12:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hh9YxXPnY7KlVMTQY8qmmfT7zi5mqtKUAP+Sh+kBQRiJrznq43Ed8a6kDahPkJeJS6vJxU2nBImqk/BSipgnYnz/Pa++N8YFD1R/cU9WeUMt2AbhKr+5UDI4WFoz/0hdcZTL04hhPXMeyX6Nw+XVTInRTr+Am28lZxmy4rO1T9K0wJ/PAl3B+R2ptfLqa/1F3ja29y5YvSvvgi/WP44bwmD+0sXmVCJWOZSL9idKRpWG7alLJmB0YmEDZ6LUcoiBdJySbBRZ7VGPyl4CxPKQ1M+bRlrP5PR/HlyZzwUbNcwv1Sc7v+pOK8gwruLYpR2kIgjLyU5PT57LTdJmpGfiew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StEfuK8shF0OGL9Z5U95PbDJwzJ7pfVszgI1Ig3vzCE=;
 b=fkvwfJrnPjS3/qWMwOzHDWTOfaA86OwFedWK8+e7Tomn7+HKXxVHGOYfbXIeMdZmq5tD3QzHKW0A085TfHKjnWI8+nynuaZ1xLMylQVzucufpPY0t2mLt8eJ1Y9Pbz10RE26nYFqPwhxKTanFm3WFPp3COqyVSH7ootfTvnYKZjKPS3VYzrfFEA1PjTrR1ur8woO+KJkic3IiQ1NQUOrJy8oFgea00ulKsmH3NK9UI1SCtB0lPhwv2w9UG5Yav7gFrkj5fCSW9/zBcFMh1Kc5DADO5zWuWEhC0X7iZKzYOQwVk411wBSaDhQT4quL304y7DbmPM/NqSErS0ecwdycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StEfuK8shF0OGL9Z5U95PbDJwzJ7pfVszgI1Ig3vzCE=;
 b=XKyi1qLL2EAUIcIndWyK5yYBoyDA9xK0C62eV3qu2a+/4gNb4shDZjB5F7dA8gpovlpjeSH4Hzs1XCVNq4//i17w9hL9Wrk6coDpxbF2mWfoPeOTbH9nfY5eL6ai+ub8IYgtWEfgXa5PURjgPih5vd0alQV/Oyo+hsO9ybWKxE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7918.namprd12.prod.outlook.com (2603:10b6:a03:4cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 12:16:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 12:16:22 +0000
Message-ID: <6aa74320-eb17-49c8-b90e-d52f01e50c1f@amd.com>
Date: Thu, 18 Jun 2026 14:16:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] drm/amdgpu: Delete pre/post_soft_reset() from
 amd_ip_funcs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOh?=
 =?UTF-8?Q?k?= <maraeo@gmail.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Lazar Lijo <lijo.lazar@amd.com>,
 Martin Roukala <martin.roukala@mupuf.org>
References: <20260617191428.1784083-1-timur.kristof@gmail.com>
 <20260617191428.1784083-7-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260617191428.1784083-7-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 88424322-b8b2-4783-118c-08decd336909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|56012099006|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: sTAEPvr7+6qSkNC/oPjZh+KoB6jcMJvJl/JQJapcyHceYW6gTq+QgFzxxZtubYBaLzl+xtUXaT/3E9mTdLf077Kn3atQbCrMjsQSEYqcVeL4YMHoHUkevcp5La5P+LuLIc2jSUiwLKkBYdiVUrPyNZ0eaLnwlkeuPC1QrafybOuzpEFzj/4Tss03T0HyR8bmyKIutgi6hOCsjt9kUzUvhGM3VeEwt91qczQ/zHv6h7FhxWdkDv0MpSXErbfOIDJyj/7RLOlXOe//pQBw+ezh07Xtm7gUJK7NMnefYG9f1NfDrQdWH7eHjuRmpjp2C+uqMZCs3EOXuvDj/tVNnsjHs2O9qFQeiROMD8u1f/2FoJAHWHpfmlQJ4EQ54jjPDcKv9wlAkyiLDz23uUysBsWRTa/eCTgLWfE7JkUYu5p31zXS97uwyyLSK2cFn0WOihI4OhNs5SrKSsZYrvG7AGKgSxu2ziOW3zirN7S8uJUMMaekNh9iADHJIA/icKhyRhgvMiUdfszH+wVG370LBw8coD/WcLy2ejMIUfZq/xnkdZti1DO9k5XowKduVDoGw2OsIA0L0m+IS+dLYvV6uZJkvXiuxbg7SK9X/uc62gLcX+BIB/1wkddwRrXMz+b2xxes0pi2pXp5yJCdPVIHQfd4frFOzh26dhRo3yRjj4BOsjMvcHJD8V7VxxPRyopHtXTr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk5Gc0UwWHM5UmFDYVpNK2VDcTljRTJCQVJiUC9HckFhYlRidWQyZXdBdXNo?=
 =?utf-8?B?RnY4bVFLVjBmZW1kTWF5dHVVL1grdGR2WXNZWXBwTnJTcGI5Nk92eHRPbElh?=
 =?utf-8?B?TUNBKzRxWS9OaEdaVTF6c0N4MHpOSzhkM2E1R0lwWmhTUThCS245YUVJNXlr?=
 =?utf-8?B?VDNVaWtLZjZIaCt6VnJ1R1BjWXpnbXlIbHNEZUppck5ob2ljUnJtMW5mOGF0?=
 =?utf-8?B?dEsycDVUVFcxdjY5ajFzNU13T0htRGpWUUNIQ3lpV29wN0g4aDNHNW92UHFE?=
 =?utf-8?B?WGpESURIMnNNMzNFV1JFUWlhdmh3Y0p4N2pNVEdGNlYxRVRtTC9ySEd0aFRS?=
 =?utf-8?B?NzNNdGV3M0hBcWdySW1xREgvOHZDZWFrRjNhVXFaZURGMVUzcFJNeG9adCt3?=
 =?utf-8?B?SzNyVmRnOWhhL0o1blZhcXVKcEg0ZTNKamxidVFuNmx3OFhrM3RwYzIvMjhN?=
 =?utf-8?B?NWlZMHQ5bVJmSmZvNWt1R3AxRThLd3kzMEhhZ0wzay9odnhpZ1hBdzJLZVhS?=
 =?utf-8?B?R3BwUmJmaFVoK3gwZUVaNitaejNKK2RvSGM5SlU1QWVDeHRmeVNGcTBTWnM1?=
 =?utf-8?B?ZzlQQ1JsamtXK0EvSUd6M1grOFBIMU5vY0FvL1hEVjJ0SmlDbE1ra3JmZFVI?=
 =?utf-8?B?c2hqOUIwSVJJSUlXWWxaUU8rMEdGS1F1dkxqakwrMW1xTEp4a0NyV091bDlC?=
 =?utf-8?B?K0lIRGl6M2tMWUVUOGs0M003QUFkaDhET0VHVmRkaTFPcEw1NHlsZGZuRkFC?=
 =?utf-8?B?RkRkYTZSYzlFdG4rMmhnYlNqM3BWR2FxZ2dTZTN4U21oU3VlbUJJZExIZDNq?=
 =?utf-8?B?VG04WGhQaDJGaEdsWGdoNEp1TDN4YjhCeWJLTTV6TXdTRUlJOGNjYXZKNC8x?=
 =?utf-8?B?YWVxU1ZhK3U3Yit1UzltV29Nb0RRWndZZlhpS2oxU2g0SEx5NFBiQkdNMFlD?=
 =?utf-8?B?bk5qUDU3cVVDNCtZZ3Z1RFhzL0t0MzU1NjlCSjJDeCtjVjB2TFdBTTVQMGEy?=
 =?utf-8?B?MUl0WGRoU2N0M0lUeUNhcTZDR1ZKbWhqblVSYWhTbVViWTdpWXY5ZGxoSSs1?=
 =?utf-8?B?N1cvNi9NcExJTGxBUVlOeWdmRURqS05MR1NmWGdlWEZNZzRidDZLRi9KQzJi?=
 =?utf-8?B?VEJ6UWkxOXZZbFhmYkQxQmcydExqR3dBMDhOcXVyR0d6NFB4RzZhVWRNTU1N?=
 =?utf-8?B?QWFOU0M0SWNtdnQ3cGx6UFZYbXUwRURKaWRJSWFLS1ZwSjcvKzFidUpTTnhu?=
 =?utf-8?B?Zk1lWGQ5cjlDMEorbmliVTNQbGwxR0RZd3VUeXE3YzM4NUtRUVFJaDlFR1Iv?=
 =?utf-8?B?b1hmaGVTTnpGVkNUdEgxdXlJUm5ETi9sa1RhY2xCSy9jbHg2Z0pvdi9zZXRQ?=
 =?utf-8?B?VFQ4Tm9ZaE83eEI0N09SN0lVTlJubEp3MTk5a2swWkFRSVlPY0tnSDVaVVpi?=
 =?utf-8?B?VUhQSk9UYXRNWjNEQ2pXNnFhalQ0cGtiRG1USWpCR0RMU3lCVmJ3c21URUJT?=
 =?utf-8?B?SnN2K0xQWno2R2VxUHNMcFRjR1h4S2t0ekdZdElTZ2YwUVZrM1QwYzhrbERQ?=
 =?utf-8?B?ak9BYVhHUFhQRllXZTBweW8wZkcvam5YRE5aMk4zeEdTcDlRa29ob2VpSDJh?=
 =?utf-8?B?Y05vUnk1UW44TVNtRFkycktXRG9YKzVFQzBXZ2ZyOTZIVHpzVnFIKzhNcUpi?=
 =?utf-8?B?SFlQRGh5Tmd1RGlEZmZRZUNSTFZQVjRCdTBNWU1RSWcwKzNzMW1NdytBakVz?=
 =?utf-8?B?MndPeEhXeW52aGtBaVE1RTlHYkFNWEVjUHVJSGhYYXhWQ3AxS08zSy9hT0dV?=
 =?utf-8?B?UlN5ZlhwZngzOVA0bTlwRXhESmxWSU1zM1N6cENGWGlrTXRUZ3V4Z0Mvb04r?=
 =?utf-8?B?Q1ZtM2dLVkF1YjdBQXE5TE1PRXpoSGFWUTZBZk1NNzZlS3k5U0JYWXFOeDlI?=
 =?utf-8?B?SUNYbkVBYjVYUUJFQ1E2Tjg2WG1QRzJzQUVLaE0vamZmbU15WUxQcmhtWVpp?=
 =?utf-8?B?LzhnVHpaZzdUT2ttb000NWc5M0RYcW9XUmlvN1I3NU9uRERDYXQ3OGtpWWV5?=
 =?utf-8?B?dS8vT1JybU9rL1FUVDNnakhBMzBsYkhEYnhXOEpxbDNvS2I3UzMwZ3REM29i?=
 =?utf-8?B?OU9UaUpVSEdDc1pkZGZmcnVIdnZxRWhGUmF1NVFDQzduNG5HQVZFbzgvRzVl?=
 =?utf-8?B?MXJxMWwvSklWU1NqZEFtOWRNcmdSR2luaUFvdlhQYXpiQjQxZGUzUlpiTngy?=
 =?utf-8?B?WGo2RWx5KzVPZUlVcDQvdi94dy9PenB2OGVTTDhiWTR4dE1LU1JsSmRwdEdS?=
 =?utf-8?Q?1ogQYQQdEQppv4pl5Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88424322-b8b2-4783-118c-08decd336909
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 12:16:22.5231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSRIjK+Vij+5eft+5BGaTaq27Iw1SJH+NDuP5M5nqhun0NJujmeL5RT6/WpDfzOa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7918
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

On 6/17/26 21:14, Timur Kristóf wrote:
> These functions were largely redundant with the respective
> suspend() and resume() functions, the main difference being
> that they were less used and therefore less likely to be
> tested and correct.
> 
> Move anything relevant from pre/post_soft_reset()
> that is not already done by suspend()/resume()
> into the soft_reset() functions.
> 
> Note that future uses of soft_reset() will need to call
> the suspend() / resume() functions and the necessary clock
> and power gating functions.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Acked-by: Christian König <christian.koenig@amd.com>

Might be better to split that up per IP engine type/generation.

But not 100% sure.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 11 +--
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 95 +++---------------------
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 -
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  2 -
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 40 ----------
>  drivers/gpu/drm/amd/amdgpu/tonga_ih.c    | 20 -----
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    | 25 -------
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c    | 27 -------
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  2 -
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  2 -
>  drivers/gpu/drm/amd/include/amd_shared.h |  2 -
>  11 files changed, 15 insertions(+), 213 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 0a34c08e251e..e1d478a5e40e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5191,14 +5191,12 @@ static int gfx_v11_0_soft_reset(struct amdgpu_ip_block *ip_block)
>  
>  	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>  
> -	return gfx_v11_0_cp_resume(adev);
> -}
> +	r = gfx_v11_0_cp_resume(adev);
> +	if (r)
> +		return r;
>  
> -static int gfx_v11_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
>  	/**
> -	 * GFX soft reset will impact MES, need resume MES when do GFX soft reset
> +	 * GFX soft reset impacts MES, resume MES after GFX soft reset is finished
>  	 */
>  	return amdgpu_mes_resume(adev, 0);
>  }
> @@ -7187,7 +7185,6 @@ static const struct amd_ip_funcs gfx_v11_0_ip_funcs = {
>  	.is_idle = gfx_v11_0_is_idle,
>  	.wait_for_idle = gfx_v11_0_wait_for_idle,
>  	.soft_reset = gfx_v11_0_soft_reset,
> -	.post_soft_reset = gfx_v11_0_post_soft_reset,
>  	.set_clockgating_state = gfx_v11_0_set_clockgating_state,
>  	.set_powergating_state = gfx_v11_0_set_powergating_state,
>  	.get_clockgating_state = gfx_v11_0_get_clockgating_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index dd1823bd89ad..7bd668f71b41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -4891,52 +4891,12 @@ static int gfx_v8_0_resume(struct amdgpu_ip_block *ip_block)
>  	return gfx_v8_0_hw_init(ip_block);
>  }
>  
> -static int gfx_v8_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -	u32 grbm_soft_reset = 0;
> -
> -	if ((!adev->gfx.grbm_soft_reset) &&
> -	    (!adev->gfx.srbm_soft_reset))
> -		return 0;
> -
> -	grbm_soft_reset = adev->gfx.grbm_soft_reset;
> -
> -	/* stop the rlc */
> -	adev->gfx.rlc.funcs->stop(adev);
> -
> -	if (REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CP) ||
> -	    REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_GFX))
> -		/* Disable GFX parsing/prefetching */
> -		gfx_v8_0_cp_gfx_enable(adev, false);
> -
> -	if (REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CP) ||
> -	    REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CPF) ||
> -	    REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CPC) ||
> -	    REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CPG)) {
> -		int i;
> -
> -		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -			struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
> -
> -			mutex_lock(&adev->srbm_mutex);
> -			vi_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> -			gfx_v8_0_deactivate_hqd(adev, 2);
> -			vi_srbm_select(adev, 0, 0, 0, 0);
> -			mutex_unlock(&adev->srbm_mutex);
> -		}
> -		/* Disable MEC parsing/prefetching */
> -		gfx_v8_0_cp_compute_enable(adev, false);
> -	}
> -
> -	return 0;
> -}
> -
>  static int gfx_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  	u32 grbm_soft_reset = 0, srbm_soft_reset = 0;
>  	u32 tmp;
> +	int i;
>  
>  	if ((!adev->gfx.grbm_soft_reset) &&
>  	    (!adev->gfx.srbm_soft_reset))
> @@ -4945,6 +4905,16 @@ static int gfx_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
>  	grbm_soft_reset = adev->gfx.grbm_soft_reset;
>  	srbm_soft_reset = adev->gfx.srbm_soft_reset;
>  
> +	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +		struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
> +
> +		mutex_lock(&adev->srbm_mutex);
> +		vi_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> +		gfx_v8_0_deactivate_hqd(adev, 2);
> +		vi_srbm_select(adev, 0, 0, 0, 0);
> +		mutex_unlock(&adev->srbm_mutex);
> +	}
> +
>  	if (grbm_soft_reset || srbm_soft_reset) {
>  		tmp = RREG32(mmGMCON_DEBUG);
>  		tmp = REG_SET_FIELD(tmp, GMCON_DEBUG, GFX_STALL, 1);
> @@ -4994,47 +4964,6 @@ static int gfx_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
>  	return 0;
>  }
>  
> -static int gfx_v8_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -	u32 grbm_soft_reset = 0;
> -
> -	if ((!adev->gfx.grbm_soft_reset) &&
> -	    (!adev->gfx.srbm_soft_reset))
> -		return 0;
> -
> -	grbm_soft_reset = adev->gfx.grbm_soft_reset;
> -
> -	if (REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CP) ||
> -	    REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CPF) ||
> -	    REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CPC) ||
> -	    REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CPG)) {
> -		int i;
> -
> -		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -			struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
> -
> -			mutex_lock(&adev->srbm_mutex);
> -			vi_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> -			gfx_v8_0_deactivate_hqd(adev, 2);
> -			vi_srbm_select(adev, 0, 0, 0, 0);
> -			mutex_unlock(&adev->srbm_mutex);
> -		}
> -		gfx_v8_0_kiq_resume(adev);
> -		gfx_v8_0_kcq_resume(adev);
> -	}
> -
> -	if (REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CP) ||
> -	    REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_GFX))
> -		gfx_v8_0_cp_gfx_resume(adev);
> -
> -	gfx_v8_0_cp_test_all_rings(adev);
> -
> -	adev->gfx.rlc.funcs->start(adev);
> -
> -	return 0;
> -}
> -
>  /**
>   * gfx_v8_0_get_gpu_clock_counter - return GPU clock counter snapshot
>   *
> @@ -6800,9 +6729,7 @@ static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
>  	.resume = gfx_v8_0_resume,
>  	.is_idle = gfx_v8_0_is_idle,
>  	.wait_for_idle = gfx_v8_0_wait_for_idle,
> -	.pre_soft_reset = gfx_v8_0_pre_soft_reset,
>  	.soft_reset = gfx_v8_0_soft_reset,
> -	.post_soft_reset = gfx_v8_0_post_soft_reset,
>  	.set_clockgating_state = gfx_v8_0_set_clockgating_state,
>  	.set_powergating_state = gfx_v8_0_set_powergating_state,
>  	.get_clockgating_state = gfx_v8_0_get_clockgating_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index f0707139a745..09c8d95df89f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -871,9 +871,7 @@ static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
>  	.resume = jpeg_v5_0_1_resume,
>  	.is_idle = jpeg_v5_0_1_is_idle,
>  	.wait_for_idle = jpeg_v5_0_1_wait_for_idle,
> -	.pre_soft_reset = NULL,
>  	.soft_reset = NULL,
> -	.post_soft_reset = NULL,
>  	.set_clockgating_state = jpeg_v5_0_1_set_clockgating_state,
>  	.set_powergating_state = jpeg_v5_0_1_set_powergating_state,
>  	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> index 717eaf43c9a6..ff02f72352a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> @@ -690,9 +690,7 @@ static const struct amd_ip_funcs jpeg_v5_0_2_ip_funcs = {
>  	.resume = jpeg_v5_0_2_resume,
>  	.is_idle = jpeg_v5_0_2_is_idle,
>  	.wait_for_idle = jpeg_v5_0_2_wait_for_idle,
> -	.pre_soft_reset = NULL,
>  	.soft_reset = NULL,
> -	.post_soft_reset = NULL,
>  	.set_clockgating_state = jpeg_v5_0_2_set_clockgating_state,
>  	.set_powergating_state = jpeg_v5_0_2_set_powergating_state,
>  	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index e77261a64cf8..c2d098cd72ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -1237,44 +1237,6 @@ static int sdma_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  	return -ETIMEDOUT;
>  }
>  
> -static int sdma_v3_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -	u32 srbm_soft_reset = 0;
> -
> -	if (!adev->sdma.srbm_soft_reset)
> -		return 0;
> -
> -	srbm_soft_reset = adev->sdma.srbm_soft_reset;
> -
> -	if (REG_GET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_SDMA) ||
> -	    REG_GET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_SDMA1)) {
> -		sdma_v3_0_ctx_switch_enable(adev, false);
> -		sdma_v3_0_enable(adev, false);
> -	}
> -
> -	return 0;
> -}
> -
> -static int sdma_v3_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -	u32 srbm_soft_reset = 0;
> -
> -	if (!adev->sdma.srbm_soft_reset)
> -		return 0;
> -
> -	srbm_soft_reset = adev->sdma.srbm_soft_reset;
> -
> -	if (REG_GET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_SDMA) ||
> -	    REG_GET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_SDMA1)) {
> -		sdma_v3_0_gfx_resume(adev);
> -		sdma_v3_0_rlc_resume(adev);
> -	}
> -
> -	return 0;
> -}
> -
>  static int sdma_v3_0_soft_reset(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> @@ -1531,8 +1493,6 @@ static const struct amd_ip_funcs sdma_v3_0_ip_funcs = {
>  	.resume = sdma_v3_0_resume,
>  	.is_idle = sdma_v3_0_is_idle,
>  	.wait_for_idle = sdma_v3_0_wait_for_idle,
> -	.pre_soft_reset = sdma_v3_0_pre_soft_reset,
> -	.post_soft_reset = sdma_v3_0_post_soft_reset,
>  	.soft_reset = sdma_v3_0_soft_reset,
>  	.set_clockgating_state = sdma_v3_0_set_clockgating_state,
>  	.set_powergating_state = sdma_v3_0_set_powergating_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> index 671f5bf18a3a..a3e883f6f099 100644
> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> @@ -390,24 +390,6 @@ static int tonga_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  	return -ETIMEDOUT;
>  }
>  
> -static int tonga_ih_pre_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	if (!ip_block->adev->irq.srbm_soft_reset)
> -		return 0;
> -
> -	return tonga_ih_hw_fini(ip_block);
> -}
> -
> -static int tonga_ih_post_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -
> -	if (!adev->irq.srbm_soft_reset)
> -		return 0;
> -
> -	return tonga_ih_hw_init(ip_block);
> -}
> -
>  static int tonga_ih_soft_reset(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> @@ -462,9 +444,7 @@ static const struct amd_ip_funcs tonga_ih_ip_funcs = {
>  	.resume = tonga_ih_resume,
>  	.is_idle = tonga_ih_is_idle,
>  	.wait_for_idle = tonga_ih_wait_for_idle,
> -	.pre_soft_reset = tonga_ih_pre_soft_reset,
>  	.soft_reset = tonga_ih_soft_reset,
> -	.post_soft_reset = tonga_ih_post_soft_reset,
>  	.set_clockgating_state = tonga_ih_set_clockgating_state,
>  	.set_powergating_state = tonga_ih_set_powergating_state,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index 7a6b6277cadd..8bb9592b0981 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -1166,17 +1166,6 @@ static int uvd_v6_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  
>  #define AMDGPU_UVD_STATUS_BUSY_MASK    0xfd
>  
> -static int uvd_v6_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -
> -	if (!adev->uvd.inst->srbm_soft_reset)
> -		return 0;
> -
> -	uvd_v6_0_stop(adev);
> -	return 0;
> -}
> -
>  static int uvd_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> @@ -1208,18 +1197,6 @@ static int uvd_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
>  	return 0;
>  }
>  
> -static int uvd_v6_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -
> -	if (!adev->uvd.inst->srbm_soft_reset)
> -		return 0;
> -
> -	mdelay(5);
> -
> -	return uvd_v6_0_start(adev);
> -}
> -
>  static int uvd_v6_0_set_interrupt_state(struct amdgpu_device *adev,
>  					struct amdgpu_irq_src *source,
>  					unsigned type,
> @@ -1519,9 +1496,7 @@ static const struct amd_ip_funcs uvd_v6_0_ip_funcs = {
>  	.resume = uvd_v6_0_resume,
>  	.is_idle = uvd_v6_0_is_idle,
>  	.wait_for_idle = uvd_v6_0_wait_for_idle,
> -	.pre_soft_reset = uvd_v6_0_pre_soft_reset,
>  	.soft_reset = uvd_v6_0_soft_reset,
> -	.post_soft_reset = uvd_v6_0_post_soft_reset,
>  	.set_clockgating_state = uvd_v6_0_set_clockgating_state,
>  	.set_powergating_state = uvd_v6_0_set_powergating_state,
>  	.get_clockgating_state = uvd_v6_0_get_clockgating_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index e01c4af46db1..9f4e88440c0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -662,31 +662,6 @@ static int vce_v3_0_soft_reset(struct amdgpu_ip_block *ip_block)
>  	return 0;
>  }
>  
> -static int vce_v3_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -
> -	if (!adev->vce.srbm_soft_reset)
> -		return 0;
> -
> -	mdelay(5);
> -
> -	return vce_v3_0_suspend(ip_block);
> -}
> -
> -
> -static int vce_v3_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -
> -	if (!adev->vce.srbm_soft_reset)
> -		return 0;
> -
> -	mdelay(5);
> -
> -	return vce_v3_0_resume(ip_block);
> -}
> -
>  static int vce_v3_0_set_interrupt_state(struct amdgpu_device *adev,
>  					struct amdgpu_irq_src *source,
>  					unsigned type,
> @@ -868,9 +843,7 @@ static const struct amd_ip_funcs vce_v3_0_ip_funcs = {
>  	.resume = vce_v3_0_resume,
>  	.is_idle = vce_v3_0_is_idle,
>  	.wait_for_idle = vce_v3_0_wait_for_idle,
> -	.pre_soft_reset = vce_v3_0_pre_soft_reset,
>  	.soft_reset = vce_v3_0_soft_reset,
> -	.post_soft_reset = vce_v3_0_post_soft_reset,
>  	.set_clockgating_state = vce_v3_0_set_clockgating_state,
>  	.set_powergating_state = vce_v3_0_set_powergating_state,
>  	.get_clockgating_state = vce_v3_0_get_clockgating_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index a0638bdb9255..437b67c573a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -1657,9 +1657,7 @@ static const struct amd_ip_funcs vcn_v5_0_1_ip_funcs = {
>  	.resume = vcn_v5_0_1_resume,
>  	.is_idle = vcn_v5_0_1_is_idle,
>  	.wait_for_idle = vcn_v5_0_1_wait_for_idle,
> -	.pre_soft_reset = NULL,
>  	.soft_reset = NULL,
> -	.post_soft_reset = NULL,
>  	.set_clockgating_state = vcn_v5_0_1_set_clockgating_state,
>  	.set_powergating_state = vcn_set_powergating_state,
>  	.dump_ip_state = amdgpu_vcn_dump_ip_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> index 1fb1dea3f129..b9f6ae75ea72 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> @@ -1203,9 +1203,7 @@ static const struct amd_ip_funcs vcn_v5_0_2_ip_funcs = {
>  	.resume = vcn_v5_0_2_resume,
>  	.is_idle = vcn_v5_0_2_is_idle,
>  	.wait_for_idle = vcn_v5_0_2_wait_for_idle,
> -	.pre_soft_reset = NULL,
>  	.soft_reset = NULL,
> -	.post_soft_reset = NULL,
>  	.set_clockgating_state = vcn_v5_0_2_set_clockgating_state,
>  	.set_powergating_state = vcn_set_powergating_state,
>  };
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 2f9e41cf3ac7..e7316e949d11 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -467,9 +467,7 @@ struct amd_ip_funcs {
>  	void (*complete)(struct amdgpu_ip_block *ip_block);
>  	bool (*is_idle)(struct amdgpu_ip_block *ip_block);
>  	int (*wait_for_idle)(struct amdgpu_ip_block *ip_block);
> -	int (*pre_soft_reset)(struct amdgpu_ip_block *ip_block);
>  	int (*soft_reset)(struct amdgpu_ip_block *ip_block);
> -	int (*post_soft_reset)(struct amdgpu_ip_block *ip_block);
>  	int (*set_clockgating_state)(struct amdgpu_ip_block *ip_block,
>  				     enum amd_clockgating_state state);
>  	int (*set_powergating_state)(struct amdgpu_ip_block *ip_block,

