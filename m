From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 011/101] drm/amdgpu/sriov: Need to initialize the HDP_NONSURFACE_BAStE
Date: Fri, 19 Jul 2019 00:06:02 -0400
Message-ID: <20190719040732.17285-11-sashal@kernel.org>
References: <20190719040732.17285-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190719040732.17285-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Tiecheng Zhou <Tiecheng.Zhou@amd.com>, Emily Deng <Emily.Deng@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: Tiecheng Zhou <Tiecheng.Zhou@amd.com>

[ Upstream commit fe2b5323d2c3cedaa3bf943dc7a0d233c853c914 ]

it requires to initialize HDP_NONSURFACE_BASE, so as to avoid
using the value left by a previous VM under sriov scenario.

v2: it should not hurt baremetal, generalize it for both sriov
and baremetal

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 72f8018fa2a8..ede27dab675f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1037,6 +1037,9 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 	tmp = RREG32_SOC15(HDP, 0, mmHDP_HOST_PATH_CNTL);
 	WREG32_SOC15(HDP, 0, mmHDP_HOST_PATH_CNTL, tmp);
 
+	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE, (adev->gmc.vram_start >> 8));
+	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE_HI, (adev->gmc.vram_start >> 40));
+
 	/* After HDP is initialized, flush HDP.*/
 	adev->nbio_funcs->hdp_flush(adev, NULL);
 
-- 
2.20.1
