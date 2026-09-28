Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D04CA5FA3
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 18:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 454A510E987;
	Mon, 28 Sep 2026 18:52:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YsD7pCS0";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF89C10E987
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 18:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lr/EJd7cNo0aN1G8o8UsnZxhApcN4ndLtfFOJcQ3OckzyXrrnPRzisVccQXRxbY1JepxhB/89s59IfOV3tKOveAe/987C6tEvHyBtTtalcmzXWVtvAPpXWXGLWXSMWNHi+MsTF+Gig9Mqrv6OxMMjmUKLvDU14E/uQEZisvx8COMVIp17h/VP6fCB2rGTLm3J7MS3gySRplT2Nzb5vmqvOVv/tOhYbZlIsbCyKZx9WPb36NkrQ2n1aE74rc0oHsRO06jCrJXbQxroZqW6b9g9t6mFVS6oQnI+y8JvYu0PXBybKDzPrBwab2MJ2JHYUSU7JrgT9CZT7k/kP+8rvASEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8sNN/JZxC//1AY9wRY2CPkRhzeQNE7Qf8Hb4SLjuqQ=;
 b=Qcq66StwcWidL/JJUR4JQC/wLPZ39kcw+pL6nEiy1rSfRT5hO1YH4bNcSpV2FK2hd8+twy2CQ6RyQcpVgC4qUva1r9F1G67ELoj8NpvIB4BqXoxxspP3oL9f5Z3VMghCLX+AfY0Z36tyIZM+XboeNUQj9z9fLrCKo14N6ZqagcIX/OgqriHFDjyATgwKt9vVr2odSOSSaEbVEzO889xeSExH0aVn5R7PpcBDPgqDi859S1o0JLZctvqZqebEZongfvNjwTJ7VX0vAr2Ov3bLDTPRXwAtbxHOAXiOkX4u+nG8XySPGzp/Y7ApEg/6bRqzxZ+8otourO+PmacPSyW5IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8sNN/JZxC//1AY9wRY2CPkRhzeQNE7Qf8Hb4SLjuqQ=;
 b=YsD7pCS0GrQLI3R/Y4cIYFPvw4vbHPWDfBZsW8UmtT1paiu/ycM6xJDCLAMaLDXwFXA/T5EczxFWVGhRU4Z/pF2snm1HCODS8pRs7fVvnzAS2HkdgGrR9TUGilUcdMgB9EBEibU5xRJunbFtzGbKr2Kwf1gDzBbjxqXdpAjVeNY=
Received: from CH0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:610:b0::32)
 by FT1PR12MB210997.namprd12.prod.outlook.com (2603:10b6:170:a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 18:52:37 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::79) by CH0PR03CA0027.outlook.office365.com
 (2603:10b6:610:b0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Mon, 28
 Sep 2026 18:52:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 18:52:36 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 13:52:35 -0500
From: David Yat Sin <David.YatSin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <philip.yang@amd.com>, David Yat Sin
 <David.YatSin@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v2] drm/amdgpu: Flush the pasid on all XCCs in parallel
