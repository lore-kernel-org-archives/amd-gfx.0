Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DEEC55822
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 15:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A1F710EAE9;
	Tue,  4 Aug 2026 15:28:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KbI1TnMv";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013066.outbound.protection.outlook.com
 [40.93.196.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E1010EAE9
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 15:27:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uu1F/wGiTHl7Ovnglk98LPQfVsD4ZSa1nlcr6uVG8azmZ+XSZVpwlZbRwYorI3OP9v8pOWhGcAShfesNDMImgVEeC13b9335MNQoCkxY8Km9iRRK4I/Xq1AHM0eN6ZDmuCzn/aKhuoRqJgY52dNwnHLBDtjSdepx+NoUHUI55f+t58+JvKdCjQIRd5QSve1k2rKhD423DaucCUvGH11L3V8nksmDxt3NpETLE0ii0BoFAWuzPlTQsoJBmeBiBCHK1Hv+/r91ZNRIimV478KOYiHSnbEIyQTcC1uhW6MMhWYQsfW3ZBUoxhYfQG3ZEQ2k6L8c+MzK9Le9yHwD3WMbOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuhHUHH1YxHt+K0roBVno/H4xgTTHecxbCQ5+VlgDSE=;
 b=pZR9c9siL57LxXTgRndlTGqSykf+6hrTfdr9MrKhYfBk8CsQl1qj/5K01xQ5BODm5sGB7AXGU+dO98Bl1i03mNy01O8g2xCqdamURYs5YkDk/NGLzqLXFQKvNUGEHvr1c/pd7YGJCG1C3V0PJweeVgqPUkGGbcwIwMUufTMi0mNIzkciOGOm7sI2rf01zcDKykbQpgjmjmLGOVAR1But0YbM+Pi4WgKUWJdthVWzyHfqR77qKcg9EhLwZx3bH64XGPiJFtIqeKvTSSeHZn2ANV1mceNrrdzvFJyw8gzOrFS7eGaFrIO4HYN4UcAOaoHNRWUNTbgs5mQ7U7iCK5JOSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuhHUHH1YxHt+K0roBVno/H4xgTTHecxbCQ5+VlgDSE=;
 b=KbI1TnMv/MlmKUofAzWWiIRGrpB1n+2tdFnH90AJpTFHLGpmhZKqBh9HzfHWb4K2WhKLUJpnw/0kX8kez7mquTPACqmEOI1EU2/8Noeo81263ssqBxnFnU+yX6TF2ILRONfpN6QSP6KZcZbWmRPvt3hxDD1tgiJEztdJhGWEPW0=
Received: from CY5PR17CA0003.namprd17.prod.outlook.com (2603:10b6:930:17::11)
 by SA1PR12MB8987.namprd12.prod.outlook.com (2603:10b6:806:386::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 15:27:14 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::90) by CY5PR17CA0003.outlook.office365.com
 (2603:10b6:930:17::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 15:27:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 15:27:13 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 4 Aug 2026 10:27:11 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: split tlb_seq into per-VMHUB counters to avoid
 spurious MMHUB flushes
Date: Tue, 4 Aug 2026 11:26:35 -0400
Message-ID: <20260804152635.899680-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|SA1PR12MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: 22bc7be5-fd29-419d-06f4-08def23cdc3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|11063799006|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: IfwL2o6ESwx5AQbrKW+Y5Ty4s9/yymhxbNLBduu1H2DIltqmIRA8gi8F+vA+2gI/R5TvIAjLs8A880JzgEU3Zo+qZGEd/wsirMe+z7+19a5j6BhlglhOo+W7H9TnLapXxaC1schvSiMlfsrx++OvZ5Oi9e8e1kC5am89GFsth4KI0WV+mthr9HcRd8k48qSABqeDen4agVPs/0YDGEsDUQG0f3frg0SK21aAeJ9nAmXpggj2bpJQ6MQldJxo8QjPBuKBPOZof19WDVVN5UokmZjk7lW6acIiqdLpVQejaIL3Di12sr3HujlJPxHdZ7eG10s5nXmyBWZNe1E95QZ1IudS/F2Wy9HbxeRcRNyXXD8onZtvPnucwpFt2gMI/rHqfAcAr4XKAF4Cb+4HoMGTWGXqeeOnxBAmmUGxgq0ZNN/RFrE9WQwd5977oplX1eggriJfEfrGRG1Ha/6rysOvkENJgM6yaGLj7vIbjaVwiRAdInF1KaMFJN0vmUXe+lwFu7or0d4hh9rRLXCfBtamMRv3NaNhxDUlZgC4uEQNjg7D817Nz3Kdn4XC5/e874e53Fi/bix5W/wlXL8UNwURkJxGvSeTno+q/1h+XH2xn3oqJZmhcaMM63gZOZyxO79MRR671Eo8n/LlLCVskvlOTQhhyQhBLHLglEMT3TOtGXdtFCPYG/5xAEXDJCFCxzX8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(11063799006)(3023799007)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iIrYQprtSPObJTaJWkAf5ndn6cvGegXLQd83JuybVH8CvCF21lH8cV5CirLhpIn6tsriyadfj1GA61s7XKV0Emk+Hoc9O6Vr3ue17CKO6HfWyFfIrzAapIjXIXKyfTodf+1yGgq92NghA8CkRCCuEgrXxhlsTG8v8LUGRlfUvrG5Ndbg6pQyUlXB7/UUZnV5ptHsMtlSPSdYEkcff5JbtQZn1/4ljUilbyVkNLsrZ7uxAe9oL/kX3UW55R6TS35s09DgNeIrZRJWBy0U0Ho9oG+1GN37qCd/dVC8p+xJkeCBRQulsYfuJhgfKOnsCbZiITUHXvj9lUjb4m22ivaQmiSCN6/W9UEFyywfwqPCwh3f5s9bfU5UNQxaNykaDKPy1ubGYkncOC9Eqpb0cAReEuqmVzP6kATQeid7TcwhoihijYEtWKVAsvI0LEx80eCe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:27:13.9033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22bc7be5-fd29-419d-06f4-08def23cdc3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8987
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

On hardware where EFC (Encode Frame Copy) is unavailable or the source
frame format requires conversion, the VA-API frontend falls back to a
GFX/compute shader blit (vl_compositor) to perform color space conversion
before VCN encode.  That blit goes through the GFX/compute ring and bumps
the VM's shared tlb_seq.  Every subsequent VCN encode job then finds
flushed_updates < tlb_seq and forces a full MMHUB TLB flush, even though
no MMHUB-relevant mappings changed.  On multi-instance VCN hardware the
same issue is compounded by the dedicated PIPE_CONTEXT_COMPUTE_ONLY
scheduling context Mesa creates.

Fix this by splitting the single tlb_seq into two counters:

  tlb_seq    - bumped only when mappings accessed by GFXHUB change
  tlb_seq_mm - bumped only when mappings accessed by MMHUB change

To know which hubs are relevant for a given PT update, add a vmhub_mask
parameter to amdgpu_vm_update_range().  The mask is derived from the set
of rings in each command submission (collected in amdgpu_cs.c and stored
in bo_va->vmhub_mask / mapping->vmhub_mask).  When vmhub_mask is 0 (BO
has never been submitted), both counters are bumped conservatively.

PDE updates and XGMI/GFX8 legacy paths bump both counters since they
affect all hubs.  The fault handler uses GENMASK(AMDGPU_MAX_VMHUBS-1,0)
because the faulting hub is unknown at that point.

MMHUB VMID allocation (amdgpu_ids.c) now compares flushed_updates against
tlb_seq_mm instead of tlb_seq, so VCN VMIDs no longer force a TLB flush
when only GFX/compute page tables changed.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Assisted-by: Claude:Claude-Sonnet-4-6
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     | 37 ++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    |  9 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 65 +++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     | 32 ++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c       |  5 +-
 6 files changed, 129 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index afc1c631d55a..33c1e9341774 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1136,19 +1136,34 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	 * with p->ticket. But removing it caused test regressions, so I'm
 	 * leaving it here for now.
 	 */
-	amdgpu_bo_list_for_each_entry(e, p->bo_list) {
-		bo_va = e->bo_va;
-		if (bo_va == NULL)
-			continue;
+	/* Collect vmhub bitmask for all rings in this submission */
+	{
+		uint16_t sub_vmhub_mask = 0;
 
-		r = amdgpu_vm_bo_update(adev, bo_va, false);
-		if (r)
-			return r;
+		for (i = 0; i < p->gang_size; ++i) {
+			struct amdgpu_ring *ring = amdgpu_job_ring(p->jobs[i]);
 
-		r = amdgpu_sync_fence(&p->sync, bo_va->last_pt_update,
-				      GFP_KERNEL);
-		if (r)
-			return r;
+			if (ring)
+				sub_vmhub_mask |= BIT(ring->vm_hub);
+		}
+
+		amdgpu_bo_list_for_each_entry(e, p->bo_list) {
+			bo_va = e->bo_va;
+			if (bo_va == NULL)
+				continue;
+
+			/* Track which hubs have accessed this BO for per-hub tlb_seq */
+			bo_va->vmhub_mask |= sub_vmhub_mask;
+
+			r = amdgpu_vm_bo_update(adev, bo_va, false);
+			if (r)
+				return r;
+
+			r = amdgpu_sync_fence(&p->sync, bo_va->last_pt_update,
+					      GFP_KERNEL);
+			if (r)
+				return r;
+		}
 	}
 
 	r = amdgpu_vm_handle_moved(adev, vm, &p->exec.ticket);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 8a2d64f0ebc3..9183569d340a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -331,7 +331,8 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 	unsigned vmhub = ring->vm_hub;
 	uint64_t fence_context = adev->fence_context + ring->idx;
 	bool needs_flush = vm->use_cpu_for_update;
-	uint64_t updates = amdgpu_vm_tlb_seq(vm);
+	uint64_t updates = AMDGPU_IS_GFXHUB(ring->vm_hub) ?
+		amdgpu_vm_tlb_seq(vm) : amdgpu_vm_tlb_seq_mm(vm);
 	int r;
 
 	*id = vm->reserved_vmid[vmhub];
@@ -395,7 +396,8 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 	unsigned vmhub = ring->vm_hub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	uint64_t fence_context = adev->fence_context + ring->idx;
-	uint64_t updates = amdgpu_vm_tlb_seq(vm);
+	uint64_t updates = AMDGPU_IS_GFXHUB(ring->vm_hub) ?
+		amdgpu_vm_tlb_seq(vm) : amdgpu_vm_tlb_seq_mm(vm);
 	int r;
 
 	job->vm_needs_flush = vm->use_cpu_for_update;
@@ -492,7 +494,8 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 
 	job->gds_switch_needed = amdgpu_vmid_gds_switch_needed(id, job);
 	if (job->vm_needs_flush) {
-		id->flushed_updates = amdgpu_vm_tlb_seq(vm);
+		id->flushed_updates = AMDGPU_IS_GFXHUB(ring->vm_hub) ?
+			amdgpu_vm_tlb_seq(vm) : amdgpu_vm_tlb_seq_mm(vm);
 		dma_fence_put(id->last_flush);
 		id->last_flush = NULL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index ff11a0903499..1d6373f1d985 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -70,6 +70,8 @@ struct amdgpu_bo_va_mapping {
 	uint64_t			__subtree_last;
 	uint64_t			offset;
 	uint32_t			flags;
+	/* bitmask of VMHUB indices whose TLBs have cached this mapping's PTEs */
+	uint16_t			vmhub_mask;
 };
 
 /* User space allocated BO in a VM */
@@ -91,6 +93,9 @@ struct amdgpu_bo_va {
 
 	bool				is_xgmi;
 
+	/* bitmask of VMHUB indices that have ever submitted jobs referencing this BO */
+	uint16_t			vmhub_mask;
+
 	/*
 	 * protected by vm reservation lock
 	 * if non-zero, cannot unmap from GPU because user queues may still access it
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index aac8ace9d7a6..b05befa1d5c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -121,6 +121,11 @@ struct amdgpu_vm_tlb_seq_struct {
 	 */
 	struct amdgpu_vm *vm;
 
+	/**
+	 * @vmhub_mask: which hub counters to increment (bitmask of VMHUB indices)
+	 */
+	uint16_t vmhub_mask;
+
 	/**
 	 * @cb: callback
 	 */
@@ -1008,8 +1013,10 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	if (flush_tlb_needed)
+	if (flush_tlb_needed) {
 		atomic64_inc(&vm->tlb_seq);
+		atomic64_inc(&vm->tlb_seq_mm);
+	}
 
 	list_for_each_entry_safe(entry, tmp, &vm->kernel.needs_update,
 				 vm_status)
@@ -1031,9 +1038,25 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
 				 struct dma_fence_cb *cb)
 {
 	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
+	bool any_gfx, any_mm;
+	unsigned int i;
 
 	tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
-	atomic64_inc(&tlb_cb->vm->tlb_seq);
+
+	any_gfx = any_mm = false;
+	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
+		if (!(tlb_cb->vmhub_mask & BIT(i)))
+			continue;
+		if (AMDGPU_IS_GFXHUB(i))
+			any_gfx = true;
+		else
+			any_mm = true;
+	}
+	if (any_gfx)
+		atomic64_inc(&tlb_cb->vm->tlb_seq);
+	if (any_mm)
+		atomic64_inc(&tlb_cb->vm->tlb_seq_mm);
+
 	kfree(tlb_cb);
 }
 
@@ -1054,6 +1077,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 	struct amdgpu_vm *vm = params->vm;
 
 	tlb_cb->vm = vm;
+	tlb_cb->vmhub_mask = params->vmhub_mask;
 	if (!fence || !*fence) {
 		amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
 		return;
@@ -1106,7 +1130,8 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
  */
 int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			   bool immediate, bool unlocked, bool flush_tlb,
-			   bool allow_override, struct amdgpu_sync *sync,
+			   bool allow_override, uint16_t vmhub_mask,
+			   struct amdgpu_sync *sync,
 			   uint64_t start, uint64_t last, uint64_t flags,
 			   uint64_t offset, uint64_t vram_base,
 			   struct ttm_resource *res, dma_addr_t *pages_addr,
@@ -1129,13 +1154,20 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	/* Vega20+XGMI where PTEs get inadvertently cached in L2 texture cache,
 	 * heavy-weight flush TLB unconditionally.
 	 */
-	flush_tlb |= adev->gmc.xgmi.num_physical_nodes &&
-		     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 0);
+	if (adev->gmc.xgmi.num_physical_nodes &&
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 0)) {
+		flush_tlb = true;
+		/* XGMI: all hubs need flushing */
+		vmhub_mask = GENMASK(AMDGPU_MAX_VMHUBS - 1, 0);
+	}
 
 	/*
 	 * On GFX8 and older any 8 PTE block with a valid bit set enters the TLB
 	 */
-	flush_tlb |= amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 0);
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 0)) {
+		flush_tlb = true;
+		vmhub_mask = GENMASK(AMDGPU_MAX_VMHUBS - 1, 0);
+	}
 
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
@@ -1144,6 +1176,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.pages_addr = pages_addr;
 	params.unlocked = unlocked;
 	params.needs_flush = flush_tlb;
