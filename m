Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DDFC27C79
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jun 2024 04:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CBD610E8BD;
	Wed, 19 Jun 2024 04:46:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ECMr7ZA9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7875610E8BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jun 2024 04:46:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTz2Hjz/8T9FKhF8h1uVpCZVuz1oun3yAGJpK1JZ1CBUnr/a3R/73DqDTKcXbViXfZBp4ztQBB9I4CDKQZCwxXztPFz96rryVMfmDKx0n6sgyEHi5fLL0arHI9SFUQccgp99lWCMZgun0AitnnvY8K0KsDybO+GKlJD2zjw/IhmRBzSJ2BY0RudtZOZ/CSSplZxy/2w5+96ZH+KJkzu0nzf5zMjVhTWABx8QtoFCFsYGdjxlRjpRmYHQpa/HbQVZ9EOwJG/bx4CRta6cvfpN9ebsZBOLGJIrK80RyexJjS035BUoe+BHkyHTgewpezeCRpyHfd4dKGsG1E2Bh9t/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLwxN/1XlIwpLuliUxTyGWlAf4cEUCK0i/CiUKmrImA=;
 b=aY8mXJzWjSIgFRzO0spnWlZ/dmD7mvg+hHAhqSL53WgIIIlMIUYp0m9EUYt0bqTU9yYmOAMAP6fd0NO4zbkXxJbmAt/KNQlefuYiybo5GmGMdGVTMxWa7pXw2H66xT7PfRklsqxBqg9eJHWUS2ik2qjkbt9rHA8CnWja8kaKTpyfcV3LVsks/cNSO0XIOlCtrzLzUsdEAA55zOGoeWwxGooPXr20o7C4eb+nfCkV0wO5BQg0h7CuZmuHzzVo1ILYMg8kNTwCOLn2DuyeWw4bIfc7oAXp5Bw77qJyuekBEMl37kePxatcvAVdjPTVsCNBxze/YY8dmmWu6OV1qfJkEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLwxN/1XlIwpLuliUxTyGWlAf4cEUCK0i/CiUKmrImA=;
 b=ECMr7ZA9AcuTJIxfrFkxSgyNFy2R3dULCO/RbUovXKF75hnRYODrI/CGWAiMDzFVpoZmOM5Nr6gjo9c+ckBAuNKU9EP9tAnUuFUU6s1HvVg9KrJkQ459M0didSpFr/yCy9uOmeOf7usSlaeqeRsY7sBImmoR6p/o5dCBNN/j3oI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 04:46:25 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972%7]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 04:46:25 +0000
Date: Wed, 19 Jun 2024 12:46:07 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Zhang, Julia" <Julia.Zhang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Chen, Jiqian" <Jiqian.Chen@amd.com>,
 "Zhu, Lingshan" <Lingshan.Zhu@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: avoid using null object of framebuffer
