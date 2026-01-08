Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B111DD1D467
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BAC510E779;
	Thu,  8 Jan 2026 14:49:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SPS0lz3R";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D433910E775
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQf76omYeVf6jo+zoJWxtQEdM1gn9LTnD9TH+yDb9oA38eEOHEuwqZpbcwmYfMVoNH0v+qLf+8p9qB6pxkHTMYBrbVyrRH+6v8swQwi3mZaf+iCm757eSldQ6GmLYFl9AnJmScw7QOFwKMwskBS7xB57AjtCuifovhb4a0k1oa81tQ2lwtCS0RHunqbw7J0lGyMGb9lrm3C7hI0zRXEOCNwCvDJ6UAiw/C4cBo5yWRj1SGFCiqr6GmMJMGZOiwzYgGY/bBPEDjBL3lTs4WH023TneMfz8+IKWuvMbfEJFWptLSk4M2aF7Ryv99i9g+Ol58FDd7hTLP6GuKBaJVYx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XY/TGE5rqLZV9Rz8LZCGFNz92tI14GYHci5A/sxpA3k=;
 b=IA4fvkYFVMsWM6Sdv3WVsRXbQD1xIpRbbh1LkfCibT8idjbGfc1llEXNro8XmEALoXO0YKFqtVWBcIiSG1JtSi9KSUBJr8mokGlSaEEaX5fJYnh0x2ER8MmDAYw2w0utGVWEqPMyhjSQLtZT3f16aEtHqf+yGOrdhrKoY+9Tc6YXRwXYZe1G6i+sZfFLnXrx+BnNc98706CaB6oN2nfQxM3uLKs18mRTssPHnbqXMCUD9H7bXgFI5zh2dCQINoRR7V/a1t9A+Ii4z3wEH5yxLS9Yid0Vbr8C6UvdZpaSKBnMsXC0mhVhM6tKPPTkZPmOT0NV7wWIu+MHFhh5DUfe5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XY/TGE5rqLZV9Rz8LZCGFNz92tI14GYHci5A/sxpA3k=;
 b=SPS0lz3RI57HL6hEezFHJ8SIBPpkBOBxnfkz66BI3O7CzzRO9hrVcfFfNVwXeUKdKxWlnS5Sjn3QmQsoIjKcVI1+DnRNDsT/wWXXbj51mwpCXxL/oMgg5OAQaIkRJW1hfMfqd/f4aa/cVF/1/pnH2Ge8YvlFrF0ASlxY2xag9cY=
Received: from BYAPR02CA0050.namprd02.prod.outlook.com (2603:10b6:a03:54::27)
 by BN7PPF9C6E5285F.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6db) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:49:14 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:54:cafe::65) by BYAPR02CA0050.outlook.office365.com
 (2603:10b6:a03:54::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:06 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Jan
 2026 08:49:06 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:49:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 35/42] drm/amdgpu: store vm flush state in amdgpu_job