+	params.vmhub_mask = vmhub_mask;
 	params.override_pte = allow_override && adev->gmc.override_pte;
 	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
 
@@ -1366,9 +1399,18 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 
 		trace_amdgpu_vm_bo_update(mapping);
 
+		/*
+		 * If vmhub_mask is 0, no ring has submitted a job with this BO
+		 * yet, so we don't know which hubs may have cached its PTEs.
+		 * Be conservative and bump all counters.
+		 */
 		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
-					   !uncached, &sync, mapping->start,
-					   mapping->last, update_flags,
+					   !uncached,
+					   bo_va->vmhub_mask ?
+					     bo_va->vmhub_mask :
+					     GENMASK(AMDGPU_MAX_VMHUBS - 1, 0),
+					   &sync,
+					   mapping->start, mapping->last, update_flags,
 					   mapping->offset, vram_base, mem,
 					   pages_addr, last_update);
 		if (r)
@@ -1572,6 +1614,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		list_del(&mapping->list);
 
 		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
+					   mapping->vmhub_mask ?
+					     mapping->vmhub_mask :
+					     GENMASK(AMDGPU_MAX_VMHUBS - 1, 0),
 					   &sync, mapping->start, mapping->last,
 					   0, 0, 0, NULL, NULL, &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
@@ -1989,6 +2034,8 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 
 	list_del(&mapping->list);
 	amdgpu_vm_it_remove(mapping, &vm->va);
