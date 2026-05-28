Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0894CD6E44
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 10:28:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B41B10EFA8;
	Thu, 28 May 2026 10:28:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hkcjkFbn";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012013.outbound.protection.outlook.com
 [40.93.195.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A817110EFA8
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 10:28:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVMO4RquQCHsd1vJudrSUypcYLCKgN41flkBgwDBcJ8xnzpO6WA8gndF+NVdqc5zlB8j2qihycGwqJgA2rdST76OvRQP0EkBKnFpTixfntKhppu4HIUkmKhGTNgvTUYLAhy6R5lhVpzPK259oWaLD9U5KTBFqXgF7BbNgjjbi4vxIvTbUnmZ3n+YD0aOJHwcfAVjbNExmUEpgAtAQrKYiOWCGfItr4esphbCdblkUobvnm9xHyxbLwt9BdS3bsZHWsWdICE225r1xE8lsXr/exrmZfOW5NVvcgjclxXQk1tuZnieFf9/yH/PC4g2/g8kWUAa37mjaj6AF8r4VgT6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SY5ZXkMXOVp9sUahzcmcU8syQ9EX2jP7hdZKSuLYKc=;
 b=braJYYuJANrz2/rm/infNXcEjylCxg5ys8sdkB4hGwWMg/Rr99OgmnJxsNwvfoZ9itDvKJmRcA1gcEXpunESjQWrnqP4iYbLCDd1YI7lTUPSaofTZwMPxaTYnjuOaQ9EUyXXsqooWZR6rl0W1HCN802A5a7iTENT9ZcscEtVHQ0psOnJA2172nEy5NwSgY61F6j7kSDZ/OciBWkawWR2q5C4f4v1xX8HVjXO8A2yEbL+hDAr8VLxJfbQVranU8Z/eo8iFTxfAfruIBMnD/0BnbwdlDaqnzkrCMzIqpzccWtlFKPS6Fm4BmBKHbeC6qevP7E+kUWqjPxBf6S2eoHuhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SY5ZXkMXOVp9sUahzcmcU8syQ9EX2jP7hdZKSuLYKc=;
 b=hkcjkFbnGpxDkKffSdXmAI4k1sPs8nSHennsA+c0M5+vNhoaj5+bvauxMk/3a+HgZvS4NsRTQyQe1hc7CG3XGWABMwPC6nLBSMXbVWqVbWG/HfYq1b+lgt7OKrOaK99Hohuesfi2DOZISupR7rw0j3iYNO1qMzqcdglJGLuPsBw=
Received: from DS7PR03CA0304.namprd03.prod.outlook.com (2603:10b6:8:2b::16) by
 IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.13; Thu, 28 May 2026 10:28:37 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::3e) by DS7PR03CA0304.outlook.office365.com
 (2603:10b6:8:2b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Thu, 28
 May 2026 10:28:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 28 May 2026 10:28:37 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 05:28:35 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
CC: <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V2] drm/amdgpu: implement per-process MES context
Date: Thu, 28 May 2026 18:28:22 +0800
Message-ID: <20260528102822.20368-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|IA1PR12MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e38ec7c-dfcb-40a7-9703-08debca3e10d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: n/Z5QDYC323qkG1U8P833lgINwR+xVlI7Bj/SQ0f//+gmKRdK/iBEJRbfGPYU2yfTLr6BIV1Kpc/SSc2pwljIJwgjKYIFQIuik0HrnThFP6Aqzv++51uot9WeW6+9QThPJnEHdtjgNSqHM7BN0uJaXdiqZ2ycUULVazXqcKJJEiE5FgRoGVDXAKCudRM77bYryS26rXcgtlq6YCMlI9yBxUGWDniWiWTomy85eNZgrfwqUtarYCiS3cwpYcohgvanEHrlia/banlhmqF7RYDmAG/rr/fT3zjpqunO4c56X5VB6nMG/wjIs30SctX+sx40s3z0fgfdwlGdGEoH2z/XLRtu0L4CQqUqBUin6039EvJeyB0eTMoUIiLfFH/mK9VKID2vN0HzXsUmT0taaKoOCxx6BXVISMvsk/rCPNv0tk9sWKJs3s3fl/x/lMj+7Q4ikRnM9RhGW/POKgzRkH6QVIBLiK7+4Zxt+/jEP+DM0Mr/AM9BGLClstbn5KS3KGXxJUrtPPKzKUrrSp6Eu+bwRbRGOd6UgXk1DSTNAOhS8FMD2sdu+pRajtF0S3YiIUfMEtI/b7jFqAJptX7jZJfvvVmfgXrcTupqCAxtXE5em1bEryQGbETREOJ9dAUDPzgBFPYqcnsqmCb9xemupMdj3aYYK2GWKzTKFWGFXdM1i++p3puoK7ZcgZ4gp7mI7MjOIio1rD3v8/A09fBS9k7+vP4hIfs2QhUAUR2cCWe9qQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3Zlso1WPqmNOBHJ2hZmQZtI6sE2NC8L1qGHJK25uh3q1OAaUOVyR/MtjfkcUAvvY3Hyw1F9mJBv7t0G3cvWnKlVLaWCHffZjIo6HeInl73jGBfzTAWHMulAIsW8EnG0QXn1edGfYP6C82ZBuIa+eExBG378ZQngBVS1LKJPzQA6d+QXYBHalbQbhxfyYtiNLA3rtUs8hREgLcY96eoV7ruYEgmowagnDDrZ75Jo5bT8ov49i3x5ddlIcRKgtyA43yI64gjvolGn8z9awLZgHxQ8sXUjiO17LVV6EDXOp3EZGUbY6y4V7CXtr/oxvNA/mjxs0HDPGQcWxBJ4Cp1ukic8GeD3qriJI9VWiLeAy79w48lui/iRUVNnHr+ZR7y6iEoxswdy7dcjJ0vdAzyooio5yKpDdP5S9Xh8qjLXW0eNZudEu8E12zGcplfyryH+L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 10:28:37.3839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e38ec7c-dfcb-40a7-9703-08debca3e10d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602
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

