Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4535FC02193
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 21:56:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E8510E584;
	Mon,  3 Feb 2025 21:56:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m+fdggO/";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B104B10E584
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 21:56:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdGHhn3tdrPeDEtFxJzM8clIHBarJK6e9z3SxwU3YTAVXden7lpsAANWkGMFRSBQp3LdNfX9PbV4e53yY28bEoPNvmTpbycR0Sod3LtjvDmoO9emGs+0nrKYL4POfIvEnsB0aMIoaILq/YOIjPH9Hqt74BsCC8gc0N+1acnYDB30nBN/EjF1Z1T7RZi3mrICNz9b+keoYCFW1xO35Bkmv4wta2cQTJHs9j4oWRKPVM4OzvOdJfaaVr4icoVStplwatr+fVjCgZLFVgiQLRYZpkJg1GEIQTIzkt39D6noZ2P2nOIH4tWK67cB0r1jDrslVeiX7uZO0k6725RRa07rGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Znl1RbA59AbIhiRNa3krM1IEjyycqS7Kg7FydYirDlE=;
 b=qdsi6M/VqeEpBHrYB826MHtmgkoneJ64jaWVP0hmBs6rj2SC5VJsGuAK5AjvF+TyPSdyS+05e8TogSMekPC30TgilrKcmIjOAgBBeWueaYmfNSclnX1FFJO3W3QqaYxS9isgPUZ2AAuRMc3cVv65ylGY162ufXz6bze6i/aW0kpCye0+WBOIG6LyEAdNPHmUsg/j/k7DFsjdQa7pPfITGhGfYWlYpOOYvtJAqFxENOMQTGS6awDu66G36+944vwN9M2h52iw+ZVP0YAaPtPwbcHmQhjAr5i+yy24PBbnHRR3lGO5MW07nUjM8+xwYdFUpIRV/ytTTTgtw1s3Kgklsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Znl1RbA59AbIhiRNa3krM1IEjyycqS7Kg7FydYirDlE=;
 b=m+fdggO/GciPja6PQsdr0RD5Oh/cMk+247m1Y6sOy5AnN7BOgUc7iFM8ZJh3IA/JV0f51o4GG4NgNpjuZU40yn9LRDifPplH5ADsGeiuVxarEMryesCLk5zABvtjUc8me1yISMZ3wUg8lQOadWTojjBf+Wsn9YuIbiSyhkvCTGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 21:56:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 21:56:00 +0000
