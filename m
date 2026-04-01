Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050C6D3516D
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 10:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DF1010E2DE;
	Wed,  1 Apr 2026 10:05:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CnmQ4djA";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011068.outbound.protection.outlook.com
 [40.93.194.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E83D110E1C1
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 10:05:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZzQo5nFs8G+TiHN+Gsx8dGocMuk1sFxi+EecKrwhXu67M6AkxqhNnAb+zlseFVz7Qlx1yiYtTihFAd2CXVxy0Z+m11Z6NXgAM+q28rSAlrfGN0nySdhfHLEcANN4lb0TfZ03QFs+Nx078nPyn1gAAmuOTMAAMwzfQyxui1OWlUBWkS0nfB6Acx+PaScHrJHrQFvHzx9g6yOL+4fwIGn+7iVXeBXtWDJ52/wJUehXzcO2YkIyIDchk8PeUcrr/XN68LZ/sGfbLlABi3KK5uVHw1ZiB90H41jHpxlWZGnfLmqu7U1+GZvDfCHCYixp4surJjeCPjfibaWVjL5wi4hBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/dAiIHUK9vheHxCKysGScNsSZkATeU/Np20OSEap8o=;
 b=t8noKtgNSUlQQ+jDEoBgKj1PgL6wRKUQB8L17Hjj8JY82U4yMnlgi4BNHHa9WELHZbvuxFybhYbdMRoYTD3qMvWXNROXQ7iF1pWx4RvJgbuLKhdUNnZlIFvJDD/6WRkjkWPJbaR/JW+IK6qmJYaoI24hMo5FZ+LPKj5Hv1jaVls2gSGb43kBesm0rCc2J2Tndpgfm8rZZDo+0j2blp02YbulnrFLWgExSTNunTxCr4g5VotI2dOO/di9HzyxDkkn4Cv/nub43sIGy71+6OhN/iN2FYrYYKcpbQgb7elOG++SgoV25FcRFPSJ4Ym4EnAOQIX9JK3nFwyGxPaDzZdX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/dAiIHUK9vheHxCKysGScNsSZkATeU/Np20OSEap8o=;
 b=CnmQ4djAqmBFqzGJ3n1O3FJbHsBmngMf0MA8/pZWFQ5V9Yv0i06IxCEr9aEeOFW26QIJI7hBYAGaHI0QPYawJ4QTWmS5Lz3cFbkHKmQAchyQmewxsPfrsj43+RgdQHzj8FnZ29FjGLTgb03RfEdQYZPjtFE3BQSssl9jtBXGXJo=
Received: from PH8PR21CA0017.namprd21.prod.outlook.com (2603:10b6:510:2ce::17)
 by MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 10:05:20 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::81) by PH8PR21CA0017.outlook.office365.com
 (2603:10b6:510:2ce::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.7 via Frontend Transport; Wed, 1
 Apr 2026 10:05:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 10:05:19 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 05:05:17 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu: rework userq fence driver alloc/destroy
Date: Wed, 1 Apr 2026 18:05:07 +0800
Message-ID: <20260401100508.3397962-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 4913cdbf-49b0-4d51-be16-08de8fd62e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Kenz0fvvF/E1M7Glzg28/oEzpDbpnKixRZi78RM7DzbaaDnTZwNU/G1mCrkclJJVur59Ot04AAqio/kZLBApqdTI6Obr2hNYy9eOkgN4DEy39oy5/QoqkCfGjsFUUig2IjY/IVdzNIR90wt/2FJepwI8njTrj0U6qozoiGOQNpwfF6IScZLEDKom19Hy2FFx1y+YY7qDPpvPnrxAORaBGzwQf3E+SPQIyDl62lHKZDao4Dg4MDannwLEvt/cTfw9Cvl1enKrpAG981/UQQcCJHrtg2btRu4fZ0axNHrJ5gxico/J0qY5DrqEQ6LFJN1KjEWcFzebu1AaBxLG3xEV17qQIiojspI2RDkI/FxlC8Ux++a9xjvmOFDwQrGSiRnJlWeK4cHYBjXSmmPGIit1YuIzGUxQeWEatdHA4q0fBrBt4RARIKb9qMYZGh+Vi2ElfSNAcecwxQPva4f8L3JtWeYbiCJ0B8q0UmwjZDcu/8hwUbXlMs2XQNuN5KFerIocadBSoHqVOUiilsz15fZmnDeFLukXwErZQPwshdSubHD8TRHn2v4+uP4sUNzyDPcgUWekyllSQibFYApQdyI8WwQGsEGSEHZ4Wcyy95dI5Fio9F1qaZyqi0izSkYPfLGyeEhM1J+XW7u8vTNh1GzDXQZIjYNwOsp+rNo7YDokQxtZQ7i7vr+dTj5kJtstJOSmeWvYBMfBkVv8G9osC1NiWH3aZWppx3MElX9S8b08dkGxzWHbJicSTcGvakgiJVGLSaFk8SlUazIdRp4Slzvd4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uWsY0ScCpwyBQT2RARrftj34z8bRQLQCwCmzt5H7Dig/OzfhSp4ivNR5sWUxmhvzpGafsEGy8nV0V0r1zJN4n915l9selqeFoTrevIjgl61tstlYjNveTF8L0tIwtBXh1LM42OthL8r9Wq3thy32rdKEr42RDqnLhlivRySDIlc/Yiedc8E3aNBtC0KsVt8iW02Tp5N66hgL8pY9xC1Yv+8afEOBVl4721mgnaa6pg1n9pEhMEJlV7savr6YZgN/DEetpLlxMhMRrnWQ8P6eQPEzThii0d+CVjB2OMdgiMJspxqMIrSyEVycRot+XNs8UOVyXQTP6NqJnpVEqhAx5UxvCXcYtkcozoeeX8CpP0Kn73rOPpDs8cFQ0Paj0cM73uQpxljU8mp5O9hari5wisaXhNmICxV8RwJhPhWjmC1W++kNYrrMbLgWY6Sslrtc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:05:19.7157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4913cdbf-49b0-4d51-be16-08de8fd62e6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312
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

The correct fix is to tie the global xa entry lifetime to the
queue lifetime: insert in amdgpu_userq_create() and erase in
amdgpu_userq_cleanup(), both at the well-defined doorbell_index key,
making the operation O(1) and resolve the fence driver UAF problem
by binding the userq driver fence to per queue.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>

v2: clean up the local variables initialization. (Christian)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  5 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 +---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 20 +------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c        | 11 +++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        | 10 +++++-----
 8 files changed, 28 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 49e7881750fa..8bc591deb546 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1045,11 +1045,6 @@ struct amdgpu_device {
 	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
 	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
 
-	/* xarray used to retrieve the user queue fence driver reference
-	 * in the EOP interrupt handler to signal the particular user
-	 * queue fence.
-	 */
-	struct xarray			userq_xa;
 	/**
 	 * @userq_doorbell_xa: Global user queue map (doorbell index → queue)
 	 * Key: doorbell_index (unique global identifier for the queue)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0c0489395edf..a7b519f670a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3757,15 +3757,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	spin_lock_init(&adev->virt.rlcg_reg_lock);
 	spin_lock_init(&adev->wb.lock);
 
-	xa_init_flags(&adev->userq_xa, XA_FLAGS_LOCK_IRQ);
-
 	INIT_LIST_HEAD(&adev->reset_list);
 
 	INIT_LIST_HEAD(&adev->ras_list);
 
 	INIT_LIST_HEAD(&adev->pm.od_kobj_list);
 
-	xa_init(&adev->userq_doorbell_xa);
+	xa_init_flags(&adev->userq_doorbell_xa, XA_FLAGS_LOCK_IRQ);
 
 	INIT_DELAYED_WORK(&adev->delayed_init_work,
 			  amdgpu_device_delayed_init_work_handler);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 6b33c2428b2d..87560c1251d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -81,7 +81,6 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq)
 {
 	struct amdgpu_userq_fence_driver *fence_drv;
-	unsigned long flags;
 	int r;
 
 	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
@@ -104,19 +103,10 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	fence_drv->context = dma_fence_context_alloc(1);
 	get_task_comm(fence_drv->timeline_name, current);
 
-	xa_lock_irqsave(&adev->userq_xa, flags);
-	r = xa_err(__xa_store(&adev->userq_xa, userq->doorbell_index,
-			      fence_drv, GFP_KERNEL));
-	xa_unlock_irqrestore(&adev->userq_xa, flags);
-	if (r)
-		goto free_seq64;
-
 	userq->fence_drv = fence_drv;
 
 	return 0;
 
-free_seq64:
-	amdgpu_seq64_free(adev, fence_drv->va);
 free_fence_drv:
 	kfree(fence_drv);
 
@@ -187,11 +177,9 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 	struct amdgpu_userq_fence_driver *fence_drv = container_of(ref,
 					 struct amdgpu_userq_fence_driver,
 					 refcount);
-	struct amdgpu_userq_fence_driver *xa_fence_drv;
 	struct amdgpu_device *adev = fence_drv->adev;
 	struct amdgpu_userq_fence *fence, *tmp;
-	struct xarray *xa = &adev->userq_xa;
-	unsigned long index, flags;
+	unsigned long flags;
 	struct dma_fence *f;
 
 	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
@@ -208,12 +196,6 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 	}
 	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 
-	xa_lock_irqsave(xa, flags);
-	xa_for_each(xa, index, xa_fence_drv)
-		if (xa_fence_drv == fence_drv)
-			__xa_erase(xa, index);
-	xa_unlock_irqrestore(xa, flags);
-
 	/* Free seq64 memory */
 	amdgpu_seq64_free(adev, fence_drv->va);
 	kfree(fence_drv);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 78d1f3eb522e..e97f487c419c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6488,14 +6488,14 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 	DRM_DEBUG("IH: CP EOP\n");
 
 	if (adev->enable_mes && doorbell_offset) {
-		struct amdgpu_userq_fence_driver *fence_drv = NULL;
-		struct xarray *xa = &adev->userq_xa;
+		struct amdgpu_usermode_queue *queue;
+		struct xarray *xa = &adev->userq_doorbell_xa;
 		unsigned long flags;
 
 		xa_lock_irqsave(xa, flags);
-		fence_drv = xa_load(xa, doorbell_offset);
-		if (fence_drv)
-			amdgpu_userq_fence_driver_process(fence_drv);
+		queue = xa_load(xa, doorbell_offset);
+		if (queue)
+			amdgpu_userq_fence_driver_process(queue->fence_drv);
 		xa_unlock_irqrestore(xa, flags);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index a418ae609c36..65c33823a688 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4854,14 +4854,14 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device *adev,
 	DRM_DEBUG("IH: CP EOP\n");
 
 	if (adev->enable_mes && doorbell_offset) {
-		struct amdgpu_userq_fence_driver *fence_drv = NULL;
-		struct xarray *xa = &adev->userq_xa;
+		struct xarray *xa = &adev->userq_doorbell_xa;
+		struct amdgpu_usermode_queue *queue;
 		unsigned long flags;
 
 		xa_lock_irqsave(xa, flags);
-		fence_drv = xa_load(xa, doorbell_offset);
-		if (fence_drv)
-			amdgpu_userq_fence_driver_process(fence_drv);
+		queue = xa_load(xa, doorbell_offset);
+		if (queue)
+			amdgpu_userq_fence_driver_process(queue->fence_drv);
 		xa_unlock_irqrestore(xa, flags);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index db49582a211f..68fd3c04134d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -3643,14 +3643,15 @@ static int gfx_v12_1_eop_irq(struct amdgpu_device *adev,
 	DRM_DEBUG("IH: CP EOP\n");
 
 	if (adev->enable_mes && doorbell_offset) {
-		struct amdgpu_userq_fence_driver *fence_drv = NULL;
-		struct xarray *xa = &adev->userq_xa;
+		struct xarray *xa = &adev->userq_doorbell_xa;
+		struct amdgpu_usermode_queue *queue;
 		unsigned long flags;
 
 		xa_lock_irqsave(xa, flags);
-		fence_drv = xa_load(xa, doorbell_offset);
-		if (fence_drv)
-			amdgpu_userq_fence_driver_process(fence_drv);
+		queue = xa_load(xa, doorbell_offset);
+		if (queue)
+			amdgpu_userq_fence_driver_process(queue->fence_drv);
+
 		xa_unlock_irqrestore(xa, flags);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index b005672f2f96..0f530bb8a9a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1662,16 +1662,16 @@ static int sdma_v6_0_process_fence_irq(struct amdgpu_device *adev,
 	u32 doorbell_offset = entry->src_data[0];
 
 	if (adev->enable_mes && doorbell_offset) {
-		struct amdgpu_userq_fence_driver *fence_drv = NULL;
-		struct xarray *xa = &adev->userq_xa;
+		struct amdgpu_usermode_queue *queue;
+		struct xarray *xa = &adev->userq_doorbell_xa;
 		unsigned long flags;
 
 		doorbell_offset >>= SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
 
 		xa_lock_irqsave(xa, flags);
-		fence_drv = xa_load(xa, doorbell_offset);
-		if (fence_drv)
-			amdgpu_userq_fence_driver_process(fence_drv);
+		queue = xa_load(xa, doorbell_offset);
+		if (queue)
+			amdgpu_userq_fence_driver_process(queue->fence_drv);
 		xa_unlock_irqrestore(xa, flags);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 5679a94d0815..9ed817b69a3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1594,16 +1594,16 @@ static int sdma_v7_0_process_fence_irq(struct amdgpu_device *adev,
 	u32 doorbell_offset = entry->src_data[0];
 
 	if (adev->enable_mes && doorbell_offset) {
-		struct amdgpu_userq_fence_driver *fence_drv = NULL;
-		struct xarray *xa = &adev->userq_xa;
+		struct xarray *xa = &adev->userq_doorbell_xa;
+		struct amdgpu_usermode_queue *queue;
 		unsigned long flags;
 
 		doorbell_offset >>= SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
 
 		xa_lock_irqsave(xa, flags);
-		fence_drv = xa_load(xa, doorbell_offset);
-		if (fence_drv)
-			amdgpu_userq_fence_driver_process(fence_drv);
+		queue = xa_load(xa, doorbell_offset);
+		if (queue)
+			amdgpu_userq_fence_driver_process(queue->fence_drv);
 		xa_unlock_irqrestore(xa, flags);
 	}
 
-- 
2.34.1

