Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835AEC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 15:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D0D20848
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 15:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="E8UCk0Ck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D0D20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 552386EE2B;
	Fri, 16 Oct 2020 15:57:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F8626EE21
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 15:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFjE+Bib3ALiFc/Z4j1NDzvGifhbTwuiKsvtHJHIJo0kFPQkHDnKiVfq0WcdUe9rFDv1oShVPelvrxwXeUd+VsPDW5+uCpwPqX/9v6s8KcYKYV+Ff3ImCqDsxHJxSiioPu2VQYRmr/KfWDAH4EUnRkqnflE1Cp/doYXd4lX5OJ4nO2DU9p3PtGpZpm6rPi+99j4EW/JD7oxViNVd3j411S/RQ1+Sl6pgOmimQQfVp57KEhTA0hfUP0rryVPo6iwZVvInFISvxnMQoX7f89A9mZSaZQLkXa7A9hU9MoVp/rXuHDcnBjmvN8KTfLkXZqAA8ViXMRULnmj9cNOqrVwD2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYf9KR3i8OCdoMNc9TzyHOD+JFehiYdO2Ht0cVjZ8FQ=;
 b=XpeRVhMXhbbQ8vYK7shX49ZodZf13gdD3hoJD8Sw0HbdB2pTEWSb/vWytr3UtwrSJh/xcLK+dXRSgxHi8Z/Mgpxo7gH+Rfv6WAIhK9k2EewGvn/Gi007ht4ss0JcusLzgzrKnkgj1cLimYhtkuLdKhVUzH7QE+iOq6PodKKESNW0LukkhREYyz9T6THy9RiSvP2HfOvt5Cdpldn4yz/gYhc1up73cHxGuAH7TMw1/0J9+7Zr9DO8aFtvmIBy7pgDuX7wO89oofr3fk0RsUVJw8PerGGq9dP5K6GvTdl+Zq8n9lYyj26Rvd8H1SBUo2McEF/YmofHrxW5lv5rgAgSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYf9KR3i8OCdoMNc9TzyHOD+JFehiYdO2Ht0cVjZ8FQ=;
 b=E8UCk0Ckq0P9awXHM2Izkrco/hycfqYO+HMX309uBPZ0VhBm00ZtwFkLS+w5BEdo8b31t8C7pVJhluFZyE8/W2wrEAtOsrFkFfDvqxuWqnZZFZ/3vfBKyryIhYj3BnTOini/3choLql97V/DlZ4LbEqR0WEFNs4YU8PVI+wjvjg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB2418.namprd12.prod.outlook.com (2603:10b6:207:4d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Fri, 16 Oct
 2020 15:57:16 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%9]) with mapi id 15.20.3477.021; Fri, 16 Oct 2020
 15:57:16 +0000
