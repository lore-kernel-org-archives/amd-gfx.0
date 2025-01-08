Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253E0C02181
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 14:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C22410EBC8;
	Wed,  8 Jan 2025 14:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RGhSykG0";
	dkim-atps=neutral
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 919BC10E8B7
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736344816; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=USd38oArDWmnL4u6hXj2RsQQSH3MAtLfbFn+t56+nmk=;
 b=RGhSykG07qYPuG1fZrvXzZMddpgpG53ybeAPKj3EIIZPSJu6PqkTmH12BN0/eZX4lRwl6rAjivCWRkTx4R8Xw6YQdQAF/Mt5jJAUpGmaj6ysj5/BWuemzEiaovC1iN+WZgwFoxaYqdveKsFeLvLeAv3mkvbhQw1OriUUeVInfBo=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNEHXFZ_1736344815 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 08 Jan 2025 22:00:15 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 Jun.Ma2@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC PATCH 11/13] drm/amdgpu/sdma: improve the way to manage irq
 reference count
Date: Wed,  8 Jan 2025 22:00:03 +0800
Message-ID: <11aead3d0e4d7e568f9533fd13395bd4d7959749.1736344725.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736344725.git.gerry@linux.alibaba.com>
References: <cover.1736344725.git.gerry@linux.alibaba.com>
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

Refactor sdma related code to improve the way to manage irq reference
count. Originally amdgpu_irq_get() is called from ip_blocks[].late_init
and amdgpu_irq_put is called from ip_blocks[].hw_fini. The asymmetric
design may cause issue under certain conditions. So
1) introduce amdgpu_sdma_ras_early_fini() to undo work done by
   amdgpu_sdma_ras_late_init().
2) remove call of amdgpu_irq_put in xxxx_hw_fini().
3) call amdgpu_irq_get() in function sdma_v4_4_2_xcp_resume() to keep
   irq reference count balanced. Currently sdma_v4_4_2_xcp_resume()
   doesn't invoke ip_blocks[].late_init(amdgpu_irq_get), but
   sdma_v4_4_2_xcp_suspend() invokes amdgpu_irq_put(), thus causes
   unbalanced irq reference count. Fix it by calling amdgpu_irq_get()
   in function sdma_v4_4_2_xcp_resume().

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 26 ++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  8 --------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 23 ++++++++++++---------
 5 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index fa19c5391d8c..ff5907f2c544 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -383,7 +383,7 @@ enum amdgpu_marker {
 	AMDGPU_MARKER_RAS_DEBUGFS	= 63,
 };
 
-#define AMDGPU_MARKER_INDEX_IRQ(idx)		(AMDGPU_MARKER_INDEX_IRQ0 + (idx))
+#define AMDGPU_MARKER_IRQ(idx)		(AMDGPU_MARKER_IRQ0 + (idx))
 
 struct amdgpu_ip_block_status {
 	bool valid;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 21938e858d55..799bcd9978da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -110,16 +110,35 @@ int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
 				AMDGPU_SDMA_IRQ_INSTANCE0 + i);
 			if (r)
 				goto late_fini;
+			amdgpu_ras_set_marker(adev, ras_block, AMDGPU_MARKER_IRQ(i));
 		}
 	}
 
 	return 0;
 
 late_fini:
-	amdgpu_ras_block_early_fini(adev, ras_block);
+	amdgpu_sdma_ras_early_fini(adev, ras_block);
 	return r;
 }
 
+void amdgpu_sdma_ras_early_fini(struct amdgpu_device *adev,
+				struct ras_common_if *ras_block)
+{
+	int i;
+
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+		for (i = 0; i < adev->sdma.num_instances; i++) {
+			if (amdgpu_ras_test_and_clear_marker(adev, ras_block,
+			    AMDGPU_MARKER_IRQ(i))) {
+				amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
+					       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+			}
+		}
+	}
+
+	amdgpu_ras_block_early_fini(adev, ras_block);
+}
+
 int amdgpu_sdma_process_ras_data_cb(struct amdgpu_device *adev,
 		void *err_data,
 		struct amdgpu_iv_entry *entry)
@@ -334,8 +353,11 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
 	adev->sdma.ras_if = &ras->ras_block.ras_comm;
 
 	/* If not define special ras_late_init function, use default ras_late_init */
-	if (!ras->ras_block.ras_late_init)
+	if (!ras->ras_block.ras_late_init) {
+		WARN_ON(ras->ras_block.ras_early_fini);
 		ras->ras_block.ras_late_init = amdgpu_sdma_ras_late_init;
+		ras->ras_block.ras_early_fini = amdgpu_sdma_ras_early_fini;
+	}
 
 	/* If not defined special ras_cb function, use default ras_cb */
 	if (!ras->ras_block.ras_cb)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 087ce0f6fa07..1915e6c9be63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -164,6 +164,8 @@ int amdgpu_sdma_get_index_from_ring(struct amdgpu_ring *ring, uint32_t *index);
 uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring, unsigned vmid);
 int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
 			      struct ras_common_if *ras_block);
+void amdgpu_sdma_ras_early_fini(struct amdgpu_device *adev,
+			        struct ras_common_if *ras_block);
 int amdgpu_sdma_process_ras_data_cb(struct amdgpu_device *adev,
 		void *err_data,
 		struct amdgpu_iv_entry *entry);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index ccf0d531776d..369d7094a3ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1968,18 +1968,10 @@ static int sdma_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int sdma_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
-		for (i = 0; i < adev->sdma.num_instances; i++) {
-			amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
-				       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
-		}
-	}
-
 	sdma_v4_0_ctx_switch_enable(adev, false);
 	sdma_v4_0_enable(adev, false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 9c7cea0890c9..744569bbc1e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1486,19 +1486,11 @@ static int sdma_v4_4_2_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	uint32_t inst_mask;
-	int i;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
 	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
-	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
-		for (i = 0; i < adev->sdma.num_instances; i++) {
-			amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
-				       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
-		}
-	}
-
 	sdma_v4_4_2_inst_ctx_switch_enable(adev, false, inst_mask);
 	sdma_v4_4_2_inst_enable(adev, false, inst_mask);
 
@@ -2153,14 +2145,24 @@ const struct amdgpu_ip_block_version sdma_v4_4_2_ip_block = {
 static int sdma_v4_4_2_xcp_resume(void *handle, uint32_t inst_mask)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int r;
+	uint32_t tmp_mask = inst_mask;
+	int r, i;
 
 	if (!amdgpu_sriov_vf(adev))
 		sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
 
 	r = sdma_v4_4_2_inst_start(adev, inst_mask);
+	if (r)
+		return r;
 
-	return r;
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+		for_each_inst(i, tmp_mask) {
+			amdgpu_irq_get(adev, &adev->sdma.ecc_irq,
+				       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+		}
+	}
+
+	return 0;
 }
 
 static int sdma_v4_4_2_xcp_suspend(void *handle, uint32_t inst_mask)
@@ -2366,6 +2368,7 @@ static struct amdgpu_sdma_ras sdma_v4_4_2_ras = {
 	.ras_block = {
 		.hw_ops = &sdma_v4_4_2_ras_hw_ops,
 		.ras_late_init = sdma_v4_4_2_ras_late_init,
+		.ras_early_fini = amdgpu_sdma_ras_early_fini,
 	},
 };
 
-- 
2.43.5

