Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B47C83F17
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 06:25:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73C9B10E50A;
	Tue, 15 Jul 2025 06:25:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xU89143J";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 235F410E50A
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 06:25:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McOGK6/uorK0ucZ/SBMzbcYYv0PVWW7zG/O1xuafR73xlx+Xcz5MK++e6HgHntw3N2asYGk7T9n/Tv+JX7GQoCyCZ6UtNQY0LaYre4X6nNiyUvPaUtuq5vX/i635WeDNX6ZhS3U8XXNTmci7xU4THOhIaNaT6P9J+s95CSFJZw1OwN63KJbCUzBk14zLm2dZOy8RmdCWKVcA0S4mMoKQVrLcPzCFh/PgzmsAL39dvx4bQ6VtGPTglUmIBVBHh3vItAiAq2TJM+3qDJYlIn/uYoNP6jmvS+tZumT3zDverXLJAKEOTn0ecVrNCivE5Zp/1gtpYII6p4sgbebw0zau3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrmJQ/3Gilz+3u8US4awn9xvDSAvB5doEPuu/xJrdqc=;
 b=vFGgaY3j5rsSu8UvZlBi+bVXKf0S8G+iiTPp4HdRDtLD/9HFp2UaDjLBsDs/qlnoowPcv2gkNdU8XgsfOosCDVV6loXn4qo1Q0j8TAIDW5Fy+489eTG2JNZqXWz3/cjijDOARKCYmI1MNzvpJ3reKgJr/NFVzKaNGwlScsZ0t2BA2pjRiVNNk0eRSbUx7tAKlzpyIVINIkMe7YRPKTs/2/AkRo5E3Vu6vwfzL1clTxLjuMAxYVpOz3Nv/kW/vv7Zr7BPa1LNKE007Ts0JwgtG364ThabGlLj18eyceKGw32rzBf1tOdV7xLreUPAA8LQ56qyu77HozHL0ADumPKFLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrmJQ/3Gilz+3u8US4awn9xvDSAvB5doEPuu/xJrdqc=;
 b=xU89143JN1Wb+QWxj5yUkLs9tx4zcjY44eC+YwhJVWQObbOtWywpC8n+jbWUd8dCMe6WKO3w3oAF6DS9TVfUHOg5eOFbLqXkCFdY6mK0kcmQlWTkrdz3SljVsMqmsXRd2U+zT1ipZ9hD4qsv2ZpllBw42k4grEKBaN9q8rGZcrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 06:25:27 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8880.023; Tue, 15 Jul 2025
 06:25:27 +0000
