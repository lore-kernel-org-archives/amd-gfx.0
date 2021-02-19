Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5E6C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 18:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57BE064E77
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 18:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BE064E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E314A6EB84;
	Fri, 19 Feb 2021 18:58:39 +0000 (UTC)
Received: from mail1.protonmail.ch (mail1.protonmail.ch [185.70.40.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C5D46EB84
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 18:58:38 +0000 (UTC)
Date: Fri, 19 Feb 2021 18:58:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1613761116;
 bh=w6SpazH4gpNlwd3/uiYCQ1FpX8wZCq6slD9hiDFkhNo=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=Kjcy+iXXdf+jMOCUkhUDL8GU/M88opSydo9ztslHuC8fjkMMLc2hSlu/GJRwO1rcX
 t8FxdhOnYxoyEHyJMIm59iBJDbzfMTQ/vW9P7pYrVicbGEb7iBGvu0Pp9XDRfX6FX7
 1EyMwXXVvokG6OdRKAIyDjIqgPPgmApLUn3CHsq26KKDSU1D3QS32fDYSf/kfJbIki
 7jL3FDDcbOsW61e+yFFeuZqf5w3SQY2r4z9Ttk+rj5tdHT4QjTwlxJRxF/Pv3oSElq
 wmNOycpSnYNm6RVG/Gz2EJkAMYxgN3qvHK5Ug8Mq8xNOG3QHWt974IER0CMTVdJsfR
 8psi9qkM2fPDw==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH 6/6] amd/display: re-introduce cursor plane rotation prop
Message-ID: <ELwHAVaGFgB0jVKHG88gEco4oAaMyf95bQxdGR5y0@cp3-web-012.plabs.ch>
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

The commit 1347385fe187 ("drm/amd/display: don't expose rotation
prop for cursor plane") removed the rotation property for the
cursor plane, assuming the cursor would always be displayed without
any rotation. However the rotation is inherited from the underlying
plane.

As a result, if the primary plane is rotated, then the cursor plane
will incorrectly be rotated as well even though it doesn't have a
rotation property.

To fix this, re-introduce the cursor rotation property, and check
that its value matches the underlying plane's.

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d6ecc5826be9..c8b188c87d17 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6649,8 +6649,7 @@ static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 		DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 |
 		DRM_MODE_ROTATE_180 | DRM_MODE_ROTATE_270;
 
-	if (dm->adev->asic_type >= CHIP_BONAIRE &&
-	    plane->type != DRM_PLANE_TYPE_CURSOR)
+	if (dm->adev->asic_type >= CHIP_BONAIRE)
 		drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
 						   supported_rotations);
 
@@ -9250,6 +9249,11 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 		return -EINVAL;
 	}
 
+	if (new_underlying_state->rotation != new_cursor_state->rotation) {
+		drm_dbg_atomic(crtc->dev, "Cursor plane rotation doesn't match underlying plane\n");
+		return -EINVAL;
+	}
+
 	/* In theory we could probably support YUV cursors when the underlying
 	 * plane uses a YUV format, but there's no use-case for it yet. */
 	if (new_underlying_state->fb->format->is_yuv) {
-- 
2.30.1


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
