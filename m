Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729F8C2D0A3
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 23:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F58222E9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 23:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="htuRNOhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F58222E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C4916EEB9;
	Wed, 21 Oct 2020 23:31:44 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3CFA6EEB7
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 23:31:41 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id ce10so5673106ejc.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 16:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pCjb7dTbnavhHe565h3krZne0WcCRJtsSaYIAQDqA3s=;
 b=htuRNOhgR0gxXVk2LTiBYHo1hLv7v7RMh8wvgMHSYdj60DNjfYojdad52TK9ymhESY
 mkKiQOyjZ9TVvRxizElfQZD7Rud3NW11S9CmEOWfG8im+V2mIRo05RNnDgPXu8OqBoWd
 umdgADdGYUFpr4v3wuXvISP4tTGNphvyOQZ++961rFUENQDC/6ROSKrXAlhFILQdSLfI
 KOE6Z98kDvfGA7JAs2Q9iNKBtUn/Mp5YHsv2051Y2So2C1ks/JBE8fSc80ZI3WRWhLp8
 XWqwex70BK0+IOO55RJJXKQkc/XE8mvh4FkmaKOcXbOL1YZ0Lw4NytxUxVqwnBot8BOS
 AWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pCjb7dTbnavhHe565h3krZne0WcCRJtsSaYIAQDqA3s=;
 b=liqIWZ8g0IfZyA2H2MYdDMLLTZZsu1C6dX/iwKBAtvpqkWTJSkvzNcNVcOcK+kMUBC
 IR3i3rFLOuCOWmv4ZavPDMwpo3ipYdModolnUoyS7rVlOOTog5lTLADhegbOYFvE/mlT
 DRRUSucdgjbTHmYRRX/bJ3QF1VwjpnEOJuyBLPZu1fs4QNwH4koS7ALd0+HMzYUSwiCM
 WExZ3MArRfhMDAFvXLmaN6z8AdjzZ44zY79lFzVIfCNsbxH7W/v1T7HNM40yFRxD23kK
 ia6Fyxpmtn3QAf8bqc1g6ycUHwXntrodavM0CxFk3UCjN1F8+ArfZYDmQuF3xcH0PUaV
 wgqw==
X-Gm-Message-State: AOAM533A+1/H/n5N4e1riYbJqhTwkgiBaNp6l0KrHl0WKr0aU4NTbaC2
 vTxXzTM6jSdwIzhRJk4hTcubNZUufbcPgfoy
X-Google-Smtp-Source: ABdhPJxAnCvvAPp/Yf4wqtBoBo0IKTfynnmK2uewK+3HHXta+hR1+jf5qqK2n3QUUmjnnzltLmrOvw==
X-Received: by 2002:a17:906:e292:: with SMTP id
 gg18mr4473500ejb.278.1603323100008; 
 Wed, 21 Oct 2020 16:31:40 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id k23sm2845236ejs.100.2020.10.21.16.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 16:31:39 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 05/11] drm/amd/display: Store tiling_flags in the
 framebuffer.
Date: Thu, 22 Oct 2020 01:31:24 +0200
Message-Id: <20201021233130.874615-6-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021233130.874615-1-bas@basnieuwenhuizen.nl>
References: <20201021233130.874615-1-bas@basnieuwenhuizen.nl>
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
Cc: maraeo@gmail.com, sunpeng.li@amd.com, daniel@ffwll.ch,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, alexdeucher@gmail.com,
 harry.wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This moves the tiling_flags to the framebuffer creation.
This way the time of the "tiling" decision is the same as it
would be with modifiers.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 48 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  3 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 73 +++----------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 -
 4 files changed, 59 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 9e92d2a070ac..1a2664c3fc26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -541,6 +541,39 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 	return domain;
 }
 
