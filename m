Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561C2FF8867
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 12:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9C4C10EFF0;
	Wed, 29 Apr 2026 12:47:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CdvHr5MK";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52D8010F00E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 12:47:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsBl3K3Ryr7zhQZKw1ABjerta0WN6bRXKmvTL6DjFjdesqFU1F6W2iyowNXhfEyQyf1CeuaxIvO7TqMMrmTRzrlIveHYhIY7SeHPgpImNxiWP3pC+hH7OFd9P6yU6J20iBDh0I3lnp1NjY/8BuuvDLQWuxtsJdbge3oULz2H9lr/lDsnBXpvZy/OExp0Ej/YYMhzS37dE0bVcFkNuf4sZOJEZpEFEHV1BLmWopRpTkhtRX9NOtDEKu33sBogvyg6Mzt0fA8Gyab5cHD4RKcvZmgoM7sGiyIC+g2EH5dqVWGmAc7pbsjX+UcY6rHn1r7Z/Aci9XC6pHeSKkqLhaIvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8grd0osY+kLuvLijk83f9muYL0y1XeSg/v4TyrfRfGY=;
 b=ON22PlfMft9cQNXLz0dKxMXhq9pBYDpAbGvaPg8JQwbMy53U2W/tHmppwNVnRaQwRhXHcwYtiu9ePHfBaw06X6X635/OYZRCKf2qpmJArnLSHFwABc0dcngTkUiINZp4vNWjsqICOdOFwhi01HxPf2hC+GBZ8l2kIijAbj1XjkP9+3IPnBJ/oG+j+yOrlAGFDMtc5TRTLljOQlD1QO0MniTTuRW1pm/4uZ75btlG0877x7z+8OkJyRj79XbpyNrPsf2cx5L+/BisP5sH2N973h3kNEUrEE9vECkYtKqvxgVDvWfAZTcO3PrWtq27WHd9AMfNl9gjKob7NngGKMLAJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8grd0osY+kLuvLijk83f9muYL0y1XeSg/v4TyrfRfGY=;
 b=CdvHr5MKFF4cNX2FojXQRiuo8YREuT4Z9SWNe8r0Fa56PJerDpQCL9PotTsxTozoIS1IWkipY2sxV4v++KspBgYcxzk4fy465thWO1+5RB8hWNPvZUcjN/K3AY9oJhGFGt15h7ZR52bOd38nLWCQutNXzJ2K86EbPZbtBwkwEcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 12:47:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 12:47:23 +0000
Message-ID: <25f247d0-8484-40f6-b751-1b5f259cfa71@amd.com>
Date: Wed, 29 Apr 2026 14:47:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Adjust GMCv10/11/12 gart size
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com,
 candice.li@amd.com
