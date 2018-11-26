From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drm/amdgpu: fix spelling mistake "Pramater" -> "Parameter"
Date: Mon, 26 Nov 2018 15:02:28 +0000
Message-ID: <20181126150228.8578-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the module description text and
a comment too, fix them. Also line break overly long comment.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 8de55f7f1a3a..dd03fe77b3ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -454,9 +454,10 @@ module_param_named(cntl_sb_buf_per_se, amdgpu_cntl_sb_buf_per_se, int, 0444);
 
 /**
  * DOC: param_buf_per_se (int)
- * Override the size of Off-Chip Pramater Cache per Shader Engine in Byte. The default is 0 (depending on gfx).
+ * Override the size of Off-Chip Parameter Cache per Shader Engine in Byte.
+ * The default is 0 (depending on gfx).
  */
-MODULE_PARM_DESC(param_buf_per_se, "the size of Off-Chip Pramater Cache per Shader Engine (default depending on gfx)");
+MODULE_PARM_DESC(param_buf_per_se, "the size of Off-Chip Parameter Cache per Shader Engine (default depending on gfx)");
 module_param_named(param_buf_per_se, amdgpu_param_buf_per_se, int, 0444);
 
 /**
-- 
2.19.1
