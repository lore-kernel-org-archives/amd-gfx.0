Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4954EEB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 15:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E686910E27E;
	Mon, 17 Jul 2023 15:59:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E447110E27C
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 15:59:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3UPZpJwIeYDtMOGz/Zamd0SxjF23E6CD2arBtjI+d8m2TAKM06ZQUV+gUGx/43PTjLDGx1VC/uJTNaf8ISmN/vScE4OZGV1FLpU/+DgV8evepf9lA9sSnCf2tiuMJ8Vxoadwzvsb25rGtfjLCNFvGd0gdjRa0rSb8WzJlloj9GKRxeiV0cC0u+ndrMDoiLHxWL2ckN2aR9I+ydZ7jyd8JG8FyOS2vGwRMfQQ2Kd1jv3useWFG3Wc26aDUIqT2h95IHGQJL/kiOHbGMaI1RYDy2NCvbQQ3BSWUQT9XIa6JgfVBzS19Xyjbp7mUwvOdVJiEqEwc5RrBIuJxmSDT1COQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWjCON9ZhTH2o9RO5PWe3CVVYddLkG7fXRtSoaEhYxI=;
 b=mhrP/78er2XcX9ABcDeJPTsHWLheSZamS14R1KxZUErVHYTvlho2hGzeRvZeop60+/qcivq3IyR8URaMhOHCR2OhyVS9FA9Oid5ZPiU1/p2KrwfVVYtHQVgBeAvIVxzRCLY2YGaNIHc8U+RZVasRu/FvgiYnpfiVVa75FF+xDT+JMILgItMsudsxATPdFLGDXj0T/Xx26afAfDS8ZdGocHzI/2ktBLey/gO7xKae8Wbe24GIwCH5R3NHI5b+dJYgkz6eGhqPOuLUdLa2MVYAF4QnzRWnUVfk7YiT3Xqtp0KkEjB1BrDP8beAWRnmklUUv5Jj2IHklBzDbmdoJ6+1nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWjCON9ZhTH2o9RO5PWe3CVVYddLkG7fXRtSoaEhYxI=;
 b=vcY1pUHY0zbCfPURCXZNiB/d1IeZQCHdDXegaUk8BW25tlGhIY+Z4IPsklbYAigNEHMajSsRJXH7RRcPZq0cTR9vuJnDZ7NrTqHqpOFvlyYENYe4Zc4WjZ43HfhQiFWerM0OeGzQj3taXngSb6XnSz25uUlTWR0Jk8qkbRPr1Hg=
