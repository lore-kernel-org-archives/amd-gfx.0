From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 56/81] drm/amdgpu: fix error handling in amdgpu_bo_list_create
Date: Wed, 30 Oct 2019 11:49:02 -0400
Message-ID: <20191030154928.9432-56-sashal@kernel.org>
References: <20191030154928.9432-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191030154928.9432-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: Christian König <christian.koenig@amd.com>

[ Upstream commit de51a5019ff32960218da8fd899fa3f361b031e9 ]

We need to drop normal and userptr BOs separately.

Signed-off-by: Christian König <christian.koenig@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 7bcf86c619995..d4c4785ab5256 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -140,7 +140,12 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
 	return 0;
 
 error_free:
-	while (i--) {
+	for (i = 0; i < last_entry; ++i) {
+		struct amdgpu_bo *bo = ttm_to_amdgpu_bo(array[i].tv.bo);
+
+		amdgpu_bo_unref(&bo);
+	}
+	for (i = first_userptr; i < num_entries; ++i) {
 		struct amdgpu_bo *bo = ttm_to_amdgpu_bo(array[i].tv.bo);
 
 		amdgpu_bo_unref(&bo);
-- 
2.20.1