+static int amdgpu_display_get_fb_info(const struct amdgpu_framebuffer *amdgpu_fb,
+				      uint64_t *tiling_flags, bool *tmz_surface)
+{
+	struct amdgpu_bo *rbo;
+	int r;
+
+	if (!amdgpu_fb) {
+		*tiling_flags = 0;
+		*tmz_surface = false;
+		return 0;
+	}
+
+	rbo = gem_to_amdgpu_bo(amdgpu_fb->base.obj[0]);
+	r = amdgpu_bo_reserve(rbo, false);
+
+	if (unlikely(r)) {
+		/* Don't show error message when returning -ERESTARTSYS */
+		if (r != -ERESTARTSYS)
+			DRM_ERROR("Unable to reserve buffer: %d\n", r);
+		return r;
+	}
+
+	if (tiling_flags)
+		amdgpu_bo_get_tiling_flags(rbo, tiling_flags);
+
+	if (tmz_surface)
+		*tmz_surface = amdgpu_bo_encrypted(rbo);
+
+	amdgpu_bo_unreserve(rbo);
+
+	return r;
+}
+
 int amdgpu_display_framebuffer_init(struct drm_device *dev,
 				    struct amdgpu_framebuffer *rfb,
 				    const struct drm_mode_fb_cmd2 *mode_cmd,
@@ -550,11 +583,18 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
 	rfb->base.obj[0] = obj;
 	drm_helper_mode_fill_fb_struct(dev, &rfb->base, mode_cmd);
 	ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
-	if (ret) {
-		rfb->base.obj[0] = NULL;
-		return ret;
-	}
+	if (ret)
+		goto fail;
+
+	ret = amdgpu_display_get_fb_info(rfb, &rfb->tiling_flags, &rfb->tmz_surface);
+	if (ret)
+		goto fail;
+
 	return 0;
+
+fail:
+	rfb->base.obj[0] = NULL;
+	return ret;
 }
 
 struct drm_framebuffer *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 345cb0464370..39866ed81c16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -304,6 +304,9 @@ struct amdgpu_display_funcs {
 struct amdgpu_framebuffer {
 	struct drm_framebuffer base;
 
+	uint64_t tiling_flags;
+	bool tmz_surface;
+
 	/* caching for later use */
 	uint64_t address;
 };
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 833887b9b0ad..5a0efaefbd7f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3839,39 +3839,6 @@ static int fill_dc_scaling_info(const struct drm_plane_state *state,
 	return 0;
 }
 
-static int get_fb_info(const struct amdgpu_framebuffer *amdgpu_fb,
-		       uint64_t *tiling_flags, bool *tmz_surface)
-{
-	struct amdgpu_bo *rbo;
-	int r;
-
-	if (!amdgpu_fb) {
-		*tiling_flags = 0;
-		*tmz_surface = false;
-		return 0;
-	}
-
-	rbo = gem_to_amdgpu_bo(amdgpu_fb->base.obj[0]);
-	r = amdgpu_bo_reserve(rbo, false);
-
-	if (unlikely(r)) {
-		/* Don't show error message when returning -ERESTARTSYS */
-		if (r != -ERESTARTSYS)
-			DRM_ERROR("Unable to reserve buffer: %d\n", r);
-		return r;
-	}
-
-	if (tiling_flags)
-		amdgpu_bo_get_tiling_flags(rbo, tiling_flags);
-
-	if (tmz_surface)
-		*tmz_surface = amdgpu_bo_encrypted(rbo);
-
-	amdgpu_bo_unreserve(rbo);
-
-	return r;
-}
-
 static inline uint64_t get_dcc_address(uint64_t address, uint64_t tiling_flags)
 {
 	uint32_t offset = AMDGPU_TILING_GET(tiling_flags, DCC_OFFSET_256B);
@@ -4287,7 +4254,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 				    struct drm_crtc_state *crtc_state)
 {
 	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(crtc_state);
-	struct dm_plane_state *dm_plane_state = to_dm_plane_state(plane_state);
+	struct amdgpu_framebuffer *afb = (struct amdgpu_framebuffer *)plane_state->fb;
 	struct dc_scaling_info scaling_info;
 	struct dc_plane_info plane_info;
 	int ret;
@@ -4304,10 +4271,10 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 
 	force_disable_dcc = adev->asic_type == CHIP_RAVEN && adev->in_suspend;
 	ret = fill_dc_plane_info_and_addr(adev, plane_state,
-					  dm_plane_state->tiling_flags,
+					  afb->tiling_flags,
 					  &plane_info,
 					  &dc_plane_state->address,
-					  dm_plane_state->tmz_surface,
+					  afb->tmz_surface,
 					  force_disable_dcc);
 	if (ret)
 		return ret;
@@ -5913,10 +5880,6 @@ dm_drm_plane_duplicate_state(struct drm_plane *plane)
 		dc_plane_state_retain(dm_plane_state->dc_state);
 	}
 
-	/* Framebuffer hasn't been updated yet, so retain old flags. */
-	dm_plane_state->tiling_flags = old_dm_plane_state->tiling_flags;
-	dm_plane_state->tmz_surface = old_dm_plane_state->tmz_surface;
-
 	return &dm_plane_state->base;
 }
 
