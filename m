From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 04/25] drm/amdgpu: psp_ring_destroy cause psp->km_ring.ring_mem NULL
Date: Fri, 29 Mar 2019 21:28:21 -0400
Message-ID: <20190330012842.32091-4-sashal@kernel.org>
References: <20190330012842.32091-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190330012842.32091-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: wentalou <Wentao.Lou@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: wentalou <Wentao.Lou@amd.com>

[ Upstream commit 14d20ec7f31ef96a2e7dcf7880b13dde1d473b56 ]

psp_ring_destroy inside psp_load_fw cause psp->km_ring.ring_mem NULL.
Call Trace occurred when psp_cmd_submit.
should be psp_ring_stop instead.

Reviewed-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
Signed-off-by: Wentao Lou <Wentao.Lou@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3a9b48b227ac..a7208ca0bfe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -546,7 +546,7 @@ static int psp_load_fw(struct amdgpu_device *adev)
 	struct psp_context *psp = &adev->psp;
 
 	if (amdgpu_sriov_vf(adev) && adev->in_gpu_reset) {
-		psp_ring_destroy(psp, PSP_RING_TYPE__KM);
+		psp_ring_stop(psp, PSP_RING_TYPE__KM); /* should not destroy ring, only stop */
 		goto skip_memalloc;
 	}
 
-- 
2.19.1
