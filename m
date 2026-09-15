Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C445C88E53
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 11:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD36E10FC0B;
	Tue, 15 Sep 2026 11:49:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="jzw9gLNr";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A364F10FC05
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 11:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=ZIJjzAAKyM2+qBL8lNlUid2AKBuHmWxZAXEQ+wvhqfM=; b=jzw9gLNrdk3bu5pEAJJ4W9JzNY
 kQrt9vKGtOMSRkuO6aUA5KFVmKwo7K1fBEotjMh5Lgacu4S6sd1WnBcS9OylGEijQD5yAeT3DUJNu
 Yc1va9o+W53gzRtB5fFdDVO8ASokRwviGUW5CoTvbg08n4iBrQkaoh5PT8HzL8496xLlgjd0EuIDV
 ebNMHlToNO3HU2Qg3KpuLDyE2wg2AZqeq4TRM137zZyknjb4HySNQR7tZ6f5BHz5lppNQDBawfTmk
 fmb+qRQjfm8Hv4IUhiNYmvNCUgkKIdADj55fSfpoTfUlNnz/08UPPaCaIuIPfOAnH7EPOIiCdLon9
 IDkfHhjg==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x6RfQ-002Q3D-U4; Tue, 15 Sep 2026 13:49:40 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH v4 5/6] drm/amdgpu: Extend logical to device instance lookup
 to all devices
Date: Tue, 15 Sep 2026 12:49:33 +0100
Message-ID: <20260915114934.60326-6-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915114934.60326-1-tvrtko.ursulin@igalia.com>
References: <20260915114934.60326-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
v2:
 * Move amdgpu_ip_map_aqua_vanjaram_override to aqua_vanjaram.c. (Alex)
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c        | 67 ++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h        | 20 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c    | 30 ++++++++-
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
 drivers/gpu/drm/amd/amdgpu/soc15_common.h     |  6 +-
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
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h     |  7 +-
 34 files changed, 92 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index bc079b95fc52..4626e0b13909 100644
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
index b30ad9701bce..38566dfea023 100644
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
index 0426118a9279..7af65416acc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -68,6 +68,7 @@
 #include "amdgpu_vf_error.h"
 
 #include "amdgpu_amdkfd.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_pm.h"
 
 #include "amdgpu_xgmi.h"
@@ -3850,6 +3851,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	spin_lock_init(&adev->irq.lock);
 
+	amdgpu_ip_map_init(adev);
 	amdgpu_early_init_rlc_reg_funcs(adev);
 	amdgpu_device_init_apu_flags(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
index a426327f2141..734f2a0bc79a 100644
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
@@ -64,35 +41,15 @@ static uint32_t amdgpu_logical_to_dev_mask(struct amdgpu_device *adev,
 	return dev_mask;
 }
 
-static void amdgpu_populate_ip_map(struct amdgpu_device *adev,
-				   enum amd_hw_ip_block_type ip_block,
-				   uint32_t inst_mask)
-{
-	int l = 0, i;
-
-	while (inst_mask) {
-		i = ffs(inst_mask) - 1;
-		adev->ip_map.dev_inst[ip_block][l++] = i;
-		inst_mask &= ~(1 << i);
-	}
-	for (; l < HWIP_MAX_INSTANCE; l++)
-		adev->ip_map.dev_inst[ip_block][l] = -1;
-}
-
 void amdgpu_ip_map_init(struct amdgpu_device *adev)
 {
-	u32 ip_map[][2] = {
-		{ GC_HWIP, adev->gfx.xcc_mask },
-		{ SDMA0_HWIP, adev->sdma.sdma_mask },
-		{ VCN_HWIP, adev->vcn.inst_mask },
-	};
-	int i;
+	int i, j;
 
-	for (i = 0; i < ARRAY_SIZE(ip_map); ++i)
-		amdgpu_populate_ip_map(adev, ip_map[i][0], ip_map[i][1]);
-
-	adev->ip_map.logical_to_dev_inst = amdgpu_logical_to_dev_inst;
-	adev->ip_map.logical_to_dev_mask = amdgpu_logical_to_dev_mask;
+	/* Assume 'logical instance == physical instance' unless overridden. */
+	for (i = 0; i < MAX_HWIP; i++) {
+		for (j = 0; j < HWIP_MAX_INSTANCE; j++)
+			adev->ip_map.dev_inst[i][j] = j;
+	}
 }
 
 int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
index 70fc4e5db51f..5dd6273982c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
@@ -90,13 +90,7 @@ struct amdgpu_fence;
 
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
@@ -125,6 +119,18 @@ struct amdgpu_ip_block {
 
 void amdgpu_ip_map_init(struct amdgpu_device *adev);
 
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
+
 int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block);
 int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 208566ffe898..9887a4f99aed 100644
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
index a676fccc466d..66eb2f34cc0d 100644
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
index c80ffa08920d..0c2e045dc397 100644
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
index 9a0c12b1a309..4bf3efbfe658 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -514,6 +514,34 @@ static int aqua_vanjaram_xcp_mgr_init(struct amdgpu_device *adev)
 	return ret;
 }
 
