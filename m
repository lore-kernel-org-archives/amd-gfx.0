From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] drm/amd: fix warning PTR_ERR_OR_ZERO can be used
Date: Sat, 25 May 2019 13:04:49 +0530
Message-ID: <20190525073449.GA7278@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, hersen wu <hersenxs.wu@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, David Francis <David.Francis@amd.com>, Hariprasad Kelam <hariprasad.kelam@gmail.com>, kbuild test robot <fengguang.wu@intel.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

fix below warnings reported by coccicheck

./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c:1057:1-3:
WARNING: PTR_ERR_OR_ZERO can be used

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 1d5fc5a..1b1ec12 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1054,8 +1054,6 @@ int dtn_debugfs_init(struct amdgpu_device *adev)
 
 	ent = debugfs_create_file_unsafe("amdgpu_dm_visual_confirm", 0644, root,
 					 adev, &visual_confirm_fops);
-	if (IS_ERR(ent))
-		return PTR_ERR(ent);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(ent);
 }
-- 
2.7.4
