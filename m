Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5BCC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 18:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2EBC10E638;
	Mon, 13 Jul 2026 18:24:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TFcsnf3e";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011048.outbound.protection.outlook.com
 [40.93.194.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BCDB10E638
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 18:24:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2V39Rxr7SBIEj+WLD5TJKs6Pzbe8kjVj6Ekp3UKHXugbxFNodigJXdjeqRcJ8l5IOHd/WeDBfcgbbisOgoZbHnuZ4rFL3UwYhvQyaoe1OBwFCoqtNIzFq5zTxBmTJY5iOLuViAasg3n40NP4dsBjkaz6T3mK31eExeduijVKY5xRiI2du/P1vmZr9Ed4tsMvhV6yd3l3kauFkRRGEJ4uWPs2RaWxjDvFyEdNeYCR4cpeQYlpYKdv55SoP4kmqaxK5lC/e9dYK7yg65aV0TPEqBe90vAKoUe9zHv14zh9klLDWjEAbKZRhOqby0QOLXLwkClfBojoOzKCt1iE99SCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b/6aNL0PirNs9EVd0VMxzna9BKZP6mYUvP4NYN3uEs=;
 b=LLwdftSNSHI+YEfE//GN5XOUBC5zuwL1MytDgkyqw0xsQ/Ei7ahaSBerxHtswHFEd01XSljdgDNjf7Txe3nMTGVNEP6Do/V5K96WUufOKtBv/65mjV1HebTH4ahdHQs5iq0zphf1ofzUqFl+gwupEOxYUkBksC9y/5TKaV3y3WVT6nPDCTCjwwWPymHxrRU3wq2XV/PO3q/8vlZleIyNfnGt6vmg1+RmlLQyjnrx0zUIqheeAiVsmejDw+jBx4jgi03LWFfz617y5I28izAaA8h4IzCCCqJhGlQQbnh/NYBTovVbnG5AHuSRsgYPgYGIdpEjuRR80BQmvXpWsJ7Wag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b/6aNL0PirNs9EVd0VMxzna9BKZP6mYUvP4NYN3uEs=;
 b=TFcsnf3evAycaHjNa5ZsHHIKlpzuJVTDJ2VzShvuagi+mLcfkw94Su7EpILhOe8hv4zbg0lkueoG7ul5dt4WPA0HxTQ6tAbS1X0faZ3DfVMrywG5x0DI1IY6tihShS1en4HHsvT4QavarptqpIiShq/95uZ0N5YXOYSehMDvbsY=
Received: from SN7PR04CA0212.namprd04.prod.outlook.com (2603:10b6:806:127::7)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 18:24:38 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::6f) by SN7PR04CA0212.outlook.office365.com
 (2603:10b6:806:127::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 18:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 18:24:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 13:24:37 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 11:24:37 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 13:24:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: handle GDS and SPM without a VM fence
Date: Mon, 13 Jul 2026 14:24:14 -0400
Message-ID: <20260713182414.630372-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713182414.630372-1-alexander.deucher@amd.com>
References: <20260713182414.630372-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: adae3119-dafd-4f2f-4419-08dee10bffb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: qsyHdgIY1SkkiNQYLZaQcu+XRx/11uPLET7eeHCAExDu5iz8CLjDErX9a9fguXHtfx4py47+aEI9DcZ7A4flkUNpRsU0rW/b3QPQNhm8O+blYqWGb4LGSV2tizzqOaX/1+KKCKCS8F9trcbyeYq5cUeKZWX3OtUieBV25oDR9nzhyBVdYrJOqNrqMUDoCrK290L/D2Dn931GfL/v3i0Lc2M/BOW9Oz0ILxbjLhiJd0pLmGZbpOF/S6uNf5eM9sRRhy3slgUFFcRfXhSxXZuNnDYyCgb/u9cYprlj8bSAuLMKG1KziSP4GE4LUYVA82vIMCgc70hkMlQS82ZA4mK8UPIHq/+GKNG1jcb1AVdbku8hAJRY1NLMA2oXr/EyxX+SD3I74q8DcUp1hKzVbUmPFbmR1EjxBXas0LLU2gw8OaxblRcsO0vp7FBCrubc3pIdSqBZ9gVdqjVIsAioiHnX03Qiigiy3IrRlrUK21mWUhYGAMqT5kmi2hIk4zAEkjqd98I5DeD51Y+oKXBN+De2f8VLbGApp/Ylj0niuuVE6mHYTVT7GRh6PJtLNTym80LjhWkBzEcuSko1z2xKDIG5iD4vdaf0XqZ/rXASSwjc+BwBDA3eJaimqJ/XWg0KL8Cu1DkmTnrEAuD/yvUJ0Nn7bwcNz4hcyf4iEuI/8j1EoWCgpyczmvo6icWaQuec8bqzZo/zddtIvllpLtT+FBs+ZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BlXH2r4MhFqIFxGbudHlM0KvYJTMcpdUybIZL+ixdUuLlKXEbcK247Mto33vWQYDVrnCJyzlaWjxEZ+MeD3kx0IIi/ApmyJvusFcmXK7ReV4QOzLLFH9AgyZlNKzUKNiob0hG99v68f5fQgz0BxVKRnmTQjEFYYE9q8Ka0Of+zv8WLnAEIBDFmpS+nDfgcJWY60S9mP5SaO9FGq7ptGGGcIIG3KECsX6kcnMnMp/sqdIysjrwi1PL7GbqPiVTHkEXFxB24mF4xeldFXoMJ07Ij3rpTr4nmlZFseP989uItHetm875esVYY4RmyMVm5aMtKPcWUacQb29tydzWvtCxHm7+tX9Kf7WldO9qcFlBrEBBNsCUBusBzp3lKuDDm5rliKR/M2MSnjkPb917niyw/hlCpbDRbVjP33l73T2PftEPMxAL+tXq236lYlTWjZ7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:24:38.3705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adae3119-dafd-4f2f-4419-08dee10bffb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708
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

If we end up emitting a VM fence keep GDS and SPM
associated with that fence.  If not, emit them as
part of the IB fence.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 14 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 47 ++++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  4 ++-
 3 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index f1ed4a436f5b4..d439c68eed9de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -131,6 +131,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	struct amdgpu_fence *af;
 	struct amdgpu_fence *vm_af;
 	bool need_ctx_switch;
+	bool emit_spm_needed = false;
+	bool emit_gds_needed = false;
 	struct amdgpu_vm *vm;
 	uint64_t fence_ctx;
 	uint32_t status = 0, alloc_size;
@@ -220,7 +222,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		vm_af = job->hw_vm_fence;
 		/* VM sequence */
 		vm_af->ib_wptr = ring->wptr;
-		amdgpu_vm_flush(ring, job, need_pipe_sync);
+		amdgpu_vm_flush(ring, job, need_pipe_sync, &emit_spm_needed,
+				&emit_gds_needed);
 		vm_af->ib_dw_size =
 			amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr, ring->wptr);
 	}
