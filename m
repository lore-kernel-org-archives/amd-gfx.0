Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E612C79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 14:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD6A310EC3B;
	Tue,  8 Sep 2026 14:45:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="njg+dLm4";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013028.outbound.protection.outlook.com
 [40.107.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F0A210EC3B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 14:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfpzCL9LwK3kevwKXI1coailn8Q448pWSrSmFYbAvd/7PwKRagHFM1xZSmJ8FT+C1nXLhfcYqPg2tZKtdIN7o5eqzFus3ZSweEFjCLouFZOkyJW13LYgtyzUpNsfh+rZDJziLn9HP8zmkhwGtPVuX6Eg6f3RhqLO43IxQf8J5REshPMvIi0W9dRak0PPgt8PuJoM/ODhfF/zsU7enmrNonZmL+1ys5Gdly1uD7O5j3CsmBPYhPzOr9zoqvRK436uiMzlo7+0smJLTb9sx3dgvW+3gtvZGQ9OjLmKlG+ub5e4fxSc13pvOU41aHgYzUhNrToclpHCModPPZSnheYBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0Tk8y+qcCJtM4MlHHGz9+mrxn5Ub9tcgHSD5YpoZkc=;
 b=yIoo14Z5JGOOt39WZWTQjq5Tv1hkGARgkfxjLtPqQg6kONPybro8nULbyp50Pj/7EGXcgzO55TRnpSrx9fncktKUZTHoeRCEP3rfdWturRRhvD90TwTNQDQwBHPg7co7hiSVmTRK7P+a0p+AQkS5jKgtoBEu3mBxeHxhRJUj/0PbAgus8BKpl5ECEYCBHL8DM3BhWBiXtEORo8ao1BJTUY/bWpSVrYc3nOHUTvF6cLit+1j1mOhMMAT3uPtFlS39ebnVnnvpAA0AALAakea2Q0v0gQC03j/PX9K5TmdxBR4Puy7kItm87GJkvx6tPIi4Gj5mou/f4EaZF90LjImuwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0Tk8y+qcCJtM4MlHHGz9+mrxn5Ub9tcgHSD5YpoZkc=;
 b=njg+dLm4N5ojJRIpFmF03BdFO5rDkRF4PMAwmlPaZXXVqNQKKXQtlfOtUstvVC015DDtbFfWl/ksaENkYexeCIqKFIjFQYu37DslS2BSCSys02iZ3Ln1opHJeRXvitWYv5ui0NGaNbW7rbxbAdKTfNkp1eTLPGV/UGCGfSvVxAw=
Received: from SJ0PR13CA0146.namprd13.prod.outlook.com (2603:10b6:a03:2c6::31)
 by IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 14:45:22 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::e8) by SJ0PR13CA0146.outlook.office365.com
 (2603:10b6:a03:2c6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 14:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 14:45:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 09:45:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 09:45:20 -0500
Received: from jenkins-5800x.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 09:45:19 -0500
From: Horatio Zhang <hongkun.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Horatio Zhang <hongkun.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: retire the legacy MES design for GFX 12.1
Date: Tue, 8 Sep 2026 22:45:18 +0800
Message-ID: <20260908144518.1392218-1-hongkun.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2f0242-ed17-4038-1162-08df0db7cf21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|6133799003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: ihvGsk/KKMTKudH7Pbk+swbzogAcNv3lFKMH/P9ExUQia1PL5kRhmLjYSToleA3JY2KUo3s7pDfcT78pTWfabgPnGUr5L3F/xcMVnKVzgp6eWSDnNb0/Iskq57lBqFTduWFeWcR5CECzSnFfN1tjGmlkNXRE/HxjhthxgTa+90n+NtEVmTNGcvZusPhGnaEs0mm38cP99Iq/GVO37PH/W4kF8dsuNRa4b6g52hnZS+dtE1WJWXOA1YU/QrP4bmBGZQuK9HsUGEsgDkc+KAsOL4ZmQnhvLOBUkt29iqcCmSHzZFNWFg4QHceo/3iBzupnRf7Fibei3fgyphmzJji3Ouuo5L+Tp/+6i4sQgC9Ys5L4jny60+HKMlX6qEoRKvswVgq2zq9FdNqR8oMVL4xG3oNlTy8R3taBam0xRT9avIl/68kIFEAdnBWVHvGUS8wRii16ae5XLeuy5Tyd34/3Cy2HyTpCrhFxXFiWfkFeP8krgnqiWgVGa0dxiTBqoRvYvRBx0kN/R9FLlrZmGjWB94McfgpQAAov7+oyJxiIwAHIk9hJna+W8MJzPy84aPB8gdBig6YPO4adKBbnUIN1MnE8PyyZUwtXoyTov3i1eUA9I5yC96iSwZX4R1SEG13VcJ5AEpBtDr6RzWMc0L/d4stfI1tvUWUniLme5pVe6Uhx5InLtFR1izaZC5U4w2yIJtm/qYSGKsLaqKmBzhfpCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(6133799003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5OwGvbMdlCKJv6dSn5J1WeReGl5CvK5I6TmN7tG1Xeyp49BQQ9r71Rg1oenN+FUPUsNV2b1pd6lqgaAdxzlW2flbVcjWq8P8bkVboi8BewD/ER9r6tMoqHT3VuBaBDi6RivrtGXsfU7FRXPj4eYRSxoyZSZqAcotW1sVsgyhv668vjLQmRfbrmmdMw55fXJs+Uv8ds0qw/jAsQ7rhgcI5iE8ds+aA6IqV6y+3RfSm6I+0iQZ3R5UStd6/FxoNE570SPG/EKg007KXCgHbPRtFYO0O/k6dTypRcSz+iTAEXp8y0/4toaiBm37tiHOLl4tl1BHPr2nIkxg3jawPGCVojUbQS4UYUytNlv4XICGrPTIn5MJSQlkCSo5E1JiiRT5B6yrGGvPPPbi1anoShYz4BLzvI6mYgdPgVs14b0fJD7KQ2NeFk+H6eHbrUq59Y/w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 14:45:21.4281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2f0242-ed17-4038-1162-08df0db7cf21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696
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

Retire the legacy design, always enable unified MES on GFX 12.1 and drop
the driver code and MODULE_FIRMWARE entries that only served the legacy
path.

Signed-off-by: Horatio Zhang <hongkun.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  11 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c        | 475 +-----------------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c        |   9 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        | 246 ++-------
 5 files changed, 57 insertions(+), 687 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 7710a8ed3d44..1420bb60e015 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -3281,8 +3281,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &mes_v12_1_ip_block);
 		adev->enable_mes = true;
 		adev->enable_mes_kiq = true;
-		if (amdgpu_uni_mes)
-			adev->enable_uni_mes = true;
+		adev->enable_uni_mes = true;
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a6f95ff47d24..7a132e6d7e42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1235,7 +1235,8 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_
 	if (adev->mes.ring[0].sched.ready)
 		return amdgpu_mes_rreg(adev, reg, xcc_id);
 
-	BUG_ON(!ring->funcs->emit_rreg);
+	if (!ring->funcs || !ring->funcs->emit_rreg)
+		goto failed_kiq_read;
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	if (amdgpu_wb_get(adev, &reg_val_offs)) {
@@ -1303,8 +1304,6 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *ring = &kiq->ring;
 
-	BUG_ON(!ring->funcs->emit_wreg);
-
 	if (amdgpu_device_skip_hw_access(adev))
 		return;
 
@@ -1313,6 +1312,9 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 		return;
 	}
 
+	if (!ring->funcs || !ring->funcs->emit_wreg)
+		goto failed_kiq_write;
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	r = amdgpu_ring_alloc(ring, 32);
 	if (r)
@@ -1409,9 +1411,8 @@ int amdgpu_kiq_hdp_flush(struct amdgpu_device *adev)
 	if (adev->enable_mes_kiq && adev->mes.ring[0].sched.ready)
 		return amdgpu_mes_hdp_flush(adev);
 
-	if (!ring->funcs->emit_hdp_flush) {
+	if (!ring->funcs || !ring->funcs->emit_hdp_flush)
 		return -EOPNOTSUPP;
-	}
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	r = amdgpu_ring_alloc(ring, 32);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index f812d6d81e9c..d7effa43c0fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -203,12 +203,7 @@ static int gfx_v12_1_get_cu_info(struct amdgpu_device *adev,
 static uint64_t gfx_v12_1_get_gpu_clock_counter(struct amdgpu_device *adev);
 static void gfx_v12_1_xcc_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 				       u32 sh_num, u32 instance, int xcc_id);
-static void gfx_v12_1_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
-				     uint32_t val);
 static int gfx_v12_1_wait_for_rlc_autoload_complete(struct amdgpu_device *adev);
