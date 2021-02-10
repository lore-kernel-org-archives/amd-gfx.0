Return-Path: <SRS0=kdbD=HM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24C0C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 14:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962F564DC3
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 14:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962F564DC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 363356EC70;
	Wed, 10 Feb 2021 14:25:50 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A63826EC70
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Feb 2021 14:25:49 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id r77so1712546qka.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Feb 2021 06:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RrIDUa/pH4hRGMxI0mklqnTDV56iXv4gIJQY+WfYSOc=;
 b=c/b6pzhElLFKl3htpDweLnq+sDSSTUxfADZCzZQ7qABB4vMpOnI0wXlMTAWoxRbgiz
 MTlkJ0MfJHUFdQg+s3QehKj1JhIXUuDdouRJJOi7N11AN2TJ8Rze0e5jV9CqFy1JDIWl
 6VshOrkLCqlf0AW4+pMXdkwy3Vzsg0J9OMtqXC8WAyZFGg1cjbEvq7ND1us4w5hxHykf
 5zXxRw6ZHT1YUZ2ax4Onvn4KwG2yY6/5OC/D+xzEVx0Sj2SIpxScC4oDDKaK5pwnFRPM
 sjksa10IGq7/GLnaS5Bn42vCtds0/mrvpGRukytYTbYbCddLuABqG4WFU02aywwbdrOp
 DaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RrIDUa/pH4hRGMxI0mklqnTDV56iXv4gIJQY+WfYSOc=;
 b=gfSQpvkKRDki6S/MzEpBnyXXYcqIoG0TkCkloXBW6iBhdXXKFwQIrz/o+tSm0mKlkg
 NXZrJFcidFrmw6UFlTKZ3HUAWYOIUmaF7uLQReJ2/azWEYLzRlDY5+yTCAWXUTQCsu7G
 rOKsUTrs3M+lol61fSF0p0KA0yI4T9yi9+/qpmBZ01+BEv2IHxGdmzR4HR4D5pYJ+hkj
 rywpRU0VxWB7e9i+xdCwT/xxt2vXkHqgHnLeLPHoIn2aToKpO4YsSyTR/ObbiMmyPDkb
 HH5C5d9jFz6BjOen2skkR4oIJimm4bTfvhklQxIP/JKvDzXGHMi+SrLtTNrdwR+TkTnC
 7vuA==
X-Gm-Message-State: AOAM5303/paO4eFcKl959wXBaYpHYFFStVIO6db9Sv9Iu5DaqyK9uOap
 +m34cTdbsWbjsdqfwBy7EWgh/Hz10BU=
X-Google-Smtp-Source: ABdhPJzNJDJC8YnhXUOwqjmsQpNfWo57M/10sCi+txcTCgA/+V7WEmXVV24qK9b9qVKBc7smEUFvMg==
X-Received: by 2002:ae9:e702:: with SMTP id m2mr3623689qka.52.1612967148639;
 Wed, 10 Feb 2021 06:25:48 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id d22sm1333676qtp.34.2021.02.10.06.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Feb 2021 06:25:47 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amd/display: reuse current context instead of
 recreating one"
Date: Wed, 10 Feb 2021 09:25:37 -0500
Message-Id: <20210210142537.1629905-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 8866a67ab86cc0812e65c04f1ef02bcc41e24d68.

This breaks hotplug of HDMI on some systems, resulting in
a blank screen.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=211649
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++++-------
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 27 ++++++-------------
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  3 ++-
 3 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 961abf1cf040..e438baa1adc1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1934,7 +1934,7 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 		dc_commit_updates_for_stream(
 			dm->dc, bundle->surface_updates,
 			dc_state->stream_status->plane_count,
-			dc_state->streams[k], &bundle->stream_update);
+			dc_state->streams[k], &bundle->stream_update, dc_state);
 	}
 
 cleanup:
@@ -1965,7 +1965,8 @@ static void dm_set_dpms_off(struct dc_link *link)
 
 	stream_update.stream = stream_state;
 	dc_commit_updates_for_stream(stream_state->ctx->dc, NULL, 0,
-				     stream_state, &stream_update);
+				     stream_state, &stream_update,
+				     stream_state->ctx->dc->current_state);
 	mutex_unlock(&adev->dm.dc_lock);
 }
 
