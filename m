Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516BBC87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 14:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED3CA10E368;
	Mon,  4 Aug 2025 14:23:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YgR/ryP5";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A2CB10E368
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 14:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PE17g/MWpRrVsqXQiodGZ6p4RvPkDP57RsOi132jUcgNJXBISlJmMUguiw56YjYdtCWXxeGEm8qN5Bp+vJJND765jYwWy3PhWgw1zYf7/kZOiCw/xy9SM4L5muF1KZ2i7wJiq2Y4I73pUXt4eacKqigCl3VXVw73YmZ7bPL6mKdNhDOjs2AuvV+05V4WVubs9YsrYAmUlEy7eoLPsihk7EYyNSnIrnSeEtKFnByLGpCjLTJtiQryJ5Ph/y1FIgmh/RtZk4QjkaZPoEQiIvWNuVV4X92pWzybkfhUOnJxExKLh7pOb0IZyTspQvDDUziPid9QGcqXlZbmMI45ogu7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTQaZBkLKI0wlL8Ep7ZObTAS18sYJCSOT4L/BcsgNaI=;
 b=rMVf9FgzJQWsDoxm2Ag1OMomCGEWtw+EuI3dzDHaYS2mJ7LyJ9hXU25MTH6sgi90g889ql7ne4ivqzHfDi2EmQ50OVE0AfU7N9bOvbjXP0xMsYnJyz/J3gu5UoNNRs6iOqMsxJs+fdGEuN+fljIVEHEWH6eGh1NuJYBj0vGXXs75xcUcAvPu0jZx7d9VwcOxRl1pqYygGx5eI76b4Xz0R53Uq9aATMQMdWL1bnHcPUYM1gumc1sZLZFNsREoCOb354G4OHJlONDserhIUk+DVgY3ZEvLrvzIFn2iOuHuKx2GWYbTnCyX+Im4i27/yo1Q2UXEYDuahdNXBNh7XRz/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTQaZBkLKI0wlL8Ep7ZObTAS18sYJCSOT4L/BcsgNaI=;
 b=YgR/ryP5+p4VUAPlmg5+cXI8Oib7LyPI5vrqaiLhZfJIFEc+DXLYm4GrhJRuo5XNkSKHN5D+FRk41ZXeiZh72Ji/8nWUzAXYo0id8mPR3q4VEifludxxjTAMJ2vDjNwjnay1tWkDsVpZU5ybzmo7fZR/4zswzmTCnQOgL4uaN7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 14:23:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 14:23:04 +0000