-static void gfx_v12_1_ring_invalidate_tlbs(struct amdgpu_ring *ring,
-					   uint16_t pasid, uint32_t flush_type,
-					   bool all_hub, uint8_t dst_sel);
 static void gfx_v12_1_xcc_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v12_1_xcc_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v12_1_update_perf_clk(struct amdgpu_device *adev,
@@ -219,142 +214,6 @@ static int gfx_v12_1_init_cp_compute_microcode_bo(struct amdgpu_device *adev);
 static void gfx_v12_1_xcc_update_medium_grain_clock_gating(
 	struct amdgpu_device *adev, bool enable, int xcc_id, bool force);
 
-static void gfx_v12_1_kiq_set_resources(struct amdgpu_ring *kiq_ring,
-					uint64_t queue_mask)
-{
-	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
-	amdgpu_ring_write(kiq_ring, PACKET3_SET_RESOURCES_VMID_MASK(0) |
-			  PACKET3_SET_RESOURCES_QUEUE_TYPE(0));	/* vmid_mask:0 queue_type:0 (KIQ) */
-	amdgpu_ring_write(kiq_ring, lower_32_bits(queue_mask));	/* queue mask lo */
-	amdgpu_ring_write(kiq_ring, upper_32_bits(queue_mask));	/* queue mask hi */
-	amdgpu_ring_write(kiq_ring, 0);	/* gws mask lo */
-	amdgpu_ring_write(kiq_ring, 0);	/* gws mask hi */
-	amdgpu_ring_write(kiq_ring, 0);	/* oac mask */
-	amdgpu_ring_write(kiq_ring, 0);
-}
-
-static void gfx_v12_1_kiq_map_queues(struct amdgpu_ring *kiq_ring,
-				     struct amdgpu_ring *ring)
-{
-	uint64_t mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
-	uint64_t wptr_addr = ring->wptr_gpu_addr;
-	uint32_t me = 0, eng_sel = 0;
-
-	switch (ring->funcs->type) {
-	case AMDGPU_RING_TYPE_COMPUTE:
-		me = 1;
-		eng_sel = 0;
-		break;
-	case AMDGPU_RING_TYPE_MES:
-		me = 2;
-		eng_sel = 5;
-		break;
-	default:
-		WARN_ON(1);
-	}
-
-	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
-	/* Q_sel:0, vmid:0, vidmem: 1, engine:0, num_Q:1*/
-	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
-			  PACKET3_MAP_QUEUES_QUEUE_SEL(0) | /* Queue_Sel */
-			  PACKET3_MAP_QUEUES_VMID(0) | /* VMID */
-			  PACKET3_MAP_QUEUES_QUEUE(ring->queue) |
-			  PACKET3_MAP_QUEUES_PIPE(ring->pipe) |
-			  PACKET3_MAP_QUEUES_ME((me)) |
-			  PACKET3_MAP_QUEUES_QUEUE_TYPE(0) | /*queue_type: normal compute queue */
-			  PACKET3_MAP_QUEUES_ENGINE_SEL(eng_sel) |
-			  PACKET3_MAP_QUEUES_NUM_QUEUES(1)); /* num_queues: must be 1 */
-	amdgpu_ring_write(kiq_ring, PACKET3_MAP_QUEUES_DOORBELL_OFFSET(ring->doorbell_index));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(mqd_addr));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(mqd_addr));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(wptr_addr));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(wptr_addr));
-}
-
-static void gfx_v12_1_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
-				       struct amdgpu_ring *ring,
-				       enum amdgpu_unmap_queues_action action,
-				       u64 gpu_addr, u64 seq)
-{
-	struct amdgpu_device *adev = kiq_ring->adev;
-	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
-
-	if (adev->enable_mes && !adev->gfx.kiq[0].ring.sched.ready) {
-		amdgpu_mes_unmap_legacy_queue(adev, ring, action, gpu_addr,
-					      seq, kiq_ring->xcc_id);
-		return;
-	}
-
-	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_UNMAP_QUEUES, 4));
-	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
-			  PACKET3_UNMAP_QUEUES_ACTION(action) |
-			  PACKET3_UNMAP_QUEUES_QUEUE_SEL(0) |
-			  PACKET3_UNMAP_QUEUES_ENGINE_SEL(eng_sel) |
-			  PACKET3_UNMAP_QUEUES_NUM_QUEUES(1));
-	amdgpu_ring_write(kiq_ring,
-		  PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(ring->doorbell_index));
-
-	if (action == PREEMPT_QUEUES_NO_UNMAP) {
-		amdgpu_ring_write(kiq_ring, lower_32_bits(gpu_addr));
-		amdgpu_ring_write(kiq_ring, upper_32_bits(gpu_addr));
-		amdgpu_ring_write(kiq_ring, seq);
-	} else {
-		amdgpu_ring_write(kiq_ring, 0);
-		amdgpu_ring_write(kiq_ring, 0);
-		amdgpu_ring_write(kiq_ring, 0);
-	}
-}
-
-static void gfx_v12_1_kiq_query_status(struct amdgpu_ring *kiq_ring,
-				       struct amdgpu_ring *ring,
-				       u64 addr, u64 seq)
-{
-	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
-
-	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_QUERY_STATUS, 5));
-	amdgpu_ring_write(kiq_ring,
-			  PACKET3_QUERY_STATUS_CONTEXT_ID(0) |
-			  PACKET3_QUERY_STATUS_INTERRUPT_SEL(0) |
-			  PACKET3_QUERY_STATUS_COMMAND(2));
-	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
-			  PACKET3_QUERY_STATUS_DOORBELL_OFFSET(ring->doorbell_index) |
-			  PACKET3_QUERY_STATUS_ENG_SEL(eng_sel));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(addr));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(addr));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(seq));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(seq));
-}
-
-static void gfx_v12_1_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
-					  uint16_t pasid,
-					  uint32_t flush_type,
-					  bool all_hub)
-{
-	gfx_v12_1_ring_invalidate_tlbs(kiq_ring, pasid, flush_type, all_hub, 1);
-}
-
-static const struct kiq_pm4_funcs gfx_v12_1_kiq_pm4_funcs = {
-	.kiq_set_resources = gfx_v12_1_kiq_set_resources,
-	.kiq_map_queues = gfx_v12_1_kiq_map_queues,
-	.kiq_unmap_queues = gfx_v12_1_kiq_unmap_queues,
-	.kiq_query_status = gfx_v12_1_kiq_query_status,
-	.kiq_invalidate_tlbs = gfx_v12_1_kiq_invalidate_tlbs,
-	.set_resources_size = 8,
-	.map_queues_size = 7,
-	.unmap_queues_size = 6,
-	.query_status_size = 7,
-	.invalidate_tlbs_size = 2,
-};
-
-static void gfx_v12_1_set_kiq_pm4_funcs(struct amdgpu_device *adev)
-{
-	int i, num_xcc;
-
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	for (i =0; i < num_xcc; i++)
-		adev->gfx.kiq[i].pmf = &gfx_v12_1_kiq_pm4_funcs;
-}
-
 static void gfx_v12_1_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 				   int mem_space, int opt, uint32_t addr0,
 				   uint32_t addr1, uint32_t ref,
