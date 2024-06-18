Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E345BC27C79
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 02:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A8110E0E8;
	Tue, 18 Jun 2024 02:44:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tfqOVKjM";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE32E10E0E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 02:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKhtcPV1woT6EUgcfacH5PyJTrqUJiVNcQgQdAwLuz48ISxfhXn/5k0SoE3xDwu5vCb2vnPRTJgT7Ds5csP+4/EkAKREcUE2p33ylsZeL9H9vWmZiB9ZXBAg90hQpTsI0d6L866O6NtFy7A1/5ISVQM/yZI8PTMoaZ2jQaES1cXLd0+BVpxpPYAWz4CQ2FNr1bz7+/AR7Jc5pJ2ExG+sHywHEe/C+i/uSVnajJnrtyTv4A/e5dQ8VbEihiZAec8RjC5ordrg4t1BRFMzWB8mpWXXYmymVRWpKtgnejlMDXawrDiVmtLlc7NyiwLv73i/95J86rnZfqH46i7hOMfjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhYto75EGjSH9XLDSi/0hXSaB8fwdWDeLkYWNKHFqwk=;
 b=EXgqsEwtb+xiAF5jAtvuRFOmX2psKWbd9WoOqTxzcjkVKo05dWUSTRePl+0Ge8OZKtEH8kReu87xs9Vk5AMY/BYl7BfRrhX9mOrNHeIpx5ad7Wi/R89TI35z7DMqGOnGensIDD+MyqwYnESIWBnCWrkzvJOv5ZTqaM30EQDaUnxOBjesNMZDSWpHLVStLmF5Ig5haF+Hj2g8HHn1wiz7jNk8pykk9hRxKEGnPW/FQ9yeT0bzZOliOoDMFaROSZYEK2VfirjAKBztobpy7/j+JH4bJ0UOqqZQAWIt9+ii+EYE8zQcH9jAS72Uhe27oovn+/M53OuPDni9yJeygwrCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhYto75EGjSH9XLDSi/0hXSaB8fwdWDeLkYWNKHFqwk=;
 b=tfqOVKjMYgCZ64xUiDeotFGdHzR0v3MTSakHjeP7dRnk/j5QjutQf7dR6GjZReSOeFcnumNmA5kanf7gD+Kdm1yNjTuXXTFJ7xfAwLXacq9v+mrURg0Kn7EDqyq1uMEO5yzSZemdyfwIeE7URgycNwHUhVXlHcmGTfQlu7Rq5bE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 02:44:44 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 02:44:44 +0000