Date: Mon, 28 Sep 2026 14:52:23 -0400
Message-ID: <20260928185223.368752-1-David.YatSin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|FT1PR12MB210997:EE_
X-MS-Office365-Filtering-Correlation-Id: 50dd0eb9-a83c-4a51-7e2e-08df1d91a9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|6133799003|18002099003|11063799006|56012099006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: Rn9m0LVyziGnv3/BKHsJD0cmHkjRM901IJuug7Bk8sZH8Fu4MQLTzBv3Jwzc7ics4o3tZlW8LDnhKm8DLajv3MVSLFVAFwVV/d7k7dQpYgT/8o9LUP0daT8CROvRciU4GDilQCngHfNBc01OvvQ17hU6JAqZWInlJG1HT8H2a8MhtnVxPFvRGXqd7Ug/H3Uyly9thJiTMbktnfsCKENYoYKbbUO6O8KERaossveD75d6DpIF84xgfG/80CoL06Os19/j0uy6FdP9gxV7B7DaX2llqVJFjNMxhDHXvvN1SVOm/8kh01ALWnUUKBEtecsJx6itRIdOlZ8+yRaE0XfJJ5SSXiv/W0A3/va69UkVjOpBpEZP2fyy5nCibUGFcBjXIyejC5VQIeFpVH20QW1qwEdfWAvWx1djVkumlFvQ9NGaOVA1sdgxoX/63r7YKs86DhhjzZ3cuUFIpRk0/PRt7D6Xgmo6fHZIftgkccY1hQ+5th7f+jZ50zVhy1tgRB0EVCEwD41UpNmcetIbBHMC6HUEM8G4HyJdyYw4wo4f8Kw82vau/WoqsEQJtgmJBkynBgCWHttArcw5d5woeciqhzI6IArcMdM7qqC8aPDLi+dLK9LgxJskzX+byBMPjfiusYj4rWE/kLh1CIdZwICPSSWpa0+Mhu045S6XWvGUqsvJ+DJ6aqV+ctFZBHajcjdHQktF4/+WVFgF6bnlMecnZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(6133799003)(18002099003)(11063799006)(56012099006)(5023799004)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U3d5DD4UpvFkvknj2j7yYexgOuC1SRjFokvLUForBVGmlTlA5W4RS9OPEneiiKWRLiWG81pa6TuBnr2S1cG/45oNd02+wQDNHqs9sO+y3jpuFKJb5CVirm59pZxI508e7/OASXWcCmER83eQTx+xuO4j3AsuwAkEW2tDiwrrQ58Ct8dtFOtyb/3sP9YRQja68LzuOxDWsBV6b1kKek8LBE+XXj8h4EAmpMcDY05MgoAhYCIg1/A9WETqZ7D571I4ZueJ8IVL9vl5UeEJPLgBW2mCIbts47h/f+hRhkv3ATzw1LL3HFOENfCehkbLOc81io/67NtYbY1hB2kWZKBMwqm2YCAked3MjmPFi62eGur5CGU6HNlg0flp+NNCQiAB+zZ/FjYRRRWR2uMKGjs7l0Hnf+7zmJ+n28hJi3Dz5kSdPdVhX7n2GVRNWB3ubQ/P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 18:52:36.8678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50dd0eb9-a83c-4a51-7e2e-08df1d91a9fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB210997
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
trips overlap. amdgpu_gmc_flush_gpu_tlb_pasid() becomes a one bit mask
call into it, so both entry points share the reset-domain handling and
the KIQ dispatch.

Note that amdgpu_vm_flush_compute_tlb() no longer stops at the first XCC
that fails. Every XCC in the mask is flushed regardless and the first
error is returned, which is a deliberate behaviour change for callers:
one XCC failing to queue its invalidation no longer leaves the remaining
XCCs unflushed.

Measured on gfx950 with all 8 XCCs in one SPX partition, revoking host
memory access for a pasid mapped on every XCC. Traced with ftrace,
amdgpu_vm_flush_compute_tlb() drops from 141 us to 65 us, against 23 us
for the slowest individual XCC flush. The KFD SVM ioctl carrying that
flush drops from 0.14 ms to 0.05 ms at p50.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: David Yat Sin <David.YatSin@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 233 +++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  10 +-
 3 files changed, 173 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 1bf2a42fa63c..167f1344f8f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -782,98 +782,197 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	dev_err(adev->dev, "Error flushing GPU TLB using the SDMA (%d)!\n", r);
 }
 
