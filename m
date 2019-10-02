From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5/6] [RESEND] drm/amd/display: hide an unused variable
Date: Wed,  2 Oct 2019 14:01:26 +0200
Message-ID: <20191002120136.1777161-6-arnd@arndb.de>
References: <20191002120136.1777161-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191002120136.1777161-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: clang-built-linux@googlegroups.com, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>, Dingchen Zhang <dingchen.zhang@amd.com>, Harry Wentland <Harry.Wentland@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, David Francis <David.Francis@amd.com>, Mario Kleiner <mario.kleiner.de@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

Without CONFIG_DEBUG_FS, we get a warning for an unused
variable:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6020:33: error: unused variable 'source' [-Werror,-Wunused-variable]

Hide the variable in an #ifdef like its only users.

Fixes: 14b2584636c6 ("drm/amd/display: add functionality to grab DPRX CRC entries.")
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This was a bugfix for a commit that landed in v5.4-rc1. The
fix was applied by Alex Deucher on Sep 19, but is still not
seen in linux-next.
Resending to make sure this makes it into v5.4-final, but
please ignore if this is already coming.
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8cab6da512a0..7516a6436822 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6019,7 +6019,9 @@ static void amdgpu_dm_enable_crtc_interrupts(struct drm_device *dev,
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
 	int i;
+#ifdef CONFIG_DEBUG_FS
 	enum amdgpu_dm_pipe_crc_source source;
+#endif
 
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
 				      new_crtc_state, i) {
-- 
2.20.0
