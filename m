Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04585C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 02:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 638B610E0AE;
	Mon,  6 Jun 2022 02:14:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D995310E0AE
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 02:14:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkO0SGVffXqYKJ16F1GpfOtRLXJUQ16sBZnSav8s7J8JZ/te4wOA4WZCwIommVwxnOc5lcF18twa+rf8GJP4XfPDOAQ6DjbAwowIAwLYyigaF4TyBDeEIwRvBntWByV1EGVcB989ogGE7Gn+orMb3jotjfp5DTNxxXtVSBHsZQZpTcPXp5k1T61A6M9sweo8HC5GETtx84XvH47t1Xry0F2gg8vmKz4zmBAA2JEUafhN9ozqe81ym3P1a14Z+ii0++HJ2yUw5Ak4/0we3ApGabr6ltSCwzbsHHbQTLmJy/oEwFGqRmaU/YduT7hbvyh/+32wTznUedMz9cfHmJNGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzK1H0yWBz/YoRHDyi4KMDMqLy7tdKbc7/Kh/Hdnu6w=;
 b=T34BRYS68+fmqHRWi1XrFnSUlzpr/8pZeDnj8yUUVfw0zQe4cGl7C/ue0M/KI2rm3UTAVZXdd+1iEVk/GZRv2yKtew3Pel5svecY/YN5+XFKMUare14/oSxLfhTo5kNAZPgWR5gkrmeF3QxaNprqUiCMc8tt2yQnJlUVUiGsWvHRphbIRnhcYzEvL1VbP/pgMCCtDEbUZMV+QoHuv9IOQN28JNwfC6xW6gqYDeREX0rz68u4CHqL+DzNLhErCa0Ns9q1uv1j0ScwcUjyFlF+EdBJt2+01FTdxDBsuqS0aQa53B0JBE5SCzCbopCTJvDlSHlEB06Conx2awMxGo2U2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzK1H0yWBz/YoRHDyi4KMDMqLy7tdKbc7/Kh/Hdnu6w=;
 b=4LsFU3Tt6L36ba7Q6ofL+k0Jv3A/xa+LS48ai43yoheYPZDM3UZXLgicbaKFE3INoJmUjiR8ewHVd1or86T3clSB9PHVdyDJVCmmWRKjhNhTb2Q9wdoRWrSoS2PF6DPE8/qDuEqksKStDJI6B7kEyehzcFTI8iTRGDzBOqlPJHA=