-int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
-				   uint32_t flush_type, bool all_hub,
-				   uint32_t inst)
+static void amdgpu_gmc_flush_pasid_regs(struct amdgpu_device *adev, u16 pasid,
+					u32 flush_type, bool all_hub,
+					u32 inst)
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
+					     u16 pasid, u32 flush_type,
+					     bool all_hub, u32 inst,
+					     u32 *seq)
 {
-	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
+	struct amdgpu_ring *ring = &kiq->ring;
 	unsigned int ndw;
-	int r, cnt = 0;
-	uint32_t seq;
+	int r;
 
-	/*
-	 * A GPU reset should flush all TLBs anyway, so no need to do
-	 * this while one is ongoing.
-	 */
-	if (!down_read_trylock(&adev->reset_domain->sem))
-		return 0;
+	/* one flush + 8 dwords fence */
+	ndw = kiq->pmf->invalidate_tlbs_size + 8;
 
-	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
+	if (adev->gmc.flush_tlb_needs_extra_type_2)
+		ndw += kiq->pmf->invalidate_tlbs_size;
 
-		if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid) {
-			r = 0;
-			goto error_unlock_reset;
-		}
+	if (adev->gmc.flush_tlb_needs_extra_type_0 && flush_type == 2)
+		ndw += kiq->pmf->invalidate_tlbs_size;
 
-		if (adev->gmc.flush_tlb_needs_extra_type_2)
-			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
-								 2, all_hub,
-								 inst);
+	spin_lock(&kiq->ring_lock);
+	r = amdgpu_ring_alloc(ring, ndw);
+	if (r) {
+		spin_unlock(&kiq->ring_lock);
+		return r;
+	}
 
-		if (adev->gmc.flush_tlb_needs_extra_type_0 && flush_type == 2)
-			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
-								 0, all_hub,
-								 inst);
+	if (adev->gmc.flush_tlb_needs_extra_type_2)
+		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
 
-		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
-							 flush_type, all_hub,
-							 inst);
-		r = 0;
-	} else {
-		/* 2 dwords flush + 8 dwords fence */
-		ndw = kiq->pmf->invalidate_tlbs_size + 8;
+	if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
+		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
 
-		if (adev->gmc.flush_tlb_needs_extra_type_2)
-			ndw += kiq->pmf->invalidate_tlbs_size;
-
-		if (adev->gmc.flush_tlb_needs_extra_type_0)
-			ndw += kiq->pmf->invalidate_tlbs_size;
+	kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
+	r = amdgpu_fence_emit_polling(ring, seq, MAX_KIQ_REG_WAIT);
+	if (r) {
+		amdgpu_ring_undo(ring);
+		spin_unlock(&kiq->ring_lock);
+		return r;
+	}
 
-		spin_lock(&adev->gfx.kiq[inst].ring_lock);
-		r = amdgpu_ring_alloc(ring, ndw);
-		if (r) {
-			spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-			goto error_unlock_reset;
-		}
-		if (adev->gmc.flush_tlb_needs_extra_type_2)
-			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
+	amdgpu_ring_commit(ring);
+	spin_unlock(&kiq->ring_lock);
 
-		if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
-			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
+	return 0;
+}
 
