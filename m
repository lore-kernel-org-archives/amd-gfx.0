Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02C4C3ABBC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 02:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C6E10E008;
	Wed,  7 May 2025 02:16:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LHFwwGEi";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 929AA10E008
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 02:16:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8EDH9YcjNRxcGwbcX62uYvAIaH7Y9kM8rSSl1A20bV3kFQkEOOlkHLfafV8ZC6xm7MszY+a7Ro6azyHtbbO/ou4nfVkXjG5FV9UVKXc8R2DdO9j2uVNGtb/+Cjo9Y4BaRAzVkmMuoggm7qMnKtxY6Bl2izyjnRQvswO6AnXbbTpygyOM2thm3tcAvHsDCq9U/RjHpI+feH4w6xPOSelv4ni2XlSLRZEjoBdphtwZInSXjc9fqF8Xm8Bl1NScDmX1NBW5PExYnSOm63INdAb8Dj49g7+eIf/eEA9Ea2dPIUFAPNhWG5mPJ/cVYVcHARuY/Udh8lw5ll3RuLUEJa9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlCQ0pc8KKJmTVthDP/rAeg6aimsQWtY7fVC4pQsSH4=;
 b=fTimIH23IyZPrTArlfvvvANJbx/2w28C6w+Zq1ovMIoByuc5q5KsVY6sSm85fCToHmEeXOJ4As4TrWkek9Uba8e1HtRkSyGrYkNCmxba/0McRyme7lQ796mCESg1wcGWT+YELle/bk+Y6uFhwdC7N2EuzilYeZCaJOB7ABjw9XpQN5I8RYJyvqs3tzv62wET+sI6cALSabcCIt/9Suc1yxtUTA4DJ7rBI1JidEjwAQrrTLjTOYCxV6GV437PvqORMMH86s+MIkUv4h7oB6wvUJHPOOC4sEa0Ef2I5LdVi79BuxKwGQXcAWOcsM3X26Q3oX4Uub58scgAscF8o1f50A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlCQ0pc8KKJmTVthDP/rAeg6aimsQWtY7fVC4pQsSH4=;
 b=LHFwwGEiE6rvOp8Gd2hh0oNxxPVvB/s+LkNVcgG8M4+6cwNVJz1+nwIdiKa+x6STi4K0hh0nAZ0XEub8uOrrU9NyF7So3+zDx1KFBo5gPav4W+Ee8YqGgP47m0/ADSJfO6b0MW5QXTuSvXmcbDekdMWoIO8V7gWgKrm0NvwtAHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ5PPF6785369A4.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::997) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Wed, 7 May
 2025 02:15:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 02:15:50 +0000
Message-ID: <847fbf6f-8f0f-43ff-800c-11688d43dbda@amd.com>
Date: Tue, 6 May 2025 21:15:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Modify the count method of defer error
To: Ce Sun <cesun102@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com
References: <20250506123048.365612-1-cesun102@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250506123048.365612-1-cesun102@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0013.prod.exchangelabs.com (2603:10b6:805:b6::26)
 To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ5PPF6785369A4:EE_
