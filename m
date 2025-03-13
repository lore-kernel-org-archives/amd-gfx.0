Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED638C35FF6
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 22:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3B6A10E94F;
	Thu, 13 Mar 2025 22:10:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SG2vahYt";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9409B10E94E
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 22:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UYVkzuHf3C4FKSf6xfwjya0dpmPC3edk9UH/wd69rPs=; b=SG2vahYtUujw7G3JcruVmJo7cu
 xow6wUfWMwZFmlOlA7jWAwUHQh2//byC0sX90ITWzOAWoHRwp4MXn2MRJwtSfz48n17SduqpaS4ie
 2wsNBvTtsZ/VUfwNyFFoL0ixJgBEXcrvwU77U0sBmJTsGZxQ9iSxhrwGLMA3E7htx92iFYnbiQhPw
 pbilJcrJW63LKM5xZ9hFZERmP/Psnd5aPfImoRc0gjtVn93727D0dDumTBP9NUdYrCuILI+Gm2JQq
 DFRuEtGO+gEjElT11+wYwcwRZWbM/evdYZGQpHDrRi/H25uxDccDjhYPUsmb0BrDr2MuTTyDz8F9I
 YCOOwlIA==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tsqkr-008MFe-MK; Thu, 13 Mar 2025 23:10:23 +0100
Date: Thu, 13 Mar 2025 16:10:20 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: Re: [PATCH 11/11] drm/amdgpu/sdma7: add support for disable_kq
Message-ID: <njrifjuiok6xtfqlostdts7btbwzfzykkmze2r7g2kwejyc4lk@7w3mbc7jaa2q>
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <20250313144136.1117072-12-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313144136.1117072-12-alexander.deucher@amd.com>
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

On 03/13, Alex Deucher wrote:
> When the parameter is set, disable user submissions
> to kernel queues.
> 
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 92a79296708ae..40d45f738c0a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1316,6 +1316,9 @@ static int sdma_v7_0_early_init(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int r;
>  
> +	if (amdgpu_disable_kq == 1)
> +		adev->sdma.no_user_submission = true;
> +
>  	r = amdgpu_sdma_init_microcode(adev, 0, true);
>  	if (r) {
>  		DRM_ERROR("Failed to init sdma firmware!\n");
> @@ -1351,6 +1354,7 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>  		ring->ring_obj = NULL;
>  		ring->use_doorbell = true;
>  		ring->me = i;
> +		ring->no_user_submission = adev->sdma.no_user_submission;
>  
>  		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
>  				ring->use_doorbell?"true":"false");
> -- 
> 2.48.1
> 

Hi Alex,

I think patch 9-11 could be a squashed in a single one.

Thanks

-- 
Rodrigo Siqueira
