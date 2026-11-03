Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75945606A33C
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MtbM4l8+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1546510E754;
	Tue,  3 Nov 2026 08:45:31 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010029.outbound.protection.outlook.com
 [40.93.198.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D62B10E754
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 08:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOWildRl/f4o2rc9HhQjV0JJIP1rGOyq29UFgfuLB/d0geXlCLpe0e26POuGULVR9gkngGR7emHBpSF5YT7MenRDwW6ZZ7CHPPmebPphqhZ2/eimYfTKLIUF38DFO8gNnLp4lg8G9uuguKh1FzoKBEYK0RhKg34LWFMZ7S+NH+ZnsBvyOjQpOnMYtmvd5nO6qO0W44rU46YkZKbV95Ih3sm/nIdtqn/OZK6zoimItHGz8+igvqyVyP1aC2jE5mFszulDtBwfWjBxsSVQ+O5AK9zer8XyPUwyjgxlNsGQHDRg4Q2NWzv8t5f9gN9JT3ookzZ8zqvCrJVOqvI03JUy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhcYoT+SEpHpN8bULGPyXo8p9gOWLXwYdymCH5YWwFo=;
 b=UzpVmJ/UBQ9EKknGl3h+i5LGuPZP6a3nuH2OO/L3dQgK04CajCQM1nyCrM1bHmlcpo0XiAor8kLuGaI/6KM2aXFxGPd3QZ92vh28/HqOz1p38+t+AD20jQvmpIGJcJwkw3OHGrtXTtX9NAth/y6gcjKFrWBWAZrHeL6B+fdquNqjiFfMFXLugc+WVurT/W9z35Xzq4wdfPRKCO96IU0iCdI11nE2BQUjrg+XCJdV/MZe/m95WzXrN0fmiVQV74t0+ogg9zhO/Pw8hqWbHDxo/zZFGc5vtWTp5fHY4ghhjaJMfynqi7YtQBC9DpL5Ou0neyNVQL6kLG9Li9XYTt4QVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhcYoT+SEpHpN8bULGPyXo8p9gOWLXwYdymCH5YWwFo=;
 b=MtbM4l8+/3/eGJlZ/qqfFZzedHZURh5zhy6T7wFdU9PNupCDWnT1pOSEsGSyfqJsVcad0m9jajghI77g80QgPxR3JCN6gLGWhQUxF1VlWliZN3ulkC6T0teaz/aJPhqeKvBZNChVpwCo3iTvH5aFiGBIK52WDUiwly7e/5uN59M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB8440.namprd12.prod.outlook.com (2603:10b6:806:2f8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Tue, 3 Nov
 2026 08:45:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 08:45:21 +0000
Message-ID: <033c60fc-6b93-43a0-ac0a-567c8f9bcff2@amd.com>
Date: Tue, 3 Nov 2026 09:45:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: don't drop the gang dependency fence twice
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20261103083132.3056003-1-Jesse.Zhang@amd.com>
 <20261103083132.3056003-2-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261103083132.3056003-2-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e00bf3-975e-418f-d80f-08df3986cb87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|261102123227099003|22082099003|10067099003|56012099006|261021121427099003|4143699003|261021135927099003|261022075727099003|261021123027099003|261028144727099003|11063799006|261022105027099003|261009223027099003|261026140227099003|260925022911599003|260925021311599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: OD1cXsJKv5NLsph4VhVVYcOLOQvbrjPsTYyx3FIJdQF4Wt+18rL0qo948pYIHFwxyztxQUfN9ALr/fs07bepIWgnehDsrXi2nH+gBYsQ0jKtGXkmVTKv3L+AIhKis1frYKuhkE+0vQhc7wAFwb20QZR2aBY4pWibhaki6izHpFFI+dryHc4OO9afqH7HGKtfXB6yhlDXInbPYXUka0HXGhajRKU0pKpz8P4raGPMMwCTZ4CgQqVdIwgWiJXzLwAWHmn3+RUwSfeVzx/7TUlpHDhCsSASb3ZWK1XhXvJCvzbAslshvbGeotRcec8jn9fN0SfEzp8MIL+J2xtmXLVNmYxjvomh8G9dJdWO5iRYQQcgsOc4Hz7lydxE5fFddfmQlKJK6TYtOWF7L0e2chQFGr4PebLkSNPSBmZteLKeev1ZHrejT35TbNnDeujjBgAtOEGCy6d4gs00DCJ09xYDjYVRbKAL3d+keEulH87ZULxpDkrGFvzu+IUkVeH058uCK5fsyxEEpPXRfTxZByz/9BBc5H9jsl2p/N36GanF43rvctXmvMjqoxxddsdxf+1QTrbRmw61MiTZboLtUsoDmgcfP20Vw7JnAUJ1bgnIlNlKpXOM3/LIT3KiuGcBGwMEhanaM7KjRDvfTlFcdEuNfupKtU4sKl2Ak0NrZbEVVKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(261102123227099003)(22082099003)(10067099003)(56012099006)(261021121427099003)(4143699003)(261021135927099003)(261022075727099003)(261021123027099003)(261028144727099003)(11063799006)(261022105027099003)(261009223027099003)(261026140227099003)(260925022911599003)(260925021311599003)(260925021911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anUwWFc0blpadTJITjNQc1QxckhBK0FJVU5hRm4rbmdlWXo0UFhmckNDZDRp?=
 =?utf-8?B?MDE1cFR6M3JOYWxHMnR5Q1pWaWZ5bUxVR3IxbldmUTBzWTlYaExXcFB0ay9I?=
 =?utf-8?B?N3JoTmV5Z2p1aHQzcnE3Q1ZCQ2dIZmJSRkJVOTNnNTk4czVSZXhFVW1CQmpS?=
 =?utf-8?B?a0QzUGVOTUZyMmZEcHV2Z1RZcVJvV2R6QzNiTzNHcU1JMEx5SktNT0paVnFM?=
 =?utf-8?B?d1VvTldMNFFrbWJ1Y3Z4YSttZUNwRjE3OGs4VTE4WXhNL09BOEsrVWwwWlht?=
 =?utf-8?B?RlBqMWZvcnBkcWM0L0V4bE5tV0F4SndKYk44YVZ2Qnd0ZDkxSFdpSHpCREM3?=
 =?utf-8?B?M0Z2N2cxVVg1Ri9YYzZ0ajhOVEN1VzRnM1RkbmwzKzNaUU5SOXhMMEdDbmRw?=
 =?utf-8?B?SXIvUkRETlpyZnNJczBZSCthSVpXRGw0WkJsZXBnUkdKMmRZSmxHaHMydUxN?=
 =?utf-8?B?NUlpT1p1MHdaeXE5ZUZ0VytYY1FJNDRVcUd5UkgyNXdaYUluMXRnSFpzYlVQ?=
 =?utf-8?B?QWhCME0wRlM1eFY2MUhibDkwRHlxVmpUQ01OcVhoNE9nNDNSV1pudFF6Wm9B?=
 =?utf-8?B?dERqTVE0bHM2emZQN3VDTmhVcXorTHozdkV2azBwTmJHUElacC9rZFc3YjM0?=
 =?utf-8?B?bU5GdEVpTUJNYTRYQVltZm5CME80dUF4cHhlckY0YWhhVnFYclY0dHVSWklj?=
 =?utf-8?B?WUlxaDc5WDdBSDlQUk03VkgxTzNWeWZqU3puckQvL2FnbG5GRk1MZnA5YnF0?=
 =?utf-8?B?Vkx1MVhLWTA4RE96aThZZ1Y3a2d3U09pMVF6M015dktVOVRQeEtOSzNPZjdT?=
 =?utf-8?B?WTZOTE4vNlN0UWNQSnZESDdmNTgyVzFyaHRCaHhHM2ZEZHVJRTdkMlF2b1lP?=
 =?utf-8?B?OUx1SWRLb3ZiMTczUW9lU0Yxb0xVbFZVejZQWVJLbVE2K2dadG55Kzkzc2Jo?=
 =?utf-8?B?UEVTcnBreHRvUllTWHBZWnBSZ0xxUnRibTdyRCtDQWErWk1iQUZFcHhKamRJ?=
 =?utf-8?B?QXo4MWkzTUpuU25oVDc3a3psME9IVWdJbnE1VWJXUW5LeEZ6N0k1cktoczlr?=
 =?utf-8?B?YUFPV2h6U2VLWTlaUVoybEczaFRtbmJLd1VQY2R3cnhiS2I4aWl3UVJpU1dS?=
 =?utf-8?B?eGZ2K1VWRDJBNFRrYXlONWs3d0VXMkZXVTk1QnFUR2FmTk9tUDk5bjYzTi9s?=
 =?utf-8?B?NWNaa2FNVWt1Z1o4ZUVjZFdjekdMbHBYZWowQm5WOFdUVkVmT0JqZzVzQnpK?=
 =?utf-8?B?eWl2eXU2elhDM2N0NW5aZVZBUTFwTzFwbmhIaHEva0ZPWmtNVWkzcjl6SU9L?=
 =?utf-8?B?Rm9zeGlUaTREalh1YmZ3YkVFMlNDTEZBcmt1M0h3SnVZaUNpMFVNNHVFNTRi?=
 =?utf-8?B?QndNS3l5Qnc1b3FtSEJRQndZVlQxODNXaWJZY0IxWE9WWTE5RWRLY29UM21k?=
 =?utf-8?B?Wm5QcUpDdjJET01oN3lJaW5vL3cxbEtjNWxrNmk4NTVHcXZqM01BOWZuMWdM?=
 =?utf-8?B?SzBFUDFWTlV0Zk1VaENVSVdvRkdQbmRtMHI5YXdYUE1OUzhzUEF6cEtwQ1J0?=
 =?utf-8?B?aTVnOUlmeC8veE0xVmNBa0ZQRHk2WFhlMUxKSWlueWh6SmlFTEhJaVNtR0pM?=
 =?utf-8?B?eFNBZFZ0akVsUXFyNytONk82RGFWcEhoTlBvMzhmN1Y0R0VWemxadURNQXhH?=
 =?utf-8?B?QnE0QytVZXR0aE84ZDVpZFcyOUhnOEVaN3BUME4zdzR2MWhUWXpwOTc4NWJq?=
 =?utf-8?B?OTIxNW0zTURXZW1zUmxrUE1xUVVyZjhIMHUweTdETjA4aC81QjZDOTZnNFM4?=
 =?utf-8?B?aGdTeEdDcDM3TTM1K2dDU0pkSTdGZWFpVUJoN3Y5OFRGYU91cnM0WWF5UWJU?=
 =?utf-8?B?ZWh0VXZVb3pQS0J0c0NuMHVLOW50SzJWNVAvbjFEOEtlSGx2QmNpcXZjbm1L?=
 =?utf-8?B?RnFyQnFDR3VTUHF4OEc1T24zUlRLYU5KOHVtOEUrZE10dWhZeG5LanZmM2hQ?=
 =?utf-8?B?OHRDc0lzam1DT2gxSlVzVVYzc2gzZ2E5ckpJZGJTWlZZbUFTNWdtTlFlcE50?=
 =?utf-8?B?ZkRNWENJb1hiSnQyZ3U4akVybFkwbnlHdG9JUlhFakJvU3BwNGxLdlQwY2hG?=
 =?utf-8?B?elA2MksweVVpNG5hTlU4SDE0MVZObE1sOGJuUFQwWTcrT3NrZ2g2b0lPeDFn?=
 =?utf-8?B?QTVqV2ZVQVVSRDVBenh0Q2NPUlh6T0piK2tDMnZMc1haWDFJbDRoenYwcndy?=
 =?utf-8?B?dDUrVXBmbVM5elpGdUZDZTVDTVR3MlJHM1lHVDlTd1NQcXptRnJtVjh4cFRU?=
 =?utf-8?Q?tjiLCdxkqeZRjbh7zG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e00bf3-975e-418f-d80f-08df3986cb87
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 08:45:21.4076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeEdedcHnEOyAm3q1U9WzX6Vtq+LkqAv3a+hPn7zV7b9dok5ZApwDITJz7Duc095
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8440
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 09:31, Jesse Zhang wrote:
> drm_sched_job_add_dependency() drops the fence reference when it fails,
> but amdgpu_cs_submit() drops it again, so the scheduled fence of a gang
> member loses a reference it still needs.
> 
> A GFX+COMPUTE gang waiting for another context, with the
> xarray node allocation for the leader's dependency failed through
> failslab:
> 
>   WARNING: drivers/dma-buf/dma-fence.c:589 at dma_fence_release+0x34d/0x730, CPU#1: amd_uapi_regres/2993
>    drm_sched_job_cleanup+0x2c2/0x340 [gpu_sched]
>    amdgpu_job_free+0xcb/0x3e0 [amdgpu]
>    amdgpu_cs_parser_fini+0x435/0x710 [amdgpu]
>    amdgpu_cs_ioctl+0xcd2/0x7a60 [amdgpu]
>   Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>   RIP: 0010:dma_fence_signal_timestamp_locked+0x1b8/0x610
> 
> Fixes: ed21f6c3fe42 ("drm/amdgpu: fix another missing fence reference in the CS code")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index b4555d8d108d..71e2b83faa12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1331,10 +1331,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>  		fence = &p->jobs[i]->base.s_fence->scheduled;
>  		dma_fence_get(fence);
>  		r = drm_sched_job_add_dependency(&leader->base, fence);
> -		if (r) {
> -			dma_fence_put(fence);
> +		if (r)
>  			return r;
> -		}
>  	}
>  
>  	if (p->gang_size > 1) {