X-MS-Office365-Filtering-Correlation-Id: 20965b55-110a-42c8-c449-08dd8d0d15fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3hDRDVaTUJaWVBxQkZuZzRCdDIrckZ4K0VvZ2xJSkE3QmtBM0Y0ZXhVUlpL?=
 =?utf-8?B?d3dqZFMxYk0zR0ZBMkowaDlaako4Qk80MFFwM1pCSDdvMCs3MXZ4R2luaFFm?=
 =?utf-8?B?bHM5YU5Ca2JmUlV0WVRkOEsrVE5FRzg4bmZ0QjhlN0dWZXNsWENsdUV5UnR4?=
 =?utf-8?B?M01aU2VOdHhPNC9MUDhQbldFa1FYUmlXWDYyVkxheDlvbmNVR2o1S3RBclBq?=
 =?utf-8?B?ZGowSFRienVkeExvWjNaek1nNVV5T1RGYmYydjhmMkx5dzByMTBFZHhScm9Y?=
 =?utf-8?B?YVVCVWxZQlRBOEd4d3BKSElndzVMR0xYWTdzU2FITjBWU2s1WURmeEM1Qmx0?=
 =?utf-8?B?WElnWjMxYmc1cVlKM3MwbjVlVnVFQlNmMDVqcUZpQnhuZGdsUmp1NWRvR05o?=
 =?utf-8?B?Sy9DUG5TZlpVL3NsRTE4bERwSDRWbDdyeXFkMTJRd3FtZDhhUFpGOXI5ZmR0?=
 =?utf-8?B?bjYzeWpnOW9KM042V1NqdmovdVBSNUIwYkNWeEYvQzd3NVVCblIvUWFFNUtR?=
 =?utf-8?B?REVLeWF1SHY1VHVVMDFQcHlscS9XRTRmQ0xHcTlGTlhUSm80d0lSdkovN1lC?=
 =?utf-8?B?ejlHK20vV243VkJjSFh5STZZSG1qWUlWWkJiN3AybTU3akp5V3BPSGJieUVq?=
 =?utf-8?B?Skg0QnJkZEZIZmZPYUNpRWkyWWRGM25EUU9GN1N6SmZrakl3Y25GQWQxUHJM?=
 =?utf-8?B?MUlBVEZReUErTE83aVlEK1gvK0Vib21RMU90UGJ5ZXVHaHlwU1hLdkx6MVVN?=
 =?utf-8?B?V0VNZVhENnExRzdzbkFESEczc3BFSUN4WDVwNlVlM2hubGdUNjRlQ2FQdkFU?=
 =?utf-8?B?ZGZaRUYrTGtjUWVNRHRZODZNamU0RngxdWtlTXRQc1VYeStkbVc3S0RzbFd0?=
 =?utf-8?B?WElIQ2Y1UVdPSFM3a1g0MHRaSG5hT29mT0JwZlM0NWdFSmdEMS9jUzRUcE5x?=
 =?utf-8?B?VHFteVZwYlpscEwzeUhkV3hBYjM1T2NFbmc5NnFER2NCTTA1NmlLa0xOTDZh?=
 =?utf-8?B?cnN2TWZLZmZ1ZkZQejhsMkRpV2FyMmdSL0pRTklKbXdCUWNrdjVCemdQWGNX?=
 =?utf-8?B?VnpFT1RMRW91YVBJRGNWdVc4UWw5SzErc3VEbWg1VzgrUHc1QzRDVVFQNVJm?=
 =?utf-8?B?VGZteWJCUTYyZ2RyZlVlLzhHWGJGN0pmdWg2S1dhc2F0M2JqeUNzbndEc1M4?=
 =?utf-8?B?RkFWZ1RVbVEzRkVHY3o4eFhvTDArRzZvdGNzMGdqMHhCT3RFY09MN3crc0J0?=
 =?utf-8?B?WTRnK2pXUHlBSFpDWmdRYklTZzhkNTBnWDhFajFqdmpSZ3hOVmxrOHZuZjdY?=
 =?utf-8?B?RHhONFBNcmUrZjlaVXYzRGE0dXlNN1I0R3VZY3hxeTlYNGFYN3dVY2k0cWNK?=
 =?utf-8?B?WUN6T0YxVitRT2ltT2RoelN6RG8rbnJaODhoTFN2ZlR3cFhUOW9YS1VVbVVm?=
 =?utf-8?B?ZXh2MlZIekx6K1kvTW1MaHRxRUcwVEtTKzdwZWQ1ZzBzYlphVDZ1dnlQT0to?=
 =?utf-8?B?aVhnMlFUakVpelg4N3lEa1h4THNZb0tLRjZIaFZiYnlYZldmakZrZ2w1WVdu?=
 =?utf-8?B?U01xdU82Tm1oNUYrdWwxRklTR0hPVk5odXB6WHpNSkxjU0NVWXZReUJJTVox?=
 =?utf-8?B?N3NZQkRUQjRSQUp3dXZEVlZOQUtVQUI5TGFvbkVmZzdZdUFkcmFBd2ZESU5B?=
 =?utf-8?B?ZmtWcDdNU0lzZldtckQ4cUM2dlZJWWRUbWI3a2dmRUp5d1lSdnNRbVp4em1N?=
 =?utf-8?B?TC94UTdLM2pxdDRXRkdaU2RJRmlNUHM2d0ptRUNBeVgyUkNLUkoxRzllTUE5?=
 =?utf-8?B?bkRXL0srODU0R2JPTVdldmNtY0Vpd0pxTWYyby9UYktsdHMyL3R4M1VVQURa?=
 =?utf-8?Q?fKwxvUGgYO/wM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0c4MXdtNko3M3YyUnBFS2VCV0xXVVZIS2I1TTJMaWNSL292WDNvMUJkc0Zk?=
 =?utf-8?B?RnFwUktHanlPTEpvaERyeFkxOFJPUVZORFZ3bUdQUVpYQ2FKTTZ6bThHdTlF?=
 =?utf-8?B?bXdEVlF4RjF1bmFiakdzb01CdnNXd0xCREVMTk9pRWdHVDhWV3A3YWdIeEtz?=
 =?utf-8?B?T3BPaHlCcDdHbFhLTXYvbW1MNGpiTDRoMmxSdXlFQ3V3dG1lM0VUQStiYUZk?=
 =?utf-8?B?WlR6TEhjQjA0TFRVTlhsM0QxSkxTSnZwK0ozYTFCQ3F4ZUlqSDVUdkgwMWtQ?=
 =?utf-8?B?NzViTXA4cEZYOEVtWjFrR016c1dSUVBhanJRbkMxZW1ScmpGVmFlWDROSnlU?=
 =?utf-8?B?cUM3SFFKdS9BenZTbEdGc2hoclI1eVRkLzVsMnRJQ29saFJYZzVSR0NSblVv?=
 =?utf-8?B?N3Q3SE54UTJKU2FXRmNoZThtQTVpKzdYT0t6eHF0RnJUVzZmNHFjZHpIdW8v?=
 =?utf-8?B?WFZqWEF2aUxXeEVXRjhWZ3dTamhWUjBpVHM0YTNLamNpYWNILzR4RFB6S1Jk?=
 =?utf-8?B?R0I2NncwMy9LMGE4cGplNUY3RHdIQVRsektzWjFONGxRdVJZYjlqQ0lNcTNG?=
 =?utf-8?B?eVZNOEFNaUxFY3JPRWQydklXNDRBcy8wTE1Vejh2bG44WUpKMjVQNGoxMVBP?=
 =?utf-8?B?K1ZTTk9ZamEyT0NsSXlSR3Z2UWlHTXVXQ3B2OGJXdDVXNEVPaFZWcnhRZEZQ?=
 =?utf-8?B?RU14ajZ6RWhKTkZnUVRKR3F6RDBabFNuOXhjSGJSSXVpZ2FPWi9EVFgvZnY0?=
 =?utf-8?B?Z28zcUJRZ0p5RjZOb3kxUm1yQXBNbm5DQms4SUpLc0RXN2VDZ01tc0xoQmNT?=
 =?utf-8?B?bzMvNnpiR1B0U0hWeEdFRzdLalc0bW9kbWIxckhhUjJ4b2xkNVJuY0hCd3NU?=
 =?utf-8?B?a2M2bERjMFFSelJPUnl1aGpERFdIWnMwRHQ3Mi9zaUFBMGRyMFpPemdQS2N5?=
 =?utf-8?B?Q0c4ZHJLSzR6K0RrVUE2SUJSYldvK3JVaWNweEtpSWxuZjhFSHRQdlgvSUVX?=
 =?utf-8?B?QnIwOFpYS2pPZXByM1VGWmlrQ0dkNExVVlF5NTVqcmlKYVRSUjQxR05qQnI5?=
 =?utf-8?B?SmdNaFZNWWJublVuZzUzanRJeTQ0bWZMS3hOUmdpYlk3VVdnZjd6TmJpVHdM?=
 =?utf-8?B?VGJNcTQvSFpjT1N0Y0drcUM4akp4OWwxbzdUQUlBbnFoV3NzcHkwczQrVDJp?=
 =?utf-8?B?cHFpWEEyTWJCZjdLV3VoMTBPZy8wQWlIcW9nUUswN29YUSt2WTE3c0YwVDBy?=
 =?utf-8?B?bmdFVEVYMGl6Yi9qd3dzVDRDUHo4a1htMWpSVTR4WGdJYzZOUkg0WG5aRlRn?=
 =?utf-8?B?R0cyVnNVL0NkZndYZXMvTy9pZnNEUmk2ZFR2OElNZnVmZjRXS2dObzNyQ1F5?=
 =?utf-8?B?SUpKU1QrNUZOc0U1M004WW52M09TQlNhNUZlRklTRWM4Tk93Mk8yUEpVdUwr?=
 =?utf-8?B?MHlGZ1VLM0lYQVFESmd6L0VOWm1lbDc3TGk3UWRwdUZZRjVZTFZmcDlhR3RP?=
 =?utf-8?B?bjlvMnd5OHJ0T1k1aUk2aU5NVlk4dnBEY20zUWl6MWd0QTUxTFlCYXkvU2g1?=
 =?utf-8?B?cmIxVm5HbWJ0TjIyM2w5LzMzS2wzWVo4eEZ0LzFCK3Q1VTVibmkzc01JcGZW?=
 =?utf-8?B?aGtzaFg2d25MNW1LOWY5VjlGWXEwVllVNUJlOXE0TmFDLy9aSU4xdzFwYUtN?=
 =?utf-8?B?QTNZNDhvK2pPdVBOdzk2dVhxMXR2SHZSeU92RlBpSmZiOUJKWG1tRm5PSVZL?=
 =?utf-8?B?VjBWbHlUblhIVDl2SkxUUGgzdEYrRkIvRTJkckI0MytZeWdpYUIwMTZCZkV5?=
 =?utf-8?B?SW0zZmNGMUhDVDJCTTkralU3TThGTmZPNjJuUHVvT0NHNDBLZmhieDdkVzYw?=
 =?utf-8?B?Vk5sVDVRcU1qdUFxUDk1UXhZazhSbGdrNzhuZ01sUkQ2UUQzRmVubDVnQ0tQ?=
 =?utf-8?B?b1pUVlAycGYyazhSUVF5dVdDNGs4TFZGZzNxUUFGTUt1bUVqK2dFRTdpNnEz?=
 =?utf-8?B?NUU2THBoQUlsWHU3Zyt3SG90L1QyNnNnWk5EdS85SmZ2NzIrQWZMZGtxek9U?=
 =?utf-8?B?SW04TnBkcmpEcHhzdFYxSVBHdEI1eFRycG94NHpFTTRsVzRCajRPM1VjUExP?=
 =?utf-8?Q?Az7+X0Fb/R9jYfV6bhkNEMHdT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20965b55-110a-42c8-c449-08dd8d0d15fe
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:15:50.1284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ReW7IDMyCCYDnTmdpiq2T3gt26yxBvgiQ10nLgLpzSvwtMUEX6cPWlPIhO1wc+wOA+g9gyW5JAShuv+TGI9pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6785369A4
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

