Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CD2C88E59
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Sep 2026 15:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC74410E519;
	Sat, 12 Sep 2026 15:11:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aheymans-xyz.20251104.gappssmtp.com header.i=@aheymans-xyz.20251104.gappssmtp.com header.b="OnLQY6xd";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B491910E519
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Sep 2026 15:11:40 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd38e0f79so3850155e9.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Sep 2026 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aheymans-xyz.20251104.gappssmtp.com; s=20251104; t=1789225899; x=1789830699;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UNp2ej2UnoB5ep8eGYhUlJSsYiFkYUAkgSgRSLrvMp8=;
 b=OnLQY6xdVthyF8lmvVo62Q/jTN81tWCvk85jsciR762oUVyXXl1tb5vNO7aMMjF2bT
 sIxqX1pT4U3W9LsPOU1V/ncML0zE9Fv1ymzrrr2u1CsQZ6N/O6CPGahyqYdyT3quqzAN
 DVR8kZvVO0jYEANU6atCHN0WIwGcaG9g7ZoBKhvZXZjSZSqKjhabX4XgKP4uPhbxTnqi
 uXb8EuUVJKnPWZOLPiavap2cxornQvYWEbmAnPaXwAXCvzs5R4AjRJYEcSKH9/drzDcM
 FLJp8ZnjyMS4ct2EUQ+Hh7PSxfmRIIbbZX1L33poh8A9wvsRC3xamK+3gvI8CZbFp2y6
 Y/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789225899; x=1789830699;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UNp2ej2UnoB5ep8eGYhUlJSsYiFkYUAkgSgRSLrvMp8=;
 b=m2aT/xDj8lAf5jwb2XOtFvpAvCuBpEDrUh46NAfYj9/5S86D6yssIgx6PKEkrQ91o0
 TY7Lx2m5zXb3vCMPBqC9Zk+YiOOjh9icHzjUlY573sG5eiUQwDP09tDEwPAhE7/K0i5h
 OouDH5g8QoGcTtdoiSvjTZ+KCCYculwVr1+fwyt97nAZdiigmttN5pmjj2HS7eRrAB1a
 P5pI1xhVJtihIZb3uWWWzMTBT08d5uEzSp4U+hWStYNSc/Fi0vZmKktIimUUxpKsXj+p
 thcmysHK2q81n4XQWyviABiLsNf9N6QpAYFaT3dAez2HWR2xNWFoAB7/WTfkpo4DVavN
 cn0g==
X-Gm-Message-State: AFuF++laAFB/6TsdziLGRP7PxnGHYG4/wiLtestJF6FhqO1c5kJa8c5E
 ziXuQwgpdzEhmvT5p7w+R/RAH/Ej+PaBR8IUMjGUHPrerNAjARUKPc4bQYIhZtK9iQszxyPgzsa
 zTYkEy1Zn6g==
X-Gm-Gg: AYBFou3qfHDgbF1A+yQHBi8uVy3gMhOQ2fX19aGp2W2Z+xTq0FzIy7wNInkHwuB6ZHx
 xyCfrtS7BebeK5xIhDUxDgMgPgMGiNlCdukvSgpCzl91G1MOmYU2lvX5JDVrZgy5+xrqkRSvVAU
 U3Ayn/8del/q6ROU+DPsXfWVHGT6bUT09WUvjLoK/vrDSF6lN48f54lhRjqWPWcTKHcXfrkUGR2
 ah6novNdA1RPfLlX3c+cfchSIqWNJmHV4p+LcSv5JfExvYC+72+9t3yceTYpwdE5jg4U7DIIOPr
 a7AWwMG3UcQoRi2ThT1tBv6jfEeI19fNUbKEsPAP4DFE3tnuvgefbufw+BxzURGMR9g2H98i5tW
 5UxoQjppS0K83k+5qdYCDamrRuBQ6MIpKDZpn4KyYkVWFJVeG2Z4dFFlWc/6dyOLjVYyUrwzFPg
 3FZvKxonQucIwanRJVb6/pKx7OSfnZybzsDCIV6n+enHpWU42uDvz1GVlb5XyIX/6UM3MTY6rv/
 +GTVDCkgn33MtR0Rvjp/0tqxIWrsZnqXKF5WUKS1WVFWrp3KEBtQDF1qthmFSR1k55CgyP4U4jT
 YatchKkI2naeuJgzkbyG71SxYXBv9Sl/HgPYQt4=
