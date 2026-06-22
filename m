Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37967CDB46F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 12:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF04D10E678;
	Mon, 22 Jun 2026 12:10:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="cjm13Tk4";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B897610E677
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 12:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=l5PM8Sctd6mX1+wNcOmCjfuWpeP2crWNWiTk2DUwTG4=; b=cjm13Tk4zfVL4QvdCAEIqOack1
 sDuPICB7AJQHWn6fPQG/tJskslUOlz4jdoZ8WKj3z5IFMrfy/O8Iewv+vbK6CNHhmWb/nTQOXtTfr
 da5IaeWDDebBbK1Tzk1+4SwUx6iejCjYoTzX/7AjLxti2YF5WlwWDDX/ScNvWXQpq7LrYLGndINWN
 nYCmFq4vEUZOvS9FZWLiI6KB/Mx87w7XyPakJhuY9loa3nY3Suewk4COZpZRclLX4HUOFTGAzGU8b
 1O133XJ991iDJM73QFurTWVx1jAUJ71iQKa5eTexnilELJTcW9qX8bEAjnX44SH9Xg8wnGM/KAhmj
 KGxUwzNw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wbdU4-003j56-PG; Mon, 22 Jun 2026 14:10:36 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH] drm/amdgpu: Extend logical to device instance lookup to all
 devices
Date: Mon, 22 Jun 2026 13:10:34 +0100
Message-ID: <20260622121034.52762-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A subset of supported devices can have a mismatch between the logical and
device engine instance numbers which the driver currently solves by a
combination of lookup table generated at driver init time, and a
conditionally set vfunc checked and used at runtime to do the lookup.

As the requirement to do these lookups is relatively widespread in the
code base, plus the fact the mapping table is already allocated for all
possible hw ips and instances, we can significantly streamline them by
initializing the said lookup table unconditionally to the predominant
"identity map" (logical instance numbers equal to device instances),
and allow affected parts to re-configure the table based on their
configuration.

The effect is that for each lookup site we replace the conditional
followed by a indirect function call with a simple two-dimensional table
lookup.

Bloat-o-meter agrees the savings are significant:

add/remove: 13/12 grow/shrink: 23/279 up/down: 51626/-198973 (-147347)
...
Total: Before=10139692, After=9992345, chg -1.45%

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c        | 49 +++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h        | 21 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  8 +--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/soc15_common.h     |  6 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c       |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  1 +
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h     |  7 ++-
 34 files changed, 70 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 15385aa3a1b4..16b6323b3c77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -20,6 +20,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_amdkfd_gfx_v9.h"
 #include "amdgpu_amdkfd_aldebaran.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 088d09cc7a72..021f6fb083ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -20,6 +20,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_amdkfd.h"
 #include "gc/gc_9_0_offset.h"
 #include "gc/gc_9_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 42fff6ee106d..e0b7a0058dea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -68,6 +68,7 @@
 #include "amdgpu_vf_error.h"
 
 #include "amdgpu_amdkfd.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_pm.h"
 
 #include "amdgpu_xgmi.h"
@@ -3778,6 +3779,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	spin_lock_init(&adev->irq.lock);
 
