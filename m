Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F96C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 14:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 833D88EC25;
	Mon, 11 Jul 2022 14:51:39 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16B308EC1F
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 14:51:37 +0000 (UTC)
Received: from kaveri ([85.2.99.24])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202207111651334587; Mon, 11 Jul 2022 16:51:33 +0200
Received: from daenzer by kaveri with local (Exim 4.96)
 (envelope-from <michel@daenzer.net>) id 1oAul1-002zRM-2H;
 Mon, 11 Jul 2022 16:51:31 +0200
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH] drm/amd/display: Ensure valid event timestamp for cursor-only
 commits
Date: Mon, 11 Jul 2022 16:51:31 +0200
Message-Id: <20220711145131.712825-1-michel@daenzer.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F1E.62CC38F6.002C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
 Spam="Unknown"; VOD="Unknown"
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
Cc: Dor Askayo <dor.askayo@gmail.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michel Dänzer <mdaenzer@redhat.com>

Requires enabling the vblank machinery for them.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2030
Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 43 +++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9dd2e0601ea8..b0667e2f3fdd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -462,6 +462,26 @@ static void dm_pflip_high_irq(void *interrupt_params)
 		     vrr_active, (int) !e);
 }
 
+static void dm_crtc_handle_vblank(struct amdgpu_crtc *acrtc)
+{
+	struct drm_crtc *crtc = &acrtc->base;
+	struct drm_device *dev = crtc->dev;
+	unsigned long flags;
+
+	drm_crtc_handle_vblank(crtc);
+
+	spin_lock_irqsave(&dev->event_lock, flags);
+
+	/* Send completion event for cursor-only commits */
+	if (acrtc->event && acrtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
+		drm_crtc_send_vblank_event(crtc, acrtc->event);
+		drm_crtc_vblank_put(crtc);
+		acrtc->event = NULL;
+	}
+
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+}
+
 static void dm_vupdate_high_irq(void *interrupt_params)
 {
 	struct common_irq_params *irq_params = interrupt_params;
@@ -500,7 +520,7 @@ static void dm_vupdate_high_irq(void *interrupt_params)
 		 * if a pageflip happened inside front-porch.
 		 */
 		if (vrr_active) {
-			drm_crtc_handle_vblank(&acrtc->base);
+			dm_crtc_handle_vblank(acrtc);
 
 			/* BTR processing for pre-DCE12 ASICs */
 			if (acrtc->dm_irq_params.stream &&
@@ -552,7 +572,7 @@ static void dm_crtc_high_irq(void *interrupt_params)
 	 * to dm_vupdate_high_irq after end of front-porch.
 	 */
 	if (!vrr_active)
-		drm_crtc_handle_vblank(&acrtc->base);
+		dm_crtc_handle_vblank(acrtc);
 
 	/**
 	 * Following stuff must happen at start of vblank, for crc
@@ -9134,6 +9154,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	struct amdgpu_bo *abo;
 	uint32_t target_vblank, last_flip_vblank;
 	bool vrr_active = amdgpu_dm_vrr_active(acrtc_state);
+	bool cursor_update = false;
 	bool pflip_present = false;
 	struct {
 		struct dc_surface_update surface_updates[MAX_SURFACES];
@@ -9169,8 +9190,13 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		struct dm_plane_state *dm_new_plane_state = to_dm_plane_state(new_plane_state);
 
 		/* Cursor plane is handled after stream updates */
-		if (plane->type == DRM_PLANE_TYPE_CURSOR)
+		if (plane->type == DRM_PLANE_TYPE_CURSOR) {
+			if ((fb && crtc == pcrtc) ||
+			    (old_plane_state->fb && old_plane_state->crtc == pcrtc))
+				cursor_update = true;
+
 			continue;
+		}
 
 		if (!fb || !crtc || pcrtc != crtc)
 			continue;
@@ -9333,6 +9359,17 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				bundle->stream_update.vrr_infopacket =
 					&acrtc_state->stream->vrr_infopacket;
 		}
+	} else if (cursor_update && acrtc_state->active_planes > 0 &&
+		   !acrtc_state->force_dpms_off &&
+		   acrtc_attach->base.state->event) {
+		drm_crtc_vblank_get(pcrtc);
+
+		spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
+
+		acrtc_attach->event = acrtc_attach->base.state->event;
+		acrtc_attach->base.state->event = NULL;
+
+		spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
 	}
 
 	/* Update the planes if changed or disable if we don't have any. */
-- 
2.36.1

