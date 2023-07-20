Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73299EB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 19:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCE4110E17B;
	Thu, 20 Jul 2023 19:20:30 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0123B10E17A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 19:20:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mu9p0SSiH1fwjs1NEV/IHL503KvFAalIRAk+Lyqh9kwSyZyN2Kgg747fsR8glFCH9SbaJFmvANuda/m2Q1s+uByvq3xO6PBbGn1lE2vHXpvkLJDOFCheSQtvbWEDGeQFwe+NaVtia92BiS0BJ3cv4kLb6RMyYc+QcmR1WvKwvkXm0nvC16ASFF2zyOtJy079Njez3gcA6wXDNx5gKkQ6luJqLoF2DlVWcBVVrqGSrFcyEAaZQuOpN1fIUrwBRwtCixtQhie89pWErmOlueMXYbwrg3QvBDYgiWlXYxRCEtv3gQBBZ2jqPZbRePXJrrxtASpcRkD0+j3Iyr8Oxybnuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSiEmlRe8+XvCdTjgQ3Wq4t8zcpLTmWExHEtNMhOQUo=;
 b=g5UoYj5KTHQb9I0nOUKmZhyGC1cczLTxsF6S0p3Sjzj2C3DMl3S9/zpiDXO+u4KnOJFyFTLFpwJWjL9FiQ77vPJRwf3gHdYYAxF7QcNN+qDW3uoPhwwUhCgvPof8uiNwmIReaCkMxkNQaLfcPQDLZnUlQgmMMVHFtrZ3l0Fbuif2QCvOFy1K1Cmf16eOqgEzEZNzb/G3CkqdxOrz5QplWN44cUze9K9fWWurJo7dNbMVF7RT/Hb4LbS3ImOKGL+ivJ6C+gVJvLtpsYFOtgM1zuymUUHLtrEYjaiSS64WN8fGIBNng5AWbXKr+p/LuBRHtyE2KpDPY77/h3M3d+lBLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSiEmlRe8+XvCdTjgQ3Wq4t8zcpLTmWExHEtNMhOQUo=;
 b=0eOtaVS86Sh587SuYHNvtgi2XS7DfrbhtvGHmOrs0+qGoGDu12B/BE8CmFSOFDAp9DVfge4GhLxx+K7uNaw7c3K/H006x8oKbzMoSJdwpNi3HHeXNbUXOmnDvi+qGCEYDQWj1DNi7EnJU0YHPompGvHfFBzjnZsK1OYEacdexGQ=
Received: from DM6PR11CA0032.namprd11.prod.outlook.com (2603:10b6:5:190::45)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Thu, 20 Jul 2023 19:20:24 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::8d) by DM6PR11CA0032.outlook.office365.com
 (2603:10b6:5:190::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Thu, 20 Jul 2023 19:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Thu, 20 Jul 2023 19:20:23 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Jul 2023 14:20:22 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amdgpu/vcn: sriov support for vcn_v4_0_3
Date: Thu, 20 Jul 2023 15:19:36 -0400
Message-ID: <20230720191940.780187-3-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720191940.780187-1-samir.dhume@amd.com>
References: <20230720191940.780187-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT006:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b221c8-caa9-4c8a-2e7d-08db89565e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P3hbyqHyNYc3raDfg9NSMohukVkEgobqNVWAuBbfnA0gYlnpj0l/VnJWxAhOAsjNjjeVIMcuCmlD3mjqQo5iB41cUXDqa0aDylypDnXaoc+Tt4khnHsBDqsTIrY3tSVLkdhf4qmfukGXGoSLD7IWBZyKbbbSZvtd8+H2hgbC03FbdKfMEqRuSOwt9kXK0181kjwkcoALCFJD7z6w7CP3qI8rHfqc1p+WlxbZNloe5gykwxEAgSIN7QjSkEWq1LlzSrG7U7zjD/lWwcYhrm7sns9yux9PBxwU4ZjJ8SsLIsQUXS3ZxKzV8doIOu46Iv+aa6cnUoht3t5c7EEMuGiyqbm9KYfCRhkA6zZtZI+AJSsFNUJg4wY8xrrjS1zAJQsuN10wm/z51txrFCvA3lHTc3aKtxS1VQeuuL+W5FIpoX4S3DGweMcflObOYkUTzyvX4O8gD96AULYMkG7Q5y8omYa7/GDpjQLV//VzG3yD27kD65tlB8mFr2UyZPKj/wiQx2RpinIA7CbITJ93RAc9Ech0Umv3+JAano927aHnJPpWik3VpctgHLAVEw0dUw+JKPOTZp/VHVkMzPqZWIcpYQu6sVvq333zNSekBCVN2v5QXPvpEkv35ibDMpNLFnuFDX/3w5KKHfoelbPShSL9JV9xN3KF0hkDNs9GOC/ILXMEJMpNAl8mr0pNnbAFoZHuuYsGd1ZWzdtwI7daqcqg/etaPDH16uDbiqtZoHnqlnpM9WE7t/ScpuAYAJW8TqrU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(478600001)(2906002)(82740400003)(16526019)(86362001)(81166007)(83380400001)(336012)(47076005)(426003)(26005)(1076003)(2616005)(40480700001)(36860700001)(40460700003)(5660300002)(356005)(54906003)(44832011)(36756003)(8676002)(6666004)(7696005)(6916009)(70586007)(8936002)(316002)(4326008)(41300700001)(70206006)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 19:20:23.9932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b221c8-caa9-4c8a-2e7d-08db89565e06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
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
 lijo.lazar@amd.com, Samir Dhume <samir.dhume@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

initialization table handshake with mmsch

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 261 +++++++++++++++++++++---
 1 file changed, 237 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 411c1d802823..8650e3c6288d 100644
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
@@ -130,6 +132,10 @@ static int vcn_v4_0_3_sw_init(void *handle)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 	}
 
+	r = amdgpu_virt_alloc_mm_table(adev);
+	if (r)
+		return r;
+
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		adev->vcn.pause_dpg_mode = vcn_v4_0_3_pause_dpg_mode;
 
@@ -167,6 +173,8 @@ static int vcn_v4_0_3_sw_fini(void *handle)
 		drm_dev_exit(idx);
 	}
 
+	amdgpu_virt_free_mm_table(adev);
+
 	r = amdgpu_vcn_suspend(adev);
 	if (r)
 		return r;
@@ -189,33 +197,50 @@ static int vcn_v4_0_3_hw_init(void *handle)
 	struct amdgpu_ring *ring;
 	int i, r, vcn_inst;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		vcn_inst = GET_INST(VCN, i);
-		ring = &adev->vcn.inst[i].ring_enc[0];
+	if (amdgpu_sriov_vf(adev)) {
+		r = vcn_v4_0_3_start_sriov(adev);
+		if (r)
+			goto done;
+
+		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+			if (adev->vcn.harvest_config & (1 << i))
+				continue;
 
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
@@ -813,6 +838,194 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
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

