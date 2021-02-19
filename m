Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B02C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 18:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF70E64EB3
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 18:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF70E64EB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61F136E07F;
	Fri, 19 Feb 2021 18:58:13 +0000 (UTC)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch
 [185.70.40.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 959E26E07F
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 18:58:12 +0000 (UTC)
Date: Fri, 19 Feb 2021 18:58:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1613761090;
 bh=FrTyGDqXHWcSP733reHUOIY6ELp22ZZxWUrNc6peMHY=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=o57XXAIlS+b6KG81bDCtaBKc3XjPnT1W1V/TWebk5BSYuowlbGum1fRVaAl9Dk9+W
 oW/2ZKLG2WHSt5i6CPWmWcbAO3h2gZiKolc6Kufc3AYchhuoT+NSwGr2cIT68sKB1a
 ZRrXc/4JkcZcNHOfdV0tyeWkgVR08XJLitftztxAY7Z1zqJCg27HKn5lA+7a6rqB7D
 vfVUsCyuVishU1HN5ciF8EHRX62rV/SoiOS+5SSsUs9jDUjvJk7Pq7ZkbfkI5FRV9+
 qXazLnx5xyQYAuWyOlhw9xm2QlmYsyYGvi7v/GCo5ftZmKe4rwx8eRsDuAW+p4Arg4
 7YMwp5hstN+/g==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH 2/6] amd/display: check cursor plane matches underlying plane
Message-ID: <IygT4fK5mauG3UQECwlUiV4hAOu3dD3TgG8Os0L0@cp7-web-044.plabs.ch>
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

The current logic checks whether the cursor plane blending
properties match the primary plane's. However that's wrong,
because the cursor uses the topmost pipe.

Instead, grab the topmost enabled plane, and check that the
cursor plane blending properties matches it.

Fixes: 12f4849a1cfd ("drm/amd/display: check cursor scaling")
Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 +++++++++++--------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4548b779bbce..acbe1537e7cf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9209,33 +9209,39 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 				struct drm_crtc *crtc,
 				struct drm_crtc_state *new_crtc_state)
 {
-	struct drm_plane_state *new_cursor_state, *new_primary_state;
-	int cursor_scale_w, cursor_scale_h, primary_scale_w, primary_scale_h;
+	int i;
+	struct drm_plane *plane;
+	struct drm_plane_state *new_cursor_state, *new_underlying_state, *new_plane_state;
+	int cursor_scale_w, cursor_scale_h, underlying_scale_w, underlying_scale_h;
 
 	/* On DCE and DCN there is no dedicated hardware cursor plane. We get a
 	 * cursor per pipe but it's going to inherit the scaling and
 	 * positioning from the underlying pipe. Check the cursor plane's
-	 * blending properties match the primary plane's. */
+	 * blending properties match the underlying plane's. */
+
+	new_underlying_state = NULL;
+	for_each_new_plane_in_state(state, plane, new_plane_state, i) {
+		if (new_plane_state->crtc == crtc && plane != crtc->cursor)
+			new_underlying_state = new_plane_state;
+	}
 
 	new_cursor_state = drm_atomic_get_new_plane_state(state, crtc->cursor);
-	new_primary_state = drm_atomic_get_new_plane_state(state, crtc->primary);
-	if (!new_cursor_state || !new_primary_state || !new_cursor_state->fb) {
+	if (!new_cursor_state || !new_underlying_state || !new_cursor_state->fb)
 		return 0;
-	}
 
 	cursor_scale_w = new_cursor_state->crtc_w * 1000 /
 			 (new_cursor_state->src_w >> 16);
 	cursor_scale_h = new_cursor_state->crtc_h * 1000 /
 			 (new_cursor_state->src_h >> 16);
 
-	primary_scale_w = new_primary_state->crtc_w * 1000 /
-			 (new_primary_state->src_w >> 16);
-	primary_scale_h = new_primary_state->crtc_h * 1000 /
-			 (new_primary_state->src_h >> 16);
+	underlying_scale_w = new_underlying_state->crtc_w * 1000 /
+			 (new_underlying_state->src_w >> 16);
+	underlying_scale_h = new_underlying_state->crtc_h * 1000 /
+			 (new_underlying_state->src_h >> 16);
 
-	if (cursor_scale_w != primary_scale_w ||
-	    cursor_scale_h != primary_scale_h) {
-		drm_dbg_atomic(crtc->dev, "Cursor plane scaling doesn't match primary plane\n");
+	if (cursor_scale_w != underlying_scale_w ||
+	    cursor_scale_h != underlying_scale_h) {
+		drm_dbg_atomic(crtc->dev, "Cursor plane scaling doesn't match underlying plane\n");
 		return -EINVAL;
 	}
 
-- 
2.30.1


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
