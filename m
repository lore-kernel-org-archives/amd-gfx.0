Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5A3C54E5D
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 21:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F37D10E2D5;
	Tue, 12 Mar 2024 21:40:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HlR0Mqtj";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AA9D10E2D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 21:40:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1400jbbkgZsvbc7BQCwwv2rNmFdNfJrO1szQK4TyeGdnmIBLSSC+GHbp2RDfBytADszs/4ymvO0TyHP+fd8oFH9CmSBjFv9mKUBEtI+fD8/lUCU7OpoZ82Od+PslBhApP10463ZoaeVbBnU/d8wKDk+9zOPBcxEQ32b8/P460eBCfkjQKLpKAH+jGm1GhaHNCpqAHaRf/IfNWd6Ff8lHGeIei+s0WvqoHz7r/LEUC5QyV4EhASehLEJVSE/ty1Aj8xVfeshxWn2wDddZIrErqjCOPL4an1v4PS20EHO6tMfzjSruq2ZZ2yz4PY6jARFDGnrWf4a5QbtjYwAyIoNWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSnWPgkEUcr6K42+gklSqbjICfzANgaceURagS0AOes=;
 b=iuf7l0qZtJc/Lnwuh6lizsE0pGLxX+v96Bk9PX/D62hYg73exdl5nQ3BnOQCwkFB5QLckveNqPECiiNIF4DywIv7hqFuemsx4801P5u3HB28oteAEBxAMPfNxE2Ux7d9jh7H6ju8gBXr3qfeu4x6Fia7QEYciPIyXkmER1xzCpFE1honJVkr3owoJ6XOvCe059PF4+EUk182FPpBgwbqMFYRU0OTFE7ABYcUjIS1XGfVMc5qQSiLs8xoj5R0jBEwL03B11Et+1rYRJAu7utyqVVQTSCwNHZrMvUAXGoZy9Jml8Hq+NpXiDlzMGpolJvzsxqi24UlzZD8HlJgKhGO3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSnWPgkEUcr6K42+gklSqbjICfzANgaceURagS0AOes=;
 b=HlR0Mqtj7JFYQqZ99EPe9g9Xklbx8FCB0JL2wLd7IDFv1lSWm252yL/VbL4bMoi3FGWNIsI8XugLraCjHM4qgfDXY/aeEextxSR63ghmAQ3x4YOPvyLD87N4k56lxw8OhKK4ctNLQ6L6A0aT5QKUqbaxesRzkajLis9KJySaKng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB7572.namprd12.prod.outlook.com (2603:10b6:610:144::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 21:40:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 21:40:10 +0000
Message-ID: <5417b02d-f84e-43f4-b62f-b632affd3fcb@amd.com>
Date: Tue, 12 Mar 2024 17:40:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Init zone device and drm client after
 mode-1 reset on reload
Content-Language: en-US
To: Ahmad Rehman <Ahmad.Rehman@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Gavin.Wan@amd.com
References: <20240308190029.7678-1-Ahmad.Rehman@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240308190029.7678-1-Ahmad.Rehman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f157a72-f1fb-4c75-5d83-08dc42dcfe1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kCP7YsyapYXiyX6daP5f3M+8mZUlcp/Wb02f2PmpIxX3c5/9WuryImCslEWJw8a8Nlcin5jeWWjdjfHkDXT7Rp9Iq/vRRl5ouxtXXIoD/f26e2Bj2xW35n9QtHcB9TTV8QebfpS1w4z00NabXOfP++YG3IP5iY6TXqQWfL8v/XKFlFhATgAzXgJZO7G52SAOu+bZ7DIRkTzq/8g9/o5/SpiMli7pfntgRkjQhnctMqyX9GwgnTumzJ6u4iq6lWLuBz+cEN3OgIQ1oUSjudKY8ZGwCbo+mCLujRbl1IIah8Hbl9nv5+Sh0zddpHIf2EQDu1wJdUv+pU49ScoL1pUuVMFN8rDrsNmzDo0+HOH0BjchdkholUroFMvP8y9i8ShWuwBmgKXWwq1mE7i+xTa6RfTQS2hNMIwJO98S/s1OIANTftercpFvOERbbvjxy4bWcLMgSfewGY9RNhit2L839AiAV8zLnnPK9+7XfanAqIF065DiA7WM5wbH0J+DKA2zkDvgA4NwJSi+p/DaWsRZ7TC6fkVKIbQmpAUYrjk5b0Fl0hC1BkNMA9v4tfkMRcQTMuuX1VH5ZjEYH4J7FURwmbHEXMHFhdS1ZUc5+nfas9pdYH9MdAR4lDMLQekw7jxB/8sCEY/AkA3WwWqTLtW+hgprcHSsHqpRwTlA4YoC5FM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnpqRVdCdkhlWW9aZzZsak9Md0tWR3lyWFFVVlJEOUlLTGJLYy9iVG1FQkJJ?=
 =?utf-8?B?RVBiZmsxa01Tbzh4V0NOVmoyQnk2MmdsQW4rTitja0ZoSmkrSitaU1FHZnVJ?=
 =?utf-8?B?QUhZbUhCWm5tNEdoakVRa1hnUVdnbm1aaSs5L1ZONXpLQWRVanZpdXhhdDJn?=
 =?utf-8?B?RGhUTlRHaDVLTzJzemZjQVNQU1ZsdjIyYmdWYkRMd2l6aHJFTE54UFBPVis4?=
 =?utf-8?B?MEErNW9sTHBsenphRFBLTnpUY0p6Y21TUlhvMGJvWnFIZzFEWUJRb1E3RkZE?=
 =?utf-8?B?SmhlOUNoOU5PcGlVWU5uTnFmWW5qcWlYRmVaTzJaK043aUkzZEg1THJUNWxO?=
 =?utf-8?B?MDRyU0wvTzUweVZxcnNyTGtsY1licmw3UGxud2dKTk1qcVVrcW51eVo3Qjht?=
 =?utf-8?B?UkZmT1dIa01YYTBEZTlLR3Y4MDN3d0VqRkJ0cXJzYmRiVEtIejBjOUp4MnlY?=
 =?utf-8?B?bFZpa01MZHJwUkZDN0l4ZGJaWFhsL29DdlFHUjNIb0NFOXlVc0tPT3hTODBN?=
 =?utf-8?B?c3RBcm9LOWtnUWc4V3IySzBaNEQwWThYQ1JucldKb2wzbGMwUDBkVXE1ZTJE?=
 =?utf-8?B?M0txd2lva3ZVRGlnUHBQY0lNU1p1ZW13YTFvQWxQU2Z1OEpEanlmVmQ1UE95?=
 =?utf-8?B?Q2tjdnRwSUdHajZENFdqRjUrRS9jZENyNkVBRFp4T2pZRTgwdUR2Zjd2aTNB?=
 =?utf-8?B?REJ2TEozbzVWYURUYXdmMGZESGVBdFNvME41K0RqSjFDS2dJUHZpcGFtbkJQ?=
 =?utf-8?B?MUtMMjgxMkFFbEFjKy9NRzB1dzFQM0JPYnBMMWxxWjc2WU15QWk5MTFKUmpZ?=
 =?utf-8?B?dk5oc0tSM1RsazJLcG5hRllBNWFaZjZDdE1uUUtpdGhlUzVuTW5ITUEydzFr?=
 =?utf-8?B?a3ppUkl5VU5HWDFzcXNHWXBRTGhoWGYwQ0VtMkNzOU9TSEFMV05tRTBiNW95?=
 =?utf-8?B?RTJyMFl5RURkMzIyaTlEaDZyQ0hMYmRjai9lcjRTeXlub2RmaDdTNDRCVkNi?=
 =?utf-8?B?M2g2aGlyLzFHWnZsRG1qdTNYOUMyRGhLMDQ0cXhrdFRhVTJLcnUxYkl4aDd1?=
 =?utf-8?B?Vmx2TXAyUFN4aVBlUzdaYVdmNDVJOTl4bTN2YWVNWkhzM1MzMkhyV2ZKNmU1?=
 =?utf-8?B?Z1FnUzZFRFIvM3kwS0VGT0pLVnFZdXpwNjl3T3lyWHNlR2VyalpHdDRmSFZh?=
 =?utf-8?B?QnJacnlxNC9aT3F4aHFFWklvay9hc1BVZExNKzZCc3YyMklxODZna0Jtcklv?=
 =?utf-8?B?Zkkwb1lFNkpYM3RNc3hEbHJvcVJHTWh3RzhWMGE2YnpEN0Z0eGhxbkRlZ0dG?=
 =?utf-8?B?T1VIRktmMVgrYlV0RFJNMTBBMGdxUzhaeUlDWjZBTXNBbzI2dTFyUXlPZHdz?=
 =?utf-8?B?MkRNNmJyaWxYMnZOOVpRM2JGNjFPZGNMZ0VlU0VYRzBvY3VFb3M4cWpBU1Jl?=
 =?utf-8?B?N2FUS3UvOFhqYVdmNy81dDN2ekp1TzFLbmRydzBBOGJjNHBEeWJkRUtGRVVN?=
 =?utf-8?B?OXZoRmFTNnJIZE9FZ3FVMFVBazhlRk95c0c3bmh6NFR2OXVZK1pzTjVIRFQ2?=
 =?utf-8?B?U0pZUU16UTRDNzUyRkg0dmlJTGdYRUtXNk9MalVmU3lZRnBtWVpCc2pqTUlC?=
 =?utf-8?B?Rk0wV3dLZXNBS2JzODVieklOaXl1dHh3WGlCOXoyZDU5dW1NTFNRSFlZWWds?=
 =?utf-8?B?TzN5eFJiYlFtTi9iYXRSV2I5NmE5czVQdFB3WVdnSEhsaSs3WVIvRUw5dURx?=
 =?utf-8?B?akVCNWNGeHdKTzkvcFpLY2E0bStsbW1VV1RsT3lYY1V6UUlDNG1Yd1NpZmlF?=
 =?utf-8?B?YUVHblJUL0xoQ2lDaWwvdUVaY053a1lWYVF6VlVXODVLQWR3amV1dndvdUFZ?=
 =?utf-8?B?cnF0VzdYMUY2N2NCaVN4eGUya3EzRXRCV3dxWGZxU05zTmxaQm8zR1lXbjRu?=
 =?utf-8?B?RTRGVEZUNHNnaXpRL0NLTzlNckNNVGRFSXFxZ1lrdzdMVTlRWkgreUZiYWRq?=
 =?utf-8?B?Ti9JZEhPY2FYZndOR3VnaWtSbWNZZENvam56NldUNE5pdE1yTkFoWEZnK1Uy?=
 =?utf-8?B?VE81ZDhXUWdsK3R0b2V1bXQ0YVJQZytUcTFlUllvdFlJY3hyS21yUTk2MzVQ?=
 =?utf-8?Q?AFIQuTFLzhsrnF6X6Axyjh17X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f157a72-f1fb-4c75-5d83-08dc42dcfe1e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 21:40:10.4573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGYvU0DvFhmxxI/JeitwEKFrOoBc2Vhl37EJ496IgHePD0x3+K1jeqn/Cy36j6oHlAicvAH0hTEgh2Fr7Z/TNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7572
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

On 2024-03-08 14:00, Ahmad Rehman wrote:
> In passthrough environment, when amdgpu is reloaded after unload, mode-1
> is triggered after initializing the necessary IPs, That init does not
> include KFD, and KFD init waits until the reset is completed. KFD init
> is called in the reset handler, but in this case, the zone device and
> drm client is not initialized, causing app to create kernel panic.
>
> v2: Removing the init KFD condition from amdgpu_amdkfd_drm_client_create.
> As the previous version has the potential of creating DRM client twice.
>
> v3: v2 patch results in SDMA engine hung as DRM open causes VM clear to SDMA
> before SDAM init. Adding the condition to in drm client creation, on top of v1,
> to guard against drm client creation call multiple times.
>
> Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 5 ++++-
>   2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index f5f2945711be..4389d24f36e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -146,8 +146,8 @@ int amdgpu_amdkfd_drm_client_create(struct amdgpu_device *adev)
>   {
>   	int ret;
>   
> -	if (!adev->kfd.init_complete)
> -		return 0;
> +	if (!adev->kfd.init_complete || adev->kfd.client.dev)
> +                return 0;
>   
>   	ret = drm_client_init(&adev->ddev, &adev->kfd.client, "kfd",
>   			      &kfd_client_funcs);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 15b188aaf681..80b9642f2bc4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2479,8 +2479,11 @@ static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
>   	}
>   	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>   		adev = mgpu_info.gpu_ins[i].adev;
> -		if (!adev->kfd.init_complete)
> +		if (!adev->kfd.init_complete) {
> +			kgd2kfd_init_zone_device(adev);
>   			amdgpu_amdkfd_device_init(adev);
> +			amdgpu_amdkfd_drm_client_create(adev);
> +		}
>   		amdgpu_ttm_set_buffer_funcs_status(adev, true);
>   	}
>   }
