Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AFDC388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 20:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 712FA20780
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 20:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712FA20780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C8DF89BF8;
	Tue, 10 Nov 2020 20:17:33 +0000 (UTC)
Received: from svt-ETHLX-2.amd.com (unknown [165.204.54.251])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8FC0D89BF8
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 20:17:31 +0000 (UTC)
Received: by svt-ETHLX-2.amd.com (Postfix, from userid 0)
 id B21921840153; Tue, 10 Nov 2020 15:17:30 -0500 (EST)
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Update VCN initizalization behvaior
Date: Tue, 10 Nov 2020 15:17:29 -0500
Message-Id: <20201110201729.20202-1-Bokun.Zhang@amd.com>
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

- Issue:
  In the original vcn3.0 code, it assumes that the VCN's
  init_status is always 1, even after the MMSCH
  updates the header.

  This is incorrect since by default, it should be set to 0,
  and MMSCH will update it to 1 if VCN is ready.

- Fix:
  We need to read back the table header after send it to MMSCH.
  After that, if a VCN instance is not ready (host disabled it),
  we needs to disable the ring buffer as well.

Change-Id: I2c5dc4344c5919044370dfe606bf5980a202c662

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 46 +++++++++++++++++++++------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 3970a0ccb6a5..c5e0a531caba 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -294,17 +294,19 @@ static int vcn_v3_0_hw_init(void *handle)
 				continue;
 
 			ring = &adev->vcn.inst[i].ring_dec;
-			ring->wptr = 0;
-			ring->wptr_old = 0;
-			vcn_v3_0_dec_ring_set_wptr(ring);
-			ring->sched.ready = true;
+			if (ring->sched.ready) {
+				ring->wptr = 0;
+				ring->wptr_old = 0;
+				vcn_v3_0_dec_ring_set_wptr(ring);
+			}
 
 			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
 				ring = &adev->vcn.inst[i].ring_enc[j];
-				ring->wptr = 0;
-				ring->wptr_old = 0;
-				vcn_v3_0_enc_ring_set_wptr(ring);
-				ring->sched.ready = true;
+				if (ring->sched.ready) {
+					ring->wptr = 0;
+					ring->wptr_old = 0;
+					vcn_v3_0_enc_ring_set_wptr(ring);
+				}
 			}
 		}
 	} else {
@@ -1230,6 +1232,8 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 	uint32_t table_size;
 	uint32_t size, size_dw;
 
+	bool is_vcn_ready;
+
 	struct mmsch_v3_0_cmd_direct_write
 		direct_wt = { {0} };
 	struct mmsch_v3_0_cmd_direct_read_modify_write
@@ -1367,7 +1371,7 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 		MMSCH_V3_0_INSERT_END();
 
 		/* refine header */
-		header.inst[i].init_status = 1;
+		header.inst[i].init_status = 0;
 		header.inst[i].table_offset = header.total_size;
 		header.inst[i].table_size = table_size;
 		header.total_size += table_size;
@@ -1425,6 +1429,30 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 		}
 	}
 
+	/* 6, check each VCN's init_status
+	 * if it remains as 0, then this VCN is not assigned to current VF
+	 * do not start ring for this VCN
+	 */
+	size = sizeof(struct mmsch_v3_0_init_header);
+	table_loc = (uint32_t *)table->cpu_addr;
+	memcpy(&header, (void *)table_loc, size);
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
+		is_vcn_ready = (header.inst[i].init_status == 1);
+		if (!is_vcn_ready)
+			DRM_INFO("VCN(%d) engine is disabled by hypervisor\n", i);
+
+		ring = &adev->vcn.inst[i].ring_dec;
+		ring->sched.ready = is_vcn_ready;
+		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+			ring = &adev->vcn.inst[i].ring_enc[j];
+			ring->sched.ready = is_vcn_ready;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
