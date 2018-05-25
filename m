From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/8] drm/amdgpu: fix 32-bit build warning
Date: Fri, 25 May 2018 17:50:09 +0200
Message-ID: <20180525155030.3667352-2-arnd@arndb.de>
References: <20180525155030.3667352-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180525155030.3667352-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>
Cc: Arnd Bergmann <arnd@arndb.de>, Felix Kuehling <Felix.Kuehling@amd.com>, Andres Rodriguez <andresx7@gmail.com>, Kent Russell <kent.russell@amd.com>, Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Colin Ian King <colin.king@canonical.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Casting a pointer to a 64-bit type causes a warning on 32-bit targets:

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c:473:24: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
          lower_32_bits((uint64_t)wptr));
                        ^
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1701:53: note: in definition of macro 'WREG32'
 #define WREG32(reg, v) amdgpu_mm_wreg(adev, (reg), (v), 0)
                                                     ^
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c:473:10: note: in expansion of macro 'lower_32_bits'
          lower_32_bits((uint64_t)wptr));
          ^~~~~~~~~~~~~

The correct method is to cast to 'uintptr_t'.

Fixes: d5a114a6c5f7 ("drm/amdgpu: Add GFXv9 kfd2kgd interface functions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 8f37991df61b..f0c0d3953f69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -470,9 +470,9 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI),
 		       upper_32_bits(guessed_wptr));
 		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
-		       lower_32_bits((uint64_t)wptr));
+		       lower_32_bits((uintptr_t)wptr));
 		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
-		       upper_32_bits((uint64_t)wptr));
+		       upper_32_bits((uintptr_t)wptr));
 		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),
 		       get_queue_mask(adev, pipe_id, queue_id));
 	}
-- 
2.9.0