@@ -232,6 +235,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	if (ring->funcs->insert_start)
 		ring->funcs->insert_start(ring);
 
+	if (emit_spm_needed)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
+
+	if (emit_gds_needed)
+		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
+					    job->gds_size, job->gws_base,
+					    job->gws_size, job->oa_base,
+					    job->oa_size);
+
 	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
 		ring->funcs->emit_mem_sync(ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index aec8468634535..756810c606d80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -766,18 +766,22 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
  * @ring: ring to use for flush
  * @job:  related job
  * @need_pipe_sync: is pipe sync needed
+ * @emit_spm_needed: does the caller need to emit spm
+ * @emit_gds_needed: does the caller need to emit gds
  *
  * Emit a VM flush when it is necessary.
  */
 void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
-		     bool need_pipe_sync)
+		     bool need_pipe_sync, bool *emit_spm_needed,
+		     bool *emit_gds_needed)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_isolation *isolation = &adev->isolation[ring->xcp_id];
 	unsigned vmhub = ring->vm_hub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
-	bool spm_update_needed = job->spm_update_needed;
+	bool spm_update_needed = adev->gfx.rlc.funcs->update_spm_vmid &&
+		job->spm_update_needed;
 	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
 		job->gds_switch_needed;
 	bool vm_flush_needed = job->vm_needs_flush;
@@ -785,6 +789,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool pasid_mapping_needed = false;
 	struct dma_fence *fence = NULL;
 	unsigned int patch = 0;
+	bool emit_fence;
 
 	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
 		gds_switch_needed = true;
@@ -800,6 +805,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	mutex_unlock(&id_mgr->lock);
 
 	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
+	spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
 	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
 			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
 	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
@@ -810,6 +816,17 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		ring->funcs->emit_cleaner_shader && job->base.s_fence &&
 		&job->base.s_fence->scheduled == isolation->spearhead;
 
+	emit_fence = !!(vm_flush_needed || pasid_mapping_needed ||
+			cleaner_shader_needed);
+
+	*emit_spm_needed = spm_update_needed;
+	if (spm_update_needed && emit_fence)
+		*emit_spm_needed = false;
+
+	*emit_gds_needed = gds_switch_needed;
+	if (gds_switch_needed && emit_fence)
+		*emit_gds_needed = false;
+
 	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
 	    !cleaner_shader_needed && !spm_update_needed)
 		return;
@@ -844,21 +861,21 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (pasid_mapping_needed)
 		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
 
-	if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
+	if (emit_fence) {
+		if (spm_update_needed)
+			adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
 
-	if (ring->funcs->emit_gds_switch &&
-	    gds_switch_needed) {
-		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
-					    job->gds_size, job->gws_base,
-					    job->gws_size, job->oa_base,
-					    job->oa_size);
-	}
+		if (gds_switch_needed)
+			amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
+						    job->gds_size, job->gws_base,
+						    job->gws_size, job->oa_base,
+						    job->oa_size);
 
-	amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
-	fence = &job->hw_vm_fence->base;
-	/* get a ref for the job */
-	dma_fence_get(fence);
+		amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
+		fence = &job->hw_vm_fence->base;
+		/* get a ref for the job */
+		dma_fence_get(fence);
+	}
 
 	if (vm_flush_needed) {
 		mutex_lock(&id_mgr->lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 939f639cd8bfd..f82572b71c5ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -515,7 +515,9 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       struct ww_acquire_ctx *ticket,
 		       int (*callback)(void *p, struct amdgpu_bo *bo),
 		       void *param);
-void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
+void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
+		     bool need_pipe_sync, bool *emit_spm_needed,
+		     bool *emit_gds_needed);
 int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm, bool immediate);
 int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
-- 
2.55.0