Date: Thu, 8 Jan 2026 09:48:36 -0500
Message-ID: <20260108144843.493816-36-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|BN7PPF9C6E5285F:EE_
X-MS-Office365-Filtering-Correlation-Id: 692d21da-a70c-4d88-97c4-08de4ec5179c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0mcCjWU1QArYoLMbLeR9VT44+vtOM+MZRd3Z4hFpbEMN/LZq8S+O/zGUP5Jh?=
 =?us-ascii?Q?8RvhyuY8kUnp4L/FRql8RnWhqKp8XBt9v14yMM26zn+KbVXjUH9nMtrFMKwI?=
 =?us-ascii?Q?keaCxkwck+dWXaeEKq1BxRzFR6iLl8odtdHQvZT7TknBeTIfSOkK0u4Rtsvm?=
 =?us-ascii?Q?vR58zmRgE+JK+e6M2Irqrr9V2nTnm27y3Ovu4VOUHU5Oidf+TaiUm2kAJutQ?=
 =?us-ascii?Q?6G5AbF42aIWGJ1WTSwd7zomBVbTye0DbYJgau9Ary8f3YrdoadKmSG2KWrl5?=
 =?us-ascii?Q?N2iKBVxCnsTgZJ9yOZRPYAkKmAxHfudIYCdSHMn8pMIsF4iugLQdYCxIK0hJ?=
 =?us-ascii?Q?gOEfsZTgz2KzI9FjD4Ls4bBlC1yF0DSvzrS6E4464T+tFg7vmZ6YI0IRJDLB?=
 =?us-ascii?Q?na5imWKBpO9oXFBsF4XyAoYUpFAEYYVWx8njA/lVd7mdTAvigT+Z8pccpRbj?=
 =?us-ascii?Q?7WTS//TLxanWTiTFIRWLvnqmPhF0aghc8HvYgVAvVvsdvkS9MswBN3u9zbAX?=
 =?us-ascii?Q?btZ6P6Zj0aZB4mRLD7S/bYvUoBhsgZaFz7DJM2MTVoR+mz5Dlaohl/bla40A?=
 =?us-ascii?Q?Ig5M8lY4aVZQL2TyoGjYGKXfQB9PsFLPpMhH/p/wDmrNfc0NZiwjKsWbwmFv?=
 =?us-ascii?Q?6p5hYlvmtfkHxk6j6u3iIhzBThN8yqAMIT7WFrKVe1WmI6rnpih7VL0lyphK?=
 =?us-ascii?Q?b/PacPb3nJ6pUk2g9FY6qHqSblSvl7AOMjdXvz5A1Y/7Y6exlWEwvKnEcMKT?=
 =?us-ascii?Q?T00Dbwm+dXPYE6KssyPUUPj66Bold7syrMynq/ofrEJeYSK0ReuLVvHSR1SY?=
 =?us-ascii?Q?4A6KhG/YSb/ZNnHlHeuTUMGftxI21bUEwmYklgIbuhnpJ9qDwiuS9H2JsF0Z?=
 =?us-ascii?Q?9m1TZhny41oLN5pH37ufh5G5u8XbC/Lp7KzW3Frc4OckpopvPTpivb1V7Irr?=
 =?us-ascii?Q?DkkrOp7IE7BmgX9iehrrI4OOM9pYGWvxz7IpgSwE1ntIdEg6tpKrEOOHwZuD?=
 =?us-ascii?Q?w7UXWALWcCmtpFUKPZJNrvIUsm+BoWQlM3zctgj3PlCFO7RxYMXxukeZqFV4?=
 =?us-ascii?Q?lwD1KB8NUnB+awWzITLqyO4UASYLrsgEbMc+Q6ZXy8n9rrzHelUMboP/Xkat?=
 =?us-ascii?Q?25W0IxOIGTo9ECMCFPisqLv60KqmWdZ2dMxNdooNCrQNhZVWmbIZN/GRft5R?=
 =?us-ascii?Q?FF/CXU6x2ACNOfL3Epgb8vTO8EmWE2Bk9F3+SEyL09jrWxcGb9bvUOJvxxGe?=
 =?us-ascii?Q?osknh1wKIGOEXkNJjQikZg5NHpAaWelKBYAdRURwP5/wgSeCstGNErWLG0d0?=
 =?us-ascii?Q?lMqAz2cm+hdhfRVdVxppu1aeOoM4uwgP4/wL50dpLDL0AgRMj3zb80Dm8GJB?=
 =?us-ascii?Q?2g4K6K9NHSnxuH7Amh5+/nK9iHgeqGJg3i1w71KBD3UgFa7q/qmDkCkl8D/A?=
 =?us-ascii?Q?X4DSmi1CqADnTjxNO1/kkDuqY4npfWL3TmKBqKbcB6vm2We7RYEGfDJ3hYkH?=
 =?us-ascii?Q?QdkXRT9+GLYrEd1wgeeDca24AKOxjppbKUAiFc9XfWS1+3SSrQIKKb/uSHY9?=
 =?us-ascii?Q?c0cMpqhqa/bioBNjEO8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:14.3499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 692d21da-a70c-4d88-97c4-08de4ec5179c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9C6E5285F
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

Store it in the job rather than as local variables.
No intended functional change.  Needed to help separate
the vm flush and emit logic.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 54 ++++++++++++-------------
 2 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 21e1941ce356a..d53c13322a648 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -105,6 +105,9 @@ struct amdgpu_job {
 	bool			need_pipe_sync;
 	u32			pipe_sync_seq;
 	bool			need_ctx_switch;
+	bool			vm_flush_needed;
+	bool			cleaner_shader_needed;
+	bool			pasid_mapping_needed;
 
 	uint32_t		num_ibs;
 	struct amdgpu_ib	ibs[];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index cea359f2084ca..e480a65dbdb1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -774,42 +774,40 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job)
 	unsigned vmhub = ring->vm_hub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
