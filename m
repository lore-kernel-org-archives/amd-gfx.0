From: Yu Zhao <yuzhao@google.com>
Subject: [PATCH v6 1/2] drm/amd: validate user pitch alignment
Date: Mon,  7 Jan 2019 15:51:14 -0700
Message-ID: <20190107225115.163992-1-yuzhao@google.com>
References: <20181230010021.196990-1-yuzhao@google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181230010021.196990-1-yuzhao@google.com>
Sender: stable-owner@vger.kernel.org
To: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: David Zhou <David1.Zhou@amd.com>, Samuel Li <Samuel.Li@amd.com>, Harry Wentland <harry.wentland@amd.com>, Junwei Zhang <Jerry.Zhang@amd.com>, Daniel Stone <daniels@collabora.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Userspace may request pitch alignment that is not supported by GPU.
Some requests 32, but GPU ignores it and uses default 64 when cpp is
4. If GEM object is allocated based on the smaller alignment, GPU
DMA will go out of bound.

Cc: stable@vger.kernel.org # v4.2+
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 15ce7e681d67..de9f198d5371 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -527,6 +527,16 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 	struct drm_gem_object *obj;
 	struct amdgpu_framebuffer *amdgpu_fb;
 	int ret;
+	struct amdgpu_device *adev = dev->dev_private;
+	int cpp = drm_format_plane_cpp(mode_cmd->pixel_format, 0);
+	int pitch = mode_cmd->pitches[0] / cpp;
+
+	pitch = amdgpu_align_pitch(adev, pitch, cpp, false);
+	if (mode_cmd->pitches[0] != pitch) {
+		DRM_DEBUG_KMS("Invalid pitch: expecting %d but got %d\n",
+			      pitch, mode_cmd->pitches[0]);
+		return ERR_PTR(-EINVAL);
+	}
 
 	obj = drm_gem_object_lookup(file_priv, mode_cmd->handles[0]);
 	if (obj ==  NULL) {
-- 
2.20.1.97.g81188d93c3-goog
