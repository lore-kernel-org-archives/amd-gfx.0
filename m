Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C8AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 10:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 728C110F95F;
	Thu, 28 Apr 2022 10:27:47 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D7610F960
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 10:27:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDpbNuaCD1V/vWyIPEsUH/OPwRyh8RRFkoQBksVTJTvN6/uCoVOI181lHxqTVhLdMgTrkX8eDg8SQGNKACz4q/nTXmsGet55JHOQvOLxAGtL/bfEfSZlR41xliJ6ChLhniBUupzalPxrnNNIElMP7DUhICk3bJE8OGoFcHu603op2lJK6PLcmBgOIiSY5tDuFKl7SLu4FmC7VmNEpAx8HZuXzZFC1OQ5O8EdmeCtcu8RiaHl/xeSpfj+pYoNN8pxiL24lGQrBNaXsxFg72V2OP6DO1Q8ykVLnE9qfOjMTs0Fa0qIPq5MblJib4n4/jFODFjZnaCc/cYsu9ZLYB61Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8JbBInkcFXPTBM5DVCPFKgGqSHi4LmQ7gLY3hGc6As=;
 b=MDkQFx06kQ8JWS4wm4WJ5kp27Z2dmLtRRDAp3DKXz7HdvKXdapmeeyam4GuYaH/zme4UFJc/lvsjxS6DiaOxJKo4rHAVdOp+IwptT/rtz+sKQhl/SwbzubHdRQHHnqj9jBPa1DNnIrUtKXHb3kEzZHC4l503ebniLt0b0DJVdSjglQlosnEVapv0StTzkOAYy28cvRFy4bajeLPk0+H8CDmoQBxOfJxS+tbJEtKL5pVPuv0EN7Q1jD8BXqhkb25aqeuTG1hVXBVw9kY6tFXfDQAu1tZjWlaENJnC8haCWbYs/F08FxCP8GyOCMfjA0eiaxmMC9CpbFvxodgmBqPTPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8JbBInkcFXPTBM5DVCPFKgGqSHi4LmQ7gLY3hGc6As=;
 b=PwuIITB6g6Jy5JGQYU9Bn+9XZdQAt66CVF3lPoqW2bAvv6Z/Ao2TSo5dQ9SIEFSiHaXDGSiLFbxT5KBfxHKS/b72HsL1fjYi4FNym0PHZLdV5Py0LVPkkiGYZJ+jauqpaaCJeCPphh0E2xnMCIOEYQFX+HGxwhXgbiHZfARGK7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Thu, 28 Apr
 2022 10:27:44 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5%3]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 10:27:44 +0000
Date: Thu, 28 Apr 2022 18:27:35 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: ricetons@gmail.com
Subject: Re: [PATCH v4] drm/amdgpu: Ensure the DMA engine is deactivated
 during set ups
