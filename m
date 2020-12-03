Return-Path: <SRS0=Gsig=FH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51909C4361A
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 20:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C99BD21E92
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 20:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99BD21E92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 479096E038;
	Thu,  3 Dec 2020 20:19:44 +0000 (UTC)
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch
 [185.70.40.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DA276E038
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Dec 2020 20:19:42 +0000 (UTC)
Date: Thu, 03 Dec 2020 20:19:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1607026780;
 bh=j577KMdp9nDGI4/VvkPuJNJT4L1V5BITiUxSVcnDQVM=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=TpowXUu3tYQUFVTzoo2NuhIGV4fb986ltcdUtYoUKoIb6eyNwpDYb5Mlg360v2htw
 RRrqcBYMftu0iqo09+es3Gz6adWDUjjel1JTPFRBS/17vCz+ZW6+qMu5gQmcd8z1yz
 tJjkwOD3RYCRveO0xUL5JZXLj7zJ9RZCH6eiqQPBR/5/cFeLv4eyEGrG5gftkFd+Vp
 wibacax3DKUebJHo59ipscaS/OY4J6OTDysSeeJL/Tt8KlNRxeK8IXVw/kM/G8kJLM
 xS747J6joc90+aDGJq4eCQYD72gveRO2UaWTGBY3gIs6gxwH2LVfgtzbprlOs5LpUX
 VUMqxu1WbaJyw==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH 1/2] drm/amd/display: extract cursor FB checks into a function
Message-ID: <1wAjTe0S3RNdK8GVTWfZWnlguby1E0TmkR1XlDiIOA@cp7-web-042.plabs.ch>
MIME-Version: 1.0
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As more checks are added, the indentation makes the code harder to read.

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 81 +++++++++++--------
 1 file changed, 46 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 313501cc39fc..070bb55ec4e1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8974,6 +8974,48 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	return false;
 }
 
+static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
+			      struct drm_plane_state *new_plane_state,
+			      struct drm_framebuffer *fb)
+{
+	unsigned int pitch;
+
+	if (fb->width > new_acrtc->max_cursor_width ||
+	    fb->height > new_acrtc->max_cursor_height) {
+		DRM_DEBUG_ATOMIC("Bad cursor FB size %dx%d\n",
+				 new_plane_state->fb->width,
+				 new_plane_state->fb->height);
+		return -EINVAL;
+	}
+	if (new_plane_state->src_w != fb->width << 16 ||
+	    new_plane_state->src_h != fb->height << 16) {
+		DRM_DEBUG_ATOMIC("Cropping not supported for cursor plane\n");
+		return -EINVAL;
+	}
+
+	/* Pitch in pixels */
+	pitch = fb->pitches[0] / fb->format->cpp[0];
+
+	if (fb->width != pitch) {
+		DRM_DEBUG_ATOMIC("Cursor FB width %d doesn't match pitch %d",
+				 fb->width, pitch);
+		return -EINVAL;
+	}
+
+	switch (pitch) {
+	case 64:
+	case 128:
+	case 256:
+		/* FB pitch is supported by cursor plane */
+		break;
+	default:
+		DRM_DEBUG_ATOMIC("Bad cursor FB pitch %d px\n", pitch);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int dm_update_plane_state(struct dc *dc,
 				 struct drm_atomic_state *state,
 				 struct drm_plane *plane,
@@ -8991,7 +9033,6 @@ static int dm_update_plane_state(struct dc *dc,
 	struct amdgpu_crtc *new_acrtc;
 	bool needs_reset;
 	int ret = 0;
-	unsigned int pitch;
 
 
 	new_plane_crtc = new_plane_state->crtc;
@@ -9012,40 +9053,10 @@ static int dm_update_plane_state(struct dc *dc,
 		}
 
 		if (new_plane_state->fb) {
-			if (new_plane_state->fb->width > new_acrtc->max_cursor_width ||
-			    new_plane_state->fb->height > new_acrtc->max_cursor_height) {
-				DRM_DEBUG_ATOMIC("Bad cursor FB size %dx%d\n",
-						 new_plane_state->fb->width,
-						 new_plane_state->fb->height);
-				return -EINVAL;
-			}
-			if (new_plane_state->src_w != new_plane_state->fb->width << 16 ||
-			    new_plane_state->src_h != new_plane_state->fb->height << 16) {
-				DRM_DEBUG_ATOMIC("Cropping not supported for cursor plane\n");
-				return -EINVAL;
-			}
-
-			/* Pitch in pixels */
-			pitch = new_plane_state->fb->pitches[0] / new_plane_state->fb->format->cpp[0];
-
-			if (new_plane_state->fb->width != pitch) {
-				DRM_DEBUG_ATOMIC("Cursor FB width %d doesn't match pitch %d",
-						 new_plane_state->fb->width,
-						 pitch);
-				return -EINVAL;
-			}
-
-			switch (pitch) {
-			case 64:
-			case 128:
-			case 256:
-				/* FB pitch is supported by cursor plane */
-				break;
-			default:
-				DRM_DEBUG_ATOMIC("Bad cursor FB pitch %d px\n",
-						 pitch);
-				return -EINVAL;
-			}
+			ret = dm_check_cursor_fb(new_acrtc, new_plane_state,
+						 new_plane_state->fb);
+			if (ret)
+				return ret;
 		}
 
 		return 0;
-- 
2.29.2


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
