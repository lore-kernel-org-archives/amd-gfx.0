From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] drm/amdgpu: remove redundant variable r and redundant return statement
Date: Thu,  3 Oct 2019 22:40:49 +0100
Message-ID: <20191003214049.23067-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

There is a return statement that is not reachable and a variable that
is not used.  Remove them.

Addresses-Coverity: ("Structurally dead code")
Fixes: de7b45babd9b ("drm/amdgpu: cleanup creating BOs at fixed location (v2)")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 481e4c381083..814159f15633 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1636,7 +1636,6 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
 static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
 {
 	uint64_t vram_size = adev->gmc.visible_vram_size;
-	int r;
 
 	adev->fw_vram_usage.va = NULL;
 	adev->fw_vram_usage.reserved_bo = NULL;
@@ -1651,7 +1650,6 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
 					  AMDGPU_GEM_DOMAIN_VRAM,
 					  &adev->fw_vram_usage.reserved_bo,
 					  &adev->fw_vram_usage.va);
-	return r;
 }
 
 /**
-- 
2.20.1
