From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amd/display: Use memset to initialize variables in amdgpu_dm_atomic_commit_tail
Date: Fri,  1 Feb 2019 13:14:28 -0700
Message-ID: <20190201201428.13357-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, David Francis <David.Francis@amd.com>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

Clang warns:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5089:60:
warning: suggest braces around initialization of subobject
[-Wmissing-braces]
                struct dc_surface_update dummy_updates[MAX_SURFACES] = { 0 };
                                                                         ^
                                                                         {}

Previous efforts to fix this type of warning by adding or removing
braces have been met with some pushback in favor of using memset [1][2].
Do that here, mirroring commit 05794eff1aa6 ("drm/amdgpu/gmc: fix
compiler errors [-Werror,-Wmissing-braces] (V2)") in this tree.

[1]: https://lore.kernel.org/lkml/022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com/
[2]: https://lore.kernel.org/lkml/20181128.215241.702406654469517539.davem@davemloft.net/

Fixes: 02d6a6fcdf68 ("drm/amd/display: Simplify underscan and ABM commit")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1c1c162c4eee..f70f4bbde665 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5089,10 +5089,13 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
 		struct dm_connector_state *dm_old_con_state = to_dm_connector_state(old_con_state);
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
-		struct dc_surface_update dummy_updates[MAX_SURFACES] = { 0 };
-		struct dc_stream_update stream_update = { 0 };
+		struct dc_surface_update dummy_updates[MAX_SURFACES];
+		struct dc_stream_update stream_update;
 		struct dc_stream_status *status = NULL;
 
+		memset(&dummy_updates, 0, sizeof(dummy_updates));
+		memset(&stream_update, 0, sizeof(stream_update));
+
 		if (acrtc) {
 			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
 			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
-- 
2.20.1
