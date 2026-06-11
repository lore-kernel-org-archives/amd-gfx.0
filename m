Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0884CD4F2C
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 07:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1D2A10F2D7;
	Fri, 12 Jun 2026 07:46:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="RNSDhfst";
	dkim-atps=neutral
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com
 [91.218.175.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2809E10E7D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 15:46:48 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1781192796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=u7GCCYEoSxjb7Y2ZDYlvbszUi1NrkX983MlXtXjBdxI=;
 b=RNSDhfstI7pXRieqVHu53yE+qm0gJwNNrPgxgJS1/4AJyEhsp2AcDFeFLQXx72RV8b249i
 8KLzljApr93InK7xP1cr2PGrhrIrtY07/R6QeQN8SZQZs8t/9/n0UmFFf0xBJ3na8QMs2S
 wzOwePQuPw4qR9exhjNiRWFfx528lM0=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 Harry Wentland <harry.wentland@amd.com>, Melissa Wen <mwen@igalia.com>
Subject: [PATCH v2] drm/amd/display: Fix mem_type change detection for async
 flips
Date: Thu, 11 Jun 2026 08:44:38 -0700
Message-ID: <20260611154438.571685-1-matthew.schwartz@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Fri, 12 Jun 2026 07:46:58 +0000
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

[Why]
amdgpu_dm_crtc_mem_type_changed() fetches the "old" and "new" plane state
with two drm_atomic_get_plane_state() calls, which both return the new
state. It compares a state against itself, so it never detects a mem_type
change and never rejects the async flip.

On DCN 3.0.1, this shows up as intermittent corruption when a single DCC
plane is scanned out with immediate flips under gamescope and its buffer
moves between the VRAM carveout and GTT.

[How]
Use drm_atomic_get_old_plane_state() and drm_atomic_get_new_plane_state()
to compare the actual old and new states. These return NULL rather than
an error pointer for a plane that is not part of the commit, so the
IS_ERR() check becomes a NULL check that skips those planes, such as an
unmodified cursor still in the CRTC's plane_mask.

Fixes: 4caacd1671b7 ("drm/amd/display: Do not elevate mem_type change to full update")
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
Changes in v2:
- Fix sha sum length in Fixes: tag
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5fc5d5608506..6b5569647fce 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12549,13 +12549,11 @@ static bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
 	struct drm_plane_state *new_plane_state, *old_plane_state;
 
 	drm_for_each_plane_mask(plane, dev, crtc_state->plane_mask) {
-		new_plane_state = drm_atomic_get_plane_state(state, plane);
-		old_plane_state = drm_atomic_get_plane_state(state, plane);
+		new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+		old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 
-		if (IS_ERR(new_plane_state) || IS_ERR(old_plane_state)) {
-			drm_err(dev, "Failed to get plane state for plane %s\n", plane->name);
-			return false;
-		}
+		if (!old_plane_state || !new_plane_state)
+			continue;
 
 		if (old_plane_state->fb && new_plane_state->fb &&
 		    get_mem_type(old_plane_state->fb) != get_mem_type(new_plane_state->fb))
-- 
2.54.0

