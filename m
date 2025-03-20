Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB009C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 11:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D687210E5E4;
	Thu, 20 Mar 2025 11:14:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mcnx8mgz";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F2B610E5E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 11:14:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfIzwJ6ma6lgV/4sEItD8foV4P+K398SoUF3LuOmpiF2yqfclHZE9cc4ddCkajtMLiW765s70bc9zmDkJ0Z7lnZ6D1eeact0gdaqOIeCyqD+j0XhV50ms7wy38o8TVtf/c55D497XdEVHri/ubMuEJSQek3yvZCeDTSS3vCzPmFni/JCGDwlbFCyLC5D0QscZCQvMR6NGW9hbXw9Z+fRd3AW7y7vTevtHbqg+mZGJ7crgxkcCf7NzivPCoMpvSMp8zyVfJZS3Dc0xGeUm8D1PO2O2l7F7qd3vtl2/ooqilLK4KfOJUjSonwVfGzfKc+FSuYxVpX5RzmIHvsvuexS0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcrxsRFUmZtIDvpJMQ9FNmKtzjhdhjUCNZYphegUrSM=;
 b=bzZS0KyS1bGS8oyT60+RdxOVfRWOw0Qai95Dg1Cxev+8uqmFKay754LMRS8y7lCywcK8xcyGbRo/p/IqiqnmBx6TtQBwYaer5VzZ7I6IKIBv35GcnrAoSuJXcmRZtNlBZerbpMIxPvw+CVNnT5UN3CmO8NhHjIPDto9h8GmbpsOkV2D1hE412vSC5S7jW2EhVGDGXPwSB6jC9P2LOSHTL3ZiIHKY+O4Tjuml8UiKVfFQsTWO91V8fzn7Mi88YEdhecMt/M20hqTty2HtzwDqEjrW8se/N6WLo5Hq3imNl0hOhq1FqA3vXJE0Fhu+Oo+qz3T9rgX6Z8rfJkaEIJjfxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcrxsRFUmZtIDvpJMQ9FNmKtzjhdhjUCNZYphegUrSM=;
 b=Mcnx8mgzTjDzdSQJJDjgeVz2WslVRIxhiz7XJtZ7oe03lWwhZItxqhsH5oREBHCoAl/fZzaQLsDbk1SW4SOyuVIAaYXsn6uPbqik+2IP1aeT7+Lx3OFCfBJKrfpiwNFvwpRwScM1q2f69M0mhi4ge2AFxUuLurlzXHZ7ZQpqSH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.35; Thu, 20 Mar 2025 11:14:14 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 11:14:13 +0000
