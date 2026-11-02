Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957BF606A32D
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 04:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Q9UAgGSa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EACD10E50D;
	Mon,  2 Nov 2026 04:33:08 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D41BA10E50D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 04:33:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbYtOxynxGoSFp2Vr0Fl37VSKlM2p4vOUU8rDHNuztXChyjLWeYyGnpwiBwHergEF7iLP6NCWEf1OTlPyOqrpVUyVeEp2/4Y7WgHyVZydv6XswKnawTjkqoAbM9tf91E/aZcCKR5ZEWExxVkSa3DBkUzLUuUDMKh22o83YxDJtwG4VydLniqAkJ7V2Y8HFu8t4VevHo06ephTBnb+MEW6DgSxLMPSEAMJDplc5lv6xLW7Z7AkQARGqclG+ozrAw3hVuxg+vrMaYvul/PfNPXBzZtN9eyW/rTgqWIviS3TlAgNfQ5N3m3zgbI4oM2K8fwaWZ2fNSicBwV9tpM4rJ5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDFRG/O68BkbNXzrwp2bUuhlLhQPh3ZxXwAFi/tT5Ao=;
 b=dw5sRk4qCuDt4gDSUiwACmSmZEIkB8uNwMmobdtg7SpfKARBgudXoQhGpvBcrDJ/Nc9aryvxPeP4fK2vnxfhpb+StKWivYcdCSbNF5FQjOPy/llt4VmZYd1pQXTo9/z3PYAToregiM2y9L9kNOF32+JbnuWqPZc33mJ5jYZdc99tAgbPlZ26c5bu/8pvB7qspORCEGgbW2ANu1s99JKMbjzHpky+I2imu2uXAYgtSxrZAfdpJ4qDxk0nUSebQIIHWl2U6o9ushrmTHMLApeXrT+loVP20E6/V8xPHp0l3Pr8Ih7tIlyc72wLQS1WFDtbiNAltbEPkCk5q3J19QqXdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDFRG/O68BkbNXzrwp2bUuhlLhQPh3ZxXwAFi/tT5Ao=;
 b=Q9UAgGSaWGiUwzYKOg5XPHJYBivrLXXFXkG3q9g8/Q8ChzYGeoDmafPoJEGqeELJU/4DeosI17yquqGF/8BcqGZBbgICc5xPLAQvP+C6lIaWN4vyuCTbM/tYnnM8RYJAdL87iR69P1sYF27Xh0pH95nKJqtUJVutHbXML0vrmP8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 04:32:59 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 04:32:58 +0000
Message-ID: <3a518d91-c6ef-4fbf-8525-5a762d465ccb@amd.com>
Date: Mon, 2 Nov 2026 10:02:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the HBM
 aperture is missing