-		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
-		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
-		if (r) {
-			amdgpu_ring_undo(ring);
-			spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-			goto error_unlock_reset;
-		}
+/*
+ * Wait for an invalidation queued by amdgpu_gmc_flush_pasid_kiq_submit().
+ *
+ * Bailing out because a reset became pending is reported as success: the reset
+ * flushes all TLBs anyway, so the invalidation no longer has to complete.  Only
+ * running out of tries is an error.
+ */
+static int amdgpu_gmc_flush_pasid_kiq_wait(struct amdgpu_device *adev,
+					   u32 inst, u32 seq)
+{
+	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
+	int cnt = 0;
+	signed long r;
 
-		amdgpu_ring_commit(ring);
-		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
+	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
 
+	might_sleep();
+	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
+	       !amdgpu_reset_pending(adev->reset_domain)) {
+		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
 		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
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
+int amdgpu_gmc_flush_gpu_tlb_pasid_xccs(struct amdgpu_device *adev, u16 pasid,
+					u32 flush_type, bool all_hub,
+					u32 xcc_mask)
+{
+	u32 seq[AMDGPU_MAX_GC_INSTANCES];
+	unsigned long pending = 0;
+	int xcc, r = 0, err;
 
-		might_sleep();
-		while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
-		       !amdgpu_reset_pending(adev->reset_domain)) {
-			msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
-			r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+	/*
+	 * A GPU reset should flush all TLBs anyway, so no need to do
+	 * this while one is ongoing.
+	 *
+	 * Unlike the one XCC at a time flush this holds the read side across
+	 * every submit and every wait, so a reset's down_write() can only get
+	 * in once the whole mask is done.  The waits are sequential, which
+	 * bounds that at num_xcc * MAX_KIQ_REG_TRY * MAX_KIQ_REG_BAILOUT_INTERVAL
+	 * in the worst case, and amdgpu_gmc_flush_pasid_kiq_wait() cuts each
+	 * wait short as soon as a reset becomes pending.
+	 */
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return 0;
+
+	for_each_inst(xcc, xcc_mask) {
+		struct amdgpu_ring *ring;
+
+		if (WARN_ON_ONCE(xcc >= AMDGPU_MAX_GC_INSTANCES)) {
+			if (!r)
+				r = -EINVAL;
+			break;
 		}
 
-		if (cnt > MAX_KIQ_REG_TRY) {
-			dev_err(adev->dev, "timeout waiting for kiq fence\n");
-			r = -ETIME;
-		} else
-			r = 0;
+		ring = &adev->gfx.kiq[xcc].ring;
+		if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
+			amdgpu_gmc_flush_pasid_regs(adev, pasid, flush_type,
+						    all_hub, xcc);
+			continue;
+		}
+
+		err = amdgpu_gmc_flush_pasid_kiq_submit(adev, pasid, flush_type,
+							all_hub, xcc, &seq[xcc]);
+		if (err) {
+			if (!r)
+				r = err;
+			continue;
+		}
+
+		pending |= BIT(xcc);
+	}
+
+	for_each_set_bit(xcc, &pending, AMDGPU_MAX_GC_INSTANCES) {
+		err = amdgpu_gmc_flush_pasid_kiq_wait(adev, xcc, seq[xcc]);
+		if (err && !r)
+			r = err;
 	}
 
-error_unlock_reset:
 	up_read(&adev->reset_domain->sem);
 	return r;
 }
 
+int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, u16 pasid,
+				   u32 flush_type, bool all_hub, u32 inst)
+{
+	return amdgpu_gmc_flush_gpu_tlb_pasid_xccs(adev, pasid, flush_type,
+						   all_hub, BIT(inst));
+}
+
 void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 				      uint32_t reg0, uint32_t reg1,
 				      uint32_t ref, uint32_t mask,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index cffd5ca3fc66..76e6f1f96913 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -444,9 +444,11 @@ int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
 void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 			      uint32_t vmhub, uint32_t flush_type);
-int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
-				   uint32_t flush_type, bool all_hub,
-				   uint32_t inst);
+int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, u16 pasid,
+				   u32 flush_type, bool all_hub, u32 inst);
+int amdgpu_gmc_flush_gpu_tlb_pasid_xccs(struct amdgpu_device *adev, u16 pasid,
+					u32 flush_type, bool all_hub,
+					u32 xcc_mask);
 void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 				      uint32_t reg0, uint32_t reg1,
 				      uint32_t ref, uint32_t mask,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 29a66e39f3d6..25a74d497255 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1723,7 +1723,6 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
 {
 	uint64_t tlb_seq = amdgpu_vm_tlb_seq(vm);
 	bool all_hub = false;
-	int xcc = 0, r = 0;
 
 	WARN_ON_ONCE(!vm->is_compute_context);
 
@@ -1739,13 +1738,8 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
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

