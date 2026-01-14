Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C355D38FF3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11AFD10E65A;
	Wed, 14 Jan 2026 16:48:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EeIOZI6x";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7EAA10E65D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWXQ9169s4Xwuhu977fJQ4p7RkKXvAQwK35OrAjrbo89fYfTuApOFdq/brPX0QiDq8vI1JoV300nwD4K/pWPwvf948EZ4qk5E9ErZAR5r9QoybDIO2XJCs5x11V1j04+FICTgTOFT8qSP4w4jGkCukmBubbHXViL7SrL6YYR2Ueq63RuDcKoXqmjxn7fEuw7ejzeaNJngTSa8YCIGe0RH3VULShpfl5ocFPfiE8IYZCeDvfXpaiaUzXiq96RbFdfb50RkcVoEoTXr2tOONJ8LyXItccEB5pBZWInfyVIP4S/YR6CAzmDPTpJQ8aufnCJ+HrP9ykzYsPkiHAeAOi0dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztzBHzGsT6R5iZfHm6qM0aoFGwlwzOS+CbrvxlbegLM=;
 b=X4VW49jX4YG4KBsTybSQgQVOgxbUx+q7K3ojkGQbnzlnUWETpI/hQ+3xVdMQCxyWq+lEMn+j8yT4EMvcVKI0Uju+HJBoKnRYiDP0A2PYMkuqlLsUTcv/lpvgEKk+K+3k/hW9hqU/EAwYRgTZCcpF7KuZlHp26Tp9UZCNDhJBuxyCh27CJpzSUUkp2l67MHHUsTzfahYBkGJlpb2c1EC5WfRrdfyKbXpVJ5ohfpGf0C6Lfvx7VigLm1tw6chM8kZ6NnCsunWFdvqIqHOsk4PKz6XBA2JxvMkJpaVGFsuH+SvqNd53eVnCAMHZsxhF5I7klcjquLhdVT9So2QqsUaXnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztzBHzGsT6R5iZfHm6qM0aoFGwlwzOS+CbrvxlbegLM=;
 b=EeIOZI6xwktIvg6nG0wuecCW9LM5UUggXd35UdlRfX2nf9qtR8+qoXr9Jwy1YoUFTFdGu/qapEYpwJhY7ergGIg20SGVKl6zyDsxg7cExyB7xyLnK4xPZrFh3LBTJ/CEz8sWsSlQfXaS3hIE+Sh4o9UdxK/5RkK9/klxM4/9vTE=
Received: from MN2PR18CA0028.namprd18.prod.outlook.com (2603:10b6:208:23c::33)
 by PH7PR12MB7017.namprd12.prod.outlook.com (2603:10b6:510:1b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:48:10 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::1b) by MN2PR18CA0028.outlook.office365.com
 (2603:10b6:208:23c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 16:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:48:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:47 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:47 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 24/42] drm/amdgpu: require a job to schedule an IB
