Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE9FC83F17
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 22:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E534810E18D;
	Mon, 28 Jul 2025 22:49:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hSzfDSM4";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB2610E18D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 22:49:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSO1okmvn0oB+OmgX/ia4cx0Aywg6gPXd8nXIyuATXZYK+ZCJQUkyJOz+hcsvPSGYUG+0y3UZMP19+xSoJjqd5zxf4+IcPqsxN7yVybPdeXMH/5VXyZZX2DhphZYFGMKAGbtk0Tv+hosvoKYmzVPT/Nag5AoPDe+bEZE/FPXpvVFtoSHWwNFwYwJbP1/lh1U8vsCpSFtOX0qks/nWZKp/i7c1SPsCnpdW5z8hhhOVZt4LK5fAoJK8/Ymv6fxvCZBLAbJTfOpdLt74m7gYy0z8R0+7LJv9TQfyILR0GdIOycVC2MhJk4t8mN8t2DHqYqCXJB3OkFNfPG9qVdb7S7HiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRgwapqVSOQdrrE9gkZ5tuGERu2C3Qgi8Lk3ulkiBj8=;
 b=bPuPkDOB7TdjkyX71LFa4qzcm+5BkdMHMlkmFO4V6eh+WvdiG008c5b9LY+71CBE0GaCSK3kB+7O3qGGE8tTATz0/+F1HVOIp3Pe7h1nObSYj46UziiSBxIbq3sz/dzvc3qPeBC389uO/WBzF6D+AUzpv2p1iGlYbF506FSZ6Io75RScOkhW0s1W6yIoM250FX5NsbKl4VAL6neSac1FhnI48QTyc3xfiDZmn8ncypnoTcDxnjApLQPHhh8jztd7fagQdX4tkj3m2q4Iwrn0J4eEgDiYk6ANxT709FRHQf0gGU52SpSS2Fuh5KkkyyIDrGKrJF1qAOgM53hiDnSKmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRgwapqVSOQdrrE9gkZ5tuGERu2C3Qgi8Lk3ulkiBj8=;
 b=hSzfDSM4I42X/iYnNM/o2WQyU+yPtQGtHvSco2Lb0evDLQbdAH3AQs1I/Q2VtRQ2mJhnyZqGsJ5whbb4jXsP1Zc+p75qdl/NhX30I8nt6TiBMukY5bP9K8zsCPpW5+6j5MZ269vJ9syC2LfjsQn6AV9Fr0QgwpBpOz8T6YFrYtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 22:49:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 22:49:31 +0000
