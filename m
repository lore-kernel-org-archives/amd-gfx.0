Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AF1D38FED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D1D410E65D;
	Wed, 14 Jan 2026 16:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3ezudVHe";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42B2F10E65D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vP5aTiHLTxgIyeveyrfG7tY+QWzBDsqEz6gtQd+W58u9FrUUt6H6bMp9jWp55CwFOeXNsJg1G/a1+PAu4iQqXkR9U2v+7FKgAV7w6qMv/Ub+CGMnlejC0obJ2m8vPCVpiUX2m/SWI7FnmzLnhPQtC7cCfXLFzpUQv9fKOpyqTs/Jb9J+12CFBm2yJaAPbuPO/I8VngzKPLNdrGAOCx4Cxl00FMHxTKMntJT32mO8WZAGxdX5b1pG/IDC5JvdE+2bsukQt7oTIhpS0YnaCRfGPWLpHkbQ3MgRmnz2sLbNmRQhexKrfmafCT4NJC9G3dZWTjR9xHyQS1sIMm1YTEHY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XY/TGE5rqLZV9Rz8LZCGFNz92tI14GYHci5A/sxpA3k=;
 b=eVwWJRlXYvBF3BkfWy95WhFR2IkMb3LVy55W91IJQvcTsNaiLIWoTbS8Rjdh45UtVy87XcmUaTiVBNz4kemaHsI4r+afFxmkpzgplcsLDBXSicECX1MOQdgdKoL7xhx3Cn26DEmUcWo/DXG0Uk64HDWUcw1MEZsEKbZxSHrIbIrh1nJiMbpDmTocRZSEvJ33oZohO1HgI+16a4ub4owyTA16JUpZOFOEisquQRKA/IuU4jSs5cQouzOOyrq+ihTHMCXtTEow1nmGTZGhBT7TlHbTEZN63jKjWZQRpZWdFb4vpOxiuvmGnvC6/tpQiZfxE6/0ZqqwVgJIDlMCWWS1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XY/TGE5rqLZV9Rz8LZCGFNz92tI14GYHci5A/sxpA3k=;
 b=3ezudVHe4LJtRIi+pcuCu1wbg07ZWz5WrC0z64sbR8d+X870ptOKnm1VKDvrONkeoJX5VWZVCnH/0UINBvd6Rmo21spAWY+TIhBs1jXebIpGGpz00ZNf5ugiLoLLiHhcxbdqVWuS8HIkzu/EELTFx6THNjrlwv5/Avfv4sm8Amg=
Received: from PH8PR02CA0012.namprd02.prod.outlook.com (2603:10b6:510:2d0::24)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:48:13 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::dc) by PH8PR02CA0012.outlook.office365.com
 (2603:10b6:510:2d0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 16:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:48:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:52 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:52 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 34/42] drm/amdgpu: store vm flush state in amdgpu_job
