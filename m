Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4855C624CE
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 13:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A10110E8A9;
	Mon, 31 Aug 2026 13:45:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YrIVizZD";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19DA510E8AA
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 13:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUNapd3ycbNMSRLNqHqzQlxdg0Lt28EHvUoQBYO/AuDjy4aWzYDkNRFlDq7zrhjizWNCgsz4q0ucTsqmVR6EnvbCK6ygGCFNU/MDMNrVZcdlJwc3WIxETP0YNeUcgoVcMZUQTOSzwkJEn+q9FJCFhLHiYTrDKsbAagJfg+BDgYNUv7ZRVnbTK7+9UosECMIv1YVIjP2mnLUXPYLf52YkVOZdVS3jNXnYJdVxlMixLIERfVyoRBO49ljAygA0ceiRnKbAagPG4JcZvGBH5xEuFTG+xDAYJ9pPGDZ4e8QB5fVkyuYXRcWr0wRtJPGuwHdyU2WyWqs2MMlKEEVnog1xCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YL7h2fL/dGqKyRzkCITdVTa/Es/i7BPM2vRFxVzZ/EI=;
 b=ZrKoSVLxBgIorkha2JF1fVXgAhBippkEgbTCqs72t4MIS4ZDCdwScSrU35Xjvb8XT7HF/f5NGLJ/O1JltSDhGcj2L0tPq4rvyBOh2NLyuLck+nmCr1KGjcD+uVn/r0E3wcYKT0DcQKmAxoMS8CjZtISwSprYG9qafRN0ufHJYTWEWwvWOw7ovP+HO/OWdcRAJcsZ+jRqiEW65O1R3VODU37WADrE/ONSFOb2TTzuukytAaW7qdlJJRGB/Qr048yy1I2gi5gEK/ciw3quNqubZztU+twWpvX9uxXp1B63f1HVVZcPTiGbSXVeubAk+jYef4hHhSJz9vwIvOqwg6yqmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YL7h2fL/dGqKyRzkCITdVTa/Es/i7BPM2vRFxVzZ/EI=;
 b=YrIVizZDVR1T21nhz4HA8gcIUIRpUji6fr401wO7OWQxWczWm6i317VJLLJsH4RQfO0Z0wKuRV0s14evwUG1gyrmUx5IDHLSdaT2o+aU0oQfX03+8XHvKbFouMqGQ9aUq6LKa2+Y6hjjNXNuUxXo69Eus3Ljzl5VHVT57WBeupM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 13:45:20 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:45:20 +0000
