Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54894C3DA59
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 11:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E27CA10E667;
	Tue, 16 Jul 2024 11:19:57 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB9A910E666
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 11:19:55 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 46GBJp54932607; Tue, 16 Jul 2024 16:49:51 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 46GBJplO932606;
 Tue, 16 Jul 2024 16:49:51 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 1/5] drm/amdgpu: Add sdma_v6_0 ip dump for devcoredump
Date: Tue, 16 Jul 2024 16:49:36 +0530
Message-Id: <20240716111940.932516-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716111940.932516-1-sunil.khatri@amd.com>
References: <20240716111940.932516-1-sunil.khatri@amd.com>
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

Add ip dump for sdma_v6_0 for devcoredump for all
instances of sdma.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 90 ++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index dab4c2db8c9d..102de209f120 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -57,6 +57,63 @@ MODULE_FIRMWARE("amdgpu/sdma_6_1_2.bin");
 #define SDMA0_HYP_DEC_REG_END 0x589a
 #define SDMA1_HYP_DEC_REG_OFFSET 0x20
 
+static const struct amdgpu_hwip_reg_entry sdma_reg_list_6_0[] = {
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_STATUS_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_STATUS1_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_STATUS2_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_STATUS3_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_STATUS4_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_STATUS5_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_STATUS6_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_UCODE_CHECKSUM),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_RB_RPTR_FETCH_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_RB_RPTR_FETCH),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_UTCL1_RD_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_UTCL1_WR_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_UTCL1_RD_XNACK0),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_UTCL1_RD_XNACK1),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_UTCL1_WR_XNACK0),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_UTCL1_WR_XNACK1),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE0_RB_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE0_RB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE0_RB_RPTR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE0_RB_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE0_RB_WPTR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE0_IB_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE0_IB_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE0_IB_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE0_IB_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE0_IB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE0_IB_SUB_REMAIN),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE0_DUMMY_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE_STATUS0),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE1_RB_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE1_RB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE1_RB_RPTR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE1_RB_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE1_RB_WPTR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE1_IB_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE1_IB_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE1_IB_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE1_IB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE1_IB_SUB_REMAIN),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE1_DUMMY_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE2_RB_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE2_RB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE2_RB_RPTR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE2_RB_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE2_RB_WPTR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE2_IB_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE2_IB_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE2_IB_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE2_IB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE2_IB_SUB_REMAIN),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_QUEUE2_DUMMY_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_INT_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS2),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_CHICKEN_BITS),
+};
+
 static void sdma_v6_0_set_ring_funcs(struct amdgpu_device *adev);
 static void sdma_v6_0_set_buffer_funcs(struct amdgpu_device *adev);
 static void sdma_v6_0_set_vm_pte_funcs(struct amdgpu_device *adev);
@@ -1239,6 +1296,8 @@ static int sdma_v6_0_sw_init(void *handle)
 	struct amdgpu_ring *ring;
 	int r, i;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_6_0);
+	uint32_t *ptr;
 
 	/* SDMA trap event */
 	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GFX,
@@ -1274,6 +1333,13 @@ static int sdma_v6_0_sw_init(void *handle)
 		return -EINVAL;
 	}
 
+	/* Allocate memory for SDMA IP Dump buffer */
+	ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
+	if (ptr)
+		adev->sdma.ip_dump = ptr;
+	else
+		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
+
 	return r;
 }
 
@@ -1287,6 +1353,8 @@ static int sdma_v6_0_sw_fini(void *handle)
 
 	amdgpu_sdma_destroy_inst_ctx(adev, true);
 
+	kfree(adev->sdma.ip_dump);
+
 	return 0;
 }
 
@@ -1488,6 +1556,27 @@ static void sdma_v6_0_get_clockgating_state(void *handle, u64 *flags)
 {
 }
 
+static void sdma_v6_0_dump_ip_state(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i, j;
+	uint32_t instance_offset;
+	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_6_0);
+
+	if (!adev->sdma.ip_dump)
+		return;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		instance_offset = i * reg_count;
+		for (j = 0; j < reg_count; j++)
+			adev->sdma.ip_dump[instance_offset + j] =
+				RREG32(sdma_v6_0_get_reg_offset(adev, i,
+				       sdma_reg_list_6_0[j].reg_offset));
+	}
+	amdgpu_gfx_off_ctrl(adev, true);
+}
+
 const struct amd_ip_funcs sdma_v6_0_ip_funcs = {
 	.name = "sdma_v6_0",
 	.early_init = sdma_v6_0_early_init,
@@ -1505,6 +1594,7 @@ const struct amd_ip_funcs sdma_v6_0_ip_funcs = {
 	.set_clockgating_state = sdma_v6_0_set_clockgating_state,
 	.set_powergating_state = sdma_v6_0_set_powergating_state,
 	.get_clockgating_state = sdma_v6_0_get_clockgating_state,
+	.dump_ip_state = sdma_v6_0_dump_ip_state,
 };
 
 static const struct amdgpu_ring_funcs sdma_v6_0_ring_funcs = {
-- 
2.34.1

