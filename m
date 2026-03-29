Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F22EF3D600
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Mar 2026 09:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7759A10E2C1;
	Sun, 29 Mar 2026 09:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a3HyutMx";
	dkim-atps=neutral
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7A2010E087
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 03:58:39 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-59e4a04f059so3491325e87.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Mar 2026 20:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774756718; x=1775361518; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LaBnkj4q34KLx3lNj+b95IrchjrEJG61P5Z/zGq1Xg=;
 b=a3HyutMxTgQW737vv2h9+izYP09E/i4+Ce1H2vo7ANFU9Zbrq4FfgJJERmpnsQSP5c
 nUpo9X8n26jZdaSOZq9aRk/ogYvFfzZB1hX6zKTfX0X9LvTi5nKWp0CMz4HofwgEO5GY
 Tur2fLCXHcReVs2Q0UHVVwQT13zwYDVCNRh/4y9FFexm/lnTp7U5wklUqa5TwLCICgSm
 AyYukApoCQSM1ucOxMfgqF+Ru7sD24/DtBQKUe4Q3GtZ5XMB+m0NYE6D6r5+SMwxW4Ek
 nqvTH8DkBYzG1i54EJ3BT4bGbGVqwrLngXJ/WwiXG7qQ2u8KzzFZZrf6px6DFzvtSree
 2MHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774756718; x=1775361518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2LaBnkj4q34KLx3lNj+b95IrchjrEJG61P5Z/zGq1Xg=;
 b=hbuPLO6oYoh1nZ6ZP+uZdQ4DONvNa+nMqTi0mbt+NbNAtUDReCmWEcOcZS8UgXfZ6/
 8vdebMa9TyeQ92oPCGUsV2tZ/nGgrt6WthdbvWpA5BmA0vqnXhGk3YIEK0IorY2tRszD
 uJUwwda3nCbpISoS0j+Pm22TiYTv3wW7C1ZZI/1lQUUnFmlvXBBCoSbhSZ5xhrGkwKTJ
 fxFHzwgZRHaLEuRV/Db8fUwMXc6XTOIBm0H+1KzYcIOa8laNUTrrcwhYW6UxXz/MCeRu
 O3xP4q9XUpjjUEWOfDvCmJsDSloHou9dGBHx6JQXNBfJp547Ml7pPfRDfH1FXC7Z6v0j
 ihyA==
X-Gm-Message-State: AOJu0YxTPi3nnjLEJ1OKlfY69tEFZeGLuExFhnmgMclwkiqLO0O6jBM4
 z/Z+pst+bvYp686jWTtIQVccVxwzgFAzURHQsGFuQGmkFWpWIT5G2BNfiB/6RvV2fg==
X-Gm-Gg: ATEYQzwdatFDMKLs3smZkhJo6S9lAic02FpRA5jcPyEVPkYR3A276GFd+ZThdfRNovZ
 YB/7tWpSiOkV4lmOsTdfAOjQziM1Q4PzijQc8ZKPxhXFmaH92/dh3qZvlKOllDrKN8cs3MUSB8Q
 onN8/iDfDLYmKQakxNW9oY9lJe4opclE23ScKQ7SsmQdog8XnkwE94hanxci49eQNEOjQ0wGAS7
 zWBFwaJay01MRVyEt9NCl0+644BN4M4AL86RICZwbiqSqHeBTBnzA2aG9e8/Y79JThHTdDiX/1c
 T3oqpUxL1MxbG4sJoR/ncGeqF1dVCdaQ7+5Po4Pb/AP2u4UKcX1QhJ1Ilt5asxZT8n5+EFu6GTx
 VbsliQ75jz6evkHYYTLc3Wy52EcUTs8V29kK+D6KEXFx7mH/W705WE3nVmus3M71LVBif4VsZlk
 gUhiiVdahONL1qpoNu7yGRiOjzN5+Y0bYACXOiBg==
X-Received: by 2002:a05:6512:39d2:b0:5a1:7434:6b2b with SMTP id
 2adb3069b0e04-5a2ab925fbbmr2914375e87.27.1774756717809; 
 Sat, 28 Mar 2026 20:58:37 -0700 (PDT)
Received: from fedora.localdomain ([2a11:3805:0:93::1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b13f41f4sm806136e87.13.2026.03.28.20.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 20:58:37 -0700 (PDT)
From: Sbenazar <voroninan95ton@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, alex.deucher@amd.com, tom.chung@amd.com,
 Sbenazar <voroninan95ton@gmail.com>, stable@vger.kernel.org
Subject: [PATCH 3/3] drm/amd/display: disable Panel Replay selective update on
 DCN 3.14
Date: Sun, 29 Mar 2026 06:58:29 +0300
Message-ID: <20260329035830.21953-4-voroninan95ton@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329035830.21953-1-voroninan95ton@gmail.com>
References: <20260329035830.21953-1-voroninan95ton@gmail.com>
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

Rather than disabling Panel Replay altogether and losing its power
savings during static screen periods, disable only the selective update
component on DCN 3.14. With SU disabled, Panel Replay still allows the
panel to enter low-power mode when the screen is static, but any pixel
change triggers a full frame update instead of a partial one. This
avoids the DMCUB firmware's buggy SU code path while preserving the
primary power saving benefit of Panel Replay.

The DMCUB firmware on newer generations (DCN 3.2+) handles SU correctly
and is not affected by this change.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/5087
Cc: stable@vger.kernel.org
Signed-off-by: Sbenazar <voroninan95ton@gmail.com>
---
 .../dc/link/protocols/link_edp_panel_control.c    | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1055,7 +1055,16 @@ static bool edp_setup_panel_replay(struct dc_link *link, const struct dc_stream_
 	if (link->replay_settings.replay_feature_enabled) {
 		pr_config_1.bits.PANEL_REPLAY_ENABLE = 1;
 		pr_config_1.bits.PANEL_REPLAY_CRC_ENABLE = 1;
-		pr_config_1.bits.PANEL_REPLAY_SELECTIVE_UPDATE_ENABLE = 1;
+		/*
+		 * Disable selective update on DCN 3.14 (Phoenix/Hawk Point).
+		 * The DMCUB firmware on this generation produces visual
+		 * artifacts during selective updates. Full frame updates
+		 * within Panel Replay still work correctly and preserve
+		 * static-screen power savings.
+		 */
+		pr_config_1.bits.PANEL_REPLAY_SELECTIVE_UPDATE_ENABLE =
+			(link->ctx->dce_version != DCN_VERSION_3_14) ? 1 : 0;
+
 		pr_config_1.bits.PANEL_REPLAY_EARLY_TRANSPORT_ENABLE = 1;

 		pr_config_1.bits.IRQ_HPD_ASSDP_MISSING = 1;
--
2.48.1