@@ -403,14 +262,9 @@ static int gfx_v12_1_ring_test_ring(struct amdgpu_ring *ring)
 		return r;
 	}
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
-		gfx_v12_1_ring_emit_wreg(ring, xcc_offset, 0xDEADBEEF);
-	} else {
-		amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
-		amdgpu_ring_write(ring, xcc_offset -
-				  PACKET3_SET_UCONFIG_REG_START);
-		amdgpu_ring_write(ring, 0xDEADBEEF);
-	}
+	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
+	amdgpu_ring_write(ring, xcc_offset - PACKET3_SET_UCONFIG_REG_START);
+	amdgpu_ring_write(ring, 0xDEADBEEF);
 	amdgpu_ring_commit(ring);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
@@ -439,11 +293,6 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	volatile uint32_t *cpu_ptr;
 	long r;
 
-	/* MES KIQ fw hasn't indirect buffer support for now */
-	if (adev->enable_mes_kiq &&
-	    ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
-		return 0;
-
 	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
@@ -1538,18 +1387,6 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 			}
 		}
 
-		if (!adev->enable_mes_kiq) {
-			r = amdgpu_gfx_kiq_init(adev, GFX12_MEC_HPD_SIZE, xcc_id);
-			if (r) {
-				dev_err(adev->dev, "Failed to init KIQ BOs!\n");
-				return r;
-			}
-
-			r = amdgpu_gfx_kiq_init_ring(adev, xcc_id);
-			if (r)
-				return r;
-		}
-
 		r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v12_1_compute_mqd), xcc_id);
 		if (r)
 			return r;
@@ -1600,15 +1437,9 @@ static int gfx_v12_1_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->gfx.num_compute_rings * num_xcc; i++)
 		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
 
-	for (i = 0; i < num_xcc; i++) {
+	for (i = 0; i < num_xcc; i++)
 		amdgpu_gfx_mqd_sw_fini(adev, i);
 
-		if (!adev->enable_mes_kiq) {
-			amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq[i].ring);
-			amdgpu_gfx_kiq_fini(adev, i);
-		}
-	}
-
 	gfx_v12_1_rlc_fini(adev);
 	gfx_v12_1_mec_fini(adev);
 
@@ -2193,8 +2024,6 @@ static void gfx_v12_1_xcc_cp_compute_enable(struct amdgpu_device *adev,
 						 enable ? 0 : 1);
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_RS64_CNTL, data);
 
-	adev->gfx.kiq[xcc_id].ring.sched.ready = enable;
-
 	udelay(50);
 }
 
@@ -2357,21 +2186,6 @@ static int gfx_v12_1_xcc_cp_compute_load_microcode_rs64(struct amdgpu_device *ad
 	return 0;
 }
 