Received: from DM6PR02CA0095.namprd02.prod.outlook.com (2603:10b6:5:1f4::36)
 by BN6PR12MB1794.namprd12.prod.outlook.com (2603:10b6:404:100::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Mon, 6 Jun
 2022 02:14:24 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::e1) by DM6PR02CA0095.outlook.office365.com
 (2603:10b6:5:1f4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Mon, 6 Jun 2022 02:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 02:14:24 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 5 Jun 2022 21:14:21 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: Ensure the DMA engine is deactivated
 during set ups"
Date: Mon, 6 Jun 2022 10:14:00 +0800
Message-ID: <20220606021400.10764-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b90b0532-2e1d-4383-9413-08da476246b4
X-MS-TrafficTypeDiagnostic: BN6PR12MB1794:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB17940C35A3C0E573D75E7792F1A29@BN6PR12MB1794.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wdW3JVQ4PZ2EddUERLkVdaM+tuL2k+JuOV3pBwKxMkEp5eGL4XH9scsqLINhkT7HSUWwxwsKgobArzKkp2G0qCEJI6VeH09BEyEaeVXW3tWEBrnx0I9mujlHDYZgzDubM1lqiuRk4p1zA+T5J1YuhOckltk2LArKVjxDEqPnTNgqj3KvX/oa4CtheNXP4wMTmSkrgamj27I70VWVDwAI+RpFnroDMILAFHZM11q1Gtqw19/mYmPOHavkcxixWMrP5VZTOSooPU3VP8xT/wihL7oyvCfC7cJl+jDU2a830Wy2PlBo2ZNi45MZuuV5nwIkO42ySevZXo/vWw+BvIEgxBnEL0NoFAdu+ypc1CN2HYcZJutZ9kDo5BRGIJzpdFFYfx0/Hx5dTx9cagi6pKwQu1CFBGzNtsUFx0y9513zXjDlYnOVanGT59E7PU4TJVZYA+QVmNrPjIXzd0Eq/dPdZFEno8KaRYBrwBEBNVLKBgccOWAus+bs3SNtDFhVsSWnR2LIHLg/PXvTwy8VaqveAHvlYpb4XyNc7h3xySfTeOFhz854PM/RGNn9VfySkKiBi2dBeVnVwcxMHgJT8mibjFvdTFqLbjwIAWshTlZJ17S8g9/jZgH7wfwEosF87ZGG6k/t8oPTLdicC2TQjYUuM82VxZKI/9KNCrMhHv7DkwDSdxSXQ/WEYrVGV2LufYd23b2GbQTwhOd3m4lAJ2qddw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8676002)(4326008)(82310400005)(5660300002)(81166007)(356005)(36860700001)(86362001)(110136005)(1076003)(70206006)(186003)(336012)(316002)(426003)(2616005)(47076005)(6636002)(70586007)(16526019)(83380400001)(54906003)(8936002)(6666004)(2906002)(7696005)(508600001)(36756003)(40460700003)(44832011)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 02:14:24.4015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b90b0532-2e1d-4383-9413-08da476246b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1794
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>, ricetons@gmail.com,
 Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit da38a66ac46e334f198afcd1b4d4554b4ddca0df.

This causes regression in GPU reset related test.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: ricetons@gmail.com
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 109 ++++++++++---------------
 1 file changed, 45 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 06b2635b142a..83c6ccaaa9e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -469,6 +469,7 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 	}
 }
 
+
 /**
  * sdma_v5_2_gfx_stop - stop the gfx async dma engines
  *
@@ -514,21 +515,17 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
 }
 
 /**
- * sdma_v5_2_ctx_switch_enable_for_instance - start the async dma engines
- * context switch for an instance
+ * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
  *
  * @adev: amdgpu_device pointer
- * @instance_idx: the index of the SDMA instance
+ * @enable: enable/disable the DMA MEs context switch.
  *
- * Unhalt the async dma engines context switch.
+ * Halt or unhalt the async dma engines context switch.
  */
-static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_device *adev, int instance_idx)
+static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
 {
 	u32 f32_cntl, phase_quantum = 0;
-
-	if (WARN_ON(instance_idx >= adev->sdma.num_instances)) {
-		return;
-	}
+	int i;
 
 	if (amdgpu_sdma_phase_quantum) {
 		unsigned value = amdgpu_sdma_phase_quantum;
@@ -552,68 +549,50 @@ static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_device *adev,
 		phase_quantum =
 			value << SDMA0_PHASE0_QUANTUM__VALUE__SHIFT |
 			unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
-
-		WREG32_SOC15_IP(GC,
-			sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE0_QUANTUM),
-			phase_quantum);
-		WREG32_SOC15_IP(GC,
-			sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE1_QUANTUM),
-		    phase_quantum);
-		WREG32_SOC15_IP(GC,
-			sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE2_QUANTUM),
-		    phase_quantum);
 	}
 
-	if (!amdgpu_sriov_vf(adev)) {
-		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL));
-		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
-				AUTO_CTXSW_ENABLE, 1);
-		WREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL), f32_cntl);
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		if (enable && amdgpu_sdma_phase_quantum) {
+			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
+			       phase_quantum);
+			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
+			       phase_quantum);
+			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
+			       phase_quantum);
+		}
+
+		if (!amdgpu_sriov_vf(adev)) {
+			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
+			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
+					AUTO_CTXSW_ENABLE, enable ? 1 : 0);
+			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
+		}
 	}
