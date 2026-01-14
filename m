Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26663D38FF1
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5FE010E655;
	Wed, 14 Jan 2026 16:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oRap62HX";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A53DB10E65A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQjW+V0UjM5Q7FdL+n82v555DTd2H6p36IsrMdi3RtReazu6pX+f6Xppbw4yku2v95K36UKi6TOlxaZ8KzHT9k1AN9Tns6EwXlsZNk8/PQflHTRg9IIWAjDAc5IOzU7seHOA8a5sLyTWKfbfXjxbMX26l+STqSzaczZ2qF7WFP0OIRw3XHzg+UmuVBs/lFbvEviOz0uP0dZ+XwAP9XyeEExK7Di2IhwlGO3oyyjbbOyc4I5ImOxv822Bt9J7z3hJb5lhueuvkc1MrxjylPjd0iYymn/kFdT1B7s46scwN2FXS7mYNgTqYBREUTO6uAAs8vtAu/dhTA3ShdTRjtdE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7jrnD9cCY4eRBuYs7ThPZj11KHEKMjw6siVgKUcDm4=;
 b=chmuYVTJ+sM6e4GLEQYGuYDZ2ft77K5NhBLCgfEIfy4hvNnokoDk8ep0Qsd4FP/iFU+kEzavm5MDjciUhShClTuO4oXWCTaHaJ9XTZ56WkQtQW59fsoLWb738HAMgkEOstwYTO+8W/fP5jpz4dcTuNRk3dzRWb82wVrwlU4gmYbxUbVLuK7YZ0N712x5UjAVO4BDggy5WCiDc5cCY/u4qhYVixfryGoPW4akqCt2vVh4QFjQJC3V3tWkwhpJbLw4IyjJOLOHsvKOm2K//bwTKA16JicSAvhRj+Hh2mrtwry1hdiTE+QjBx+0fHfMZBertPJQaKcCWYafcjkQL/MuZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7jrnD9cCY4eRBuYs7ThPZj11KHEKMjw6siVgKUcDm4=;
 b=oRap62HXPVLn0yrOfzuqrsoXQuKSvYJ1sx75TBmScKfDmaromnlOcOPJd5N+kpV8H6xMxA09WMpPpKbcvZbQNHA7cIufiGPu5O5FAn+OcYrc6EGZ8jbDkQNIMgZYfKMBpu1Ktnc+yHOUnPjJjGp8P9MobToqpyebMExVdDm2VDg=
Received: from PH8PR02CA0009.namprd02.prod.outlook.com (2603:10b6:510:2d0::22)
 by DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 16:48:12 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::2b) by PH8PR02CA0009.outlook.office365.com
 (2603:10b6:510:2d0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 16:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:48:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:51 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Jan
 2026 10:47:51 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:51 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 32/42] drm/amdgpu: drop extra parameter for vm_flush
Date: Wed, 14 Jan 2026 11:47:17 -0500
Message-ID: <20260114164727.15367-33-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DM4PR12MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: f45593d5-edc4-4750-ba77-08de538cb49d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dCD3V5eFEvQJkbBxl3ljcizge5k6g8Fx4aXnW1nAH+9I4pofvZGtFUYbh/AS?=
 =?us-ascii?Q?IhLNin5D0IUCrlLKhlr8RsxbxCGODVGrm8uX9WhN08w9ug79JQ9tIt2vFG90?=
 =?us-ascii?Q?ojo1/ezLa2jyxBrnpcERRjdMceaEeousQNZWVMlUCuATEpoklcL2oNt+KqNL?=
 =?us-ascii?Q?Bv5iGnM/nJgMuovae4/X5l87GTfc74AO1nfiCTWy4bDN5qYioFrssdSZVsiq?=
 =?us-ascii?Q?9qAfWUkADbgJex3YOiXhi7Y0Xf+rYfmg0v5GCgsVtli2n/lxxNncwcSdtFh2?=
 =?us-ascii?Q?+RNrLw0i3x3lYne0L93jPKwvbRt49jVTYt8h3qt+jFhGct/BjdHe5WGOQM7h?=
 =?us-ascii?Q?ElQukvguzcT9VO5SukLzSXFKXumbiNWiZ8CcOFvxdJoIYpdKa+mQwPA8RQ7q?=
 =?us-ascii?Q?qLWKjllNEVYPD61u4+nZQEcWD0xQfQiv5HTREriUri4sHs/wPvvPnCIvu4bc?=
 =?us-ascii?Q?8QSglqViTF315HOGJwrIsMeMQ5vq+K9VA3L7MKTPSHqChxVivOUPaYG3GOi9?=
 =?us-ascii?Q?sAFiAI6jx48iXAZ7CuhSlwi1U4vIzCItK250D126t94YJrbei9sctG1ihiVi?=
 =?us-ascii?Q?HJUwaIdcK60ftEC74twbIvSdy8Jl/vDVOXOwekuY89vcF341QXSFcSQUfUmh?=
 =?us-ascii?Q?/OD1EN+YsVJ4t8Cx+QaYeDpejUvFydr66Ij1W31m0wUjrEqCkN8AlT2HE+46?=
 =?us-ascii?Q?I4TfxS63/SHqQ+aVED+KWPICwiGHce32CUPPcsNela/caXcjsGcb7RxiWTnH?=
 =?us-ascii?Q?yOUoGzK/bwjUDRmKJa6VGKpIlBs5DHSmfAMT+L47WPQnscnImfD9HV9d2vt7?=
 =?us-ascii?Q?TRN69z8ZS0GimH1tnCROxCnFkygSYMqgrBOph9/Q27+5VJhaSYL+bx2KVuHS?=
 =?us-ascii?Q?VK66Mmwa6A6zZ4qN5q8jtR82wxWW0ohopwGH4ptVNIskXMstiPM1AFDw3LO3?=
 =?us-ascii?Q?R3Xd7ALAMVIHQgq/ndN8gePCr8zPBPZtoj4Q1gak8OsM+gJX40NswrO7F9U3?=
 =?us-ascii?Q?VhOS2ViVTFHlfUsp77T8hQcH5XYpBoSRPX/tQhkddlRZbQcSZZxpewZrPUiZ?=
 =?us-ascii?Q?egX9Junf7CnUxZwSDXmXk2JI0QWdUB0Ne5QSnIqQ94zzlBwrwT5VBOooOdvf?=
 =?us-ascii?Q?zXBq+mK6GV42i5PNI/Dvww8cD2PWJ+kHEx3xDMn/85ezPBl89a2o4hSyKDo4?=
 =?us-ascii?Q?CqCeBZi7cPz8/xGL9d4Zsl6PUsk7Cuo3E+HoISekQVGvNpG9B58YOY8HO5PX?=
 =?us-ascii?Q?iKko1/toDYVuVtaYUkhqcS/LKyqVeCsKLgZNNNxbd9ZBC89kos4ZY2g02ftM?=
 =?us-ascii?Q?kCf16Y5G5jpmItSuJh2r1lYRs2vIpPgGVzHDoEZ5wvgfLKuX8fNSk4wthXjw?=
 =?us-ascii?Q?G3t8Qdoj7bOwjBisJb72uQyp4+Yp18s/KBz59Rc0BkxubkPycA7wv28YedBX?=
 =?us-ascii?Q?nMSJHj2pe+cmWAMB3/MP2FFPibrDTZ2gBovNudOYHbYi3ezHsnakVdMfKjgc?=
 =?us-ascii?Q?4pnqh4J1M7SdSnMiPfK8GpOr4qRUnUtMK68PiZGn5LmA+o0XBZatxt2lTd25?=
 =?us-ascii?Q?bRjuftBG38Ik4fcUgrFee0evm0xxmWOyE7je4mCQMQCrzVxkDd+wS9PwDhMB?=
 =?us-ascii?Q?3gUb0AgmsgkBVSUWIrs+pUCFh+OhZT5aAQW5Ysf+UXy42BHg84iHg5ZX1i7W?=
 =?us-ascii?Q?R5RgYw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:48:12.3084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f45593d5-edc4-4750-ba77-08de538cb49d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560
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

