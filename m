Return-Path: <SRS0=s2Nc=GI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B15C433E6
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 23:00:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A110F22E00
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 23:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A110F22E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 222C689F45;
	Tue,  5 Jan 2021 23:00:28 +0000 (UTC)
X-Greylist: delayed 354 seconds by postgrey-1.36 at gabe;
 Tue, 05 Jan 2021 23:00:26 UTC
Received: from svt-ETHLX-2.amd.com (unknown [165.204.54.251])
 by gabe.freedesktop.org (Postfix) with ESMTP id B50A489F2A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jan 2021 23:00:26 +0000 (UTC)
Received: by svt-ETHLX-2.amd.com (Postfix, from userid 0)
 id 3ABCF1840172; Tue,  5 Jan 2021 17:54:29 -0500 (EST)
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/amdgpu: Use IP discovery data to determine VCN
 enablement instead of MMSCH
Date: Tue,  5 Jan 2021 17:54:27 -0500
Message-Id: <20210105225427.19570-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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
Cc: Bokun Zhang <Bokun.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In the past, we use MMSCH to determine whether a VCN is enabled or not.
This is not reliable since after a FLR, MMSCH may report junk data.

It is better to use IP discovery data.

Change-Id: I8b6c32c34017b20dcaebffdaa78bb07178e9d03c
Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 73 +++++++++++++++++----------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index def583916294..02cac6e33219 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -27,6 +27,7 @@
 #include "amdgpu_pm.h"
 #include "soc15.h"
 #include "soc15d.h"
+#include "soc15_hw_ip.h"
 #include "vcn_v2_0.h"
 #include "mmsch_v3_0.h"
 
@@ -60,6 +61,17 @@ static int amdgpu_ucode_id_vcns[] = {
 	AMDGPU_UCODE_ID_VCN1
 };
 
+#define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
+#define VCN_BLOCK_DECODE_DISABLE_MASK 0x40
+#define VCN_BLOCK_QUEUE_DISABLE_MASK 0xC0
+
+enum vcn_ring_type {
+	VCN_ENCODE_RING,
+	VCN_DECODE_RING,
+	VCN_UNIFIED_RING,
+};
+
+static bool vcn_v3_0_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance);
 static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
 static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
@@ -311,18 +323,26 @@ static int vcn_v3_0_hw_init(void *handle)
 				continue;
 
 			ring = &adev->vcn.inst[i].ring_dec;
-			if (ring->sched.ready) {
+			if (vcn_v3_0_is_disabled_vcn(adev, VCN_DECODE_RING, i)) {
+				ring->sched.ready = false;
+				dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
+			} else {
 				ring->wptr = 0;
 				ring->wptr_old = 0;
 				vcn_v3_0_dec_ring_set_wptr(ring);
+				ring->sched.ready = true;
 			}
 
 			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
 				ring = &adev->vcn.inst[i].ring_enc[j];
-				if (ring->sched.ready) {
+				if (vcn_v3_0_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
+					ring->sched.ready = false;
+					dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
+				} else {
 					ring->wptr = 0;
 					ring->wptr_old = 0;
 					vcn_v3_0_enc_ring_set_wptr(ring);
+					ring->sched.ready = true;
 				}
 			}
 		}
@@ -1266,6 +1286,29 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 	return 0;
 }
 
+static bool vcn_v3_0_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance)
+{
+	bool ret = false;
+
+	int major;
+	int minor;
+	int revision;
+
+	/* if cannot find IP data, then this VCN does not exist */
+	if (amdgpu_discovery_get_ip_version(adev, VCN_HWID, vcn_instance, &major, &minor, &revision) != 0)
+		return true;
+
+	if ((type == VCN_ENCODE_RING) && (revision & VCN_BLOCK_ENCODE_DISABLE_MASK)) {
+		ret = true;
+	} else if ((type == VCN_DECODE_RING) && (revision & VCN_BLOCK_DECODE_DISABLE_MASK)) {
+		ret = true;
+	} else if ((type == VCN_UNIFIED_RING) && (revision & VCN_BLOCK_QUEUE_DISABLE_MASK)) {
+		ret = true;
+	}
+
+	return ret;
+}
+
 static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 {
 	int i, j;
@@ -1283,8 +1326,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 	uint32_t table_size;
 	uint32_t size, size_dw;
 
-	bool is_vcn_ready;
-
 	struct mmsch_v3_0_cmd_direct_write
 		direct_wt = { {0} };
 	struct mmsch_v3_0_cmd_direct_read_modify_write
@@ -1476,30 +1517,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 		}
 	}
 
-	/* 6, check each VCN's init_status
-	 * if it remains as 0, then this VCN is not assigned to current VF
-	 * do not start ring for this VCN
-	 */
-	size = sizeof(struct mmsch_v3_0_init_header);
-	table_loc = (uint32_t *)table->cpu_addr;
-	memcpy(&header, (void *)table_loc, size);
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-
-		is_vcn_ready = (header.inst[i].init_status == 1);
-		if (!is_vcn_ready)
-			DRM_INFO("VCN(%d) engine is disabled by hypervisor\n", i);
-
-		ring = &adev->vcn.inst[i].ring_dec;
-		ring->sched.ready = is_vcn_ready;
-		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
-			ring = &adev->vcn.inst[i].ring_enc[j];
-			ring->sched.ready = is_vcn_ready;
-		}
-	}
-
 	return 0;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