+
 }
 
 /**
- * sdma_v5_2_ctx_switch_disable_all - stop the async dma engines context switch
+ * sdma_v5_2_enable - stop the async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @enable: enable/disable the DMA MEs.
  *
- * Halt the async dma engines context switch.
+ * Halt or unhalt the async dma engines.
  */
-static void sdma_v5_2_ctx_switch_disable_all(struct amdgpu_device *adev)
+static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
 {
 	u32 f32_cntl;
 	int i;
 
-	if (amdgpu_sriov_vf(adev))
-		return;
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
-		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
-				AUTO_CTXSW_ENABLE, 0);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
+	if (!enable) {
+		sdma_v5_2_gfx_stop(adev);
+		sdma_v5_2_rlc_stop(adev);
 	}
-}
-
-/**
- * sdma_v5_2_halt - stop the async dma engines
- *
- * @adev: amdgpu_device pointer
- *
- * Halt the async dma engines.
- */
-static void sdma_v5_2_halt(struct amdgpu_device *adev)
-{
-	int i;
-	u32 f32_cntl;
-
-	sdma_v5_2_gfx_stop(adev);
-	sdma_v5_2_rlc_stop(adev);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		for (i = 0; i < adev->sdma.num_instances; i++) {
 			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
-			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
+			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
 			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
 		}
 	}
@@ -625,9 +604,6 @@ static void sdma_v5_2_halt(struct amdgpu_device *adev)
  * @adev: amdgpu_device pointer
  *
  * Set up the gfx DMA ring buffers and enable them.
- * It assumes that the dma engine is stopped for each instance.
- * The function enables the engine and preemptions sequentially for each instance.
- *
  * Returns 0 for success, error for failure.
  */
 static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
@@ -769,7 +745,10 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 
 		ring->sched.ready = true;
 
-		sdma_v5_2_ctx_switch_enable_for_instance(adev, i);
+		if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
+			sdma_v5_2_ctx_switch_enable(adev, true);
+			sdma_v5_2_enable(adev, true);
+		}
 
 		r = amdgpu_ring_test_ring(ring);
 		if (r) {
@@ -813,7 +792,7 @@ static int sdma_v5_2_load_microcode(struct amdgpu_device *adev)
 	int i, j;
 
 	/* halt the MEs */
-	sdma_v5_2_halt(adev);
+	sdma_v5_2_enable(adev, false);
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		if (!adev->sdma.instance[i].fw)
@@ -885,8 +864,8 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 	int r = 0;
 
 	if (amdgpu_sriov_vf(adev)) {
-		sdma_v5_2_ctx_switch_disable_all(adev);
-		sdma_v5_2_halt(adev);
+		sdma_v5_2_ctx_switch_enable(adev, false);
+		sdma_v5_2_enable(adev, false);
 
 		/* set RB registers */
 		r = sdma_v5_2_gfx_resume(adev);
@@ -910,10 +889,12 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 		amdgpu_gfx_off_ctrl(adev, false);
 
 	sdma_v5_2_soft_reset(adev);
+	/* unhalt the MEs */
+	sdma_v5_2_enable(adev, true);
+	/* enable sdma ring preemption */
+	sdma_v5_2_ctx_switch_enable(adev, true);
 
-	/* Soft reset supposes to disable the dma engine and preemption.
-	 * Now start the gfx rings and rlc compute queues.
-	 */
+	/* start the gfx rings and rlc compute queues */
 	r = sdma_v5_2_gfx_resume(adev);
 	if (adev->in_s0ix)
 		amdgpu_gfx_off_ctrl(adev, true);
@@ -1447,8 +1428,8 @@ static int sdma_v5_2_hw_fini(void *handle)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	sdma_v5_2_ctx_switch_disable_all(adev);
-	sdma_v5_2_halt(adev);
+	sdma_v5_2_ctx_switch_enable(adev, false);
+	sdma_v5_2_enable(adev, false);
 
 	return 0;
 }
-- 
2.17.1