@@ -7548,7 +7549,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				    struct drm_crtc *pcrtc,
 				    bool wait_for_vblank)
 {
-	int i;
+	uint32_t i;
 	uint64_t timestamp_ns;
 	struct drm_plane *plane;
 	struct drm_plane_state *old_plane_state, *new_plane_state;
@@ -7589,7 +7590,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		amdgpu_dm_commit_cursors(state);
 
 	/* update planes when needed */
-	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
+	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
 		struct drm_crtc *crtc = new_plane_state->crtc;
 		struct drm_crtc_state *new_crtc_state;
 		struct drm_framebuffer *fb = new_plane_state->fb;
@@ -7812,7 +7813,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 						     bundle->surface_updates,
 						     planes_count,
 						     acrtc_state->stream,
-						     &bundle->stream_update);
+						     &bundle->stream_update,
+						     dc_state);
 
 		/**
 		 * Enable or disable the interrupts on the backend.
@@ -8148,13 +8150,13 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
 		struct dm_connector_state *dm_old_con_state = to_dm_connector_state(old_con_state);
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
-		struct dc_surface_update surface_updates[MAX_SURFACES];
+		struct dc_surface_update dummy_updates[MAX_SURFACES];
 		struct dc_stream_update stream_update;
 		struct dc_info_packet hdr_packet;
 		struct dc_stream_status *status = NULL;
 		bool abm_changed, hdr_changed, scaling_changed;
 
-		memset(&surface_updates, 0, sizeof(surface_updates));
+		memset(&dummy_updates, 0, sizeof(dummy_updates));
 		memset(&stream_update, 0, sizeof(stream_update));
 
 		if (acrtc) {
@@ -8211,15 +8213,16 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		 * To fix this, DC should permit updating only stream properties.
 		 */
 		for (j = 0; j < status->plane_count; j++)
-			surface_updates[j].surface = status->plane_states[j];
+			dummy_updates[j].surface = status->plane_states[0];
 
 
 		mutex_lock(&dm->dc_lock);
 		dc_commit_updates_for_stream(dm->dc,
-						surface_updates,
+						     dummy_updates,
 						     status->plane_count,
 						     dm_new_crtc_state->stream,
-						     &stream_update);
+						     &stream_update,
+						     dc_state);
 		mutex_unlock(&dm->dc_lock);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6cf1a5a2a5ec..58eb0d69873a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2679,7 +2679,8 @@ void dc_commit_updates_for_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
 		struct dc_stream_state *stream,
-		struct dc_stream_update *stream_update)
+		struct dc_stream_update *stream_update,
+		struct dc_state *state)
 {
 	const struct dc_stream_status *stream_status;
 	enum surface_update_type update_type;
@@ -2698,12 +2699,6 @@ void dc_commit_updates_for_stream(struct dc *dc,
 
 
 	if (update_type >= UPDATE_TYPE_FULL) {
-		struct dc_plane_state *new_planes[MAX_SURFACES];
-
-		memset(new_planes, 0, sizeof(new_planes));
-
-		for (i = 0; i < surface_count; i++)
-			new_planes[i] = srf_updates[i].surface;
 
 		/* initialize scratch memory for building context */
 		context = dc_create_state(dc);
@@ -2712,21 +2707,15 @@ void dc_commit_updates_for_stream(struct dc *dc,
 			return;
 		}
 
-		dc_resource_state_copy_construct(
-				dc->current_state, context);
+		dc_resource_state_copy_construct(state, context);
 
-		/*remove old surfaces from context */
-		if (!dc_rem_all_planes_for_stream(dc, stream, context)) {
-			DC_ERROR("Failed to remove streams for new validate context!\n");
-			return;
-		}
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *new_pipe = &context->res_ctx.pipe_ctx[i];
+			struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
-		/* add surface to context */
-		if (!dc_add_all_planes_for_stream(dc, stream, new_planes, surface_count, context)) {
-			DC_ERROR("Failed to add streams for new validate context!\n");
-			return;
+			if (new_pipe->plane_state && new_pipe->plane_state != old_pipe->plane_state)
+				new_pipe->plane_state->force_full_update = true;
 		}
-
 	}
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index e243c01b9672..b7910976b81a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -283,7 +283,8 @@ void dc_commit_updates_for_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
 		struct dc_stream_state *stream,
-		struct dc_stream_update *stream_update);
+		struct dc_stream_update *stream_update,
+		struct dc_state *state);
 /*
  * Log the current stream state.
  */
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
