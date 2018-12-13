From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 59/73] drm/amdgpu/vcn: Update vcn.cur_state during suspend
Date: Wed, 12 Dec 2018 23:28:24 -0500
Message-ID: <20181213042838.75160-59-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: James Zhu <James.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: James Zhu <James.Zhu@amd.com>

[ Upstream commit 0a9b89b2e2e7b6d90f81ddc47e489be1043e01b1 ]

Replace vcn_v1_0_stop with vcn_v1_0_set_powergating_state during suspend,
to keep adev->vcn.cur_state update. It will fix VCN S3 hung issue.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 072371ef5975..4f8f3bb21832 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -43,6 +43,7 @@ static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_jpeg_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_jpeg_ring_set_patch_ring(struct amdgpu_ring *ring, uint32_t ptr);
+static int vcn_v1_0_set_powergating_state(void *handle, enum amd_powergating_state state);
 
 /**
  * vcn_v1_0_early_init - set function pointers
@@ -216,7 +217,7 @@ static int vcn_v1_0_hw_fini(void *handle)
 	struct amdgpu_ring *ring = &adev->vcn.ring_dec;
 
 	if (RREG32_SOC15(VCN, 0, mmUVD_STATUS))
-		vcn_v1_0_stop(adev);
+		vcn_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
 
 	ring->ready = false;
 
-- 
2.19.1