Date: Wed, 14 Jan 2026 11:47:09 -0500
Message-ID: <20260114164727.15367-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|PH7PR12MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 12dd8499-4b99-4742-9464-08de538cb35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UiA9e+tg7GGekwgON1qqymJ33q0kd9T2RErcN23tlLRBBNkqWeId+DwW77+F?=
 =?us-ascii?Q?d9YWbZid+2POeaBlGsop0I3krgcqMAvWT17kE95t8mAFutcGMdUPlDy6Kiej?=
 =?us-ascii?Q?UMsoZ55eeE9IjTtz2F9rwq6MGRBJh/JzXbgkIjHdvbG/6NjrjMlwhXnoxDls?=
 =?us-ascii?Q?eXcWsHHvSUeGitimaN1+a0prLCtQKFSWfOM2W3w97D0GwTAGvA3ekkRz+pQC?=
 =?us-ascii?Q?2xmlQXdQ9k+fQcRqKFJGtKFtFyBEK936TFAYI2C+N310lTPGS+6/IhEkri46?=
 =?us-ascii?Q?5yoYwZjpynf1O69L3tseeJgvRNDtQCAK+vCeAeFqFJO3jpWuVsnHURIV6Wnw?=
 =?us-ascii?Q?KPDmqh4YUSJ/KXnOwJqzyb4nfOSwjvZuMeZtoTdRNsvGtg2f0JL9m+Nhu86e?=
 =?us-ascii?Q?KiKjspzVA7cydv9/FQIaJuYtUaabMnHDBB6gNanCo/012NvrO9pbVpltFsrG?=
 =?us-ascii?Q?WtZw9dVOKOttrE0GyvbKZsAEQnUMKKBmsrlDXM+wRbVuGsyL01j32a08NLOn?=
 =?us-ascii?Q?1nW3+WbHSv4btgX78NEvrZrpwW1Goq9m881qwfQZZf7BTXjE9kMmPu44EAYX?=
 =?us-ascii?Q?u/IGYx9fxJ5d/tBi8OIIvS29KT2GL6LN/dkIwhbOZfF9B0QwUp0kRPE/YJMd?=
 =?us-ascii?Q?xQjhR34xSrmlqKM14clIhN9bAqj+IHS5M1JiC45P/9YQn9XzBnBX76CG1t1x?=
 =?us-ascii?Q?sqogYlqCmeSZPIgDX2qOCYyxDOioNCLH4+bnzmuKP8NzBozPgCH71G4Oti3i?=
 =?us-ascii?Q?e5PTsw//sNnZHDTwuUSDbepmZBrUB0bbS8Sicx9c+P8l/o5T9mv+Z+UTCBJK?=
 =?us-ascii?Q?519Cpob9WK8EvdG0O9f16feimOaRlmruYT/PlqRwQMguI3hWEN5mYh0DHKmJ?=
 =?us-ascii?Q?ycOuSpha+cblMXfSWePbCjqRKiEJExHK6wmpi2yr2PoNeSeVXgOop5k+V6Tt?=
 =?us-ascii?Q?kqtYsJnHBZSFF8oDOkgnndIXAd91Rv+uVEaoiPWWoDduz3a/BKJhVz+F99HO?=
 =?us-ascii?Q?w7b2wzUw2AUi7tO7yCsj+4LDFeFXzWoy2XDAp9B8MFIaylRkeN/mynpqpanP?=
 =?us-ascii?Q?JZbwJNhddAZ+qnCsmb5k6MYyyCHO3uzRKnLFeas8Xm2pHTAoqElwGsf3UO0J?=
 =?us-ascii?Q?iI9mjYFL16O/7APyexrYYHl8VMEqi/AWtYXrSva4BaNmoXHFSm9GOZ0vREPU?=
 =?us-ascii?Q?Us6XeHUUi0rI38Id6iQbLj0ZWOwccOdND3flF+Nr5ifFwa/gsZnH7eGPyXf5?=
 =?us-ascii?Q?kKkuluO/9V7THQnXHI2es8MkpOY7lkW3bS++4z8qrEMPhKF/bwJQ46NbhGov?=
 =?us-ascii?Q?79adnUmXVeFZx5vRXR8fi8Y+8MKvhv4EeJo7uXg/je5FFM5AhLbchfflM4vI?=
 =?us-ascii?Q?nBGdmKC/C1wVA/15Z7bx/36U7tvUaHGhz1j3gj2qAcITPJcPcfB2pIM9WNrB?=
 =?us-ascii?Q?JPmuJ6JofSlgca/jEszzluW4lIetdNkOGOSGn3Nexk8PxLOObq+cNMCJEECl?=
 =?us-ascii?Q?AdcUBNpUYDv7ufP4nGFgKNQMblnZUvUGssGWiF1DvikDdRVMKBbO/HRWvCCP?=
 =?us-ascii?Q?mWLijOgK9i7bJ3QGrtC8CsvsBRF0PIg1xwATsKn3miPjYkBx1e5XcQ9mqwfE?=
 =?us-ascii?Q?S9KcSrxqlJoVeyJnr59Zb5asP0vzy4r+SW5AGIS0IkDLp+wGJsgh9HB5DowX?=
 =?us-ascii?Q?HiJ9vQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:48:10.2430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12dd8499-4b99-4742-9464-08de538cb35c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7017
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
index 136e50de712a0..fb58637ed1507 100644
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
index 35c19215a2e0a..d96a4339e340c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -370,7 +370,7 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
 	int r;
 
 	job->base.sched = &ring->sched;
-	r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job, fence);
+	r = amdgpu_ib_schedule(ring, job, fence);
 
 	if (r)
 		return r;
@@ -440,8 +440,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
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

