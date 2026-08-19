Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB21C5DF6D
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 07:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA3CA10E0DC;
	Wed, 19 Aug 2026 07:27:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bcnzSu3A";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09EA610E0DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 07:27:29 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hPynn41f4z8v2C;
 Wed, 19 Aug 2026 09:27:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787124445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MKJ8aN14i/bEt+k8ZEzjkHeWRc2zm+bl6gMVfHAcnX0=;
 b=bcnzSu3AUtwA6wFul9l+E2Z7ztDXxxfIFqma+3GaSslaMp2GDhTeAjiyv8r7vwgzqKONBP
 MBzPK6RTAb9bfNiK8beKwFZIPxV6Nimrwz5diw+Ouc5mWzKnYZpuHZalKmYRKf6iN+Jaq+
 9eMtuk2FZrjiVW8bZL92cysEdMTAska6mCem6VpM3/WF2CbxfTlHHqUDNQODjaaxe8uA7I
 oxzq67xpbi+NIaoTmyj5xb4urwR9kLqXGZNdS5Ysvnj+HYsHg0kS8yr0olZ1mLMhcF4jSL
 RRHrZP+lb+yj0LkrEN3dqveH23jZL6XASB/9pgH3+gM4BFJVLxYUxGBs1edHbw==
Message-ID: <bec41455-2fbd-40fc-ade6-bc908c4e9045@mailbox.org>
Date: Wed, 19 Aug 2026 09:27:20 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 01/82] drm/amd/display: Fall back to overlay cursor on
 dcn4x when top plane doesn't fill CRTC
To: IVAN.LIPSKI@amd.com, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>,
 James Lin <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
 <20260818202139.4172592-2-IVAN.LIPSKI@amd.com>
Content-Language: en-CA
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20260818202139.4172592-2-IVAN.LIPSKI@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 63q9brzarb36gkcmqihaip8jj635pomh
X-MBO-RS-ID: b5832baa3492829ffa8
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


[ Adding Timur ]

On 8/18/26 22:14, IVAN.LIPSKI@amd.com wrote:
> From: James Lin <PingLei.Lin@amd.com>
> 
> [why]
> amdgpu_dm_crtc_get_cursor_mode() returns DM_CURSOR_NATIVE_MODE early and
> unconditionally for dcn4.x. That early return was added because these
> ASICs no longer have the cursor-on-scaled-plane or cursor-on-yuv-plane
> restrictions of older DCN, so native cursor is fine in those cases.
> However, it also bypasses the "does the top plane fill the CRTC?" (hole)
> evaluation further down. When the top/primary plane does not cover the
> whole CRTC, the cursor must fall back to an overlay plane so it is
> composited over the uncovered region; keeping the native cursor there
> produces an incorrect result. As a consequence
> igt@amdgpu/amd_cursor_overlay@non-full, which verifies exactly this
> native->overlay fallback, fails on dcn42.
> 
> [how]
> Change unconditional early return with a skip_fmt_scale_restrictions flag.
> For dcn4.x keep skipping the YUV / active-color-pipeline / different-scale
> overlay triggers (genuinely unnecessary on this hardware), but fall
> through to the existing entire_crtc_covered check so a top plane that does
> not fill the CRTC still selects DM_CURSOR_OVERLAY_MODE. Native mode is
> still chosen when the plane covers the whole CRTC.
> 
> Update the amdgpu_dm_cursor KUnit tests accordingly: exercise the dcn4x
> path with a full atomic state fixture (full coverage -> native) and add a
> dcn4x hole case (top plane does not fill the CRTC -> overlay).
> 
> Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: James Lin <PingLei.Lin@amd.com>
> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c  | 28 ++++++++--------
>  .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   | 32 +++++++++++++------
>  2 files changed, 38 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
> index 9534848ed240c..c41fce07b8fa8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
> [...]
> @@ -300,15 +297,17 @@ int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
>  	 */
>  	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1) ||
>  	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0) ||
> -#if defined(CONFIG_DRM_AMD_DC_DCN6_0)
>  	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1) ||
>  	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(6, 0, 0) ||
> -#else
> -	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1) ||
> -#endif
>  	    !dm_crtc_state->base.enable) {
> -		*cursor_mode = DM_CURSOR_NATIVE_MODE;
> -		return 0;
> +		/*
> +		 * Newer DCN has no cursor-on-scaled/yuv-plane restriction, so
> +		 * skip those overlay triggers below. A plane that does not fill
> +		 * the CRTC still needs overlay mode so the cursor renders over
> +		 * the hole, so fall through to the coverage check instead of
> +		 * unconditionally forcing native mode here.
> +		 */
> +		skip_fmt_scale_restrictions = true;
>  	}

Timur, looks like this might break your fix in cea54c52d82d ("drm/amd/display: Set native cursor mode for disabled CRTCs") again.

Maybe the CRTC disabled case should be handled separately from the DCE cases after all.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
