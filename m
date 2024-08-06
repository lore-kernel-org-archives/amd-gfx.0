Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585D7C52D74
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 08:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FA2E10E317;
	Tue,  6 Aug 2024 08:18:40 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD53D10E318
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 08:18:36 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 4768IWMh2422891; Tue, 6 Aug 2024 13:48:32 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 4768IWI12422890;
 Tue, 6 Aug 2024 13:48:32 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 11/15] drm/amdgpu: add vcn_v2_0 ip dump support
Date: Tue,  6 Aug 2024 13:48:21 +0530
Message-Id: <20240806081825.2422771-12-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806081825.2422771-1-sunil.khatri@amd.com>
References: <20240806081825.2422771-1-sunil.khatri@amd.com>
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

Add support of vcn ip dump in the devcoredump
for vcn_v2_0.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 111 +++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index d3d096909a7f..062651f87aa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -53,6 +53,74 @@
 #define mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET		0x5a7
 #define mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET			0x1e2
 
+static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_0[] = {
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_POWER_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_CONTEXT_ID),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_GPCOM_VCPU_DATA0),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_GPCOM_VCPU_DATA1),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_GPCOM_VCPU_CMD),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_NC1_64BIT_BAR_HIGH),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_NC1_64BIT_BAR_LOW),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_RBC_IB_VMID),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE_VMIDS_MULTI),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_NC_VMIDS_MULTI),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_HI),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_LO),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_HI2),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_LO2),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_HI3),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_LO3),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_RPTR2),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_WPTR2),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_RPTR3),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_WPTR3),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_SIZE),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_SIZE2),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_SIZE3),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_PGFSM_CONFIG),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_PGFSM_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SOFT_RESET),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SOFT_RESET2),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_CGC_GATE),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_CGC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_CGC_CTRL),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SUVD_CGC_GATE),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SUVD_CGC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SUVD_CGC_CTRL),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_LO4),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_HI4),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_SIZE4),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_RPTR4),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_WPTR4),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_VCPU_CACHE_OFFSET2),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE3_64BIT_BAR_LOW),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE3_64BIT_BAR_HIGH),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE4_64BIT_BAR_LOW),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE4_64BIT_BAR_HIGH),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE5_64BIT_BAR_LOW),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE5_64BIT_BAR_HIGH),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE6_64BIT_BAR_LOW),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE6_64BIT_BAR_HIGH),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE7_64BIT_BAR_LOW),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE7_64BIT_BAR_HIGH),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SCRATCH1)
+};
+
+
 static void vcn_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_0_set_irq_funcs(struct amdgpu_device *adev);
@@ -96,6 +164,8 @@ static int vcn_v2_0_sw_init(void *handle)
 {
 	struct amdgpu_ring *ring;
 	int i, r;
+	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
+	uint32_t *ptr;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	volatile struct amdgpu_fw_shared *fw_shared;
 
@@ -184,6 +254,15 @@ static int vcn_v2_0_sw_init(void *handle)
 	if (amdgpu_vcnfw_log)
 		amdgpu_vcn_fwlog_init(adev->vcn.inst);
 
+	/* Allocate memory for VCN IP Dump buffer */
+	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
+	if (ptr == NULL) {
+		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
+		adev->vcn.ip_dump = NULL;
+	} else {
+		adev->vcn.ip_dump = ptr;
+	}
+
 	return 0;
 }
 
@@ -213,6 +292,8 @@ static int vcn_v2_0_sw_fini(void *handle)
 
 	r = amdgpu_vcn_sw_fini(adev);
 
+	kfree(adev->vcn.ip_dump);
+
 	return r;
 }
 
@@ -1985,6 +2066,34 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev)
 	return vcn_v2_0_start_mmsch(adev, &adev->virt.mm_table);
 }
 
+static void vcn_v2_0_dump_ip_state(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i, j;
+	bool is_powered;
+	uint32_t inst_off;
+	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
+
+	if (!adev->vcn.ip_dump)
+		return;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
+		inst_off = i * reg_count;
+		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
+		is_powered = (adev->vcn.ip_dump[inst_off] &
+				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+
+		if (is_powered)
+			for (j = 1; j < reg_count; j++)
+				adev->vcn.ip_dump[inst_off + j] =
+					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_0[j], i));
+	}
+}
+
 static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
 	.name = "vcn_v2_0",
 	.early_init = vcn_v2_0_early_init,
@@ -2003,7 +2112,7 @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
 	.post_soft_reset = NULL,
 	.set_clockgating_state = vcn_v2_0_set_clockgating_state,
 	.set_powergating_state = vcn_v2_0_set_powergating_state,
-	.dump_ip_state = NULL,
+	.dump_ip_state = vcn_v2_0_dump_ip_state,
 	.print_ip_state = NULL,
 };
 
-- 
2.34.1

