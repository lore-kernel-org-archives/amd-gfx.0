Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E1FC77B60
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C04410F001;
	Thu, 30 Mar 2023 19:46:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F2410EFD4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGVpNkTvPyecHqLhR4AMxAC/m7hH6aBLVpkV3xHmmZDCiXkfsll2cncyUM/4fxOUHPRNqWdaJaidrbMoXj07HuoUwrqVhK9boIB70fOov4jnXW8RbXPgoP+PLO4Gnx+Yz8pDcBzImghhcdMa0tQ/TZHhCObW3/LJQ52Bd8lhLHB4XVR3wvgKcR5rGhjZH7zeHCCvSJS4iaxV3YO3dkoSpk8q6aaqp9W4xLyAA28wojiC96Zkdp/3nY+N04hQkti2wH7nO9JWCPOz3z6fR2EyxxWJAoqL8EawNamnLhySjkCWnkE3na2eER6nGdB4DP5C0Gg7qxAWYQS09YN4t4NqMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSyMxyjucYSQU81lXrTx36okzt8cI3ZKVHzCRqzYkEE=;
 b=WOUoT/5T60tzFIr5j1v7915oMpWxVu1qJRMy4zwNX9u82nd2TmR+a1Se8OE26g8FbLSpCPt02gn/N+OXLWWfYZZm4G5LQTzT434dYe29fsDQinvXmOnnJMvcMxwp+nT3uha/4Kzx/krMaKl9HO3KBoxCPO9+c85BV68Xkz0Kh80en0fwd7wo+zdf+4eU1CF5VkDaAXBEHhQrqJJp/luUv0fuBFIDON/q67ypPx0Wmw+AGYnLD6cuWOb9nPmj2pb6CweT/pxMH+EwUzsOEQ0qkIaI5pl9l91QXU1vJCqZS/xXvcopJ4NoM0HnvB6QkfY7eCq5XVCso/4gKl7graOZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSyMxyjucYSQU81lXrTx36okzt8cI3ZKVHzCRqzYkEE=;
 b=ojzaX/IKTWk1Vl3aFqYgpH/GtH3GrUQesPHMH150L6kDj5Oy1uLMMS8q9IRAvrdPQrxEPwE1j7SW5WqF8MRVQJ4U/baTSfWtIzLM4b0AaoH0BZacJXkk5YkIdFD/ZgdsMR5D3j6WpcKJDQ/qkgwNY7Vq4FrRB6uJ3DqdsLfl1Yo=
