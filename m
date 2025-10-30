Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97854CCF9E3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 19:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 194D210E32C;
	Thu, 30 Oct 2025 19:39:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RRR4pN63";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD2C610E32C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 19:39:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6E6F740977
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 19:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3360C4CEF1;
 Thu, 30 Oct 2025 19:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761853188;
 bh=c3Oq5XDkcAS1NTdkKIyRFxb1nFrDWdUFy+wwJ4DmS+A=;
 h=From:To:Cc:Subject:Date:From;
 b=RRR4pN63St6mqkRTgEzQiQwilEvhhSWbsn49/2j2aV/HP4WwZD4vA3FpkbEwXR9QV
 FK61TjErMHEOzortfO7oxcDL1jCRQ1/cut7iNZoBKjY7/CAcrvaUaFa5Be7SpVUB3l
 VZklGRtezyW3wsXE+KRfenGf/gGHTOCAD2/6TMfRjewlXZBpzGYe9wQkVvW+syUgJZ
 1RBLO2m7VRAKHna7/AaZeMwxECllwya2H4GXVP+s3rRjv2GjZRebX+qsYKjC/FEqx3
 KUPQhwLs1WFNSbZdtQcthLC7rBNTjLk9DqPyfwYw8IvlNP/whoMYrKCFchVJu/SKel
 keYXphOWAZTTw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH] drm/amd/display: Don't stretch non-native images by default
 in eDP
Date: Thu, 30 Oct 2025 14:39:43 -0500
Message-ID: <20251030193943.4064454-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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

commit 978fa2f6d0b12 ("drm/amd/display: Use scaling for non-native
resolutions on eDP") started using the GPU scaler hardware to scale
when a non-native resolution was picked on eDP. This scaling was done
to fill the screen instead of maintain aspect ratio.

The idea was supposed to be that if a different scaling behavior is
preferred then the compositor would request it.  The not following
aspect ratio behavior however isn't desirable, so adjust it to follow
aspect ratio and still try to fill screen.

Note: This will lead to black bars in some cases for non-native
resolutions. Compositors can request the previous behavior if desired.

Fixes: 978fa2f6d0b12 ("drm/amd/display: Use scaling for non-native resolutions on eDP")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4538
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 29b9197bbbc32..5b279182e66a8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8078,7 +8078,7 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 				       "mode %dx%d@%dHz is not native, enabling scaling\n",
 				       adjusted_mode->hdisplay, adjusted_mode->vdisplay,
 				       drm_mode_vrefresh(adjusted_mode));
-			dm_new_connector_state->scaling = RMX_FULL;
+			dm_new_connector_state->scaling = RMX_ASPECT;
 		}
 		return 0;
 	}
-- 
2.43.0

