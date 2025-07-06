Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45901C83F03
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Jul 2025 14:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC53E10E293;
	Sun,  6 Jul 2025 14:56:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="PS4120iA";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26D7010E293
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Jul 2025 14:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2XrfO/PUkuo0ebc0jdDcYBDNhnbAq/UwCgQ13RRfbPI=; b=PS4120iAFXgnDtVRt7YZ8F8O1c
 mdlOa1Cf86DX9+oDzPCmS55MK9MZ/XLqH/OCM5Kg9flfyxRQFICgszWPq5RiZj6FjCHq/1QoWgdQ1
 ThzO+Tk7oOEjzsfiMqOGd9Gf2G1iYESxzkuCVLTsrqrsCi60Hlnjv5CPaCmLTj/uSwkkYJbKprUKN
 QM9WQoLVYEYvsYAw0qNbRT4TwJxk6WS+tuDNPhYdoYzZJzv/epCBz42upHnZbsYPNjwVDqIDrFrnR
 xvR4kgccsoQFPwp4UzlGKNtGNr1xFmov03vUf7xxzM1B7GfthFI+VwkX3tO3kh27Qt5A/HKUB/66F
 zu4IjNOQ==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uYQnE-00DACG-Hz; Sun, 06 Jul 2025 16:56:36 +0200
Date: Sun, 6 Jul 2025 08:56:33 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, sasundar@amd.com
Subject: Re: [PATCH 04/28] drm/amdgpu/gfx9: re-emit unprocessed state on kcq
 reset
Message-ID: <32lz64s3r636pphzd4d2o4vbfzzr42rn4gt2m2jvq6qarrimfk@jc6qru354hbi>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
 <20250701184451.11868-5-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701184451.11868-5-alexander.deucher@amd.com>
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

On 07/01, Alex Deucher wrote:
> Re-emit the unprocessed state after resetting the queue.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 76ba664efecb3..30f6b04cf82e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -7187,7 +7187,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
>  	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>  		return -EINVAL;
>  
> -	drm_sched_wqueue_stop(&ring->sched);
> +	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>  
>  	spin_lock_irqsave(&kiq->ring_lock, flags);
>  
> @@ -7238,19 +7238,13 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
>  	}
>  	kiq->pmf->kiq_map_queues(kiq_ring, ring);
>  	amdgpu_ring_commit(kiq_ring);
> -	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>  	r = amdgpu_ring_test_ring(kiq_ring);
> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);

Is this `spin_unlock_irqrestore` part something that maybe should be in
another commit?  Maybe one commit that make this change for all of the
GFXs?

Thanks

>  	if (r) {
>  		DRM_ERROR("fail to remap queue\n");
>  		return r;
>  	}
> -
> -	r = amdgpu_ring_test_ring(ring);
> -	if (r)
> -		return r;
> -	amdgpu_fence_driver_force_completion(ring);
> -	drm_sched_wqueue_start(&ring->sched);
> -	return 0;
> +	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
>  }
>  
>  static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
> -- 
> 2.50.0
> 

-- 
Rodrigo Siqueira
