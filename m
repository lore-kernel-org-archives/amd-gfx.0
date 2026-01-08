Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A7FD1D468
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B414C10E776;
	Thu,  8 Jan 2026 14:49:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bMRytRo+";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF28E10E75F
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKnFeINa7mmNdApyWeDkzmlyKuGbEKu5jzOwqsXWPK85b2Q1VGj5FlrHccz9jJjbZnkX6BrHe3i79KdAzC7Pc5DZdD/c5nchniu08ytUjrN9O0j9w51Mam8sVoKX/OGme0qJCTveUmNkwYgyXh2mK7EhmAvBzI/duoEbddCAkzPoFTEU6lWUvgPGVAZrOcZT33/vj1c2H8X8Vfl79vhDLkoQupkeFlXEVOZksmYSa/J0alUsIocFiT9aRtWwVPB+boB3a/aZ55Vwz0AvjzRoDtil77E2ZhIvRibRlEuW61DhrxzBhbBi4bJuE/lK5D9kOCHzKUmrDGeAxLVtZrI/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icz99iLon4vXz+P07YWVrbEKdND+SOxpp9aYZkgy/kw=;
 b=gAzjn5JW+spwWYM5idp7eG/g/Z1OUiMYIhVCDJ3uWXDoJTMl7dpDTU25OQUdrSse/C2nS37924KAeuQuGREQu1RInRzhr/xNaai+WLEVMPRRh1yLb6jM7YiAiWpn0mxqrTc4dm0ZmCAFbKNunuuRG6HUoP4qem8MYY/aJoEq5Kf81/PBWjxqQH+aVcE8bVqcqPQDEMlmS/LlQIowIogkEE3bGDDNsKdvrPH5aKkdJEScoW7fnH48aAUTbw78B9BaH/f8t+hMVfdmw8hESDUC7lnn7xlG/Vefv2Sl2LskFUrp9uB2q1atS6ofCBX88sWlVDumiG2ozY+a6bECOAzTqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icz99iLon4vXz+P07YWVrbEKdND+SOxpp9aYZkgy/kw=;
 b=bMRytRo+MEjfS1b6RceW5EQJaSTwi8mVebnqR9v8G3COn4BIida74mXkzLHJTtaJq1tX9lqkeC5FtHRtvorrNvsXCRnslXt7mfVv1/ZCSDZCAq59eDejSUQRRSXrFxcQ6LNtOyAbI/mchJXryxB9ipu3tb+XSMqQs0CmpB6ei5g=
Received: from BL0PR02CA0130.namprd02.prod.outlook.com (2603:10b6:208:35::35)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:49:14 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::87) by BL0PR02CA0130.outlook.office365.com
 (2603:10b6:208:35::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Thu, 8
 Jan 2026 14:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:05 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Jan
 2026 08:49:05 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:49:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 33/42] drm/amdgpu: drop extra parameter for vm_flush