Received: from MW4PR04CA0138.namprd04.prod.outlook.com (2603:10b6:303:84::23)
 by SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Mon, 17 Jul
 2023 15:59:14 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::5) by MW4PR04CA0138.outlook.office365.com
 (2603:10b6:303:84::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 17 Jul 2023 15:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 15:59:14 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Jul 2023 10:59:13 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amdgpu/vcn: sriov support for vcn_v4_0_3
Date: Mon, 17 Jul 2023 11:58:37 -0400
Message-ID: <20230717155841.758516-3-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717155841.758516-1-samir.dhume@amd.com>
References: <20230717155841.758516-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT016:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f5080d-b1ce-4bc6-d477-08db86dec4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3N/tlrKS/s10SBbCWCXxFPXYJ3jyV9Aha3peLFn8Ld1fd3HH8p7zaG8BNqRnyIOIU5NgTQ3liHNm3c+Sjf/1Z9gJ+aWmvXsl6zVFpIh/nuAIyEjT5bNb4rs06FJ9SANs24YlcThiWcSbb7AobNK5DvBFu8ykSbDNBw0sa1ihkQhopnmd32Bq5UdZCR9awpuCGLrwn06gnRk2uru6pUdgOB5cSjtMYAjxiylrFLEqmR43ldTSFy9rh9KiXphoGodcgWyTLsyFgPWO9o+XxcBH23CUTEFqf2MGpxVmiMbvELma10q8biuvy1GHGrJlpyTEWewOxBuBN+TGFjV4HSFwhNXLt1DjF1thnAdArNCyzg6/15DjQTmeffnQaRDauaLel3upORNO9IUvQ6mgLmTjWjKqNzwYJ53JHz9ck1+vv1M9CMSPqoIFfhXFLwiNE0QHJqctOO0oOb9XKhWQrU+03jtp+Rk8zicqlnlmUSWbFiFSrTUFqMxZTqg8MsBOrBlmOAFBqZTCMuGSiwsgbV3Ug5+btt3AckOzBNVmktJiXsQSgTHp+JNzCnFuOibc9REfooqinlXi0NV8eZg2RAkigkTOr1s62x1vuk5zrSvwAS0mZrJhFmHjjO/rX1pyX8DFXXcBTK5IYkM4kGe/D5bqHeOs0nDMAWdy1Qt/5z30k89EL68+jZ6yL5NgFepRsST8BhE0Q/Wi9ADlzuMP5vTjvqiedNUKMWnWkjX8TwkqOXrOoy/UHu4lr82w5b2akB16
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(2906002)(7696005)(478600001)(41300700001)(8676002)(8936002)(36756003)(316002)(44832011)(6666004)(4326008)(6916009)(70206006)(70586007)(82740400003)(426003)(83380400001)(47076005)(81166007)(86362001)(356005)(336012)(2616005)(5660300002)(16526019)(40460700003)(26005)(40480700001)(36860700001)(1076003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:59:14.2632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f5080d-b1ce-4bc6-d477-08db86dec4b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212
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
Cc: Samir Dhume <samir.dhume@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

initialization table handshake with mmsch

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 264 +++++++++++++++++++++---
 1 file changed, 240 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 411c1d802823..ac405dfcfaf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -31,6 +31,7 @@
 #include "soc15d.h"
 #include "soc15_hw_ip.h"
 #include "vcn_v2_0.h"
+#include "mmsch_v4_0_3.h"
 
 #include "vcn/vcn_4_0_3_offset.h"
 #include "vcn/vcn_4_0_3_sh_mask.h"
@@ -44,6 +45,7 @@
 #define VCN_VID_SOC_ADDRESS_2_0		0x1fb00
 #define VCN1_VID_SOC_ADDRESS_3_0	0x48300
 
+static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v4_0_3_set_powergating_state(void *handle,
@@ -130,6 +132,12 @@ static int vcn_v4_0_3_sw_init(void *handle)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 	}
 
+	if (amdgpu_sriov_vf(adev)) {
+		r = amdgpu_virt_alloc_mm_table(adev);
+		if (r)
+			return r;
+	}
+
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		adev->vcn.pause_dpg_mode = vcn_v4_0_3_pause_dpg_mode;
 
@@ -167,6 +175,9 @@ static int vcn_v4_0_3_sw_fini(void *handle)
 		drm_dev_exit(idx);
 	}
 
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_virt_free_mm_table(adev);
+
 	r = amdgpu_vcn_suspend(adev);
 	if (r)
 		return r;
@@ -189,33 +200,50 @@ static int vcn_v4_0_3_hw_init(void *handle)
 	struct amdgpu_ring *ring;
 	int i, r, vcn_inst;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		vcn_inst = GET_INST(VCN, i);
-		ring = &adev->vcn.inst[i].ring_enc[0];
+	if (amdgpu_sriov_vf(adev)) {
+		r = vcn_v4_0_3_start_sriov(adev);
+		if (r)
+			goto done;
 
-		if (ring->use_doorbell) {
-			adev->nbio.funcs->vcn_doorbell_range(
-				adev, ring->use_doorbell,
-				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-					9 * vcn_inst,
-				adev->vcn.inst[i].aid_id);
-
-			WREG32_SOC15(
-				VCN, GET_INST(VCN, ring->me),
-				regVCN_RB1_DB_CTRL,
-				ring->doorbell_index
-						<< VCN_RB1_DB_CTRL__OFFSET__SHIFT |
-					VCN_RB1_DB_CTRL__EN_MASK);
-
-			/* Read DB_CTRL to flush the write DB_CTRL command. */
-			RREG32_SOC15(
-				VCN, GET_INST(VCN, ring->me),
-				regVCN_RB1_DB_CTRL);
+		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+			if (adev->vcn.harvest_config & (1 << i))
+				continue;
+
+			ring = &adev->vcn.inst[i].ring_enc[0];
+			ring->wptr = 0;
+			ring->wptr_old = 0;
+			vcn_v4_0_3_unified_ring_set_wptr(ring);
+			ring->sched.ready = true;
 		}
+	} else {
+		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+			vcn_inst = GET_INST(VCN, i);
+			ring = &adev->vcn.inst[i].ring_enc[0];
+
+			if (ring->use_doorbell) {
+				adev->nbio.funcs->vcn_doorbell_range(
+					adev, ring->use_doorbell,
+					(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+						9 * vcn_inst,
+					adev->vcn.inst[i].aid_id);
+
+				WREG32_SOC15(
+					VCN, GET_INST(VCN, ring->me),
+					regVCN_RB1_DB_CTRL,
+					ring->doorbell_index
+							<< VCN_RB1_DB_CTRL__OFFSET__SHIFT |
+						VCN_RB1_DB_CTRL__EN_MASK);
+
+				/* Read DB_CTRL to flush the write DB_CTRL command. */
+				RREG32_SOC15(
+					VCN, GET_INST(VCN, ring->me),
+					regVCN_RB1_DB_CTRL);
+			}
 
-		r = amdgpu_ring_test_helper(ring);
-		if (r)
-			goto done;
+			r = amdgpu_ring_test_helper(ring);
+			if (r)
+				goto done;
+		}
 	}
 
 done:
@@ -813,6 +841,194 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 	return 0;
 }
 