Message-ID: <4f288d7f-f04d-4dfd-9686-43ba3bf7a34d@amd.com>
Date: Mon, 31 Aug 2026 19:15:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: skip IMU microcode request for GC 12.1
To: Horatio Zhang <hongkun.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Shiwu.Zhang@amd.com
References: <20260831133144.65852-1-hongkun.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260831133144.65852-1-hongkun.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bbb875b-4e8b-4b43-a408-08df07661929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ObMtkH/5G6wbSxu7qiJVLoSC1B+B6sGXwiEb+uVpn5PJvd4pFmAP+bUz2yLDX5uq7P4d0Qjpbo4vALEJ7ByOQmvlDs7fIaG+4086wlhu4HMDq+ICDRY9+qFVwQ2Nh88tGv1eaTLbF47czCIk/DxYyKtP65SAqkcy0ukESX69Soo0XFbIgaW5GiASi+O7+MqpPKPYbSkW71ir/xobfESG7iTkbUK2ukFQfiLPcQpR9yGFigv7D2m7wNxzsk9OWEdIexdCrnPrl+r6Esqs3FHpFzigRWVPEeoFsnG9u8PfKd9kbsiHBaWUFCs34Kt7TcG3/z7/rtDi7MuCCZuuMsMmxJ1AOnUACK8DnHkKu8tOFFWbijj7sNjBa4mMyxCmkwM8ziUBSpVJQNOabfc3a3N81dLi3TFDpVxGasTefFsED1kraGcmInuUTR8dAP8y+7u3e1xDmOgTSPAu+ag1GrtEe8T2GxPJJ/ZcsTMdMQw+RpjM0fSeN7mtsJv4YXVHjPplpx4wh2vtNCieHId9C4gfimV0y8E9DK4D/hIVh4KQzkal0YS6XIsq1c3sXlzQ0n+oUBsZOTQzs1lReXqdprJsZyMmtiLv0+Cy4tw/t1igT7Q6nrypU/er6e14yKjG3V5CWulJ3KRoj4QKLYKwtE0MM8IV0y9w/4OprcWWQsOmf4M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0c5clMvazFjWkhkZFhCYU1Ub3NIekVBYUcvVzRkdElXVThjWVhsTUVxUEhH?=
 =?utf-8?B?M0tMd0J3aXJEM1VZSEQ1SnVkbUE0bzRyRGlvci8zWnNXMlcxQ1BNbjg5VUd5?=
 =?utf-8?B?WkU2eUpLckR1RmtVUmxrVi9QY2NHbk90VFNVNjg5aVhEMVl0dmN1MWRyMVBs?=
 =?utf-8?B?K3ZRMzhySFoyMTRNT2VQdnBacXZnd0pOMW1NVDEvQ1BvR3NXNEx6U1BWQkZJ?=
 =?utf-8?B?WklleFc0TFJvWEZkL0pmQnMxT3loeGVyMDEvcVEwWUt4bWdjakFvVDkxZ2lk?=
 =?utf-8?B?TTdEbW5yUWVKenJBMGNRaGRJUEltL2FLcDdtenVHOEFzOWQrTGd4bFAxSWxp?=
 =?utf-8?B?K0hOUHRtVlJDQktiakhnbkJFMHZRNk9VdGJLU3p1ZVd2c0YxZ0phSmxlMUxq?=
 =?utf-8?B?Y0dxMDNyVTNEdlJ3aW1OanF0VWgwOUJtblJtRGR4aEd6OXQ1STVrQnlXNTBV?=
 =?utf-8?B?elY1Mjk2bEVGcEt6dklBejJKUGorZG15dFE5Wld5Vy9xYVJTQVp2SjFnZzlV?=
 =?utf-8?B?d0VpRGExZGJ0d29PY1JTNmhvMk80MDRGd2RodWFtWjZFN2JEMHN1SW0xZWE5?=
 =?utf-8?B?OVhNTWF0c1JFYXcvWUFwOEdod3FOT0d1bVQzeUhrY3pXNndnMmt3a0dtMUFM?=
 =?utf-8?B?eXAyQm56eWFySVR5RXFMREM5V3Q3NE5mKzR6YlZPNG11R2hkU1lMbUg2RWpv?=
 =?utf-8?B?akorbDFaZC9WSFZtQ3l1ZHZ4K1gwOHdNbnVDKzJ6VGdlVmttQ0pGNEZNcTV4?=
 =?utf-8?B?akJHSFNnWUVoblJjSnVqcjRCOEZpYnhtQ1BwbnU5OXg1RnFqVnZFek4waWxu?=
 =?utf-8?B?RUE3UlBDQ0xZbjVhdVJWNmYwQXY5K3VxZmJYNUtzOXpBYU92KzRoSGZ4cEFM?=
 =?utf-8?B?N3FDU3FvZi9zUUFnNk5FTnYzODk3anlOM0RLMjlLaS9pdWtJSTV0b2xIWlFK?=
 =?utf-8?B?MVBxZytaYWVrSDFjWlg5V2JrMHFqSkpLQ2lPWjFRY0hNZTNMWHJQbEpubWVL?=
 =?utf-8?B?Y0p0eEdPRVJTVWhKUDNXaUVlSDJjWGJoOXlaR085aURtWllHQ3g2cGh5N2pu?=
 =?utf-8?B?cmh2TGY0TmFCKzdQNEYvTG9LQ0dlVTVwajdvcTdBUk1xOFdSbjVSeThyakgv?=
 =?utf-8?B?YWFrSGpXSGZHczFsSXZDZlhhN2RVcGhucjlvaXA2bkxrU1paVkFaZWprMitq?=
 =?utf-8?B?SHExZHQ4ZlZaZXdZMGZPNU40bGx0T3B3Qm1QZ1lYVUlUWnpsN0lOOEQ2Ly9J?=
 =?utf-8?B?YWFEdUJRNHFsTHRGNXlMaCtXMFpTK1JlcXVkakRWcW04WEhnbUtCSW5TeWpq?=
 =?utf-8?B?azJFWjFBNWhvNWpBbXVsc2lIalVZV09RYUExNDdURHMrS1FwMnltR05wYzFP?=
 =?utf-8?B?RU0vLzRCakkrd3dlMnltYzFTMkloMXhpZGQ3TzJmTFhlNFJoaXFWUGwyRm1w?=
 =?utf-8?B?ODNvdnVHc0Z1QUdIS2VZbXc5cEx3T0Jhb1hZcW5vOVp6Q1N5cFF4NWRYbmxQ?=
 =?utf-8?B?QnYxSHMyVTVIUnBQdytjWjEyeU5tWkRPVmlodWJZeHZHR09sSjdSLzZtUnBT?=
 =?utf-8?B?c2NDMWFBaVJqcUx5d01ScGY2dzB3SFNsVG1KM3VsUjh4SDFxSkpYNEM0R3p6?=
 =?utf-8?B?M1E4aFpwYWpUQWVsNXV6STAySWwyNEpDUDM3K2wzK1lndlFjNWlMcjdrdGgv?=
 =?utf-8?B?ZzcyZFFETnNreG1Gc3FlQTkwdTJ1aVpqOFdMcXR3cmQ1aVRpOE5pdHFjT3BO?=
 =?utf-8?B?SEgrR1Q1T0RURVlXTnYrQ2owV2xMY202T0orMDhmVi93SmFZSk1jSDFIMk0v?=
 =?utf-8?B?Tis2TFlpcStMY3BnN2Zkd3FpbEkxd2NyZGRvYnlqeEVpSVM3ZHdCMUN1am9m?=
 =?utf-8?B?WldYWjI1NmtMTi9tVnlKVHNEdXJ1eVpWWVpRZStNOHhxMzJFRzF5djNidTlT?=
 =?utf-8?B?dDZyeWR1ZkgwY2dpK2FPMC9uZTlRUGhtdUJKY1lPVGVMVGRjNlppWHkvaDJ3?=
 =?utf-8?B?Z1BoSHBUUEhaaWdqL2ZJaWIzWS8rT2U5aHFOdHZMWDZzL2lyTCtJeURSUldM?=
 =?utf-8?B?ZlpxMGIzK0RMMHUxbVZ5Z1FJR2cybGt4K0RBZ2U1Uk1ERVNQWXExalphYWgr?=
 =?utf-8?B?M3o5QTJvd0ZSOXVoaFJ3QkFidFV6TmYyLytFRWtHaDJvWkQ3Z0VjMHRuUTY3?=
 =?utf-8?B?djZqNXNzTko2T0REU3A1RUJKOVNUU2dzZS9FN2tEK29sekdENCtXOFM4OXFG?=
 =?utf-8?B?WDhLV2Zselc3QUFxaGFKTmZVbC9ZbVhnSG9JOEtXd0Y1RlZwZG1RYkdwZlBj?=
 =?utf-8?Q?4rfkAHuhvV12mpZU65?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbb875b-4e8b-4b43-a408-08df07661929
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:45:20.3267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Sfa6nyXZp545lEUeqaAIrWzHQ5VoDdQWdJ7nsHOmEQZHod+QNC+UXnLHWMrF91g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907
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