+	amdgpu_ip_map_init(adev);
 	amdgpu_early_init_rlc_reg_funcs(adev);
 	amdgpu_device_init_apu_flags(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
index 6aa54156bbc9..524318088d49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
@@ -24,39 +24,16 @@
 #include "amdgpu.h"
 #include "amdgpu_ip.h"
 
-static int8_t amdgpu_logical_to_dev_inst(struct amdgpu_device *adev,
-					 enum amd_hw_ip_block_type block,
-					 int8_t inst)
+u32 amdgpu_ip_map_logical_to_dev_mask(struct amdgpu_ip_map_info *ip_map,
+				      enum amd_hw_ip_block_type block,
+				      u32 mask)
 {
-	int8_t dev_inst;
-
-	switch (block) {
-	case GC_HWIP:
-	case SDMA0_HWIP:
-	/* Both JPEG and VCN as JPEG is only alias of VCN */
-	case VCN_HWIP:
-		dev_inst = adev->ip_map.dev_inst[block][inst];
-		break;
-	default:
-		/* For rest of the IPs, no look up required.
-		 * Assume 'logical instance == physical instance' for all configs. */
-		dev_inst = inst;
-		break;
-	}
-
-	return dev_inst;
-}
-
-static uint32_t amdgpu_logical_to_dev_mask(struct amdgpu_device *adev,
-					   enum amd_hw_ip_block_type block,
-					   uint32_t mask)
-{
-	uint32_t dev_mask = 0;
-	int8_t log_inst, dev_inst;
+	unsigned int log_inst, dev_inst;
+	u32 dev_mask = 0;
 
 	while (mask) {
 		log_inst = ffs(mask) - 1;
-		dev_inst = amdgpu_logical_to_dev_inst(adev, block, log_inst);
+		dev_inst = ip_map->dev_inst[block][log_inst];
 		dev_mask |= (1 << dev_inst);
 		mask &= ~(1 << log_inst);
 	}
@@ -80,6 +57,17 @@ static void amdgpu_populate_ip_map(struct amdgpu_device *adev,
 }
 
 void amdgpu_ip_map_init(struct amdgpu_device *adev)
+{
+	int i, j;
+
+	/* Assume 'logical instance == physical instance' unless overridden. */
+	for (i = 0; i < MAX_HWIP; i++) {
+		for (j = 0; j < HWIP_MAX_INSTANCE; j++)
+			adev->ip_map.dev_inst[i][j] = j;
+	}
+}
+
+void amdgpu_ip_map_aqua_vanjaram_override(struct amdgpu_device *adev)
 {
 	u32 ip_map[][2] = {
 		{ GC_HWIP, adev->gfx.xcc_mask },
@@ -90,9 +78,6 @@ void amdgpu_ip_map_init(struct amdgpu_device *adev)
 
 	for (i = 0; i < ARRAY_SIZE(ip_map); ++i)
 		amdgpu_populate_ip_map(adev, ip_map[i][0], ip_map[i][1]);
-
-	adev->ip_map.logical_to_dev_inst = amdgpu_logical_to_dev_inst;
-	adev->ip_map.logical_to_dev_mask = amdgpu_logical_to_dev_mask;
 }
 
 int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
index 590ad82f115e..3c225dcb9ee0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
@@ -87,13 +87,7 @@ enum amd_hw_ip_block_type {
 
 struct amdgpu_ip_map_info {
 	/* Map of logical to actual dev instances/mask */
-	uint32_t dev_inst[MAX_HWIP][HWIP_MAX_INSTANCE];
-	int8_t (*logical_to_dev_inst)(struct amdgpu_device *adev,
-				      enum amd_hw_ip_block_type block,
-				      int8_t inst);
-	uint32_t (*logical_to_dev_mask)(struct amdgpu_device *adev,
-					enum amd_hw_ip_block_type block,
-					uint32_t mask);
+	unsigned int dev_inst[MAX_HWIP][HWIP_MAX_INSTANCE];
 };
 
 #define AMDGPU_MAX_IP_NUM AMD_IP_BLOCK_TYPE_NUM
@@ -121,6 +115,19 @@ struct amdgpu_ip_block {
 };
 
 void amdgpu_ip_map_init(struct amdgpu_device *adev);
+void amdgpu_ip_map_aqua_vanjaram_override(struct amdgpu_device *adev);
+
+u32 amdgpu_ip_map_logical_to_dev_mask(struct amdgpu_ip_map_info *ip_map,
+				      enum amd_hw_ip_block_type block,
+				      u32 mask);
+
+static inline unsigned int
+amdgpu_ip_map_logical_to_dev_inst(struct amdgpu_ip_map_info *ip_map,
+				  enum amd_hw_ip_block_type block,
+				  unsigned int inst)
+{
+	return ip_map->dev_inst[block][inst];
+}
 
 int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block);
 int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 63ee6ba6a931..620dc338e0a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -25,6 +25,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_jpeg.h"
 #include "amdgpu_pm.h"
 #include "soc15d.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 4b91a22701dc..caa031d1a4a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -27,6 +27,7 @@
 #include <drm/drm_drv.h>
 
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_psp.h"
 #include "amdgpu_ucode.h"
 #include "amdgpu_xgmi.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 389f69c7d5c3..0cef515a571b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -23,6 +23,7 @@
 #include "amdgpu.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_drv.h"
+#include "amdgpu_ip.h"
 
 #include <drm/drm_drv.h>
 #include "../amdxcp/amdgpu_xcp_drv.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 72ea37dbfea8..b9d1dae3ab11 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -545,7 +545,7 @@ int aqua_vanjaram_init_soc_config(struct amdgpu_device *adev)
 	if (ret)
 		return ret;
 
-	amdgpu_ip_map_init(adev);
+	amdgpu_ip_map_aqua_vanjaram_override(adev);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 71a2558acef8..f4285b5abc67 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -23,6 +23,7 @@
 #include <linux/firmware.h>
 
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_gfx.h"
 #include "soc15.h"
 #include "soc15d.h"
@@ -1708,10 +1709,9 @@ static bool gfx_v9_4_3_check_rlcg_range(struct amdgpu_device *adev,
 		const struct soc15_reg_rlcg *entry;
 
 		entry = &entries[i];
-		inst = adev->ip_map.logical_to_dev_inst ?
-			       adev->ip_map.logical_to_dev_inst(
-				       adev, entry->hwip, entry->instance) :
-			       entry->instance;
+		inst = amdgpu_ip_map_logical_to_dev_inst(&adev->ip_map,
+							 entry->hwip,
+							 entry->instance);
 		reg = adev->reg_offset[entry->hwip][inst][entry->segment] +
 		      entry->reg;
 		if (offset == reg)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index fbdf46070b38..4c37a4ad77a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -21,6 +21,7 @@
  *
  */
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_xcp.h"
 #include "gfxhub_v1_2.h"
 #include "gfxhub_v1_1.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 6be2000c8261..3e61febfa0bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -26,6 +26,7 @@
 #include <drm/drm_cache.h>
 
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_atomfirmware.h"
 #include "gmc_v10_0.h"
 #include "umc_v8_7.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 8eb9847d9e1e..0345adc52842 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -26,6 +26,7 @@
 #include <drm/drm_cache.h>
 
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_atomfirmware.h"
 #include "gmc_v11_0.h"
 #include "umc_v8_10.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 84c93364d220..51665ba567e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -27,6 +27,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_atomfirmware.h"
+#include "amdgpu_ip.h"
 #include "gmc_v12_0.h"
 #include "gmc_v12_1.h"
 #include "athub/athub_4_1_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 8a5c44810ba1..f96f119bcc3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -62,6 +62,7 @@
 
 #include "ivsrcid/vmc/irqsrcs_vmc_1_0.h"
 
+#include "amdgpu_ip.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index b0bdb449538e..ec57256ddd1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_jpeg.h"
 #include "soc15.h"
 #include "soc15d.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index a43582b9c876..3372ef240a2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_jpeg.h"
 #include "amdgpu_pm.h"
 #include "soc15.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 72a4b2d0676f..836da8c3a590 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_jpeg.h"
 #include "amdgpu_pm.h"
 #include "soc15.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index e023ae958459..44c5de8e4cf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_jpeg.h"
 #include "amdgpu_pm.h"
 #include "soc15.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index bdfd2917e3ca..80f5e8106d5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -22,6 +22,7 @@
  */
 #include "amdgpu.h"
 #include "nbio_v7_9.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_ras.h"
 
 #include "nbio/nbio_7_9_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 777a70852883..4b51e9308c54 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -27,6 +27,7 @@
 #include <linux/pci.h>
 
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_ucode.h"
 #include "amdgpu_trace.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index e8c1d0f207e7..2011361b8738 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -26,11 +26,9 @@
 
 /* GET_INST returns the physical instance corresponding to a logical instance */
 #define GET_INST(ip, inst) \
-	(adev->ip_map.logical_to_dev_inst ? \
-	adev->ip_map.logical_to_dev_inst(adev, ip##_HWIP, inst) : inst)
+	amdgpu_ip_map_logical_to_dev_inst(&adev->ip_map, ip##_HWIP, inst)
 #define GET_MASK(ip, mask) \
-	(adev->ip_map.logical_to_dev_mask ? \
-	adev->ip_map.logical_to_dev_mask(adev, ip##_HWIP, mask) : mask)
+	amdgpu_ip_map_logical_to_dev_mask(&adev->ip_map, ip##_HWIP, mask)
 
 /* Register Access Macros */
 #define SOC15_REG_OFFSET(ip, inst, reg)	(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 0442bfcfd384..774cf5ed6824 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -25,6 +25,7 @@
 #include <drm/drm_drv.h>
 
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_vcn.h"
 #include "soc15.h"
 #include "soc15d.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 8b8184fe6764..38cc6afa9220 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -25,6 +25,7 @@
 #include <drm/drm_drv.h>
 
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_vcn.h"
 #include "amdgpu_pm.h"
 #include "soc15.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 81bba3ec2a93..aabd0f63134a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -23,6 +23,7 @@
 
 #include <linux/firmware.h>
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_vcn.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_cs.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 4389f8e9e40c..012bb237f671 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -23,6 +23,7 @@
 
 #include <linux/firmware.h>
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_vcn.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_cs.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 3c3f3d1a040d..b47acca452f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -25,6 +25,7 @@
 #include <drm/drm_drv.h>
 
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_vcn.h"
 #include "amdgpu_pm.h"
 #include "soc15.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index c8879a6e5297..f28b2bee0ca1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -23,6 +23,7 @@
 
 #include <linux/firmware.h>
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_vcn.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_cs.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 45580e9c4e0c..10edc2c251c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -23,6 +23,7 @@
 
 #include <linux/firmware.h>
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_vcn.h"
 #include "amdgpu_pm.h"
 #include "soc15.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 95f55bab528a..55104974c281 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -23,6 +23,7 @@
 
 #include <linux/firmware.h>
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_vcn.h"
 #include "amdgpu_pm.h"
 #include "soc15.h"
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 67a17458f4e9..6179469b82a6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -34,6 +34,7 @@
 #include "kfd_svm.h"
 #include "kfd_migrate.h"
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_xcp.h"
 
 #define MQD_SIZE_ALIGNED 768
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 12b57a0f4fc4..b6fc3f3ce716 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -25,6 +25,7 @@
 
 #include <linux/firmware.h>
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_smu.h"
 #include "smu_v13_0_12_pmfw.h"
 #include "smu_v13_0_6_ppt.h"
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ce520f43ab94..183077c9a14a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -25,6 +25,7 @@
 
 #include <linux/firmware.h>
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_smu.h"
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
index 2775c7bf41b7..1bb076e94c5d 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
@@ -29,6 +29,7 @@
 #include <linux/dev_printk.h>
 #include <linux/mempool.h>
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 
 /* inject address is 52 bits */
 #define RAS_UMC_INJECT_ADDR_LIMIT       (0x1ULL << 52)
@@ -94,15 +95,13 @@
 #define RAS_GET_INST(dev, ip, inst) \
 ({ \
 	struct amdgpu_device *adev = (struct amdgpu_device *)dev; \
-	adev->ip_map.logical_to_dev_inst ? \
-		adev->ip_map.logical_to_dev_inst(adev, ip##_HWIP, inst) : inst; \
+	amdgpu_ip_map_logical_to_dev_inst(&adev->ip_map, ip##_HWIP, inst); \
 })
 
 #define RAS_GET_MASK(dev, ip, mask) \
 ({ \
 	struct amdgpu_device *adev = (struct amdgpu_device *)dev; \
-	(adev->ip_map.logical_to_dev_mask ? \
-		adev->ip_map.logical_to_dev_mask(adev, ip##_HWIP, mask) : mask); \
+	amdgpu_ip_map_logical_to_dev_mask(&adev->ip_map, ip##_HWIP, mask); \
 })
 
 static inline void *ras_radix_tree_delete_iter(struct radix_tree_root *root, void *iter)
-- 
2.54.0