Received: from DM6PR13CA0016.namprd13.prod.outlook.com (2603:10b6:5:bc::29) by
 BL0PR12MB4945.namprd12.prod.outlook.com (2603:10b6:208:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:46:01 +0000
Received: from DS1PEPF0000E636.namprd02.prod.outlook.com
 (2603:10b6:5:bc:cafe::b6) by DM6PR13CA0016.outlook.office365.com
 (2603:10b6:5:bc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:46:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E636.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:46:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:46:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/8] drm/amdgpu: add unified queue support on vcn_v4_0_3
Date: Thu, 30 Mar 2023 15:45:41 -0400
Message-ID: <20230330194547.1135862-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194547.1135862-1-alexander.deucher@amd.com>
References: <20230330194547.1135862-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E636:EE_|BL0PR12MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb10d25-4de5-4162-fac6-08db31576407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MX2OUJ3wojSEVquF4Pl+tVeQ9WU0AupcFd1ecXmeOS6t6bfxvu3mEjWn919YuxnLjsP0shZZvonoTruE57Omk0O0cPURP/VZ3NUvIc1iRSGfHLDez8ZMpETHFbOHvmwTETGQBH2zBt4+tSYW6s5fxS4h/EgYq2OBWIpwqoMC7xKpcaab3BF9gXG2nGJBKBPQlCWxBokO4ShIZ0P4224+61ezCRO3r+glgDnmqocgNdtleWIEmb1zorPGmIki3wkoMgfVO3m2u0+O+Uq2MbT00XCsTcJaSG2g0tI/TRZARTjSCvxMM+LNUJpHr8EA4QglQyxiLTGqDdoTwYOmVFSgLyKKTR3IwJDs0Pm/aLG0qeSmC0zSlQ4uCTOg0iY4Ec2RDIX8eYh/00Bh5/8VU0j5THc44X3bvAmdnO2doSxR1MZ+345DATsbv2PIT9idORfn8wutcF6YoHn6sDBaIRew+GRPIST/G24X4P8TR99+jFskxTLCPC//7+tpl4TeVDNtXNo1mNFz2f4Gxon/1kCZk8VKeerJxkO59CGP7FebxkHhQd9CBzmyCNcQtSSf1cFcG5UYn/310FlLdJhB5redPs6p6DG7gY9TOFR9VcyVV0RdKD/V8Dl+woiBxmIklZBt23SQmROOQQ8LU6ViS9yPC3Uwzx9tkYsd/NlowuB4yF6ub0FaWmKS5dfnWibgOfq9lpMlZRLvmMORbspVp7xo9TlPyCx7In1qkx5uhOAyENI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(2906002)(8936002)(82740400003)(41300700001)(356005)(5660300002)(30864003)(86362001)(36756003)(82310400005)(40480700001)(81166007)(54906003)(336012)(426003)(47076005)(7696005)(316002)(478600001)(36860700001)(26005)(8676002)(70206006)(70586007)(4326008)(6916009)(83380400001)(2616005)(16526019)(186003)(1076003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:46:01.2436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb10d25-4de5-4162-fac6-08db31576407
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E636.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4945
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Add unified queue support on vcn_v4_0_3.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |   9 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 173 +++++++++++++-----------
 2 files changed, 102 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 72eb12aa2e8d..2e28b19e741e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1004,11 +1004,14 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 int amdgpu_vcn_unified_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
+	struct amdgpu_device *adev = ring->adev;
 	long r;
 
-	r = amdgpu_vcn_enc_ring_test_ib(ring, timeout);
-	if (r)
-		goto error;
+	if (adev->ip_versions[UVD_HWIP][0] != IP_VERSION(4, 0, 3)) {
+		r = amdgpu_vcn_enc_ring_test_ib(ring, timeout);
+		if (r)
+			goto error;
+	}
 
 	r =  amdgpu_vcn_dec_sw_ring_test_ib(ring, timeout);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 40de2852c5ca..18320eebdb4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -31,7 +31,6 @@
 #include "soc15d.h"
 #include "soc15_hw_ip.h"
 #include "vcn_v2_0.h"
-#include "vcn_sw_ring.h"
 
 #include "vcn/vcn_4_0_3_offset.h"
 #include "vcn/vcn_4_0_3_sh_mask.h"
@@ -45,12 +44,13 @@
 #define VCN_VID_SOC_ADDRESS_2_0		0x1fb00
 #define VCN1_VID_SOC_ADDRESS_3_0	0x48300
 
-static void vcn_v4_0_3_set_dec_ring_funcs(struct amdgpu_device *adev);
+static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v4_0_3_set_powergating_state(void *handle,
 		enum amd_powergating_state state);
 static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
+static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring);
 
 /**
  * vcn_v4_0_3_early_init - set function pointers
@@ -63,7 +63,10 @@ static int vcn_v4_0_3_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	vcn_v4_0_3_set_dec_ring_funcs(adev);
+	/* re-use enc ring as unified ring */
+	adev->vcn.num_enc_rings = 1;
+
+	vcn_v4_0_3_set_unified_ring_funcs(adev);
 	vcn_v4_0_3_set_irq_funcs(adev);
 
 	return 0;
@@ -94,7 +97,7 @@ static int vcn_v4_0_3_sw_init(void *handle)
 
 	/* VCN DEC TRAP */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
-		VCN_4_0__SRCID__UVD_TRAP, &adev->vcn.inst->irq);
+		VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst->irq);
 	if (r)
 		return r;
 
@@ -104,11 +107,11 @@ static int vcn_v4_0_3_sw_init(void *handle)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		ring = &adev->vcn.inst[i].ring_dec;
+		ring = &adev->vcn.inst[i].ring_enc[0];
 		ring->use_doorbell = true;
 		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 9 * i;
 		ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
-		sprintf(ring->name, "vcn_dec_%d", i);
+		sprintf(ring->name, "vcn_unified_%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
 				     AMDGPU_RING_PRIO_DEFAULT,
 				     &adev->vcn.inst[i].sched_score);
@@ -116,7 +119,7 @@ static int vcn_v4_0_3_sw_init(void *handle)
 			return r;
 
 		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared->present_flag_0 = 0;
