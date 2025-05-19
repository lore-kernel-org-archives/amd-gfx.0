Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60205C54795
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 18:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAAED10E42A;
	Mon, 19 May 2025 18:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mnLt5sF+";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5884E10E410
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 18:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8Y2M6TuwkdZ8p5Q8iTyo1DZC5BsrJ3LS882wyvC7s9ApWCqmk1R0Chvuye5+fR8OFYySuop5f0HRNvrBtbjUcSJdBcfpCJSBu7SUI9sc1ak2yvpi3VagiMElblhCLebywQ8VVp/TX+MYNHThejfZRNO1Yotn41yqEXIEsrCI39JHatuWdBvMFMx5B7/nQIchkcdlyvgGOvez5hdNtzdMkC4OzxmVly41jlaNfsyMthtiDyOqtN1EPLSL/9cgaw9eFDe/3bbW8HurLds/F/1kPwAgZK0r9+mDbGqzupX+Au63u9RU02LtoC53yZOXigmxtC3F5r5W9sctGTYF++RPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZgSK4gN2SWixNFBDaF7Z9G3WRvHV8TOtqGihBcqEkQ=;
 b=CNk/dDKg3TrRIIOTZSglfBm9lpSMShpBylE8hw4y5w5SJj1VkvKUDTdw0H9X+GSypQjVA8ZGQxCpFx+Q9vsIzxBPKEbBaVyptdob28/jPzTDdCxGtVw/3zSCDM5qcGzsodPU+ye65PzTU8Wv0bISZDC3/LB/m4x+sfjYT6hi492DTVvkUAlPndzJJTFKAHDOTUUUySMNrW3bnZ3+mCDwhdlL5f6QVUFmZOR/P3dcj2eigo775+oaNopFGyDH80aELCvXoez/KFQwdvMdWAGjoYzd6fwBGLcklQIhZw9axA+by5pmBrYH1MbaLUMG03BixZWpuzKmaCW2pAgiW5OG3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZgSK4gN2SWixNFBDaF7Z9G3WRvHV8TOtqGihBcqEkQ=;
 b=mnLt5sF+r+ZDTVudX5IPJ4wW2Mpr9brVOt8hHKUE8Prx4Z0dxdlvp23uKlT+RRzN/Qso1Aowst3hjNmHSr2MqnWOOjQWVoQ5HQm3KrgIYZczNed/P8M4H2vAux+F6apKO5UHleHxHTc6HmETINek6j+0RNdjlzZ1un1qt58MsaA=
Received: from MW4PR03CA0306.namprd03.prod.outlook.com (2603:10b6:303:dd::11)
 by SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 18:22:32 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::30) by MW4PR03CA0306.outlook.office365.com
 (2603:10b6:303:dd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.25 via Frontend Transport; Mon,
 19 May 2025 18:22:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 18:22:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 13:22:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 8/8] drm/amdgpu: rework gfx12 queue reset
