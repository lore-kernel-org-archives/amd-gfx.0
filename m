Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96BBC07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 21:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A926D61152
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 21:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A926D61152
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA8B6E12E;
	Tue, 13 Jul 2021 21:01:36 +0000 (UTC)
Received: from svt-ETHLX-2.amd.com (unknown [165.204.54.251])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1A1C76E12E
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 21:01:35 +0000 (UTC)
Received: by svt-ETHLX-2.amd.com (Postfix, from userid 0)
 id C416118402AF; Tue, 13 Jul 2021 17:01:34 -0400 (EDT)
From: Bokun Zhang <bokun.zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Rewrite the code for single VCN enablemebt
Date: Tue, 13 Jul 2021 17:01:33 -0400
Message-Id: <20210713210133.39216-1-bokun.zhang@amd.com>
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
Cc: Bokun Zhang <bokun.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After reviewing the code, seem like there is a merge issue
and the logic of the code does not make any sense anymore

The code has been rewritten for single VCN enablement

Change-Id: I2c3d0bf6d7d446e2a014c83ee535b3c4bf20abf9
Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 23 -----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 ---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 33 +++++++++++++++----------
 3 files changed, 20 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 84b025405578..9492b505e69b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -287,29 +287,6 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 	return 0;
 }
 
-bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance)
-{
-	bool ret = false;
-
-	int major;
-	int minor;
-	int revision;
-
-	/* if cannot find IP data, then this VCN does not exist */
-	if (amdgpu_discovery_get_vcn_version(adev, vcn_instance, &major, &minor, &revision) != 0)
-		return true;
-
-	if ((type == VCN_ENCODE_RING) && (revision & VCN_BLOCK_ENCODE_DISABLE_MASK)) {
-		ret = true;
-	} else if ((type == VCN_DECODE_RING) && (revision & VCN_BLOCK_DECODE_DISABLE_MASK)) {
-		ret = true;
-	} else if ((type == VCN_UNIFIED_RING) && (revision & VCN_BLOCK_QUEUE_DISABLE_MASK)) {
-		ret = true;
-	}
-
-	return ret;
-}
-
 int amdgpu_vcn_suspend(struct amdgpu_device *adev)
 {
 	unsigned size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index d74c62b49795..7b168f2c1ac3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -297,9 +297,6 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev);
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
 
-bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev,
-				enum vcn_ring_type type, uint32_t vcn_instance);
-
 int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring);
 int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index c3580de3ea9c..7507d32a340a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -88,9 +88,7 @@ static int vcn_v3_0_early_init(void *handle)
 	int i;
 
 	if (amdgpu_sriov_vf(adev)) {
-		for (i = 0; i < VCN_INSTANCES_SIENNA_CICHLID; i++)
-			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i))
-				adev->vcn.num_vcn_inst++;
+		adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
 		adev->vcn.harvest_config = 0;
 		adev->vcn.num_enc_rings = 1;
 
@@ -151,8 +149,7 @@ static int vcn_v3_0_sw_init(void *handle)
 		adev->firmware.fw_size +=
 			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
 
-		if ((adev->vcn.num_vcn_inst == VCN_INSTANCES_SIENNA_CICHLID) ||
-		    (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)) {
+		if (adev->vcn.num_vcn_inst == VCN_INSTANCES_SIENNA_CICHLID) {
 			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id = AMDGPU_UCODE_ID_VCN1;
 			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw = adev->vcn.fw;
 			adev->firmware.fw_size +=
@@ -322,18 +319,28 @@ static int vcn_v3_0_hw_init(void *handle)
 				continue;
 
 			ring = &adev->vcn.inst[i].ring_dec;
-			ring->wptr = 0;
-			ring->wptr_old = 0;
-			vcn_v3_0_dec_ring_set_wptr(ring);
-			ring->sched.ready = true;
-
-			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
-				ring = &adev->vcn.inst[i].ring_enc[j];
+			if (vcn_v3_0_is_disabled_vcn(adev, VCN_DECODE_RING, i)) {
+				ring->sched.ready = false;
+				dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
+			} else {
 				ring->wptr = 0;
 				ring->wptr_old = 0;
-				vcn_v3_0_enc_ring_set_wptr(ring);
+				vcn_v3_0_dec_ring_set_wptr(ring);
 				ring->sched.ready = true;
 			}
+
+			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+				ring = &adev->vcn.inst[i].ring_enc[j];
+				if (vcn_v3_0_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
+					ring->sched.ready = false;
+					dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
+				} else {
+					ring->wptr = 0;
+					ring->wptr_old = 0;
+					vcn_v3_0_enc_ring_set_wptr(ring);
+					ring->sched.ready = true;
+				}
+			}
 		}
 	} else {
 		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