To: Chenglei Xie <Chenglei.Xie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Victor.Skvortsov@amd.com, Zhigang.Luo@amd.com
References: <20261022153132.211631-1-Chenglei.Xie@amd.com>
 <20261029180652.213481-1-Chenglei.Xie@amd.com>
 <20261029180652.213481-2-Chenglei.Xie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261029180652.213481-2-Chenglei.Xie@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY1PR12MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: 656a9743-f8c7-4ee5-285e-08df389a5f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|11063799006|4143699003|56012099006|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: /IXsgg9ZEE0dU4kR6Q7LW2LOhwGYisqg81U69haV3k1Zya03Mo4VmNM7uFx3QWAKx7LvJggch41yv6bJcrN6dsFDyb7btdIicd9X4ZD+rVfXC3Fwt9stONxqqp9dd8NmBI3oerwGVZBW+ozUvwxopnnwt+J9fy535oDnyQtLYDda5YkUaY18GJW4+DuCsiWpfmCjNssvQmQIG3n4ULRuBcvBqT0awy7hsoLXXXNLJde709g9dVTW7QZuAJTyhEEZmOPO0hDvZ9YrPLDtUTCOh3DnFjXH7wa8S7tWcsfnaviPKyE7uBGtySL7jpFr9fuP/ASL9npejq5ZaPRIaZf1Bx9yG0+9QVmTqIWixP3HJTguXkRZR5Fc/Aq4Dtf1TBOXAsG6s9L7HrzBRmaScSEk7iLr5Ej4f4b1AqFNLDv4Gzk/u0B/Js2kLxTZjwzj5OQUnwtBFO4bZbgVcQNTMLU8E/ofliZeTXqlFWz31T5cRodet+9JiqvmZfY1W5rUHH0PV9RNq9E5FA6IZ4ykI/7A/aCayR1l9VBJnu5Hu4w+/5GD7i0XIwEnY8+KwQIGhnZCezS2OFjkmziBHU5SIxWZRo0o2FBVucTiZBvbEqPWFWFN0OWUOGEJbPDubtQvzhcW0579INdyNiRSMrLs+VJycImo4WYc5uSsnEuzK6772aY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2tSaSt6WDUwQWlleEt5TTVlcU5oSFhSc1FRd1JxVHkydloyRWpuak52TVU4?=
 =?utf-8?B?NGNORzR5WTNtWHlYMzIxVE5iNlV4QlAybmJoeHB1cVhWUDdySGE0YTlTY0RI?=
 =?utf-8?B?cGN3cGdNNi9yblBjYkNPYkVpZEh6NXZiWUtpeVF1cVB0K0RuQkRYZ3pBbHg4?=
 =?utf-8?B?RkJSVjFXaXVZREJyaGY3bXRHc0dpYnJPRmRHYVl4K0R4a293cHRwajJ2Y2pa?=
 =?utf-8?B?Z0NSZzVTR3l1bEZNN2V2dmF5RXlpTkQzeUprVm9Rak01aFF2WU8yeFN2RDRo?=
 =?utf-8?B?b2FJWGpNc0tmWkcyZW92WmdVcGN4dTJQMUhXdU5wT2xIUkhGWW9HU0RudTQ0?=
 =?utf-8?B?c3pGaW5QN3M2MncxNDgyTjJFcklqb1llaUs3azNYRmZCclgyMXo5aHRMSmtC?=
 =?utf-8?B?NkUrWGZtN1VlMm0wV201QTNRREhXQk5NZno4NERVU1ErWlVNY2JWbnpWMVlI?=
 =?utf-8?B?SFUvall4NXJERkZuanY0T3VsRHRiZlNPa1B0Vk0yejlTUlljWWdqb1plZ1pR?=
 =?utf-8?B?U3orVlowUGRkZmpzQUlNNWJIWGNlRzhXUUg1QWxDUkZBNHIwVk90MnAwd3Uy?=
 =?utf-8?B?OHpHd3AxMGtXL2pLVVJnQUtXZTJxVjdyaUlWNGR1cXV5UW50NTdqT1JXUFVu?=
 =?utf-8?B?MXRldDk4UEF1dzRaL0hoSTBDdGFVbTJQMHFVeWV0NG9ERFVjZTJUVm51NjFz?=
 =?utf-8?B?cnVyNm15dnZBdVBsY3JENDFZYVhmR01IY3IyV0pDSHBhU0VHbitDWTJ2YU1n?=
 =?utf-8?B?SzJWUktXeitXZ2dJQXRxbmFYbkRTeTg3Q3dNM0xBQ0dIYkk0d3NIRWo5cTVm?=
 =?utf-8?B?WWYvQVFmNVlNWStHQU5IdmliREtpazg3UGJkZEZJeUtJaDgwdGZMeng4ZUdJ?=
 =?utf-8?B?S1Y2TU4zNU9Ca1VvaFlzZy9WanBCWlBXeEZtZE1iTm5iQkRUR1V1eDN1Nkt4?=
 =?utf-8?B?TnY5RWxkbHJXZmZ1UnNjY2hEYWRVczU2c2VTQ3hqZGVrMlZVelBzNlNYajZ3?=
 =?utf-8?B?OEFSd0NRR0NaSHhLMXJjaEk2R29BdWRVR3k3UWNnY3hWSHpweVo1MVplRVlm?=
 =?utf-8?B?dWdjbW1VVnk1dXFRaDdqUGllTXhnWWdTRStlL0hMd0c3b2s1aVEvcVAwVk9m?=
 =?utf-8?B?V200WU8xOXY2MWF3MDZYN3d4eExlVmFkT253OXFGM2hweVNwU3VUL1kxMXlt?=
 =?utf-8?B?bUZYdE93dGJvWWVwNGlSRHptTTljOEpDdjhlcG55Vks1c2REanBEWXQrMmF0?=
 =?utf-8?B?SUZoYmF1a2xBUTJVK05heEhPUkpWZ3UzUkJNdjE3VkJWbmZ6YUM4K0NyOWc4?=
 =?utf-8?B?a1c2U1BSTWR2d1FsZktXcjJVaDlPeEVaNHlZVUJTREZrdWVLcjNxNDZKN0dr?=
 =?utf-8?B?bzVScjVjdzhnZFFrNG9tNkltWUdXd21mdVJndUxTTDVWdEIyV1RQWDhrQWJY?=
 =?utf-8?B?WkRvUFV6S0p5SEZzVk03RnZyWGVJNFJBK1BNWUdkZUFxamNiYW5INDEyeUdH?=
 =?utf-8?B?dEpZbVZEQ0xEdzZuc1gwako5V1pnaUlMaDlBUjhydDJ3SlRHaEV3SFJldUJF?=
 =?utf-8?B?WjNGUXJ1ZWR4Rnk5bWZ2OGgwRlBqNlF4YUNCQ2ljUFFVc3RCUTZEbVY5dUh3?=
 =?utf-8?B?N056WUVQQXJxWnNEZ0FFWEc0VjFuVk84VzRmUU9GSkdQMXVvdk5hWnRMMGl6?=
 =?utf-8?B?OGFEdVl0TUtwcDZhWDQ4REFYb1lqUTlKUzVPQy9kTzJNd3dldDJiTnFyRGZy?=
 =?utf-8?B?d3hlOGxrci9XSHBHV3lVaTE4YVV3Y3phWDk4MzZROEpYMzRTRCtOQjhWTE52?=
 =?utf-8?B?Z0Roa1hyTmg1MHkwUk84cjY2MHJnbXZybWlQRXlCSXQwMXRLaTVzSjE5djRx?=
 =?utf-8?B?RXhHTm1WbVNCajFwTjV1bmoreVVFNmtEUWdUckQ1empjMFNLbFh3MHlOUnRj?=
 =?utf-8?B?eTY2OGlkQjFsdzVDbml4b0RCc2VFWG1wZTJuNkpPb3RHNE9LZ21xSHZyOXBH?=
 =?utf-8?B?UGpBWVpWUldSZGxCZkJSVDRsSXdhTVJlYm1vdklSb0VjcTZ4MkFyQXErdVkz?=
 =?utf-8?B?UlNIVDF3U1JSN05tUXgxdGRBbTFrVGNaNmVzMnE5THN0MXlZNkF1NTZMMWhp?=
 =?utf-8?B?RkJxaStHY2FmRzFWZWlmRE13RTFwWFpPRHE0SWF4SS9lRHhmTzgya3BRK1hU?=
 =?utf-8?B?UDNwdHFhOUNRaXAycWx3SHY4RmxxU0t5RzdBK1JaWXdxZ1FvcHVDeDhMcXdy?=
 =?utf-8?B?dzBaQVBTaG54a29CV1FBWVRKcVhxRUdVZzZieEcwQTdXSjdGTGJQbzZhNGFi?=
 =?utf-8?Q?g73KAEAzyActGNWh36?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656a9743-f8c7-4ee5-285e-08df389a5f4f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 04:32:58.6940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQAy7ZwtlQOpbhoyimOytxtd5HRoarJu+X6M2aSSBf1ii7CIZ9eJ+uZSBj7udLEK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9601
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



