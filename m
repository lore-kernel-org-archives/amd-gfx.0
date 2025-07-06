Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64246C83F03
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Jul 2025 15:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E9E10E3A1;
	Sun,  6 Jul 2025 15:02:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="XzBfoKyJ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E54D10E3A1
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Jul 2025 15:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vMasM6EzYc09wDQ+ln135nP7VMcMCkpIepw+1dXmARI=; b=XzBfoKyJLXkSKDuj0C/nUmfZ6O
 qVEJlDdJfXYMQGBDN8RX6wtHNSIw3fFbSC44jFdV6UF5FDKVeInHdvWBw4EdYFcOn5Nx5b05rwEcA
 MVEhmb6qIcJNnQizGiTFsXRzVcwBWISNJvZU7GqQGmSJzn296iM9ThCVk2RYqmMF9mNE78yvk8TsN
 WKkBfxvc7ysAfsSwONrz2zpu+qhwRIRoiv3jnDjyJ1GiWsRNRS79c6IZyuNCMeRt5VpFYs1pEFWwP
 Z532M4f7wxmrOB7/rgcOy3hCBCjsSg7MHX0kflKoKz/FJbyhl6FBsLkoSvU4TunXQKRZbmpi1Lm/6
 9Hc3AhEw==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uYQsx-00DAHv-0k; Sun, 06 Jul 2025 17:02:31 +0200
Date: Sun, 6 Jul 2025 09:02:27 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 sasundar@amd.com, Sathishkumar S <sathishkumar.sundararaju@amd.com>
Subject: Re: [PATCH 18/28] drm/amdgpu/jpeg4.0.5: add queue reset
Message-ID: <f5urtjtcwqmb6nhuf42veldvdgmruu6s2ytjl7l5qtx5us62lk@quh2kakbricm>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
 <20250701184451.11868-19-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701184451.11868-19-alexander.deucher@amd.com>
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
> Add queue reset support for jpeg 4.0.5.
> Use the new helpers to re-emit the unprocessed state
> after resetting the queue.
> 
> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> index 974030a5c03c9..e6e90496135b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -767,6 +767,16 @@ static int jpeg_v4_0_5_process_interrupt(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> +static int jpeg_v4_0_5_ring_reset(struct amdgpu_ring *ring,
> +				  unsigned int vmid,
> +				  struct amdgpu_fence *timedout_fence)
> +{
> +	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> +	jpeg_v4_0_5_stop(ring->adev);
> +	jpeg_v4_0_5_start(ring->adev);

Stop and start return values in case of errors. Maybe you can add a
check here? If something goes wrong, you can add a log message.

Thanks

> +	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> +}
> +
>  static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
>  	.name = "jpeg_v4_0_5",
>  	.early_init = jpeg_v4_0_5_early_init,
> @@ -812,6 +822,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
>  	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
>  	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
> +	.reset = jpeg_v4_0_5_ring_reset,
>  };
>  
>  static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev)
> -- 
> 2.50.0
> 

-- 
Rodrigo Siqueira