On 31-Aug-26 7:01 PM, Horatio Zhang wrote:
> vBIOS has the support of IMU firmware. Requesting it now fails and
> aborts GPU init:
> 
>    amdgpu 0001:01:00.0: early_init of IP block <gfx_v12_1> failed -19
>    amdgpu 0001:01:00.0: Fatal error during GPU init
> 
> v2: drop the MODULE_FIRMWARE declaration.
> 
> Signed-off-by: Horatio Zhang <hongkun.zhang@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/imu_v12_1.c | 2 --
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index 1188e91c66ec..3273be640600 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -582,7 +582,8 @@ static int gfx_v12_1_init_microcode(struct amdgpu_device *adev)
>   	adev->gfx.mec2_fw = NULL;
>   
>   	if (adev->gfx.imu.funcs) {
> -		if (adev->gfx.imu.funcs->init_microcode) {
> +		if (adev->gfx.imu.funcs->init_microcode &&
> +		    adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
>   			err = adev->gfx.imu.funcs->init_microcode(adev);
>   			if (err)
>   				dev_err(adev->dev, "Failed to load imu firmware!\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
> index a124abe44724..33fe0a127c50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
> @@ -32,8 +32,6 @@
>   #include "gc/gc_12_1_0_sh_mask.h"
>   #include "mmhub/mmhub_4_2_0_offset.h"
>   
> -MODULE_FIRMWARE("amdgpu/gc_12_1_0_imu.bin");
> -
>   #define TRANSFER_RAM_MASK	0x001c0000
>   
>   static int imu_v12_1_init_microcode(struct amdgpu_device *adev)