+static void amdgpu_populate_ip_map(struct amdgpu_device *adev,
+				   enum amd_hw_ip_block_type ip_block,
+				   uint32_t inst_mask)
+{
+	int l = 0, i;
+
+	while (inst_mask) {
+		i = ffs(inst_mask) - 1;
+		adev->ip_map.dev_inst[ip_block][l++] = i;
+		inst_mask &= ~(1 << i);
+	}
+	for (; l < HWIP_MAX_INSTANCE; l++)
+		adev->ip_map.dev_inst[ip_block][l] = -1;
+}
+
+static void amdgpu_ip_map_aqua_vanjaram_override(struct amdgpu_device *adev)
+{
+	u32 ip_map[][2] = {
+		{ GC_HWIP, adev->gfx.xcc_mask },
+		{ SDMA0_HWIP, adev->sdma.sdma_mask },
+		{ VCN_HWIP, adev->vcn.inst_mask },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ip_map); ++i)
+		amdgpu_populate_ip_map(adev, ip_map[i][0], ip_map[i][1]);
+}
+
 int aqua_vanjaram_init_soc_config(struct amdgpu_device *adev)
 {
 	u32 mask, avail_inst, inst_mask = adev->sdma.sdma_mask;
@@ -548,7 +576,7 @@ int aqua_vanjaram_init_soc_config(struct amdgpu_device *adev)
 	if (ret)
 		return ret;
 
-	amdgpu_ip_map_init(adev);
+	amdgpu_ip_map_aqua_vanjaram_override(adev);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index ce48da12edb2..484ecde55ac9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -23,6 +23,7 @@
 #include <linux/firmware.h>
 
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_gfx.h"
 #include "soc15.h"
 #include "soc15d.h"
@@ -1646,10 +1647,9 @@ static bool gfx_v9_4_3_check_rlcg_range(struct amdgpu_device *adev,
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
index 8397d3d38287..e89813590539 100644
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
index 9a8a7921ce98..490b4c4eb662 100644
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
index bee269a8877a..3cdc7893587a 100644
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
index 0cc73982ed6f..fcbaaca2dda5 100644
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
index 633772fa71fd..5245d8850a42 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -63,6 +63,7 @@
 
 #include "ivsrcid/vmc/irqsrcs_vmc_1_0.h"
 
+#include "amdgpu_ip.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 49f84e6647a5..0343a64595f2 100644
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
index 197d1af18a3a..4da3f9c995c1 100644
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
index 9b57fdc1e69a..dcdb089b4308 100644
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
index f67868132bed..f2debf6b6bd0 100644
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
index dd0fe773456b..332536454aee 100644
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
index 47e0329b6f3f..937d02ef7124 100644
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
index c559213e442c..7d2b9e4b913a 100644
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
index 732aaa1d8e67..10ef5616b2f5 100644
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
index e876733b754a..0f4f4d66e2e4 100644
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
index 60a5636c0073..4b7f7bbe18da 100644
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
index 3d28289bc4f1..2fa8f0d911d0 100644
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
index 660dab262dfb..f30f80c1b07f 100644
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
index 08fca20b2c99..7b7c3bc9f046 100644
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
index b3b83ad20103..09e553b8a657 100644
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
index 1c1e7878a2a7..351ca8718c87 100644
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
index 0033453f27e5..1ecf65d402ba 100644
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
index 19bc6ce29da0..ee380488d212 100644
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
index de3da5571ef8..1c5e02de7fca 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
@@ -31,6 +31,7 @@
 #include <linux/math64.h>
 #include <linux/time.h>
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 
 /* inject address is 52 bits */
 #define RAS_UMC_INJECT_ADDR_LIMIT       (0x1ULL << 52)
@@ -96,15 +97,13 @@
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
2.55.0

