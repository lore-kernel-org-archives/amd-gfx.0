Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69830C5DF74
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 03:24:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E0610E494;
	Tue, 18 Aug 2026 03:24:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DRkBmuKg";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A5E10E494
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 03:24:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjO6rF6RrX74NysqiRhgmDQn2tzYv+L6vGZTYmvoMoTbYJoVZgvG07NzYhXzRi/xiC7lHko4UzqpRBX5XdvN/vQh0Y2da+JgBBk1XWCcKWWLhyx58SGj3UfnVkwAO0ftX8YcfzHtyE9HLrmdpxfvtYwXXS4e1DTD/5c71fZ4ZaHG19d8pEJQst2PHFXIGaN3SsAuUUnQ5VnnQva0VboHkGcRqdGOPPHs+IFueHMo7C4oweaspuCkRhiHV0VBwqKk1D3mX+Fyyav9pxHRxBv3zjuV0DN8bCcUrh9Oj8XzmxJMyaqbpW9dfMA3opOGj3mv4QJRes4fiU5XclwHVioBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKDP1BRk6zR/2zP0qIPNU03pZcq4ikvaNIz26obHIWE=;
 b=Wg+PmDQVAtqMnsfN5JTifCZUEB7bPaYJvdMzyWQmCcf9hwGqGRhJaW6OKSB+q1Y0UpGFDsGseFjXAoHKW5UdXQMmgTXC/tsmpuMQ8JxySJCEms/tKCrCdjheyJrU/PttMSwqsacbT28WzhaEyfDQN2dHHhkXnz2SPzcftGRQI7vk9QWJUZbkPWnvd5c1KXk2whntX1ML8pNimo2M1TCToFP2oiwiYW13n+HwEGNqXeXwzHmP+5+QsFiHRT1wNWI1AlDAWAaGvinSU9EgG0C7M8dyFnwkNbiOlSRSVQujzpQSI/9sk+G1NktHx5wct/nzgoPNPJBagPeLZc5Rl00MRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKDP1BRk6zR/2zP0qIPNU03pZcq4ikvaNIz26obHIWE=;
 b=DRkBmuKgb4CG3USCaBzZhuiA+a1etAVEcRkLKK5VKi9rHu7TP/BSdwMARl422nR50v1NQvGyN4IqJ3VwoEngrEE0VXHGLndu4RDz46bHTtZ1IpY4CA6mn52/Z9LhR3NOAD7FAGT/xmQx+ylXLnB5IeM6Kisij4TjEQunDomVdzw=
