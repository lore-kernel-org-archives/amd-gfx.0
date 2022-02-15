Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64A6C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 07:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59A0410E386;
	Tue, 15 Feb 2022 07:10:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76F3710E386
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 07:10:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2WW1xObMpOO47/+rIl/1ZPCqNMviTe2bkljxrjw7zvGPh3zPQW/9uwZviLVYoTR2VELgmfnWUpcLa56QxgVB4GrFbCMYCCew1/Ejd17JsmwPN7AxCsgQlo79jDih9pPTVnS6hsqp6nMjoe6ZFBH/b7SjkGVMWt2MdVu1oLSSznXjr6Ua2mccOjPA6VCaTRwRipP0yrH63GNG9gRelg0VdIMMHwPwlvrGSLa4Bb9ytN+QX47tVoCfYD1lt/OlLJMWuP92bPLQ5qJofn9uw7GOYL/89Z/lXv4grzmqXXllcmTY49jihI9+LLFLr+0dHHrKIdtQ7ZbOUSv4DfaBJsiEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk9ThF3mc2h+e+n5QI/MuWDanZaWSZEYqhTITpvuBBE=;
 b=T4M3i8ziYcqHH/AKC6UCtDGeyXEvd6cPqGPk0q9hc6Jn9fVklnroIoPXXYXBzvEq51B5xdFfSHKupRyNZeCQnxSijDX4vG6l4S9VAPSBSqccVM2A6Yx/HTtF8Uw67/7BB9Lm/dTE1DWLB5qf1BU02ETVftaGfulv27s5u+4OcxTeqe9Wa0g2U5qQJ9ZRLue3eNOdbRRBeEgIq2tbpKashtFtIX5duQmjmroQZTvw1JAbsZWCmBRqznrbpzTjNt2z5wzOtQii8TCITaRztG6u1VfZnhQQ6Uwu78Pdla36Clm6eYV4bZBTDI9DGI2bNHHSv5rhx6b5Tg3/sLkjLaoj0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk9ThF3mc2h+e+n5QI/MuWDanZaWSZEYqhTITpvuBBE=;
 b=QFX6TFWBDWvEcmZ+6ue9XOUXU4uhoM13PUmt51ITSx3WYNYuPQCXckFI2IIvHRDVMPMrGY1J9OEclucXpL4bKij4qh5tNjUtnknmyK8k5GISLkTp5IyEHcARHA9xSFJy0pyWSYOneCYmy1dAPumDtAPlT/iJh0M1CFaqC1UwuyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM5PR1201MB0121.namprd12.prod.outlook.com (2603:10b6:4:56::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Tue, 15 Feb 2022 07:10:52 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1%5]) with mapi id 15.20.4975.017; Tue, 15 Feb 2022
 07:10:51 +0000
Date: Tue, 15 Feb 2022 15:10:30 +0800
From: Huang Rui <ray.huang@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: make cyan skillfish support code more
 consistent