+		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
 		fw_shared->sq.is_enabled = cpu_to_le32(true);
 
 		if (amdgpu_vcnfw_log)
@@ -179,17 +182,17 @@ static int vcn_v4_0_3_hw_init(void *handle)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
-		ring = &adev->vcn.inst[i].ring_dec;
+		ring = &adev->vcn.inst[i].ring_enc[0];
 
-		if (ring->use_doorbell)
+		if (ring->use_doorbell) {
 			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 					(adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 9 * i,
 					adev->vcn.inst[i].aid_id);
 
-		if (ring->use_doorbell)
-			WREG32_SOC15(VCN, ring->me, regVCN_RB4_DB_CTRL,
-				ring->doorbell_index << VCN_RB4_DB_CTRL__OFFSET__SHIFT |
-				VCN_RB4_DB_CTRL__EN_MASK);
+			WREG32_SOC15(VCN, ring->me, regVCN_RB1_DB_CTRL,
+				ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
+				VCN_RB1_DB_CTRL__EN_MASK);
+		}
 
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
@@ -731,31 +734,31 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
 				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
 
-	ring = &adev->vcn.inst[inst_idx].ring_dec;
+	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 
 	/* program the RB_BASE for ring buffer */
-	WREG32_SOC15(VCN, inst_idx, regUVD_RB_BASE_LO4,
+	WREG32_SOC15(VCN, inst_idx, regUVD_RB_BASE_LO,
 		lower_32_bits(ring->gpu_addr));
-	WREG32_SOC15(VCN, inst_idx, regUVD_RB_BASE_HI4,
+	WREG32_SOC15(VCN, inst_idx, regUVD_RB_BASE_HI,
 		upper_32_bits(ring->gpu_addr));
 
-	WREG32_SOC15(VCN, inst_idx, regUVD_RB_SIZE4, ring->ring_size / sizeof(uint32_t));
+	WREG32_SOC15(VCN, inst_idx, regUVD_RB_SIZE, ring->ring_size / sizeof(uint32_t));
 
 	/* resetting ring, fw should not check RB ring */
 	tmp = RREG32_SOC15(VCN, inst_idx, regVCN_RB_ENABLE);
-	tmp &= ~(VCN_RB_ENABLE__RB4_EN_MASK);
+	tmp &= ~(VCN_RB_ENABLE__RB_EN_MASK);
 	WREG32_SOC15(VCN, inst_idx, regVCN_RB_ENABLE, tmp);
+	fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
 
 	/* Initialize the ring buffer's read and write pointers */
-	WREG32_SOC15(VCN, inst_idx, regUVD_RB_RPTR4, 0);
-	WREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR4, 0);
-	ring->wptr = RREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR4);
+	WREG32_SOC15(VCN, inst_idx, regUVD_RB_RPTR, 0);
+	WREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR, 0);
+	ring->wptr = RREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR);
 
 	tmp = RREG32_SOC15(VCN, inst_idx, regVCN_RB_ENABLE);
-	tmp |= VCN_RB_ENABLE__RB4_EN_MASK;
+	tmp |= VCN_RB_ENABLE__RB_EN_MASK;
 	WREG32_SOC15(VCN, inst_idx, regVCN_RB_ENABLE, tmp);
-
-	WREG32_SOC15(VCN, inst_idx, regUVD_SCRATCH2, 0);
+	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
 	/*resetting done, fw can check RB ring */
 	fw_shared->sq.queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
@@ -902,31 +905,31 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev)
 		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
 			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
 
-		ring = &adev->vcn.inst[i].ring_dec;
+		ring = &adev->vcn.inst[i].ring_enc[0];
 		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 
 		/* program the RB_BASE for ring buffer */
-		WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO4,
+		WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO,
 			lower_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI4,
+		WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI,
 			upper_32_bits(ring->gpu_addr));
 
-		WREG32_SOC15(VCN, i, regUVD_RB_SIZE4, ring->ring_size / sizeof(uint32_t));
+		WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring->ring_size / sizeof(uint32_t));
 
 		/* resetting ring, fw should not check RB ring */
 		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
-		tmp &= ~(VCN_RB_ENABLE__RB4_EN_MASK);
+		tmp &= ~(VCN_RB_ENABLE__RB_EN_MASK);
 		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
 
 		/* Initialize the ring buffer's read and write pointers */
