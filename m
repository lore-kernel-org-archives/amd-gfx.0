Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FB7C54FB3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 01:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9265810E298;
	Mon,  2 Jun 2025 01:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="p9ufa7GA";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48A9110E174
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 01:44:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7187D5C4C50;
 Mon,  2 Jun 2025 01:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0079C4CEE7;
 Mon,  2 Jun 2025 01:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748828682;
 bh=PjCU0FLkqQrX00TrDcQ7NlkWEaWwIe8Elgg3GgI1Cik=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=p9ufa7GAKJ9m4sc/Khc4RFUlYmde6PZGZFcaOrCxbC9/TH0nU+AkWubYRe5QaP1NP
 PvrpFiPQxLgayDTjwenWPqQfRjwOXRbOdr93gFpsIzcWV/ncBOxANsC496a7baE9sS
 M9vPBOfXn4b1qlZ/gvmBTrBvqK0QwoTB0XCbWEzm/bH8lWCezfEQn1dTin0fExPFQ3
 JGlcbRrWNBDAvPPQYbCKVMfDDJ6TJ/Shgmd1ENewT76YhULJ/53Mx6VlbYUT+ymsfT
 vugU2hYs2yx8uPxvztD68/hqyK/FkvYGi1ZI0agYZmFrcsY87/H3EODi2laEVSLAjU
 TCeOMm9YdJL9g==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Chris Bainbridge <chris.bainbridge@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/3] drm/amd/display: Destroy cached state in complete()
 callback
Date: Sun,  1 Jun 2025 20:44:32 -0500
Message-ID: <20250602014432.3538345-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250602014432.3538345-1-superm1@kernel.org>
References: <20250602014432.3538345-1-superm1@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
When the suspend sequence has been aborted after prepare() but
before suspend() the resume() callback never gets called. The PM core
will call complete() when this happens. As the state has been cached
in prepare() it needs to be destroyed in complete() if it's still around.

[How]
Create a helper for destroying cached state and call it both in resume()
and complete() callbacks. If resume has been called the state will be
destroyed and it's a no-op for complete().  If resume hasn't been called
(such as an aborted suspend) then destroy the state in complete().

Fixes: 50e0bae34fa6b ("drm/amd/display: Add and use new dm_prepare_suspend() callback")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 100 +++++++++++-------
 1 file changed, 60 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1f5894d8f2fb1..94e5f07a51462 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3073,6 +3073,64 @@ static int dm_cache_state(struct amdgpu_device *adev)
 	return adev->dm.cached_state ? 0 : r;
 }
 
+static void dm_destroy_cached_state(struct amdgpu_device *adev)
+{
+	struct amdgpu_display_manager *dm = &adev->dm;
+	struct drm_device *ddev = adev_to_drm(adev);
+	struct dm_plane_state *dm_new_plane_state;
+	struct drm_plane_state *new_plane_state;
+	struct dm_crtc_state *dm_new_crtc_state;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_plane *plane;
+	struct drm_crtc *crtc;
+	int i;
+
+	if (!dm->cached_state)
+		return;
+
+	/* Force mode set in atomic commit */
+	for_each_new_crtc_in_state(dm->cached_state, crtc, new_crtc_state, i) {
+		new_crtc_state->active_changed = true;
+		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+		reset_freesync_config_for_crtc(dm_new_crtc_state);
+	}
+
+	/*
+	 * atomic_check is expected to create the dc states. We need to release
+	 * them here, since they were duplicated as part of the suspend
+	 * procedure.
+	 */
+	for_each_new_crtc_in_state(dm->cached_state, crtc, new_crtc_state, i) {
+		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+		if (dm_new_crtc_state->stream) {
+			WARN_ON(kref_read(&dm_new_crtc_state->stream->refcount) > 1);
+			dc_stream_release(dm_new_crtc_state->stream);
+			dm_new_crtc_state->stream = NULL;
+		}
+		dm_new_crtc_state->base.color_mgmt_changed = true;
+	}
+
+	for_each_new_plane_in_state(dm->cached_state, plane, new_plane_state, i) {
+		dm_new_plane_state = to_dm_plane_state(new_plane_state);
+		if (dm_new_plane_state->dc_state) {
+			WARN_ON(kref_read(&dm_new_plane_state->dc_state->refcount) > 1);
+			dc_plane_state_release(dm_new_plane_state->dc_state);
+			dm_new_plane_state->dc_state = NULL;
+		}
+	}
+
+	drm_atomic_helper_resume(ddev, dm->cached_state);
+
+	dm->cached_state = NULL;
+}
+
+static void dm_complete(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	dm_destroy_cached_state(adev);
+}
+
 static int dm_prepare_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -3306,12 +3364,6 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
-	struct drm_crtc *crtc;
-	struct drm_crtc_state *new_crtc_state;
-	struct dm_crtc_state *dm_new_crtc_state;
-	struct drm_plane *plane;
-	struct drm_plane_state *new_plane_state;
-	struct dm_plane_state *dm_new_plane_state;
 	struct dm_atomic_state *dm_state = to_dm_atomic_state(dm->atomic_obj.state);
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct dc_state *dc_state;
@@ -3468,40 +3520,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	}
 	drm_connector_list_iter_end(&iter);
 
-	/* Force mode set in atomic commit */
-	for_each_new_crtc_in_state(dm->cached_state, crtc, new_crtc_state, i) {
-		new_crtc_state->active_changed = true;
-		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
-		reset_freesync_config_for_crtc(dm_new_crtc_state);
-	}
-
-	/*
-	 * atomic_check is expected to create the dc states. We need to release
-	 * them here, since they were duplicated as part of the suspend
-	 * procedure.
-	 */
-	for_each_new_crtc_in_state(dm->cached_state, crtc, new_crtc_state, i) {
-		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
-		if (dm_new_crtc_state->stream) {
-			WARN_ON(kref_read(&dm_new_crtc_state->stream->refcount) > 1);
-			dc_stream_release(dm_new_crtc_state->stream);
-			dm_new_crtc_state->stream = NULL;
-		}
-		dm_new_crtc_state->base.color_mgmt_changed = true;
-	}
-
-	for_each_new_plane_in_state(dm->cached_state, plane, new_plane_state, i) {
-		dm_new_plane_state = to_dm_plane_state(new_plane_state);
-		if (dm_new_plane_state->dc_state) {
-			WARN_ON(kref_read(&dm_new_plane_state->dc_state->refcount) > 1);
-			dc_plane_state_release(dm_new_plane_state->dc_state);
-			dm_new_plane_state->dc_state = NULL;
-		}
-	}
-
-	drm_atomic_helper_resume(ddev, dm->cached_state);
-
-	dm->cached_state = NULL;
+	dm_destroy_cached_state(adev);
 
 	/* Do mst topology probing after resuming cached state*/
 	drm_connector_list_iter_begin(ddev, &iter);
@@ -3550,6 +3569,7 @@ static const struct amd_ip_funcs amdgpu_dm_funcs = {
 	.prepare_suspend = dm_prepare_suspend,
 	.suspend = dm_suspend,
 	.resume = dm_resume,
+	.complete = dm_complete,
 	.is_idle = dm_is_idle,
 	.wait_for_idle = dm_wait_for_idle,
 	.check_soft_reset = dm_check_soft_reset,
-- 
2.43.0

