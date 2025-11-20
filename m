Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A855FCF8562
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 09:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A26910E27F;
	Thu, 20 Nov 2025 09:17:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="EwwW6zlL";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="To2AajnG";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F2610E27F
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 09:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1763630252;
 bh=4yAGINHpApLlyrFfDUnXmUN
 DoQCNyx9asfNkF5CjkK4=; b=EwwW6zlL86tuzWLw6HZBWLQymL0t5DRRvWpyE9BPXp9ibY+kRt
 nlwvrBd4F5+eafPly30JVWH8h/m2FkEJ1T7+w7GuIcXWpsaQOx1Ow8yVz6eGGchCLnY2NaZB3Qi
 5D4pGHyVYF/f74HcMbcrGmPiVUPm1eM2q+Vd8UAnJ3G7o/hBvH/lmgvgisWlZd44F5PGebbH8XB
 sD2eoV4Lh7HVkWgaEixI7ZmigD3ZVlHZSm828Lajtd44Aeoz5p5x8UnPhi6YGHW5/vfxMuwOOKY
 vphVCgzwe9b2j1i0f7EiIMtndorUhjO0C83anpxpio8Msk+lIygva1oo/IGR3BdWqKg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1763630252; bh=4yAGINHpApLlyrFfDUnXmUN
 DoQCNyx9asfNkF5CjkK4=; b=To2AajnGo4ZEQxPYlaltiy0+bvQjseJ8UOWuIoOEw/7hF93jkz
 0xGkuMFCGUDHetupNSz3GhIE/VIRirB2ZAAQ==;
Message-ID: <4cd9b847-06b2-4e3a-a2e0-b4630a13612e@damsy.net>
Date: Thu, 20 Nov 2025 10:17:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix spelling in gmc9/10 code
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251119151654.3664461-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20251119151654.3664461-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Reviewed-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Le 19/11/2025 à 16:16, Alex Deucher a écrit :
> onyl -> only
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index ce6e04242c522..47558e572553a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -117,7 +117,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>   	if (retry_fault) {
>   		/* Returning 1 here also prevents sending the IV to the KFD */
>   
> -		/* Process it onyl if it's the first fault for this address */
> +		/* Process it only if it's the first fault for this address */
>   		if (entry->ih != &adev->irq.ih_soft &&
>   		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
>   					     entry->timestamp))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 8ad7519f7b581..778ad7ac6d086 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -600,7 +600,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   			if (ret)
>   				return 1;
>   		} else {
> -			/* Process it onyl if it's the first fault for this address */
> +			/* Process it only if it's the first fault for this address */
>   			if (entry->ih != &adev->irq.ih_soft &&
>   			    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
>   					     entry->timestamp))
