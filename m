Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66044C3DA60
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 11:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE2310E666;
	Tue, 16 Jul 2024 11:19:59 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4907110E666
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 11:19:58 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 46GBJriJ932640; Tue, 16 Jul 2024 16:49:53 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 46GBJri5932639;
 Tue, 16 Jul 2024 16:49:53 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 4/5] drm/amdgpu: Add sdma_v5_0 ip dump for devcoredump
Date: Tue, 16 Jul 2024 16:49:39 +0530
Message-Id: <20240716111940.932516-5-sunil.khatri@amd.com>
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

Add ip dump for sdma_v5_0 for devcoredump for all
instances of sdma.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 82 ++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index b7d33d78bce0..cb324a90b310 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -59,6 +59,55 @@ MODULE_FIRMWARE("amdgpu/cyan_skillfish2_sdma1.bin");
 #define SDMA0_HYP_DEC_REG_END 0x5893
 #define SDMA1_HYP_DEC_REG_OFFSET 0x20
 
+static const struct amdgpu_hwip_reg_entry sdma_reg_list_5_0[] = {
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_STATUS_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_STATUS1_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_STATUS2_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_STATUS3_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_UCODE_CHECKSUM),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_RB_RPTR_FETCH_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_RB_RPTR_FETCH),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_UTCL1_RD_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_UTCL1_WR_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_UTCL1_RD_XNACK0),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_UTCL1_RD_XNACK1),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_UTCL1_WR_XNACK0),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_UTCL1_WR_XNACK1),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_GFX_RB_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_GFX_RB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_GFX_RB_RPTR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_GFX_RB_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_GFX_RB_WPTR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_GFX_IB_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_GFX_IB_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_GFX_IB_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_GFX_IB_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_GFX_IB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_GFX_IB_SUB_REMAIN),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_GFX_DUMMY_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_PAGE_RB_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_PAGE_RB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_PAGE_RB_RPTR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_PAGE_RB_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_PAGE_RB_WPTR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_PAGE_IB_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_PAGE_IB_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_PAGE_IB_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_PAGE_DUMMY_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_RLC0_RB_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_RLC0_RB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_RLC0_RB_RPTR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_RLC0_RB_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_RLC0_RB_WPTR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_RLC0_IB_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_RLC0_IB_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_RLC0_IB_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_RLC0_DUMMY_REG),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_INT_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_VM_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS2)
+};
+
 static void sdma_v5_0_set_ring_funcs(struct amdgpu_device *adev);
 static void sdma_v5_0_set_buffer_funcs(struct amdgpu_device *adev);
 static void sdma_v5_0_set_vm_pte_funcs(struct amdgpu_device *adev);
@@ -1341,6 +1390,8 @@ static int sdma_v5_0_sw_init(void *handle)
 	struct amdgpu_ring *ring;
 	int r, i;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_5_0);
+	uint32_t *ptr;
 
 	/* SDMA trap event */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_SDMA0,
@@ -1378,6 +1429,13 @@ static int sdma_v5_0_sw_init(void *handle)
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
 
@@ -1391,6 +1449,8 @@ static int sdma_v5_0_sw_fini(void *handle)
 
 	amdgpu_sdma_destroy_inst_ctx(adev, false);
 
+	kfree(adev->sdma.ip_dump);
+
 	return 0;
 }
 
@@ -1718,6 +1778,27 @@ static void sdma_v5_0_get_clockgating_state(void *handle, u64 *flags)
 		*flags |= AMD_CG_SUPPORT_SDMA_LS;
 }
 
+static void sdma_v5_0_dump_ip_state(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i, j;
+	uint32_t instance_offset;
+	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_5_0);
+
+	if (!adev->sdma.ip_dump)
+		return;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		instance_offset = i * reg_count;
+		for (j = 0; j < reg_count; j++)
+			adev->sdma.ip_dump[instance_offset + j] =
+				RREG32(sdma_v5_0_get_reg_offset(adev, i,
+				       sdma_reg_list_5_0[j].reg_offset));
+	}
+	amdgpu_gfx_off_ctrl(adev, true);
+}
+
 const struct amd_ip_funcs sdma_v5_0_ip_funcs = {
 	.name = "sdma_v5_0",
 	.early_init = sdma_v5_0_early_init,
@@ -1734,6 +1815,7 @@ const struct amd_ip_funcs sdma_v5_0_ip_funcs = {
 	.set_clockgating_state = sdma_v5_0_set_clockgating_state,
 	.set_powergating_state = sdma_v5_0_set_powergating_state,
 	.get_clockgating_state = sdma_v5_0_get_clockgating_state,
+	.dump_ip_state = sdma_v5_0_dump_ip_state,
 };
 
 static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
-- 
2.34.1

