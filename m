Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02475E9A03B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 09:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C95D10E59A;
	Wed, 18 Feb 2026 09:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NBQjIkWO";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13BD310E59A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 09:41:39 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fGBNZ6qTFz9tH7;
 Wed, 18 Feb 2026 10:41:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1771407695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5aVmk7oksWt/qb/f/B5GRueSM0fybjF6JjCRZ+Jap1Q=;
 b=NBQjIkWOpOzUxqqK0qPQ5a+7RSdGDE8L3Q/dXZ4t9YQr1TIU1/9GAM+kAJ+ZZg9pcVUxyH
 rJ0u7JXRSqvvUR85BfrZotJ9HM53UwBx9M5bQDurwzymO1XN5qP1nfVP/WJubsrsPbz0yG
 wBfDdU3iWoZDn5dgzRIvvKPpfx6ux2R02BL+vyVC/+H67gv6ztIPxrV/kko9oFUAQOwJqc
 Coy5dg6HN5cnuwrj2PG4EdK1t5MhlU0BUFypLI/tgWKGRFzbYOM5PrbXx7UhKTMP/ijllC
 jjqRqvcAwb2+X28Ztbdsh/MIMdiSJq7kwq3nVcGgO6Y/JWErhMcM57EsxAfUng==
Message-ID: <02cb98e2-5666-45ca-be15-93c93f517238@mailbox.org>
Date: Wed, 18 Feb 2026 10:41:32 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Michele Palazzi <sysdadmin@m1k.cloud>, amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 sunpeng.li@amd.com
References: <20260218003104.1256473-1-sysdadmin@m1k.cloud>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20260218003104.1256473-1-sysdadmin@m1k.cloud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b2b31ea18ee17763b6e
X-MBO-RS-META: xziodijob88nqdek4drzuczt96tyk487
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

On 2/18/26 01:31, Michele Palazzi wrote:
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a8a59126b2d2..35987ce80c71 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10168,8 +10168,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>  	} else if (cursor_update && acrtc_state->active_planes > 0) {
>  		spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
>  		if (acrtc_attach->base.state->event) {
> -			drm_crtc_vblank_get(pcrtc);
> -			acrtc_attach->event = acrtc_attach->base.state->event;
> +			drm_crtc_send_vblank_event(pcrtc, acrtc_attach->base.state->event);

Can this code run before start of vblank? If yes, the event would have the wrong sequence number and timestamp.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