+	/* Copy hub mask before clearing bo_va pointer (freed list loses the link) */
+	mapping->vmhub_mask = bo_va->vmhub_mask;
 	mapping->bo_va = NULL;
 	trace_amdgpu_vm_bo_unmap(bo_va, mapping);
 
@@ -2212,6 +2259,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
 		list_del(&mapping->list);
 		amdgpu_vm_it_remove(mapping, &vm->va);
+		mapping->vmhub_mask = bo_va->vmhub_mask;
 		mapping->bo_va = NULL;
 		trace_amdgpu_vm_bo_unmap(bo_va, mapping);
 		list_add(&mapping->list, &vm->freed);
@@ -3048,6 +3096,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	}
 
 	r = amdgpu_vm_update_range(adev, vm, true, false, false, false,
+				   GENMASK(AMDGPU_MAX_VMHUBS - 1, 0),
 				   NULL, addr, addr, flags, value, 0, NULL, NULL, NULL);
 	if (r)
 		goto error_unlock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 2f8234560764..deeb43a7ef86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -313,6 +313,11 @@ struct amdgpu_vm_update_params {
 	 */
 	bool needs_flush;
 
+	/**
+	 * @vmhub_mask: bitmask of VMHUB indices whose tlb_seq counters to bump
+	 */
+	uint16_t vmhub_mask;
+
 	/**
 	 * @override_pte: true for memory that is not uncached and gmc override function is
 	 * implemented to allow MTYPE to be overridden for NUMA local memory.
@@ -403,6 +408,8 @@ struct amdgpu_vm {
 
 	/* Last finished delayed update */
 	atomic64_t		tlb_seq;
+	/* Separate TLB flush sequence for MMHUB rings (VCN/JPEG/VPE) */
+	atomic64_t		tlb_seq_mm;
 	struct dma_fence	*last_tlb_flush;
 	atomic64_t		kfd_last_flushed_seq;
 	uint64_t		tlb_fence_context;
@@ -528,7 +535,8 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
 int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			   bool immediate, bool unlocked, bool flush_tlb,
-			   bool allow_override, struct amdgpu_sync *sync,
+			   bool allow_override, uint16_t vmhub_mask,
+			   struct amdgpu_sync *sync,
 			   uint64_t start, uint64_t last, uint64_t flags,
 			   uint64_t offset, uint64_t vram_base,
 			   struct ttm_resource *res, dma_addr_t *pages_addr,
@@ -649,6 +657,28 @@ static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
 	return atomic64_read(&vm->tlb_seq);
 }
 
