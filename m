Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446D7C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 10:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF7B410E3E2;
	Tue,  9 Jan 2024 10:44:39 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3293910E3E2
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 10:44:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dF9UHZSldCLvppwntk4aUbe1HorGPPH4IPejwftKqYVFeeo/76IwrFIcRog7xo+4ga/LdFVAvS/z5Yup+QDjGoUCNslNxqTPGja2G2tA3I6JcaWYBRT48anMyhPQJ7AdJD96VZIgieBG+pz/e76wGxDwVfeED7ELvJoezgZs08AKsmTH2PIJWA5JWB5T8fdggsRmobONxSdrsOb5oytDRvErD7Q+1Ko7euZxG20G6O7JjtOlwAem8U5SPZaIocUquL+aGivhCySDdb4xNyhxRRoyw7BOp66ECiayD+4Cgq38YJlsUljhF8Gj3zRphBOklspyxl+NXrO7S2/pd0evmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzM5V7sDULZ1xX0jEO39iFVH7NUiNVHyfkHkZsvXbrg=;
 b=MJQo+7Mrr5Jupe3GlLp4JDV4uNLZ+wwjgd2cEO0/AEpRsnu0foTahCrfZY1gOs+6ra6fA+/yqThkeJw8Re0zDINDW2UeqT7VixLBJBtCjj2mq04HuvWYQ9aJHtZuSnAtGOoVawsYolp9edX0gksCWTuIfjTINkQps2kYjOF/ojDWQRcYc9zzaiQrCf2Nn5pe1H80JdMYOMpJIECtojNsoo84XUfskAKne6ibwtJKFg+RaJ6Jrhv7AHeN9+iiHeo6ZnZweOIODGn0b620N+9F0GeMvx3gvHOAZ2JMHhVsNFCCWRiteVOwslGS3ekXG/7NG6YDsfcY18g72QHyMCWxbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzM5V7sDULZ1xX0jEO39iFVH7NUiNVHyfkHkZsvXbrg=;
 b=ngHNP5bRvRcO+OOhVVwU/Z0i/y3QUJqEz5FFGy79XE9rkQAQkMjATwrgI8ZgNzDemJgoNM9CWsGSFohh4iP2sR2mcSI/mnSS3AjxjbQ4fCbIvdHj6g2iXAH8qvc3XZw0WCw1J2wa818nX57wmO2k+kV2UKLnoIld/54kqXXAt9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Tue, 9 Jan
 2024 10:44:35 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::3e94:f45f:2aa:2fc1]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::3e94:f45f:2aa:2fc1%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 10:44:35 +0000
Message-ID: <a138c6b8-d5b5-4964-8c65-6105eca62744@amd.com>
Date: Tue, 9 Jan 2024 16:14:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: add debug flag to change fw bo placement
 for frontdoor loading
