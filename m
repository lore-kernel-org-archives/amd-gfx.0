Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9746C982FF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 13:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F17110ECD3;
	Tue, 22 Sep 2026 13:13:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FuJ9/Sft";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62B0010ECD3
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 13:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0QwFu628eCduO/1cwWg4Yp3vZU8MVef2uzMEwTznjPWgHfj7/Ur2z5c+8YovcRW6naahFONfrF2thWaLVz5XUKSfek4o4lktBg/r3aAZrQR+LVwXt+L73SZt76subB70knC4zwkFhdQeNweFM9zwXJOoCaQDNOoT7DR+o5tuK5Nw6bN0CnbumYvJfUoa4942fgZEowpcNE/sCUEAf8dYwgnc1tBr2VTAfvS3MIWytG6/qgf6V/TGjTtJj4KaXMUCVW2OPFOLuOvXu3q6x6+QV8HazrgGRX3tbH5S8yC/iTHIUEZoIrEGCKVY8DDKKh197Wpz6wnYPVvyEELEF+Q0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXDscCY2WnhqBEhA2dVpQqxU2WJGvc42TG1uLJpeqko=;
 b=EcZO+dwfrwGvqqQWJDJwBgUCKeBxlAAKjWCPgWHVo8oDG1M33oQjsRNHCziccruMrmPCFcweko6b3nDr3lERbK9SPvjmauuceKzhDA2E60ZLiRRBV5xaKsvi6J01d9lk4RpKrvYUkMrLBY/pUEVvb/rtxiGcRKoOEhDP9kmtEpyGCyrZrCJGchDzbgOlFAfDi8cyIffUVj1F9FTpv8qSpsPzCheK+0+dzQhX9zTTsal1PmuXyL5ylUMB1MBiX6q6VW0jgN8K+/GzrZTi+eNHLbY10av7ysdYsvD5zm1W5vqwscoSZiMPTa802loTK5PzrZupZcqfkbyR7bGYruspgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXDscCY2WnhqBEhA2dVpQqxU2WJGvc42TG1uLJpeqko=;
 b=FuJ9/SftIwbKMsWWijy06WJSNqILDb5jWuDoJtZuundPs5r8f7VJ6Le1WYm2xlUa/ND61qpIiUOPfMuesflhLvVr+leN4UlmM56chvGkTfluzJ2kfacVTagqaD2yRMCgrrkcqrjO0Yewy2pkjCaaL9OwxFeWdaAf+UraM4d1Wio=