X-Received: by 2002:a05:600c:2301:b0:49d:2555:1a6d with SMTP id
 5b1f17b1804b1-49e619cbf88mr155925425e9.16.1789225898398; 
 Sat, 12 Sep 2026 08:11:38 -0700 (PDT)
Received: from localhost
 (2a02-1810-b422-d400-af60-1d41-c104-7560.ip6.access.telenet.be.
 [2a02:1810:b422:d400:af60:1d41:c104:7560])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60adaeefsm162063135e9.12.2026.09.12.08.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 08:11:38 -0700 (PDT)
From: Arthur Heymans <arthur@aheymans.xyz>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 michael.mityushkin@amd.com, nicholas.kazlauskas@amd.com,
 qingqing.zhuo@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Arthur Heymans <arthur@aheymans.xyz>,
 stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: Preserve eDP mode on initial ASSR failure
Date: Sat, 12 Sep 2026 17:11:37 +0200
Message-ID: <20260912151137.3913987-1-arthur@aheymans.xyz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
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

Commit 56d8ce9d8c17 ("drm/amd/display: Apply correct panel mode when
reinitializing hardware") made ASSR failure fall back to the default panel
mode unless eDP mode had previously been applied.

However, dc_link is zero-initialized and DP_PANEL_MODE_DEFAULT is zero.
Before the first call to dp_set_panel_mode(), panel_mode therefore looks
like a previously applied default mode. If ASSR setup fails during the
first link training attempt, the driver incorrectly trains the eDP link
using the default scrambling mode.

On a Google Vilboz Chromebook running self-built coreboot firmware and
PSP verstage, this leaves the panel mostly black with corrupted output
along the top edge.

Track whether panel_mode has actually been initialized, and only consult
the saved mode after it has been applied. This retains the recovery
behavior while preserving eDP mode during initial link training.

Fixes: 56d8ce9d8c17 ("drm/amd/display: Apply correct panel mode when reinitializing hardware")
Cc: stable@vger.kernel.org # v6.4+
Assisted-by: Pi:gpt-5.6-sol
Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
---
 drivers/gpu/drm/amd/display/dc/dc.h                           | 1 +
 .../amd/display/dc/link/protocols/link_edp_panel_control.c    | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4ecd5699ac5e..0db55a73da0c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1912,6 +1912,7 @@ struct dc_scratch_space {
 	struct ddc_service *ddc;
 
 	enum dp_panel_mode panel_mode;
+	bool panel_mode_initialized;
 	bool aux_mode;
 
 	/* Private to DC core */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 9883216dcc9d..cd90576bc6f0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -93,6 +93,7 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
 	}
 
 	link->panel_mode = panel_mode;
+	link->panel_mode_initialized = true;
 	DC_LOG_DETECTION_DP_CAPS("%d eDP panel mode supported: %d, enabled: %d\n",
 				 link->link_index,
 				 link->dpcd_caps.panel_mode_edp,
@@ -1300,7 +1301,8 @@ void edp_set_panel_assr(struct dc_link *link, struct pipe_ctx *pipe_ctx,
 
 		result = cp_psp->funcs.enable_assr(cp_psp->handle, link);
 
-		if (!result && link->panel_mode != DP_PANEL_MODE_EDP)
+		if (!result && link->panel_mode_initialized &&
+		    link->panel_mode != DP_PANEL_MODE_EDP)
 			*panel_mode = DP_PANEL_MODE_DEFAULT;
 	}
 }
-- 
2.55.0