-static void gfx_v12_1_xcc_kiq_setting(struct amdgpu_ring *ring,
-				      int xcc_id)
-{
-	uint32_t tmp;
-	struct amdgpu_device *adev = ring->adev;
-
-	/* tell RLC which is KIQ queue */
-	tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS);
-	tmp &= 0xffffff00;
-	tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS, tmp);
-	tmp |= 0x80;
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS, tmp);
-}
-
 static void gfx_v12_1_xcc_cp_set_doorbell_range(struct amdgpu_device *adev,
 						int xcc_id)
 {
@@ -2527,149 +2341,6 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
-static int gfx_v12_1_xcc_kiq_init_register(struct amdgpu_ring *ring,
-					   int xcc_id)
-{
-	struct amdgpu_device *adev = ring->adev;
-	struct v12_1_compute_mqd *mqd = ring->mqd_ptr;
-	int j;
-
-	/* inactivate the queue */
-	if (amdgpu_sriov_vf(adev))
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE, 0);
-
-	/* disable wptr polling */
-	WREG32_FIELD15_PREREG(GC, GET_INST(GC, xcc_id), CP_PQ_WPTR_POLL_CNTL, EN, 0);
-
-	/* write the EOP addr */
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_EOP_BASE_ADDR,
-	       mqd->cp_hqd_eop_base_addr_lo);
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_EOP_BASE_ADDR_HI,
-	       mqd->cp_hqd_eop_base_addr_hi);
-
-	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_EOP_CONTROL,
-	       mqd->cp_hqd_eop_control);
-
-	/* enable doorbell? */
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CONTROL,
-	       mqd->cp_hqd_pq_doorbell_control);
-
-	/* disable the queue if it's active */
-	if (RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE) & 1) {
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_DEQUEUE_REQUEST, 1);
-		for (j = 0; j < adev->usec_timeout; j++) {
-			if (!(RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE) & 1))
-				break;
-			udelay(1);
-		}
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_DEQUEUE_REQUEST,
-		       mqd->cp_hqd_dequeue_request);
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_RPTR,
-		       mqd->cp_hqd_pq_rptr);
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_LO,
-		       mqd->cp_hqd_pq_wptr_lo);
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_HI,
-		       mqd->cp_hqd_pq_wptr_hi);
-	}
-
-	/* set the pointer to the MQD */
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MQD_BASE_ADDR,
-	       mqd->cp_mqd_base_addr_lo);
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MQD_BASE_ADDR_HI,
-	       mqd->cp_mqd_base_addr_hi);
-
-	/* set MQD vmid to 0 */
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MQD_CONTROL,
-	       mqd->cp_mqd_control);
-
-	/* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_BASE,
-	       mqd->cp_hqd_pq_base_lo);
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_BASE_HI,
-	       mqd->cp_hqd_pq_base_hi);
-
-	/* set up the HQD, this is similar to CP_RB0_CNTL */
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_CONTROL,
-	       mqd->cp_hqd_pq_control);
-
-	/* set the wb address whether it's enabled or not */
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_RPTR_REPORT_ADDR,
-		mqd->cp_hqd_pq_rptr_report_addr_lo);
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_RPTR_REPORT_ADDR_HI,
-		mqd->cp_hqd_pq_rptr_report_addr_hi);
-
-	/* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MASK=1 */
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_POLL_ADDR,
-	       mqd->cp_hqd_pq_wptr_poll_addr_lo);
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_POLL_ADDR_HI,
-	       mqd->cp_hqd_pq_wptr_poll_addr_hi);
-
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CONTROL,
-	       mqd->cp_hqd_pq_doorbell_control);
-
-	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_LO,
-	       mqd->cp_hqd_pq_wptr_lo);
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_HI,
-	       mqd->cp_hqd_pq_wptr_hi);
-
-	/* set the vmid for the queue */
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_VMID, mqd->cp_hqd_vmid);
-
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PERSISTENT_STATE,
-	       mqd->cp_hqd_persistent_state);
-
-	/* activate the queue */
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE,
-	       mqd->cp_hqd_active);
-
-	if (ring->use_doorbell)
-		WREG32_FIELD15_PREREG(GC, GET_INST(GC, xcc_id), CP_PQ_STATUS, DOORBELL_ENABLE, 1);
-
-	return 0;
-}
-
-static int gfx_v12_1_xcc_kiq_init_queue(struct amdgpu_ring *ring,
-					int xcc_id)
-{
-	struct amdgpu_device *adev = ring->adev;
-	struct v12_1_compute_mqd *mqd = ring->mqd_ptr;
-
-	gfx_v12_1_xcc_kiq_setting(ring, xcc_id);
-
-	if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
-		/* reset MQD to a clean status */
-		if (adev->gfx.kiq[xcc_id].mqd_backup)
-			memcpy(mqd, adev->gfx.kiq[xcc_id].mqd_backup, sizeof(*mqd));
-
-		/* reset ring buffer */
-		ring->wptr = 0;
-		amdgpu_ring_clear_ring(ring);
-
-		mutex_lock(&adev->srbm_mutex);
-		soc_v1_0_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, GET_INST(GC, xcc_id));
-		gfx_v12_1_xcc_kiq_init_register(ring, xcc_id);
-		soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
-		mutex_unlock(&adev->srbm_mutex);
-	} else {
-		memset((void *)mqd, 0, sizeof(*mqd));
-		if (amdgpu_sriov_vf(adev) && adev->in_suspend)
-			amdgpu_ring_clear_ring(ring);
-		mutex_lock(&adev->srbm_mutex);
-		soc_v1_0_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, GET_INST(GC, xcc_id));
-		amdgpu_ring_init_mqd(ring);
-		gfx_v12_1_xcc_kiq_init_register(ring, xcc_id);
-		soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
-		mutex_unlock(&adev->srbm_mutex);
-
-		if (adev->gfx.kiq[xcc_id].mqd_backup)
-			memcpy(adev->gfx.kiq[xcc_id].mqd_backup, mqd, sizeof(*mqd));
-	}
-
-	return 0;
-}
-
 static int gfx_v12_1_xcc_kcq_init_queue(struct amdgpu_ring *ring,
 					int xcc_id)
 {
@@ -2700,32 +2371,6 @@ static int gfx_v12_1_xcc_kcq_init_queue(struct amdgpu_ring *ring,
 	return 0;
 }
 
-static int gfx_v12_1_xcc_kiq_resume(struct amdgpu_device *adev,
-				    int xcc_id)
-{
-	struct amdgpu_ring *ring;
-	int r;
-
-	ring = &adev->gfx.kiq[xcc_id].ring;
-
-	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-	if (unlikely(r != 0))
-		return r;
-
-	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (unlikely(r != 0)) {
-		amdgpu_bo_unreserve(ring->mqd_obj);
-		return r;
-	}
-
-	gfx_v12_1_xcc_kiq_init_queue(ring, xcc_id);
-	amdgpu_bo_kunmap(ring->mqd_obj);
-	ring->mqd_ptr = NULL;
-	amdgpu_bo_unreserve(ring->mqd_obj);
-	ring->sched.ready = true;
-	return 0;
-}
-
 static int gfx_v12_1_xcc_kcq_resume(struct amdgpu_device *adev,
 				    int xcc_id)
 {
@@ -2762,6 +2407,9 @@ static int gfx_v12_1_xcc_cp_resume(struct amdgpu_device *adev, uint16_t xcc_mask
 	int r, i, xcc_id;
 	struct amdgpu_ring *ring;
 
+	if (!adev->mes.kiq_hw_init)
+		return -EINVAL;
+
 	for_each_inst(xcc_id, xcc_mask) {
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 			/* legacy firmware loading */
@@ -2779,19 +2427,7 @@ static int gfx_v12_1_xcc_cp_resume(struct amdgpu_device *adev, uint16_t xcc_mask
 
 		gfx_v12_1_xcc_cp_compute_enable(adev, true, xcc_id);
 
-		if (adev->enable_mes_kiq && adev->mes.kiq_hw_init) {
-			r = amdgpu_mes_kiq_hw_init(adev, xcc_id);
-			/*
-			 * With MES, GFX KIQ ring is owned by the MES and is never
-			 * initialized/used directly by the driver, so it must
-			 * not be left flagged as ready. mes_v12_0_hw_init() clears
-			 * but clear here if MES init fails
-			 */
-			if (r)
-				adev->gfx.kiq[xcc_id].ring.sched.ready = false;
-		} else {
-			r = gfx_v12_1_xcc_kiq_resume(adev, xcc_id);
-		}
+		r = amdgpu_mes_kiq_hw_init(adev, xcc_id);
 		if (r)
 			return r;
 
@@ -3184,7 +2820,6 @@ static int gfx_v12_1_early_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 						  AMDGPU_MAX_COMPUTE_RINGS);
 
-	gfx_v12_1_set_kiq_pm4_funcs(adev);
 	gfx_v12_1_set_ring_funcs(adev);
 	gfx_v12_1_set_irq_funcs(adev);
 	gfx_v12_1_set_rlc_funcs(adev);
@@ -3685,18 +3320,6 @@ static void gfx_v12_1_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 			       upper_32_bits(addr), seq, 0xffffffff, 4);
 }
 
-static void gfx_v12_1_ring_invalidate_tlbs(struct amdgpu_ring *ring,
-				   uint16_t pasid, uint32_t flush_type,
-				   bool all_hub, uint8_t dst_sel)
-{
-	amdgpu_ring_write(ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
-	amdgpu_ring_write(ring,
-			  PACKET3_INVALIDATE_TLBS_DST_SEL(dst_sel) |
-			  PACKET3_INVALIDATE_TLBS_ALL_HUB(all_hub) |
-			  PACKET3_INVALIDATE_TLBS_PASID(pasid) |
-			  PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
-}
-
 static void gfx_v12_1_ring_emit_vm_flush(struct amdgpu_ring *ring,
 					 unsigned vmid, uint64_t pd_addr)
 {
@@ -3705,65 +3328,14 @@ static void gfx_v12_1_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	/* compute doesn't have PFP */
 }
 
-static void gfx_v12_1_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
-					  u64 seq, unsigned int flags)
-{
-	struct amdgpu_device *adev = ring->adev;
-
-	/* write fence seq to the "addr" */
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-	amdgpu_ring_write(ring, (PACKET3_WRITE_DATA__DST_SEL(5) | PACKET3_WRITE_DATA__WR_CONFIRM(1)));
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
-	amdgpu_ring_write(ring, lower_32_bits(seq));
-
-	if (flags & AMDGPU_FENCE_FLAG_INT) {
-		/* set register to trigger INT */
-		amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-		amdgpu_ring_write(ring, (PACKET3_WRITE_DATA__DST_SEL(0) | PACKET3_WRITE_DATA__WR_CONFIRM(1)));
-		amdgpu_ring_write(ring, SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regCPC_INT_STATUS));
-		amdgpu_ring_write(ring, 0);
-		amdgpu_ring_write(ring, 0x20000000); /* src_id is 178 */
-	}
-}
-
-static void gfx_v12_1_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
-				     uint32_t reg_val_offs)
-{
-	struct amdgpu_device *adev = ring->adev;
-
-	reg = soc_v1_0_normalize_xcc_reg_offset(reg);
-
-	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
-	amdgpu_ring_write(ring, 0 |	/* src: register*/
-				(5 << 8) |	/* dst: memory */
-				(1 << 20));	/* write confirm */
-	amdgpu_ring_write(ring, reg);
-	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				reg_val_offs * 4));
-	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				reg_val_offs * 4));
-}
-
 static void gfx_v12_1_ring_emit_wreg(struct amdgpu_ring *ring,
 				     uint32_t reg,
 				     uint32_t val)
 {
-	uint32_t cmd = 0;
-
 	reg = soc_v1_0_normalize_xcc_reg_offset(reg);
 
-	switch (ring->funcs->type) {
-	case AMDGPU_RING_TYPE_KIQ:
-		cmd = (1 << 16); /* no inc addr */
-		break;
-	default:
-		cmd = PACKET3_WRITE_DATA__WR_CONFIRM(1);
-		break;
-	}
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-	amdgpu_ring_write(ring, cmd);
+	amdgpu_ring_write(ring, PACKET3_WRITE_DATA__WR_CONFIRM(1));
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
 	amdgpu_ring_write(ring, val);
@@ -4157,41 +3729,12 @@ static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_compute = {
 	.emit_mem_sync = gfx_v12_1_emit_mem_sync,
 };
 
-static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_kiq = {
-	.type = AMDGPU_RING_TYPE_KIQ,
-	.align_mask = 0xff,
-	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
-	.support_64bit_ptrs = true,
-	.get_rptr = gfx_v12_1_ring_get_rptr_compute,
-	.get_wptr = gfx_v12_1_ring_get_wptr_compute,
-	.set_wptr = gfx_v12_1_ring_set_wptr_compute,
-	.emit_frame_size =
-		7 + /* gfx_v12_1_ring_emit_pipeline_sync */
-		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
-		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* gfx_v12_1_ring_emit_vm_flush */
-		8 + 8 + 8, /* gfx_v12_1_ring_emit_fence_kiq x3 for user fence, vm fence */
-	.emit_ib_size =	7, /* gfx_v12_1_ring_emit_ib_compute */
-	.emit_ib = gfx_v12_1_ring_emit_ib_compute,
-	.emit_fence = gfx_v12_1_ring_emit_fence_kiq,
-	.test_ring = gfx_v12_1_ring_test_ring,
-	.test_ib = gfx_v12_1_ring_test_ib,
-	.insert_nop = amdgpu_ring_insert_nop,
-	.pad_ib = amdgpu_ring_generic_pad_ib,
-	.emit_rreg = gfx_v12_1_ring_emit_rreg,
-	.emit_wreg = gfx_v12_1_ring_emit_wreg,
-	.emit_reg_wait = gfx_v12_1_ring_emit_reg_wait,
-	.emit_reg_write_reg_wait = gfx_v12_1_ring_emit_reg_write_reg_wait,
-};
-
 static void gfx_v12_1_set_ring_funcs(struct amdgpu_device *adev)
 {
 	int i, j, num_xcc;
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
-		adev->gfx.kiq[i].ring.funcs = &gfx_v12_1_ring_funcs_kiq;
-
 		for (j = 0; j < adev->gfx.num_compute_rings; j++)
 			adev->gfx.compute_ring[j + i * adev->gfx.num_compute_rings].funcs =
 						&gfx_v12_1_ring_funcs_compute;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 565ee7fba3cd..3349e8bc1c20 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -407,9 +407,8 @@ static void gmc_v12_1_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* This is necessary for SRIOV as well as for GFXOFF to function
 	 * properly under bare metal
 	 */
-	if (((adev->gfx.kiq[inst].ring.sched.ready ||
-	      adev->mes.ring[MES_PIPE_INST(inst, 0)].sched.ready) &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)))) {
+	if (adev->mes.ring[MES_PIPE_INST(inst, 0)].sched.ready &&
+	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 		const unsigned eng = 17;
 		u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
@@ -432,7 +431,7 @@ static void gmc_v12_1_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
  * @pasid: pasid to be flush
  * @flush_type: the flush type
  * @all_hub: flush all hubs
- * @inst: is used to select which instance of KIQ to use for the invalidation
+ * @inst: XCC instance to use for the invalidation
  *
  * Flush the TLB for the requested pasid.
  */
@@ -443,7 +442,7 @@ static void gmc_v12_1_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint16_t queried;
 	int vmid, i;
 
-	if (adev->enable_uni_mes && adev->mes.ring[0].sched.ready &&
+	if (adev->mes.ring[0].sched.ready &&
 	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x6f) {
 		struct mes_inv_tlbs_pasid_input input = {0};
 		input.xcc_id = inst;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index c827eb46058a..a69f9b9c5cd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -34,8 +34,6 @@
 #include "gfx_v12_1_pkt.h"
 #include "sdma_v7_1_0_pkt_open.h"
 
-MODULE_FIRMWARE("amdgpu/gc_12_1_0_mes.bin");
-MODULE_FIRMWARE("amdgpu/gc_12_1_0_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_1_0_uni_mes.bin");
 
 static int mes_v12_1_hw_init(struct amdgpu_ip_block *ip_block);
@@ -414,15 +412,11 @@ static int mes_v12_1_map_legacy_queue(struct amdgpu_mes *mes,
 		convert_to_mes_queue_type(input->queue_type);
 	mes_add_queue_pkt.map_legacy_kq = 1;
 
-	if (mes->adev->enable_uni_mes) {
-		/* Keep scheduler queue on KIQ pipe; map all other kernel queues on sched pipe. */
-		if (input->queue_type == AMDGPU_RING_TYPE_MES)
-			pipe = AMDGPU_MES_KIQ_PIPE;
-		else
-			pipe = AMDGPU_MES_SCHED_PIPE;
-	} else {
+	/* Keep scheduler queue on KIQ pipe; map all other kernel queues on sched pipe. */
+	if (input->queue_type == AMDGPU_RING_TYPE_MES)
+		pipe = AMDGPU_MES_KIQ_PIPE;
+	else
 		pipe = AMDGPU_MES_SCHED_PIPE;
-	}
 
 	return mes_v12_1_submit_pkt_and_poll_completion(mes,
 			input->xcc_id, pipe,
@@ -459,15 +453,11 @@ static int mes_v12_1_unmap_legacy_queue(struct amdgpu_mes *mes,
 			convert_to_mes_queue_type(input->queue_type);
 	}
 
-	if (mes->adev->enable_uni_mes) {
-		/* Keep scheduler queue on KIQ pipe; map all other kernel queues on sched pipe. */
-		if (input->queue_type == AMDGPU_RING_TYPE_MES)
-			pipe = AMDGPU_MES_KIQ_PIPE;
-		else
-			pipe = AMDGPU_MES_SCHED_PIPE;
-	} else {
+	/* Keep scheduler queue on KIQ pipe; map all other kernel queues on sched pipe. */
+	if (input->queue_type == AMDGPU_RING_TYPE_MES)
+		pipe = AMDGPU_MES_KIQ_PIPE;
+	else
 		pipe = AMDGPU_MES_SCHED_PIPE;
-	}
 
 	return mes_v12_1_submit_pkt_and_poll_completion(mes,
 			input->xcc_id, pipe,
@@ -567,7 +557,7 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 	int pipe;
 
 	/*OP_WRM_REG_WR_WAIT is used to do tlb invalidation which need to be handled in sched pipe for gfx_12_1.*/
-	if (mes->adev->enable_uni_mes && input->op != MES_MISC_OP_WRM_REG_WR_WAIT)
+	if (input->op != MES_MISC_OP_WRM_REG_WR_WAIT)
 		pipe = AMDGPU_MES_KIQ_PIPE;
 	else
 		pipe = AMDGPU_MES_SCHED_PIPE;
@@ -766,7 +756,7 @@ static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
 
 	if (pipe == AMDGPU_MES_SCHED_PIPE)
 		adev->mes.sched_version = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MES_GP3_LO);
-	else if (pipe == AMDGPU_MES_KIQ_PIPE && adev->enable_mes_kiq)
+	else if (pipe == AMDGPU_MES_KIQ_PIPE)
 		adev->mes.kiq_version = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MES_GP3_LO);
 
 	soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
@@ -880,10 +870,7 @@ static int mes_v12_1_reset_legacy_queue(struct amdgpu_mes *mes,
 		mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
 	}
 
-	if (mes->adev->enable_uni_mes)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
-		pipe = AMDGPU_MES_SCHED_PIPE;
+	pipe = AMDGPU_MES_KIQ_PIPE;
 
 	return mes_v12_1_submit_pkt_and_poll_completion(mes,
 			input->xcc_id, pipe,
@@ -1100,10 +1087,8 @@ static void mes_v12_1_enable(struct amdgpu_device *adev,
 
 		if (amdgpu_emu_mode)
 			msleep(500);
-		else if (adev->enable_uni_mes)
-			udelay(500);
 		else
-			udelay(50);
+			udelay(500);
 	} else {
 		data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MES_CNTL);
 		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_ACTIVE, 0);
@@ -1426,31 +1411,6 @@ static void mes_v12_1_queue_init_register(struct amdgpu_ring *ring,
 	mutex_unlock(&adev->srbm_mutex);
 }
 
-static int mes_v12_1_kiq_enable_queue(struct amdgpu_device *adev, int xcc_id)
-{
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
-	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
-	int r, inst = MES_PIPE_INST(xcc_id, AMDGPU_MES_SCHED_PIPE);
-
-	if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
-		return -EINVAL;
-
-	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size);
-	if (r) {
-		DRM_ERROR("Failed to lock KIQ (%d).\n", r);
-		return r;
-	}
-
-	kiq->pmf->kiq_map_queues(kiq_ring, &adev->mes.ring[inst]);
-
-	r = amdgpu_ring_test_ring(kiq_ring);
-	if (r) {
-		DRM_ERROR("kfq enable failed\n");
-		kiq_ring->sched.ready = false;
-	}
-	return r;
-}
-
 static int mes_v12_1_queue_init(struct amdgpu_device *adev,
 				  enum amdgpu_mes_pipe pipe,
 				  int xcc_id)
@@ -1458,13 +1418,9 @@ static int mes_v12_1_queue_init(struct amdgpu_device *adev,
 	struct amdgpu_ring *ring;
 	int r;
 
-	if (!adev->enable_uni_mes && pipe == AMDGPU_MES_KIQ_PIPE)
-		ring = &adev->gfx.kiq[xcc_id].ring;
-	else
-		ring = &adev->mes.ring[MES_PIPE_INST(xcc_id, pipe)];
+	ring = &adev->mes.ring[MES_PIPE_INST(xcc_id, pipe)];
 
-	if ((adev->enable_uni_mes || pipe == AMDGPU_MES_SCHED_PIPE) &&
-	    (amdgpu_in_reset(adev) || adev->in_suspend)) {
+	if (amdgpu_in_reset(adev) || adev->in_suspend) {
 		*(ring->wptr_cpu_addr) = 0;
 		*(ring->rptr_cpu_addr) = 0;
 		amdgpu_ring_clear_ring(ring);
@@ -1475,10 +1431,7 @@ static int mes_v12_1_queue_init(struct amdgpu_device *adev,
 		return r;
 
 	if (pipe == AMDGPU_MES_SCHED_PIPE) {
-		if (adev->enable_uni_mes)
-			r = amdgpu_mes_map_legacy_queue(adev, ring, xcc_id);
-		else
-			r = mes_v12_1_kiq_enable_queue(adev, xcc_id);
+		r = amdgpu_mes_map_legacy_queue(adev, ring, xcc_id);
 		if (r)
 			return r;
 	} else {
@@ -1527,39 +1480,6 @@ static int mes_v12_1_ring_init(struct amdgpu_device *adev,
 				AMDGPU_RING_PRIO_DEFAULT, NULL);
 }
 
-static int mes_v12_1_kiq_ring_init(struct amdgpu_device *adev, int xcc_id)
-{
-	struct amdgpu_ring *ring;
-	int inst = MES_PIPE_INST(xcc_id, AMDGPU_MES_KIQ_PIPE);
-
-	spin_lock_init(&adev->gfx.kiq[xcc_id].ring_lock);
-
-	ring = &adev->gfx.kiq[xcc_id].ring;
-
-	ring->me = 3;
-	ring->pipe = 1;
-	ring->queue = 0;
-	ring->xcc_id = xcc_id;
-	ring->vm_hub = AMDGPU_GFXHUB(xcc_id);
-
-	ring->adev = NULL;
-	ring->ring_obj = NULL;
-	ring->use_doorbell = true;
-	ring->eop_gpu_addr = adev->mes.eop_gpu_addr[inst];
-	ring->no_scheduler = true;
-	ring->doorbell_index =
-		(adev->doorbell_index.mes_ring1 +
-		 xcc_id * adev->doorbell_index.xcc_doorbell_range)
-		<< 1;
-
-	snprintf(ring->name, sizeof(ring->name), "mes_kiq_%hhu.%hhu.%hhu.%hhu",
-		 (unsigned char)xcc_id, (unsigned char)ring->me,
-		 (unsigned char)ring->pipe, (unsigned char)ring->queue);
-
-	return amdgpu_ring_init(adev, ring, 1024, NULL, 0,
-				AMDGPU_RING_PRIO_DEFAULT, NULL);
-}
-
 static int mes_v12_1_mqd_sw_init(struct amdgpu_device *adev,
 				   enum amdgpu_mes_pipe pipe,
 				   int xcc_id)
@@ -1568,10 +1488,7 @@ static int mes_v12_1_mqd_sw_init(struct amdgpu_device *adev,
 	struct amdgpu_ring *ring;
 	int inst = MES_PIPE_INST(xcc_id, pipe);
 
-	if (!adev->enable_uni_mes && pipe == AMDGPU_MES_KIQ_PIPE)
-		ring = &adev->gfx.kiq[xcc_id].ring;
-	else
-		ring = &adev->mes.ring[inst];
+	ring = &adev->mes.ring[inst];
 
 	if (ring->mqd_obj)
 		return 0;
@@ -1606,8 +1523,8 @@ static int mes_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->mes.kiq_hw_fini = &mes_v12_1_kiq_hw_fini;
 	adev->mes.enable_legacy_queue_map = true;
 
-	adev->mes.event_log_size =
-		adev->enable_uni_mes ? (AMDGPU_MAX_MES_PIPES * AMDGPU_MES_LOG_BUFFER_SIZE * num_xcc) : AMDGPU_MES_LOG_BUFFER_SIZE;
+	adev->mes.event_log_size = AMDGPU_MAX_MES_PIPES *
+				   AMDGPU_MES_LOG_BUFFER_SIZE * num_xcc;
 
 	r = amdgpu_mes_init(adev);
 	if (r)
@@ -1623,15 +1540,11 @@ static int mes_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 			if (r)
 				return r;
 
-			if (!adev->enable_uni_mes && pipe ==
-			    AMDGPU_MES_KIQ_PIPE)
-				r = mes_v12_1_kiq_ring_init(adev, xcc_id);
-			else
-				r = mes_v12_1_ring_init(adev, xcc_id, pipe);
+			r = mes_v12_1_ring_init(adev, xcc_id, pipe);
 			if (r)
 				return r;
 
-			if (adev->enable_uni_mes && num_xcc > 1) {
+			if (num_xcc > 1) {
 				r = mes_v12_1_allocate_shared_cmd_buf(adev,
 							      pipe, xcc_id);
 				if (r)
@@ -1662,12 +1575,10 @@ static int mes_v12_1_sw_fini(struct amdgpu_ip_block *ip_block)
 					      &adev->mes.eop_gpu_addr[inst],
 					      NULL);
 
-			if (adev->enable_uni_mes || pipe == AMDGPU_MES_SCHED_PIPE) {
-				amdgpu_bo_free_kernel(&adev->mes.ring[inst].mqd_obj,
-						      &adev->mes.ring[inst].mqd_gpu_addr,
-						      &adev->mes.ring[inst].mqd_ptr);
-				amdgpu_ring_fini(&adev->mes.ring[inst]);
-			}
+			amdgpu_bo_free_kernel(&adev->mes.ring[inst].mqd_obj,
+					      &adev->mes.ring[inst].mqd_gpu_addr,
+					      &adev->mes.ring[inst].mqd_ptr);
+			amdgpu_ring_fini(&adev->mes.ring[inst]);
 		}
 	}
 
@@ -1675,13 +1586,6 @@ static int mes_v12_1_sw_fini(struct amdgpu_ip_block *ip_block)
 		amdgpu_ucode_release(&adev->mes.fw[pipe]);
 
 	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
-		if (!adev->enable_uni_mes) {
-			amdgpu_bo_free_kernel(&adev->gfx.kiq[xcc_id].ring.mqd_obj,
-				      &adev->gfx.kiq[xcc_id].ring.mqd_gpu_addr,
-				      &adev->gfx.kiq[xcc_id].ring.mqd_ptr);
-			amdgpu_ring_fini(&adev->gfx.kiq[xcc_id].ring);
-		}
-
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 			mes_v12_1_free_ucode_buffers(adev,
 				       AMDGPU_MES_KIQ_PIPE, xcc_id);
@@ -1694,44 +1598,6 @@ static int mes_v12_1_sw_fini(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static void mes_v12_1_kiq_dequeue_sched(struct amdgpu_device *adev,
-					  int xcc_id)
-{
-	uint32_t data;
-	int i;
-
-	mutex_lock(&adev->srbm_mutex);
-	soc_v1_0_grbm_select(adev, 3, AMDGPU_MES_SCHED_PIPE, 0, 0,
-			     GET_INST(GC, xcc_id));
-
-	/* disable the queue if it's active */
-	if (RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE) & 1) {
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_DEQUEUE_REQUEST, 1);
-		for (i = 0; i < adev->usec_timeout; i++) {
-			if (!(RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE) & 1))
-				break;
-			udelay(1);
-		}
-	}
-	data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CONTROL);
-	data = REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
-				DOORBELL_EN, 0);
-	data = REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
-				DOORBELL_HIT, 1);
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CONTROL, data);
-
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CONTROL, 0);
-
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_LO, 0);
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_HI, 0);
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_RPTR, 0);
-
-	soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
-	mutex_unlock(&adev->srbm_mutex);
-
-	adev->mes.ring[MES_PIPE_INST(xcc_id, 0)].sched.ready = false;
-}
-
 static void mes_v12_1_kiq_dequeue(struct amdgpu_device *adev, int xcc_id)
 {
 	int i;
@@ -1780,10 +1646,7 @@ static int mes_v12_1_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_id)
 	int r = 0;
 	struct amdgpu_ip_block *ip_block;
 
