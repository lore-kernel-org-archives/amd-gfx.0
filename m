Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CD9D1D468
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D6ED10E777;
	Thu,  8 Jan 2026 14:49:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sOZg/TWk";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F38DB10E773
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCRQkB9UDxRS5v+YltEYvDtZKpljtOJa8jMJ9hMpaSqKXtVsuPwtxTQNup+fU7dQC20IRX+qEOOgF9vf/PCsVlGqDKEYVcfpQIilaDgt2rGvhROBTHUGgkV9OTOza5lBMrDqIxk7heuzsREcMHlV5rTvt3l0Lwa41yX61nVw/W1tGHqMZl0cGfiyM6uQTirO5jWArwPb3uBtZHROtrYurTHa80OfGcrs40i80HspK8rA1NWpy8YQA6W1sOBcV71ufqmq49kkIgI3TUtxG6vuzl9MW9N/P9Mjw6ODRIvjL0GHi/U3FywSeyfK/Wd4afQEjfcq2OGqL0zi9bza83br8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtFPlcpGJ6ijcnf9JsepRz2T4bHPVZljt8yffwWAhlY=;
 b=qDZxGCukxwHPosnhkZzDNrgMPceZ49XV3npnATSh+V+VGrmG5nPkMaK1hYaVg9Q89Ym7E+T/TRpMioHHzU/ItX6ThXGpRpk8dPPnh9c0NAXUqd6pbIMVY/9nvLUexsXhUJ5w82YbXDi2+PqkDoHO2a8jDKK3Cgkr+rCKpe2w8wrm+erBhcSEynvwjmQmIVrAF5QpxAOrkBv/70FUIRuzLu1BUTtQroc95aYKPpvq317mK5dLgqft2JIyv96G+4mPcIBiCyFCR0X2+JmgsaK+0EuRsYz9JE1ueYdw1JbMZ9yY6O5RXIYd3mAanLJVkqTAdnT48RlJJIZg1typJK6Fcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtFPlcpGJ6ijcnf9JsepRz2T4bHPVZljt8yffwWAhlY=;
 b=sOZg/TWkyl8w+3zRUVw4fnxtI1WZGRed192WO+h9bbhWr1goOwzaHGyjTIMVJbIFzyy8ZMQ4ynAwjq+ZDn/ynNOfJimjT41UAS+QOYlCv9ha8ViDiP8dD6853GmDh1AeAFr0IHFJDdCmkZQwNJZ6gs0IMaH8e4gIttGcpkhv2FA=
Received: from BL0PR02CA0126.namprd02.prod.outlook.com (2603:10b6:208:35::31)
 by CY5PR12MB6597.namprd12.prod.outlook.com (2603:10b6:930:43::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Thu, 8 Jan
 2026 14:49:11 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::53) by BL0PR02CA0126.outlook.office365.com
 (2603:10b6:208:35::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Thu, 8
 Jan 2026 14:49:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:02 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:49:01 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 26/42] drm/amdgpu: require a job to schedule an IB
