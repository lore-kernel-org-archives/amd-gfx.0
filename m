Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886C5606A32D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=DkWW4NNC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 179B610E1A6;
	Mon, 26 Oct 2026 10:41:55 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 886A410E1A6
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 10:41:48 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jCqtd06QFz8t2h;
 Mon, 26 Oct 2026 11:41:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793011305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kzgs3AQHLT3HSYh32Yj3thzN6uDPjTvFSOG8Xs2EFDM=;
 b=DkWW4NNCtwDcquzGT2i1uQpzfJ7cq015afy2S8OH3g+Zc0Bt8hqPNFmS3Q1OAs5HdlBqYh
 gnoCfN/s/bYOPiBih4ExklS97zbMwa/cktIbUPMDBiR7sJaDtBX9SZvTuxjgf+Ve9PTBJH
 L/5gD1G5JprehXwvJ5p0qrkA6tO02N46OCRI2iV2ST0xuYmAXEwPY8KNXXQe5x6Jn8jsA/
 y8SaXcVmEroRqNwUbl1X2oWYjaV8Qg6Gp0D43jwNUlWd/ohlYSA29x3/VJQ1+FnVsEgdwz
 Mh0PmLqa5AqTkk+wDku6eGK9xt0mz1y/2XwmE6mDBECrt4G04rUfrBljA4SNiA==
Message-ID: <e307f665-3836-47ac-bca2-b9ed883fc995@mailbox.org>
Date: Mon, 26 Oct 2026 11:41:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix DC scanout position handling
To: Erhan Bilgili <erhan.bilgili@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Jack.Xiao@amd.com,
 stable@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20261025084506.62881-1-erhan.bilgili@gmail.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20261025084506.62881-1-erhan.bilgili@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: zpz4e79r48wx4n4f8jybk3kjowe48amm
X-MBO-RS-ID: 3b6ae10290bdc8a2763
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/25/26 09:45, Erhan Bilgili wrote:
> dm_crtc_get_scanoutpos() packs decoded DC positions and blanking
> boundaries into u32 words, shifting the second value by 16 bits.
> 
> VRR extends vertical blanking without changing the line clock. For
> example, a 4K240 mode with vtotal=2250 spans about 9000 lines per
> refresh at 60 Hz, exceeding the 13 bit range within a 48-240 Hz VRR
> range.
> 
> The 13 bit mask truncates positions above 8191, causing early VRR
> timestamps and missed vblank count adjustments.
> 
> Fixes: e806208dc1da ("drm/amd/display: Fix slow FPS.")

I don't see how that commit caused the issue. Rather it fixed a bug which had masked the issue.


> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 0a8dd7241750..f78c82ba7f70 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -1767,6 +1767,8 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
>  	bool in_vbl = true;
>  
>  	struct amdgpu_device *adev = drm_to_adev(dev);
> +	/* DC packs decoded values into 16 bit fields. */
> +	const u32 scanout_mask = adev->dc_enabled ? 0xffff : 0x1fff;

The 0x1fff mask isn't correct for all non-DC cases either. drivers/gpu/drm/amd/include/asic_reg/dce/dce_10_0_sh_mask.h has

#define CRTC_STATUS_POSITION__CRTC_VERT_COUNT_MASK 0x3fff


> @@ -1784,15 +1786,15 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
>  	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
>  
>  	/* Decode into vertical and horizontal scanout position. */
> -	*vpos = position & 0x1fff;
> -	*hpos = (position >> 16) & 0x1fff;
> +	*vpos = position & scanout_mask;
> +	*hpos = (position >> 16) & scanout_mask;

Since no HW generation seems to have any other fields in the CRTC_STATUS_POSITION & CRTC_V_BLANK_START_END registers, maybe just use

	*vpos = lower_16_bits(position);
	*hpos = upper_16_bits(position);

and correspondingly for vbl_start/end.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
