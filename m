From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 55/81] drm/amdgpu: fix potential VM faults
Date: Wed, 30 Oct 2019 11:49:01 -0400
Message-ID: <20191030154928.9432-55-sashal@kernel.org>
References: <20191030154928.9432-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191030154928.9432-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: Christian König <christian.koenig@amd.com>

[ Upstream commit 3122051edc7c27cc08534be730f4c7c180919b8a ]

When we allocate new page tables under memory
pressure we should not evict old ones.

Signed-off-by: Christian König <christian.koenig@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index bea6f298dfdc5..0ff786dec8c4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -421,7 +421,8 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 		.interruptible = (bp->type != ttm_bo_type_kernel),
 		.no_wait_gpu = false,
 		.resv = bp->resv,
-		.flags = TTM_OPT_FLAG_ALLOW_RES_EVICT
+		.flags = bp->type != ttm_bo_type_kernel ?
+			TTM_OPT_FLAG_ALLOW_RES_EVICT : 0
 	};
 	struct amdgpu_bo *bo;
 	unsigned long page_align, size = bp->size;
-- 
2.20.1