Received: from SN7PR04CA0203.namprd04.prod.outlook.com (2603:10b6:806:126::28)
 by PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 13:13:06 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::1c) by SN7PR04CA0203.outlook.office365.com
 (2603:10b6:806:126::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 13:13:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 13:13:05 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 08:13:01 -0500
From: David Yat Sin <David.YatSin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <philip.yang@amd.com>, David Yat Sin
 <David.YatSin@amd.com>
Subject: [PATCH] drm/amdgpu: Flush the pasid on all XCCs in parallel
Date: Tue, 22 Sep 2026 09:12:46 -0400
Message-ID: <20260922131246.2886098-1-David.YatSin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|PH8PR12MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: edf6f9eb-4597-4d2b-9694-08df18ab3d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|6133799003|18002099003|5023799004|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: D9VyHwpuOKBS2pRryBjSrCnU1wIQSPYw5kM3D8vp/rzVPWzpf2K0aKArNWBFJ6FlPfbZlzx6jipuGEeJvzQG077zY1NnhvbkOUw4vdQCTA9/FkpoQA8hIBjUU3QpHOWMjHeaWJb01wX6Q28xhjf/pLOpdI4h6EV4jLIFZDtaZ4t/UETEwinQgS9ZAEHOcL6Drb2AyEaHvicFu9npupz+2NdSu6B4bT4kRRfyaUTSsCpfzEF1WpHCdMKeEvAFPTO41Ec1lGe6nEa0IoaFGOwIlKr7nrivbTHcYDZY12pWrVKhK60D2zTtjcvzlxvInPvHmmKPS+JsCe2ekRvyHl2TcSclw9hNn7W+HOCpSTKtVcoYwApyJMmr0eWRUHnl1CLIs/T7TOopyOBCopUU8xE0qEAI6P85K1q7eQfJK/lLLb19GHCoV3OFjrdbetfo/pLPGdy9y+9TG7qS/yOsZjRhGKzJaK7CfDXjcNlKjoypyhrex4xVN7a4OeugEp57ukAsFzUEAvOoISLcHrylUMeIAqTOdVBq3z5wEfNWlB77tGZtPtENAnpEPPYekqLAiMhvwi1A4F9flva7adZof0QTTrF/SnPztDdzK1falKeKDtP0elq2jofZTWufUhnLqb5nahNSb4Shw4VmBw5v5MJbekv7zZ6XEDeiFXTf8OGiRXsP98DjZl9Lxh9Qq4wH6JVXSVmOofop5PL0SVODmwCYGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(6133799003)(18002099003)(5023799004)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fNST+ldQ4plQBZ1iS96SfSK2ZjMSjxZFTieo+ATLUN8LP2szndkqiThmj1fiPYNtKakWfZRZ/ZiuanybjT68Z5IRg5Wfr+x36t7KBIx/GTN1Mgi8vV0eGWMdW4eCrnbVSbhMXnk+pa+rMUVlzIN5uYyJ3y//8BcTfSDJWvhmqYC8kisbO5oKPGi1BnM/I7OYT3hXHlqYKjraG5JDu5bKG1hdBoTiHIL0QO+sOp5gZffstBwxHIKOtqKyYIv/HwY0FpLzwI57OhTl8KpRvgZNYvbYmevPmxHo0J4EPObx/ZeAEHWln7XRS1JOl2mxfHq4R4cKPMgrGuxktA8BBDTkocAsVii8iiTslDIHEKCxvlQ5kwE7eGlal01/p7hJb1CgH/RfTc4G/EDyf17kHnTxL4zQMtpP+wl52a8uAnDYTJZ4ZJiWCgww1uGSC3mMRCAP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 13:13:05.6286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edf6f9eb-4597-4d2b-9694-08df18ab3d4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674
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

amdgpu_vm_flush_compute_tlb() walks the XCCs of the compute partition one
at a time, and amdgpu_gmc_flush_gpu_tlb_pasid() submits the invalidation
to one XCC's KIQ and then busy-waits for its fence before the caller can
move on to the next. On a partition that owns every XCC of the device
that is num_xcc round trips back to back.

The XCCs do not depend on each other here. Each has its own KIQ ring,
ring lock and fence sequence, the page tables are already updated before
any invalidation is issued, and no invalidation needs another XCC to have
finished first.

Split the submit out of amdgpu_gmc_flush_gpu_tlb_pasid() and add
amdgpu_gmc_flush_gpu_tlb_pasid_xccs(), which queues the invalidation on
every XCC in the mask before collecting any of the fences, so the round
trips overlap. Every XCC is flushed even when one of them fails, and the
first error is what gets returned. The single XCC entry point keeps its
behaviour, so only the compute TLB flush path changes.

Signed-off-by: David Yat Sin <David.YatSin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 226 +++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  10 +-
 3 files changed, 172 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 7c0554506334..6a9bcd28b43c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -780,15 +780,108 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	dev_err(adev->dev, "Error flushing GPU TLB using the SDMA (%d)!\n", r);
 }
 