Subject: Re: [PATCH] drm/amdgpu: move amdgpu_num_kcq handling to a helper
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201016142003.1095354-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <27cd7c0f-062d-1876-4c36-fb95db9bc28d@amd.com>
Date: Fri, 16 Oct 2020 11:57:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201016142003.1095354-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.113.11]
X-ClientProxiedBy: YTXPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::28) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YTXPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20 via Frontend Transport; Fri, 16 Oct 2020 15:57:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c6fbd5fe-532b-432e-789d-08d871ec273e
X-MS-TrafficTypeDiagnostic: BL0PR12MB2418:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2418417D06DB1BF8714997AD92030@BL0PR12MB2418.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C7xjsNNUJXXGROO8VtLxIaWu1e466z0j25tN3f8GjWuH1jyhaHGZj+RBLIZBZPBZnVIP53eX2kmTxbLf8nJDjzTOwEd6Eydsq/BcjwEo5purPp7YiPT9VemdTtMUA5SbD+2u2QE4/kIVGY9juxem0fL0+MwKfl9vctz+fB/hC6TLgFt8VECetPYNavySFVEUHwwygIH+sL/+wY/A8aYEgE5/OHzoehgiwxPh6cZ5dkxFM1n2YTWz8nAoFEYPy+d5m4DRgUGtxNtpCdS/9yBToOaCFsh2NrwEU0nh3DNc2Z+dRRbfX5aGkAKE+dhEQkN+S7pNw6PmOdE0kX3Ej0lVDqxP6ave7nnfIZYdXPHm+erXtJlIg2hZpDDpI5/3tQ2A4cT2x76xDsXGXI+bLfqWyJXS3ELIMpi8d6XNn16FAOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(52116002)(478600001)(5660300002)(316002)(956004)(6486002)(16526019)(8676002)(2616005)(66556008)(8936002)(26005)(186003)(44832011)(66476007)(16576012)(66946007)(31696002)(2906002)(34490700002)(4326008)(36756003)(83380400001)(4001150100001)(31686004)(86362001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: YZHRAex5VntLuXO2rS8W8zDRjacGLGq+wDnMKAqCDc2qn8c5Q2OG/03/SZzpsYdZjfFnWA1umQ9KDpgKUkr+T1J/uwXCUVCS0hZKKdLGEb4ouG7/UV0vYCp+07m3rlDb4Nh7lQ+oXQsSHTtmsIQ7NKp8GiNa/9nu3wAMj/QfsHvhpYWUr19evdb2xgJTyei56n+f6jbEc4fDS6bnql7/18qk2pELBB/sJuP0aFYwtEFdKaIxU67Izn9yVK2HSiKzi02GrSNeA88lAOy9Fc0wGg/S9SfdDoNAxEqgvkh0srJsYs45zK1d6nHiOQDAFj35YCIoHM6B8GXAg0i0SOwZ3xYsaOwDjNf1O818uE24kx8muwaq1os4QOyXvffoag3jEY7lzpW7cfPIUVMoAwifhXMD5p8sgcDKxLD3Ee+RfwJi7ZFxpH/yvYmbeptZhvkhXOAXL2FcU0Te2DETsyPW37H7lwsxQHThjDNxIydU5d9mBBv/eq4Z7Pbcsw6F9Le6P/wdFHTW+uIwiWsuQd6MYqm0Ew37N8nlnvPRItRmE6z14+CujGaDum+LyVg1JkHEGL7TXBRuydg2h692RFJmtAJkEvhTY+NuY0NgjAB0tLkOs/K8H+Tfaic5VfXTwq0AWPl+4zfyh7sNfoDKnX7IxQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fbd5fe-532b-432e-789d-08d871ec273e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 15:57:15.9323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcgXc+uqL5ctOWpNCzO22mC6gDZO3gI6EFEVkgC4DBYAzCcd2XupRGhWyYqg7iOei1ecdhW5U3qOZlyYq+qxCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2418
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2020-10-16 um 10:20 a.m. schrieb Alex Deucher:
> Add a helper so we can set per asic default values. Also,
> the module parameter is currently clamped to 8, but clamp it
> per asic just in case some asics have different limits in the
> future. Enable the option on gfx6,7 as well for consistency.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  7 -------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 11 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c      |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  3 ++-
>  8 files changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index abddcd9dab3d..fb9e61f861e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1374,13 +1374,6 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>  
>  	amdgpu_gmc_tmz_set(adev);
>  
> -	if (amdgpu_num_kcq == -1) {
> -		amdgpu_num_kcq = 8;
> -	} else if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
> -		amdgpu_num_kcq = 8;
> -		dev_warn(adev->dev, "set kernel compute queue number to 8 due to invalid parameter provided by user\n");
> -	}
> -
>  	amdgpu_gmc_noretry_set(adev);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 8c9bacfdbc30..e584f48f3b54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -804,3 +804,14 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
>  failed_kiq_write:
>  	dev_err(adev->dev, "failed to write reg:%x\n", reg);
>  }
> +
> +int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
> +{
> +	if (amdgpu_num_kcq == -1) {
> +		return 8;
> +	} else if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
> +		dev_warn(adev->dev, "set kernel compute queue number to 8 due to invalid parameter provided by user\n");
> +		return 8;
> +	}
> +	return amdgpu_num_kcq;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 190753930b11..786eb4aa7314 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -393,4 +393,5 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
>  				  struct amdgpu_iv_entry *entry);
>  uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
>  void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
> +int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 669c352c27af..b4df472194af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7406,7 +7406,8 @@ static int gfx_v10_0_early_init(void *handle)
>  		break;
>  	}
>  
> -	adev->gfx.num_compute_rings = amdgpu_num_kcq;
> +	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
> +					  AMDGPU_MAX_COMPUTE_RINGS);
>  
>  	gfx_v10_0_set_kiq_pm4_funcs(adev);
>  	gfx_v10_0_set_ring_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> index 79c52c7a02e3..671c46ebeced 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -3064,7 +3064,8 @@ static int gfx_v6_0_early_init(void *handle)
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  
>  	adev->gfx.num_gfx_rings = GFX6_NUM_GFX_RINGS;
> -	adev->gfx.num_compute_rings = GFX6_NUM_COMPUTE_RINGS;
> +	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
> +					  GFX6_NUM_COMPUTE_RINGS);
>  	adev->gfx.funcs = &gfx_v6_0_gfx_funcs;
>  	adev->gfx.rlc.funcs = &gfx_v6_0_rlc_funcs;
>  	gfx_v6_0_set_ring_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 04eaf3a8fddb..cb07bc21dcbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -4238,7 +4238,8 @@ static int gfx_v7_0_early_init(void *handle)
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  
>  	adev->gfx.num_gfx_rings = GFX7_NUM_GFX_RINGS;
> -	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> +	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
> +					  AMDGPU_MAX_COMPUTE_RINGS);
>  	adev->gfx.funcs = &gfx_v7_0_gfx_funcs;
>  	adev->gfx.rlc.funcs = &gfx_v7_0_rlc_funcs;
>  	gfx_v7_0_set_ring_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 94b7e0531d09..6487ea3cfdd2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -5295,7 +5295,8 @@ static int gfx_v8_0_early_init(void *handle)
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  
>  	adev->gfx.num_gfx_rings = GFX8_NUM_GFX_RINGS;
> -	adev->gfx.num_compute_rings = amdgpu_num_kcq;
> +	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
> +					  AMDGPU_MAX_COMPUTE_RINGS);
>  	adev->gfx.funcs = &gfx_v8_0_gfx_funcs;
>  	gfx_v8_0_set_ring_funcs(adev);
>  	gfx_v8_0_set_irq_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 2c3224948ea5..d3df4c0441a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4635,7 +4635,8 @@ static int gfx_v9_0_early_init(void *handle)
>  		adev->gfx.num_gfx_rings = 0;
>  	else
>  		adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
> -	adev->gfx.num_compute_rings = amdgpu_num_kcq;
> +	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
> +					  AMDGPU_MAX_COMPUTE_RINGS);
>  	gfx_v9_0_set_kiq_pm4_funcs(adev);
>  	gfx_v9_0_set_ring_funcs(adev);
>  	gfx_v9_0_set_irq_funcs(adev);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