Message-ID: <ZnJijxTr65XMEXki@amd.com>
References: <20240619042924.1489294-1-julia.zhang@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619042924.1489294-1-julia.zhang@amd.com>
X-ClientProxiedBy: TYCPR01CA0123.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::9) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe28a21-a4f5-409e-b68b-08dc901ac679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?prYlqSQCW3yDC2Kau0U7ALEQSUBxqP7tLRvGlHD9GQkb81f+viV8sYi38sz/?=
 =?us-ascii?Q?RpU6jHXh4n/Q53o3g96Ehpy+C+abPKZ5Lk1C/vinezfWC5i5kUyL3M24HW5e?=
 =?us-ascii?Q?ofuq2gUOIr3UuxSRKVcy2jDu9YsqD4UpRl6j+tJLc8HnEjBpSeBG5Tae/nPM?=
 =?us-ascii?Q?KqGsfOrAxlCA6x3JSGoWzpbok9ncTzB7GMggIB4LuM90VFYeRr4j8fNo2vTr?=
 =?us-ascii?Q?r0g5BjpID550ra59ZfA3Tc9X5x+yFsN/ttlXLL2J0HQYQme5vdlmeP3SfE2V?=
 =?us-ascii?Q?eKojWXAG0GxsXInM9XSeZDf9eBJPRK4HndVtv8+WZKqe8uyAPRNNgQBqNsXj?=
 =?us-ascii?Q?4VSMBk+CJI8j3CADirb5b9U5sdJOG27DopzgpW6VQXla2ynuFoe7+Q2do2u2?=
 =?us-ascii?Q?u852XzWl18aliJeV6F+IRWnVmVv3pJkO/SjRrntpqwX3s1XeXcgOvTagl347?=
 =?us-ascii?Q?qNuvtXIh0T8JhHRiNfjVys0abfRQBG9+ua8TZELQUQYz8fey4YX0cYAF/Eql?=
 =?us-ascii?Q?qPdojudPS0AIOxtiAV7pouapRKWITRpnIWxDJOwrUdaTnHuNZ/zAyxmRg4sR?=
 =?us-ascii?Q?3xifv8PaFxwVLTXPxvm40EdG0vbSadG4znuXliB0hC601Q2Bgl81Zopow9fv?=
 =?us-ascii?Q?5IkHf9qWYaplGv16A8akYwnke3Q05SFYSDM7WyRDoWrTYAIrxgIIbxjy7aE2?=
 =?us-ascii?Q?cR91C1Rkc05wyspdw5XUWvn8ppiTr2U2aayNfsj4b5R9hhjlR2MtbnISHp5s?=
 =?us-ascii?Q?1A/xlpHRDVkLigq5bQc3UsM/HBaOAKxjR63YVOpnkpp3uELM2Z0+9nzZva09?=
 =?us-ascii?Q?24rcm4HH1/ujvbT3tsZZrNKJ1UfMSZU6YHiRPYkxepGshbB9qxdfKMemKXan?=
 =?us-ascii?Q?LZG4677LyCZUeMkzbklS4D0yrJWVN9wZI0O2n96guUcoCa59Sm45DQo7Bp+2?=
 =?us-ascii?Q?E7K8nZEP2LNYu+4PSl27zxZihMVL/5u8Cun5s6ESnKs+cpP2bI8/5V8tUlys?=
 =?us-ascii?Q?GlgdKf3NU1zQLtSbIsuUED/2niY1fSBmkGMQuDlSkp7B1Oihb0IFRHCQbJZN?=
 =?us-ascii?Q?b0LDY2rfNlgG+k6VxSAIrJAeaw0YpT2BdP+OQd+8hERJwZqvV4u9fPZoA9pJ?=
 =?us-ascii?Q?0bPDSCezL15yQ9aNyDLECmn+F3ThVJTHb6Ggs9BPKrZDDv5uCfOM/9+EQNAS?=
 =?us-ascii?Q?k+3Ru1h1HnKmDscKT3feuA1a39+P2ZVc00/0z9El8+NAvpvGzkM3OW/jl/CC?=
 =?us-ascii?Q?8/gM9wqED7TNUrq3jye3MPaRpxgRuC854NmEtV/w3uMU8ltoMZD0MEgpWPz8?=
 =?us-ascii?Q?mzFxVMjpHEoK8HXbuqd2qr5S?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8690.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hwg5d2165V9SAmGVjqgwAX1XVbmL/0BKihCHN1TcjDqlIpi43UyfHVEyVSsn?=
 =?us-ascii?Q?WL6bjt7nlPxr2Qknq4p1O3JYdRLZciMKUvo2A8PdR8OpE/GZvyPG3muZ5IVq?=
 =?us-ascii?Q?bidLwt0VHVXsF8GhM28riSUUau8sFjKadttB1hNOa1KIAP+H8bq/C8l0rL7o?=
 =?us-ascii?Q?xnZ7PVJceQw4gkB4OhtcQ/nGCNyMt9/fPrYGutU9goyF1FV412eZifoZAols?=
 =?us-ascii?Q?CMACT91Ro3uwHAIA5EI9if6JAuTgTS5qjUl4sr0E8H1+P60vsnKc9Ng2P9qz?=
 =?us-ascii?Q?HlOSTArtytn93EsSImPMGcdbpHRApSVaAWht73l7t22KAIFNyeBrcV7aCKAW?=
 =?us-ascii?Q?zKic97pQm+6cQZ/qQjBGJA8q0pffP/u1E2O17OLpLgbV+3qCEXjJ11VRu9Ic?=
 =?us-ascii?Q?BD24a31Br1Ha3q0Xn3c/f8IDk2e1d3i7JMV2QM1Vpe3+5W1h2HGmCHENBpr1?=
 =?us-ascii?Q?a8ASHNOzhDBt0k66MER3lhurM5QkS/gQ7h718NiPhuL4klZm8DgeaI76iUHu?=
 =?us-ascii?Q?K3Apoc2pPf+j/5d8BpgQZ8hsstd7FlnxUucAuodyxVJQDfsonEqNLoS8hK12?=
 =?us-ascii?Q?kwXRKks4Whke+ugfop5N1X2otCaBc/vDImImGh5ESCdjJHcusUVbxC2FgTbv?=
 =?us-ascii?Q?eJcAJxwzp1ltZYml21uG7FIvA808xN5wRFxuPpuPfHpfBwLfjEi2ZDhmBw1L?=
 =?us-ascii?Q?yIKtu6ku0B5f6hnlyTdPE4Dp/6qTv6UsaEcGKRmwPsage8gj0oS6cf//o6YN?=
 =?us-ascii?Q?Y34hgfvZ2NbyJeM7Y42vlASYfyUcmeFCvt4v4imuqxMQEb8G8dPA3K2qymhC?=
 =?us-ascii?Q?92qbZw3DWUcYvS5Qg+D/RV62no1d/pnlSWeeUYEiSiH+N/UQphmM0ujeZHSp?=
 =?us-ascii?Q?cSShcAbTCoQLkJIBYeSVRZMxXa9zYy4+Y3hH4NGIBMSVofWcIqDK/JRJrwOJ?=
 =?us-ascii?Q?jtbIIETjObAJx/PrN2s+mZkrPMCOdT7abNpNQw8U5EvS1agIaegJwcR3yr8p?=
 =?us-ascii?Q?Hkx3NrnuJOavOTtns1LySKvWEgaFjBjdnBBmKyAXDoP+MQZhGbsWjvZeAlcl?=
 =?us-ascii?Q?IjefiaAV9Hc+bbVasJVYzww7ASkeLPONo74W8MX/B1fhyQNElUsGvj+cUcWr?=
 =?us-ascii?Q?Q0fOdXwfDeAAEI4wQfTR5xDPBL1cHC6jDzqPKghGmGR6fkuyAl/qgp+2TedC?=
 =?us-ascii?Q?WQCjmMN+OxycIXvWb3l5vuSbCBvTTLsh1+08aLEuka/MRhol06RB9qHflAnx?=
 =?us-ascii?Q?4aD2iYQCXFuIF3kJpmms69z5oQ7d8eWuq4R0XsYSq59Z+QPeqn2ky9HjMXfv?=
 =?us-ascii?Q?dvzgRHW3MH5FHCED04NVunyttTjjM3SbEHrvozty4g44VbU6ZLIcg1e+h1UD?=
 =?us-ascii?Q?dXEH5G6UDMwB7nu0MAQ2j97fxCCAv+5/KuC7eggURuXbKIMpdoKjlugUVO5J?=
 =?us-ascii?Q?euU/vYL5hlDNadpHqiIIN4gHsNVGuEz17Zu3erDnPQzhEGlj1jPgO9zARoTp?=
 =?us-ascii?Q?z2Li6/ePiP9eNmtq/+sTs38joEiS+2bMe5bry5Vq3gONYVP7iBzD5ku6d1ed?=
 =?us-ascii?Q?yRQtBwtguVVLo3MeOpVWc73bWO5qDBvOLETH6Txu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe28a21-a4f5-409e-b68b-08dc901ac679
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 04:46:25.4436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJmymfZL34VbDtHeTAY+4kNStNnXpJybjBv1xmxXvBiEFviK2n1SPHBrOayikdQZOfXh+eW2gCF/gXl4yV8xgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438
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

