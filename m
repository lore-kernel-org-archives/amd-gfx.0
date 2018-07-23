From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: amdgpu: Replace mdelay with msleep in cik_pcie_gen3_enable()
Date: Mon, 23 Jul 2018 22:29:56 +0800
Message-ID: <20180723142956.3718-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, Rex.Zhu@amd.com, harry.wentland@amd.com, Samuel.Li@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

cik_pcie_gen3_enable() is only called by cik_common_hw_init(), which is
never called in atomic context.
cik_pcie_gen3_enable() calls mdelay() to busily wait, which is not
necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/cik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 0df22030e713..5b7fab2c2008 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1476,7 +1476,7 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 				tmp |= PCIE_LC_CNTL4__LC_REDO_EQ_MASK;
 				WREG32_PCIE(ixPCIE_LC_CNTL4, tmp);
 
-				mdelay(100);
+				msleep(100);
 
 				/* linkctl */
 				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &tmp16);
-- 
2.17.0