-	bool spm_update_needed = job->spm_update_needed;
-	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
-		job->gds_switch_needed;
-	bool vm_flush_needed = job->vm_needs_flush;
-	bool cleaner_shader_needed = false;
-	bool pasid_mapping_needed = false;
 	struct dma_fence *fence = NULL;
 	unsigned int patch;
 	int r;
 
+	job->gds_switch_needed = ring->funcs->emit_gds_switch &&
+		job->gds_switch_needed;
+	job->vm_flush_needed = job->vm_needs_flush;
+
 	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
-		gds_switch_needed = true;
-		vm_flush_needed = true;
-		pasid_mapping_needed = true;
-		spm_update_needed = true;
+		job->gds_switch_needed = true;
+		job->vm_flush_needed = true;
+		job->pasid_mapping_needed = true;
+		job->spm_update_needed = true;
 	}
 
 	mutex_lock(&id_mgr->lock);
 	if (id->pasid != job->pasid || !id->pasid_mapping ||
 	    !dma_fence_is_signaled(id->pasid_mapping))
-		pasid_mapping_needed = true;
+		job->pasid_mapping_needed = true;
 	mutex_unlock(&id_mgr->lock);
 
-	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
-	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
-			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
-	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
+	job->gds_switch_needed &= !!ring->funcs->emit_gds_switch;
+	job->vm_flush_needed &= !!ring->funcs->emit_vm_flush &&
+		job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
+	job->pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
 		ring->funcs->emit_wreg;
 
-	cleaner_shader_needed = job->run_cleaner_shader &&
+	job->cleaner_shader_needed = job->run_cleaner_shader &&
 		adev->gfx.enable_cleaner_shader &&
 		ring->funcs->emit_cleaner_shader && job->base.s_fence &&
 		&job->base.s_fence->scheduled == isolation->spearhead;
 
-	if (!vm_flush_needed && !gds_switch_needed && !job->need_pipe_sync &&
-	    !cleaner_shader_needed)
+	if (!job->vm_flush_needed && !job->gds_switch_needed && !job->need_pipe_sync &&
+	    !job->cleaner_shader_needed)
 		return 0;
 
 	amdgpu_ring_ib_begin(ring);
@@ -820,29 +818,31 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job)
 	if (job->need_pipe_sync)
 		amdgpu_ring_emit_pipeline_sync(ring, job->pipe_sync_seq);
 
-	if (cleaner_shader_needed)
+	if (job->cleaner_shader_needed)
 		ring->funcs->emit_cleaner_shader(ring);
 
-	if (vm_flush_needed) {
+	if (job->vm_flush_needed) {
 		trace_amdgpu_vm_flush(ring, job->vmid, job->vm_pd_addr);
 		amdgpu_ring_emit_vm_flush(ring, job->vmid, job->vm_pd_addr);
 	}
 
-	if (pasid_mapping_needed)
+	if (job->pasid_mapping_needed)
 		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
 
-	if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
+	if (job->spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
 		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
 
 	if (ring->funcs->emit_gds_switch &&
-	    gds_switch_needed) {
+	    job->gds_switch_needed) {
 		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
 					    job->gds_size, job->gws_base,
 					    job->gws_size, job->oa_base,
 					    job->oa_size);
 	}
 
-	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
+	if (job->vm_flush_needed ||
+	    job->pasid_mapping_needed ||
+	    job->cleaner_shader_needed) {
 		r = amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
 		if (r)
 			return r;
@@ -851,7 +851,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job)
 		dma_fence_get(fence);
 	}
 
-	if (vm_flush_needed) {
+	if (job->vm_flush_needed) {
 		mutex_lock(&id_mgr->lock);
 		dma_fence_put(id->last_flush);
 		id->last_flush = dma_fence_get(fence);
@@ -860,7 +860,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job)
 		mutex_unlock(&id_mgr->lock);
 	}
 
-	if (pasid_mapping_needed) {
+	if (job->pasid_mapping_needed) {
 		mutex_lock(&id_mgr->lock);
 		id->pasid = job->pasid;
 		dma_fence_put(id->pasid_mapping);
@@ -872,7 +872,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job)
 	 * Make sure that all other submissions wait for the cleaner shader to
 	 * finish before we push them to the HW.
 	 */
-	if (cleaner_shader_needed) {
+	if (job->cleaner_shader_needed) {
 		trace_amdgpu_cleaner_shader(ring, fence);
 		mutex_lock(&adev->enforce_isolation_mutex);
 		dma_fence_put(isolation->spearhead);
-- 
2.52.0