Message-ID: <8eb38883-64a6-42d5-b9da-600ba76aefcc@amd.com>
Date: Tue, 15 Jul 2025 11:55:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Use drm_*() macros instead of DRM_*() for
 amdgpu_cs
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250714192032.32089-1-mario.limonciello@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250714192032.32089-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0244.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH0PR12MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da6db2d-c16d-4c74-ad9c-08ddc368639e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mkg0b1czMGtpUVRlbVBLWjk0YVF4Q1c2enlhRjd2a1BMUWlKTk5FZHZqYjJG?=
 =?utf-8?B?UFYzczlQdFZMVmgra0h6Q3dQblFQOElEV0d5c040aXZyaldXa0xJM3V1RWVZ?=
 =?utf-8?B?aU5KV2Z1dkcvUjV2TnpkOHBSQ0Z6MTR1eW1FQTlLU2FVUW1ud1FzSlRUTmxN?=
 =?utf-8?B?YmRMK1ZNbDJTbjBQNmdVUGUzTFFxektMVE9nd1FLQzRUemRkUGhCTFZMWjc0?=
 =?utf-8?B?MnQyMVlTU3BSYmFQeU1tRklSV1ZCS21WQncweHl1eWRkdVpNQUN2NVlnenlH?=
 =?utf-8?B?NWZmMDc0WTBZSko3TWhVdEUyQVhIazNGTVBwM05QLy9BU2w4a2dSc29zVUtj?=
 =?utf-8?B?ZXVZVkJDbmpWZG8zaTRDTUNDWktMR3Z1NCt6VnJaMGN5SzBQcWdSSTBrOFNs?=
 =?utf-8?B?anBHejZGM1VSUDNoQlNyZ3BiWDdLQVFtNC81V0lzQVBwaFFSY1kydWtJMUlJ?=
 =?utf-8?B?VDI2UGFRTXlWd0w3UmsycEl5ZjY1bEFYOVNJUjRveld4YUorSWlnZWtQMm03?=
 =?utf-8?B?Y0VIZ1g5b3MvVWVVRXBVYzZPSGlLMXk3SHFuVkltYmdxVGlGZmM0UGM1SjNr?=
 =?utf-8?B?K05tczVEcWZVVWtZN3l5cmNtWTdsVkpNM0c0alMwZU8yRDJLNHZxYk53blU1?=
 =?utf-8?B?cWZMd2xsdDRGdEJsaFlqQzlTSEo2U0t4TjZZdkpid0dDdmprZFZNc3E0S0E1?=
 =?utf-8?B?dytaWUFMNzlibXR5ZHlneEUxaUZHdjBBbVNYWXRMSnVFMEtNaEFiNU8zaEdG?=
 =?utf-8?B?MzdCSlUxa2VONzNrWU03V3JmRnE0c3dxUmpiaVlvMEJEOXlJVVhSNExRemdG?=
 =?utf-8?B?Y1ZnRHVtd2RFZkFqdnFtNnhaWWpTSzMxdnlSZFpPbXQ2L093bmtvUXFQdzBY?=
 =?utf-8?B?Y0liV3F6ZFpyUmRIMUZia0FZLzd2V1d1S096anVBR0RKNVBJWnE2Zll3TEpr?=
 =?utf-8?B?aStMSDgyczU0RUw0M2J5Y29pNUt1bDVCK1htL0E2Y3B6c1o2eXZueE1iWEdO?=
 =?utf-8?B?MHBPenNrWEk0OTVFanBISnh4dTQzWVZLWUJlVmNHL0lzY1o1bTNCdVBTYWZT?=
 =?utf-8?B?MENOams3bXhiaVRmN1lUSWV0Y2Nlc2ZEZnk1ZVNYZ2s4RDE0K0x2RmV2dFhj?=
 =?utf-8?B?UFdTZTM2L0xzVnBKUFcxekE1dHd1ZnZzdG8wRFI3a2JhTXRyT0gzVVpzT3Fq?=
 =?utf-8?B?cDBlSVZZTFdvQXF4czVQMkdHdnFqYnJxKzY4ZHQ0UlRkRjNxK1F5VlNsTVJ6?=
 =?utf-8?B?dnBwSHhCWmE1UzNWdVhwdDFTVmM2N0FJOC9sMFdLNXpSWXhQZEtnaUx1R3BC?=
 =?utf-8?B?UjdhelA2U0pmdDI3b3BiZ0Y1cGpyK1ZsSk1XaXRSTkhSSHVPNnFaZFg2cEZD?=
 =?utf-8?B?RVh0Q1JEV3FTWitVNmNHQnd5UlZLMmNHVGw1WTE2UFFmWGNTU05tUGNMRGRo?=
 =?utf-8?B?ZjZtUFBpNHZ6VWpGUGF6R24rMENEWVZ5UWxxZUtCSnE1TUwyNTdhY0xBZXRU?=
 =?utf-8?B?bHVndUtaYlN2OER1NzJORDd2UkVZVGE4U3cwM1ZWVWF2ZmlxTEVZc2xsd3dH?=
 =?utf-8?B?aFVNVlpLb1M3YlBXdy9ZbEg1V0RYRWpTNlpwMU1jdXZmRlFTdkpnMEdibGFz?=
 =?utf-8?B?UHo0V2JnVTQxK3I4L3lPdkZmTTZnUzgwdGhSNy9OYTlxZFlMMFEvb2lrK0dW?=
 =?utf-8?B?TS9TWEUzUFp1NXFiQWlJNFUwQlRpM2NQZGRlSldpbW5TZU5kVFlmU1ljQysx?=
 =?utf-8?B?YUlDVlVPZG1Ydk5WTzZkaytZSHF4ZlhTV2NOcFlHbEZIRTVyRUowYkYza1J6?=
 =?utf-8?B?ZUtaNmJXQXhHU3IzQnMzMm1qbkFyNytzVjhKOGNyMytHMGhaQ3lKaWdDSzRJ?=
 =?utf-8?B?YXpqeGZxbnl4ZE1WYVFMVk5DMzRWa1dUSElLZURnUmthZmNNUzVnRWFIQWxT?=
 =?utf-8?Q?9811D3ud/Uk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXlXR3pFQ0R4dU9YbVhLV3VvRVZsWTE3dzltdllDYnZOdWN3S2t2b3VBbVZ6?=
 =?utf-8?B?Yjh3eHo1a2FpaklNQzVncjVXQVBNY2hGZnZ0WUhlcXJZTzdXR2ppZFpCTENU?=
 =?utf-8?B?MUhzekZ4VW1vYmY2RzRibGFSTDdGRlJMdGJIOGlQRHRmMUloejE3K1ZvTzBt?=
 =?utf-8?B?UWhkR0xWYVdmamFVNEJHSnJ5SlBSbTZFUHR2YThNdTZHeUwxTDc1U1ZtbWZZ?=
 =?utf-8?B?dHY1SDVKNDYxNUoxd1RDc2lBQmI4elV6NjhWQnNJUnpMY0tHQmZnblJKbVNn?=
 =?utf-8?B?cjBIQVBPazJuRDdoYlpWTXVmb1FoYmtBd1ZmTC8vWnFoNnhDbmJac3dQVkZs?=
 =?utf-8?B?N1c3RmhUYlY5WlhMQjE0czI4RGVjRVpSUHFwNUllMDJSUUFEL1NWWlJaK0I2?=
 =?utf-8?B?L0ZvSDltdlNBUW9JR1BzczFTeEpYY3hhNlk2eDhsRTlPdDFrTXlBWFdodktK?=
 =?utf-8?B?ZUk0Z1dCWE45TVBKR0ZPVGx0V2ZMQ1VpNzBjaHFMMnJVY1dZTkRkNWIrN0d3?=
 =?utf-8?B?Y0d1RVFocWF4bEUrRjZpMFN6OVFEVjFFd3l6V2kwd0RYVWtaYS9KWkZpaXNM?=
 =?utf-8?B?MXIrTzF4ZGZCM2ZRZmQzSk9EYnc3cHI4dDJ5cVdNaHZOVEtQTS9USEVMcEJ3?=
 =?utf-8?B?U0pVTGFZMSsydDRxNDBxcVVxamVkNjBmMXQvRWdwS1RDTDhTY0MrOVJsV3Rs?=
 =?utf-8?B?UlZWTno0K0s2VHQ1eHlMbmZxZmZKSDJXOXBMVXZMa3ltcEJBWElFdnljcm91?=
 =?utf-8?B?eXMra1RVbHhRYTVBaVhaejRzL0NUZ1FhZTVGMUFUcVNVTkQycHVDQ3VnNTJM?=
 =?utf-8?B?VVkxNTRtY3RmRXR0Tkg3c2phd3dmOEd4MU8zcmlJM2psU2NDazNDTklTbXlu?=
 =?utf-8?B?RWtXSVU5a0tIcGpmQ01zd1B6MGROKzJGWUt0YVpEOW80VTdDQ1NCUTh3ZW1I?=
 =?utf-8?B?Tlg4R3J4K2Z0SUdXTXpRdkpHZEc4eE40d1NPR0dNSStUVzhxcUZRYmp5Zkxp?=
 =?utf-8?B?Qlo0dkVYUDk1Z1A3cmFtRXBYM3RFU2xSNllhemwxcjdXRzFmcjY2akxEUS9Z?=
 =?utf-8?B?ZlYvU01DbDAvWWFWMlBMYi9zQ3paRTY1bWdVVExxTHZnZHpTSnBVWmF5TU5i?=
 =?utf-8?B?aXdITUFMVm43dFhCYWJKalFVbmYzV29ocklZUkI0QmxteXNrOERuWmpzSzFk?=
 =?utf-8?B?RUdvMDFtRzVCQitiVTlaZ2YrSWp1MzZCVEZWdWVTalVGNDBvUWh1L0RzVkFh?=
 =?utf-8?B?THR1NHU1NHBpZFI4WHkwSFNqWDRsTTNia2tVVHVFc011bVBNU2ZXTCtaeDF6?=
 =?utf-8?B?Y1MzKzdIME1LS3pScE5meDhVNEFVRjMvbDQ2VXJYTGE3OTNSYkxRSkRNdkJQ?=
 =?utf-8?B?S1VUSDZTYW5EL2pOQmtwejR3RFlDbklVRGdidWdUa2Y4d2tteTNrZ3Jwejky?=
 =?utf-8?B?d3ZHOEhEZ1UzNXhFKyswV2ppck9TNmtDNkhHdCtXWGsxUEVoMGw4LzA2c1Br?=
 =?utf-8?B?cU9NM2dQOVVlZldQZ3pCN3c1elM0OHdqRFpwdktzbXprVzJzZHVXWmlOU1BJ?=
 =?utf-8?B?aFV6Y2Rkbk9ZQk1sOHhHenN0VzNabHRHUmc3V2U5S09qa043Wm1nK0tGTi94?=
 =?utf-8?B?bXQzcEVrTmJ2MXZmdHRLRGdDajBxRlVBUEhudFh6bkpYZkJPaEdVV1l0K2Jt?=
 =?utf-8?B?clhGRVgrdGJycVVtWlZTRWlwNEpXWHNKYzgweVJ2TVNOeFNaRDBCcU0yMmEw?=
 =?utf-8?B?NzhOV2xnZVgxekRpckVKdVJiOHRUTFBheFdGd2JTdktFYWVpYlRscFk1enRu?=
 =?utf-8?B?TzNCakxzYXF3NUF2VWw2SFlORzdCR0JmUFZnNDFLVVJkbWdoZ0tDY0RZK3dY?=
 =?utf-8?B?UU85NzlqaStmdDFoblZqaWltWURnRE44RkR3ZlEycG9OKytGc0RMWlFVYjVK?=
 =?utf-8?B?cFYvZVFaVjJZbEZqMFc2NkdicFNkUFlOYk5ta2x3MkVlOUZsMEt4c3habEkz?=
 =?utf-8?B?SGwwMkpiWU0vWWU4QzJtM2EyUVNUbGNSSHFrNDUvZVVQbFd3U25vaHhnaUxr?=
 =?utf-8?B?KzVnOTBoYVV4cHY4VjQrQWtsd0pCbVFScXpyYmFGWFg4TTFTMUNFcE1RczdJ?=
 =?utf-8?Q?a1kIMAEzP1YFE1y+LnA9ylJHU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da6db2d-c16d-4c74-ad9c-08ddc368639e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:25:27.4611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3lridIPFLyhSiM6eLRvzKQbkYEg2UQ0m4tav8NGdttZnaWYU6YCbns4HhNbWvKz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608
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



