From: Helen Koike <helen.koike@collabora.com>
Subject: [PATCH v4 2/5] drm/amd: fix fb references in async update
Date: Mon,  3 Jun 2019 13:56:07 -0300
Message-ID: <20190603165610.24614-3-helen.koike@collabora.com>
References: <20190603165610.24614-1-helen.koike@collabora.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190603165610.24614-1-helen.koike@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, nicholas.kazlauskas@amd.com
Cc: andrey.grodzovsky@amd.com, daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, boris.brezillon@collabora.com, David Airlie <airlied@linux.ie>, Sean Paul <seanpaul@google.com>, kernel@collabora.com, harry.wentland@amd.com, =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@google.com>, Helen Koike <helen.koike@collabora.com>, Leo Li <sunpeng.li@amd.com>, David Francis <David.Francis@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Anthony Koo <Anthony.Koo@amd.com>, amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Mario Kleiner <mario.kleiner.de@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
List-Id: amd-gfx.lists.freedesktop.org

Async update callbacks are expected to set the old_fb in the new_state
so prepare/cleanup framebuffers are balanced.

Calling drm_atomic_set_fb_for_plane() (which gets a reference of the new
fb and put the old fb) is not required, as it's taken care by
drm_mode_cursor_universal() when calling drm_atomic_helper_update_plane().

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Helen Koike <helen.koike@collabora.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

---

Changes in v4: None
Changes in v3: None
Changes in v2:
- added reviewed-by tag

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 443b13ec268d..40624b2c630e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4347,8 +4347,7 @@ static void dm_plane_atomic_async_update(struct drm_plane *plane,
 	struct drm_plane_state *old_state =
 		drm_atomic_get_old_plane_state(new_state->state, plane);
 
-	if (plane->state->fb != new_state->fb)
-		drm_atomic_set_fb_for_plane(plane->state, new_state->fb);
+	swap(plane->state->fb, new_state->fb);
 
 	plane->state->src_x = new_state->src_x;
 	plane->state->src_y = new_state->src_y;
-- 
2.20.1
