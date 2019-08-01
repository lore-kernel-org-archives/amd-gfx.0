From: Colin King <colin.king@canonical.com>
Subject: [PATCH][drm-next] drm/amdgpu: fix unsigned variable instance compared to less than zero
Date: Thu,  1 Aug 2019 12:01:45 +0100
Message-ID: <20190801110145.10803-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

Currenly the error check on variable instance is always false because
it is a uint32_t type and this is never less than zero. Fix this by
making it an int type.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: 7d0e6329dfdc ("drm/amdgpu: update more sdma instances irq support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index a33bd867287e..92257f2bf171 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1962,7 +1962,8 @@ static int sdma_v4_0_process_trap_irq(struct amdgpu_device *adev,
 static int sdma_v4_0_process_ras_data_cb(struct amdgpu_device *adev,
 		struct amdgpu_iv_entry *entry)
 {
-	uint32_t instance, err_source;
+	uint32_t err_source;
+	int instance;
 
 	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
 	if (instance < 0)
-- 
2.20.1