Date: Thu, 8 Jan 2026 09:48:27 -0500
Message-ID: <20260108144843.493816-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CY5PR12MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: a161349b-7c77-4c29-20fa-08de4ec5159e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4zAqAUhGlHClLdI7iFEWn2UqKvTCYBMwcaH5uhvxuh+siVh9eTND3DTxiDz1?=
 =?us-ascii?Q?S6Pca+LciUZEWbXAlrpLVhVrLByUnt6J8TV1xRam46YQouMt/mg0gN/Snu0/?=
 =?us-ascii?Q?ItvnUjz4+SceRWYovsB3ir4oM9e3U0bh7FzmqzLvPvON89rM3gVMioiDLH5n?=
 =?us-ascii?Q?mjAVllyRhAk7mWDjGRjU1/hVI1djNYNL2FQ8Yh2iwTo51qBiJx7NMHczbA8v?=
 =?us-ascii?Q?UctATGlzF/FTNui+GsKtzew3PBJiYWxrUc/JLIlbKYQHCQ9qXTmhuA1Q7fub?=
 =?us-ascii?Q?eMpqkHx2BdaP7tIlnug5VLglbOC/OvOUQn0Njwn240j/pHfsBflYLlHE4HSV?=
 =?us-ascii?Q?KeWNkDdmSxdBl97AriuotDYwY0sRKkWWSlMpCL4hIQDTMMN+BvmWnt/oN2Lo?=
 =?us-ascii?Q?q0jugCC6FF4M7IOqXmQS0/rV02NWd9JsKBqFqzk+fIqbFhwDAxlwqfbMlOxe?=
 =?us-ascii?Q?h3TLBE05JSpumqjzgHyZSh56YVkuh6GVL/V1aI+ZPFg86U6t6PH8jDaPsBlo?=
 =?us-ascii?Q?tz+oOxNWy7AfThMxX5gGlE7/1ekOyV77aQcAOonaoqoISTnTHeHt0tKBWyhC?=
 =?us-ascii?Q?LbqleIHeAU/e1eaf0fLCIJQEhwA1n2ZBpqLiPiBXkOP5gVPbzZr/f1XQZi4D?=
 =?us-ascii?Q?OVIE/qamJcgtonSXyMC7+NLCbTOUQ7dF+nMVfgMalkIQrqyKSPnxv6CuFo2U?=
 =?us-ascii?Q?Ju138KsTGSEiiUQDOHmsqARwUR3vU2ZRQCVRaTi2muumTjg2sLyZ1uqp7fpg?=
 =?us-ascii?Q?8jn533B0i7hnvLcDmHRfwGd3HOUnP8ywihX2Mb32UmQ1QND6HWWeAsk63iiS?=
 =?us-ascii?Q?oggiG7slO1j33/kv4kOFHD3tGmQvsuLzb4p/fL/it6Yp3COj5KSSCeezUnZa?=
 =?us-ascii?Q?jdgIdWeeSgMFsfNfLenEOwZhIhDaOYJy1sGCYBOyyTrSTpdJt9OpVj3NO6mf?=
 =?us-ascii?Q?5PQSXCyYgkIv9SlJfsr8rckC6GG9o3C20RIOk6YBy2JfCNcgjylDe9d8N+T6?=
 =?us-ascii?Q?KP/mae+bIUGrlhatVMNM8pxywOe9ZoAgejW3ajJrcQE1yr8hAXvAyxyPK8wg?=
 =?us-ascii?Q?BTAF+FloawHrcHzFWar0rFfr64NQ/jQ8Q9YLaKfZmGHkzUsMn0efa7IdIPvh?=
 =?us-ascii?Q?gTwpyizZ1wHoG1bJSSuwUBtv5stObRXVAHxGiMmfe11ojxJhZwK7c0VgEtpx?=
 =?us-ascii?Q?hdAuJLkhR83Hd4U1hHy3LUHveRvcQty6dXVVE1WH6x9bldJHXEc+AQ5Od/rM?=
 =?us-ascii?Q?Ky52LRi9cT3APgCOsoo4fZUIORrLcBw+J98krstODMkBdmnQeMYxomh3F40l?=
 =?us-ascii?Q?svBVkaOfvLvpRrgRhbW9Q78mPoerCqQiRo6/flL8Fi5rZK8m1D7BvH3tmPnI?=
 =?us-ascii?Q?SsOEMBlOG0AJWKckJFvsqwZH6x5+/9y64Pon4ME/j10r4x9oUmORq/R7/UUo?=
 =?us-ascii?Q?VSJ1dOrqq4S0L277AHItpMPLj1WBCyD9w8ab0Qkyh2htTRbLYbiJ2VwJqRmM?=
 =?us-ascii?Q?jxzhMN4/7ZyWHc6DzOn+YuT+E5ZV2Ap5TxA1KxA3JJVAF4t0vuUzHbV/FV4m?=
 =?us-ascii?Q?jfRRoWTPVNSUv666W2s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:11.0960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a161349b-7c77-4c29-20fa-08de4ec5159e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6597
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

Remove the old direct submit path.  This simplifies
the code.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 106 ++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   3 +-
 4 files changed, 45 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 67a01c4f38855..e8f1266cd8575 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -680,7 +680,7 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 	job->vmid = vmid;
 	job->num_ibs = 1;
 
