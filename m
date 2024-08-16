Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A261EC3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 09:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E03910E5E5;
	Fri, 16 Aug 2024 09:59:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ukKJVh5z";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 868DF10E5E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 09:59:35 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Wlcsc1GtLz9sqc;
 Fri, 16 Aug 2024 11:59:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1723802372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Efc1JSMFQJPdLshWpJgrRasTNI6X7tACYYKIpvuz0so=;
 b=ukKJVh5zExtgyLWk1WZPuMr/JjfmHz0uKc4mUkl2eddyWCowo/rW2sipcS5qiAWImNZ27p
 DJjdX9aD8KqueO0I8fz5ZC0DIaCHXEwulsOtlZKQ/sU3stqR9nBqe7BDE4bUml3rLfGOmA
 Xb3Lfj/tFbexwQ2GWXBXvRfF3KwrZeJKxR6Etn7obYzTSt7NGGXFhp3nNJVdsLXAlD6rza
 xu6hG8kZ4HDNIMLwUV1rqTuu/9ovEZVQ2C9riKJWxQ6bGlIi0xIbiWn6nbp4Y3QZ35k/go
 20UE0rGDzfmZzrG517RsdbNaJgDA1SQoQ9i8dX6sLTG6eRjy0MJTW7NlpeJ5iQ==
Message-ID: <19006625-1abc-4aa8-946a-2c0db1921e8d@mailbox.org>
Date: Fri, 16 Aug 2024 11:59:30 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] drm/amd/display: use drm_crtc_vblank_on_config()
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
References: <20240815193727.294435-1-hamza.mahfooz@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20240815193727.294435-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8abad972bb3bc1a523b
X-MBO-RS-META: g7f4r4upxfmh4x5hnwdapi7bprge36hs
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

On 2024-08-15 21:37, Hamza Mahfooz wrote:
> Hook up drm_crtc_vblank_on_config() in amdgpu_dm. So, that we can enable
> PSR and other static screen optimizations more quickly, while avoiding
> stuttering issues that are accompanied by the following dmesg error:
> 
> [drm:dc_dmub_srv_wait_idle [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> 
> This also allows us to mimic how vblanking is handled by the windows
> amdgpu driver.
> 
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
> v3: use a less conservative policy
> 
> [...]
>  
> @@ -8244,9 +8244,36 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
>  		amdgpu_display_crtc_idx_to_irq_type(
>  			adev,
>  			acrtc->crtc_id);
> +	struct drm_vblank_crtc_config config = {0};
> +	struct dc_crtc_timing *timing;
> +	int vsync_rate_hz;
> +	int offdelay = 30;
> +
> +	if (acrtc_state) {
> +		timing = &acrtc_state->stream->timing;
> +
> +		vsync_rate_hz = div64_u64(div64_u64((timing->pix_clk_100hz *
> +						     (u64)100),
> +						    timing->v_total),
> +					  timing->h_total);

AFAICT this can be done with a single division:

		vsync_rate_hz = div64_u64((u64)timing->pix_clk_100hz * 100,
					  (u64)timing->v_total * timing->h_total);


> +		if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
> +		    IP_VERSION(3, 5, 0) ||
> +		    acrtc_state->stream->link->psr_settings.psr_version <
> +		    DC_PSR_VERSION_UNSUPPORTED) {
> +			if (vsync_rate_hz)
> +				/* at least 2 frames */
> +				offdelay = 2000 / vsync_rate_hz + 1;

Or even this:

  2000 / (timing->pix_clk_100hz * 100 / (timing->v_total * timing->h_total)) =

  2000 / 100 * timing->v_total * timing->h_total / timing->pix_clk_100hz =

  20 * timing->v_total * timing->h_total / timing->pix_clk_100hz

⇒ offdelay = div64_u64((u64)20 * timing->v_total * timing->h_total,
		       timing->pix_clk_100hz) + 1;


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