Content-Language: en-US
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240109101359.28362-1-le.ma@amd.com>
 <20240109101359.28362-2-le.ma@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240109101359.28362-2-le.ma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::34) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d436a4d-67c8-44e9-01e0-08dc10fff82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yTd/sN5q1vEfjYmwTFdMmpLJb+Op31RcFs9CJG0vOCyQaVpYeREks4mLqwTt+mhQB6HjxDx/Qw5LHJoexDGtNWs07GulQDWZ1eQo+5NxF+BCssj6MEkqdohXwx6OxNJCZsBk7UgW9WavBsGFu14z5MZu17gM/1w1feQgDMV7NPUVNW4vDkIyEIMnXYlBtUXuD6lPjhibuEYOnyLH6+NRykAreQg4YHEpQs9/ev3wPTGX/24qRkYsgA+OUjLbWpNzqZD9HeZ0HbojWjU+Xo4nDfS141wWsgT4jb9VJ4cpdAHzJr2GtVFSqg4jdgfmi8zsO0KSr14MuJUhnEGa19+hTpLXeG6z9tc4sed4cq3P2bbO8Wd+Kq7A4gy5GhGGbR6INpCPWFVa2psWgOYXWsyhIRYqrfjxLHqQlVHEgKWYhNcTSCILWhATLo5+S8ph5Q05hOBCowVhaudPS+fPo78DnEd10QnKwcXch1tmdDrkevAUgjxYdIBoXW6XgnHO56r/p+408UpQP8UB1MUFF88BC1hYWWLaKuwkr1S360Jh9jm5YAL0P/tbi1894iydp1RjACbQ52Q+aD4xiuY6rZwnGrXZ35hx7Xu1nolJ6UOcuQs7/sei244i68Aj4czEslubOrnfWYD7FT9XreCrXFGIAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(83380400001)(66946007)(41300700001)(36756003)(86362001)(31696002)(38100700002)(26005)(2616005)(6506007)(6512007)(53546011)(5660300002)(6486002)(2906002)(66556008)(66476007)(316002)(478600001)(6666004)(8936002)(4326008)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzlvMDZYVytyc21JRG8vMkt6Y3NJcWhjMkp3MWh6d2RQZWYyWS9BYTVHVUtR?=
 =?utf-8?B?bmtEbkJibFpjeFVVYW5SeEFvdmt6TTdqL2Y1UE1WS3BDL3hGTWc5YVAvUlFU?=
 =?utf-8?B?MFNoMkdYeUpNNGRPV0ZGczZDNEw3WmVTZm83ZHJjTExHVGpwblFYZXMvNlZa?=
 =?utf-8?B?SXVWRU43OWl2RnM1OUdxOHpwOGhrbzdySzg0TVB3QUFXS1doMzVZV3BBYWlG?=
 =?utf-8?B?RHIzcE54TlpFUlpjSXFzRlFabkVxUkI2QXFWTVd5K0lmZ0R5TG44b0xpUWZl?=
 =?utf-8?B?TUQzb2c2bnhjZUgvRHZBOGczOEtJQ3c4OUV2R3BwUjlDKzQwU0ErUGNrNCtS?=
 =?utf-8?B?U21SNC92ZDBzY2N6WTdCYlU4bFM0M0dRN2Ntd1dqcExLVXJqT3BmRFRrQTlK?=
 =?utf-8?B?dUFwN2NvWFZsYm5wdkNLUHRpNm9qbElCSy9LVU5jZ0lsUVNZWGR6Y09DNExV?=
 =?utf-8?B?U25zTW5jZXBCTDJ1YkNhU1FjUmpYK3g5aCtiQWtjdXVrdUJhVitMUFlnOTUw?=
 =?utf-8?B?cGc5em1kTzNUL0FEcHNFcTZjWG5oTzFYdXFQWEFTQmRqMjN5UWJhMHppZkZF?=
 =?utf-8?B?UE94NUcySGV2aENzd1lKVEp5cXI1K0VNU0I0MzhlNjdsbHlRZjFTSCt2dUk4?=
 =?utf-8?B?ZmxSNkVjTE1tMHB6eTlOVmVTdC94Ynp3ZjllempoRy9xWDh0T3RNVVd3TTFI?=
 =?utf-8?B?UStDMXdNcFlwRXYxb2JhN25DOXRMMGJ6d05QbTMwVEtDSUFoNXZacndDWmY1?=
 =?utf-8?B?VGJtcitKdnljeW5JUmpObUF6MURQSjdnODVYa25ldEZ5Mjlvby9oNTdXUnlR?=
 =?utf-8?B?SzRlYVJmYzNScVd0V1A3QVlZbmpmNG1aQjFKck9hWmxGTEE1WmgxSzRQb003?=
 =?utf-8?B?eGtPL0pxbURtM1JYNnZERHhMbWJUdUFTTCsyTUlta3RGdjdwV2VYK3lxRTFF?=
 =?utf-8?B?bnNpRVIrU0NvVkphN2xuajNKQmh6dTBUMkJKYWwyY0RWVkVyUTlCZEZwaWNW?=
 =?utf-8?B?UU1ZRTRxRzRxNXRIYk9WSzNkRFNGM3NQc1poMmV6VUdSRkNvL2lLWjQ4eXdn?=
 =?utf-8?B?c3I2UjZqeDhOUlY3dTBJUWFpc25EOTNCQXhSZkQ2eVZ6NHVtZncrc2d2TjB6?=
 =?utf-8?B?RkRhVDAzWjhyT3Ira3RxSTJabzJoNDFES0JUdlhEKzh6SzN0WU9TWUFHbG5R?=
 =?utf-8?B?T2xEelp1Mko5ZEhOY0kwaWRXSlFNaERKME41cFRoY0k2Yk1BMHRWM3kwaFpj?=
 =?utf-8?B?N1cyd2lKTE4vdkJHUHhIS2xPdFNvNlpvNWE3bG9JVE1WeFNQNUE2RlFLRVdF?=
 =?utf-8?B?Wk1KNkloSjNOdHJtKzhUV1gzdGxWOC9sN3N1WnZyaTljTEZLbFM3cEpVQXpw?=
 =?utf-8?B?eVZLdFB1eWpzcG1TRmlnVUxpRDdpc3pRaHJTaTRhdkFkcFEzZENkS1pHYWtH?=
 =?utf-8?B?dGhGU1RBNGU5NE5PYUM1TTRNTW03clVtTjF6eXRBZytRazdDbGdaTzJteDV3?=
 =?utf-8?B?aXhxNDQ2OVArQ2FxNDZmcmtFajJmd1BNZkpsTHhxQkRYbTVMTkVlSHV6U25h?=
 =?utf-8?B?ZXBzdFN4dDEwcTRpRjhHVStMWTJVUlRUYkJhdU5rTGJMVGpFTVR4MENDVUVj?=
 =?utf-8?B?cm9CMGExTlBlVHJQNDg0NXBjWEFmc3RKVFNiQUNIZG5xV3psbXJKMUl5YkNa?=
 =?utf-8?B?cnFmTXRJYTBPNDgzM1h6QlRLZ2ZkaVk2M3RqazNQbWhnMkJwN1d1elhGNEVC?=
 =?utf-8?B?SzVtT1JvYmdxVGJjdFZGYUYwNHROdVJjWXRHUCtIaXpxNjBDbGxIMHZQK0tE?=
 =?utf-8?B?elFzWnI5dlVnWVJiV09leUZtc0tpbS8wWUx1MzdDY29laVlpRjRROXBvb0JV?=
 =?utf-8?B?cUpGVXM0L25TWlFMcElxVHlxaXBsRVlWZU1Hbkkwcy9iTjM4OGF2Nit0WTlX?=
 =?utf-8?B?TWdsbGtnaXA0RkhYRHJ1ZzdDeFUxQ3VEVkpjaWx4T2g2aGN1dzY2cDAyYVd6?=
 =?utf-8?B?MHBrQUthQXBweXR6MXZ4aGJDb1p3S3ZtWC9tbENSMUZiNDBlbXVJejBJUStI?=
 =?utf-8?B?NUNMY1V5TnVYODdDRHhmVk1yTkNkamE2clkySzVlaWkyUlozWVlmbUFseFJO?=
 =?utf-8?Q?2FElQA+qKPeclamIzWE5mqUfb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d436a4d-67c8-44e9-01e0-08dc10fff82b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 10:44:34.9939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LgI0gMwRd57Z/j8nOpF+YRLX9I36dpnJO9iJgzWci5XixxLdGlwUlRTgACOUp5E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444
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
Cc: Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/9/2024 3:43 PM, Le Ma wrote:
> se debug_mask=0x8 param to help isolating data path issues
> on new systems in early phase.
> 
> Signed-off-by: Le Ma <le.ma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 6 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 ++-
>   4 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 616b6c911767..c740825cf5dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1144,6 +1144,7 @@ struct amdgpu_device {
>   	bool                            debug_vm;
>   	bool                            debug_largebar;
>   	bool                            debug_disable_soft_recovery;
> +	bool                            debug_change_fw_placement;
>   };
>   
>   static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 880137774b4e..3e0e39a1b5ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -128,6 +128,7 @@ enum AMDGPU_DEBUG_MASK {
>   	AMDGPU_DEBUG_VM = BIT(0),
>   	AMDGPU_DEBUG_LARGEBAR = BIT(1),
>   	AMDGPU_DEBUG_DISABLE_GPU_SOFT_RECOVERY = BIT(2),
> +	AMDGPU_DEBUG_CHANGE_FW_PLACEMENT = BIT(3),

Instead of a generic "change", better to explicitly mention the 
placement location of FW intended by this flag - like 
AMDGPU_DEBUG_USE_VRAM_FW_BUF or similar.

Thanks,
Lijo

>   };
>   
>   unsigned int amdgpu_vram_limit = UINT_MAX;
> @@ -2117,6 +2118,11 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
>   		pr_info("debug: soft reset for GPU recovery disabled\n");
>   		adev->debug_disable_soft_recovery = true;
>   	}
> +
> +	if (amdgpu_debug_mask & AMDGPU_DEBUG_CHANGE_FW_PLACEMENT) {
> +		pr_info("debug: place fw in vram for frontdoor loading\n");
> +		adev->debug_change_fw_placement = true;
> +	}
>   }
>   
>   static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 51bfe3757c89..a9f2d33fa54b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -467,7 +467,7 @@ static int psp_sw_init(void *handle)
>   	}
>   
>   	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
> -				      amdgpu_sriov_vf(adev) ?
> +				      (amdgpu_sriov_vf(adev) || adev->debug_change_fw_placement) ?
>   				      AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
>   				      &psp->fw_pri_bo,
>   				      &psp->fw_pri_mc_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 0efb2568cb65..8d36a7c1c789 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1062,7 +1062,8 @@ int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
>   {
>   	if (adev->firmware.load_type != AMDGPU_FW_LOAD_DIRECT) {
>   		amdgpu_bo_create_kernel(adev, adev->firmware.fw_size, PAGE_SIZE,
> -			amdgpu_sriov_vf(adev) ? AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
> +			(amdgpu_sriov_vf(adev) || adev->debug_change_fw_placement) ?
> +			AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
>   			&adev->firmware.fw_buf,
>   			&adev->firmware.fw_buf_mc,
>   			&adev->firmware.fw_buf_ptr);

