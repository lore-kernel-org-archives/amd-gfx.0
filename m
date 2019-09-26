From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH 5/6] drm/amdgpu/dm/mst: Report possible_crtcs incorrectly, for now
Date: Thu, 26 Sep 2019 18:51:07 -0400
Message-ID: <20190926225122.31455-6-lyude@redhat.com>
References: <20190926225122.31455-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926225122.31455-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, David Francis <David.Francis@amd.com>, Mario Kleiner <mario.kleiner.de@gmail.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

This commit is seperate from the previous one to make it easier to
revert in the future. Basically, there's multiple userspace applications
that interpret possible_crtcs very wrong:

https://gitlab.freedesktop.org/xorg/xserver/merge_requests/277
https://gitlab.gnome.org/GNOME/mutter/issues/759

While work is ongoing to fix these issues in userspace, we need to
report ->possible_crtcs incorrectly for now in order to avoid
introducing a regression in in userspace. Once these issues get fixed,
this commit should be reverted.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b404f1ae6df7..fe8ac801d7a5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4807,6 +4807,17 @@ static int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 	if (!acrtc->mst_encoder)
 		goto fail;
 
+	/*
+	 * FIXME: This is a hack to workaround the following issues:
+	 *
+	 * https://gitlab.gnome.org/GNOME/mutter/issues/759
+	 * https://gitlab.freedesktop.org/xorg/xserver/merge_requests/277
+	 *
+	 * One these issues are closed, this should be removed
+	 */
+	acrtc->mst_encoder->base.possible_crtcs =
+		amdgpu_dm_get_encoder_crtc_mask(dm->adev);
+
 	return 0;
 
 fail:
-- 
2.21.0
