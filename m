Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BDFC77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 15:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C856A10E76E;
	Tue, 25 Apr 2023 15:49:16 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5097A10E76E
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 15:49:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYXP1X4w3+HoKDmurCLdBACOOs54WhAvyeNNNO25wFLig/mAATv8DA5l32l6EPUtEBikXHczeyZIh5N69R5D7/dxSHuGUI7Fhjr7yE86L3BpBfabOgiTekzll3s7EL1bZiiIKk6VWzXm2wVAJM7gRCOp56KCrUSs7hRIzmx8uw0TJ7a6CLT9MutP9Z4etvvZ7pJRe+UHBjqTD+sJwoDlaMlM7gyiN4FAeudv9BuKzA7D3gS5QSp2ESVIRFz1vGdDLQdBL78fhF+XEH4EFz0qZdCBaJ8Pm/W6EQzge+AhTPU4Bo38XJmC0KXjpaJsM1cTLpq6g4xlL7rwB4liY8w+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hcd2OvsnMQo3DfXra92BHlOgEoi5LU9HqxltzksE0xE=;
 b=B+pNNOGKxiW3nRN0Cl9OlWXqwQUdlsAV4kYMHSTtv0/xpAmKzYUIHUyxo9uK5TBGWXU0eOj7ijKcoHtDRuz1h69jshPXL93yMWBv1WNPtgxB88LcOHwy8HnmX/eu1QlBt0Y6f/wArsjDU9VFQHC4b0HEgU8kFieLnsU1wvBJr4dXK7FFtwadxxo2Yn1ccGioOKnVWwjy3AnAL+Now9UzQJvPQQ/lUn1Up5OFmji97pZyMo5zA0TU1WfGP5Ux0pSqcL3jd3QcyIGP4GjmVSeySrDnaUwc+xvCDlA4+K60LUe7/WZaiGOmmNq5Xyes2rN3J63swkt65CVr3W1qaQ/G5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hcd2OvsnMQo3DfXra92BHlOgEoi5LU9HqxltzksE0xE=;
 b=GvevpI+PMlb3wBdrTeD1WTatqODsfE6HU6Gfyo0JVIT3cK08SHBppihSSEQEFs8xUSFW9ljg3yS1G35/3CV9MWcHJBpioMtII/wXLydlvSqqF/r3Q46w8wZ1htut3jwskA7EM6Ete0YP635FlzW4JLFcr8yg2cRggnNDzBt2P7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 15:49:12 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 15:49:12 +0000
