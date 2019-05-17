From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] drm/amdgpu/soc15: skip reset on init
Date: Fri, 17 May 2019 09:26:47 -0500
Message-ID: <20190517142647.26034-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Not necessary on soc15 and breaks driver reload on server cards.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 32dc5a128249..78bd4fc07bab 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -761,6 +761,11 @@ static bool soc15_need_reset_on_init(struct amdgpu_device *adev)
 {
 	u32 sol_reg;
 
+	/* Just return false for soc15 GPUs.  Reset does not seem to
+	 * be necessary.
+	 */
+	return false;
+
 	if (adev->flags & AMD_IS_APU)
 		return false;
 
-- 
2.20.1