Message-ID: <c2e819e1-c8cb-42b5-85e1-bebb55c22490@amd.com>
Date: Mon, 4 Aug 2025 16:23:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: keep job->vm in amdgpu_job_prepare_job
To: YuanShang <YuanShang.Mao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250723090624.53536-1-YuanShang.Mao@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250723090624.53536-1-YuanShang.Mao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0005.prod.exchangelabs.com (2603:10b6:208:10c::18)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a36412f-5193-44fa-3f5b-08ddd3626c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUxpVnRYVGdiczh4ek02NFpTQkZPOC9ybWVEWi9OdU9XNlNUbXU1MFl1MEhG?=
 =?utf-8?B?N2Z2dVdXM1d5YmtsY3plUnBEbVdoMit1MTVzZDcxaW5FZ21NenVpc1NkSmNt?=
 =?utf-8?B?N2Q2Tk9qUzRxWWg0b0JlMmpQZTN6WlVOayswYVdaakJXR29UZ2F0a0o2Rkxz?=
 =?utf-8?B?b3JWb3NSbDlrOHJiZ0dUdHdyQWZCK2tVZGZUcFBFK1JyYy9IdmJTeTZhMytE?=
 =?utf-8?B?RFdhR0tubjhjNGlXQ0xUakpEa3ZGY2NQOWk3b0M0cHhqbWNTVjU5N1N0NnVF?=
 =?utf-8?B?VC9WZE56UEo0K1RmZmpzeHZEblNSTlFzVS9zL3U4V0tiUnNTMHk1eWp2b1Jj?=
 =?utf-8?B?ZHdyUzFuVWM0VU8xTGJRaElDcmNBYm1JVVdSUmJ6UmlYZTNuYldTMDJxZS9S?=
 =?utf-8?B?azJOY0pDRjNsV0NNWUI1eGpkcWw3aDF4TkJlV2ZmWUUrNStROURNRVhweVpk?=
 =?utf-8?B?MFpvbFFaWWRrSzhKK3lYT2pvTnkvcGlwVkpXRUV3bUYza29IUG5vQytYY2xR?=
 =?utf-8?B?L0dKNFhGNmhDMlA3SWhXYUxuZzVUVEJZZFk5ZVNLMEhza2gwZ2RKZitJOUJh?=
 =?utf-8?B?dG81Sm5rMFJHN2gzcmFCVklNcEVQM1c4S2k5RFZDYWl1N0d4OU0wQ0lFOWxm?=
 =?utf-8?B?WGQvSExoMklibHllcGR2TnlHUWE3bFpZcHRCQVRObEhKZ2JRak00RzFNL0pZ?=
 =?utf-8?B?T1VrcDcwTm1PUXViWDBtSFd5dENWRU56SHdsZXkxZWhCUG8zcVdVR0JtK1RP?=
 =?utf-8?B?dGE5MjRQM3g0ejlGaDNJSmp1cnE0TmtIeENWTktwYXRramsxWG5mOHJTN2xK?=
 =?utf-8?B?dllsbGhVeGRpV3hRTVV2TFhBa0Z1dU1NSEZUd20xd0x1VU80Z2JuUnJBMVVp?=
 =?utf-8?B?QnRheTBRRHd0c3Yrc1lOc053N2NpR01OTlJha3RHTTVJNHFFaWs3Q0JqNlI2?=
 =?utf-8?B?b1lJd05YNkVsWDlkRStycXl1aUpzNi9tRGFTM3lKbFdFOEZrWGZwNHJaMUlW?=
 =?utf-8?B?TGVIZDNKbEp5eEhuaHd3OE9KMk42QzZ5TTFzZjNiVm8vczRaMkQwTWgrZWtC?=
 =?utf-8?B?MWhOdU9vY0diTFlXYXlLYlRacGh4aUx4TDBFMlVBaTRFMmJucXRFOTF6YVpa?=
 =?utf-8?B?dG96dkdEYlYzckMyQ2t2c0FPVGQ2VTB0akU3WVJRbWJvTGRKUlZaNDcwUnp4?=
 =?utf-8?B?Z21YU2NHNWwwMTMyVStDS3hsSlYzUFYwaWZjQ2dLcExJZUsyZzdsaWw3MDNZ?=
 =?utf-8?B?eWNZa1dQcTdyekRXT0JYSlVxM1hxMlhybFFTNTB3UWQ3VmtDd2JUVmkrdjNL?=
 =?utf-8?B?THkrZnNjY0ZmbXV3cWVnT3BuK0NOV3pjZWRaWlZrMUlpWTdvNWpGeFNUQXY5?=
 =?utf-8?B?dnZlTGFiTHF1YmtLM1BBVXJpRmFFVEVSaW4vd0s2OXlwaHdjZFVHVkU1MElZ?=
 =?utf-8?B?MWFPbUt0VWFhS3MvL1hpUjY5Y201d2x3NzhxVXMrdGZXUDd0aWk3cGxaTzlv?=
 =?utf-8?B?RWxsbldjR0N6VERYbTAzUjF6d29aVUx5S0NoVU9CUGR3QTlmNUZ1ZXlEWUtl?=
 =?utf-8?B?eEQvdVo5TmpiZTV2QWRHb01hMFJIa3RvM0J6K0huM2JNaDZ0V1Zkd3dTcm9h?=
 =?utf-8?B?WEtKRXFyWEtST0g2bU1jMnh2WWJ2MjlMUFdHMkR2eG1tUVJmOThybUxBTFhn?=
 =?utf-8?B?T0xVYnB5Q2t3K1N3NFB2blFFdFpkRHB6OTlzY1dPNTBSVHdWY05ZQmhMMzFD?=
 =?utf-8?B?aGRQZzRlTjlaWkdRVVY2QUkrT0xuN1RFTGFybHlKaUNwNXVVSVNUZlYwVFBz?=
 =?utf-8?B?SzIzNTBkSXNMTG4zbnV2MHliV3F0dVZOYlpmMXp3TEllQzFtZXRzRVJCaHdw?=
 =?utf-8?B?Q1VaLy91WXJTTld5a0lZTjAzOTFlRUpKUEZTbG5VNDh2K0FVYkJDU3NmZGpF?=
 =?utf-8?Q?oBR9igEd/J0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UURSUnNESTV1RWlPZkFLc0s4WmwzTFd0eUlyS1U2bW1sbzExakRoUFQ5M0VM?=
 =?utf-8?B?MDhOTUxkUTUrUnVNTFlUaDJjSGZFUTROWWxTNVN6S0pqSTduUFdUL0w1Wm5P?=
 =?utf-8?B?VXJmbDA0R3lHdDBIME1YZFRuRjBFWkd6dllGT1llNjF4UFZqSEkzSlI3MTdE?=
 =?utf-8?B?TXpIdEJJRnQ0cHJETVNsSEw3akZJS1dIMFpBN2trNWpVOUJjOHJPangya2l2?=
 =?utf-8?B?Um9kTWVHTzFDNWdIdENPcXRyRkh2dWFGL0RVbWNhNmFxV1I0eWptME5HVTJh?=
 =?utf-8?B?YjdMZE1QUU8zdTRDbjlaNVdEU1NzQzVlVXdKeHduenBSMG4wZGlhd2trMWEz?=
 =?utf-8?B?Q2ZJYzBhM0NQcVY4K2lGZDhyY001OEZhKzQ3RlQ1NmF1MEFHQ3dIanlsREZL?=
 =?utf-8?B?U0ZFQVJOekJMdE5PNEpUTE1yS2hIbGhsUElJM3JiM0wrU2M0VHl3bSsvYzZZ?=
 =?utf-8?B?SkZicXFTTnlXWkxRRk10TThGVW03bHMvelgrRHI0ZmJmdW1Db29aNnZSU3U0?=
 =?utf-8?B?aGlKRzZMdVBuK1pMSWZWcUE1aW1ZemtweHkvREcrVG84SXREd2d1UWdSZC9o?=
 =?utf-8?B?SFFPMU04QjRZMVNUd0VmV2wzVWw3cWV6ZWtGMTZDUDRUOXJMdi84Q3ZWYnNL?=
 =?utf-8?B?ZGk2WWtFUlZiN0I0dlorUUJDVXpURnB2SytMbmUzRytoQUh3MHpsaUw1cUNP?=
 =?utf-8?B?ZERQM2E4K2ZIejV4T3JBUmI4SDZYdU1mbnFHL2s2S1VaUmpIMnVOUGNwaC9n?=
 =?utf-8?B?bDU3S1pyeHdqMVd1S01CdEM4enhvbjcwZnR6NUF3am9hN0RnNWo5c1V2VU12?=
 =?utf-8?B?VTRqYk9PLzlaUGtEWDFOL0pXemRidmNOTU41VGlTcVgreU10UFh0dWJFVTJJ?=
 =?utf-8?B?SUpCKzFncjRmV1JuU0d3eCtESVBmTDVXdUJvS1JVTW5sUG82T1BUUkdYVHIy?=
 =?utf-8?B?Z0lpWEpBRUxzaGJnQmw2Ti9qNEwyWEs4M2w4K25WZ25Jb1c2c21IRmYva3F2?=
 =?utf-8?B?WXpoakJrRmJkOUhkMWFrVHI4Wm1aWDBycXdIaEVTb0I2MFhBSWlyOVUrWG5y?=
 =?utf-8?B?aFMvNWZwMDBVaTZWNXFqcE1yRHNTVUFzVVhMOGdxeUVCOXJhcXBIQUdiLy9H?=
 =?utf-8?B?bzVidWhjT0p5WHF1UE1EZFg3QnlEYkRmZ3VKZGVFNVVwdXJmVGE5cTFpdFYy?=
 =?utf-8?B?bXk2dDdmRzlOMlJUeUg2VlNseHZIaVUwTUVjUkVDZGtjRnF3aWRESEFITGt3?=
 =?utf-8?B?MlVjV0FDTmdhQVBKSnRDTEdYSTA2b1hCbE9DVUwzeUoxRVlzL3RuTEhXWUht?=
 =?utf-8?B?dDVSVENPZGwzdDNXbE1heVB1NnVDSW1DMGdMSjJTS0c2cWdhbWVHMXR3RVZR?=
 =?utf-8?B?WkRzUnZqekVWYmNMNGFYWU5lWVdKMGtGT3R3N2NpVkp0RE9IcXdia1lDOVFZ?=
 =?utf-8?B?SSsrRDBxa1RjVkxZM3JrTUliblRhcWJHYWlPbUVKYkI5L3J5TVNGK2dvUU81?=
 =?utf-8?B?K2RhQytXbyt0bjRiVWJGVm9TVU9YaE5pK3M5aWoxR3owZlFtbG5UTUtoVGhD?=
 =?utf-8?B?TnRVRzRqT3lZa3p4Tll1QjdNZytpajFLSVZDL0EzZ2ZVaDV2MzNSbW12UUJT?=
 =?utf-8?B?akZPUSsrVDBlMVpHZHp3d0Q2WTBFcm9LYWFUTkp3YVJ0MlBWblloQVFLNmRD?=
 =?utf-8?B?RFhhOEVIUFdURnBib0xnbVVHUUhSQXBtT0NvVHJTdWJMaDJEdHFGYm1wTzRC?=
 =?utf-8?B?SDlWKzQ4SmZYWWR3UVRUMG5RYlR2cmc3a0JJVndTWFExUHJXS0NMYkc2VEZH?=
 =?utf-8?B?aTgwbWxNWU5zVHN5SG4wMDRZRStzS1RJeGhiN0hkZGJLbzBWdDh6a1c5bTRF?=
 =?utf-8?B?SmM1S1FzVk8zQmlQRThQai90OVAyUk1wZEJGNnFvK0hTS0lFd1ZIcHhoejlm?=
 =?utf-8?B?eHMraXcrK0Q5Wi81YVpyeE5kMy9ObGtBdmJSeXVvYVgxdFNKUXJUbmNTMzNQ?=
 =?utf-8?B?b0xoazBtTGVJSVFldHJBZ3FVdm1qTkEyUTgwQ3VWODNPTWZ3WkIwQ2F0ZHY4?=
 =?utf-8?B?K0dNWW11ejJCeEFkb3lQVTdSQ1Rtc216YXg4Ykt3eE51NmZqbnlDWVpDaW1W?=
 =?utf-8?Q?7RMVZtKUxKAHOKHHfCZxSpCwu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a36412f-5193-44fa-3f5b-08ddd3626c8c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 14:23:04.0131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibf9oeu7Nm4B+nRnqe34qekZJl0axIZMXeRqHmweEC5PmpXcRX5seQXG/beo+9Rq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059
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

On 23.07.25 11:06, YuanShang wrote:
> job->vm is used in function amdgpu_job_run to get the page
> table re-generation counter and decide whether the job should be skipped.

Support for resubmitting jobs was removed, so that code should probably be removed as well.

We should probably move the call to amdgpu_vm_generation() into amdgpu_job_prepare_job() as well.

Regards,
Christian.

> 
> Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 45febdc2f349..18998343815e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -360,13 +360,6 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
>  			dev_err(ring->adev->dev, "Error getting VM ID (%d)\n", r);
>  			goto error;
>  		}
> -		/*
> -		 * The VM structure might be released after the VMID is
> -		 * assigned, we had multiple problems with people trying to use
> -		 * the VM pointer so better set it to NULL.
> -		 */
> -		if (!fence)
> -			job->vm = NULL;
>  		return fence;
>  	}
>  