Message-ID: <d973f3cd-5b49-b685-227d-e3b7058c1b1e@amd.com>
Date: Tue, 25 Apr 2023 17:49:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: Enable doorbell selfring after resize FB BAR
Content-Language: en-US
To: Shane Xiao <shane.xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, felix.kuehling@amd.com, hawking.zhang@amd.com
References: <20230425145444.1309838-1-shane.xiao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230425145444.1309838-1-shane.xiao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BY5PR12MB4195:EE_
X-MS-Office365-Filtering-Correlation-Id: 6579911c-e854-4102-efbc-08db45a49d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ugRnm0p0Rxc1jJEeec0TwJBx0vOPIkw+HhDj6on5qybxhfoC+XyDRwY+n57nfCiqASgq793UDz+Se4iGjmNqwh113k8jneTCJLvMztm74qoJq/MM+3AQgrnKyM6FJlkgF9E4ph+qU8ipPvGzmU8VLOaD+OqSPgZNQ4sDtqoZW27N4OcX4UTsGBTGm5R/U1sykwXAFWiHs6BuTytsGgJj1CDX3Nj9OgAwCrCQBgEUOsUIqhHzmUWE2XRPjMkoEHPnjIiaGFqxHvDB8aHHWxiC8VSEVxQ4Ak3siTfofQ/+flDPkd4jIloEbMIVPfya9A4U0GSkep+ja8+4yB1n3DdNGAo4Cv7RQJEPdvx3bQ59hHr7pN5JBbsEksUhLPhvpe6AS+j2O+EOZspbML4RnZp7DFHTtU14A8H7ITQrGxdDzez/JvSYN5fIakPaFZcO35osL2yIXoO+X2BcDhztEWoHGuYm+HeGHYSbtpwV7gboUTegCc/v+M4FLlEPC1mPRCL/sCKE07T0PzpUZSkmLMQM82fr9/Gx+VfkXNDv29pHRJ/6JzSOst4p+yVX7flfOcwwRzMc9GjYMEVQKKrs5QbyUufrvEiJQAV4NACiMhhRGFg7RYTaQbQKorBDiGW90+R+zsA93W9isXL29cdZtMSwDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199021)(66556008)(86362001)(83380400001)(186003)(6506007)(6512007)(2616005)(31696002)(38100700002)(4326008)(5660300002)(316002)(8936002)(41300700001)(8676002)(6486002)(6666004)(36756003)(66476007)(66946007)(478600001)(6636002)(54906003)(31686004)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHRFUGZuakxRS2dyNm83U2tLa1lNUk14KzJ0SWp0aGxiYzA1L3dqS3Z5aHFy?=
 =?utf-8?B?N212T2RlMFpVbERMM1BtU3pJelBIenN1YUN4cnRkNFJtZ0VBOG13THROWWh0?=
 =?utf-8?B?VGxSaDNSSm5KaXNkb09JNCt2MzJveDlaaXdJakh4aSs0N1NjN0hXTHREUVZw?=
 =?utf-8?B?NkNhYUswbDgrRlBSMDdkOGhtMmpUSXRPT2RHNnBjUVpPalRqdmIvYzVpU1lm?=
 =?utf-8?B?RXNUVkFNcVJCOHhlMjFScGQzakEwa0d3dHd5eTlVQlZNS3A5amxuV3BUWndx?=
 =?utf-8?B?VVBKMXMxZmR5QVp5TE16SldxenhiM0locTAwN09TTkgrbDdmeW1MQ1NXdkhG?=
 =?utf-8?B?c3hyOU82dHF1ZVBUQlN2SWx0RFZsQjUySHA3NWxpSCsrenN1aS9GYTNhNlI3?=
 =?utf-8?B?U3JNV1ZraUNnd1ZCSHROc1VreFhUQzQyVUIzYWJLMjRPYzY2QXJaM1pXLzVZ?=
 =?utf-8?B?NU1aSndqZlNJbVRBOStVTTNJWnZUd2R5amVYVzdFaUlOWURTYXZ1ZjZaV3V6?=
 =?utf-8?B?R1dNY2NybCs2Mm5zdHo1bXNJRk5Ccko2MmRsd25nakMxZUFFOElucThoZjFE?=
 =?utf-8?B?YUNQbkFIeWxIMlBtdnVZdmFGSTNpMW5Vd2hIV1Q2cHZTS0NxbXZrTHdiaG1W?=
 =?utf-8?B?T21UekpQS2ZSTEY0aVlSMU9DcVk1aEN3N1BSU0Z5alZEMVh4STg5MkpieHNI?=
 =?utf-8?B?NklxY1dSanA4TVNzSjhrNFoyeFVtbUFRN1VhcTdCalFvUWhkQ3J5VFByWkpz?=
 =?utf-8?B?R3dUQUJqSmZxek8yK3QyQ2I1eTZSUTlSUVJucmNzbGgza0Jmb0NZcHYzU1Jq?=
 =?utf-8?B?THV3anBZQWI2eTcwRmJEYk1aS3hPeUM0eWFDL2lVQWdzS0lRSi9DN0ErTTMx?=
 =?utf-8?B?aFJzY1VjSzcvaXBsdXBING9JaUVaTWN1MWdpQ2hzV1FCakJrV01HZWJjWGhB?=
 =?utf-8?B?SUgyMUh1SkpCNDcwVEMzcjlqNGZhak04TWFOMGhpajBpM3NBYVhHYitDcmZx?=
 =?utf-8?B?enM0YkxTeWRjOG84YThGQms3enY3OVlsdFRSSkRNb2VGTndnd3FxVDl0OWEw?=
 =?utf-8?B?U2UrcXYrWGEwTlhkMnd1eUx2K3B3MGl2NVNUUmtBd2FJdW1lVi9zVnhwNEN6?=
 =?utf-8?B?TllpeHROZEhzRW90TEowOUQ3R1o2SDM2ZTRPK2MrL0xhblhVdnM3QWVGUkJi?=
 =?utf-8?B?cWhXb0hBTjM5T3RyRFY1dGwwMEFBdk5NRmtDQkRIaWdlSHlsNjhQeTFJbGNG?=
 =?utf-8?B?aFppQUlVRERHVEYyMWk4c2h3MzEvYW5LbWJiUTk5UWp2M1BFOG5hdG1VTEpw?=
 =?utf-8?B?VG5EYkxGSDJ1MW81NHlGZk45NkRDamc5TDBpZkF5K0phdDhKbUh4ZUE1Q3Jw?=
 =?utf-8?B?YUtyenhWUW4yZHV2aFhsYm9NRlkwUk1td1E0cmx0czc2L3JHRzBTNXRtUHpU?=
 =?utf-8?B?TlhWN0J1L2lOZ2djM25NMFVXcEVrenk5QVJCanFDV0lBTEpFVysyVER2SlYw?=
 =?utf-8?B?VXFBRXAxeWwyVG5WUGlYditGNE5Ea0phY1JvZVFZc3N3eHB4QVR2SW5KdVdP?=
 =?utf-8?B?dk5vS2RLWjFJcGJzenRnUGVFTU5kdW4wMUxEWkltVHhuek0vSEUvQzR5VEFQ?=
 =?utf-8?B?Q1k2NGxKc0dkdXFrZTF2bXpRbWNvdXRvN2xNdUlUTHcxeW5QaEhzVmw3Y3Bt?=
 =?utf-8?B?b05oL09BVEp1Y1JsSTdndDJtRlU2YmwxUEJKTTBaeE1iUW9RU3BoM1FCaFl3?=
 =?utf-8?B?aTJUMDRTUXdiUm5pSGNCckxXd3AyOU1pMXYrTS9BY0RGaGVObjg3dFlaakE1?=
 =?utf-8?B?NFptbVh3VzBIcUNPbGJKK0ZRQWE2YitNU3U1RmJoMDZpLzduMTFEYjNCaU9L?=
 =?utf-8?B?VVdoSjAwVElZTlNxME5CRE9zdmRHZ3FEdTd4Mnpsc2tGQWxqcmVBZHYwK3Vv?=
 =?utf-8?B?VUh3L2VzZGdkK1BKMit5ZDFSYkdWcGIzemRZRWEvZGtjZEN0SStpcnNacFlI?=
 =?utf-8?B?am1mMDA3MkdhN2kxWFhZYUFSNUpTek1KTU1VMG1hZTBwMkxXcFNJcjYwUDlj?=
 =?utf-8?B?VitkTDhGaitNQlh3YnhFQzVheC9VcXg5cWl1SjBLQjh3MHlXcFpGSEdZTjhm?=
 =?utf-8?B?dlJaQ29LRmZqNHBvYXpLOStIeXZnWVZ2YnpXY1VWTGZvVGczdkdLeHZQRU5S?=
 =?utf-8?Q?qRHtePR32LEXlGFAx8/IEC2raXFkBG/eEhcqDawb93Kh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6579911c-e854-4102-efbc-08db45a49d4f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 15:49:12.1812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9sTWQlB5TmzYFHfOvL8m/T9nB3xrfemXN45pMFLqLvLoCWeIGKX6VrecFZA7k8N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
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
Cc: Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.04.23 um 16:54 schrieb Shane Xiao:
> [Why]
> The selfring doorbell aperture will change when resize FB
> BAR successfully during gmc sw init, we should reorder
> the sequence of enabling doorbell selfring aperture.
>
> [How]
> Move enable_doorbell_selfring_aperture from *_common_hw_init
> to *_common_late_init.
>
> This fixes the potential issue that GPU ring its own
> doorbell when this device is in translated mode when
> iommu is on.
>
> v2: Remove *_enable_doorbell_aperture functions (Christian)
> v3: Add comments to note that why we need enable doorbell
>      selfring late (Christian)
>
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> Tested-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/nv.c    | 23 +++++++++++++----------
>   drivers/gpu/drm/amd/amdgpu/soc15.c | 25 +++++++++++++++----------
>   drivers/gpu/drm/amd/amdgpu/soc21.c | 23 +++++++++++++----------
>   3 files changed, 41 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index dabeeab2f2ad..3cc068974bcd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -531,13 +531,6 @@ static void nv_program_aspm(struct amdgpu_device *adev)
>   
>   }
>   
> -static void nv_enable_doorbell_aperture(struct amdgpu_device *adev,
> -					bool enable)
> -{
> -	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
> -	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
> -}
> -
>   const struct amdgpu_ip_block_version nv_common_ip_block =
>   {
>   	.type = AMD_IP_BLOCK_TYPE_COMMON,
> @@ -999,6 +992,11 @@ static int nv_common_late_init(void *handle)
>   		}
>   	}
>   
> +	/* Enable selfring doorbell aperture late because doorbell BAR
> +	 * aperture will change if resize BAR successfully in gmc sw_init.
> +	 */
> +	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
> +
>   	return 0;
>   }
>   
> @@ -1038,7 +1036,7 @@ static int nv_common_hw_init(void *handle)
>   	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
>   		adev->nbio.funcs->remap_hdp_registers(adev);
>   	/* enable the doorbell aperture */
> -	nv_enable_doorbell_aperture(adev, true);
> +	adev->nbio.funcs->enable_doorbell_aperture(adev, true);
>   
>   	return 0;
>   }
> @@ -1047,8 +1045,13 @@ static int nv_common_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	/* disable the doorbell aperture */
> -	nv_enable_doorbell_aperture(adev, false);
> +	/* Disable the doorbell aperture and selfring doorbell aperture
> +	 * separately in hw_fini because nv_enable_doorbell_aperture
> +	 * has been removed and there is no need to delay disabling
> +	 * selfring doorbell.
> +	 */
> +	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
> +	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 4d1487a9836c..3221522e71e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -619,13 +619,6 @@ static void soc15_program_aspm(struct amdgpu_device *adev)
>   		adev->nbio.funcs->program_aspm(adev);
>   }
>   
> -static void soc15_enable_doorbell_aperture(struct amdgpu_device *adev,
> -					   bool enable)
> -{
> -	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
> -	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
> -}
> -
>   const struct amdgpu_ip_block_version vega10_common_ip_block =
>   {
>   	.type = AMD_IP_BLOCK_TYPE_COMMON,
> @@ -1125,6 +1118,11 @@ static int soc15_common_late_init(void *handle)
>   	if (amdgpu_sriov_vf(adev))
>   		xgpu_ai_mailbox_get_irq(adev);
>   
> +	/* Enable selfring doorbell aperture late because doorbell BAR
> +	 * aperture will change if resize BAR successfully in gmc sw_init.
> +	 */
> +	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
> +
>   	return 0;
>   }
>   
> @@ -1182,7 +1180,8 @@ static int soc15_common_hw_init(void *handle)
>   		adev->nbio.funcs->remap_hdp_registers(adev);
>   
>   	/* enable the doorbell aperture */
> -	soc15_enable_doorbell_aperture(adev, true);
> +	adev->nbio.funcs->enable_doorbell_aperture(adev, true);
> +
>   	/* HW doorbell routing policy: doorbell writing not
>   	 * in SDMA/IH/MM/ACV range will be routed to CP. So
>   	 * we need to init SDMA doorbell range prior
> @@ -1198,8 +1197,14 @@ static int soc15_common_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	/* disable the doorbell aperture */
> -	soc15_enable_doorbell_aperture(adev, false);
> +	/* Disable the doorbell aperture and selfring doorbell aperture
> +	 * separately in hw_fini because soc15_enable_doorbell_aperture
> +	 * has been removed and there is no need to delay disabling
> +	 * selfring doorbell.
> +	 */
> +	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
> +	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
> +
>   	if (amdgpu_sriov_vf(adev))
>   		xgpu_ai_mailbox_put_irq(adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 7d59303ca2f9..0f82b8e83acb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -450,13 +450,6 @@ static void soc21_program_aspm(struct amdgpu_device *adev)
>   		adev->nbio.funcs->program_aspm(adev);
>   }
>   
> -static void soc21_enable_doorbell_aperture(struct amdgpu_device *adev,
> -					bool enable)
> -{
> -	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
> -	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
> -}
> -
>   const struct amdgpu_ip_block_version soc21_common_ip_block =
>   {
>   	.type = AMD_IP_BLOCK_TYPE_COMMON,
> @@ -764,6 +757,11 @@ static int soc21_common_late_init(void *handle)
>   			amdgpu_irq_get(adev, &adev->nbio.ras_err_event_athub_irq, 0);
>   	}
>   
> +	/* Enable selfring doorbell aperture late because doorbell BAR
> +	 * aperture will change if resize BAR successfully in gmc sw_init.
> +	 */
> +	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
> +
>   	return 0;
>   }
>   
> @@ -797,7 +795,7 @@ static int soc21_common_hw_init(void *handle)
>   	if (adev->nbio.funcs->remap_hdp_registers)
>   		adev->nbio.funcs->remap_hdp_registers(adev);
>   	/* enable the doorbell aperture */
> -	soc21_enable_doorbell_aperture(adev, true);
> +	adev->nbio.funcs->enable_doorbell_aperture(adev, true);
>   
>   	return 0;
>   }
> @@ -806,8 +804,13 @@ static int soc21_common_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	/* disable the doorbell aperture */
> -	soc21_enable_doorbell_aperture(adev, false);
> +	/* Disable the doorbell aperture and selfring doorbell aperture
> +	 * separately in hw_fini because soc21_enable_doorbell_aperture
> +	 * has been removed and there is no need to delay disabling
> +	 * selfring doorbell.
> +	 */
> +	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
> +	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		xgpu_nv_mailbox_put_irq(adev);

