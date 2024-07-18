Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDECC3DA60
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 04:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6B7D10E501;
	Thu, 18 Jul 2024 04:43:14 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B398810E0AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 04:42:59 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 46I4gsoM1822110; Thu, 18 Jul 2024 10:12:54 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 46I4gsPn1822109;
 Thu, 18 Jul 2024 10:12:54 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 3/6] drm/amdgpu: Add sdma_v4_0 ip dump for devcoredump
Date: Thu, 18 Jul 2024 10:12:47 +0530
Message-Id: <20240718044250.1822051-4-sunil.khatri@amd.com>
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

Add ip dump for sdma_v4_0 for devcoredump for all
instances of sdma.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 80 ++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 772604feb6ac..f39d3d94ba9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -72,6 +72,53 @@ MODULE_FIRMWARE("amdgpu/renoir_sdma.bin");
 MODULE_FIRMWARE("amdgpu/green_sardine_sdma.bin");
 MODULE_FIRMWARE("amdgpu/aldebaran_sdma.bin");
 
+static const struct amdgpu_hwip_reg_entry sdma_reg_list_4_0[] = {
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
+	SOC15_REG_ENTRY_STR(GC, 0, mmSDMA0_VM_CNTL)
+};
+
 #define SDMA0_POWER_CNTL__ON_OFF_CONDITION_HOLD_TIME_MASK  0x000000F8L
 #define SDMA0_POWER_CNTL__ON_OFF_STATUS_DURATION_TIME_MASK 0xFC000000L
 
@@ -1750,6 +1797,8 @@ static int sdma_v4_0_sw_init(void *handle)
 	struct amdgpu_ring *ring;
 	int r, i;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_4_0);
+	uint32_t *ptr;
 
 	/* SDMA trap event */
 	for (i = 0; i < adev->sdma.num_instances; i++) {
@@ -1870,6 +1919,13 @@ static int sdma_v4_0_sw_init(void *handle)
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
 
@@ -1890,6 +1946,8 @@ static int sdma_v4_0_sw_fini(void *handle)
 	else
 		amdgpu_sdma_destroy_inst_ctx(adev, false);
 
+	kfree(adev->sdma.ip_dump);
+
 	return 0;
 }
 
@@ -2292,6 +2350,27 @@ static void sdma_v4_0_get_clockgating_state(void *handle, u64 *flags)
 		*flags |= AMD_CG_SUPPORT_SDMA_LS;
 }
 
+static void sdma_v4_0_dump_ip_state(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i, j;
+	uint32_t instance_offset;
+	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_4_0);
+
+	if (!adev->sdma.ip_dump)
+		return;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		instance_offset = i * reg_count;
+		for (j = 0; j < reg_count; j++)
+			adev->sdma.ip_dump[instance_offset + j] =
+				RREG32(sdma_v4_0_get_reg_offset(adev, i,
+				       sdma_reg_list_4_0[j].reg_offset));
+	}
+	amdgpu_gfx_off_ctrl(adev, true);
+}
+
 const struct amd_ip_funcs sdma_v4_0_ip_funcs = {
 	.name = "sdma_v4_0",
 	.early_init = sdma_v4_0_early_init,
@@ -2308,6 +2387,7 @@ const struct amd_ip_funcs sdma_v4_0_ip_funcs = {
 	.set_clockgating_state = sdma_v4_0_set_clockgating_state,
 	.set_powergating_state = sdma_v4_0_set_powergating_state,
 	.get_clockgating_state = sdma_v4_0_get_clockgating_state,
+	.dump_ip_state = sdma_v4_0_dump_ip_state,
 };
 
 static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs = {
-- 
2.34.1