On 29-Oct-26 11:36 PM, Chenglei Xie wrote:
> An SPM backed VF has no FB BAR0 and gets its HBM aperture from the ACPI
> SRAT. When that entry is missing, amdgpu_acpi_find_gpu_memory_in_srat()
> returns -ENOENT, which the early init IP loop treats as the GMC block
> being absent. Init keeps going and dies later with a confusing -ENOMEM
> instead of the real cause.
> 
> Return -ENODEV from gmc_v12_0_early_init() so the probe aborts at the
> point where the aperture is actually missing.
> 
> On a legacy host the VF already holds exclusive GPU access at this point,
> and the early init error paths returned directly without releasing it, so
> the host timed out and FLR'd the VF. Route these failures through a new
> err_release_full_gpu label that releases the access the host is waiting on.
> 
> Add amdgpu_virt_deactivate() to clear AMDGPU_SRIOV_CAPS_RUNTIME and drop
> adev->virt.ops, and call it from the same label, so the later fini path
> does not send a REQ_GPU_FINI that the host will never answer.
> 
> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
> ---
> v2: Move the runtime cap and virt ops clearing into a new
>      amdgpu_virt_deactivate() helper and call it from the label. Drop the
>      redundant SRAT error log already emitted by
>      amdgpu_acpi_find_gpu_memory_in_srat().
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 49 ++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 12 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     |  7 +++-
>   4 files changed, 55 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3ced5c18daaa..3b6a3d86348c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1999,7 +1999,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   
>   		r = amdgpu_virt_init_critical_region(adev);
>   		if (r)
> -			return r;
> +			goto err_release_full_gpu;
>   	}
>   
>   	switch (adev->asic_type) {
> @@ -2012,7 +2012,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   		adev->family = AMDGPU_FAMILY_SI;
>   		r = si_set_ip_blocks(adev);
>   		if (r)
> -			return r;
> +			goto err_release_full_gpu;
>   		break;
>   #endif
>   #ifdef CONFIG_DRM_AMDGPU_CIK
> @@ -2028,7 +2028,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   
>   		r = cik_set_ip_blocks(adev);
>   		if (r)
> -			return r;
> +			goto err_release_full_gpu;
>   		break;
>   #endif
>   	case CHIP_TOPAZ:
> @@ -2047,13 +2047,13 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   
>   		r = vi_set_ip_blocks(adev);
>   		if (r)
> -			return r;
> +			goto err_release_full_gpu;
>   		break;
>   	default:
>   		r = amdgpu_discovery_set_ip_blocks(adev);
>   		if (r) {
>   			adev->num_ip_blocks = 0;
> -			return r;
> +			goto err_release_full_gpu;
>   		}
>   		break;
>   	}
> @@ -2062,7 +2062,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
>   	    !amdgpu_device_get_rev_id(adev)) {
>   		dev_err(adev->dev, "Unsupported A0 hardware\n");
> -		return -ENODEV;	/* device unsupported - no device error */
> +		r = -ENODEV;	/* device unsupported - no device error */
> +		goto err_release_full_gpu;
>   	}
>   
>   	if (amdgpu_has_atpx() &&
> @@ -2123,7 +2124,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
>   			r = amdgpu_device_parse_gpu_info_fw(adev);
>   			if (r)
> -				return r;
> +				goto err_release_full_gpu;
>   
>   			bios_flags = amdgpu_device_get_vbios_flags(adev);
>   			skip_bios = !!(bios_flags & AMDGPU_VBIOS_SKIP);
> @@ -2131,8 +2132,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   			if (!skip_bios) {
>   				bool optional =
>   					!!(bios_flags & AMDGPU_VBIOS_OPTIONAL);
> -				if (!amdgpu_get_bios(adev) && !optional)
> -					return -EINVAL;
> +				if (!amdgpu_get_bios(adev) && !optional) {
> +					r = -EINVAL;
> +					goto err_release_full_gpu;
> +				}
>   
>   				if (optional && !adev->bios)
>   					dev_info(
> @@ -2148,7 +2151,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   							adev,
>   							AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL,
>   							0, 0);
> -						return r;
> +						goto err_release_full_gpu;
>   					}
>   				}
>   			}
> @@ -2159,14 +2162,16 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   
>   		}
>   	}
> -	if (!total)
> -		return -ENODEV;
> +	if (!total) {
> +		r = -ENODEV;
> +		goto err_release_full_gpu;
> +	}
>   
>   	/* Request full GPU access only for the remaining SR-IOV init work. */
>   	if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>   		r = amdgpu_virt_request_full_gpu(adev, true);
>   		if (r)
> -			return r;
> +			goto err_release_full_gpu;
>   	}
>   
>   	if (adev->gmc.xgmi.supported)
> @@ -2184,6 +2189,24 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   	amdgpu_smu_early_init(adev);
>   
>   	return 0;
> +
> +err_release_full_gpu:
> +	if (amdgpu_sriov_vf(adev)) {
> +		/*
> +		 * Release the access the host is waiting on so it finishes the
> +		 * handshake instead of timing out and FLR'ing the VF.
> +		 */
> +		if (early_full_gpu_access)
> +			amdgpu_virt_release_full_gpu(adev, true);
> +
> +		/*
> +		 * Mark the VF inactive so the later fini path does not send a
> +		 * request the host will never answer.
> +		 */
> +		amdgpu_virt_deactivate(adev);

Shouldn't this be called when amdgpu_virt_request_full_gpu fails for 
early_full_gpu_access case also?

Thanks,
Lijo
> +	}
> +
> +	return r;
>   }
>   
>   static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 576a818db522..a4dd0299fe11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -135,6 +135,18 @@ int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init)
>   	return 0;
>   }
>   
> +/*
> + * amdgpu_virt_deactivate - stop driving an SR-IOV VF after a failed init
> + *
> + * Clear the runtime capability and drop the virt ops so the teardown path
> + * does not issue host handshakes the host will never answer.
> + */
> +void amdgpu_virt_deactivate(struct amdgpu_device *adev)
> +{
> +	adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
> +	adev->virt.ops = NULL;
> +}
> +
>   /**
>    * amdgpu_virt_reset_gpu() - reset gpu
>    * @adev:	amdgpu device.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 3971bcc1ed11..3520af170278 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -471,6 +471,7 @@ bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
>   void amdgpu_virt_init_setting(struct amdgpu_device *adev);
>   int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
>   int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init);
> +void amdgpu_virt_deactivate(struct amdgpu_device *adev);
>   int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);
>   void amdgpu_virt_request_init_data(struct amdgpu_device *adev);
>   int amdgpu_virt_ptl_request(struct amdgpu_device *adev, u32 req_code,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index cd276a138e10..3bb13cfed92f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -667,8 +667,13 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
>   
>   		r = amdgpu_acpi_find_gpu_memory_in_srat(adev, &aper_base,
>   							&aper_size);
> +		/*
> +		 * An SPM VF has no FB BAR0 and cannot init without the HBM
> +		 * aperture from the SRAT. Abort this GPU probe instead of
> +		 * limping on as if the GMC block were absent.
> +		 */
>   		if (r)
> -			return r;
> +			return -ENODEV;
>   
>   		adev->gmc.aper_base = aper_base;
>   		adev->gmc.aper_size = aper_size;