Message-ID: <YmpsF4F109J3+zzH@lang-desktop>
References: <20220428095327.10513-1-ricetons@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428095327.10513-1-ricetons@gmail.com>
X-ClientProxiedBy: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dfd969c-c5d1-4e8b-6a05-08da2901bb22
X-MS-TrafficTypeDiagnostic: MN2PR12MB3775:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3775E263E6E50AAF32AE418FFBFD9@MN2PR12MB3775.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PUxyUC3kr/XP3Z9zkdCOueDycdw4aDTd/I1vsXq8haRLOliIp/A7+oAARszLoXHW3opFPvz5HzwAhbHN2vjiJzjyd5FykYIzgfFNDeFeJZKctofouz6YwI0SiWJA2YxR/AukPNY145cxWYCROnqLgnCPXUXadxozus+xHzGUvvYVkQoeWZVgvHILGNhm7mPYY0qLoM1rNlbMF+Azm1hQ3zuzhn5aMxCwarCcvyUeuhwl5xYh2jHaG/trCg790mzME09/xmIPW3ydigU03qXm78oHsDkPbdZSb+1eIRSv3gXIRaveAUND2RCXiE8svAeRWhFD2hZXilcXHv/i0/tUUmpSDtbc1bftIoAE8tD/CzMvW95L8SEsWfRnci2pCLp7sbJAW56bHxDu8gvulST3ORYVhobgao/DdycdxW64wWsmWEiYakb2BIp/tPpn5di5buiCHahXni3NVCw/95REl4xuxNMlQRPuDiY7pnbLbi6tOTknSnHEZmojx7jY2o9nGmQj2ghR+Xwon7nj5R8FErkjI7Ttb7jC/312jKraWofHblIo3dKOZJzYsAFB6n12EGaSVpyrQgCme/dUpS80XmGq4edNmVb9AJTk7aEekAhnfEW2jjWMdeYXpwVJQAxL/+BNyLb0vqQWwSjshQNRlyQ26ULNtRib+WnG+VP6xe/GMxwIDsytwqV3Ol6miIgSVbKtIA0pYsxWSlvEc+tUkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(4636009)(366004)(508600001)(8936002)(9686003)(26005)(6506007)(6666004)(2906002)(6512007)(33716001)(38100700002)(6916009)(186003)(86362001)(83380400001)(5660300002)(66476007)(66556008)(66946007)(4326008)(8676002)(6486002)(316002)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kAxff4L90/WSpW+ZAGI6oNRm96ooOrVeIS/6R/eKkrNCLxWSaOry6O5MpUXs?=
 =?us-ascii?Q?k/uRbDpMHFYM4NO2kV/yzS6B+RZd6e++C2C6oihuqhm6tV7zVYQ0vtk80J3V?=
 =?us-ascii?Q?pgC82bgI2415fUI43NnPCZzVIL+A+dAWJR3e21QS0M9bELkOtE7A+fyh5bdF?=
 =?us-ascii?Q?EGDckEGDlZ1isCDXAwnmvZdFdlIDQVPndV3M/IjkVQmAyPAIWmHUS1hdkqzm?=
 =?us-ascii?Q?qFxm/stzwp/zJwsmmtbTNN7zm0l280NwDzN7sg50lVr4+9E+uBoIClWmFCGI?=
 =?us-ascii?Q?fiv2IdLLr7dU8HswgyxT9rlJarMmlhtw3+d/Vu+xkuXimDmsw+05+kksC3tO?=
 =?us-ascii?Q?yqUgucRCS9epY8bgIvJ/FckSoU38injBgCHPJiU7zMTIg33AX9xVpZ7Z2xHw?=
 =?us-ascii?Q?epLNjdtpzPIJ3pNjUhF3hvUH1st51aTG5UIGhB7lddyj77K16plDv6KAI8mh?=
 =?us-ascii?Q?TrmcRTObx6AACtTzDGNJmBH9Snm3AYUpalgUmITUnhE+heWwKDDmAjGSr46F?=
 =?us-ascii?Q?EF1UaYKq21r94pZm+pksLziRLxbViff8u+PeRvEZ7K9sLTmi+ANQ3/THi7eh?=
 =?us-ascii?Q?N6+b4gjWfwzYGS7TbgquGW770dw0eddt4h1kKYHEdI7m3KWumy8f2E0NmT3f?=
 =?us-ascii?Q?bSj0Ygj1iN+bbGdovjW5Fdbif4y0dFISr6DItfoB85/qsIx9KgWVWxc3rGTX?=
 =?us-ascii?Q?vyqyV8Hs8JDNuk85txByWu/lNPf+7ChDGaaubarp3WMHTjA8z7a4OfcoNRUb?=
 =?us-ascii?Q?8+MYOUc9fge/BjJmpkAyqdAAfLIhiswk/XarhvHn69BP05HWADWUX7z+1jcb?=
 =?us-ascii?Q?g8pG3DdaTZCl4Zrvs7FoyUbNkmSmXhbo6oy0iWw8JZR23EpyH7VvwtKiBexL?=
 =?us-ascii?Q?GXhU4hZpG6VGEk/K/jv1/75lOgE2DSsdsTLcC/11h9bljNa2iyBq8ApBfsGG?=
 =?us-ascii?Q?MrrMpx9ZblxwBNYcAp25HQ/jYbUFvdPSz/pjdN9pGc+PkySSA7R1Frfv7TOG?=
 =?us-ascii?Q?8LvUQSMRHOnuQP2+TPtzW3+qBdJyXWMGyKXokp1HaD045/NrI3+gbnNCg3nh?=
 =?us-ascii?Q?eD2KixqIDCeva1B5q+HIXJ9cHDbCMIEJniqPxoL8hF/xtdMXUc40IfinTod1?=
 =?us-ascii?Q?8K3CkF9Dxjnd7Xx3QfPAKrPG4IpJfFlWVX/lFAAT9vj4kp+0upOYYvJ5EZ5+?=
 =?us-ascii?Q?kACYOLw1rGyYyLWy3Sz/YXz3t6ZqKG1JiAHwhupP9PW1Ct3AnbILTdx7oqMM?=
 =?us-ascii?Q?3E/x7knykRL/ORwOcTILLM+Jfm30nr/vPhZFJR+CRXbBH7OnQP3QZoBYI9Cj?=
 =?us-ascii?Q?NfETD33zI5vYxBRcq7YC8Tfza4aZLLkAOCb2YiWlzw0Bi+Sxe90eH8xBc0ii?=
 =?us-ascii?Q?a8cMEi32AP+OMzugjacWFgbW1g72aD5NcDUXHffVQYcuLFJaS3REUhezw0a3?=
 =?us-ascii?Q?odCwsEC1BQZOIqmSxoXGbmFlNdkncdeTVctLsKmy9ZU8+boIm+e4HIHhLIHF?=
 =?us-ascii?Q?DzCtJJoPslw6+WAFYgVmvQSPJEAeKEMoJFraDL/DqbU1TJVXchdmkJSU35u8?=
 =?us-ascii?Q?oIzlPHIHXqNyBjnDeryp6r0jxAWgxhdeboXjiecadGmmtaA16njiLMB9Q2i7?=
 =?us-ascii?Q?kvxZggZOcIoIBNxLkrxigHTNa1i0LHcs+hOXyMrN9yAEm02UkTk7V44Bw5GG?=
 =?us-ascii?Q?lASsfiS0hghVX1oJUussQiiiNTcewpv07MQJSRsC0W2bzHRkCakBz6tZHbw3?=
 =?us-ascii?Q?jdZE4NRdFw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfd969c-c5d1-4e8b-6a05-08da2901bb22
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 10:27:44.0928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fCM8lKhNEz4jun5gIgV+hIyKOvtqFZCmHJNaTWZMNI+e06aSEg9NKdqMJ/2gZ0hwMVrRCzJvjmgPL7U3P0K7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3775
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
Cc: ckoenig.leichtzumerken@gmail.com, Hawking.Zhang@amd.com,
 Guchun.Chen@amd.com, amd-gfx@lists.freedesktop.org, yifan1.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 04/28/ , ricetons@gmail.com wrote:
