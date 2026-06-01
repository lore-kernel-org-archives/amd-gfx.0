Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58210CD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 06:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9AF4112E4C;
	Mon,  1 Jun 2026 06:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J5VX/CHc";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 774C9112E4C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 06:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjOswtm83mBlqHJUiIZuiCAIztTv7QScsy0g3vt4YrfswW9jK/CYHk2k0pzbkmMoUyzdQLvCuZSevG3WGgpgkMEhIiZKDmtVIerbmgOoNFImho0piwDlHwzyL66aSWNuZtjm5wtIpOmC8Y+wZ7TCHjm4Rfrum1FmjvvdJ690LKHlXivf12xeUNWqkMNGJ8wg25r0VGPyqUQOGjHf5ULF0IoQYyjH9xPTZ1vm38kMXoX0ObJr5FBrhtqb+x37+Hvio3UFdpEs0CGEL3e+1WZKEu3+vytH65qXyHxjiBptBSKW40GPUen2a+Fpwy0lI38GCW3F8ofW4s9jSI3pi+6DJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xW0HIN4pn/M81PdLtWBBTJu6z/9rQ0QaWZilFWWIMSI=;
 b=b0O8evYcOi35jPNzPhPTLRZjEuVy17NV5o/pdpUk3IP/k0zr92KYkTiBVKCM5t1KV0unE+OJHIeBcADyl8tHcixhJsws9nQSG2NOkeLKJcgaYmHqKTt1vvfSpMn4sm1Q3NtrxpTd2dGO3RNvtCWx8VHNTJjMWyuJRcpDQUL+ZJQLMwbk8QPBvr/3oK+LoT9wWG1L1NNAtFKnpNTbawVoVNmW02auCr1pAXRa+Zkr1obvQYf6p2RhkLIj5FvGWCicOBYZI4hN0rkjmicucZA3RknngvOcu7wifd8OMNg64C19OIaL38rHe4up0c8b27ngeTdrXaGDm192oNP6ioiq7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xW0HIN4pn/M81PdLtWBBTJu6z/9rQ0QaWZilFWWIMSI=;
 b=J5VX/CHcFg/3xQO+trI7SSvDifWPjI/zR3ShFL6oWZJsglRPsDDGAL6HI/TAECY7rEQUq2F7iv7Bv7xtf+pU3kyHDYFgbZvHk3QmwJpZ5beUdK1GT2+5QemsFYlVlBRMVlDAxxaVSuBypqr2aYSsm3orWJJKvJeP95rPcm9CtjM=
Received: from DS7PR06CA0054.namprd06.prod.outlook.com (2603:10b6:8:54::34) by
 PH7PR12MB8039.namprd12.prod.outlook.com (2603:10b6:510:26a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 06:42:38 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:8:54:cafe::51) by DS7PR06CA0054.outlook.office365.com
 (2603:10b6:8:54::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 06:42:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 06:42:37 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 01:42:36 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <Ray.Huang@amd.com>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V3] drm/amdgpu: implement per-process MES context
Date: Mon, 1 Jun 2026 14:41:12 +0800
Message-ID: <20260601064112.172432-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|PH7PR12MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a437457-5949-46ca-aa28-08debfa8f8ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 3a2VojmJqZgwl5EqlIpZzbrDGeGW2uHu84yFQEL4Xxp0I1RldphsFKPfSsBATjoFKfZCEkO6S128/Hxf2DRvW7lD1x/Tku/O3uD2tmUKBgYTvX6+3FfQn8HyqUBkaxZyGPgDpXhiluQKUSOzlcSoOO6cDTa82F56Fw5RgsEblzFeE89OPCAer3vV2ZhxO/T6MrBEgiCOouY2iEpOkmFD+fVMbf73FOJnEyHQaiVXL6pHXoOURMz/vqRixdQ4DdxFmsWapF6bBHz6vkRRpPEmBP0UzjsefO8s2i0+GwDky7HnZ8K/1WaeQK7LQxl+NWACVvK922FxTC5bB1dJWUS7xstHD5/5WHI4aKJkKvM03cQe2X+eWdwcWm17Jhyhf7DIQaViRjMhcPFxpV6YnmI1C1gdXGhCO4lnt/R/Psnb1C8fxzzLp55o8a+92zuXkedoRqG51zM8XGuJVLUuf8VWVX5FN8i4YTl/ncetOv8E6+KYUowgxjuMj2BeQMrnDhJNpF2+cSliC2LMuKhMeWb4JBeV1ZGaklgQgMh6Pdvwih9SfQ8mKtg2ZEMytH4kQ7YxDWOQS9SMhZGSUHsmQcQZrw6lgVGDAe1NZZXi3yPn+qcsQ9Oeg6Xj4CNrRtMU74+gkOHh8Ev9VXDG1nEG1RKmKWlApoQWZTf4q8RD8KMro6YUHr1psEaPLVf1E8LPx6xwHHMcgxYZb4QGqX4Ie0OqriqUjrEHmBwh5LHa/iLFtbI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jt1htpS7cTotXe5njvzB2jWX2PombmZOrdDSmFnj6Sa4i1be/xYoCTJ6Vfo4niz5efTA/dwJFSUauUIjgYZenQv3x9mZyxTrobUiWEULwhX2m7/ddLKyg+h9qS1I4ImAyDeKr2w/6sirAuug88E6vK0ioil+XuPV1qve7H85sJN8PlI3cmCGfSDloy7pYZwD0g2j5kAiO7GW2cx7SPsVGSgA4wGKru4sYHmIAVmWNrLHf9nZ2a84bPiU2J7alrrQc7pc4pvlTITCYUKi0bGpjA/l791o976ff5RXTfeL+0jDP1fUyL8FjLryTfE1zxnm23M/yDIGRH4uOXvOZJjd+P0MNcCoQmYbmqz+DJsCUGi9zKwXn+oHsA+IJs8s43rhRP5y+Y8453wx9YmDONI7VTe+ijT4QqcYhzyeqL3M4F1qTPctZdpuB0MX2Nt1yXhw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 06:42:37.9801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a437457-5949-46ca-aa28-08debfa8f8ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8039
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
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 51 +++++++++++++++++-----
 3 files changed, 47 insertions(+), 12 deletions(-)

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
index e9189f07c6dc..6c8a44cee34b 100644
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
@@ -257,6 +253,30 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 	return r;
 }
 
+static int mes_userq_create_proc_ctx_space(struct amdgpu_userq_mgr *uq_mgr)
+{
+	int r = 0;
+
+	mutex_lock(&uq_mgr->proc_ctx_lock);
+	/* This check is a necessary because amdgpu_bo_create_kernel()
+	 * calls helpers like amdgpu_bo_pin() and memset() unconditionally
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
@@ -429,7 +449,14 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
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
@@ -492,7 +519,7 @@ static int mes_userq_preempt(struct amdgpu_usermode_queue *queue)
 	*fence_ptr = 0;
 
 	memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
-	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue_input.gang_context_addr = ctx->gpu_addr;
 	queue_input.suspend_fence_addr = fence_gpu_addr;
 	queue_input.suspend_fence_value = 1;
 	amdgpu_mes_lock(&adev->mes);
@@ -529,7 +556,7 @@ static int mes_userq_restore(struct amdgpu_usermode_queue *queue)
 		return 0;
 
 	memset(&queue_input, 0x0, sizeof(struct mes_resume_gang_input));
-	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue_input.gang_context_addr = ctx->gpu_addr;
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->resume_gang(&adev->mes, &queue_input);
-- 
2.54.0

