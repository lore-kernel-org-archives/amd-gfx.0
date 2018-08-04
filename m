From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: radeon: cik: Replace mdelay() with msleep() in cik_pcie_gen3_enable()
Date: Sat,  4 Aug 2018 08:25:35 +0800
Message-ID: <20180804002535.18434-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

cik_pcie_gen3_enable() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/radeon/cik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 7c73bc7e2f85..c1b4d4fbcf3a 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -9598,7 +9598,7 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
 				tmp |= LC_REDO_EQ;
 				WREG32_PCIE_PORT(PCIE_LC_CNTL4, tmp);
 
-				mdelay(100);
+				msleep(100);
 
 				/* linkctl */
 				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &tmp16);
-- 
2.17.0
