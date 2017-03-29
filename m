From: Jan Burgmeier <jan.burgmeier@unicon-software.com>
Subject: [PATCH] Fix IB va_start+ib_bytes range check on 32Bit systems
Date: Wed, 29 Mar 2017 11:18:39 +0200
Message-ID: <20170329091839.5246-2-jan.burgmeier@unicon-software.com>
References: <20170329091839.5246-1-jan.burgmeier@unicon-software.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170329091839.5246-1-jan.burgmeier@unicon-software.com>
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: airlied@linux.ie
List-Id: amd-gfx.lists.freedesktop.org

Signed-off-by: Jan Burgmeier <jan.burgmeier@unicon-software.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 99424cb8020b..583d22974e14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -908,6 +908,7 @@ static int amdgpu_cs_ib_fill(struct amdgpu_device *adev,
 			struct amdgpu_bo *aobj = NULL;
 			uint64_t offset;
 			uint8_t *kptr;
+			uint64_t it_last;
 
 			m = amdgpu_cs_find_mapping(parser, chunk_ib->va_start,
 						   &aobj);
@@ -916,8 +917,9 @@ static int amdgpu_cs_ib_fill(struct amdgpu_device *adev,
 				return -EINVAL;
 			}
 
+			it_last = m->it.last;
 			if ((chunk_ib->va_start + chunk_ib->ib_bytes) >
-			    (m->it.last + 1) * AMDGPU_GPU_PAGE_SIZE) {
+			    (it_last + 1) * AMDGPU_GPU_PAGE_SIZE) {
 				DRM_ERROR("IB va_start+ib_bytes is invalid\n");
 				return -EINVAL;
 			}
-- 
2.11.0