On 5/6/2025 7:30 AM, Ce Sun wrote:
> The number of newly added de counts and the number of
> newly added error addresses remain consistent

You need to make sure you include a Signed-off-by: tag when you submit 
patches.

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 11 +++++++++--
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> index 857693bcd8d4..52fb71c4ce9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> @@ -130,6 +130,7 @@ struct amdgpu_umc {
>   
>   	/* active mask for umc node instance */
>   	unsigned long active_mask;
> +	unsigned long err_addr_cnt;
>   };
>   
>   int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> index 0e404c074975..eb3f99dbbcd7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -262,6 +262,9 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
>   				soc_pa, channel_index, umc_inst);
>   	}
>   
> +	if (err_data)
> +		adev->umc.err_addr_cnt = err_data->err_addr_cnt;
> +
>   out:
>   	return ret;
>   }
> @@ -428,8 +431,12 @@ static int umc_v12_0_aca_bank_parser(struct aca_handle *handle, struct aca_bank
>   		bank->regs[ACA_REG_IDX_ADDR]);
>   
>   	ext_error_code = ACA_REG__STATUS__ERRORCODEEXT(status);
> -	count = ext_error_code == 0 ?
> -		ACA_REG__MISC0__ERRCNT(bank->regs[ACA_REG_IDX_MISC0]) : 1ULL;
> +	if (umc_v12_0_is_deferred_error(adev, status))
> +		count = ext_error_code == 0 ?
> +			adev->umc.err_addr_cnt / adev->umc.retire_unit : 1ULL;
> +	else
> +		count = ext_error_code == 0 ?
> +			ACA_REG__MISC0__ERRCNT(bank->regs[ACA_REG_IDX_MISC0]) : 1ULL;
>   
>   	return aca_error_cache_log_bank_error(handle, &info, err_type, count);
>   }