Message-ID: <b08c6de0-3fcf-4690-ad35-306e65ba330e@amd.com>
Date: Tue, 29 Jul 2025 04:19:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd: Use drm_*() macros instead of DRM_*() for
 amdgpu_cs
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
References: <20250715212420.2254925-1-superm1@kernel.org>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250715212420.2254925-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0082.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4dd77b-ff39-471d-7182-08ddce2903ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVRJcFRUVE9pbWs4UVRVbUFUVDY3V2Q0YmRRZENjMm5wWmR1YXp3NmE3dzBI?=
 =?utf-8?B?bHErWnJzdSsvQTUyYkM4WWIwNmJacGNlTnVSSENqKzZHdGordzB2SVgxaE1S?=
 =?utf-8?B?YThkaFExVUdzZEFNa0VQbEhKZUJUckttY0xGeUZGOTd4V0F2MEQybGNoYy9O?=
 =?utf-8?B?UE9NVUxBK3E0c25IUzJhK0pzSXFjR3RJS3hFTFI4SlpNYVBBOU9pbTJLaFpi?=
 =?utf-8?B?L0czdzNLWkZCUWVHUjZTK1d6aklPZFlhaUZxUVdaZ2JQOFZqNUpvRm9sZk1C?=
 =?utf-8?B?K3FkMnAzdGRUTkRyQUZPcVJNN1FkQStwdXVQS1pjYWkyUWs3QjVUencvdUs3?=
 =?utf-8?B?cmF6ZTQ0Qyt2djVQN3FOdFNteXJPOFZuN3dEUit6QkNlUUxDb0UzNHUyVERK?=
 =?utf-8?B?SXJ1eUJybGg1QnQ1aWRYOFplYnVGUndPRzRKRUR6dkVxeExWeXhWQjMxNzJw?=
 =?utf-8?B?T0JQT01UNExxMTlnSDluWWVsVlQ0VVpYWEZrcU1NcFBtc1BscVhwNEU1VW92?=
 =?utf-8?B?R212T0ZrU0VnUW04eTR6d21ha3FPMGowa29za3dIMUJTcG9US3ZxSzAyeEdC?=
 =?utf-8?B?cTc5UnhjMElqSGVWNzYyOWVHNVlaYlllN2h0Yll0Z0l6NmRxc0dra3phNVJI?=
 =?utf-8?B?ajhucHVVT1JyOGI2Q0daUERUbHQyZFdoODlwZVMyNldlMGlJb0REcnpFeEc3?=
 =?utf-8?B?S2hGbEdWUCtHYmVSQ1pScmIyYzBhSExUa0ZoZFBOb3d3QkdFekxsZDBNTUR1?=
 =?utf-8?B?eVRCTmNicDhzU0RSZ0FDY2FYa29nYlF1RmFjUWhNb1R6V3o2akhySDA2TFBy?=
 =?utf-8?B?a1JDb0JlZVVISGxUUEtnT0V4NCtrWGdWa0M5S0VMQWlBdnVib3A0Y3hkR3V3?=
 =?utf-8?B?a0N2OER0UkRsWC9RMGtHa2lmeUEvbC9kMnJFb2J3dVN1eGdEYzlaUFpwcjJo?=
 =?utf-8?B?ampISUlmeWlIUGk4bERDb2VWckpPYkZYTGIybENkN00vMnpnL0FZTHlOek5y?=
 =?utf-8?B?cjFrR1Joay91eTRGWWNodUY1eXltaGg1b2tEWWZ2dGNsV1lqTzA3QzZQc1NR?=
 =?utf-8?B?ZHpiU0grU3l6S1UzV09raW81Y3QyU1NINVFrTDg2Qkl6c2srbmF1clByMG9l?=
 =?utf-8?B?T01yUDF4WVZXN1pmdndJVlJXNFFrUDR5OE1RYU9LRnJoOWlSUitGWUJiSFN6?=
 =?utf-8?B?aUx4WG9pRy8xT05PNmRxKzBDdFlKNVczQUlEN0pFa1ZzK1ZJdlVYaHlRQXY5?=
 =?utf-8?B?ZjJQUmg0V1Fpb3hJVng1VU8wZjk3Q0t1YkpnR3gySFpRUU0zVURuVkY5Rm1u?=
 =?utf-8?B?NTN2dnNmWDVwTFhZMnFXZ0dxYWFZVXA2Sm9EUzJURGY4TWhCZTFXVUJLS2ZB?=
 =?utf-8?B?ZHNDbGp6cGpPL3VJaDg0aUUyTCtvUlFtOGVvamZrclNYS1M5YlJQcVV5ZUZL?=
 =?utf-8?B?UWxLRnN5WWFGL2NzRy8rK3M0S0xvcUttQ2NVcVpzRUtibk9VWWhnNi9YZFo0?=
 =?utf-8?B?bEtaYW1HMzkrWTNCdHVVV0xiMVRiS0thMmlzMVVOcUJkb3RNKzhsWE81eWxi?=
 =?utf-8?B?MzN2bCsyeFF0VWNRY3JvWnNTRTRNc29DdmZXeThZVjdYRElYbm0zd2U5amIy?=
 =?utf-8?B?SGlEVmZ6T2JLTEdvbWUwQW5RNmUrbmxiRnZxSURoTG1ITWx5c3FpNlhDVjJr?=
 =?utf-8?B?ellDbHA3QWFFZkZRemJQSUJlblhINkdMME9jdkl0bkhua0VNMkgvb2pjQ1B3?=
 =?utf-8?B?QVFVN3d0SURwZ09PcnI4TFZKV1NKaWh6MS9tSUJucEhvakZTRXRHV09ucXh6?=
 =?utf-8?B?SWNTNC9oUW1KV1dwZDdxWkNudHRvbldqc0t3bllwb1hUanpGcjRoRnFGaHpa?=
 =?utf-8?B?SWtRTFJJclZKcDJkVmpIaWxwTEwzdDhKN1B1YXphejdSd3Q5TXpZZ2hmcEEy?=
 =?utf-8?Q?IduMxU/qyaE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dC9hU2M2dWp6ZWcxNlFLai9sU0tkanIzZ0ZicVpKd3piSENiY1hJZUNzbEV3?=
 =?utf-8?B?Wm85T0szcndCelpvd2dia0tidzJnaVh4UGE1bjVHVmo1ekphTGM0TTZtai9T?=
 =?utf-8?B?S25ZckRQa1hTOS8vTzJpS2p1L2JFSFJzQ3NKeXEyYUg1cGdKV2N1ZnRIeGIz?=
 =?utf-8?B?MGlvVE85aTd6ZGdaNHNaNHNydmE2dnBTOHZYckVxajBXK3h6YnkxV2hYVDZK?=
 =?utf-8?B?VjZ1NEk5WlQ1OWVJaGxJeHdEMC9LVWw4TU52ZUFLbDVlamNVQ3RKZ1I5TDE5?=
 =?utf-8?B?bTdVK2xOSmlBSDBqVm9LckxFRDd3cTdlL3VMTFZqbDk1UGVwbmI5RTE4bWpH?=
 =?utf-8?B?ZnlNY2hvMVNzb1E3dEYyeEJnNUs2RkpxT2pMcVptYXMvZUVUeXorQ0pGcHMv?=
 =?utf-8?B?ank1ODNuTWVBU0crTWhnQXp2TkFlWlJ2Qm5DU2dGcnRHUy83d2pxZDdGM2h6?=
 =?utf-8?B?VEUwMEk5SERaOENiTzA3ODlOaWF4SmRETzQ1YTRrNVdQN0hXeFl4VlpMakkr?=
 =?utf-8?B?dWFJU29pNzBNN3h2M2RTeGRDVk52cnBsMEJzb0dvNTE2ZHJBam93YzIvMEdN?=
 =?utf-8?B?b1gzek9jLzBlWHpUNzVxMjhFVnA3SXY1bVMwOTF3L05ZN2VhcE1nMnk1OTJj?=
 =?utf-8?B?Mlptd3Z2R2ZFaG13SUtqWWJ6TzlMYUFPQmc0c1BEM1JjRTV6N3VqVGE1UkYz?=
 =?utf-8?B?VmRFWW9mQnVoREhaTDZneHg0Sk5Cd09vcS90U2I4b2xBelMyTjZnVHl3NkY0?=
 =?utf-8?B?NUNHaDluYXcvSENodnZEaFl3Q05DUHlzRVhDWGxMaHRGVmtFMXhScmpmZDFp?=
 =?utf-8?B?TE5nQjY0NXBDb1dvZ1RncUZycGZRMDNwWWFPL0x6ZXk1N0E4NXZPUkhhY3Jj?=
 =?utf-8?B?ZnJKWlNLeHVUcklkOXJLSHlGVERIcDJwR2RybkFLemJIMng4M3BPNFZKM2ZP?=
 =?utf-8?B?dTd3dFNZdFdJYnUyRzdwQWU4S1hWSzUwQjlML2JpbHFXc3dLL3RmSlEvN0hm?=
 =?utf-8?B?RmlZdlBOVkllOGUwb0R1Q3NNL3M0anJHYk1DOG96V3hWdnhTNGFoK0ErcGcy?=
 =?utf-8?B?M3pFZC9iTElPeW1BcVNkNThUNlFrMXpsQmhQbGxJZFRXekdOTjVWb2pnVjU4?=
 =?utf-8?B?cHdCcnRRRE9wOFBNNms0aEpRRVJNQzZSQmZNOVArWVNHdEpLY2pJSSt4OVFG?=
 =?utf-8?B?dVZlRDV0YVZWWmdObTJ2VTlsczQ2bXcvM3dWeW5vUGFjQVJGcmpQWVZKVGdo?=
 =?utf-8?B?WWJpU0YxUW5ZVzdSTzVxR01lUTZrTTRSZzNOeEdJdkNUTm1ZSVNKd3FEb3Zs?=
 =?utf-8?B?MVkxanoraGNUY21RRGN5OXlBbVdhYjQ0U1ppa0FyTHg2Q1RYRWE3bFNhYnNO?=
 =?utf-8?B?aEVKbzBBaFZCRVJrNWNtYjVucTBEbk1IeVpuaVNRZldLOVdRNFJ1M3dia3ox?=
 =?utf-8?B?MVIxZWhKOE1mczBoL0hYTzFPeEp3T25adTNUenFNT2luNGtldk5RUTdmUDlw?=
 =?utf-8?B?b0cvTm5lQ1hxNDZtTjhrRTNxaERlWUd3VHU3THB0RENlekdPYWVzY29FQ0JV?=
 =?utf-8?B?MU54MmdPYkhnYkN2SnV2M2FpSXQyRVZsemJDdldUM1Rvb2ZLellic3BNaWkr?=
 =?utf-8?B?MDFYUmdMeXpDcGMwc29HbW1EOWVDSUhFc3JSSktsMWQweTM4U1dQVXNCSE5n?=
 =?utf-8?B?Z1l2dmVHUXpNN1h1cXRncDgxdDV0RndZTDBoSFk1ekcvcENnMlI3blZCM04z?=
 =?utf-8?B?MnlkRTBYclhuYlJ6WUthdVFJRnFIUFZxSGpKYXNrMXpNWVBqdnlsRVN3RS83?=
 =?utf-8?B?VWMzREhCek40d3RYd2pUMHpuQ3RoWHE4YndnOEN6Z2E0OUFrako1bitlNjRD?=
 =?utf-8?B?L044RWt3TWFQaDFrZjJ2WUZUV2t6L09NVE9rOGNWUmZpSy8xcjJJRnRRMXBO?=
 =?utf-8?B?Nnk3MTlOajRMbVZwRm5DNDltN0o3SG9PZEl2MHFxL2E0eXNhV1VZSk14S05Q?=
 =?utf-8?B?STNBUzdYL1pIY1RlYVBIbkJLaEZsb1FFSkdoWWtpY2k3RnNnQjN6dlZ1a2Vj?=
 =?utf-8?B?Q3VlY0wwYlZaSDlXckt3ZkFHRUc3RDFiSHNxWk90c1NLQzU0UStyT1pWbU42?=
 =?utf-8?Q?jgycsEBXBVBkgj1zrkyoDD42t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4dd77b-ff39-471d-7182-08ddce2903ac
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 22:49:31.0451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xc/dzPKK/Ny66Fy0aAfc5eMwx7v5IBz5bSjggNGuvaDy0+kjbvN8zVMKDTOrQgqCYqeKeHA2dAmjiUTz7xoTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132
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

