Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB01C001DB
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 16:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE54310E1FB;
	Tue,  8 Aug 2023 16:27:07 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F251810E1DA
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 16:27:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gV9oGGJ9EVnVnkjZbNglUjAvMTTsu/KgY0j+FHD6kWV/PLKf2Zn9Mci3ZAuMjiFO5owxuJNJFDxg/H4xxhr/Dv92fZRBqkz/LTxBlJTwO/H/DtielnfYeG9Drp7DI0ZCfcT/k7Xz+LkPu5fX+dEC1gtO7RbA5AhqVi8Vd42iobSMlmSUEK6j7oPISnUAOvJAX0RHRqRJzr6rIJdm5t+8GbeyB74u6hKRaKdkcoam+xvYB8xh5WkjtL0RfXZKTS/queQBDGmdjDkjnk+CAywr+AujdmhROzZlUoJUNDYKyq5SfOEBish+FKtjAnI/XDiBF4Q6F6Y9VXbNyYKOmkhzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ai1rkdB4+Tu28J2rae5XaDMcJaqsEhiRCg090YI0oyU=;
 b=hf0pyxV4ibo9lkuEQzmufLE7hXBbipu4boxorivfStciDgHCLq+IPLRQ9gvWnhsxCBqthISmIFhcpmeVy2zae3dRmqrKV/T8rpmyn0Lm99c9XRb0Oo8nmiqDWy5KPO+XLHVV/9k/vDSk6sWomALTfWFXinqDLIyn95kRP1+kvChXs332+UtI/ugpCvjBJda5WlaKXUOJNelaFUa4/jJAledSEcz+8pNd8AhFH9IPb0Z80qvqmCcp0LaADA/D0rfisjr2bx62o2e2hA1WSgD9AeR7wPhi1p3kUbd+hmJcAZQbSO9jTVMtC6wjpcY0e87lh0Ui/tm0QT8clUe0EMTxgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ai1rkdB4+Tu28J2rae5XaDMcJaqsEhiRCg090YI0oyU=;
 b=KA3cDLZRiysCAkrFsujYTlG16qVcKirYxYLSkZT6EWEuZ5BsgQSQosfGGBx4kkxClAvpMNJxQGGcRQDJeNvtdPoSWWSSSTXC5qchF7T7w45htGwiLhQA66xyuqqNU1cnMtUUvq3crwPVtxyJ6q7lQUJeYF4mcDfyHqFTVx+XFbU=
Received: from SA9P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::18)
 by SJ2PR12MB8010.namprd12.prod.outlook.com (2603:10b6:a03:4c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 16:27:02 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::3b) by SA9P223CA0013.outlook.office365.com
 (2603:10b6:806:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 16:27:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 16:27:01 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 11:27:00 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 3/7] drm/amdgpu/vcn: sriov support for vcn_v4_0_3
