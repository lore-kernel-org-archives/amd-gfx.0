Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E04D58E49
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 03:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE41210E349;
	Mon,  2 Mar 2026 03:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FCxQPqHt";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BF2610E348
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 03:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwqy5R4+LfGXV0LSlGjLlPOeZlQaCtM9OrnbL+Z5B+mVwQaJ4kfJtv7qG1g7LnEvaNaggd7UAzH5vpWsQ+ENhbGO1h3OuiwMyUJL5ce5GxBEH14pXd2gS3NS/yBfFXO+xufXhcyvM5XJbScYVbXOwBE0Q9QqxJI9ov+r+M7plxR/V8xOvsZ9bcD7IUkPQ2wiuqtd1gruLL+yZYIJiiIzh+l+WhexKpC63rD2K7ZFG4mZ8AFIUWWkbMRG1/cVXIqwZvn0CGTZOAwMkeGCqorqVlFOiWiMB8kMor59vEJYD8i7eqdUowERx8rZIbsAeNEkHY0hS0LW/a7PnMLorSs1oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ho9yQU7gsuHPGcVNZyr+98/VK0LADjINcJZ8pdLu0Io=;
 b=hG5fRVjFmbtPm77hZrtjgAkjwzXvskd35+hs7ArT8D8PAkkSSne4LDyBMqg3mB7sSZOBZbaZxhtb3aAQnIl9sDrUorgnRPKWJcVF1Kd//ADlfusZgJC7Q22r4CYKQz+A1scvFQgiEx1n/bU6Z5oxQXX73O/q5OTzh0Lm9xG+QML0mcIO+R3qBMkwx1boP3mVQdcjx+nylIY1F2gnmKXgI1ogKD59vGk2qKIFRESrzr3ZJpnXiA2S117nIi2UtHVL3ieJ0nYSThOk8VxyK/+T2aXALmP6lxpI1ozqRejgrXiJr2T98t+9buJCT/A3BgK8x32dvp+0JEu+IvfjIIMzLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ho9yQU7gsuHPGcVNZyr+98/VK0LADjINcJZ8pdLu0Io=;
 b=FCxQPqHtMmwzLMGAovsawY9juEVQEZ2M82gnESq551tGZRjC8jcp/naaPPzuUSXODeFOi5xR/vIKpKeAPFA+Bu4AphkcAMslpaJgtQXkLv/w0srFXWBaPAIczGoaY817bj5POOSQ/o3GEB9WFhzEByXITk7DRAw5kNCenZQxiiI=
Received: from SJ0PR03CA0089.namprd03.prod.outlook.com (2603:10b6:a03:331::34)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 03:02:46 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:331:cafe::fe) by SJ0PR03CA0089.outlook.office365.com
 (2603:10b6:a03:331::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 03:02:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 03:02:46 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 1 Mar 2026 21:02:43 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v3 2/4] drm/amdgpu/userq: Hold eventfd manager ref in fence
 driver
Date: Mon, 2 Mar 2026 08:32:17 +0530
Message-ID: <20260302030219.1734986-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302030219.1734986-1-srinivasan.shanmugam@amd.com>
References: <20260302030219.1734986-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: 20688d41-6d3b-47cb-a2d5-08de78082e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: yqOz0kIV6RiunEBq4dFi6UV1+gDJL/ipYwywEh7sI8fOzmapK1uMEzAfFbL3zLSDEQezrm8DUpgDZ13X26M5OpvL9RBTUfoKkaiBDhBm3gke4d9UgiRfgjQYjwohmu31+NG2+du0IbJaRzzDh768v9zC5vJLQbml93Rvp0w63mQIzuPuzHP2bClm4xmPcV/Ku2tgBiwEK/aJt0OkLujrCvBwHUPznRrCOEuw8cJ7yc5cx5Emrxyh2laml30GmR+LrILu+xL0EonjPoJqR4EbmrcD8FXxVbeyDecW9vATqvUhWUjXElLD/vW/D5K6a3Dv3C0Lj7WkqcuGCxthV53zpsNyCxS7XsK8kMQyHjXT6lBuXhSoeRMUWtQqvXPGEz+T7L3O9IA3+nDlx0JnipJK5pPZvnspDF4iczyzbhcBRC/Voebzu/h1YOfGx+186FyGBQ9aZOvjWItDcbPbovyULJFK6kLRliASuwc0oZ5OEBs67s9Cyftl+LQPXVHa799rcLkfW1J1k7lgGMGUiPv9VDmGKzod/8azXuujpMMT2cOHzucsMkuan58bwxaqkPkGaBn2USXVeIZTrC7xX8vcbK+7SfF8bHvegYJ/cAE8monYONiJnS2x1SZa+LHHNM/0lbeY3DE01rBrrGe3UEXYshs7qClkwYnvCEEZqPYSZLITDkM5GMFHqR1O97SCQ0KDk0hfvZdWPYvvKV9FNNYmjeJoOZAoE6SmmdxGwta1lESyMkGlXe4/MxfkgOZXvs6nA+OgU3wuRrqO5Y3TWESfKgstNEemEDFifS0dV+FMPV6ggDUG46qEGeoJa/87J9/cKqYTY8EDGmK6NeZbvbP3Dg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9BSr0KkLLaBGJAywdJizTnFPcAFA1SHsREhIGXut6tjSK+HxDQgo7MGPFTg84AGbRUYwNoqStVGjxlNf9aTWJlvZDUF+VbFyIWdsI+98G9nFDJwcsvJkUHLvDffAObdwcB5nNV6bDYjRF2SWOYi7DPT7l7lsoi098PM3TVCEkBmNGTXw5Por6gSLsNLcApl4z9bTtUuseKKRhRHeSuYO8c2rFFn9RIWAnf/U1bjmDn35Qsu0ZHaCrXiJP70tnhWDljSi0PfB/ot8jo6iQWRsHtK19GBp9v/REsQ7nGuF2m2jL4YmrrxjKjoy6qH3KFYGqJTd3sOAYB0De58THGkJVG8EwgfdQlHw/q7XiicLJuQw6ydjaotZhUheoQmWmZTJPHweqeRYHjQRs9EoQyxjFtdHQMC/f766h4pqlwS3HZV4Chamupg/vgA1kBuVayID
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 03:02:46.0322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20688d41-6d3b-47cb-a2d5-08de78082e14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294
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