On Wed, Jun 19, 2024 at 12:29:24PM +0800, Zhang, Julia wrote:
> Instead of using state->fb->obj[0] directly, get object from framebuffer
> by calling drm_gem_fb_get_obj() and return error code when object is
> null to avoid using null object of framebuffer.
> 
> v2: Call drm_gem_fb_get_obj after check old_state->fb for NULL.
> 
> Signed-off-by: Julia Zhang <Julia.Zhang@amd.com>
> ---

Julia, you can add my RB during V1 in the next submission.

Reviewed-by: Huang Rui <ray.huang@amd.com>

>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> index d60c4a2eeb0c..212f6522859d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -2,6 +2,7 @@
>  
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_simple_kms_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_vblank.h>
>  
>  #include "amdgpu.h"
> @@ -311,7 +312,13 @@ static int amdgpu_vkms_prepare_fb(struct drm_plane *plane,
>  		return 0;
>  	}
>  	afb = to_amdgpu_framebuffer(new_state->fb);
> -	obj = new_state->fb->obj[0];
> +
> +	obj = drm_gem_fb_get_obj(new_state->fb, 0);
> +	if (!obj) {
> +		DRM_ERROR("Failed to get obj from framebuffer\n");
> +		return -EINVAL;
> +	}
> +
>  	rbo = gem_to_amdgpu_bo(obj);
>  	adev = amdgpu_ttm_adev(rbo->tbo.bdev);
>  
> @@ -365,12 +372,19 @@ static void amdgpu_vkms_cleanup_fb(struct drm_plane *plane,
>  				   struct drm_plane_state *old_state)
>  {
>  	struct amdgpu_bo *rbo;
> +	struct drm_gem_object *obj;
>  	int r;
>  
>  	if (!old_state->fb)
>  		return;
>  
> -	rbo = gem_to_amdgpu_bo(old_state->fb->obj[0]);
> +	obj = drm_gem_fb_get_obj(old_state->fb, 0);
> +	if (!obj) {
> +		DRM_ERROR("Failed to get obj from framebuffer\n");
> +		return;
> +	}
> +
> +	rbo = gem_to_amdgpu_bo(obj);
>  	r = amdgpu_bo_reserve(rbo, false);
>  	if (unlikely(r)) {
>  		DRM_ERROR("failed to reserve rbo before unpin\n");
> -- 
> 2.34.1
> 
