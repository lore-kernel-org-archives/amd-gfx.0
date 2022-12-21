Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CEBC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Dec 2022 15:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 030FD10E036;
	Wed, 21 Dec 2022 15:24:23 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C85110E036
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Dec 2022 15:24:20 +0000 (UTC)
Received: from kaveri ([188.62.80.205])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202212211624141997; Wed, 21 Dec 2022 16:24:14 +0100
Received: from daenzer by kaveri with local (Exim 4.96)
 (envelope-from <michel@daenzer.net>) id 1p80x3-003hoi-1J;
 Wed, 21 Dec 2022 16:24:13 +0100
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Solomon Chiu <solomon.chiu@amd.com>
Subject: [PATCH] Revert "drm/amd/display: Enable Freesync Video Mode by
 default"
Date: Wed, 21 Dec 2022 16:24:13 +0100
Message-Id: <20221221152413.883409-1-michel@daenzer.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F1B.63A3251F.000C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michel Dänzer <mdaenzer@redhat.com>

This reverts commit de05abe6b9d0fe08f65d744f7f75a4cba4df27ad.

The bug referenced below was bisected to this commit. There has been no
activity toward fixing it in 3 months, so let's revert for now.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2162
Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 27 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++----
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6b74df446694..e3e2e6e3b485 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -195,6 +195,7 @@ extern int amdgpu_emu_mode;
 extern uint amdgpu_smu_memory_pool_size;
 extern int amdgpu_smu_pptable_id;
 extern uint amdgpu_dc_feature_mask;
+extern uint amdgpu_freesync_vid_mode;
 extern uint amdgpu_dc_debug_mask;
 extern uint amdgpu_dc_visual_confirm;
 extern uint amdgpu_dm_abm_level;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b4f2d61ea0d5..1353ffd08988 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -181,6 +181,7 @@ int amdgpu_mes_kiq;
 int amdgpu_noretry = -1;
 int amdgpu_force_asic_type = -1;
 int amdgpu_tmz = -1; /* auto */
+uint amdgpu_freesync_vid_mode;
 int amdgpu_reset_method = -1; /* auto */
 int amdgpu_num_kcq = -1;
 int amdgpu_smartshift_bias;
@@ -879,6 +880,32 @@ module_param_named(backlight, amdgpu_backlight, bint, 0444);
 MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto (default), 0 = off, 1 = on)");
 module_param_named(tmz, amdgpu_tmz, int, 0444);
 
+/**
+ * DOC: freesync_video (uint)
+ * Enable the optimization to adjust front porch timing to achieve seamless
+ * mode change experience when setting a freesync supported mode for which full
+ * modeset is not needed.
+ *
+ * The Display Core will add a set of modes derived from the base FreeSync
+ * video mode into the corresponding connector's mode list based on commonly
+ * used refresh rates and VRR range of the connected display, when users enable
+ * this feature. From the userspace perspective, they can see a seamless mode
+ * change experience when the change between different refresh rates under the
+ * same resolution. Additionally, userspace applications such as Video playback
+ * can read this modeset list and change the refresh rate based on the video
+ * frame rate. Finally, the userspace can also derive an appropriate mode for a
+ * particular refresh rate based on the FreeSync Mode and add it to the
+ * connector's mode list.
+ *
+ * Note: This is an experimental feature.
+ *
+ * The default value: 0 (off).
+ */
+MODULE_PARM_DESC(
+	freesync_video,
+	"Enable freesync modesetting optimization feature (0 = off (default), 1 = on)");
+module_param_named(freesync_video, amdgpu_freesync_vid_mode, uint, 0444);
+
 /**
  * DOC: reset_method (int)
  * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 50c783e19f5a..c9dff07127d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5831,7 +5831,8 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		 */
 		DRM_DEBUG_DRIVER("No preferred mode found\n");
 	} else {
-		recalculate_timing = is_freesync_video_mode(&mode, aconnector);
+		recalculate_timing = amdgpu_freesync_vid_mode &&
+				 is_freesync_video_mode(&mode, aconnector);
 		if (recalculate_timing) {
 			freesync_mode = get_highest_refresh_rate_mode(aconnector, false);
 			drm_mode_copy(&saved_mode, &mode);
@@ -6982,7 +6983,7 @@ static void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connect
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
 		to_amdgpu_dm_connector(connector);
 
-	if (!edid)
+	if (!(amdgpu_freesync_vid_mode && edid))
 		return;
 
 	if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
@@ -8846,7 +8847,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		 * TODO: Refactor this function to allow this check to work
 		 * in all conditions.
 		 */
-		if (dm_new_crtc_state->stream &&
+		if (amdgpu_freesync_vid_mode &&
+		    dm_new_crtc_state->stream &&
 		    is_timing_unchanged_for_freesync(new_crtc_state, old_crtc_state))
 			goto skip_modeset;
 
@@ -8881,7 +8883,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		if (!dm_old_crtc_state->stream)
 			goto skip_modeset;
 
-		if (dm_new_crtc_state->stream &&
+		if (amdgpu_freesync_vid_mode && dm_new_crtc_state->stream &&
 		    is_timing_unchanged_for_freesync(new_crtc_state,
 						     old_crtc_state)) {
 			new_crtc_state->mode_changed = false;
@@ -8893,7 +8895,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 			set_freesync_fixed_config(dm_new_crtc_state);
 
 			goto skip_modeset;
-		} else if (aconnector &&
+		} else if (amdgpu_freesync_vid_mode && aconnector &&
 			   is_freesync_video_mode(&new_crtc_state->mode,
 						  aconnector)) {
 			struct drm_display_mode *high_mode;
-- 
2.38.1

