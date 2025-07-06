Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4331CC83F03
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Jul 2025 15:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEFCF10E2C8;
	Sun,  6 Jul 2025 15:00:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="mJiWzQc1";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF78410E2C8
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Jul 2025 15:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9riFkfaQBMjWhT1TDn6R5HSwFWEH8b6SROfTt4mi0sc=; b=mJiWzQc1+TDqV8FkC68KZfWMYu
 bRCrbba3P+oySqm0VF3541AcRKxJCXbucRkc1BUVAeHnK9KCk/gFdyMCgTdL/TeGDU6xFd1Mj2UKB
 M76PBpf8ZACT6AHl7z9RzTF6ZlX/sklNjb+SenZyrguah+xI1cX2ixkU0sH9sClTBtZxFE7n5vlnK
 achWMMYSKc812bwcJqp/1qib5lT5jLc+ONbm/tY38A3FbKADbnUPPuVXo6kwoGqAOWbtPNTOemXDS
 fvjs1U8DZ8SlnzaBNaOAr7xwpz0dHnUkEqGpP9pnOUXLJqSERkOW34lGXRc/YfVVqzUfRxsjyyM61
 7QXC3aog==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uYQqt-00DAG4-NR; Sun, 06 Jul 2025 17:00:24 +0200
Date: Sun, 6 Jul 2025 09:00:20 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, sasundar@amd.com
Subject: Re: [PATCH 09/28] drm/amdgpu/sdma5: re-emit unprocessed state on
 ring reset
Message-ID: <iioi32zpnax5d2ub2xoiwhbx5bcdtzttho3dni3v3mfktyrtzr@z5vfaef7ha54>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
 <20250701184451.11868-10-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701184451.11868-10-alexander.deucher@amd.com>
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

On 010/01, Alex Deucher wrote:
> Re-emit the unprocessed state after resetting the queue.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 5a1098bdd8256..577b002fe566c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1544,14 +1544,25 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
>  				 struct amdgpu_fence *timedout_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	u32 inst_id = ring->me;
>  	int r;
>  
> +	if (amdgpu_sriov_vf(adev))
> +		return -EINVAL;
> +
> +	if (ring->me >= adev->sdma.num_instances) {
> +		DRM_ERROR("sdma instance not found\n");
> +		return -EINVAL;
> +	}

Nitpick:
Are these checks part of this commit? I noticed you made a similar
modification in the next commit. Maybe you can put these checks in a
single commit before this one?

Thanks

> +
> +	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> +
>  	amdgpu_amdkfd_suspend(adev, true);
> -	r = amdgpu_sdma_reset_engine(adev, inst_id, false);
> +	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
>  	amdgpu_amdkfd_resume(adev, true);
> +	if (r)
> +		return r;
>  
> -	return r;
> +	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
>  }
>  
>  static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
> -- 
> 2.50.0
> 

-- 
Rodrigo Siqueira