Received: from SN6PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:805:106::27) by CH3PR12MB9022.namprd12.prod.outlook.com
 (2603:10b6:610:171::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 03:24:49 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::29) by SN6PR2101CA0017.outlook.office365.com
 (2603:10b6:805:106::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.0 via Frontend Transport; Tue, 18
 Aug 2026 03:24:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 03:24:48 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 22:24:48 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 17 Aug 2026 22:24:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, David Rosca <david.rosca@amd.com>
Subject: [PATCH] drm/amdgpu: handle pipeline sync without a VM fence
Date: Mon, 17 Aug 2026 23:24:36 -0400
Message-ID: <20260818032436.1047825-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CH3PR12MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c82321-db86-4f52-9700-08defcd8424c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|18002099003|10067099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: hZecPKks/uVyBbWqCV8F85Wia5glIJ2O3GljciFhjZ/C3gNXfXwBUX7Xga3/aEY8yWjawshPgnOvBba851thjXkv0pjLp3yM/FQ/iy5PSYXYBj931UyzSoVLoyOEHhgB2NYNdRVKXbwuFB7ndC0VW7hof+hYbC+mTkZ0TjG6wpUl/EDkuXFwWzT8wxxSax0pL//HrOZHuVE/0oI6LsO98Gz8EMlslhNYYomHTFCwlz8oPuJFUh5ezSxOMWGdUMZIPlwTnFZXrpvP6J4/LDWP08jgFL6QX1Q4q3hU0YdRnTozPgKE3pa7NStgvLfgouSdD/hRk12NfzaGEGhIhOHkz4HfQkBeRwKFdYqhWvsD2jjE9fCLIqypzmYxF60RbRfSTc/zfUy8u1Px/ojJsg99+IQ2F1eCkNUxNXfhvizLlmhiYpW/hWbKFk9c9MsVStAB7hoIH1MMlVcVUjyh9fLreKcwzDR4X3drHaCWLyqL5hV1t26xtgicGvJpjQCcBcUcTtrnWBuz7EhGK411kpJ+U6xY0xc2nwJWemWjAV1RL0EeZ+0Gn7MkvCh1QZnsNjr6PuEjiwY3XI2rTRU5yGyR0Y83D72JnpYuD7TMWOT7G/spzHVYMSTVoxNPYSJy1ENtwgwcW+i3piCDdb1ujEKqJpdGs68IOKcO08PDEoRrz0F1G03PkussFE2GupOzwrgnCKi1m8ynkNQKLdu7dq91Yw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(18002099003)(10067099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jHdADG/qMUvavioS0sqkkOLdVq60UIAgi/SCMeAZaakKrfO8tPIx/EvSExoJhmnHwFbnEXOHJOdvoY/tZ1JhPsUXjvyByTEcTt55CWavKOZ+pjPPGcbDOLS/tmM6FOg6eXMoS2KMNV+3stTxyaTfX0RdSmQQmbzxt9db8qNjKrwqsZLzjHw1+8enQlL0HK76Vzs4mn4ZQiP6E5i9FoE+X/vvBDLycZFBGgmBsZxebQOrimgRkrLOmwjf2lm91UqSdS5OservUQ+oJGw/YsEc1Qa0XfeE38cqGxYYWQrZTYdNwaurNvb7PIjj1drgUicp9AWnKh+82MHmCFul8UD4OepG4/yyuNjfs8XNbJoGaRnGyupmAFiaPWd2+QRCZb90fih+ts4oNi2mZEbtwMNP14zWuGjmXVLFmTKb+VgeAWEJ31rKw3ahgsUWp0eVw03d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 03:24:48.7902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c82321-db86-4f52-9700-08defcd8424c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022
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

If we end up emitting a VM fence keep pipeline sync
associated with that fence.  If not, emit them as
part of the IB fence.

v2: fix need_pipe_sync handling
v3: simplify the function

Cc: David Rosca <david.rosca@amd.com>
Fixes: cb1e657ccac8 ("drm/amdgpu: handle GDS and SPM without a VM fence")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 27 +++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  2 +-
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index da4dc489e80bd..360e6f00cb7c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -222,7 +222,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		vm_af = job->hw_vm_fence;
 		/* VM sequence */
 		vm_af->ib_wptr = ring->wptr;
-		amdgpu_vm_flush(ring, job, need_pipe_sync, &emit_spm_needed,
+		amdgpu_vm_flush(ring, job, &need_pipe_sync, &emit_spm_needed,
 				&emit_gds_needed);
 		vm_af->ib_dw_size =
 			amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr, ring->wptr);
@@ -235,6 +235,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	if (ring->funcs->insert_start)
 		ring->funcs->insert_start(ring);
 
+	/* this may have been handled by amdgpu_vm_flush */
+	if (need_pipe_sync)
+		amdgpu_ring_emit_pipeline_sync(ring);
+
 	if (emit_spm_needed)
 		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 71050a86bcc3a..f6c5de63eae61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -772,7 +772,7 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
  * Emit a VM flush when it is necessary.
  */
 void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
-		     bool need_pipe_sync, bool *emit_spm_needed,
+		     bool *need_pipe_sync, bool *emit_spm_needed,
 		     bool *emit_gds_needed)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -827,8 +827,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (gds_switch_needed && emit_fence)
 		*emit_gds_needed = false;
 
-	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
-	    !cleaner_shader_needed && !spm_update_needed)
+	if (!emit_fence)
 		return;
 
 	amdgpu_ring_ib_begin(ring);
@@ -847,8 +846,10 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		patch = amdgpu_ring_init_cond_exec(ring,
 						   ring->cond_exe_gpu_addr);
 
-	if (need_pipe_sync)
+	if (*need_pipe_sync) {
 		amdgpu_ring_emit_pipeline_sync(ring);
+		*need_pipe_sync = false;
+	}
 
 	if (cleaner_shader_needed)
 		ring->funcs->emit_cleaner_shader(ring);
@@ -861,21 +862,19 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (pasid_mapping_needed)
 		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
 
-	if (emit_fence) {
-		if (spm_update_needed)
-			adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
+	if (spm_update_needed)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
 
-		if (gds_switch_needed)
-			amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
+	if (gds_switch_needed)
+		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
 						    job->gds_size, job->gws_base,
 						    job->gws_size, job->oa_base,
 						    job->oa_size);
 
-		amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
-		fence = &job->hw_vm_fence->base;
-		/* get a ref for the job */
-		dma_fence_get(fence);
-	}
+	amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
+	fence = &job->hw_vm_fence->base;
+	/* get a ref for the job */
+	dma_fence_get(fence);
 
 	if (vm_flush_needed) {
 		mutex_lock(&id_mgr->lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 7f2ba728e3ed3..d32183cd9e0fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -512,7 +512,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       int (*callback)(void *p, struct amdgpu_bo *bo),
 		       void *param);
 void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
-		     bool need_pipe_sync, bool *emit_spm_needed,
+		     bool *need_pipe_sync, bool *emit_spm_needed,
 		     bool *emit_gds_needed);
 int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm, bool immediate);
-- 
2.55.0

