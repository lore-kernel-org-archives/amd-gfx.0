From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] drm/amd/display: fix unsigned less than 0 comparison on error check
Date: Fri,  8 Nov 2019 15:00:17 +0000
Message-ID: <20191108150017.125859-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Lyude Paul <lyude@redhat.com>, Mikita Lipski <mikita.lipski@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

Currently the error check on the call to drm_dp_atomic_find_vcpi_slots
is always false because an unsigned dm_new_connector_state->vcpi_slots
is being checked for a less than zero. Fix this by casting this to
an int on the comparison.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: 5133c6241d9c ("drm/amd/display: Add MST atomic routines")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 37c56156a116..00e730b8d98f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4866,7 +4866,7 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 									   mst_mgr,
 									   mst_port,
 									   dm_new_connector_state->pbn);
-	if (dm_new_connector_state->vcpi_slots < 0) {
+	if ((int)dm_new_connector_state->vcpi_slots < 0) {
 		DRM_DEBUG_ATOMIC("failed finding vcpi slots: %d\n", (int)dm_new_connector_state->vcpi_slots);
 		return dm_new_connector_state->vcpi_slots;
 	}
-- 
2.20.1