Date: Tue, 18 Jun 2024 10:44:24 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Zhang, Julia" <Julia.Zhang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [PATCH] drm/amdgpu: avoid using null object of framebuffer
Message-ID: <ZnD0iC42srxzIV3t@amd.com>
References: <20240607070455.125522-1-julia.zhang@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607070455.125522-1-julia.zhang@amd.com>
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|PH0PR12MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ccad9e7-e3e2-4daf-aa6b-08dc8f409c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D/KTD1rIv/Smcfs/tkMyDOlXbkj2T/3fTWali0eFoCrJbmyQxH/3NwFFZS3S?=
 =?us-ascii?Q?7J0Xw/p+os9qudJTXi2w26GlT9nkoCwoOsLoGprLrZtTmlIuZP8EZhCaWh6K?=
 =?us-ascii?Q?Qq6IMZkRuBClK0pUdAxHMSvoPYxk1DpudmT7o1JAZvhgV8xuDu12vgAX74eX?=
 =?us-ascii?Q?LIt55ruPqm0CYkEEJiJxxBkg7XME3OMDYmeIfLvgaHPithAHT0DIsoJuCQPZ?=
 =?us-ascii?Q?zMr5yAhdOW05pso2RvXu/TRHT4mv5OhVXlxXLsAS2sXwLbGKZVysNVrFneXp?=
 =?us-ascii?Q?ZfXuUUkrgIhEpSDOG8TuEGwTM4bi1eEsbwP8uK5nXS/a4XHz1FoOfDdIkH+J?=
 =?us-ascii?Q?r+PusJ1cCaNKxzJSTLnnY9jVm6TuRlRemlykg7e5xzmDGU+WYIRqKPhBrEPa?=
 =?us-ascii?Q?bqw+gVPavmtW3mfIF1f0b6zHdh5cEXIVBzhVAYXLfiUpwWMYEDL6rwX/P6/g?=
 =?us-ascii?Q?LyiL9eldIOZzuG6w0ixAlFLCcGQZky3JCeLhi5TuTqQrD8bwpDMn85E/YP38?=
 =?us-ascii?Q?14jQdhiwaMyf3BrRxZ8qAkTRf7Wpe0HgHtHNQwevD98/nDrxO8mGqiKUQ8KC?=
 =?us-ascii?Q?VLj+7yGpXQUbZVjG+XcAf5ZINmNlbcc3l+hULUs+H1R43IuR6emsPVqKA5Ss?=
 =?us-ascii?Q?Y1AHy/tldpK7UyprA4pYK0TKeYv8SQTpp2jsrz+3naK4uFfzDOQsDsW8fad1?=
 =?us-ascii?Q?luq+FRr+UEsb9coiW4gYDMFkiL2s0gpxsVHKyRIbB1ay7+l+Zknce8b8PrwA?=
 =?us-ascii?Q?9XJrlr1OESSyDjUP6ckdxkNeP6dZ+l4frc6t86FkTqPJ8r2vZ3/rBQ22NAho?=
 =?us-ascii?Q?bk2hoNytjWKnhBXeM3S28W16ZN1vLs71staIRWOD2xp8MfwLWmHZMClcz0A8?=
 =?us-ascii?Q?G5aPl8XLzp0B6C8Cerg6i5zncdzig0TWT+hqQVUKCiLjDTYYY5bZQ7tj30sI?=
 =?us-ascii?Q?O1fWHbbV9+i0PCQ9U96okijt+RwrqcGIqMCCRzdRaiKcTe91GCHhl8CJc+Au?=
 =?us-ascii?Q?x/clFqj3b6EEYhJPNHf1l8ZwYuS2O2DvY+hqicBznTJUYTqFldwvH46xKCpj?=
 =?us-ascii?Q?QabFNP1tfsR9S498qnjUEGF6PMcX101ntxURgHSsbDm8IZfxaPqc/wNFV4Gl?=
 =?us-ascii?Q?SqsXXE7PNhDbmSTftjorJqxNjDISwrMa4vY9EGZd2oGsK7uEiD0wQUsVx7Xe?=
 =?us-ascii?Q?hOGKqo9TgaMi8JeI6weOxV4Z/nYWIxJ+KmdhWOqUHQAFOZIsjHVlQiseMAS/?=
 =?us-ascii?Q?NEireP3OG/XUdDqDZJG0K4dopkssXEswLUVr2AcNcVMK3eV3RcLtUK4j3PBH?=
 =?us-ascii?Q?FC1gcSksFLkLNhUeVAZrfCYA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8690.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x0AQoHY7zjcI3UetnIyQzV0DSD0ERtD/RYfT97PrvLST368v3VcyMr89qErW?=
 =?us-ascii?Q?YlMkpQGKvMTllpbcJAeqTurC7Fz/fIVMjGmsX314pXRzxJuzur37qwoqUOaU?=
 =?us-ascii?Q?xV/xZUIBRev4uxwhi/A8dwGY1P4UDZgbAFA88yW2umVkYX/gAMBxklHTcVrm?=
 =?us-ascii?Q?0AvPi/mfagIJGA88OiLzWjueZtyQLSKgCHj6RB02SMDy0qEVMwGIv0nS1YV+?=
 =?us-ascii?Q?ZELMycTowABn3h8cFgLXoF2NWWi3C6S/HaqkGmU356UGPrbaUeUYn4Cmmt/V?=
 =?us-ascii?Q?tnQ9t9v/8GMmdO5nEtJrVra7gub9psUq5cs/s9UT/Mepc14HHC/n8DAoWPi8?=
 =?us-ascii?Q?/nBd4vCAXP/pCOjIzpKmkUORZVM4ScpMxE6ygNiOkp08nhkZR9M6+uMYR3OP?=
 =?us-ascii?Q?CWAA0eSgEtXzj6NLYPMTQFEwNIgPfsCB6VBkWSvkLOqt4aLp7kQnrE/jBHhe?=
 =?us-ascii?Q?Srb6KyakyS2B8qhAL8/8NhXOmH5RvFBk3/RvtlpnSxw3xyw9PUnUBRp4VoQe?=
 =?us-ascii?Q?ZB4wGkGePjSG3AWeEUsg4RulouRXyUwO1qIzkgFuXdTPjHrLy3/jprRFz9UG?=
 =?us-ascii?Q?lT8JYHjuHIs5uaKNXxXDaj0QP00mVi6j3ntL9dXfSzQKrtte7qpcTsv8/b0t?=
 =?us-ascii?Q?V++w0jKYXhsOHnB4/7e+QFCdvg2pJkcaqZMBIJFFJUbqOHERAe1KiLkYXHLL?=
 =?us-ascii?Q?U1aA8nh3ZgwdHRSqhoKHiXW5uSL+QMninXKcYq4j17GMyJRK0LoM/fT5UFY/?=
 =?us-ascii?Q?zLreBbVytanD9vhU8BAQnlKKLu9BTEGg8O3p40VZWHSMpEVhKhzOtdJy+rs+?=
 =?us-ascii?Q?jihzrSQgpQy63HV58nDa6jOMLetCTMI0g93GIyuRYeYdqEvSo8RWLCkWdRIQ?=
 =?us-ascii?Q?Jl5C+eZPtTc2PMbGq9E+X1eaAZGVw1rXC/pOyoMIZABMtoy/AQzQERpQcQo9?=
 =?us-ascii?Q?XzBHnC2spDwUErJG76EDMRh1dyubh7mR5dsBR+dgu50du/htjsXA9w6y16MA?=
 =?us-ascii?Q?Y0NRWBYgeTImpcSsrOkz3pPBFQpgSRgxA1NDd/BsJcnSzBhcxOmm1cuYs/71?=
 =?us-ascii?Q?nNKsUvYXZ3lYPeLRwF0ftLtvW91dfjOa8zYiYPiQYtTG1e3v6OUgABMJoo1L?=
 =?us-ascii?Q?buzDEOysNsaje2w+QJWutik8oJPQQkBhXTWQrTKjIxMxjSX9Rh/ImRwX79k5?=
 =?us-ascii?Q?tq96cDIdJD6q16+KJtQWDcJetMmNYRJt4rFwhxE0TrWjspTuooy6rCkG/jid?=
 =?us-ascii?Q?t8uIIC8+/VRwRvomwJotPnbiE7D026ZmOWrRiypt9wCfhBfc834ckfb8MhNq?=
 =?us-ascii?Q?qeaQ6WgpjWxv1uRsHwAzGk+WnXBCS7euXogSBXyDQECdxwgJSN3XX1kLE3RZ?=
 =?us-ascii?Q?XoJxQk8BvdBGncnGiZ2b8dxfslQsbSIXQVnOCWvhIeHutDzbLNt9Rol7OsvY?=
 =?us-ascii?Q?a58wuL0WqHZm7shsODFr0NSpPZXKD7t2vvDFiASH8+YBAlmYnuqUCqE5oLlQ?=
 =?us-ascii?Q?M+KxK9u9ikh2V+4Pz1UuK4bDAWj50QcK8Pkk1JxCUNnted15ScuoANZdAAot?=
 =?us-ascii?Q?ha+XWE6Mxgbd97rMuKZ+u3Pwirc+uf3M+7Ly19O8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccad9e7-e3e2-4daf-aa6b-08dc8f409c5a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 02:44:44.4956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZiZy/Qyg4mKVB09GD900BzZKRDQAGu4GwGlrt6iXEIuKEpqgOqc+ocZW9NIc8qREbUua+Mjmw6PXXbqCGnQIgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029
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

On Fri, Jun 07, 2024 at 03:04:55PM +0800, Zhang, Julia wrote:
> Instead of using state->fb->obj[0] directly, get object from framebuffer
> by calling drm_gem_fb_get_obj() and return error code when object is
> null to avoid using null object of framebuffer.
> 
> Signed-off-by: Julia Zhang <Julia.Zhang@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> index d60c4a2eeb0c..d50ee0828935 100644
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
> @@ -365,12 +372,18 @@ static void amdgpu_vkms_cleanup_fb(struct drm_plane *plane,
>  				   struct drm_plane_state *old_state)
>  {
>  	struct amdgpu_bo *rbo;
> +	struct drm_gem_object *obj = drm_gem_fb_get_obj(old_state->fb, 0);
>  	int r;
>  
>  	if (!old_state->fb)
>  		return;
>  
> -	rbo = gem_to_amdgpu_bo(old_state->fb->obj[0]);
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