USERQ fence driver can outlive amdgpu_fpriv, so
it must not hold a raw pointer to fpriv.

Store a kref'd amdgpu_eventfd_mgr pointer in the fence driver instead.
The manager is owned by the drm_file but can be safely referenced by
longer-lived producer objects.

Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 24 +++++++++++++++++--
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  4 ++++
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e07b2082cf25..95b28816c298 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -820,7 +820,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 	queue->doorbell_index = index;
 	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
-	r = amdgpu_userq_fence_driver_alloc(adev, queue);
+	r = amdgpu_userq_fence_driver_alloc(adev, fpriv->eventfd_mgr, queue);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
 		goto unlock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 3c30512a6266..a69b95f74fbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -31,6 +31,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_eventfd.h"
 
 static const struct dma_fence_ops amdgpu_userq_fence_ops;
 static struct kmem_cache *amdgpu_userq_fence_slab;
@@ -78,6 +79,7 @@ amdgpu_userq_fence_write(struct amdgpu_userq_fence_driver *fence_drv,
 }
 
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
+				    struct amdgpu_eventfd_mgr *eventfd_mgr,
 				    struct amdgpu_usermode_queue *userq)
 {
 	struct amdgpu_userq_fence_driver *fence_drv;
@@ -104,18 +106,26 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	fence_drv->context = dma_fence_context_alloc(1);
 	get_task_comm(fence_drv->timeline_name, current);
 
+	fence_drv->eventfd_mgr = eventfd_mgr;
+	if (fence_drv->eventfd_mgr)
+		amdgpu_eventfd_mgr_get(fence_drv->eventfd_mgr);
+
 	xa_lock_irqsave(&adev->userq_xa, flags);
 	r = xa_err(__xa_store(&adev->userq_xa, userq->doorbell_index,
 			      fence_drv, GFP_KERNEL));
 	xa_unlock_irqrestore(&adev->userq_xa, flags);
 	if (r)
-		goto free_seq64;
+		goto free_mgr_ref;
 
 	userq->fence_drv = fence_drv;
 
 	return 0;
 
-free_seq64:
+free_mgr_ref:
+	if (fence_drv->eventfd_mgr) {
+		amdgpu_eventfd_mgr_put(fence_drv->eventfd_mgr);
+		fence_drv->eventfd_mgr = NULL;
+	}
 	amdgpu_seq64_free(adev, fence_drv->va);
 free_fence_drv:
 	kfree(fence_drv);
@@ -214,6 +224,16 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 			__xa_erase(xa, index);
 	xa_unlock_irqrestore(xa, flags);
 
+	/*
+	 * Drop the eventfd manager reference held by this fence driver.
+	 * Do this after fences are canceled (so any fence completion paths
+	 * that might signal still have a valid mgr while we unwind).
+	 */
+	if (fence_drv->eventfd_mgr) {
+		amdgpu_eventfd_mgr_put(fence_drv->eventfd_mgr);
+		fence_drv->eventfd_mgr = NULL;
+	}
+
 	/* Free seq64 memory */
 	amdgpu_seq64_free(adev, fence_drv->va);
 	kfree(fence_drv);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index d76add2afc77..857b43bb64f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -29,6 +29,8 @@
 
 #include "amdgpu_userq.h"
 
+struct amdgpu_eventfd_mgr;
+
 struct amdgpu_userq_fence {
 	struct dma_fence base;
 	/*
@@ -56,6 +58,7 @@ struct amdgpu_userq_fence_driver {
 	struct list_head fences;
 	struct amdgpu_device *adev;
 	char timeline_name[TASK_COMM_LEN];
+	struct amdgpu_eventfd_mgr *eventfd_mgr; /* kref'd */
 };
 
 int amdgpu_userq_fence_slab_init(void);
@@ -64,6 +67,7 @@ void amdgpu_userq_fence_slab_fini(void);
 void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv);
 void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
+				    struct amdgpu_eventfd_mgr *eventfd_mgr,
 				    struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
-- 
2.34.1