+static void amdgpu_gmc_flush_pasid_regs(struct amdgpu_device *adev, uint16_t pasid,
+					uint32_t flush_type, bool all_hub,
+					uint32_t inst)
+{
+	if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid)
+		return;
+
+	if (adev->gmc.flush_tlb_needs_extra_type_2)
+		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid, 2, all_hub,
+							 inst);
+
+	if (adev->gmc.flush_tlb_needs_extra_type_0 && flush_type == 2)
+		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid, 0, all_hub,
+							 inst);
+
+	adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid, flush_type, all_hub,
+						 inst);
+}
+
+/*
+ * Queue the invalidation on one XCC and return its fence without waiting, so
+ * that a caller flushing several XCCs can have them in flight together.  The
+ * KIQ ring, its lock and its fence sequence are per XCC, so the submissions do
+ * not interfere with each other.
+ */
+static int amdgpu_gmc_flush_pasid_kiq_submit(struct amdgpu_device *adev,
+					     uint16_t pasid, uint32_t flush_type,
+					     bool all_hub, uint32_t inst,
+					     uint32_t *seq)
+{
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
+	struct amdgpu_ring *ring = &kiq->ring;
+	unsigned int ndw;
+	int r;
+
+	/* 2 dwords flush + 8 dwords fence */
+	ndw = kiq->pmf->invalidate_tlbs_size + 8;
+
+	if (adev->gmc.flush_tlb_needs_extra_type_2)
+		ndw += kiq->pmf->invalidate_tlbs_size;
+
+	if (adev->gmc.flush_tlb_needs_extra_type_0)
+		ndw += kiq->pmf->invalidate_tlbs_size;
+
+	spin_lock(&kiq->ring_lock);
+	r = amdgpu_ring_alloc(ring, ndw);
+	if (r) {
+		spin_unlock(&kiq->ring_lock);
+		return r;
+	}
+
+	if (adev->gmc.flush_tlb_needs_extra_type_2)
+		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
+
+	if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
+		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
+
+	kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
+	r = amdgpu_fence_emit_polling(ring, seq, MAX_KIQ_REG_WAIT);
+	if (r) {
+		amdgpu_ring_undo(ring);
+		spin_unlock(&kiq->ring_lock);
+		return r;
+	}
+
+	amdgpu_ring_commit(ring);
+	spin_unlock(&kiq->ring_lock);
+
+	return 0;
+}
+
+static int amdgpu_gmc_flush_pasid_kiq_wait(struct amdgpu_device *adev,
+					   uint32_t inst, uint32_t seq)
+{
+	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
+	int cnt = 0;
+	signed long r;
+
+	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+
+	might_sleep();
+	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
+	       !amdgpu_reset_pending(adev->reset_domain)) {
+		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
+		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+	}
+
+	if (cnt > MAX_KIQ_REG_TRY) {
+		dev_err(adev->dev, "timeout waiting for kiq fence\n");
+		return -ETIME;
+	}
+
+	return 0;
+}
+
 int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 				   uint32_t flush_type, bool all_hub,
 				   uint32_t inst)
 {
 	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
-	unsigned int ndw;
-	int r, cnt = 0;
 	uint32_t seq;
+	int r;
 
 	/*
 	 * A GPU reset should flush all TLBs anyway, so no need to do
@@ -798,76 +891,91 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 		return 0;
 
 	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
+		amdgpu_gmc_flush_pasid_regs(adev, pasid, flush_type, all_hub, inst);
+		r = 0;
+		goto error_unlock_reset;
+	}
 
-		if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid) {
-			r = 0;
-			goto error_unlock_reset;
-		}
-
-		if (adev->gmc.flush_tlb_needs_extra_type_2)
-			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
-								 2, all_hub,
-								 inst);
+	r = amdgpu_gmc_flush_pasid_kiq_submit(adev, pasid, flush_type, all_hub,
+					      inst, &seq);
+	if (r)
+		goto error_unlock_reset;
 
-		if (adev->gmc.flush_tlb_needs_extra_type_0 && flush_type == 2)
-			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
-								 0, all_hub,
-								 inst);
+	r = amdgpu_gmc_flush_pasid_kiq_wait(adev, inst, seq);
 
-		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
-							 flush_type, all_hub,
-							 inst);
-		r = 0;
-	} else {
-		/* 2 dwords flush + 8 dwords fence */
-		ndw = kiq->pmf->invalidate_tlbs_size + 8;
+error_unlock_reset:
+	up_read(&adev->reset_domain->sem);
+	return r;
+}
 