Date: Thu, 8 Jan 2026 09:48:34 -0500
Message-ID: <20260108144843.493816-34-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SA0PR12MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c5c400d-ac27-4532-1d64-08de4ec51751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pGxiFuySRLX3PGDQMkn+fPwrQAA96/jPbdWLKFCcU82Bh6S7G/c3itb6AsFo?=
 =?us-ascii?Q?woOLaf1r1FLnI+GgpzDxmpaqru7joC/vlHC1g05Xt8bgDfscewfh3moSudzQ?=
 =?us-ascii?Q?MTaiqOhkoCsEFM8uABwsTefXPP8iL+uAEoAJfZ8FUdUEhNBfXkmdGym1mSw9?=
 =?us-ascii?Q?j/5lRkKObeqn/Qj7G85J7g9pmmDfyhilVzI0bCcJCDK7JgxHmMO9I130tpzw?=
 =?us-ascii?Q?9w6KwfoT/RTtfNjlCuicT2ctG5k5chhd0n9e2fx15PmwKkS3c5CnWMXW/oe2?=
 =?us-ascii?Q?vBhEEYrGyhEMKZT+gwBp7vW5gJfbGDjpHxHOF113d62ZQmrty4mqmt0kUWy7?=
 =?us-ascii?Q?c2JSsQMznqs9z3hMylOu0EOtz8TZZESNS5/wPc6FCbM46XIShOVd81m7eDKd?=
 =?us-ascii?Q?Wtz25N3icisAAwpVHW2cMGQRLrF/uFHd/plfedai/WpzBtehXMaXoFyeXCe/?=
 =?us-ascii?Q?pypL9dqtvn+dGczwA2tY1r/TYp1nBBRhxk0RKdc5Z/hJzxjkV6yQsfXWviGk?=
 =?us-ascii?Q?yUwmbgJY4BadR9BR2Jc4rlXmJHRtC+es+s8QjidFhH99wulcNauCQEFDn/q+?=
 =?us-ascii?Q?O1mUAp8PL04mOfvVbBkaAzPbA2Endm2b6bXgbi2EhdtnNoOb02ENeaAMtkBB?=
 =?us-ascii?Q?/DaPUKw4ZhdMIOkawSZkRBVSuEInYwUA7mLMCM9ZZ9oa5b4cNCXt2e4yqBtv?=
 =?us-ascii?Q?btjvBKUOktUQgGVlMX7jKH47+Olkg1KmcKlMa2UhjHbJoXM5vSen71q4SxGx?=
 =?us-ascii?Q?ilnBfFVRCGRjptgPrhawAChc4sUNQojlKB22t9Q/xxE+7ClGjqYo5pPEPaqh?=
 =?us-ascii?Q?QVqwn60XCEeGuqBEmWNq2S8rkSRnK2I2Tbor9D+ihTEbPaASRL68YPdc1fkF?=
 =?us-ascii?Q?1YiZTQ38NGC1+Llswn3ddRvLd6dDiAZDcsqnuqDalF/QtXPjTlfBCmWcJYdB?=
 =?us-ascii?Q?wyDYy67kdYBsFKXOzeIor1TT4Y5WQJbR37iWI0jUy0bmNLO45ZCsQBSqtiCu?=
 =?us-ascii?Q?pddRKHByXso8IqAE6/5px8D5NQ52QUe6lmzOAUGNUW1Jkc6j+sOiQX9owMP5?=
 =?us-ascii?Q?qRxKk65rQMdhz4I7o03PCB8GivpAHxRB2Biz/uYg23IDdd1gvUvis7ESJg7P?=
 =?us-ascii?Q?aD767N0Z9ktbUgIQtbevbOwe7susmYCvrOGxwuRY7ghef+RltjLBM26sqNNR?=
 =?us-ascii?Q?PXoejmzGeD/CySXAKUJ3CkrMRlLdv1MmpsdeHKlH/vT4iW/eb5S7E7VWQVKs?=
 =?us-ascii?Q?M6d7vLBzb616vaSVRQSFXsO8fy3Yd7i0FtBXQiQ3IInECVGkOH33oMsF0A8b?=
 =?us-ascii?Q?2Kjeh6aQH7JMCY7fudywrQSkJ6oz3W5cjDsdky01WoSiCUIBGpkKqAOmx2QE?=
 =?us-ascii?Q?ngFbd4H3Z3Klb4fhWhXX2ZYSKeILeNKpZdhZzGHBzZ5uGmqAxQeP2SOHx/oP?=
 =?us-ascii?Q?xmzc8Lr1BCHFR9klySqWPPzEcJkLc3XYReZoaqLFo5gOZ+Ds9q0oUAesKc+4?=
 =?us-ascii?Q?g1vYPLJfFFuCwrBsA0fxxO95TOLOmL8BXP+IHxqE1Y9i9/cPzKWLmaggc1RO?=
 =?us-ascii?Q?fMzhx2OJF4fJuaIrt40=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:13.9460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5c400d-ac27-4532-1d64-08de4ec51751
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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
index fb2e08ea248c6..d9db39d56fa2d 100644
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