References: <20260429123745.3930780-1-lijo.lazar@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260429123745.3930780-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ce3a65-6ba6-4877-83d9-08dea5ed756d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: qVh4mNUEvuL4/Bun/5YV+fH9eK/T2f6XkzY5a6KPJjMiJykc7k7g+QxJdJd8sZ8NyL2ajvJNiEb5n4sfbR0AE0RY8De0dOHGMmCugIyr38uXqTfWBhdsPxvUTL7GW6leNtuM5/iv+OwZCVCq0IMeMWNC5YivWyKld7/H7fUBk4STwAcB9AWAefCDIs6ZrKGUYoiImlS8he6QhhrA/+CWEbrxbR/Z6YKshBqogOR3DIWr5pJmUiBqclUGMwsWvaIzuV6b3OeFVbjfpaXbeVKId5ctgaQMfG1AA2aeqNz2F7Xfyx+YDCg/5a6euR01o9bbYVTeCL4Awyur3M8WqMMWRqZlZ2CaJXCCzGdK6kYbF8KzOHfdKl1EpzYnKB/dyBTHy+TK/kH2a4KhYKUAYkHT7BKtx8A7bdnUer84WIqSb7tD6hBVO1GuFA5WzfA7I8QsRuukcXtfJCWfiP5Q/M1oziH5zMHiHfjrnkFeNHH9++w8uVcDftxAqHP+KgDBY30hBr4D/HUJrcoXEisx/KYyVOLfY4tvdU9ia1OJorexA6UpgtcG5lpjeKFLm0VUw9gSRe35esKdLzwo0WRDkIsxfEbkSIRAe3Kh3S5Jd9r5nfzyLT7GPeam3MwtYlrQMfwbSmuYq6WRH0sJHNgo0CgDSb+NWL+cAVdAB5JfuRSgxcyeamKFnInyROsVWg1IDSJzbPj31JpznOy5GGl0D2Am5xixFQPop0UlZVEQlSfQbgE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjlSQzNLRFV4WHl2VDVwbWNzbEV0NzZvNGhFSEprNUFZK2ZJMk5mMUpndDBX?=
 =?utf-8?B?Nm5XZkh2QXA0akw1aFJxazdhQ052YThlYzJKamk4aStWdU1LTHJvSmp4WmpZ?=
 =?utf-8?B?MG5HSHJib3pKVnRTcDNjZisxR1NCMkdIVE1zUjFxTGZRTVBpRlBTdGtWVTNT?=
 =?utf-8?B?TkRXcG9YejI1TzgvdUw0dFBJamFnQjJPOG1IUVNuajBRV2xzTE9pd2Q2UE42?=
 =?utf-8?B?Y2ttK0Jha0R0UFNSTVJPU0Frb1ZZZVNEUC9lRjRpWnFWNVZyV3NPZWJ3NnFj?=
 =?utf-8?B?aGhtc2VHUXVON3p3SWFzVjhNc2FrSjUxRUhES3VBMk1nem02bUhYUTBObzFi?=
 =?utf-8?B?YnV4TUowbVE2NXFMY0FMTDlYdC9IRUR1S3B3MGFkK2R2RmNHSVVHbjNHZGdr?=
 =?utf-8?B?bk1MZTlLT2lidzI4UDlkUThHYWRSY0dvL2RveWtLeEVHaDI2OWtja2J0bkQv?=
 =?utf-8?B?d3Q2UklsMkcwc2FTdVNKYW9iU2sxMFQ5eTg1d1pCYWV2Q0g2WjlMTTRkeUJV?=
 =?utf-8?B?R0JqdS9PeC9qL01qNW5LMzdqTHByaGNQWDRmREFNMGMzbytWc3dtcFg0RTJI?=
 =?utf-8?B?b0xzdi9pTEdPUXhXMnd3aDVYd2c1enkvcDc0M250UFI2OWFRNjE2eGQyMHNO?=
 =?utf-8?B?MEVQZHZPSlF1dE82UnZ2ZzJlVDZWalFpWE8wRk9UZk1PM1NwK1UwTFRYSkU2?=
 =?utf-8?B?Z09pRGJyS2Z2VzVGbFdQeGFEdHBKSXFBdW9LcmlkUktWdE9UbktlcVl5elBV?=
 =?utf-8?B?UThRbFM4WTFkQ2ljR0lEVzNocm1FeCtqRm14NWJ2UEtlSEp1WFluZFk4NnJT?=
 =?utf-8?B?ZVFlb1pmVUZhQlpQOEIyb2lRMkVrcFM3U3BNRnRDQjdaRThBRU5rek9MNXl2?=
 =?utf-8?B?ZlM5TUo3RXZWSmh0T08wL3dtM2N5TTd6cWZuWU1udzhtK0dTblBLV0l3alpB?=
 =?utf-8?B?MlQrTWg2NlR4NkJPZVVWc1JsR2Z4UlRYajBlaWJCdXljSHJuZS92SVZJVEN6?=
 =?utf-8?B?QU9oVUNqdjlkcDZndUhXWVFkZHVZTDMvYmlJalR4YVlPc0N4SUFHWWprbXNM?=
 =?utf-8?B?L01jSytvOWpQTlNkcGd2Z0pZbG1ReHpqZHhZb01iVGFnZ2djczVQV09ncy9S?=
 =?utf-8?B?VjNRbXp3QkpLU24xY2tpZ2pPOHRVR013NG13dzhjR3pGdWZyRHJCWG44TSty?=
 =?utf-8?B?Y2pPSXVtU3VEQzB1UG9DZlFEVEc5Mk9MV1piSVFweWJ2bThYcWtjTVJHZ0s4?=
 =?utf-8?B?Y2UrRklMendMdU9qSCs3YllkOXpHalBZY0U0bUFPeE14M0dvQmFPcnhuNFha?=
 =?utf-8?B?TVVCTytOSXB6SzBGd1lKeGlGd3dOSHBaOHhkOVlzZlE4KzJSSm9ELzF1L0dt?=
 =?utf-8?B?WEF6dVVLQlJYQkIycDVLUWEzak9CZXFiZGl3S0hIR1ArUngzTXgvSHg4WGYv?=
 =?utf-8?B?MzhlYlY0Z3JzaDZPMUEybnkveGdTYWp2MU91RFFKaTcrcmE3b0xEbnUzTURj?=
 =?utf-8?B?SVpUYVlTQ1cwWDc2eFVJNFJiM1IwZ3lmZW9aWmJER3UzSDIvdGtvUFVuYlk2?=
 =?utf-8?B?b3ZCQUE1TWwxZitXcG0xdTM0V2JyZk5XWkpvbUpWSzQ4T09qUThtbDcvSUp5?=
 =?utf-8?B?VG5wY2Frd284OUpJTm81OHhsZWlYYXF5NitlMUo3bkU2cHlmdTBrVmxoWGN6?=
 =?utf-8?B?NVdhVytNcXhYSXJXQkI3eXZCMGNlTkYvbHp3VXozb3IrZUw3SWorUFNTeUxx?=
 =?utf-8?B?TEM4T05BVlJ5dXFYeUszWFFXY0pxd3FlMzJLblpoQjMxckdNTzBWS2FkaldO?=
 =?utf-8?B?bitveGc1MTdtQkNWOXNHMVVaWkZXNnNzVVU3bDVaQ1ROQVVhRG9UMUt2SkpI?=
 =?utf-8?B?MGJSb3craDF3VU5XOFZyM0ZVc08rQ2FuTUR1c3BaV0cyR1dCRWNCVnRYa2hE?=
 =?utf-8?B?SzZTT1lyM0pKY20xZ3MwV2llaFBGalNrZUtrS1FNU24yc1lGZ010ZTNQS2hN?=
 =?utf-8?B?SEgzYnQxWTNhcDZYU2xrYUp3bmNrSUxjZ1kwVHYrcmNTUGY5MGVNak1MMTQw?=
 =?utf-8?B?SnFlQklNRHYrbFdNS2wyWG9PcWRyQTU5dWdXQkI4bExadUtOQk9wdjBqMHRq?=
 =?utf-8?B?KzhtR083Q2ZxbVlSVEF3MDN4dFhaclgyRGZ2Q2EraldDbTFJdEdVSzZld2pw?=
 =?utf-8?B?UDBKY0VzUE90Zm96SDhPTENKdUZsZ0ZSL0Y3RHVDbHRGUUZwSWJSdlhyTWdr?=
 =?utf-8?B?dEZvQzhsK0M0NU95SkNtV2pzczJGV3RLQ3pjYzlpRGZtVkk5VmNpL2dPd1ZT?=
 =?utf-8?Q?P07llRtoWJ+HzB3odz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ce3a65-6ba6-4877-83d9-08dea5ed756d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 12:47:23.4017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4I6A9ZwO7QRCp3L9IMROiOjjcZyKK7AsrXnhEBECgXfdSEKK9qOmUI1dIu9d1Nz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953
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

On 4/29/26 14:37, Lijo Lazar wrote:
> Adjust gart size to account for space required for firmware private
> buffer allocation, if any.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 ++
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 ++
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index e1ace7d44ffd..1c32e653a9ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -723,6 +723,8 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
>  		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
>  	}
>  
> +	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
> +

That is pretty much exactly what we don't want.

The SMU prv buffer size should *NOT* override the amdgpu_gart_size parameter.

Instead we should disable the SMU feature when the GART size isn't sufficient.

Regards,
Christian.

>  	gmc_v10_0_vram_gtt_location(adev, &adev->gmc);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 94d6631ce0bc..2f6e338f2a35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -714,6 +714,8 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
>  	else
>  		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
>  
> +	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
> +
>  	gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 5bdd4b9b7893..e5096b9cdf50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -770,6 +770,8 @@ static int gmc_v12_0_mc_init(struct amdgpu_device *adev)
>  	} else
>  		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
>  
> +	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
> +
>  	gmc_v12_0_vram_gtt_location(adev, &adev->gmc);
>  
>  	return 0;