+/**
+ * amdgpu_vm_tlb_seq_mm - return MMHUB-specific tlb flush sequence number
+ * @vm: the amdgpu_vm structure to query
+ *
+ * Returns the tlb flush sequence number for MMHUB rings (VCN/JPEG/VPE).
+ * Only bumped when mappings accessed by MMHUB engines change.
+ */
+static inline uint64_t amdgpu_vm_tlb_seq_mm(struct amdgpu_vm *vm)
+{
+	unsigned long flags;
+	spinlock_t *lock;
+
+	rcu_read_lock();
+	lock = dma_fence_spinlock(vm->last_tlb_flush);
+	rcu_read_unlock();
+
+	spin_lock_irqsave(lock, flags);
+	spin_unlock_irqrestore(lock, flags);
+
+	return atomic64_read(&vm->tlb_seq_mm);
+}
+
 /*
  * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
  * happens while holding this lock anywhere to prevent deadlocks when
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 30ad10bbd47e..fb888f200f70 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1372,7 +1372,9 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return -EINVAL;
 	}
 
-	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, gpu_start,
+	return amdgpu_vm_update_range(adev, vm, false, true, true, false,
+				      GENMASK(AMDGPU_MAX_VMHUBS - 1, 0),
+				      NULL, gpu_start,
 				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
 				      fence);
 }
@@ -1490,6 +1492,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 			 pte_flags);
 
 		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, true,
+					   GENMASK(AMDGPU_MAX_VMHUBS - 1, 0),
 					   NULL, gpu_start, gpu_end,
 					   pte_flags,
 					   (last_start - prange->start) << PAGE_SHIFT,
-- 
2.43.0