-		if (adev->gmc.flush_tlb_needs_extra_type_2)
-			ndw += kiq->pmf->invalidate_tlbs_size;
+/**
+ * amdgpu_gmc_flush_gpu_tlb_pasid_xccs - flush a pasid on several XCCs at once
+ *
+ * @adev: amdgpu_device pointer
+ * @pasid: pasid to be flushed
+ * @flush_type: the flush type
+ * @all_hub: flush all hubs
+ * @xcc_mask: mask of the XCCs to flush
+ *
+ * Submits the invalidation to every XCC in @xcc_mask before waiting for any of
+ * them, so the round trips overlap instead of running back to back.  Flushing
+ * one XCC at a time costs num_xcc times the latency of a single one, which on
+ * a partition holding every XCC of the device is most of the cost of a compute
+ * TLB flush.
+ *
+ * The XCCs are independent of each other here: the page tables are already
+ * updated before any invalidation is issued, and nothing in an invalidation
+ * depends on another XCC having completed its own.
+ *
+ * Returns:
+ * 0 for success, the first error otherwise.  Every XCC is flushed even if one
+ * of them fails.
+ */
+int amdgpu_gmc_flush_gpu_tlb_pasid_xccs(struct amdgpu_device *adev, uint16_t pasid,
+					uint32_t flush_type, bool all_hub,
+					uint32_t xcc_mask)
+{
+	uint32_t seq[AMDGPU_MAX_GC_INSTANCES];
+	unsigned long pending = 0;
+	int xcc, r = 0, tmp;
 
-		if (adev->gmc.flush_tlb_needs_extra_type_0)
-			ndw += kiq->pmf->invalidate_tlbs_size;
+	/*
+	 * A GPU reset should flush all TLBs anyway, so no need to do
+	 * this while one is ongoing.
+	 */
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return 0;
 
-		spin_lock(&adev->gfx.kiq[inst].ring_lock);
-		r = amdgpu_ring_alloc(ring, ndw);
-		if (r) {
-			spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-			goto error_unlock_reset;
-		}
-		if (adev->gmc.flush_tlb_needs_extra_type_2)
-			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
+	for_each_inst(xcc, xcc_mask) {
+		struct amdgpu_ring *ring;
 
-		if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
-			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
+		if (xcc >= AMDGPU_MAX_GC_INSTANCES)
+			break;
 
-		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
-		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
-		if (r) {
-			amdgpu_ring_undo(ring);
-			spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-			goto error_unlock_reset;
+		ring = &adev->gfx.kiq[xcc].ring;
+		if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
+			amdgpu_gmc_flush_pasid_regs(adev, pasid, flush_type,
+						    all_hub, xcc);
+			continue;
 		}
 
-		amdgpu_ring_commit(ring);
-		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-
-		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
-
-		might_sleep();
-		while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
-		       !amdgpu_reset_pending(adev->reset_domain)) {
-			msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
-			r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+		tmp = amdgpu_gmc_flush_pasid_kiq_submit(adev, pasid, flush_type,
+							all_hub, xcc, &seq[xcc]);
+		if (tmp) {
+			if (!r)
+				r = tmp;
+			continue;
 		}
 
-		if (cnt > MAX_KIQ_REG_TRY) {
-			dev_err(adev->dev, "timeout waiting for kiq fence\n");
-			r = -ETIME;
-		} else
-			r = 0;
+		__set_bit(xcc, &pending);
+	}
+
+	for_each_set_bit(xcc, &pending, AMDGPU_MAX_GC_INSTANCES) {
+		tmp = amdgpu_gmc_flush_pasid_kiq_wait(adev, xcc, seq[xcc]);
+		if (tmp && !r)
+			r = tmp;
 	}
 
-error_unlock_reset:
 	up_read(&adev->reset_domain->sem);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index cffd5ca3fc66..5ea237ce133b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -447,6 +447,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 				   uint32_t flush_type, bool all_hub,
 				   uint32_t inst);
+int amdgpu_gmc_flush_gpu_tlb_pasid_xccs(struct amdgpu_device *adev, uint16_t pasid,
+					uint32_t flush_type, bool all_hub,
+					uint32_t xcc_mask);
 void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 				      uint32_t reg0, uint32_t reg1,
 				      uint32_t ref, uint32_t mask,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 47cde5459469..aae92ca87914 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1724,7 +1724,6 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
 {
 	uint64_t tlb_seq = amdgpu_vm_tlb_seq(vm);
 	bool all_hub = false;
-	int xcc = 0, r = 0;
 
 	WARN_ON_ONCE(!vm->is_compute_context);
 
@@ -1740,13 +1739,8 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
 	    adev->family == AMDGPU_FAMILY_RV)
 		all_hub = true;
 
-	for_each_inst(xcc, xcc_mask) {
-		r = amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, flush_type,
-						   all_hub, xcc);
-		if (r)
-			break;
-	}
-	return r;
+	return amdgpu_gmc_flush_gpu_tlb_pasid_xccs(adev, vm->pasid, flush_type,
+						   all_hub, xcc_mask);
 }
 
 /**
-- 
2.34.1