-		WREG32_SOC15(VCN, i, regUVD_RB_RPTR4, 0);
-		WREG32_SOC15(VCN, i, regUVD_RB_WPTR4, 0);
+		WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
+		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
 
 		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
-		tmp |= VCN_RB_ENABLE__RB4_EN_MASK;
+		tmp |= VCN_RB_ENABLE__RB_EN_MASK;
 		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
 
-		ring->wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR4);
+		ring->wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
 		fw_shared->sq.queue_mode &=
 			cpu_to_le32(~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF));
 
@@ -951,8 +954,8 @@ static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
 	/* wait for read ptr to be equal to write ptr */
-	tmp = RREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR4);
-	SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_RB_RPTR4, tmp, 0xFFFFFFFF);
+	tmp = RREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR);
+	SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_RB_RPTR, tmp, 0xFFFFFFFF);
 
 	SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_POWER_STATUS, 1,
 		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
@@ -972,15 +975,20 @@ static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  */
 static int vcn_v4_0_3_stop(struct amdgpu_device *adev)
 {
+	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	uint32_t tmp;
 	int i, r = 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
+
+		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
+
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v4_0_3_stop_dpg_mode(adev, i);
-			goto Done;
+			vcn_v4_0_3_stop_dpg_mode(adev, i);
+			continue;
 		}
 
 		/* wait for vcn idle */
@@ -1000,7 +1008,7 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *adev)
 		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL2);
 		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
 		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL2, tmp);
-		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
+		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
 			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
 		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
 		if (r)
@@ -1059,101 +1067,112 @@ static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev, int inst_idx,
 }
 
 /**
- * vcn_v4_0_3_dec_ring_get_rptr - get read pointer
+ * vcn_v4_0_3_unified_ring_get_rptr - get unified read pointer
  *
  * @ring: amdgpu_ring pointer
  *
- * Returns the current hardware read pointer
+ * Returns the current hardware unified read pointer
  */
-static uint64_t vcn_v4_0_3_dec_ring_get_rptr(struct amdgpu_ring *ring)
+static uint64_t vcn_v4_0_3_unified_ring_get_rptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	return RREG32_SOC15(VCN, ring->me, regUVD_RB_RPTR4);
+	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
+		DRM_ERROR("wrong ring id is identified in %s", __func__);
+
+	return RREG32_SOC15(VCN, ring->me, regUVD_RB_RPTR);
 }
 
 /**
- * vcn_v4_0_3_dec_ring_get_wptr - get write pointer
+ * vcn_v4_0_3_unified_ring_get_wptr - get unified write pointer
  *
  * @ring: amdgpu_ring pointer
  *
- * Returns the current hardware write pointer
+ * Returns the current hardware unified write pointer
  */
-static uint64_t vcn_v4_0_3_dec_ring_get_wptr(struct amdgpu_ring *ring)
+static uint64_t vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 
+	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
+		DRM_ERROR("wrong ring id is identified in %s", __func__);
+
 	if (ring->use_doorbell)
-		return adev->wb.wb[ring->wptr_offs];
+		return *ring->wptr_cpu_addr;
 	else
-		return RREG32_SOC15(VCN, ring->me, regUVD_RB_WPTR4);
+		return RREG32_SOC15(VCN, ring->me, regUVD_RB_WPTR);
 }
 
 /**
- * vcn_v4_0_3_dec_ring_set_wptr - set write pointer
+ * vcn_v4_0_3_unified_ring_set_wptr - set enc write pointer
  *
  * @ring: amdgpu_ring pointer
  *
- * Commits the write pointer to the hardware
+ * Commits the enc write pointer to the hardware
  */
-static void vcn_v4_0_3_dec_ring_set_wptr(struct amdgpu_ring *ring)
+static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 
+	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
+		DRM_ERROR("wrong ring id is identified in %s", __func__);
+
 	if (ring->use_doorbell) {
-		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
-		WREG32_SOC15(VCN, ring->me, regUVD_RB_WPTR4, lower_32_bits(ring->wptr));
+		WREG32_SOC15(VCN, ring->me, regUVD_RB_WPTR, lower_32_bits(ring->wptr));
 	}
 }
 