@@ -6021,10 +5984,10 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
 
 		fill_plane_buffer_attributes(
 			adev, afb, plane_state->format, plane_state->rotation,
-			dm_plane_state_new->tiling_flags,
+			afb->tiling_flags,
 			&plane_state->tiling_info, &plane_state->plane_size,
 			&plane_state->dcc, &plane_state->address,
-			dm_plane_state_new->tmz_surface, force_disable_dcc);
+			afb->tmz_surface, force_disable_dcc);
 	}
 
 	return 0;
@@ -7287,6 +7250,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		struct drm_crtc *crtc = new_plane_state->crtc;
 		struct drm_crtc_state *new_crtc_state;
 		struct drm_framebuffer *fb = new_plane_state->fb;
+		struct amdgpu_framebuffer *afb = (struct amdgpu_framebuffer *)fb;
 		bool plane_needs_flip;
 		struct dc_plane_state *dc_plane;
 		struct dm_plane_state *dm_new_plane_state = to_dm_plane_state(new_plane_state);
@@ -7341,10 +7305,10 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 
 		fill_dc_plane_info_and_addr(
 			dm->adev, new_plane_state,
-			dm_new_plane_state->tiling_flags,
+			afb->tiling_flags,
 			&bundle->plane_infos[planes_count],
 			&bundle->flip_addrs[planes_count].address,
-			dm_new_plane_state->tmz_surface, false);
+			afb->tmz_surface, false);
 
 		DRM_DEBUG_DRIVER("plane: id=%d dcc_en=%d\n",
 				 new_plane_state->plane->index,
@@ -8483,8 +8447,7 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	 * TODO: Come up with a more elegant solution for this.
 	 */
 	for_each_oldnew_plane_in_state(state, other, old_other_state, new_other_state, i) {
-		struct dm_plane_state *old_dm_plane_state, *new_dm_plane_state;
-
+		struct amdgpu_framebuffer *old_afb, *new_afb;
 		if (other->type == DRM_PLANE_TYPE_CURSOR)
 			continue;
 
@@ -8528,12 +8491,11 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 		if (old_other_state->fb->format != new_other_state->fb->format)
 			return true;
 
-		old_dm_plane_state = to_dm_plane_state(old_other_state);
-		new_dm_plane_state = to_dm_plane_state(new_other_state);
+		old_afb = (struct amdgpu_framebuffer *)old_other_state->fb;
+		new_afb = (struct amdgpu_framebuffer *)new_other_state->fb;
 
 		/* Tiling and DCC changes also require bandwidth updates. */
-		if (old_dm_plane_state->tiling_flags !=
-		    new_dm_plane_state->tiling_flags)
+		if (old_afb->tiling_flags != new_afb->tiling_flags)
 			return true;
 	}
 
@@ -8859,17 +8821,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		}
 	}
 
-	/* Prepass for updating tiling flags on new planes. */
-	for_each_new_plane_in_state(state, plane, new_plane_state, i) {
-		struct dm_plane_state *new_dm_plane_state = to_dm_plane_state(new_plane_state);
-		struct amdgpu_framebuffer *new_afb = to_amdgpu_framebuffer(new_plane_state->fb);
-
-		ret = get_fb_info(new_afb, &new_dm_plane_state->tiling_flags,
-				  &new_dm_plane_state->tmz_surface);
-		if (ret)
-			goto fail;
-	}
-
 	/* Remove exiting planes if they are modified */
 	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
 		ret = dm_update_plane_state(dc, state, plane,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index a46338410ddd..9308bed3c4fe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -420,8 +420,6 @@ struct dc_plane_state;
 struct dm_plane_state {
 	struct drm_plane_state base;
 	struct dc_plane_state *dc_state;
-	uint64_t tiling_flags;
-	bool tmz_surface;
 };
 
 struct dm_crtc_state {
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