Date: Mon, 19 May 2025 14:22:09 -0400
Message-ID: <20250519182209.18273-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519182209.18273-1-alexander.deucher@amd.com>
References: <20250519182209.18273-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|SA1PR12MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a27a0e-38b5-4e76-f155-08dd97021e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hrkCEYKTZrsXF4dSV1+luuXW2ATqSgHMdPmwiEMEIgXb7N6yrzWv7pMHmEB4?=
 =?us-ascii?Q?DfVcLRZnSMttrHJ9++t1iDUfai8110grZf9xgx1diCrbo/L9y3aeWTBaxES0?=
 =?us-ascii?Q?aL7oN26EJGVx1H8fOLAl+PJCQQVzl3AUQy8aiikOTKo0gtk4Syl2aeCy7iTF?=
 =?us-ascii?Q?ELLyVulZ1Pf7u+4EQWimg2TaetW/zbXh8X25AIz/ISJcIqFz6wrd6xJ5yt3T?=
 =?us-ascii?Q?pFm8jLRNdNHyrvycgc1/dSNRFROQuwiyCNQ/z0G35gjdFeebdYqIiHMNUokv?=
 =?us-ascii?Q?x9xBy60FSTbA50EwbDr2QmkiF8AHbhPPw3IdVhTrhonV8xBQrIdtUntf7KVz?=
 =?us-ascii?Q?/r0BQv2jJ5JNUjpVoWiVESl0cwNEyAE+GIja/m546xKCWWfBTFh8tQ1R01Y3?=
 =?us-ascii?Q?NBJSS07LSWqtXbeUPxohRGfkLsigDTFyHusT4vcxZ57yPuTP9EHha9eg/QMA?=
 =?us-ascii?Q?gG0pYicDmDy+y7gak+yv89cgOW5nw8GuRw/l7u/0YlYVy7yiTqtc/enwv/En?=
 =?us-ascii?Q?81z78iPmrWtVIQf+Y0afEKxzH3OyRVh8aX4k8UE6aV0l9VpkpfpkS/NmYh90?=
 =?us-ascii?Q?0O4hyedrZAZYhgKNZZW4tFOfVYOPnSwc/eGUZ7lJ+cDsbDGuxXPgti4vh0Th?=
 =?us-ascii?Q?AksepcQAtXvXZBJ7IYXrOCLnqTzUd4zcyuR8+9gMFdAcNwOZzQIw7K8NrgeS?=
 =?us-ascii?Q?KJkjeBaoGZbhkLGC6Ww0O2sb740UjpGqXdNf3AxfuTvaUkPG/TQtHrhSjhua?=
 =?us-ascii?Q?0tB2RCbdCmvpJv/ETgJDbfp+JT5hWrf1bfBO+K0cHxTFRTRM+Tgp5ZlNIZBC?=
 =?us-ascii?Q?FYe/D9CVEF3ZsLy3/icm1OCxF9o4EoGjRhIGzn0i8wmQJOyY42bz/miGSWii?=
 =?us-ascii?Q?05CCT3HnAxt90S/Z800i7uzXKCbAmJvlHde7Vo0RuPSYyavrBHv1sQEmYghc?=
 =?us-ascii?Q?OeFqtlfn12oMjrF5UDYaSZqzujAzx6bKVcLXa/OSO11tHBs6JYxefDVbnY4q?=
 =?us-ascii?Q?PHFoqy7iY5V7mR8731BbGrqgKIYLaBvRIBV3q4dwMZ1/uxfupllu0Gj8BIZQ?=
 =?us-ascii?Q?NfB0/BHz3hIxqsvtxBoU6zdMR/m8hWh6DRNSTSvt8eeRbHVUILJdqv2s//DX?=
 =?us-ascii?Q?OYX3QE9Yg4srtQh/AxEg9P4xRZWenlAcSPjlYh4XEgp9uDX+SWmRjC3gSHPy?=
 =?us-ascii?Q?3jD1lxWiwoRwnCQCH3Ti+pxx8b7yi+ReN53MSa8gpcCKUlEE4EQNI02uWj6O?=
 =?us-ascii?Q?3N1ZrZZ4/Uu9vd52FL6mdkGcJKAGycpXSEULP46EcqIsF3RjrFbNQFOrHGLZ?=
 =?us-ascii?Q?CF6IwMNENF/nozy9SONUzRnkLkPQ3WL06zgZ+RIeW04nkjCsvhvnoalTkOMO?=
 =?us-ascii?Q?VC3JaZxp4hhbpjZq9l5CZA6HjlENZcbLs8uTAHhIvPzyGhIQkF+wKJ1qnxMn?=
 =?us-ascii?Q?SsXLMI5qqsCNu8iFI20w97V9epBi1hDEnSGNaCaIZpzKk85lsaEUBg5A2Lgy?=
 =?us-ascii?Q?8j5dPUq21BUA7lAWucjazxnRFlpxQUdHVXIS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 18:22:31.3592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a27a0e-38b5-4e76-f155-08dd97021e91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659
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

Apply the same changes to gfx12 as done to gfx10.

Background is that we don't use per application kernel queues for
gfx12 on Linux for performance reasons.