We can store it in the job.  No need for an extra
parameter.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 10 ++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  2 +-
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index fb58637ed1507..17176e51c0398 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -134,7 +134,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool secure, init_shadow;
 	u64 shadow_va, csa_va, gds_va;
 	int vmid = AMDGPU_JOB_GET_VMID(job);
-	bool need_pipe_sync = false;
 	unsigned int cond_exec;
 	unsigned int i;
 	int r = 0;
@@ -191,7 +190,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
 	     need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
 
-		need_pipe_sync = true;
+		job->need_pipe_sync = true;
+		job->pipe_sync_seq = ring->fence_drv.sync_seq;
 
 		if (tmp)
 			trace_amdgpu_ib_pipe_sync(job, tmp);
@@ -209,7 +209,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (ring->funcs->insert_start)
 		ring->funcs->insert_start(ring);
 
-	r = amdgpu_vm_flush(ring, job, need_pipe_sync);
+	r = amdgpu_vm_flush(ring, job);
 	if (r) {
 		amdgpu_ring_undo(ring);
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 56a88e14a0448..908239d45bd3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -101,6 +101,10 @@ struct amdgpu_job {
 	bool			enforce_isolation;
 	bool			run_cleaner_shader;
 
+	/* job state */
+	bool			need_pipe_sync;
+	u32			pipe_sync_seq;
+
 	uint32_t		num_ibs;
 	struct amdgpu_ib	ibs[];
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c05a9f80053d4..cea359f2084ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -761,15 +761,13 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
  *
  * @ring: ring to use for flush
  * @job:  related job
- * @need_pipe_sync: is pipe sync needed
  *
  * Emit a VM flush when it is necessary.
  *
  * Returns:
  * 0 on success, errno otherwise.
  */
-int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
-		    bool need_pipe_sync)
+int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_isolation *isolation = &adev->isolation[ring->xcp_id];
@@ -810,7 +808,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		ring->funcs->emit_cleaner_shader && job->base.s_fence &&
 		&job->base.s_fence->scheduled == isolation->spearhead;
 
-	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
+	if (!vm_flush_needed && !gds_switch_needed && !job->need_pipe_sync &&
 	    !cleaner_shader_needed)
 		return 0;
 
@@ -819,8 +817,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		patch = amdgpu_ring_init_cond_exec(ring,
 						   ring->cond_exe_gpu_addr);
 
-	if (need_pipe_sync)
-		amdgpu_ring_emit_pipeline_sync(ring, ring->fence_drv.sync_seq);
+	if (job->need_pipe_sync)
+		amdgpu_ring_emit_pipeline_sync(ring, job->pipe_sync_seq);
 
 	if (cleaner_shader_needed)
 		ring->funcs->emit_cleaner_shader(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 139642eacdd0c..89b76639cb273 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -512,7 +512,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       struct ww_acquire_ctx *ticket,
 		       int (*callback)(void *p, struct amdgpu_bo *bo),
 		       void *param);
-int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
+int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job);
 int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm, bool immediate);
 int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
-- 
2.52.0