MES process context is a process-level page
where process specific context is saved for
MES scheduler.

However, current user-queue code path assigns
fw_obj of a queue to MES process_context_addr
when adding the queue to MES.

This means every new queue from the same process
would replace the previous process context address
with that queue's fw_obj address.
What's worse is, when user space frees a queue,
its fw_obj will be freed as well, causing MES
working on a NULL page pointer.

This issue leads to inconsistency and crash
in the scheduler.

This commit allocates a process-level page for
MES process contexts for a process other than queue-level

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 52 +++++++++++++++++-----
 3 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 38e310a8694d..951d5da850be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1172,6 +1172,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
+	mutex_init(&userq_mgr->proc_ctx_lock);
 
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
 	INIT_WORK(&userq_mgr->reset_work, amdgpu_userq_mgr_reset_work);
@@ -1225,6 +1226,11 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 	 */
 	cancel_work_sync(&userq_mgr->reset_work);
 
+	amdgpu_bo_free_kernel(&userq_mgr->proc_ctx_obj.obj,
+			      &userq_mgr->proc_ctx_obj.gpu_addr,
+			      &userq_mgr->proc_ctx_obj.cpu_ptr);
+
+	mutex_destroy(&userq_mgr->proc_ctx_lock);
 	mutex_destroy(&userq_mgr->userq_mutex);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 28cfc6682333..a5867ffe6988 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -127,6 +127,8 @@ struct amdgpu_userq_mgr {
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
+	struct mutex			proc_ctx_lock;
+	struct amdgpu_userq_obj		proc_ctx_obj;
 
 	/**
 	 * @reset_work:
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index e9189f07c6dc..5313cae63322 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -133,8 +133,8 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	queue_input.gang_quantum = 10000;
 	queue_input.paging = false;
 
-	queue_input.process_context_addr = ctx->gpu_addr;
-	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue_input.process_context_addr = uq_mgr->proc_ctx_obj.gpu_addr;
+	queue_input.gang_context_addr = ctx->gpu_addr;
 	queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
 	queue_input.gang_global_priority_level = convert_to_mes_priority(queue->priority);
 
@@ -169,7 +169,7 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
 
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
 	queue_input.doorbell_offset = queue->doorbell_index;
-	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue_input.gang_context_addr = ctx->gpu_addr;
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
@@ -186,12 +186,8 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
 	int r, size;
 
-	/*
-	 * The FW expects at least one page space allocated for
-	 * process ctx and gang ctx each. Create an object
-	 * for the same.
-	 */
-	size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ;
+	/* The FW expects at least one page space allocated for gang ctx. */
+	size = AMDGPU_USERQ_GANG_CTX_SZ;
 	r = amdgpu_bo_create_kernel(uq_mgr->adev, size, 0,
 				    AMDGPU_GEM_DOMAIN_GTT,
 				    &ctx->obj, &ctx->gpu_addr,
@@ -257,6 +253,31 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 	return r;
 }
 
+static int mes_userq_create_proc_ctx_space(struct amdgpu_userq_mgr *uq_mgr)
+{
+	int r = 0;
+
+	mutex_lock(&uq_mgr->proc_ctx_lock);
+	/* This check is a necessary because amdgpu_bo_create_kernel()
+	 * calls helpers like amdgpu_bo_pin() and memset() unconditionally
+	 * even when bo_ptr is NULL
+	 */
+	if (!uq_mgr->proc_ctx_obj.obj) {
+		r = amdgpu_bo_create_kernel(uq_mgr->adev, AMDGPU_USERQ_PROC_CTX_SZ,
+					    0, AMDGPU_GEM_DOMAIN_GTT,
+					    &uq_mgr->proc_ctx_obj.obj,
+					    &uq_mgr->proc_ctx_obj.gpu_addr,
+					    &uq_mgr->proc_ctx_obj.cpu_ptr);
+
+		if (!r)
+			memset(uq_mgr->proc_ctx_obj.cpu_ptr, 0, AMDGPU_USERQ_PROC_CTX_SZ);
+	}
+
+	mutex_unlock(&uq_mgr->proc_ctx_lock);
+
+	return r;
+}
+
 static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 				struct drm_amdgpu_userq_in *args_in)
 {
@@ -429,7 +450,14 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 		goto free_mqd;
 	}
 
-	/* Create BO for FW operations */
+	/* Create per-process MES process context BO */
+	r = mes_userq_create_proc_ctx_space(uq_mgr);
+	if (r) {
+		DRM_ERROR("Failed to allocate MES process context space bo, error: %d\n", r);
+		goto free_mqd;
+	}
+
+	/* Create BO of a gang for FW operations */
 	r = mes_userq_create_ctx_space(uq_mgr, queue, mqd_user);
 	if (r) {
 		DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
@@ -492,7 +520,7 @@ static int mes_userq_preempt(struct amdgpu_usermode_queue *queue)
 	*fence_ptr = 0;
 
 	memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
-	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue_input.gang_context_addr = ctx->gpu_addr;
 	queue_input.suspend_fence_addr = fence_gpu_addr;
 	queue_input.suspend_fence_value = 1;
 	amdgpu_mes_lock(&adev->mes);
@@ -529,7 +557,7 @@ static int mes_userq_restore(struct amdgpu_usermode_queue *queue)
 		return 0;
 
 	memset(&queue_input, 0x0, sizeof(struct mes_resume_gang_input));
-	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue_input.gang_context_addr = ctx->gpu_addr;
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->resume_gang(&adev->mes, &queue_input);
-- 
2.54.0