Date: Wed, 14 Jan 2026 11:47:19 -0500
Message-ID: <20260114164727.15367-35-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6253d2-6b0f-446c-6103-08de538cb50c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d9qrpbUOH18GdYYaKFkMm2YYBmYpqdvr5qYSJfAmql7pARa04CU1JK5+eeNC?=
 =?us-ascii?Q?ber0fYsageO4EmZakZ+Ua2gWEAXXIvHj96vAUxYdVDhBH4l4+eXDKuzRsVmQ?=
 =?us-ascii?Q?Idz+XrdA6Q41eh9/tVMbfjpSYof1ksBCPMIu/nqQDAR+Ldz54kpB6000g+nQ?=
 =?us-ascii?Q?QakUIpcU1LWd1D0fW3rggQSWLyVthBGQrYyOnIxUou1DEBqyxirnAtp+trwB?=
 =?us-ascii?Q?KnY4OCq0hjJiC0YufAYIACWPslcFeBwhteqUjeg8ZqlugPTiVWOp7INZi52D?=
 =?us-ascii?Q?J+A/4TC1xBgXlTbEhMh61fpDcKIAVlDl7cnZbgnzXu/E7tKgolTiN0c+CtsY?=
 =?us-ascii?Q?IBxdKpZ27GsieY125TIowisIDUWUhhgmUDUVIe+5mlUgh8twdkk2qHFAZtZe?=
 =?us-ascii?Q?EJep6kq6kTWmUcG04QFn3IGlBz/SosYx8WnbqNvM+enhvfBYdI+jonC6g/fh?=
 =?us-ascii?Q?C8o7y/r2/oQyPiV9Bcvpl8FjEPtj+mEJgX4q9iKjBg82UhawTRAebUNjft5j?=
 =?us-ascii?Q?37zJLkgG3jo9m2Jt7KLGzRENPESa/hxdzSQ90k/+w4aHok9Yog/SFWlN7Udf?=
 =?us-ascii?Q?CoOt+tyL+Qn7zS+JXjSBPMCWUPPxlIHrBQ9Jkvf/+I7Hz0h2TTHrJ0DOTgwu?=
 =?us-ascii?Q?R7YOM7MaxZDklm5OLM54Tkl6FIpZgFCfkmcO7IpxlTMu6sWiZdN+t1Xyz9DL?=
 =?us-ascii?Q?67VnJLF7lCb8rIXcgwGSuaCAjtjbtRzKyu7xzxlsBCnxpdSiTwjvletQdDzP?=
 =?us-ascii?Q?Wo/IgEZV2JhGqX+9jPeSgPGZxLPW5rNjUyZMQxqMFneL5wrvwDvGcPKUnTbv?=
 =?us-ascii?Q?rogiTwrwCKpRkZauKXHPYxfPmz8KesLjr/gLZHQgyAEe+JzNtTB7eHbRkDRT?=
 =?us-ascii?Q?6n3BZjmE/5fNtJ2PjUK21cD8l/tH1sYWWvlXk95QGuV2aS3PVnYOU0utkvi5?=
 =?us-ascii?Q?D2nkpm/MNIobj7bdlju7Di1Lz4rbW12d/cDbJueHsJrjIK3FftFyT8hcUr6+?=
 =?us-ascii?Q?jqiXcspRSlJGWCei0p2FS4svrh+fN/KhuLx6BryV0TXaHdmwSW6PswdJw8mj?=
 =?us-ascii?Q?KhBhthPx4zYKpPQgqUv6/MqD5VHNp3t0pFMvM070DaoLjpAmJyT0TITjuiZD?=
 =?us-ascii?Q?Bg0cepp5LuEd5LOjvGufzZkqzWZ3O75hZFvW8HqrCiZCGHH1QuqUdLleDuch?=
 =?us-ascii?Q?gVMUb54Izjo/MVLIsSro15pq30K01S0H83CqdwrUsCsb0KXumO8Qhzhczzof?=
 =?us-ascii?Q?F4KiM6Q9dAVgyhIex61kcXMvuMFkS4QpueOB6IzjxlSQKZGFMuW2ddgroXzM?=
 =?us-ascii?Q?UYJUxIfW8301uXtQcu5eaTWKAzXA2x6IWu1hAy72VWnasNQPdoJbgea3LId0?=
 =?us-ascii?Q?96cRjfyrpt3DKVydihttCV4MLs0kwq9YkKMnD/sEAa8AOffaavSWOKhbVAgq?=
 =?us-ascii?Q?jSerTGOBROgC5bGRR184xN+mziJU1Sa/U126nQW/jllyJcV7oiwZ5B5xInsF?=
 =?us-ascii?Q?VRM3KZ4AzEop78I6BF+6Y60lyNtQjfob0bfytwQ7qri1zGvtFPle1GldaxHO?=
 =?us-ascii?Q?0H3SHZZdzE3vpzaYns2tfmJD+6ZtVxYB171+uX2QezN4R5Yt+ZoQU7lKFHqq?=
 =?us-ascii?Q?vF46PJmoPMxjtDpsU2to1BKL0jz39WWl3frEdiaCv/b5tyNXxZOyPy+FdZyD?=
 =?us-ascii?Q?P3tb/w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:48:13.0274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6253d2-6b0f-446c-6103-08de538cb50c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250
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