-	if (adev->enable_uni_mes)
-		mes_v12_1_kiq_setting(&adev->mes.ring[inst], xcc_id);
-	else
-		mes_v12_1_kiq_setting(&adev->gfx.kiq[xcc_id].ring, xcc_id);
+	mes_v12_1_kiq_setting(&adev->mes.ring[inst], xcc_id);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 
@@ -1818,19 +1681,17 @@ static int mes_v12_1_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_id)
 	if (r)
 		goto failure;
 
-	if (adev->enable_uni_mes) {
-		r = mes_v12_1_setup_coop_mode(adev, xcc_id);
-		if (r)
-			goto failure;
+	r = mes_v12_1_setup_coop_mode(adev, xcc_id);
+	if (r)
+		goto failure;
 
-		r = mes_v12_1_set_hw_resources(&adev->mes,
-						 AMDGPU_MES_KIQ_PIPE, xcc_id);
-		if (r)
-			goto failure;
+	r = mes_v12_1_set_hw_resources(&adev->mes,
+				       AMDGPU_MES_KIQ_PIPE, xcc_id);
+	if (r)
+		goto failure;
 
-		mes_v12_1_set_hw_resources_1(&adev->mes,
-					       AMDGPU_MES_KIQ_PIPE, xcc_id);
-	}
+	mes_v12_1_set_hw_resources_1(&adev->mes,
+				     AMDGPU_MES_KIQ_PIPE, xcc_id);
 
 	if (adev->mes.enable_legacy_queue_map) {
 		r = mes_v12_1_xcc_hw_init(ip_block, xcc_id);
@@ -1850,12 +1711,8 @@ static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id)
 	int inst = MES_PIPE_INST(xcc_id, AMDGPU_MES_SCHED_PIPE);
 
 	if (adev->mes.ring[inst].sched.ready) {
-		if (adev->enable_uni_mes)
-			amdgpu_mes_unmap_legacy_queue(adev,
-				      &adev->mes.ring[inst],
-				      RESET_QUEUES, 0, 0, xcc_id);
-		else
-			mes_v12_1_kiq_dequeue_sched(adev, xcc_id);
+		amdgpu_mes_unmap_legacy_queue(adev, &adev->mes.ring[inst],
+					      RESET_QUEUES, 0, 0, xcc_id);
 
 		adev->mes.ring[inst].sched.ready = false;
 	}