-static const struct amdgpu_ring_funcs vcn_v4_0_3_dec_sw_ring_vm_funcs = {
-	.type = AMDGPU_RING_TYPE_VCN_DEC,
+static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
+	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
-	.nop = VCN_DEC_SW_CMD_NO_OP,
-	.get_rptr = vcn_v4_0_3_dec_ring_get_rptr,
-	.get_wptr = vcn_v4_0_3_dec_ring_get_wptr,
-	.set_wptr = vcn_v4_0_3_dec_ring_set_wptr,
+	.nop = VCN_ENC_CMD_NO_OP,
+	.get_rptr = vcn_v4_0_3_unified_ring_get_rptr,
+	.get_wptr = vcn_v4_0_3_unified_ring_get_wptr,
+	.set_wptr = vcn_v4_0_3_unified_ring_set_wptr,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
-		VCN_SW_RING_EMIT_FRAME_SIZE,
-	.emit_ib_size = 5, /* vcn_dec_sw_ring_emit_ib */
-	.emit_ib = vcn_dec_sw_ring_emit_ib,
-	.emit_fence = vcn_dec_sw_ring_emit_fence,
-	.emit_vm_flush = vcn_dec_sw_ring_emit_vm_flush,
-	.test_ring = amdgpu_vcn_dec_sw_ring_test_ring,
-	.test_ib = amdgpu_vcn_dec_sw_ring_test_ib,
+		4 + /* vcn_v2_0_enc_ring_emit_vm_flush */
+		5 + 5 + /* vcn_v2_0_enc_ring_emit_fence x2 vm fence */
+		1, /* vcn_v2_0_enc_ring_insert_end */
+	.emit_ib_size = 5, /* vcn_v2_0_enc_ring_emit_ib */
+	.emit_ib = vcn_v2_0_enc_ring_emit_ib,
+	.emit_fence = vcn_v2_0_enc_ring_emit_fence,
+	.emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
+	.test_ring = amdgpu_vcn_enc_ring_test_ring,
+	.test_ib = amdgpu_vcn_unified_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
-	.insert_end = vcn_dec_sw_ring_insert_end,
+	.insert_end = vcn_v2_0_enc_ring_insert_end,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.begin_use = amdgpu_vcn_ring_begin_use,
 	.end_use = amdgpu_vcn_ring_end_use,
-	.emit_wreg = vcn_dec_sw_ring_emit_wreg,
-	.emit_reg_wait = vcn_dec_sw_ring_emit_reg_wait,
+	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
+	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
 /**
- * vcn_v4_0_3_set_dec_ring_funcs - set dec ring functions
+ * vcn_v4_0_3_set_unified_ring_funcs - set unified ring functions
  *
  * @adev: amdgpu_device pointer
  *
- * Set decode ring functions
+ * Set unified ring functions
  */
-static void vcn_v4_0_3_set_dec_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev)
 {
 	int i;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
-		adev->vcn.inst[i].ring_dec.funcs = &vcn_v4_0_3_dec_sw_ring_vm_funcs;
-		adev->vcn.inst[i].ring_dec.me = i;
+		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v4_0_3_unified_ring_vm_funcs;
+		adev->vcn.inst[i].ring_enc[0].me = i;
 		adev->vcn.inst[i].aid_id = i / adev->vcn.num_inst_per_aid;
 	}
-	DRM_DEV_INFO(adev->dev, "VCN decode(Software Ring) is enabled in VM mode\n");
+	DRM_DEV_INFO(adev->dev, "VCN decode is enabled in VM mode\n");
 }
 
 /**
@@ -1276,7 +1295,7 @@ static int vcn_v4_0_3_set_interrupt_state(struct amdgpu_device *adev,
 }
 
 /**
- * vcn_v4_0_process_interrupt - process VCN block interrupt
+ * vcn_v4_0_3_process_interrupt - process VCN block interrupt
  *
  * @adev: amdgpu_device pointer
  * @source: interrupt sources
@@ -1295,8 +1314,8 @@ static int vcn_v4_0_3_process_interrupt(struct amdgpu_device *adev,
 	DRM_DEV_DEBUG(adev->dev, "IH: VCN TRAP\n");
 
 	switch (entry->src_id) {
-	case VCN_4_0__SRCID__UVD_TRAP:
-		amdgpu_fence_process(&adev->vcn.inst[i].ring_dec);
+	case VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE:
+		amdgpu_fence_process(&adev->vcn.inst[i].ring_enc[0]);
 		break;
 	default:
 		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
-- 
2.39.2