So instead use the gfx10 approach here as well and only reset all
submissions from a specific VMID instead of the whole queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 102 ++++++-------------------
 1 file changed, 23 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f09d96bfee16d..ffecbe217d09d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4479,6 +4479,19 @@ static void gfx_v12_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
 	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_GFX) {
+		amdgpu_ring_emit_reg_wait(ring,
+					  SOC15_REG_OFFSET(GC, 0, regCP_VMID_RESET),
+					  0, 0xffff);
+		amdgpu_ring_emit_wreg(ring,
+				      SOC15_REG_OFFSET(GC, 0, regCP_VMID_RESET),
+				      0);
+		amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+				       ring->fence_drv.sync_seq,
+				       AMDGPU_FENCE_FLAG_EXEC);
+	}
 
 	gfx_v12_0_wait_reg_mem(ring, usepfp, 1, 0, lower_32_bits(addr),
 			       upper_32_bits(addr), seq, 0xffffffff, 4);
@@ -5251,91 +5264,22 @@ static bool gfx_v12_pipe_reset_support(struct amdgpu_device *adev)
 	return false;
 }
 
-static int gfx_v12_reset_gfx_pipe(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t reset_pipe = 0, clean_pipe = 0;
-	int r;
-
-	if (!gfx_v12_pipe_reset_support(adev))
-		return -EOPNOTSUPP;
-
-	gfx_v12_0_set_safe_mode(adev, 0);
-	mutex_lock(&adev->srbm_mutex);
-	soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-
-	switch (ring->pipe) {
-	case 0:
-		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
-					   PFP_PIPE0_RESET, 1);
-		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
-					   ME_PIPE0_RESET, 1);
-		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
-					   PFP_PIPE0_RESET, 0);
-		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
-					   ME_PIPE0_RESET, 0);
-		break;
-	case 1:
-		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
-					   PFP_PIPE1_RESET, 1);
-		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
-					   ME_PIPE1_RESET, 1);
-		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
-					   PFP_PIPE1_RESET, 0);
-		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
-					   ME_PIPE1_RESET, 0);
-		break;
-	default:
-		break;
-	}
-
-	WREG32_SOC15(GC, 0, regCP_ME_CNTL, reset_pipe);
-	WREG32_SOC15(GC, 0, regCP_ME_CNTL, clean_pipe);
-
-	r = (RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_INSTR_PNTR1)) << 2) -
-					RS64_FW_UC_START_ADDR_LO;
-	soc24_grbm_select(adev, 0, 0, 0, 0);
-	mutex_unlock(&adev->srbm_mutex);
-	gfx_v12_0_unset_safe_mode(adev, 0);
-
-	dev_info(adev->dev, "The ring %s pipe reset: %s\n", ring->name,
-			r == 0 ? "successfully" : "failed");
-	/* Sometimes the ME start pc counter can't cache correctly, so the
-	 * PC check only as a reference and pipe reset result rely on the
-	 * later ring test.
-	 */
-	return 0;
-}
-
 static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
+	u32 tmp;
 	int r;
 
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
-
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
-	if (r) {
-		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
-		r = gfx_v12_reset_gfx_pipe(ring);
-		if (r)
-			return r;
-	}
-
-	r = gfx_v12_0_kgq_init_queue(ring, true);
-	if (r) {
-		dev_err(adev->dev, "failed to init kgq\n");
-		return r;
-	}
-
-	r = amdgpu_mes_map_legacy_queue(adev, ring);
-	if (r) {
-		dev_err(adev->dev, "failed to remap kgq\n");
+	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
+	r = amdgpu_mes_wreg(adev, SOC15_REG_OFFSET(GC, 0, regCP_VMID_RESET), tmp);
+	if (r)
 		return r;
-	}
+	if (amdgpu_ring_alloc(ring, 7 + 7 + 5 + 8))
+		return -ENOMEM;
+	gfx_v12_0_ring_emit_pipeline_sync(ring);
+	amdgpu_ring_commit(ring);
 
-	return amdgpu_ring_test_ring(ring);
+	return gfx_v12_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -5495,7 +5439,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.set_wptr = gfx_v12_0_ring_set_wptr_gfx,
 	.emit_frame_size = /* totally 242 maximum if 16 IBs */
 		5 + /* COND_EXEC */
-		7 + /* PIPELINE_SYNC */
+		7 + 7 + 5 + 8 + /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* VM_FLUSH */
-- 
2.49.0