+static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
+{
+	int i;
+	struct amdgpu_ring *ring_enc;
+	uint64_t cache_addr;
+	uint64_t rb_enc_addr;
+	uint64_t ctx_addr;
+	uint32_t param, resp, expected;
+	uint32_t offset, cache_size;
+	uint32_t tmp, timeout;
+
+	struct amdgpu_mm_table *table = &adev->virt.mm_table;
+	uint32_t *table_loc;
+	uint32_t table_size;
+	uint32_t size, size_dw;
+	uint32_t init_status;
+	uint32_t enabled_vcn;
+
+	struct mmsch_v4_0_cmd_direct_write
+		direct_wt = { {0} };
+	struct mmsch_v4_0_cmd_direct_read_modify_write
+		direct_rd_mod_wt = { {0} };
+	struct mmsch_v4_0_cmd_end end = { {0} };
+	struct mmsch_v4_0_3_init_header header;
+
+	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+	volatile struct amdgpu_fw_shared_rb_setup *rb_setup;
+
+	direct_wt.cmd_header.command_type =
+		MMSCH_COMMAND__DIRECT_REG_WRITE;
+	direct_rd_mod_wt.cmd_header.command_type =
+		MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE;
+	end.cmd_header.command_type = MMSCH_COMMAND__END;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
+		memset(&header, 0, sizeof(struct mmsch_v4_0_3_init_header));
+		header.version = MMSCH_VERSION;
+		header.total_size = sizeof(struct mmsch_v4_0_3_init_header) >> 2;
+
+		table_loc = (uint32_t *)table->cpu_addr;
+		table_loc += header.total_size;
+
+		table_size = 0;
+
+		MMSCH_V4_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(VCN, 0, regUVD_STATUS),
+			~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
+
+		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+				regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo);
+
+			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+				regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi);
+
+			offset = 0;
+			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+				regUVD_VCPU_CACHE_OFFSET0), 0);
+		} else {
+			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+				regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				lower_32_bits(adev->vcn.inst[i].gpu_addr));
+			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+				regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				upper_32_bits(adev->vcn.inst[i].gpu_addr));
+			offset = cache_size;
+			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+				regUVD_VCPU_CACHE_OFFSET0),
+				AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
+		}
+
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_VCPU_CACHE_SIZE0),
+			cache_size);
+
+		cache_addr = adev->vcn.inst[i].gpu_addr + offset;
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), lower_32_bits(cache_addr));
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), upper_32_bits(cache_addr));
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_VCPU_CACHE_OFFSET1), 0);
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE);
+
+		cache_addr = adev->vcn.inst[i].gpu_addr + offset +
+			AMDGPU_VCN_STACK_SIZE;
+
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW), lower_32_bits(cache_addr));
+
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH), upper_32_bits(cache_addr));
+
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_VCPU_CACHE_OFFSET2), 0);
+
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE);
+
+		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+		rb_setup = &fw_shared->rb_setup;
+
+		ring_enc = &adev->vcn.inst[i].ring_enc[0];
+		ring_enc->wptr = 0;
+		rb_enc_addr = ring_enc->gpu_addr;
+
+		rb_setup->is_rb_enabled_flags |= RB_ENABLED;
+		rb_setup->rb_addr_lo = lower_32_bits(rb_enc_addr);
+		rb_setup->rb_addr_hi = upper_32_bits(rb_enc_addr);
+		rb_setup->rb_size = ring_enc->ring_size / 4;
+		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
+
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
+			lower_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
+			upper_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_VCPU_NONCACHE_SIZE0),
+			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared)));
+		MMSCH_V4_0_INSERT_END();
+
+		header.vcn0.init_status = 0;
+		header.vcn0.table_offset = header.total_size;
+		header.vcn0.table_size = table_size;
+		header.total_size += table_size;
+
+		/* Send init table to mmsch */
+		size = sizeof(struct mmsch_v4_0_3_init_header);
+		table_loc = (uint32_t *)table->cpu_addr;
+		memcpy((void *)table_loc, &header, size);
+
+		ctx_addr = table->gpu_addr;
+		WREG32_SOC15(VCN, i, regMMSCH_VF_CTX_ADDR_LO, lower_32_bits(ctx_addr));
+		WREG32_SOC15(VCN, i, regMMSCH_VF_CTX_ADDR_HI, upper_32_bits(ctx_addr));
+
+		tmp = RREG32_SOC15(VCN, i, regMMSCH_VF_VMID);
+		tmp &= ~MMSCH_VF_VMID__VF_CTX_VMID_MASK;
+		tmp |= (0 << MMSCH_VF_VMID__VF_CTX_VMID__SHIFT);
+		WREG32_SOC15(VCN, i, regMMSCH_VF_VMID, tmp);
+
+		size = header.total_size;
+		WREG32_SOC15(VCN, i, regMMSCH_VF_CTX_SIZE, size);
+
+		WREG32_SOC15(VCN, i, regMMSCH_VF_MAILBOX_RESP, 0);
+
+		param = 0x00000001;
+		WREG32_SOC15(VCN, i, regMMSCH_VF_MAILBOX_HOST, param);
+		tmp = 0;
+		timeout = 1000;
+		resp = 0;
+		expected = MMSCH_VF_MAILBOX_RESP__OK;
+		while (resp != expected) {
+			resp = RREG32_SOC15(VCN, i, regMMSCH_VF_MAILBOX_RESP);
+			if (resp != 0)
+				break;
+
+			udelay(10);
+			tmp = tmp + 10;
+			if (tmp >= timeout) {
+				DRM_ERROR("failed to init MMSCH. TIME-OUT after %d usec"\
+					" waiting for regMMSCH_VF_MAILBOX_RESP "\
+					"(expected=0x%08x, readback=0x%08x)\n",
+					tmp, expected, resp);
+				return -EBUSY;
+			}
+		}
+
+		enabled_vcn = amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, 0) ? 1 : 0;
+		init_status = ((struct mmsch_v4_0_3_init_header *)(table_loc))->vcn0.init_status;
+		if (resp != expected && resp != MMSCH_VF_MAILBOX_RESP__INCOMPLETE
+					&& init_status != MMSCH_VF_ENGINE_STATUS__PASS) {
+			DRM_ERROR("MMSCH init status is incorrect! readback=0x%08x, header init "\
+				"status for VCN%x: 0x%x\n", resp, enabled_vcn, init_status);
+		}
+	}
+
+	return 0;
+}
+
 /**
  * vcn_v4_0_3_start - VCN start
  *
-- 
2.34.1