> From: Haohui Mai <ricetons@gmail.com>
> 
> The patch fully deactivates the DMA engine before setting up the ring
> buffer to avoid potential data races and crashes.
> 
> The v4 patch addresses the comments from Lang Yu <Lang.Yu@amd.com>.
> 
> Signed-off-by: Haohui Mai <ricetons@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 113 ++++++++++++++-----------
>  1 file changed, 62 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 013d2dec81d0..b000117b77d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -459,7 +459,6 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
>  	}
>  }
>  
> -
>  /**
>   * sdma_v5_2_gfx_stop - stop the gfx async dma engines
>   *
> @@ -505,17 +504,21 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
>  }
>  
>  /**
> - * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
> + * sdma_v5_2_ctx_switch_enable_for_instance - start the async dma engines
> + * context switch for an instance
>   *
>   * @adev: amdgpu_device pointer
> - * @enable: enable/disable the DMA MEs context switch.
> + * @instance_idx: the index of the SDMA instance
>   *
> - * Halt or unhalt the async dma engines context switch.
> + * Unhalt the async dma engines context switch.
>   */
> -static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
> +static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_device *adev, int instance_idx)
>  {
>  	u32 f32_cntl, phase_quantum = 0;
> -	int i;
> +
> +	if (WARN_ON(instance_idx >= adev->sdma.num_instances)) {
> +		return;
> +	}
>  
>  	if (amdgpu_sdma_phase_quantum) {
>  		unsigned value = amdgpu_sdma_phase_quantum;
> @@ -539,61 +542,71 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
>  		phase_quantum =
>  			value << SDMA0_PHASE0_QUANTUM__VALUE__SHIFT |
>  			unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
> -	}
> -
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		if (enable && amdgpu_sdma_phase_quantum) {
> -			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
> -			       phase_quantum);
> -			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
> -			       phase_quantum);
> -			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
> -			       phase_quantum);
> -		}
>  
> -		if (!amdgpu_sriov_vf(adev)) {
> -			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> -			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> -					AUTO_CTXSW_ENABLE, enable ? 1 : 0);
> -			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> -		}
> +		WREG32_SOC15_IP(GC,
> +			sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE0_QUANTUM),
> +			phase_quantum);
> +		WREG32_SOC15_IP(GC,
> +			sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE1_QUANTUM),
> +		    phase_quantum);
> +		WREG32_SOC15_IP(GC,
> +			sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE2_QUANTUM),
> +		    phase_quantum);
>  	}
>  
> +	if (!amdgpu_sriov_vf(adev)) {
> +		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL));
> +		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> +				AUTO_CTXSW_ENABLE, 1);
> +		WREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL), f32_cntl);
> +	}
>  }
>  
>  /**
> - * sdma_v5_2_enable - stop the async dma engines
> + * sdma_v5_2_ctx_switch_disable_all - stop the async dma engines context switch
>   *
>   * @adev: amdgpu_device pointer
> - * @enable: enable/disable the DMA MEs.
>   *
> - * Halt or unhalt the async dma engines.
> + * Halt the async dma engines context switch.
>   */
> -static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
> +static void sdma_v5_2_ctx_switch_disable_all(struct amdgpu_device *adev)
>  {
>  	u32 f32_cntl;
>  	int i;
>  
> -	if (!enable) {
> -		sdma_v5_2_gfx_stop(adev);
> -		sdma_v5_2_rlc_stop(adev);
> -	}
> +	if (amdgpu_sriov_vf(adev))
> +		return;
>  
> -	if (!amdgpu_sriov_vf(adev)) {
> -		for (i = 0; i < adev->sdma.num_instances; i++) {
> -			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> -			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
> -			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
> -		}
> +	for (i = 0; i < adev->sdma.num_instances; i++) {
> +		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> +		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> +				AUTO_CTXSW_ENABLE, 0);
> +		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
>  	}
>  }
>  
> +/**
> + * sdma_v5_2_halt - stop the async dma engines
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Halt the async dma engines.
> + */
> +static void sdma_v5_2_halt(struct amdgpu_device *adev)
> +{
> +	sdma_v5_2_gfx_stop(adev);
> +	sdma_v5_2_rlc_stop(adev);
> +}
> +
>  /**
>   * sdma_v5_2_gfx_resume - setup and start the async dma engines
>   *
>   * @adev: amdgpu_device pointer
>   *
>   * Set up the gfx DMA ring buffers and enable them.
> + * It assumes that the dma engine is stopped for each instance.
> + * The function enables the engine and preemptions sequentially for each instance.
> + *
>   * Returns 0 for success, error for failure.
>   */
>  static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> @@ -737,10 +750,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
>  
>  		ring->sched.ready = true;
>  
> -		if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
> -			sdma_v5_2_ctx_switch_enable(adev, true);
> -			sdma_v5_2_enable(adev, true);
> -		}
> +		sdma_v5_2_ctx_switch_enable_for_instance(adev, i);
>  
>  		r = amdgpu_ring_test_ring(ring);
>  		if (r) {
> @@ -784,7 +794,7 @@ static int sdma_v5_2_load_microcode(struct amdgpu_device *adev)
>  	int i, j;
>  
>  	/* halt the MEs */
> -	sdma_v5_2_enable(adev, false);
> +	sdma_v5_2_halt(adev);
>  
>  	for (i = 0; i < adev->sdma.num_instances; i++) {
>  		if (!adev->sdma.instance[i].fw)
> @@ -856,8 +866,8 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
>  	int r = 0;
>  
>  	if (amdgpu_sriov_vf(adev)) {
> -		sdma_v5_2_ctx_switch_enable(adev, false);
> -		sdma_v5_2_enable(adev, false);
> +		sdma_v5_2_ctx_switch_disable_all(adev);
> +		sdma_v5_2_halt(adev);
>  
>  		/* set RB registers */
>  		r = sdma_v5_2_gfx_resume(adev);
> @@ -865,6 +875,9 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
>  	}
>  
>  	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
> +		sdma_v5_2_ctx_switch_disable_all(adev);
> +		sdma_v5_2_halt(adev);

You don't need call these functions here. 

In original code, you can see sdma_v5_2_load_microcode() calls 
sdma_v5_2_enable(adev, false) to halt the engine before load ucode.

What I mean is sdma_v5_2_halt(adev) should have no functional change with 
original sdma_v5_2_enable(adev, false), like this,

static void sdma_v5_2_halt(struct amdgpu_device *adev) {
	u32 f32_cntl;
	int i;

	sdma_v5_2_gfx_stop(adev);
	sdma_v5_2_rlc_stop(adev);
	
	if (!amdgpu_sriov_vf(adev)) {
		for (i = 0; i < adev->sdma.num_instances; i++) {
			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
		}
	}	
}

But you remove the codes to set the HLAT bit of register mmSDMA0_F32_CNTL.

Regards,
Lang

>  		r = sdma_v5_2_load_microcode(adev);
>  		if (r)
>  			return r;
> @@ -881,12 +894,10 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
>  		amdgpu_gfx_off_ctrl(adev, false);
>  
>  	sdma_v5_2_soft_reset(adev);
> -	/* unhalt the MEs */
> -	sdma_v5_2_enable(adev, true);
> -	/* enable sdma ring preemption */
> -	sdma_v5_2_ctx_switch_enable(adev, true);
>  
> -	/* start the gfx rings and rlc compute queues */
> +	/* Soft reset supposes to disable the dma engine and preemption.
> +	 * Now start the gfx rings and rlc compute queues.
> +	 */
>  	r = sdma_v5_2_gfx_resume(adev);
>  	if (adev->in_s0ix)
>  		amdgpu_gfx_off_ctrl(adev, true);
> @@ -1340,8 +1351,8 @@ static int sdma_v5_2_hw_fini(void *handle)
>  	if (amdgpu_sriov_vf(adev))
>  		return 0;
>  
> -	sdma_v5_2_ctx_switch_enable(adev, false);
> -	sdma_v5_2_enable(adev, false);
> +	sdma_v5_2_ctx_switch_disable_all(adev);
> +	sdma_v5_2_halt(adev);
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 