On 7/16/2025 2:54 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Some of the IOCTL messages can be called for different GPUs and it might
> not be obvious which one called them from a problem.  Using the drm_*()
> macros the correct device will be shown in the messages.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

ping?

> ---
> v2:
>   * use adev_to_drm (Lijo)
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 9ea0d9b71f48..e1e48e6f1f35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -395,7 +395,7 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
>   			   chunk_ib->ib_bytes : 0,
>   			   AMDGPU_IB_POOL_DELAYED, ib);
>   	if (r) {
> -		DRM_ERROR("Failed to get ib !\n");
> +		drm_err(adev_to_drm(p->adev), "Failed to get ib !\n");
>   		return r;
>   	}
>   
> @@ -467,7 +467,7 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
>   
>   	r = drm_syncobj_find_fence(p->filp, handle, point, flags, &fence);
>   	if (r) {
> -		DRM_ERROR("syncobj %u failed to find fence @ %llu (%d)!\n",
> +		drm_err(adev_to_drm(p->adev), "syncobj %u failed to find fence @ %llu (%d)!\n",
>   			  handle, point, r);
>   		return r;
>   	}
> @@ -901,7 +901,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   					 sizeof(struct page *),
>   					 GFP_KERNEL);
>   		if (!e->user_pages) {
> -			DRM_ERROR("kvmalloc_array failure\n");
> +			drm_err(adev_to_drm(p->adev), "kvmalloc_array failure\n");
>   			r = -ENOMEM;
>   			goto out_free_user_pages;
>   		}
> @@ -982,7 +982,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   	r = amdgpu_vm_validate(p->adev, &fpriv->vm, NULL,
>   			       amdgpu_cs_bo_validate, p);
>   	if (r) {
> -		DRM_ERROR("amdgpu_vm_validate() failed.\n");
> +		drm_err(adev_to_drm(p->adev), "amdgpu_vm_validate() failed.\n");
>   		goto out_free_user_pages;
>   	}
>   
> @@ -1060,13 +1060,13 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
>   		va_start = ib->gpu_addr & AMDGPU_GMC_HOLE_MASK;
>   		r = amdgpu_cs_find_mapping(p, va_start, &aobj, &m);
>   		if (r) {
> -			DRM_ERROR("IB va_start is invalid\n");
> +			drm_err(adev_to_drm(p->adev), "IB va_start is invalid\n");
>   			return r;
>   		}
>   
>   		if ((va_start + ib->length_dw * 4) >
>   		    (m->last + 1) * AMDGPU_GPU_PAGE_SIZE) {
> -			DRM_ERROR("IB va_start+ib_bytes is invalid\n");
> +			drm_err(adev_to_drm(p->adev), "IB va_start+ib_bytes is invalid\n");
>   			return -EINVAL;
>   		}
>   
> @@ -1234,7 +1234,7 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
>   	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_leader_idx]);
>   	if (r) {
>   		if (r != -ERESTARTSYS)
> -			DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
> +			drm_err(adev_to_drm(p->adev), "amdgpu_ctx_wait_prev_fence failed.\n");
>   		return r;
>   	}
>   
> @@ -1447,7 +1447,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   
>   	r = amdgpu_cs_parser_init(&parser, adev, filp, data);
>   	if (r) {
> -		DRM_ERROR_RATELIMITED("Failed to initialize parser %d!\n", r);
> +		drm_err_ratelimited(dev, "Failed to initialize parser %d!\n", r);
>   		return r;
>   	}
>   
> @@ -1462,9 +1462,9 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   	r = amdgpu_cs_parser_bos(&parser, data);
>   	if (r) {
>   		if (r == -ENOMEM)
> -			DRM_ERROR("Not enough memory for command submission!\n");
> +			drm_err(dev, "Not enough memory for command submission!\n");
>   		else if (r != -ERESTARTSYS && r != -EAGAIN)
> -			DRM_DEBUG("Failed to process the buffer list %d!\n", r);
> +			drm_dbg(dev, "Failed to process the buffer list %d!\n", r);
>   		goto error_fini;
>   	}
>   