Message-ID: <9a19d3eb-0830-4359-ab58-dc032e55a477@amd.com>
Date: Mon, 3 Feb 2025 15:55:58 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] drm/amdkfd: use GTT for VRAM on APUs only if GTT
 is larger
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131172113.1807775-1-alexander.deucher@amd.com>
 <20250131172113.1807775-2-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250131172113.1807775-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:806:130::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV3PR12MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: ff936fbb-5c0b-4d0f-476b-08dd449d8ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUptajZiWW9rcWZEcmFsRVZ3KzVFUEdpTHpXU2M4Zmdzb29yQVBpSWxYZVJj?=
 =?utf-8?B?UXowYXkzcGQ5cmZPajdlOVhFRGN5emxOeUtsc1EvbU9WemlkYTF2WnExaGRl?=
 =?utf-8?B?RnJiZW5mTnhIblE2TUVmSHVjdkhxbno0NDMwdmxnZW1NVHBPSmwyekxZV3pz?=
 =?utf-8?B?UFY2NTd0cktIVTBBdjVMWlk4YUdPZmxQVWR0ZnRMWjUzMk0wK2tLb0FGMERS?=
 =?utf-8?B?ajgrN09McStEQ3hVWkROdUhNYTJ6ZHo2UWd1RmF3U3hVSTFla0ExY2huYWpM?=
 =?utf-8?B?TW5LS1ZJSExOM0hBUkZmak41YzdlaGFOWi9MYkkyMzE0bGp2V2hKdnFyVDNz?=
 =?utf-8?B?ZFVybzRBRzBMdGNXZUJZMFB2WmVlRjBwQlQ3SHRJT1NueVR4aWptbWhvRG1k?=
 =?utf-8?B?K3lkVmlldFhEdUV2OFBNelU1eWxKbEttbERrNC82MERuMjVtY1ErOHViS2cx?=
 =?utf-8?B?R2RVOHpTdGhEVDh2a3hnNjMxTnphanlXSW8wU3p1SGE2b25JVzNqWHZWVDFJ?=
 =?utf-8?B?NU1ZRy93V0dqTzlxQWwwK3dMUmRYNGtIRklSVTJ1UDUweENvWTVWSEdtRTlB?=
 =?utf-8?B?KzVGck0xQjNxZG5od0wxKzBsWTBKWEsrNXRaYlpDTWVqMWl2cjR1QnVaK1A0?=
 =?utf-8?B?MGorWXhlMkF2S2I3SlVhWWc0aVJNQXovalpkSHR4NnpQb29CYUtlSHQ2WkJJ?=
 =?utf-8?B?NGF3N2tJLzZBR1FGdnJkazdnOGdQVUI0RW5vZ0U1Mjl4QjF0aGtPbnhobThQ?=
 =?utf-8?B?UlJwV0RjZktJS1lVOWl0dUV2OHhXRmJFUmlqWDNOV1BzcmQ4ait5RFNTNU9L?=
 =?utf-8?B?VmpoS0hTTzlQWU5WZWVLaU5VRnlaUmVweDA2L0tEYVVFL3R5aUQraFFSV3pG?=
 =?utf-8?B?WE81eW4wY1ZGTW5UNWtnZDJLRjRtbktadzh2TVJlTFFuY2FHdHc4UzV3bHNN?=
 =?utf-8?B?REgyRW53SEZXVC91bTMyNThqRXdub0Y2aDZORUM2bXgweUZ2Z3lRMXdYRGRU?=
 =?utf-8?B?Q3o5RzM2dFdJT0NlSTFuSElmSERJd1lnSmNISGM5dVRhQXZ2Qjc5Z3FKR1Uy?=
 =?utf-8?B?c2lMcG9GZ2JJRGZRY2MzMkdON1F5S0hRS254SXZETVpOc2RnOWtSaGFjSjdW?=
 =?utf-8?B?VmRpalZ2amZWMU5mbUhxUStuRUd4TktxY0lIMlVBbkhrNUJMQk9FdFpPMkxy?=
 =?utf-8?B?SW5SQUdjS0RPNElHc2RZZFVoMTdjR2dhcldCdU9McUR0a3VQSzBLZG1rVGtl?=
 =?utf-8?B?THczOXJVb0lDRW5PMzhvenZGY2NHaEtnWEpWcmJvM0hCSkRxS3Q1bmYyZTFM?=
 =?utf-8?B?U3pwVTREcTkxMFVnS1pHem9vSmtyS3hyWXV4aEpUL3ZpWGVPQ1RjbTdvb1o0?=
 =?utf-8?B?MytZRUdqK2ZGZkZ1YzJDVGxLTHpodUEva1V6MTkzRGZaSWZOQ0crVE5GcEZQ?=
 =?utf-8?B?b1ZLVTNvbWxtcjZSRUJEelJXbXkrMWR1ekgrV1FaRjlieTJXblJZdWFLT1kw?=
 =?utf-8?B?andqeFpwOGl2R2dGYW5ZaEZJWVphUW9SVkRwRllEc2VobDFBWGNTM3pLVVlu?=
 =?utf-8?B?UzNFUXB1Y3pOd0c3a0VES1NBaHp2SkNFZ0hSWEF0bmlwRnlXK3BCR2JLQks0?=
 =?utf-8?B?bHBxRTVrQ01BaDZJbGJPTlBqc0VoVUk2MXg0TUxaVG9NazRCRkZ0OVZqYm5Q?=
 =?utf-8?B?SmFoemRvS09URStucmJqYkZpaURPU2w4YURGZUhHWlRZL1N3alpYMTFub0k3?=
 =?utf-8?B?TlpDbnBsZExHbHFhaUNQcEhIekpZbVJqaTNnY2g0TWdDdkxSeVRiMEwreG5G?=
 =?utf-8?B?TDdxcWk5TW9oVFg5bDY3bEpkc0JhNGlkdlVOVnNRRlJKQ3R2MysrQU1ETFhS?=
 =?utf-8?Q?89774sbWJr5xX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXNLYVROMUtoM0hxUitiUlpmKzhNcWJ3MkdGbHBLa3U4Q3ViSFBpREpiYzBq?=
 =?utf-8?B?N1N2L0lZbkZldGJSTk9OdnVqQTg3MUhVbGNWK0V2Q0lvbHpEaDVEajVUc2Zt?=
 =?utf-8?B?emEzU1VaaEJuYk5RRVh3OHp1c2ZvK3Y3SU1BSSsraityY2pOQzUvYU4zWXcz?=
 =?utf-8?B?U01ickpWWVFpeVJoZEMwQWFvVlk5TGltcFFXaGtPN3ZYOFZWN3JZeDdMRGYx?=
 =?utf-8?B?NFVrVDUyNGhEdVA1ZDRwcUNVa001R0ZUOXpBV21YTWhFZVViWS9QWTFLRXBw?=
 =?utf-8?B?T3JNaExuNXdMWTZ4dExNU2FSMUxHdGIzRGY5M2VQUDJoU2JUcWxPeGpReFY1?=
 =?utf-8?B?Mkh0NEVkTFIyT0tSQWV3QkdDMm1jdFJKRE83SVQrMHdFazhDNVhNeWVjWjBt?=
 =?utf-8?B?M1lnalFybVZ0LzBkNWNSOVZYb1JFc1JkM0JxWE1XckVaVmt6aTk3aENVQytR?=
 =?utf-8?B?N3BHdnBYKzU3dloxT1QyRU9hUmJuSHR1YTJ3YXA2d3o5V2NUOEI3REUyVW1M?=
 =?utf-8?B?QVNXa1Azb2x2V09VN25TbzNHYmpPUGlpWFhPZ1liandWZ2V3ZmxRK05nbkZs?=
 =?utf-8?B?cWN6dmYwais1S2htZUtLQTU3d3RpWHkrMmxBNXd3OE5MbzZuWEVPSStNMFdi?=
 =?utf-8?B?d2pFWkVwWi9ZaVk0Q1h6WmNSTmMrdllEeVppemk3RUhCVDYxdmU1TFUrc0xR?=
 =?utf-8?B?cEo2NUt0OURzMUpzUFZzNkpKZWRjMFBFYTJ0TFh5aEFFekttVUpsb3BlQ2tt?=
 =?utf-8?B?N09naFdNOEpkTjVtRTVFb3AxbHYwSDVQdkthSlM1akl3MzVPQ0R6MkVUQ0ZY?=
 =?utf-8?B?K2lrRGF0T1RJNjJmWlducnR2SEFYMUduY0RnMWtLMVQxV2JlSmh4T3dQQnJR?=
 =?utf-8?B?UlhiOTJ1VzVhU1BHMWpwNmdtMGY3Yjh0YkI5UEtWeVBqa2tYQTUvbmxPWDlS?=
 =?utf-8?B?c3VNUHd0a2dva1VUOUtaek5PUkJXMHV2WWkrK3hJVmd5dzJpNGpwVGRMRUVP?=
 =?utf-8?B?UTBIckpaUDIwWXNhajRkd0FhVU5BUU5vd0FVOSs3MlMvOTY4RGhKVWVWZTFm?=
 =?utf-8?B?ZlIySDhnM1M3UVhhcEQraXloSFppQkVYSDFxVVBsbTdLZEVjWkx3aFdDYUtE?=
 =?utf-8?B?eWVuNEo1enB1T0pWRTNCdjVUZTZNZ3lKbTFZenU3N0lxS0hHSU4zTWV5WEJR?=
 =?utf-8?B?RWVtd2hKeW13R0VaQU9mUmpWdGVRYjlheUpiNytQT2FnOHhEUFQ4QlBJN3FS?=
 =?utf-8?B?NjNkbmwxL3hpd0lCV1NzVVVXZUxRUm16czJPZ29wWGxEaWtSaVhOeE5YOHE4?=
 =?utf-8?B?ZEczTWRycWhCVms2aUlvK0d3VDh6WmF5KzZuZGcyVkVBSFFQYzJHM3VPYmdo?=
 =?utf-8?B?SUZGcURiTkdpU3kxQ252QnBsV0lMME4xamZ1ZzFETnVJUnpROTE3bzZJWUpZ?=
 =?utf-8?B?MWlnMkhER2lWeU45dGJQSUlkZlkyVk51MVd0dFpuMEQydnNHWGNrUGxlaDdu?=
 =?utf-8?B?b2tuakZjVUkrNmNxamZHMzJ4L1JHZGV0bWFkVnVIRlN0Q1lBS2dBSDhSNVRG?=
 =?utf-8?B?dHo3QlEycVZKZmhGVTYxek1tazZ3TmtzclpZaHlFTktmcS9uelk2VjlwMy9C?=
 =?utf-8?B?Sit2VXN6OHFTeTAxYlZUWktIMHh5TGdLSG95VzYzcXc5TzQybkhudWtzSDY2?=
 =?utf-8?B?WFhiSzNEbUdYR3N5UE82MlFDWjJ5Q0kvZ3lnendyQnA2VXlHTjhlMFRqQlVp?=
 =?utf-8?B?dmw2UFR5UGhVN2hQY203QUFpSlZVUjZtems3aEZIVUVURlJIS3Q5aHNhaWhp?=
 =?utf-8?B?M09VNjNPVTJsSnZOQ3FZTTdVYnBtVmhBZGhURTJoVlA5M2ZYcUExcEZMbzhZ?=
 =?utf-8?B?Ukh3cFNYN1ZnUFh3VjAvY2liOVlhbGFrT0JYMFNpbkJtQU1VcnBDOVAwbGc5?=
 =?utf-8?B?VEM4SDBmUWN2TDlFbW9oNmpDVjh1d3RmRHR2T1BiUXNaV1BGNGhpYkNQYTEz?=
 =?utf-8?B?MEpHRHZTbHJBMTRPeDFEUXYyN3dySkhldVo1akozejREV2w4d28wYlVpcG8v?=
 =?utf-8?B?T0VuUmpYWHVNa21mNytnS3FDVnUrekQ3aFJzSmZTNHd4Q3Nycm43TVNzcUtR?=
 =?utf-8?Q?s7bP1jh/xe9YKtlb1+mnnXnYa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff936fbb-5c0b-4d0f-476b-08dd449d8ba9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:56:00.3544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/l7P++yZjQR76pBPrOWtoNuDf/NMHhjaFX8M3VUJBxPQNpHZW8Eefrh7YolhvK99yLKBSMs20ZcDG/AEP9OLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214
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

On 1/31/2025 11:21, Alex Deucher wrote:
> If the user has configured a large carveout on a small APU,
> only use GTT for VRAM allocations if GTT is larger than
> VRAM.
> 
> v2: fix reversed check (Philip)
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 32b42f1104623..1b8d7c4889341 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1989,8 +1989,10 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	DRM_INFO("amdgpu: %uM of GTT memory ready.\n",
>   		 (unsigned int)(gtt_size / (1024 * 1024)));
>   
> -	if (adev->flags & AMD_IS_APU)
> -		adev->apu_prefer_gtt = true;
> +	if (adev->flags & AMD_IS_APU) {
> +		if (adev->gmc.real_vram_size < gtt_size)
> +			adev->apu_prefer_gtt = true;
> +	}
>   
>   	/* Initialize doorbell pool on PCI BAR */
>   	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL, adev->doorbell.size / PAGE_SIZE);

For both patches:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