@@ -1916,26 +1773,6 @@ static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_block *ip_block, int xcc_id)
 	if (adev->mes.ring[MES_PIPE_INST(xcc_id, 0)].sched.ready)
 		goto out;
 
-	if (!adev->enable_mes_kiq) {
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
-			r = mes_v12_1_load_microcode(adev,
-				       AMDGPU_MES_SCHED_PIPE, true, xcc_id);
-			if (r) {
-				DRM_ERROR("failed to MES fw, r=%d\n", r);
-				return r;
-			}
-
-			mes_v12_1_set_ucode_start_addr(adev, xcc_id);
-
-		} else if (adev->firmware.load_type ==
-			   AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {
-
-			mes_v12_1_set_ucode_start_addr(adev, xcc_id);
-		}
-
-		mes_v12_1_enable(adev, true, xcc_id);
-	}
-
 	/* Enable the MES to handle doorbell ring on unmapped queue */
 	mes_v12_1_enable_unmapped_doorbell_handling(&adev->mes, true, xcc_id);
 
@@ -1948,10 +1785,7 @@ static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_block *ip_block, int xcc_id)
 	if (r)
 		goto failure;
 
-	if (adev->enable_uni_mes) {
-		mes_v12_1_set_hw_resources_1(&adev->mes,
-					       AMDGPU_MES_SCHED_PIPE, xcc_id);
-	}
+	mes_v12_1_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED_PIPE, xcc_id);
 	mes_v12_1_init_aggregated_doorbell(&adev->mes, xcc_id);
 
 	r = mes_v12_1_query_sched_status(&adev->mes,
@@ -1963,12 +1797,6 @@ static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_block *ip_block, int xcc_id)
 
 	amdgpu_mes_validate_fw_version(adev);
 out:
-	/*
-	 * Disable KIQ ring usage from the driver once MES is enabled.
-	 * MES uses KIQ ring exclusively so driver cannot access KIQ ring
-	 * with MES enabled.
-	 */
-	adev->gfx.kiq[xcc_id].ring.sched.ready = false;
 	adev->mes.ring[MES_PIPE_INST(xcc_id, 0)].sched.ready = true;
 
 	return 0;
-- 
2.43.0