-	ret = amdgpu_ib_schedule(ring, 1, ib, job, &f);
+	ret = amdgpu_ib_schedule(ring, job, &f);
 
 	if (ret) {
 		drm_err(adev_to_drm(adev), "failed to schedule IB.\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 72ec455fa932c..fb2e08ea248c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -103,8 +103,6 @@ void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f)
  * amdgpu_ib_schedule - schedule an IB (Indirect Buffer) on the ring
  *
  * @ring: ring index the IB is associated with
- * @num_ibs: number of IBs to schedule
- * @ibs: IB objects to schedule
  * @job: job to schedule
  * @f: fence created during this submission
  *
@@ -121,12 +119,11 @@ void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f)
  * a CONST_IB), it will be put on the ring prior to the DE IB.  Prior
  * to SI there was just a DE IB.
  */
-int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
-		       struct amdgpu_ib *ibs, struct amdgpu_job *job,
+int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		       struct dma_fence **f)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib *ib = &ibs[0];
+	struct amdgpu_ib *ib;
 	struct dma_fence *tmp = NULL;
 	struct amdgpu_fence *af;
 	bool need_ctx_switch;
@@ -142,64 +139,51 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	unsigned int i;
 	int r = 0;
 
-	if (num_ibs == 0)
+	if (!job)
+		return -EINVAL;
+	if (job->num_ibs == 0)
 		return -EINVAL;
 
-	/* ring tests don't use a job */
-	if (job) {
-		vm = job->vm;
-		fence_ctx = job->base.s_fence ?
-			job->base.s_fence->finished.context : 0;
-		shadow_va = job->shadow_va;
-		csa_va = job->csa_va;
-		gds_va = job->gds_va;
-		init_shadow = job->init_shadow;
-		af = job->hw_fence;
-		/* Save the context of the job for reset handling.
-		 * The driver needs this so it can skip the ring
-		 * contents for guilty contexts.
-		 */
-		af->context = fence_ctx;
-		/* the vm fence is also part of the job's context */
-		job->hw_vm_fence->context = fence_ctx;
-	} else {
-		vm = NULL;
-		fence_ctx = 0;
-		shadow_va = 0;
-		csa_va = 0;
-		gds_va = 0;
-		init_shadow = false;
-		af = kzalloc(sizeof(*af), GFP_ATOMIC);
-		if (!af)
-			return -ENOMEM;
-	}
+	ib = &job->ibs[0];
+	vm = job->vm;
+	fence_ctx = job->base.s_fence ?
+		job->base.s_fence->finished.context : 0;
+	shadow_va = job->shadow_va;
+	csa_va = job->csa_va;
+	gds_va = job->gds_va;
+	init_shadow = job->init_shadow;
+	af = job->hw_fence;
+	/* Save the context of the job for reset handling.
+	 * The driver needs this so it can skip the ring
+	 * contents for guilty contexts.
+	 */
+	af->context = fence_ctx;
+	/* the vm fence is also part of the job's context */
+	job->hw_vm_fence->context = fence_ctx;
 
 	if (!ring->sched.ready) {
 		dev_err(adev->dev, "couldn't schedule ib on ring <%s>\n", ring->name);
-		r = -EINVAL;
-		goto free_fence;
+		return -EINVAL;
 	}
 
 	if (vm && !job->vmid) {
 		dev_err(adev->dev, "VM IB without ID\n");
-		r = -EINVAL;
-		goto free_fence;
+		return -EINVAL;
 	}
 
 	if ((ib->flags & AMDGPU_IB_FLAGS_SECURE) &&
 	    (!ring->funcs->secure_submission_supported)) {
 		dev_err(adev->dev, "secure submissions not supported on ring <%s>\n", ring->name);
-		r = -EINVAL;
-		goto free_fence;
+		return -EINVAL;
 	}
 
-	alloc_size = ring->funcs->emit_frame_size + num_ibs *
+	alloc_size = ring->funcs->emit_frame_size + job->num_ibs *
 		ring->funcs->emit_ib_size;
 
 	r = amdgpu_ring_alloc(ring, alloc_size);
 	if (r) {
 		dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
-		goto free_fence;
+		return r;
 	}
 
 	need_ctx_switch = ring->current_ctx != fence_ctx;
@@ -225,12 +209,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	if (ring->funcs->insert_start)
 		ring->funcs->insert_start(ring);
 
