Return-Path: <SRS0=Gsig=FH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA4FC4361A
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 20:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5310421E92
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 20:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5310421E92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1AD66E03D;
	Thu,  3 Dec 2020 20:19:52 +0000 (UTC)
Received: from mail2.protonmail.ch (mail2.protonmail.ch [185.70.40.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 538C96E03D
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Dec 2020 20:19:51 +0000 (UTC)
Date: Thu, 03 Dec 2020 20:19:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1607026789;
 bh=/LgdJvHC0qi73sVZWTR1w8NxS5Zjvc9fARLcbDg0AW8=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=Ewk7dK1KthzwITBZxZQCtBq3hL3wXmFyDIsPItjIc5XtLf0d1L7wXeSpe8lu52X7/
 sRneKwvW9fxYmx95OD3AKqiYoC+VYdxaHMN5WhWk9ADE3ob5CF1iojmsaV8zA99Y9k
 cXpQLwn608laxuHN8gwe9wyoKHnN7kHSGLO0aK/AiLTBssnHeWE2q7MyrWG/rfcWvT
 2w6uKwQ6Afm7R9l5j7vg2dwAaNZgL+MHWmrR5G2WcckFBoieEeF4Jq4PceAqCYwl8t
 Hc6Fi9MOS3SfzmfoP9envP7/RIwuuBNkrCZp8388bhrNTImyuBheASagnXwO48h4JG
 z5lwuecJ8ZQfQ==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH 2/2] drm/amd/display: check cursor FB is linear
Message-ID: <JrpTBOVYpzRt8W1KDK3aNwqf6dwNpfPQKZOEnJgND0@cp3-web-020.plabs.ch>
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
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Previously we accepted non-linear buffers for the cursor plane. This
results in bad output, DC validation failures and oops.

Make sure the FB uses a linear layout in the atomic check function.

The GFX8- check is inspired from ac_surface_set_bo_metadata in Mesa.
The GFX9+ check comes from convert_tiling_flags_to_modifier.

Signed-off-by: Simon Ser <contact@emersion.fr>
References: https://gitlab.freedesktop.org/drm/amd/-/issues/1390
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 070bb55ec4e1..b46b188588b4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8978,7 +8978,10 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 			      struct drm_plane_state *new_plane_state,
 			      struct drm_framebuffer *fb)
 {
+	struct amdgpu_device *adev = drm_to_adev(new_acrtc->base.dev);
+	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(fb);
 	unsigned int pitch;
+	bool linear;
 
 	if (fb->width > new_acrtc->max_cursor_width ||
 	    fb->height > new_acrtc->max_cursor_height) {
@@ -9013,6 +9016,22 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 		return -EINVAL;
 	}
 
+	/* Core DRM takes care of checking FB modifiers, so we only need to
+	 * check tiling flags when the FB doesn't have a modifier. */
+	if (!(fb->flags & DRM_MODE_FB_MODIFIERS)) {
+		if (adev->family < AMDGPU_FAMILY_AI) {
+			linear = AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_2D_TILED_THIN1 &&
+			         AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_1D_TILED_THIN1 &&
+				 AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE) == 0;
+		} else {
+			linear = AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0;
+		}
+		if (!linear) {
+			DRM_DEBUG_ATOMIC("Cursor FB not linear");
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.29.2


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
