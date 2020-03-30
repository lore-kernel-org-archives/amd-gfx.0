Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2309C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 09:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AAB520714
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 09:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="fuAyP8sx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AAB520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2243489CB9;
	Mon, 30 Mar 2020 09:32:05 +0000 (UTC)
X-Greylist: delayed 514 seconds by postgrey-1.36 at gabe;
 Mon, 30 Mar 2020 09:32:03 UTC
Received: from mail2.protonmail.ch (mail2.protonmail.ch [185.70.40.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7024289CB9
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 09:32:03 +0000 (UTC)
Date: Mon, 30 Mar 2020 09:23:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1585560207;
 bh=Tt5NAl7EafYN3BIveIzxcsnNrI9b/KT7w8HFCd7yRaI=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=fuAyP8sxhj8aavTwvhsdmFvz/mwBubykgzomCsq+L7G99q2pCP4QjA8epob+2Mgo0
 x5GovpBz5jZk/Ya2bi/l/FCupayL3/AvtcGwAa5GKfObyPizN+Lpwe9Ew0CKFVcELA
 01fyUYQRzX1ZlPwEX/VmAy9czO8HRx30p3gc1ieg=
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH] drm/amd/display: add basic atomic check for cursor plane
Message-ID: <67AgM0yylniATabNxt8ct_5KATDTAwvscoDJBJxA3cm0vb0LJvyUM9VAX4r6Ib5Vxykoy9AN0G1uyZO8q00_RvTwmaimmGNQ3hZYoWKXZAo=@emersion.fr>
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
 Roman Gilg <subdiff@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds a basic cursor check when an atomic test-only commit is
performed. The position and size of the cursor plane is checked.

This should fix user-space relying on atomic checks to assign buffers to
planes.

Signed-off-by: Simon Ser <contact@emersion.fr>
Reported-by: Roman Gilg <subdiff@gmail.com>
References: https://github.com/emersion/libliftoff/issues/46
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f6b0b9a121fd..e1b084318ad6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7843,6 +7843,7 @@ static int dm_update_plane_state(struct dc *dc,
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
 	struct dm_crtc_state *dm_new_crtc_state, *dm_old_crtc_state;
 	struct dm_plane_state *dm_new_plane_state, *dm_old_plane_state;
+	struct amdgpu_crtc *new_acrtc;
 	bool needs_reset;
 	int ret = 0;

@@ -7852,9 +7853,30 @@ static int dm_update_plane_state(struct dc *dc,
 	dm_new_plane_state = to_dm_plane_state(new_plane_state);
 	dm_old_plane_state = to_dm_plane_state(old_plane_state);

-	/*TODO Implement atomic check for cursor plane */
-	if (plane->type == DRM_PLANE_TYPE_CURSOR)
+	/*TODO Implement better atomic check for cursor plane */
+	if (plane->type == DRM_PLANE_TYPE_CURSOR) {
+		if (!enable || !new_plane_crtc ||
+			drm_atomic_plane_disabling(plane->state, new_plane_state))
+			return 0;
+
+		new_acrtc = to_amdgpu_crtc(new_plane_crtc);
+
+		if ((new_plane_state->crtc_w > new_acrtc->max_cursor_width) ||
+			(new_plane_state->crtc_h > new_acrtc->max_cursor_height)) {
+			DRM_DEBUG_ATOMIC("Bad cursor size %d x %d\n",
+							 new_plane_state->crtc_w, new_plane_state->crtc_h);
+			return -EINVAL;
+		}
+
+		if (new_plane_state->crtc_x <= -new_acrtc->max_cursor_width ||
+			new_plane_state->crtc_y <= -new_acrtc->max_cursor_height) {
+			DRM_DEBUG_ATOMIC("Bad cursor position %d, %d\n",
+							 new_plane_state->crtc_x, new_plane_state->crtc_y);
+			return -EINVAL;
+		}
+
 		return 0;
+	}

 	needs_reset = should_reset_plane(state, plane, old_plane_state,
 					 new_plane_state);
--
2.26.0


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
