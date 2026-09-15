Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EFDC88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 07:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2641610F1C5;
	Tue, 15 Sep 2026 07:20:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4mxkUuKz";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010052.outbound.protection.outlook.com
 [52.101.193.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FBC010F1C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 07:20:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBnLofESD/uF2OwDk1B4j+jw+am2+ljxaNEQ7Fu3Au6jzE7F5YdCLc9wR3zLfAaOxXB38NIquI32idxDGXOk9rl3tHleaEPNGN53aXCn6mC94BEUsj9CSJpIguwzdxFibNHmcvkOstJeqfGkPu3yVsQ2RYhOMgqaJY/TyC1+LD6481mK22pAo2ZTif2NYUGmSI/KoBY8tGBYYxk9UFrOqBbiZjjpj4gCQPAIddkF/lsv43m1PnNfr1ZoZTkB7KLoPIE5dTZisCIXnqFCJCNBgbGPKk93oVwEnDsyhTE1qCBwO6QpRkByACKQI3hlCO3MwwxKmXUvwbMuDCdlci3tIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0Ck8EZtz2Cl1KDYN44Z98jH1i5j2b8l0UdAWe+JWTM=;
 b=L5ILFiwtEcAj8rPJCQvXsteNzes8jVvMGmtybGOFlhavPAqhyxm9LkD4GSejNEsQf0LlyvMF+zz5k822BYd0Ma9Muco7AvsZaMck1Gb6Br9lrRQVLJHtk108aVbMTnw628Wu/z0BDhE1h5I804DckC5QpFTDudF9ZWDiP9nSPjUB7FacGLoeDgoMBEdjInL5FkrP4JiOXEXZXNnrkaERPl176eVyOdxU7pbVs1tz4vYpSjN8MZNhvZYzAubp/3/hHvo2OZmuenz2nGfqS5LDT/lmrg9kigIerrBPOgub8qeEfKbOc4mFvopDvrf1K/15yJcwU6dufVz9WRfStFoENQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0Ck8EZtz2Cl1KDYN44Z98jH1i5j2b8l0UdAWe+JWTM=;
 b=4mxkUuKzTRRG3uPqGF3l7l3eed+JHhAj8OZ1MvPqKbmnmnH3raeJZCIC/rUlPTc/OrwNXf0W0a5sP9nuT3lQlTm6hYyZZhuAGmZEy+1QHfctMJoAXRI4eh7WRO/bHH86ziGEGfb6lTbR4SjgTW9nvQyaTv7emmTcAL15ApsDsIw=
Received: from CH0PR03CA0220.namprd03.prod.outlook.com (2603:10b6:610:e7::15)
 by SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 07:20:12 +0000
Received: from BN2PEPF0000A801.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::1a) by CH0PR03CA0220.outlook.office365.com
 (2603:10b6:610:e7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 07:20:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A801.mail.protection.outlook.com (10.167.245.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 07:20:12 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 02:20:03 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 5/5] drm/amdgpu: mark queue and process as guilty for hung
 user queue
Date: Tue, 15 Sep 2026 15:19:46 +0800
Message-ID: <20260915071946.710846-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915071946.710846-1-Prike.Liang@amd.com>
References: <20260915071946.710846-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A801:EE_|SN7PR12MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: d326bd6b-3fe4-4048-8323-08df12f9c82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +rJWy+CBOdHUK023R8JT5YnV7d5U9gmAohVp/GLc6/t+rYMmIGbNiEoNN1Ep97HPn5j7r5Pb1Oqt7sCrKR5vkgju7zdCBEXdG6sbLC0zV6w9H5A2WKUiFqOxL8q+PigL0E3HDnrFyfelgVsGmkhHq2CFE+AMS4qv3PML3g1g/70r5Q+5AavPFvFYoLdAS0spA6hZWHgFGvxKU1KzMWW+LdssaLceeilafPv3IdHXM+nKaHcyGfTdNnk0yyjANS73yxhBadOHOsRIOjkW/C3gw9C7kcjlgiV5E0Vtv4bzIJMHR4DjRgcQeDkuylbyUNPQxWdZX0fCoT+LHW6dsyROgUONoi2XD5t4YaGQTZ6t+Urlk/Z3TnAhamQOUkvivtCdyBbT4K+S2aEdeA/wsjqr1jbcTYP6opTCyKD2HhzLytUeZcRzGKpIrRRSw9KwJstF2f6lNBY/dOmpE3C7oaq41GD9IokIlbyYtQEuyAxXTe7Q6lgVuaNGcgYBWMkH/NNw0Dm2V/8mPW4LQxJDj6moQJTUGWHRW9bw3IMdc8d2GmiEpCZ1IoqzzR4CcLAv4hGPOYiEJNnrR3MW0GYocHKE8iCWR4/SLi5Z3D3WaGLLnRrUfthObHka/IMopz5FUatr6dmlMervbm6uAvgv9kQe6sTgqo+p/l2IxOHYSzC1BsuEoKgBtXgFOuUC4GfoNbi7/AURszYMCMCo0pQfdKAXZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5+J0AtOx3g8E+BkieRQZqmb7PVcMTe79NM5NGa9zyyASZcffB3IjRhOmpz+DrITeajcNjxs/pD1g30i37i931QbPDgCOQg8AERzbaDaJp5kM78MYXQgjKSKUK8yJa6/dbhRN3GX63lOoVKE/Kjp9YI/4lH4v2reTcdsVoY4YDX1F82pqAKYujgPdP87skpwOhqYQLhFkWe5qLnTSBWZtoqNRJwSJ9Er9gSEowILX6phpFmCL9qoWImJnzW5W3Mx4gSSao5kzytNiD7trtaQyA6ccETKCZVW//yDwVnJIahK0XoXbLocbRBl2XBlFWXnZ+kYHjKl25LTPPMbVlzYdXc8RyiLiuJUqe696QIDEpmg4449zc05YDzRWel+QThfWEt4bmoUtDeWK5DW6viKgwHO42u9Y5CsPgVqpc88slu/mkNwDzMccTuZJ/aG2tqhW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:20:12.3867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d326bd6b-3fe4-4048-8323-08df12f9c82b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A801.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809
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

When a hung user queue triggers a reset, its context becomes corrupted
and must not be replayed. Mark both the queue and its owning process as
guilty so that user space is notified that the offending queue is no
longer usable and must recreate the context before resubmitting work.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 48 +++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  5 ++-
 3 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index b15ed4a534f1..1094057d2e1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -589,7 +589,9 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
 	if (ctx->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_VRAMLOST;
 
-	if (amdgpu_ctx_guilty(ctx))
+	if (amdgpu_ctx_guilty(ctx) ||
+	    ((out->state.flags & AMDGPU_CTX_QUERY2_FLAGS_RESET) &&
+	     READ_ONCE(fpriv->userq_mgr.guilty)))
 		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_GUILTY;
 
 	if (amdgpu_in_reset(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 6c92575213c1..6bd8867a6eae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -126,6 +126,7 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 		adev->userq_funcs[queue->queue_type];
 	struct drm_wedge_task_info *info = NULL;
 	struct amdgpu_task_info *ti = NULL;
+	unsigned long flags;
 	bool gpu_reset = false;
 
 	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
@@ -148,6 +149,11 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 		}
 	}
 
+	xa_lock_irqsave(&adev->userq_doorbell_xa, flags);
+	WRITE_ONCE(queue->guilty, true);
+	WRITE_ONCE(uq_mgr->guilty, true);
+	xa_unlock_irqrestore(&adev->userq_doorbell_xa, flags);
+
 	if (amdgpu_userq_is_reset_type_supported(adev, queue->queue_type,
 						 AMDGPU_RESET_TYPE_PER_QUEUE)) {
 		int r;
@@ -174,7 +180,7 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 	 * handler to another is illegal if you don't take extra precautions!
 	 */
 	if (gpu_reset)
-		amdgpu_userq_mgr_reset_work(&queue->userq_mgr->reset_work);
+		amdgpu_userq_mgr_reset_work(&uq_mgr->reset_work);
 }
 
 /*
@@ -338,6 +344,10 @@ static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
 		adev->userq_funcs[queue->queue_type];
 	int r = 0;
 
+	if (READ_ONCE(queue->guilty) ||
+	    queue->generation != amdgpu_vm_generation(adev, queue->vm))
+		return 0;
+
 	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
 		trace_amdgpu_userq_state_start(queue);
 
@@ -388,9 +398,12 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
 		adev->userq_funcs[queue->queue_type];
 	int r;
 
+	if (READ_ONCE(queue->guilty) ||
+	    queue->generation != amdgpu_vm_generation(adev, queue->vm))
+		return 0;
+
 	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
 		trace_amdgpu_userq_state_start(queue);
-
 		r = userq_funcs->map(queue);
 		if (r) {
 			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
@@ -630,6 +643,27 @@ static int amdgpu_userq_priority_permit(struct drm_file *filp,
 	return -EACCES;
 }
 
+static void amdgpu_userq_mgr_clear_guilty(struct amdgpu_userq_mgr *uq_mgr)
+{
+	struct xarray *xa = &uq_mgr->adev->userq_doorbell_xa;
+	struct amdgpu_usermode_queue *queue;
+	unsigned long flags, queue_id;
+
+	xa_lock_irqsave(xa, flags);
+	if (!READ_ONCE(uq_mgr->guilty))
+		goto unlock;
+
+	xa_for_each(xa, queue_id, queue) {
+		if (queue->userq_mgr == uq_mgr && READ_ONCE(queue->guilty))
+			goto unlock;
+	}
+
+	WRITE_ONCE(uq_mgr->guilty, false);
+
+unlock:
+	xa_unlock_irqrestore(xa, flags);
+}
+
 static int
 amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 {
@@ -789,6 +823,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		return r;
 	}
 
+	amdgpu_userq_mgr_clear_guilty(uq_mgr);
 	amdgpu_debugfs_userq_init(filp, queue, qid);
 	trace_amdgpu_userq_create_end(queue, 0);
 	args->out.queue_id = qid;
@@ -831,7 +866,8 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 
 	args->out_qs.flags = 0;
-	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG ||
+	    READ_ONCE(queue->guilty))
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
 	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
@@ -1594,7 +1630,11 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
 	int ret = 0, r;
 
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
-		if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
+		if (vram_lost || READ_ONCE(queue->guilty) ||
+		    queue->generation != amdgpu_vm_generation(adev, queue->vm))
+			continue;
+
+		if (queue->state == AMDGPU_USERQ_STATE_HUNG) {
 			trace_amdgpu_userq_state_start(queue);
 
 			userq_funcs = adev->userq_funcs[queue->queue_type];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 40228c60a1ea..f2eca744a3c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -51,6 +51,8 @@ struct amdgpu_userq_obj {
 struct amdgpu_usermode_queue {
 	int			queue_type;
 	enum amdgpu_userq_state state;
+	/* Reset due to a hang; must not be re-mapped, userspace recreates. */
+	bool			guilty;
 	uint64_t		doorbell_handle;
 	uint64_t		doorbell_index;
 	u32			doorbell_offset;
@@ -132,7 +134,8 @@ struct amdgpu_userq_mgr {
 	struct drm_file			*file;
 	struct mutex			proc_ctx_lock;
 	struct amdgpu_userq_obj		proc_ctx_obj;
-
+	/* Set when any queue owned by this process is reset guilty */
+	bool                            guilty;
 	bool				proc_ctx_allocated;
 	uint32_t			proc_ctx_array_index;
 	/**
-- 
2.34.1

