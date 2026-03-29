Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F22AF3D602
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Mar 2026 09:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28FA410E3DB;
	Sun, 29 Mar 2026 09:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lgfZccwr";
	dkim-atps=neutral
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F32010E0C2
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 04:40:25 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5a2b542cbaaso125964e87.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Mar 2026 21:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774759224; x=1775364024; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwayw7hVc2wLnLxV5KmPEi139DKPQvAF6YzQKlIAl14=;
 b=lgfZccwr3fDImH0P8XMZvnCFLnY82HJqoVTVyS86BFuJsZbyiUJxIxfVfTF1lm8eeC
 vIWCWlfznj2z3JaEGKrgbkULCm+UogNHt9gSOZXm4QMhyxQWIqzRHH1t09kusBPk3caV
 LrD3OpTdlFSsuCpH8rPrzULdQKq/WbJ575ERIKVAfGAkhcDzhKGqxdnHVthuZ6UYbZLF
 vK0oaMREu8ey5oZAnm1DVZUFp0ISQbt6nfFzi0fPVRi7P7dNRRUD9x/yMYc3n6gohNO3
 oMsQf2KU1xJGTz3ZDdoTHlNQZUBxD4CFTeGHWydkrs6GxTIJiAbH0HtiNy7V4p1Y4rur
 I6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774759224; x=1775364024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kwayw7hVc2wLnLxV5KmPEi139DKPQvAF6YzQKlIAl14=;
 b=XcgSwEdJjrbi899jDT63NV5WbIDxy1utGS2UbgtA99/R9oa4BmYtiyTgNG0h8Yb56M
 JTR9Bjn1YQ8D/I80qEBD7ecrUl7GkJu+4Zdu9bRiijJbwCc8wXigt+mrPsuJGhjy5EDy
 gxcxKfg4y4DPYFiZ/sNRXHf3VbOGlTInUKBiO6t6EMd2R5iqtjKVeeo5mlEo7CtRoNwC
 FVS1gdSvrt/Vtd0YyRqpaeIyiMfURdtSkqBC15JZzXVe7uxRy/kJdgJiyIu7egnzmX9W
 UJOwcLECQ7geC6UespAynvImTgjnVIKApAZpWSheABPyjPwYTi4Xr28H85crsT8COwQ3
 k1tg==
X-Gm-Message-State: AOJu0YyvD9X6JKLlFxk+TcJI/1DRutB4BD9/kOm12Xrm5Akqcxx2929S
 aB8GP0cKJs4XzeRp1+eL35CYKXrQgafpIwe2oU3k99q9vQwmqyXoQrsk7CwUWek=
X-Gm-Gg: ATEYQzwJnyYPamN1hyJONg0sUgrNNco5/oGQF9w/BJ7DlZ3sWvzOhwR/HUAT0/tBEcy
 R4MujInzUIKb8GPTdK/6IQe2ba4TI8NBxviYrQD3Nlnirvl7onMj+7Ak8aYu5VwB5R/Uf5tztxs
 inZvrB2BB/Yb1IJM3WfoOEzGVhZA7geUeG5ecUaZfl4ElWSraJ/7tt+N7YwPwNH2BWPOWQJF/W3
 2sv3WtzPpjndXHHkIaqWJo8EQYTaFH7PjAHLpQT0zkTfrprrx/ofDZyupJ4PVjQbQq5ewxHHJeA
 xEnutoHEu9ltYJUyA3thF5gZMl/TbUMT1qoQMM6WJcpX+pscM/CfMtGx2KPswcYzoxKwO0enkEN
 P2ImAeSvxlC4j8kXt1hms5nsm0+dl3K5g+3UlcPszkZpPFRNtk+X1R5oqbMxvQQFN9BsMsZQ97o
 CSVak351e+NyxlKPysbLO2DNAusuo=
X-Received: by 2002:ac2:43d2:0:b0:5a2:aec9:95f8 with SMTP id
 2adb3069b0e04-5a2aec997cfmr1288731e87.17.1774759223449; 
 Sat, 28 Mar 2026 21:40:23 -0700 (PDT)
Received: from fedora.localdomain ([2a11:3805:0:93::1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b145772fsm836212e87.71.2026.03.28.21.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 21:40:23 -0700 (PDT)
From: Sbenazar <voroninan95ton@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, Sbenazar <voroninan95ton@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v3 3/4] drm/amd/display: force full frame updates for Replay
 on DCN 3.14
Date: Sun, 29 Mar 2026 07:40:07 +0300
Message-ID: <20260329044014.30276-4-voroninan95ton@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329035830.21953-1-voroninan95ton@gmail.com>
References: <20260329035830.21953-1-voroninan95ton@gmail.com>
 <20260329044014.30276-1-voroninan95ton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 29 Mar 2026 09:57:18 +0000
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

On DCN 3.14 (Phoenix/Hawk Point, Radeon 780M), the DMCUB firmware
produces visual artifacts when Panel Replay operates in selective update
mode. The artifacts manifest as brief green/purple horizontal bands
during any screen content change — workspace switches, scrolling in
browsers, window management — and do not appear in screenshots,
confirming the corruption occurs at the display controller level rather
than in the compositor or rendering pipeline.

The issue is widely reported across multiple vendors (Framework 16,
Lenovo T14, HONOR MagicBook) and Linux distributions, tracked upstream
as drm/amd#5087. The current community workaround is to disable Panel
Replay entirely via amdgpu.dcdebugmask=0x410.

DCN 3.14 uses FreeSync Replay (DC_FREESYNC_REPLAY), not VESA Panel
Replay. Unlike the VESA variant, FreeSync Replay does not have a DPCD
SELECTIVE_UPDATE_ENABLE bit — selective update behavior is driven by the
dirty rects that the driver sends to DMCUB via DMUB_CMD__UPDATE_DIRTY_RECT.

Fix this by forcing fill_dc_dirty_rects() to always emit a full-frame
dirty rect (FFU) when Replay is active on DCN 3.14. This way DMCUB
always receives a single full-screen region and never attempts a partial
selective update. Panel Replay still allows the panel to sleep when the
screen is static — only the update granularity changes from partial to
full-frame.

The caller guarantees that dm_crtc_state->stream is non-NULL (the
function is only called when psr_feature_enabled or
replay_feature_enabled is set on the stream's link), so no additional
NULL check is needed.

The DMCUB firmware on newer generations (DCN 3.2+) handles selective
updates correctly and is not affected by this change.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/5087
Cc: stable@vger.kernel.org
Signed-off-by: Sbenazar <voroninan95ton@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6347,6 +6347,16 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 	if (new_plane_state->rotation != DRM_MODE_ROTATE_0)
 		goto ffu;

+	/*
+	 * Force full-frame updates for Replay on DCN 3.14 (Phoenix/Hawk Point).
+	 * The DMCUB firmware on this generation produces visual artifacts when
+	 * processing selective updates within Panel Replay. Sending a single
+	 * full-screen dirty rect avoids the buggy SU code path in firmware.
+	 */
+	if (dm_crtc_state->stream->link->replay_settings.replay_feature_enabled &&
+	    dm_crtc_state->stream->ctx->dce_version == DCN_VERSION_3_14)
+		goto ffu;
+
 	num_clips = drm_plane_get_damage_clips_count(new_plane_state);
 	clips = drm_plane_get_damage_clips(new_plane_state);

--
2.48.1

