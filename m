Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119D6CCFA0E
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 14:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5207F10E5F2;
	Tue,  4 Nov 2025 14:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="f+VHNxQq";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B06110E5E9
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 14:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=w3qDiHCAytWSM9DtUeVHCZ63VHOaZsTwPDQ2cIIc8YM=; b=f+VHNxQqBdOgSJISAcGQwY0zXY
 dPq6Uizsy2Vydwc0vv7nDpu87xaKF1FWsz0D8E0GlUsYOGA0eP+dcA5CWrhfSvGkB9pHjaSbSMWje
 galVnwGm6i+QjwWVEzd4OLZQlOM3sCCO2myiVxV+Bv0SmNsBgVoJap+u2gmKhB6OoEO9IcmL+oGLK
 fKCDEnMqjjuhgLHRxi8dAROIw5crx5yy8PYtkES/iJ5Ml/9y9BgyDlAyDMmxv+ptCIqCQcj+Vv0ng
 GxOqViRQfPo6isxnKKyJ5tgmAO33f+KKSA1bdiSMqM9M6I34Z1aMxnMMPNBAp61FCvehufogi40Y0
 Y3k34mdA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vGHg9-001OEc-KB; Tue, 04 Nov 2025 15:06:33 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 05/25] drm/amdgpu: Extend logical to device instance lookup to
 all devices
Date: Tue,  4 Nov 2025 14:04:01 +0000
Message-ID: <20251104140421.88520-6-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20251104140421.88520-1-tvrtko.ursulin@igalia.com>
References: <20251104140421.88520-1-tvrtko.ursulin@igalia.com>
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

add/remove: 13/11 grow/shrink: 12/178 up/down: 49091/-148553 (-99462)
...
Total: Before=9078695, After=8979233, chg -1.10%

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  8 +--
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c        | 49 +++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h        | 15 ++++++
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
 35 files changed, 72 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 50079209c472..d93005a29d4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -813,13 +813,7 @@ enum amd_hw_ip_block_type {
 
 struct amdgpu_ip_map_info {
 	/* Map of logical to actual dev instances/mask */
-	uint32_t 		dev_inst[MAX_HWIP][HWIP_MAX_INSTANCE];
-	int8_t (*logical_to_dev_inst)(struct amdgpu_device *adev,
-				      enum amd_hw_ip_block_type block,
-				      int8_t inst);
-	uint32_t (*logical_to_dev_mask)(struct amdgpu_device *adev,
-					enum amd_hw_ip_block_type block,
-					uint32_t mask);
+	unsigned int dev_inst[MAX_HWIP][HWIP_MAX_INSTANCE];
 };
 
 enum amdgpu_uid_type {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 89a45a9218f3..cdc9eaa29af6 100644
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
index 2b31a47617d1..1bc67723cec0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -67,6 +67,7 @@
 #include "amdgpu_vf_error.h"
 
 #include "amdgpu_amdkfd.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_pm.h"
 
 #include "amdgpu_xgmi.h"
@@ -4558,6 +4559,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->gfx.workload_profile_mutex);
 	mutex_init(&adev->vcn.workload_profile_mutex);
 
+	amdgpu_ip_map_init(adev);
 	amdgpu_early_init_rlc_reg_funcs(adev);
 	amdgpu_device_init_apu_flags(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
index 99e1cf4fc955..4b82aee1e52d 100644
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
@@ -90,7 +78,4 @@ void amdgpu_ip_map_init(struct amdgpu_device *adev)
 
 	for (i = 0; i < ARRAY_SIZE(ip_map); ++i)
 		amdgpu_populate_ip_map(adev, ip_map[i][0], ip_map[i][1]);
-
-	adev->ip_map.logical_to_dev_inst = amdgpu_logical_to_dev_inst;
-	adev->ip_map.logical_to_dev_mask = amdgpu_logical_to_dev_mask;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
index 2490fd322aec..21f8cf6c09f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
@@ -24,6 +24,21 @@
 #ifndef __AMDGPU_IP_H__
 #define __AMDGPU_IP_H__
 
+#include "amdgpu.h"
+
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
 
 #endif /* __AMDGPU_IP_H__ */
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
index 8c0e5d03de50..f809a96d9853 100644
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
index 1083db8cea2e..079374370eef 100644
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
index 811124ff88a8..92746a50f6c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -566,7 +566,7 @@ int aqua_vanjaram_init_soc_config(struct amdgpu_device *adev)
 	if (ret)
 		return ret;
 
-	amdgpu_ip_map_init(adev);
+	amdgpu_ip_map_aqua_vanjaram_override(adev);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 48ed96ec7296..b839145764df 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -23,6 +23,7 @@
 #include <linux/firmware.h>
 
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 #include "amdgpu_gfx.h"
 #include "soc15.h"
 #include "soc15d.h"
@@ -1705,10 +1706,9 @@ static bool gfx_v9_4_3_check_rlcg_range(struct amdgpu_device *adev,
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
index 6c03bf9f1ae8..826a3cca5d23 100644
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
index d7499be8c4bf..e8daa7276455 100644
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
index 7bc389d9f5c4..04e352c885d9 100644
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
index cad2d19105c4..af19b939f13a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -27,6 +27,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_atomfirmware.h"
+#include "amdgpu_ip.h"
 #include "gmc_v12_0.h"
 #include "athub/athub_4_1_0_sh_mask.h"
 #include "athub/athub_4_1_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e716097dfde4..bcf624bfa135 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -62,6 +62,7 @@
 
 #include "ivsrcid/vmc/irqsrcs_vmc_1_0.h"
 
+#include "amdgpu_ip.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index aae7328973d1..f8d7b988d445 100644
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
index 54fd9c800c40..693a2399c02d 100644
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
index 46bf15dce2bd..83eaecff2f99 100644
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
index baf097d2e1ac..3b284d97d0f0 100644
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
index 36b1ca73c2ed..2aa402c6041f 100644
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
index 5ee5867fe794..2b8e934769f2 100644
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
index 8897dcc9c1a0..850aa5fb4e13 100644
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
index cebee453871c..96a5a1852176 100644
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
index d9cf8f0feeb3..3ee79a44ee40 100644
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
index 3ae666522d57..0dcf3666654b 100644
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
index 627ee85e879f..2aef4b514996 100644
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
index b107ee80e472..da958d8ba135 100644
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
index 0202df5db1e1..78b3fdc46211 100644
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
index 714350cabf2f..1bbdb337f0c1 100644
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
index e9cfb80bd436..08ce3113f3c4 100644
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
index cb3fea9e8cf3..a87ef3dfe9d6 100644
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
index 0a7d2cea7dc6..9b3fee29b30e 100644
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
index 8156531a7b63..be314de2f753 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
@@ -29,6 +29,7 @@
 #include <linux/dev_printk.h>
 #include <linux/mempool.h>
 #include "amdgpu.h"
+#include "amdgpu_ip.h"
 
 #define RAS_DEV_ERR(device, fmt, ...)                                               \
 	do {                                                                      \
@@ -82,15 +83,13 @@
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
2.48.0

