Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F46CD5BBF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 08:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2376310E099;
	Mon, 25 May 2026 08:24:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qesBvsU/";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012038.outbound.protection.outlook.com [52.101.53.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8206610E5EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 08:24:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJPDb7RWnmSmLNnT7Ovl+QvrtLTgmjT9aJLJ/3/Hlnp5r7TZtUVsmO+YV1l55EW6ShTTTLmpmLNKLPaEAMYQX7HXKOSqSHjfPrwTafRb2cRdhD96HJxkff4Fwyfq7Aw1hsGldnx70K+sWnfEMZnNk2yUBqPZNdXmlq6Jv0tp20cUsOGY1vPBAqJEDUp3bJ656oFx113uI0Z4NH38FEqj3OA12TYhzkZy4eAk06p54IN59ehoA1/ZvQAYmgzn4Sb0r30LHQ5lKPdrjpVSoPQuF8wmO3nqcB+raImEDxVmnzMGE4O7VYZNhX+YmdgPbSV226jN6znxpzXGjgPD1mOxCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9CGuqmxXS28QVGuuiwCnLQSxK5hBmny8MEuhQtBFQ8=;
 b=chymNSoV1ZEKZ3Dd7/8OZ7ceHGqukSLOUIeD/RUrIjDem00+zoEadbmec4YKRIGoZX3yExO679i7SPs6H8zHvenRMK9H8fj/gIxejG7UrMOGDXIn1HQTwy2daKCkZrhZ57q7dIs+lpQ4t7bs9pSJKejCi6VR+mAPSKjYa8sJXqvOR7KbLYNfETK7LLKmxpCOlKqUG5G7JJfEQgRLzntnfw9p7rPA7W+V88tYF4k6BPXUlwxBVnbTCKITdYdiIBFh9brwvou8hTy41CfK2PWu657iiLkoRuCRjU9klEwUO+EfJa036AMkjLkOZaLe4M58tdBMddWsfvWqp85iIe1efg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9CGuqmxXS28QVGuuiwCnLQSxK5hBmny8MEuhQtBFQ8=;
 b=qesBvsU/Ul0/5pyV215CVz/2RSs3KbJ+YUd9aCsk8uOKQ+EXzlCqCV1vFF/4Jr7fpvguaTS7y4lhgeQKl6bwycbuyKysnV36iRmvI80sdGOtRvr0UbSr6p5Us5VGLBOIVWSWwBsVoTeGJLFbyJAdUVTnMqzinZZAAuyuX44pxfg=