Message-ID: <d2af32a9-f7e7-4530-93b0-c5d015e41c5e@amd.com>
Date: Thu, 20 Mar 2025 16:44:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu/mes: optimize compute loop handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: "Shaoyun.liu" <Shaoyun.liu@amd.com>
References: <20250319190850.3899718-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250319190850.3899718-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::32) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA0PR12MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: e44be1cd-639e-4517-369d-08dd67a0588a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RENZeHRwTm0vVUFhaEt3dHdLMDVJRXhtUnduTFRvSXU2enRhdE13TEV2YmMr?=
 =?utf-8?B?RFFzbFk2ZlpkaWg5S2VZRlFYa3gyZDl3dW9lanIzdVd5S3p2cyt5SElOYnR2?=
 =?utf-8?B?c2VOWlhoZ1haTGtXcEpEakxOMjNXWklXOFpnbTVyRGZhMzh5aVlnK1NBcFdQ?=
 =?utf-8?B?bFZ1OFBFemtaclljR1Bjd0w4a3hmelFQM3ROaG5rdHZVMU41MzQ4K2RheU05?=
 =?utf-8?B?VTB6NVdTT0RmYjNZcGRVcXpUajQ2R1N6aDl2V0ZqV1lmd082MFU0SEdTanVo?=
 =?utf-8?B?K3c4T1l5N1JyMTN4eUs0c0czbXhIV3pibnFDYmM3WTVqMDFVM1NDMWhibXBn?=
 =?utf-8?B?K2lKTTd6amt3VVpCaGZ0M1dZRHE5bGxrQ1h2MWkveWlzN3IvY3k0TWZDQ1Ru?=
 =?utf-8?B?R0FJbVFnQTBiR2dSRHFpb1ZaZGpQdER4ODdxSFhYd1RNd1N2YzhLV1owSVBk?=
 =?utf-8?B?SGlZZzhsdTVCcGJyVHZ0YjhiUmJWVDkyRElDczVpZE44UHZONlRmSEwyNENY?=
 =?utf-8?B?QXY4a1VVOWNvb1FTV0NvZ3p5a0JteTdFSldTazB6SVlQNURxellUNVJqeVg1?=
 =?utf-8?B?NDlLZHJ3MTJUUWcyNlVBcnp0ZVNlcXErYVk1Rk9CZHdzclM4Z2xOUkRqL2Ni?=
 =?utf-8?B?TWpBaTczZ2NxM1Q4UEhTZnBENm0zazVXb1RQU3puT0VWeDdpUUREd20rRGw0?=
 =?utf-8?B?TkNuSEkyL1NpVkdXeGp0SE1mVUVnTE13aVJhK21XMmg5ZzcyOG9ROUtPZnkv?=
 =?utf-8?B?V21jZXZKUnpKaDhYVVJyTGxGUkxyU1VvOXlidGkreDFkS0N4dzFFMWNnTzU2?=
 =?utf-8?B?NkwyVFlOT2JmSFBhdUhsV3NhYUtyZUpvRlNrcFhadzlHMmJLaFdWeDh3VUZi?=
 =?utf-8?B?Z0Rsd29oQmVIVEtwWFpkZU9lRjVHOUYvbEVmUnpWTnNDMnJta2c5cVJRenRM?=
 =?utf-8?B?eGFDTFBmM01tSy9UdGZiamdtSGRwSjFYZHFYaHNNTnFsZWJ6eis4Z01BZkVU?=
 =?utf-8?B?MEtYUXQ1cXdOTVJGUTRoY0ROczFOaERFVmUvdVJQWERhUFFDT24wYkxsWndj?=
 =?utf-8?B?U2xyTjNWK0hndDE1QWh4MHhESi85Rk1Oa0VmSGkwUWNmVG9YdHBMNnE5YXBn?=
 =?utf-8?B?UmVtWnJJTlE0QkZlc1lHYkVvQkROTmphdVdQejBVOWI1a2ZURHlCZFNiNk5Q?=
 =?utf-8?B?cDlNWTl6eEc0QkFnNElYRjFLT0xEV3VMSGEzNnJtcnN3cGtaeVEvN0tEdGFZ?=
 =?utf-8?B?Mi8vazVqQmRXRlpsRHNROUJZSFAxTjB2dUpid3hyVnhqbzFQQzM5YzZhSWtx?=
 =?utf-8?B?MkQzZUlBeU1DVXUrZG5IODA0aGNlaWVVM3FWNHllcEdYN0JxRE5sOEdSNXdB?=
 =?utf-8?B?VjRkS2x3OXljTTI5Tk5La0RFamJ1T0NDdlNSektYb25vRDFHNGo5Yng1dXZz?=
 =?utf-8?B?ODV1MUEvOWVkbU5KT2Z5S2JGOERvS1JHTTlZQ0drUnNyRTZ0b05LRjFxWVZr?=
 =?utf-8?B?cU5pclc3eHI5SThoaUZsL0pXdDlFZlJlSWN5SHg3RCtxQXA0L0J0NW11SDdP?=
 =?utf-8?B?aDFHZnYvaWpTSHBhdmNKMUlqQkQwLzhUcFNHdVZhUE5LYmZxTStiWFVtb3pR?=
 =?utf-8?B?TnowS1VQc0NtMEdCV0kyUUU2YU9ZWDdtMWpBUXVlZzZkZGdjd0VqWGVGc0Va?=
 =?utf-8?B?a0trdDlKdGlvT1M3NWFrWVlHUE13bVhYRXJCMmxYSHJWVjh5eWZJc3cvc0t4?=
 =?utf-8?B?QW4xRWJEenUrM3FENHEvOUJQY2YrOXMwVGJXMWV3cnpMN2FNMUFvbThIVXlF?=
 =?utf-8?B?bERGMU96Qk8rZ1NhQzk5S3VGcXp3RWtJV2o2ck4rSGN0dTlFSjdUTUxicGlU?=
 =?utf-8?Q?VpB28rkk/tADA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmhNNDcrZ3NuRjRrVDlEZ2MzMUFoZExKc3VwNHZ4RE1ub0tvVXdZL1BQcllT?=
 =?utf-8?B?cGJQVEt2UUJPWjNIUDNBRi9qM1ZGMThZOTBRNlNoRGVXV0RlZkoyL0NSa0p2?=
 =?utf-8?B?T29SQVlKR25WWkdTSVZ0bHJZaEdzd0dDVE5PSklsVVNnRUlkcHZ4L1Y2UVND?=
 =?utf-8?B?c3JIcnZEKzFtY1lvVXQ5NFNRL1FHNU55L2NOOWY5ZG9sSUlVSDhhckx6R3Zq?=
 =?utf-8?B?VTBMRlZvSjQ5UXdWeU1RYThrRkFpNGQvSVBmM0xBWjM3blBnS1pDWjU5M2s1?=
 =?utf-8?B?OWV6anBMSFRaR0RrKzZkOC9FWE8rM1cvM25jVjhEclBBRXZWYnpJOERqUEV4?=
 =?utf-8?B?bzh6TmNXcks3SUNKSlBqVlpRM01FbDF1QmlsNkdlRnJhNW1oRjhydjE2aHJX?=
 =?utf-8?B?UUtnWkdxS1BZUDN4bUVZc3pvcDFIbDBkNzlrcTBmQ0pqUjJSL0U2MWZnNHQx?=
 =?utf-8?B?cTBPandzd21JQVAzY1hWR05LbHdlMlN3Vk1telMxVVpiSEZEdUF6blBIMVM3?=
 =?utf-8?B?QlNWeFlwKzIrS2YxK0lGdzVoajRuQW9qNy81WGh5bjgwd1YwdlpkOU5wK1Zq?=
 =?utf-8?B?ZHZuQXVYSEYwbVVHN2tRWGZsUVNLNy9ZK1dZWWdsellXZzdqRkJZVHc1OVgz?=
 =?utf-8?B?U1RIZUlJVFBTcnRJWlBsZDNxR3VQcDAyUUEvOTZIMWNpbzdMdzgveHNobG1P?=
 =?utf-8?B?NFRueXc1YkRaWXZRQ2dNeXhxWGZKRVl2aGZZbVFjV2J1bVQ1L3dLWlZxYTJL?=
 =?utf-8?B?YXdROWt4ai9zMHBiczhEN1BzN29XVXI2K0lJbzhGMWNOOHk1QWR1V1c2cGwr?=
 =?utf-8?B?YkxwbURSNkU4cGZXaDRnQ2lKWkpsVVU1aEVxR0RpOTlLTWFCQThNUDRUUUhR?=
 =?utf-8?B?RnRoQ2FWNTQyNnBDcFR1UW1HbzZMQ1l5WDdOc2tUNVM0K1Vub3g1dlRuNlZT?=
 =?utf-8?B?SE5sWk42Y2V0ZDNuaUQ2eUFoaDRQTzBtQWlYTjlnbjBKTFZ1bFB4NU9mS0ho?=
 =?utf-8?B?VmZocUxUTlMvYmZaZFZXMTBZNjlsdy9jTGpFRzI3dTBNZ1RLQTJUc25zcm0w?=
 =?utf-8?B?QlBZeUgxMk1zVTAxMGVVMkkzR3ZWejEycCtZYVBWM3NOdEphSEhrN1o3elZN?=
 =?utf-8?B?bHlCbml2UlMwSzlsUXhjV3ZrMVBPQjExWXNJa1BnMmN4OC84V1VhdUI5N2J0?=
 =?utf-8?B?Qlg5UG9obDlXVFNzTGJHWWROTEc2RVdreTRuaFRkYmNQbHo5ZkZnMG5xRTZ2?=
 =?utf-8?B?RjRvVGMvazlEYlVQQTRjVW9hSmR6ZnJySnpiN21ZTVlTRW4xbXRRK3ZzWlBI?=
 =?utf-8?B?Y3BSdkE1UEJNdnFRZHBBWVdpS2s4bzFZV1lUWnloTUhHMVdYRWFUSklBV3E1?=
 =?utf-8?B?WnRRR0I5M2Z6OXNlNnI3d0ZjTGdjV1FNV08yT3JYcDFtSUsxSUxNenB3SkRD?=
 =?utf-8?B?eVlWWTZXVUF1NnVXR1FXWXNSWGEwWnhCZmFxQnBNRDJ4UVFwZFZ6OHFsZDFv?=
 =?utf-8?B?ZXowaGpuUjJvdG0rQnFRVDMySTlUcW11OHA1ZW5KSGNYMHRscHZtbjh5QUNx?=
 =?utf-8?B?RUtNYjlSUkVHd3dqcWZWd3Y0MUc4b3RJeUI3cXZNaEViSGRRbXNyeVYwZmdy?=
 =?utf-8?B?SlBZeDU2b3gydy9OQ2ZrV2lYV1EwVnEzaC90QmN1ZG14Nko1a29OTmg5UUV0?=
 =?utf-8?B?TC9JeHE5MFNVOTVieExuL3czNGJCWlJXeTFXMVFDU29hWVkyTUdyUUU1aUc5?=
 =?utf-8?B?MmlaUWpFdjZJdklHWGYzQ2ZqMWVBM2hCZFMzcFVwV0RqenNPOW9EUmV1cGhz?=
 =?utf-8?B?YjJWcnNKaElzU0haZlRwS25lUHlWOEZBcFE3NHIrUUtBZmJ4eElNcDFDOC93?=
 =?utf-8?B?VzBLKzJOYnZtSlFqN2R0NXY0YnVJZ29DSk5oZ1lZSlZuTDRyZk9xUTZpWW1u?=
 =?utf-8?B?VDZ2YkFIdk9VaDM2SEJnUHRVOXdKOEpxTVFrT3Jvck9rb3BSeUpLNkVKQXZ4?=
 =?utf-8?B?a3crazZ2TldpdWVMTzlLU1NhNUdvaENEeEVZQ0o2SmlQaGFVaEVEU2RMTmkr?=
 =?utf-8?B?TVBMRzBrS1FrU2h6bTc3Z0kvU1lSNjZaOWs0WjdpdmoreTQ2ZFhTZCtSYyt0?=
 =?utf-8?Q?S41QhVnEw3SxVbhPYk6r/eWEE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44be1cd-639e-4517-369d-08dd67a0588a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 11:14:13.8524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJhkbGPnHOZNWZvdKVjEsOSfmUHzvxiZvmZKYcav67ZNqgipZ4VcT1BP+WKpVcIh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494
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



On 3/20/2025 12:38 AM, Alex Deucher wrote:
> Break when we get to the end of the supported pipes
> rather than continuing the loop.
> 
> Reviewed-by: Shaoyun.liu <Shaoyun.liu@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 3b83880f9e2cc..10f14bf925778 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -132,7 +132,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>  	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {

Unless I'm not seeing something, why not just keep it i <
adev->gfx.mec.num_pipe_per_mec?

Thanks,
Lijo

>  		/* use only 1st MEC pipes */
>  		if (i >= adev->gfx.mec.num_pipe_per_mec)
> -			continue;
> +			break;
>  		adev->mes.compute_hqd_mask[i] = 0xc;
>  	}
>  

