Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DDDD3516C
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 10:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6874810E1C1;
	Wed,  1 Apr 2026 10:05:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GZOIBvrn";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013014.outbound.protection.outlook.com
 [40.93.196.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 408BA10E1C1
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 10:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGB07CilkKtvaQJhyuHQd2CUQSyEjOb1JhQu1wnRnXzosO1+oIVAs2AKw/2ZY7j+qnAkrGMsdh9f1OdoGYOraLZiDp6OChvf/Ukf8im/U9tKQAmx82ElK+BCL9bi5Bxc4Bqzd/NR77EC6mmC5i68c+Vhcu5lVHHg57HbIjD+jzFZh4vHClHyB3rb78IhPbp2MocsOlR2YYmQv32Qz8BdRJo+MvAgAEpgvh2dTVZ31nYLTEvm52SELwW4oyU6pZ6E3K0oFZDVUwsdSlQCFarAr+vxj7SVuTLX3czew7FskuQsRCrkRw+iO1IGLD7sgoyRSXz5XlLJnyZJv31JysNI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0oC6+UI6hu8WbZAhxANwJ5N9SgeCZwx/O+BPjssm+E=;
 b=w3mjTZCoE/WOHqOVJ1xPuF+K4tlrDBNyFLbfUPe/GhDNuBMw83B2IafzXVaf2JVzFmQ6HvxcX0w1CcIfDyoiV3N3vGXQxhdnWjh9flH1oSn4LPVZMnMjLSUt/mywCEoiSVj/MDL9UiwtFVNYniwPICQRoMBpTYViTcz1Bsw1oCX1RGQhBmp4JgES/55FAwthkx5iWttNIQuGl7k1ofxmfT1yANEVOM2QyD/UewqHcRZxM40+sQnsg3pQGddA+jbJUG+5034UuU1tdL6oqgpROqqtAs3njbwm/zmPuXtJvxcF035K48vgQ0jf372lut3vi20wSOv5Nk4WpjzUElYN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0oC6+UI6hu8WbZAhxANwJ5N9SgeCZwx/O+BPjssm+E=;
 b=GZOIBvrnusLTWaXUwD+PuPBfYnMmVQlsFI+XNwiNyZF5bv9miWnjywsg33SMbsbZnyB5raa0xC90QVJpvsPzOUkjkwOaqh0axxv7HOk8/X7eO2GBwydcTPrKgDX9bsOnV09LH5zZ0KcuMDOOGqFlbqhtOcrgDGFsBJAlyWEqyrM=
Received: from PH8PR21CA0021.namprd21.prod.outlook.com (2603:10b6:510:2ce::15)
 by CH1PPF189669351.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::608) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Wed, 1 Apr
 2026 10:05:21 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::48) by PH8PR21CA0021.outlook.office365.com
 (2603:10b6:510:2ce::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.8 via Frontend Transport; Wed, 1
 Apr 2026 10:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 10:05:20 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 05:05:19 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: make userq fence_drv drop explicit in
 queue destroy
Date: Wed, 1 Apr 2026 18:05:08 +0800
Message-ID: <20260401100508.3397962-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401100508.3397962-1-Prike.Liang@amd.com>
References: <20260401100508.3397962-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CH1PPF189669351:EE_
X-MS-Office365-Filtering-Correlation-Id: e8bf1164-7d2f-42d1-8b83-08de8fd62f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: UZDM4Wtd7tdQP5fKSYO4frMzzOdcbONIUBt2XFeLp2gkDdS9LE+v510/WkkeK+3LhAgMzmWw6Q3F0RLZcD9F0RUYljF9SEpKfj1mH2rDWKHfgw3dSyH58PSYT91SUTd9dOD70wr9HidCvcnMaCKRv1Ot/6ksgidNNkbAnJfLoj4gkjdPaaCYsU+ijv469PtgBQL93mXnbgNJYhDRsL5b/oXwXD9Bm24VRjUgcJoawF6QSaL+6CH7X8zr+gZtjTZvRW6gMDQeLOSg6hhhGRn0NWpI3ZifZaHVVNRhp+CCTSltVncWVyp308yOrzHLx6RhKM+bmbaVxn7D2iBLFbVmPyHWD2F2ismaTmwQRNyfzBrnMsFk/CDHnwKoMmZf0fFqI99eqYr7JoLHzS4JraaoJ6BIV608z+rKtCZbq/HMLnJ0yVymNc0xnMgFXDpT0HieW1Q/kv+nBBtX7RNeh3PEH1bqgzPCT5BFx7Ea5C3YXntKpbU9I8pbLJIjbZUm8kYaP1p0e8qxzOInPwR2UQuOu+bWyZhcffLHZyEv5x33Ei+s8PN4F3nRo9a+ob6vdGZDzACcijFp8M+i8H0B1S2J0e/JdRtbI48e4qkaozZCyR9Fs8ZReOB3LIiyz2rQnC2BnfQBVt9oO+6WT0H6giMPzA+Sfs0uIwWNdv/Rrp4UfhYCVUx7f+jFZJxXIJPdCT2kfC3wax2ORVBmoIRMdq3w19zxWELgJV9ubYJndpXlyZfFKgSxJrFgApPuq/2FVFqMaj8YX/UkQ3m45uxaWUhJVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0b4J2Y7VuVz5N7KSa/03AN5sEYlScvy6KS9QhPOhORF5Dx7yN+1tgleI6hSXOc2bE9y391wb+olqF7BhB0yv5svmysTCiZqmJhvquryfh2aCKqQiBw925cbmGJ2Y1uPa1scpC19+8vKzUucZ4JNt4kvOLqWr3xVPZx3bZZnMJisYh3DYpI6EjDGFtl9pyIIlcl+P3Y9SHtNkjdIEr8C4Zg6IHHJ+AcL8b3Bqzvdw/bmJAt9jDor8HknTkHgtVsVeASSQSD6ALc3XUeANsl5VwD94PQq9wsIlCV04Jv3Xe8AqMZdA7CrHs/iLmqrYqidiqJOIB0Aj9EyJejDCRZ5Bantiduv+ZqN6aNzdc3GGZugW/vS5aYwp2DoOFbmKUcOn6OPNO5RBLRILjqELI/nxC2Mx0Z7eJcqO9f7dxfk0s0z8EYjkbbTLkz3nku7dCT1e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:05:20.9131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bf1164-7d2f-42d1-8b83-08de8fd62f26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF189669351
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

amdgpu_userq_fence_driver_free() is now responsible only for releasing
per-queue ancillary state (last_fence, fence_drv_xa) and no longer
touches the ownership reference, making each function's contract clear.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>

v2: Get the userq fence driver from amdgpu_userq_fence_driver_alloc()
    directly and dropping the userq fence driver reference after removing
    userq_doorbell_xa entry.(Christian)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h |  2 +-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index c4841df80bf8..4f9f2e266562 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -458,9 +458,10 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
 	/* Drop the userq reference. */
 	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
 	uq_funcs->mqd_destroy(queue);
-	amdgpu_userq_fence_driver_free(queue);
 	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
 	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
+	amdgpu_userq_fence_driver_free(queue);
+	queue->fence_drv = NULL;
 	queue->userq_mgr = NULL;
 	list_del(&queue->userq_va_list);
 	kfree(queue);
@@ -799,7 +800,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 	queue->doorbell_index = index;
 	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
-	r = amdgpu_userq_fence_driver_alloc(adev, queue);
+	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
 		goto free_queue;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 87560c1251d8..3be80a82788a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -78,11 +78,15 @@ amdgpu_userq_fence_write(struct amdgpu_userq_fence_driver *fence_drv,
 }
 
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
-				    struct amdgpu_usermode_queue *userq)
+				    struct amdgpu_userq_fence_driver **fence_drv_req)
 {
 	struct amdgpu_userq_fence_driver *fence_drv;
 	int r;
 
+	if (!fence_drv_req)
+		return -EINVAL;
+	*fence_drv_req = NULL;
+
 	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
 	if (!fence_drv)
 		return -ENOMEM;
@@ -103,7 +107,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	fence_drv->context = dma_fence_context_alloc(1);
 	get_task_comm(fence_drv->timeline_name, current);
 
-	userq->fence_drv = fence_drv;
+	*fence_drv_req = fence_drv;
 
 	return 0;
 
@@ -134,10 +138,10 @@ void
 amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
 {
 	dma_fence_put(userq->last_fence);
-
+	userq->last_fence = NULL;
 	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
 	xa_destroy(&userq->fence_drv_xa);
-	/* Drop the fence_drv reference held by user queue */
+	/* Drop the queue's ownership reference to fence_drv explicitly */
 	amdgpu_userq_fence_driver_put(userq->fence_drv);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index d76add2afc77..d56246ad8c26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -64,7 +64,7 @@ void amdgpu_userq_fence_slab_fini(void);
 void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv);
 void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
-				    struct amdgpu_usermode_queue *userq);
+				    struct amdgpu_userq_fence_driver **fence_drv_req);
 void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
 void amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq);
-- 
2.34.1