Received: from DM6PR02CA0144.namprd02.prod.outlook.com (2603:10b6:5:332::11)
 by CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 08:24:21 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::62) by DM6PR02CA0144.outlook.office365.com
 (2603:10b6:5:332::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Mon, 25
 May 2026 08:24:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 08:24:21 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 03:24:19 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
CC: <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH] drm/amdgpu: implement per-process MES context
Date: Mon, 25 May 2026 16:23:59 +0800
Message-ID: <20260525082359.5510-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f33bed-05a3-402e-a37a-08deba3705ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: DdZsKUD5huhtQilntt0va59yZ9j1WJZlo2sXaNc4+W8fQu59cZfRJwSNkAgh2nlD48jior8tpeTtgNdZlVAP1J4BVeFI/80s15J4ggu580/XA8BXnzEFTkuBheIDEXwXb/NDdNMkEYjeCAgKL9ttwGYdIJ9KTw5Dph3zb2eoku3bCw2/Uk3QahO8CFY5wvdL/qyW00/VAvm3LUCSNjm3o7kcVljSBWbje6hGRh/l4/EARIn1kFKTDUjS+RFTWdLV02Klm2Pf7Eua9wBHM7wNGJuswonxPiHoscpJm2mNDFlbBFH9idPNsM24743BzVBiyh4rgM8jfdZZkyw259iKQHquLdpSP5+nBRGErCINVMVT+HTriwsEjSg9xjYhV6/0SULBNsfx8j8EMqVNmuA2RqVHFl+Om0FOuo+tBfVEnF85kStB6fUF2M3INN11k1MS8S4IUxh7Jh5HXgyD6yZWlCx52nYILoF15bSpbgDiCSrIzw7eEPqepWydMC6UOaqZ6vwQHxxKY/WhwEMrXm3+IXXplMjTjAhdKb8ARoOF18zdq1z4nRS7xRz3FJgrIvG1o8vZdyvmlLsXaNzGvIBLcKXZ/xBbg2xz6NYpWAfiVq++yJnvzhadkHlyqRuShdeT+fJNXkkNQRLHSJp6rOiszrDGqy2VzUSkjSn91octgt3X+g9htul8LUakZL7nI9uMFMXDI3wp62g5gzeWgB4GQ9eFkZUYpHXjTy+77qmCSdA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IFVmws/wqDoWPzH6xZOH/tE8ylDNfJ3ulcI+YR+hhB5f8u+KZ3ld1ATPNeln1ytrK3ovegX4sTF0/g9H35lI+L6sl6retvztohza3EVUFDb+xbne7MEtSlw8BY3vrGl83i2sWNB2BW+BCJcugZfr/O5spNsIueROOBcPhuzJU8msA+eyHd2TxZXsLzqQjAvQaEf62obRS/l9B9nO/yAN4UKOLL4vICrYicQME9Uii/5RPy/4rAwwosj4sns0r4My/mb1VfC5ydyUD2wm/uN+Bf17KhsfEnvk79UYe3sWSS6OIReRbxYmuN3YFoU9ggAZMQwqX6JHciRQh1qfq7QMVTL8GYpHNRaO8E5cM8vQ2pIYnUrBhvS5nfX+O+GMwRknfGE8MrROuxhos5gujElnYb7rh7qZKE19DpLFDYxwbi18ms5eV0P1AnQVCD6h+Onq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 08:24:21.3543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f33bed-05a3-402e-a37a-08deba3705ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 48 ++++++++++++++++------
 3 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 38e310a8694d..0c4d6f80616e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1225,6 +1225,11 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 	 */
 	cancel_work_sync(&userq_mgr->reset_work);
 
+	if (userq_mgr->proc_ctx_obj.obj)
+		amdgpu_bo_free_kernel(&userq_mgr->proc_ctx_obj.obj,
+				      &userq_mgr->proc_ctx_obj.gpu_addr,
+				      &userq_mgr->proc_ctx_obj.cpu_ptr);
+
 	mutex_destroy(&userq_mgr->userq_mutex);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 28cfc6682333..fe85234e58b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -127,6 +127,7 @@ struct amdgpu_userq_mgr {
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
+	struct amdgpu_userq_obj		proc_ctx_obj;
 
 	/**
 	 * @reset_work:
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index e9189f07c6dc..3022025bc2ec 100644
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
@@ -257,6 +253,27 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 	return r;
 }
 
+static int mes_userq_create_proc_ctx_space(struct amdgpu_userq_mgr *uq_mgr)
+{
+	int r = 0;
+
+	mutex_lock(&uq_mgr->userq_mutex);
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
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return r;
+}
+
 static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 				struct drm_amdgpu_userq_in *args_in)
 {
@@ -429,7 +446,14 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
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
@@ -492,7 +516,7 @@ static int mes_userq_preempt(struct amdgpu_usermode_queue *queue)
 	*fence_ptr = 0;
 
 	memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
-	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue_input.gang_context_addr = ctx->gpu_addr;
 	queue_input.suspend_fence_addr = fence_gpu_addr;
 	queue_input.suspend_fence_value = 1;
 	amdgpu_mes_lock(&adev->mes);
@@ -529,7 +553,7 @@ static int mes_userq_restore(struct amdgpu_usermode_queue *queue)
 		return 0;
 
 	memset(&queue_input, 0x0, sizeof(struct mes_resume_gang_input));
-	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue_input.gang_context_addr = ctx->gpu_addr;
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->resume_gang(&adev->mes, &queue_input);
-- 
2.54.0