Message-ID: <YgtR5jyohAL0a15n@amd.com>
References: <20220214204847.2096329-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214204847.2096329-1-alexander.deucher@amd.com>
X-ClientProxiedBy: HK2PR03CA0064.apcprd03.prod.outlook.com
 (2603:1096:202:17::34) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32d473c4-288d-40d2-29ff-08d9f0524cb2
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0121:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01210FB18257B0A6F107D20CEC349@DM5PR1201MB0121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jq0W7QoP2oLD7ZUMB3U1I17+B7n7ijYfehRd6L0nCx4x9XG6uZoJqsjGOCC+9TFl0g9neHBMj8Eme4zUpHzsCzsFX4ySXJ6vAJaszArTFzf6wQbjY1iG8v2Ak1eLpG8UaoqO96L8b66niyN9aCi5lzHEN+mXrfcHmBRQqhTBXxMYHS5etNvC9OI7LJfH3TtpkHP3+kDS9P+kMVdQmueYwRKlhyIxLs+/bFWl4mRvh5Tua6tJUSTwUvl/LLTNbdCCVOGiPbp1k+OIG+D8ODW/IgmL4hNPvzDjjWvp8DngNEDuyZOWTSbtrdPkT4+zIuKzYku8e3/erb9N7vZDO+FQ76XCd0GIWBBwVBYLAuY63UeVW1Vc71ivHmhtl7PQPB1L8jaU+7mqIcPc6B+9n+LyeWUxHhxvVe2vEnU7zGIeIu2dg7+saHLxAjrNs3ryIPpOCly42aQSvv5FEUzkKoukzPoPN2EFleCgIiVBUnr3IXNxUn09XX5PhB5zcFzKc7V/FIr2p+iw3UAQWLk2kzNVFMJ+GI826NXZZgO72PswPFEkdgMaCgwpu4r3rFu3Y/fUCiIsQ0S09CWXKF35g1B90AlCXyRutyHpH1wdRLU4hihSuSimzw3cDubKLtTTv7ndJGpWqtTFX//lJ4K7tUyLHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(6666004)(8936002)(26005)(66556008)(6486002)(66946007)(8676002)(66476007)(4326008)(6862004)(508600001)(186003)(37006003)(6506007)(316002)(2616005)(6636002)(83380400001)(5660300002)(2906002)(36756003)(6512007)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tFHC7iTjgvRe9KihLTQYxK2lWClDkzykx8kw/0+dNK4GJgsUu3qllmFKWD3P?=
 =?us-ascii?Q?k7q1ze66EgY6liS5C1Zyxk3tmJst1rjpcFdjynGrd4b1jOn1t2ciHsYUQaJK?=
 =?us-ascii?Q?DX+gNXXTFEealnWH+AOFnQFXGDj1WhWIo9+n5QaB4ZpWBtTsfrousn0KU8YX?=
 =?us-ascii?Q?gdRsAYAxhkiS5CVEgIu/CbMTHynhHn3p7+u9pDfJh6637c433uS+i3LsIloN?=
 =?us-ascii?Q?b84tOIOk69m8Ptxt04VNGRq5mqZ7smdSVpw54j3UjeY8NhvJM7/wAgkPpLTA?=
 =?us-ascii?Q?V/KOYEtUDSFWNFplrpIx4au3Nalvc/7/GYaLrpvz9CdbNIP/6nqxENIP1ocZ?=
 =?us-ascii?Q?KUBxRdi8/pOVCyjvQL46g0rSXRSRXscEkOaz5xJdkbTnbpHdvYwsSl1hM8O3?=
 =?us-ascii?Q?vVgNELHR+4oVGWRakMR1fj16VBIVI6FwescrgMexepfxGNmeotCHbmyB/6ZH?=
 =?us-ascii?Q?DSCBODxgu5kM3kpauR/3Ewtb1SRpeejNSOpuzCIJoMHF15qRiiwDCpFsCb5P?=
 =?us-ascii?Q?ZiOxz2b6+4hFVkmf/v9KFZcrCnGXd7RPIwhpVhh7B22sdx+9VIUbO9B0xU4j?=
 =?us-ascii?Q?eup5es0fOxHIRipPlIVJOPQJ5NXa+Qb9OvwvZ3ekLUGrk/diWxN2VWejHJLg?=
 =?us-ascii?Q?5Jki87nb94hzBUJUrwE6Be8h572pRsRTwHsSKvAYEpXHFq/h+lmE8TR9O2ev?=
 =?us-ascii?Q?Lst40MVpjxeWbsSLnu7ggR3Qayx9g9qTxVLmAy2jhE5++YJ2PpWcrV1tUJ9v?=
 =?us-ascii?Q?5Uo50m+0/0+yIQlvPWJWuvPyAjpQbfO2RU7RlmIotdMgD0Y2EciiIeXtCD0p?=
 =?us-ascii?Q?0+Uy3vlvfpO0zbjOR6FYOPipZXAiD/n3C4cLAGLONru3PkhP32y/FMrfi60l?=
 =?us-ascii?Q?QXZkOmalTDxFwlDSg7BehvcUyYLhlT46KG0FStCKoUJ9yjwHjbxcArJ2oqgw?=
 =?us-ascii?Q?0DCUW2yQeFu7PeDcI61TGpKg8i48dxIgDO7PPlsHwdSC/9Sw7SznfTo93KL0?=
 =?us-ascii?Q?RpSapJ6YesOUycgmOZgAPyr650uyZmZY0W1dYobwAIUMD7hz363URHTkiyaV?=
 =?us-ascii?Q?/HYq8VESqOn68IusqUJkuFv/21vTKNcTKt4MmPLt4oFKULU3hdPvG2vxDiRd?=
 =?us-ascii?Q?1MgKK0GAGWtO6+2obUfsId+Msr3/M8gk3pJ7sVAVEqmc6xcplm8dHlVkiJTh?=
 =?us-ascii?Q?GzEOFDf2ZrQVRWBC+rIPeLMtZJBVUh72P8wghLniHtwx37lpLP/SwDJRpLDv?=
 =?us-ascii?Q?Etc5VibS6CmXaZsDVdd4GZtbSrs52irdhBZmsXF2tl6wKosnA1A7GHQI7xmj?=
 =?us-ascii?Q?R/IJiJCpUYe12vM9dUC9A1fLWiCP0sFafCiq/lLR+rChgVz/yohICuCbPG80?=
 =?us-ascii?Q?yrMAQO93oGjbWd1fCpPo9DTZdFxISqJ4O8QqpD34bC4MlvCuUE/R6HgBnWNI?=
 =?us-ascii?Q?gjHBOP8l5y3ROHe4iHbmE6L5Bx+JjdECpQQCEtCWuNi5m8wQMaauDYBjFzqU?=
 =?us-ascii?Q?jff11Lj7jHchFvnWksU0ircBu1gApQwioW/xg3QHDtgwIYdfR2H6axMpWP+G?=
 =?us-ascii?Q?615/FqUFwb3/1ti2KNrmfQVtr2z5cOvIiVQzrYwEHiLPZdD3wBV+6MNHwnzQ?=
 =?us-ascii?Q?ddvjRDxL2EIl4oQGPp7C3VA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d473c4-288d-40d2-29ff-08d9f0524cb2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 07:10:51.8114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: regL6/NbNoNfAYl0ULWrCM7rTI2QdueSvoarQDn6LXaFpu65H15g3MmD/22mJE28s4+UFK9veEGlDWc0dqO8IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0121
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 14, 2022 at 03:48:47PM -0500, Alex Deucher wrote:
> Since this is an existing asic, adjust the code to follow
> the same logic as previously so the driver state is consistent.
> 
> No functional change intended.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 3 +--
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 4 +---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     | 3 +--
>  5 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ff3b57fe5232..9f1b2ee54706 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1452,7 +1452,8 @@ static int amdgpu_device_init_apu_flags(struct amdgpu_device *adev)
>  	case CHIP_YELLOW_CARP:
>  		break;
>  	case CHIP_CYAN_SKILLFISH:
> -		if (adev->pdev->device == 0x13FE)
> +		if ((adev->pdev->device == 0x13FE) ||
> +		    (adev->pdev->device == 0x143F))
>  			adev->apu_flags |= AMD_APU_IS_CYAN_SKILLFISH2;
>  		break;
>  	default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 5cdafdcfec59..a0b5cf9a41cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1923,6 +1923,7 @@ static const struct pci_device_id pciidlist[] = {
>  
>  	/* CYAN_SKILLFISH */
>  	{0x1002, 0x13FE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFISH|AMD_IS_APU},
> +	{0x1002, 0x143F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFISH|AMD_IS_APU},
>  
>  	/* BEIGE_GOBY */
>  	{0x1002, 0x7420, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 9bc9155cbf06..f2806959736a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -137,8 +137,7 @@ static int psp_early_init(void *handle)
>  		psp->autoload_supported = true;
>  		break;
>  	case IP_VERSION(11, 0, 8):
> -		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2 ||
> -		    adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 4)) {
> +		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2) {
>  			psp_v11_0_8_set_psp_funcs(psp);
>  			psp->autoload_supported = false;
>  		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 8fb4528c741f..dfbe65c1ae0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3956,14 +3956,12 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
>  		chip_name = "yellow_carp";
>  		break;
>  	case IP_VERSION(10, 1, 3):
> +	case IP_VERSION(10, 1, 4):
>  		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2)
>  			chip_name = "cyan_skillfish2";
>  		else
>  			chip_name = "cyan_skillfish";
>  		break;
> -	case IP_VERSION(10, 1, 4):
> -		chip_name = "cyan_skillfish2";
> -		break;
>  	default:
>  		BUG();
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 45e10d5028c5..81e033549dda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -264,8 +264,7 @@ static int sdma_v5_0_init_microcode(struct amdgpu_device *adev)
>  		chip_name = "navi12";
>  		break;
>  	case IP_VERSION(5, 0, 1):
> -		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2 ||
> -		    adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 4))
> +		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2)
>  			chip_name = "cyan_skillfish2";
>  		else
>  			chip_name = "cyan_skillfish";
> -- 
> 2.34.1
> 