-	if (job) {
-		r = amdgpu_vm_flush(ring, job, need_pipe_sync);
-		if (r) {
-			amdgpu_ring_undo(ring);
-			return r;
-		}
+	r = amdgpu_vm_flush(ring, job, need_pipe_sync);
+	if (r) {
+		amdgpu_ring_undo(ring);
+		return r;
 	}
 
 	amdgpu_ring_ib_begin(ring);
@@ -248,7 +230,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	if (need_ctx_switch)
 		status |= AMDGPU_HAVE_CTX_SWITCH;
 
-	if (job && ring->funcs->emit_cntxcntl) {
+	if (ring->funcs->emit_cntxcntl) {
 		status |= job->preamble_status;
 		status |= job->preemption_status;
 		amdgpu_ring_emit_cntxcntl(ring, status);
@@ -257,15 +239,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	/* Setup initial TMZiness and send it off.
 	 */
 	secure = false;
-	if (job && ring->funcs->emit_frame_cntl) {
+	if (ring->funcs->emit_frame_cntl) {
 		secure = ib->flags & AMDGPU_IB_FLAGS_SECURE;
 		amdgpu_ring_emit_frame_cntl(ring, true, secure);
 	}
 
-	for (i = 0; i < num_ibs; ++i) {
-		ib = &ibs[i];
+	for (i = 0; i < job->num_ibs; ++i) {
+		ib = &job->ibs[i];
 
-		if (job && ring->funcs->emit_frame_cntl) {
+		if (ring->funcs->emit_frame_cntl) {
 			if (secure != !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
 				amdgpu_ring_emit_frame_cntl(ring, false, secure);
 				secure = !secure;
@@ -277,7 +259,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		status &= ~AMDGPU_HAVE_CTX_SWITCH;
 	}
 
-	if (job && ring->funcs->emit_frame_cntl)
+	if (ring->funcs->emit_frame_cntl)
 		amdgpu_ring_emit_frame_cntl(ring, false, secure);
 
 	amdgpu_device_invalidate_hdp(adev, ring);
@@ -286,7 +268,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		fence_flags |= AMDGPU_FENCE_FLAG_TC_WB_ONLY;
 
 	/* wrap the last IB with fence */
-	if (job && job->uf_addr) {
+	if (job->uf_addr) {
 		amdgpu_ring_emit_fence(ring, job->uf_addr, job->uf_sequence,
 				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
 	}
@@ -299,15 +281,14 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	r = amdgpu_fence_emit(ring, af, fence_flags);
 	if (r) {
 		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
-		if (job && job->vmid)
+		if (job->vmid)
 			amdgpu_vmid_reset(adev, ring->vm_hub, job->vmid);
 		amdgpu_ring_undo(ring);
-		goto free_fence;
+		return r;
 	}
 	*f = &af->base;
 	/* get a ref for the job */
-	if (job)
-		dma_fence_get(*f);
+	dma_fence_get(*f);
 
 	if (ring->funcs->insert_end)
 		ring->funcs->insert_end(ring);
@@ -315,7 +296,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	amdgpu_ring_patch_cond_exec(ring, cond_exec);
 
 	ring->current_ctx = fence_ctx;
-	if (job && ring->funcs->emit_switch_buffer)
+	if (ring->funcs->emit_switch_buffer)
 		amdgpu_ring_emit_switch_buffer(ring);
 
 	if (ring->funcs->emit_wave_limit &&
@@ -334,11 +315,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	amdgpu_ring_commit(ring);
 
 	return 0;
-
-free_fence:
-	if (!job)
-		kfree(af);
-	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 7f5d01164897f..d94b85e4e28a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -367,7 +367,7 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
 	int r;
 
 	job->base.sched = &ring->sched;
-	r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job, fence);
+	r = amdgpu_ib_schedule(ring, job, fence);
 
 	if (r)
 		return r;
@@ -437,8 +437,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 		dev_dbg(adev->dev, "Skip scheduling IBs in ring(%s)",
 			ring->name);
 	} else {
-		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
-				       &fence);
+		r = amdgpu_ib_schedule(ring, job, &fence);
 		if (r)
 			dev_err(adev->dev,
 				"Error scheduling IBs (%d) in ring(%s)", r,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 87c9df6c2ecfe..cf56babb2527a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -569,8 +569,7 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		  enum amdgpu_ib_pool_type pool,
 		  struct amdgpu_ib *ib);
 void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f);
-int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
-		       struct amdgpu_ib *ibs, struct amdgpu_job *job,
+int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		       struct dma_fence **f);
 int amdgpu_ib_pool_init(struct amdgpu_device *adev);
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
-- 
2.52.0