Date: Tue, 8 Aug 2023 12:26:18 -0400
Message-ID: <20230808162622.74937-3-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808162622.74937-1-samir.dhume@amd.com>
References: <20230808162622.74937-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SJ2PR12MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: 17fa3452-682f-48a2-c529-08db982c4b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZhPywVi6ddXva791COjUfVlLCfq2Nqh//72hQuDsE330l0ZHMtXFzzApWugjytmRSi9LeUu4sRNWvXufvrFsEmPaQgosKXekRTDg0yd67B2C+5eos2f6JZtuIgELRmgLGUg5h7E5kiSssdzWgM4KvcSDA28Dk3AAuECnDeXw0fsfQmZwwn7S+2t7U0/Kd1YtY6cOWUd356VDm72upoqHFyR571El9EEm2TCu7voEpnm594cELP9QSp0zJ43TxZtPMgnE/nKwnGZgVBQ2iQjmfbRvbJDdWGl4Q4931FePJVtxMUGs4k0BjGypezDwVd9zBi3r4wwRmqKt82BLHepqdnWuqnHZuReGFsDZKIbicRndtGp8RbhA1h34DijFipqqW1H/lLkDbt9ovzrzu1AOQWBjqFJprTuRQ407JdjwWxCWJkHhtdaDdVIRO7b5dFPEwvehLq9l6KKAzVBUg5XLdfU+QsSBNWsCD369GLSwUQOCCCaBjQKfYrO5eGLx0APn637gFXjJXZcYFNTnr7h5YEAMD+9r7ARk+dly8OrYYKFh8INsoJBtchPNZs+7JlMFjN5q0ellcilIWpNe0/WAvVpQ13pWIHPfB4ylrksIbG6SFj6Xvw1RpcuiHIiBodhOTHZ3ulUy5ZXJjw8FGvjSYcHd+WQ2L+z/0q672sDaDsWxcLTbSraytw1/oW+yo0UUdeQohKigi4qYKe+PZ3c/uHna4s+Agn9ll6liyS1Gny2KPzvMeACG3tgjpHEiLig
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(82310400008)(1800799003)(186006)(451199021)(46966006)(36840700001)(40470700004)(426003)(26005)(1076003)(83380400001)(2906002)(44832011)(5660300002)(8676002)(41300700001)(36860700001)(8936002)(47076005)(16526019)(40460700003)(2616005)(40480700001)(336012)(81166007)(316002)(6916009)(54906003)(82740400003)(7696005)(86362001)(356005)(70586007)(70206006)(6666004)(478600001)(4326008)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 16:27:01.6390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fa3452-682f-48a2-c529-08db982c4b93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8010
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
Cc: zhigang.luo@amd.com, guchun.chen@amd.com, gavin.wan@amd.com,
 lijo.lazar@amd.com, emily.deng@amd.com, frank.min@amd.com,
 alexander.deucher@amd.com, Samir
 Dhume <samir.dhume@amd.com>, leo.liu@amd.com, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

initialization table handshake with mmsch

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 260 +++++++++++++++++++++---
 1 file changed, 236 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 411c1d802823..66eb0c8e6f94 100644
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
@@ -189,33 +200,47 @@ static int vcn_v4_0_3_hw_init(void *handle)
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
@@ -813,6 +838,193 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 	return 0;
 }
 
+static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
+{
+	int i, vcn_inst;
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
+		vcn_inst = GET_INST(VCN, i);
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
+		cache_addr = adev->vcn.inst[vcn_inst].gpu_addr + offset;
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), lower_32_bits(cache_addr));
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), upper_32_bits(cache_addr));
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_VCPU_CACHE_OFFSET1), 0);
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE);
+
+		cache_addr = adev->vcn.inst[vcn_inst].gpu_addr + offset +
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
+		fw_shared = adev->vcn.inst[vcn_inst].fw_shared.cpu_addr;
+		rb_setup = &fw_shared->rb_setup;
+
+		ring_enc = &adev->vcn.inst[vcn_inst].ring_enc[0];
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
+			lower_32_bits(adev->vcn.inst[vcn_inst].fw_shared.gpu_addr));
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
+			upper_32_bits(adev->vcn.inst[vcn_inst].fw_shared.gpu_addr));
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
+		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_CTX_ADDR_LO, lower_32_bits(ctx_addr));
+		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_CTX_ADDR_HI, upper_32_bits(ctx_addr));
+
+		tmp = RREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_VMID);
+		tmp &= ~MMSCH_VF_VMID__VF_CTX_VMID_MASK;
+		tmp |= (0 << MMSCH_VF_VMID__VF_CTX_VMID__SHIFT);
+		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_VMID, tmp);
+
+		size = header.total_size;
+		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_CTX_SIZE, size);
+
+		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_MAILBOX_RESP, 0);
+
+		param = 0x00000001;
+		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_MAILBOX_HOST, param);
+		tmp = 0;
+		timeout = 1000;
+		resp = 0;
+		expected = MMSCH_VF_MAILBOX_RESP__OK;
+		while (resp != expected) {
+			resp = RREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_MAILBOX_RESP);
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