On 7/15/2025 12:50 AM, Mario Limonciello wrote:
> Some of the IOCTL messages can be called for different GPUs and it might
> not be obvious which one called them from a problem.  Using the drm_*()
> macros the correct device will be shown in the messages.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 9ea0d9b71f48..245c2696abc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -395,7 +395,7 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
>  			   chunk_ib->ib_bytes : 0,
>  			   AMDGPU_IB_POOL_DELAYED, ib);
>  	if (r) {
> -		DRM_ERROR("Failed to get ib !\n");
> +		drm_err(&p->adev->ddev, "Failed to get ib !\n");

For consistency, you may use adev_to_drm()

Thanks,
Lijo

>  		return r;
>  	}
>  
> @@ -467,7 +467,7 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
>  
>  	r = drm_syncobj_find_fence(p->filp, handle, point, flags, &fence);
>  	if (r) {
> -		DRM_ERROR("syncobj %u failed to find fence @ %llu (%d)!\n",
> +		drm_err(&p->adev->ddev, "syncobj %u failed to find fence @ %llu (%d)!\n",
>  			  handle, point, r);
>  		return r;
>  	}
> @@ -901,7 +901,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  					 sizeof(struct page *),
>  					 GFP_KERNEL);
>  		if (!e->user_pages) {
> -			DRM_ERROR("kvmalloc_array failure\n");
> +			drm_err(&p->adev->ddev, "kvmalloc_array failure\n");
>  			r = -ENOMEM;
>  			goto out_free_user_pages;
>  		}
> @@ -982,7 +982,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  	r = amdgpu_vm_validate(p->adev, &fpriv->vm, NULL,
>  			       amdgpu_cs_bo_validate, p);
>  	if (r) {
> -		DRM_ERROR("amdgpu_vm_validate() failed.\n");
> +		drm_err(&p->adev->ddev, "amdgpu_vm_validate() failed.\n");
>  		goto out_free_user_pages;
>  	}
>  
> @@ -1060,13 +1060,13 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
>  		va_start = ib->gpu_addr & AMDGPU_GMC_HOLE_MASK;
>  		r = amdgpu_cs_find_mapping(p, va_start, &aobj, &m);
>  		if (r) {
> -			DRM_ERROR("IB va_start is invalid\n");
> +			drm_err(&p->adev->ddev, "IB va_start is invalid\n");
>  			return r;
>  		}
>  
>  		if ((va_start + ib->length_dw * 4) >
>  		    (m->last + 1) * AMDGPU_GPU_PAGE_SIZE) {
> -			DRM_ERROR("IB va_start+ib_bytes is invalid\n");
> +			drm_err(&p->adev->ddev, "IB va_start+ib_bytes is invalid\n");
>  			return -EINVAL;
>  		}
>  
> @@ -1234,7 +1234,7 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
>  	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_leader_idx]);
>  	if (r) {
>  		if (r != -ERESTARTSYS)
> -			DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
> +			drm_err(&p->adev->ddev, "amdgpu_ctx_wait_prev_fence failed.\n");
>  		return r;
>  	}
>  
> @@ -1447,7 +1447,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  
>  	r = amdgpu_cs_parser_init(&parser, adev, filp, data);
>  	if (r) {
> -		DRM_ERROR_RATELIMITED("Failed to initialize parser %d!\n", r);
> +		drm_err_ratelimited(dev, "Failed to initialize parser %d!\n", r);
>  		return r;
>  	}
>  
> @@ -1462,9 +1462,9 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  	r = amdgpu_cs_parser_bos(&parser, data);
>  	if (r) {
>  		if (r == -ENOMEM)
> -			DRM_ERROR("Not enough memory for command submission!\n");
> +			drm_err(dev, "Not enough memory for command submission!\n");
>  		else if (r != -ERESTARTSYS && r != -EAGAIN)
> -			DRM_DEBUG("Failed to process the buffer list %d!\n", r);
> +			drm_dbg(dev, "Failed to process the buffer list %d!\n", r);
>  		goto error_fini;
>  	}
>  

