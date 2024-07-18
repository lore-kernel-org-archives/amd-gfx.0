Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35335C3DA64
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 04:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB8AF10E500;
	Thu, 18 Jul 2024 04:43:08 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C80B510E4F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 04:42:59 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 46I4gsgT1822100; Thu, 18 Jul 2024 10:12:54 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 46I4gstK1822099;
 Thu, 18 Jul 2024 10:12:54 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 1/6] drm/amdgpu: Add sdma_v7_0 ip dump for devcoredump
Date: Thu, 18 Jul 2024 10:12:45 +0530
Message-Id: <20240718044250.1822051-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718044250.1822051-1-sunil.khatri@amd.com>
References: <20240718044250.1822051-1-sunil.khatri@amd.com>
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

Add ip dump for sdma_v7_0 for devcoredump for all
instances of sdma.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 91 ++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 41b5e45697dc..327b5387949a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -51,6 +51,64 @@ MODULE_FIRMWARE("amdgpu/sdma_7_0_1.bin");
 #define SDMA0_HYP_DEC_REG_END 0x589a
 #define SDMA1_HYP_DEC_REG_OFFSET 0x20
 
+static const struct amdgpu_hwip_reg_entry sdma_reg_list_7_0[] = {
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_STATUS_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_STATUS1_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_STATUS2_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_STATUS3_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_STATUS4_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_STATUS5_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_STATUS6_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_UCODE_REV),
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
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_VM_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS2),
+	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_CHICKEN_BITS),
+};
+
 static void sdma_v7_0_set_ring_funcs(struct amdgpu_device *adev);
 static void sdma_v7_0_set_buffer_funcs(struct amdgpu_device *adev);
 static void sdma_v7_0_set_vm_pte_funcs(struct amdgpu_device *adev);
@@ -1217,6 +1275,8 @@ static int sdma_v7_0_sw_init(void *handle)
 	struct amdgpu_ring *ring;
 	int r, i;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_7_0);
+	uint32_t *ptr;
 
 	/* SDMA trap event */
 	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GFX,
@@ -1247,6 +1307,13 @@ static int sdma_v7_0_sw_init(void *handle)
 			return r;
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
 
@@ -1263,6 +1330,8 @@ static int sdma_v7_0_sw_fini(void *handle)
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)
 		sdma_v12_0_free_ucode_buffer(adev);
 
+	kfree(adev->sdma.ip_dump);
+
 	return 0;
 }
 
@@ -1466,6 +1535,27 @@ static void sdma_v7_0_get_clockgating_state(void *handle, u64 *flags)
 {
 }
 
+static void sdma_v7_0_dump_ip_state(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i, j;
+	uint32_t instance_offset;
+	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_7_0);
+
+	if (!adev->sdma.ip_dump)
+		return;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		instance_offset = i * reg_count;
+		for (j = 0; j < reg_count; j++)
+			adev->sdma.ip_dump[instance_offset + j] =
+				RREG32(sdma_v7_0_get_reg_offset(adev, i,
+				       sdma_reg_list_7_0[j].reg_offset));
+	}
+	amdgpu_gfx_off_ctrl(adev, true);
+}
+
 const struct amd_ip_funcs sdma_v7_0_ip_funcs = {
 	.name = "sdma_v7_0",
 	.early_init = sdma_v7_0_early_init,
@@ -1483,6 +1573,7 @@ const struct amd_ip_funcs sdma_v7_0_ip_funcs = {
 	.set_clockgating_state = sdma_v7_0_set_clockgating_state,
 	.set_powergating_state = sdma_v7_0_set_powergating_state,
 	.get_clockgating_state = sdma_v7_0_get_clockgating_state,
+	.dump_ip_state = sdma_v7_0_dump_ip_state,
 };
 
 static const struct amdgpu_ring_funcs sdma_v7_0_ring_funcs = {
-- 
2.34.1

