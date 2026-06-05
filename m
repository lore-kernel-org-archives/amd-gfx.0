Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E41FCD8C85
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 22:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB9AD11AB8A;
	Fri,  5 Jun 2026 22:19:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FB7slmTs";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013059.outbound.protection.outlook.com
 [40.93.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4886411AB8A
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 22:19:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPn8tv+ekf9vxZmf82UhFQwXTorS+Iy7aJgEYLyvv8pKWyQnMrulJPP6S2pshXwGE4Kq3MyGku/t4aQqDZiPYRalYQeP4fsAJUaqtUJ0jDPUr4DdDAg2n730vqMbZgt/VpxXKWsBBgAsZIOTd2dz5ZAJOHsuHAvLNye+xERtWPFpgqSEFQ1hq2Fttf0snhO0wIO773JZ6uFD0ln6TDMsOjBzcTvkuePTVsenyma0U78t3QTDP3qMeXPtwJ22gjBUi74F7GzTxOd426PvcHJbZQwOy5nDCyCVYVciJ+/Ipe/lj2Ac5AzYjGUZX0eK1DPP/ovRK5DhQVXSkfp0tJfIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFaSvs0NcP8KEeRA7gHr2ntq4uLXYQYu9Od8gTCQO00=;
 b=R+sH4ykqMpz2xo+n+NuPPVa8oIlVYVnZtJIwiPlqlq3JddI2PUNjX9u9U4H+3RHbzp7ng0fLh8lVXh9B0ZeHhKYrVmK5WDZMt2+7tizHv1mScj7zmIXQN2wg33QixLLJ1dcFR1M583Uwx2PtBB9YWvumO+j3bMu5I2WqYwrWh21pbKdTG4pamNSdDLA5WuPp/biV7uibsX79G+o6wJ3Pb8Z/c8q6COvYZo+gsLW5AQ18nY/+pec696BSffOgqFlwO0mJepuUrMMFeioHEs8u7JJTv4L2TzJJX7EtnvgziQPg0RV3ncrn0YIeMPMYs7dEcAvtM5/fgOrQQjII53bF5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFaSvs0NcP8KEeRA7gHr2ntq4uLXYQYu9Od8gTCQO00=;
 b=FB7slmTsm+TutS+V3c2M90Gq6Nn2KqA8OG3krH5NibPtf0DGLWm4eArD9cXadLPbZYeYOzqUd9nEJNVhKN6ie9zHpaYF/q6uWfxzHaghxRVSMLeus0fFlhFAZmOE3ZM9zHBZaNgMxeaJgdB1Cb20TA8alNL/tUX+0aX9FNhud64=
Received: from SJ0PR05CA0065.namprd05.prod.outlook.com (2603:10b6:a03:332::10)
 by SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 22:19:06 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::1d) by SJ0PR05CA0065.outlook.office365.com
 (2603:10b6:a03:332::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 22:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 22:19:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 17:19:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 15:19:05 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 17:19:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: handle GDS and SPM without a VM fence
Date: Fri, 5 Jun 2026 18:18:53 -0400
Message-ID: <20260605221853.903153-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605221853.903153-1-alexander.deucher@amd.com>
References: <20260605221853.903153-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: f832c174-3d83-4d11-822f-08dec350751f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WYyLafZwyUf5+C+bd0xcsYcS0qSMRgpIh9wJH7Hx1yjVtMIe2if+qsbbrzau+aBkvUh3f32DJXkvnAD9SsfmfdLH+h0M6fecoAT/mXZDddhrEpL6nLICKkPcWLuhZmqCxZIV1hfPP+Ic7it7i7NHG3BjASAxGYnGRlWvi1LNTz4IQ8XeqrU7YfqWWs0pACwj2AtPbOaS8/We8EE2/8CIMhuxlw+wIUU65owXLRbXMrabPeoLQLOl1967zCGwT4pSJIkM8zC8MA1tGj8Y+QUaapJPujbFv2TyHHPRDDQtjJl1KlwTDpm88Sp8Hqg8yGtIBq8sxSW3rKWPLiF4XSZWfcsNgx/fA89tLo7BYPcCQgDEB+9XGquJhpJalTtZ2BtD9MhSTfum4HU2gcMmlWFY90ysxKSOkMbUK/qJkd1VRHUPLRGU7MwMY95/Zp1RZeJflvb/NyeVAvbr7xTTs1kkvjpb/S9wymn5Elp+x28w9Iq53uAeI0IHD7CpxGvlxMi+XmnPguryzUhwf1j+vNQtDKzZIDIi8DGkvcktWSn3smCO/Eo/78AsWUhMczc6VEN4TzcHXKddtOH3wsLRpNRy8nnaixNweFSQfz4jwlLWNnYZrLYNxyRAZe/K11g6rGvrZrf9Jdtg4vopnGOBQgC1/3YXCy9Rj9m7QCUyxKtxV4JsPhQGXkTLKrgYNqvPNJtGIKdpurUSMwmkUEQCATOuyr8Ydo98M73kj0ek8SJy54E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gddQ7W/Ig1zngIUovaoNWFEGgM0BqfJ3MYR3IIeb9Kc9jyr8NcGGYsOhSXJKYEGwITPG6lXADNqaS9Lds3QjKxCZ8mLPWOnGZ7buxpO3Gn2FTmCJWBq0KEeoz/RkHI0ZSvwXg2s6xTf5fU7aMOzBJGboDQSTo13IV+vOz1M5jsQOU+wL6Lp8L/H3Xfw/kRTJkS6tpent6VueMhpLLxlJFIbCEJJNIMMN9yPsw7q90tu8acHR84du7jYtOrgGnUANeL45D9CacILSfr2k2rvMyqdwDKFrAnpM43dlccxBkoN1rR/lv5r16ivBktg/wWCJlh88/ZRsRhcn0y22zPESNUDUjZnczBKkKFZKh78jwdGwERadiE/5Az0T+dxqGWsERgOIHMGvHgp7GBoTKroW26w3Yu5t9G9X0ZjK2ox2gEH3bukUc6nVRtx4cApWWcKv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 22:19:06.2271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f832c174-3d83-4d11-822f-08dec350751f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871
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
index 13031e4b6f1d5..339902c41fc7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -764,18 +764,22 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
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
@@ -783,6 +787,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool pasid_mapping_needed = false;
 	struct dma_fence *fence = NULL;
 	unsigned int patch = 0;
+	bool emit_fence;
 
 	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
 		gds_switch_needed = true;
@@ -798,6 +803,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	mutex_unlock(&id_mgr->lock);
 
 	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
+	spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
 	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
 			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
 	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
@@ -808,6 +814,17 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
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
@@ -842,21 +859,21 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
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
index cc096c005e348..b67eeec464e09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -514,7 +514,9 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
2.54.0

