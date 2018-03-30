From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] drm/amdgpu/si: implement get/set pcie_lanes asic callback
Date: Fri, 30 Mar 2018 13:37:11 -0500
Message-ID: <20180330183711.8836-1-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Required for dpm setup on some asics. Fixes a NULL dereference
on asics that require it.

Bug: https://bugs.freedesktop.org/show_bug.cgi?id=102553
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/si.c | 67 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 775cacfe9917..c364ef94cc36 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1258,6 +1258,71 @@ static bool si_need_full_reset(struct amdgpu_device *adev)
 	return true;
 }
 
+static int si_get_pcie_lanes(struct amdgpu_device *adev)
+{
+	u32 link_width_cntl;
+
+	if (adev->flags & AMD_IS_APU)
+		return 0;
+
+	link_width_cntl = RREG32_PCIE_PORT(PCIE_LC_LINK_WIDTH_CNTL);
+
+	switch ((link_width_cntl & LC_LINK_WIDTH_RD_MASK) >> LC_LINK_WIDTH_RD_SHIFT) {
+	case LC_LINK_WIDTH_X1:
+		return 1;
+	case LC_LINK_WIDTH_X2:
+		return 2;
+	case LC_LINK_WIDTH_X4:
+		return 4;
+	case LC_LINK_WIDTH_X8:
+		return 8;
+	case LC_LINK_WIDTH_X0:
+	case LC_LINK_WIDTH_X16:
+	default:
+		return 16;
+	}
+}
+
+static void si_set_pcie_lanes(struct amdgpu_device *adev, int lanes)
+{
+	u32 link_width_cntl, mask;
+
+	if (adev->flags & AMD_IS_APU)
+		return;
+
+	switch (lanes) {
+	case 0:
+		mask = LC_LINK_WIDTH_X0;
+		break;
+	case 1:
+		mask = LC_LINK_WIDTH_X1;
+		break;
+	case 2:
+		mask = LC_LINK_WIDTH_X2;
+		break;
+	case 4:
+		mask = LC_LINK_WIDTH_X4;
+		break;
+	case 8:
+		mask = LC_LINK_WIDTH_X8;
+		break;
+	case 16:
+		mask = LC_LINK_WIDTH_X16;
+		break;
+	default:
+		DRM_ERROR("invalid pcie lane request: %d\n", lanes);
+		return;
+	}
+
+	link_width_cntl = RREG32_PCIE_PORT(PCIE_LC_LINK_WIDTH_CNTL);
+	link_width_cntl &= ~LC_LINK_WIDTH_MASK;
+	link_width_cntl |= mask << LC_LINK_WIDTH_SHIFT;
+	link_width_cntl |= (LC_RECONFIG_NOW |
+			    LC_RECONFIG_ARC_MISSING_ESCAPE);
+
+	WREG32_PCIE_PORT(PCIE_LC_LINK_WIDTH_CNTL, link_width_cntl);
+}
+
 static const struct amdgpu_asic_funcs si_asic_funcs =
 {
 	.read_disabled_bios = &si_read_disabled_bios,
@@ -1268,6 +1333,8 @@ static const struct amdgpu_asic_funcs si_asic_funcs =
 	.get_xclk = &si_get_xclk,
 	.set_uvd_clocks = &si_set_uvd_clocks,
 	.set_vce_clocks = NULL,
+	.get_pcie_lanes = &si_get_pcie_lanes,
+	.set_pcie_lanes = &si_set_pcie_lanes,
 	.get_config_memsize = &si_get_config_memsize,
 	.flush_hdp = &si_flush_hdp,
 	.invalidate_hdp = &si_invalidate_hdp,
-- 
2.13.6
