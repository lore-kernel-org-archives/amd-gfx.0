Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D28EC3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 950DB10E37C;
	Thu, 10 Apr 2025 18:12:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MJSDl+RS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B566D10E14D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:12:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lc2iP476H+k1H1SQ4S/y+5J7LZ8rK6NLTHBZ6AHZ7dzSCxcu4CunpCTc3cAVrsxe5DoBpct+Pk4mc6EkB64RnIHSX58C10s9XIb3zyKBsgQuuwCD9EF1cz7b+300W07Qhz5X8tFP8jTHWGUv06ybw7SEcjs76j9pDz5oVY9tiP/9oxxBvQkg4RZ5oke0KiTeN0jr1EphyK810+0mwoqJeU4MLaEncvrCFcgttBApAs9JO7YiX1352OcZ1TQgFJgJ7HmvaOTvXX0/XzG9LLc4rGNCHBLGmUz84pCYWh+FM+oEOFNO81dCgcCyN6T2oxKjn6hlzZK+JPawKEXwA35JPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsOjlHGxk3TF+pSxnMPJIhiuIjSFzqgz3t4yDXIsKbw=;
 b=S9UHeQot2F75pPXltBxE/OwAEn/wPuHCQBCrJHsHKOELHDSpWa0QD24dAggtSlbrKyKfniVjagJrmutpMVWvAC/Wu3eh3kaNeZIr1zHhlOKc4DFFDFCqB4qKBxwSaV0TJVeBev97v5HOh0GDH+MYYQOXJVbuFFCjTYW4HgaxelKxr0LyyOeOi2znZp4uVcCp97bCrotEBqeqKZ3mMt38tDkRNIA5pC8YIbA/D5kSYB8N+jyQOBgKBif+9K1xR4IbaEvIsaOoeViaeWm+8fza00DIto5fk6JKCo6cFbwT+LsmzJ7YTSeamjkjwXSW3AiGqUCfmYeskAe11Z0fS7YreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsOjlHGxk3TF+pSxnMPJIhiuIjSFzqgz3t4yDXIsKbw=;
 b=MJSDl+RSZozyVqxRsxAYoJVeJTweJUKnui5LLvni3nDbGMEbDjrJIMiWR8K+LGe2D4/qsRaUtefwsQuUJDDY7vytJ+X67xUeIIy1mLhA8zHKQJzmWkZRcsOhmYEpCbPnSgMaIeSEVteyEFuf5dkP75HmyqOootH+du4hUr7v4oA=
Received: from BN9PR03CA0336.namprd03.prod.outlook.com (2603:10b6:408:f6::11)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 18:11:53 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::3f) by BN9PR03CA0336.outlook.office365.com
 (2603:10b6:408:f6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.36 via Frontend Transport; Thu,
 10 Apr 2025 18:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:11:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:11:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/9] drm/amdgpu/userq: move some code around
Date: Thu, 10 Apr 2025 14:11:32 -0400
Message-ID: <20250410181138.2287932-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410181138.2287932-1-alexander.deucher@amd.com>
References: <20250410181138.2287932-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4035fb-385a-46d3-0357-08dd785b2c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hsrMaVfjZuniYw6JkD3AouuIIYhO09M6Zx8axjvecHcyu4Zht7FSkrZBXNHB?=
 =?us-ascii?Q?pBGZvvUGa3uPF7OXRiFtaIzfUHzqMxFaq7lw483QBdkO28TMdl4Xg7ws9MHF?=
 =?us-ascii?Q?92xvNebRTRoN00ziA/UL0E+DG0aeFtOUl00KqKUXQ9WUcx0qmnXl1Yi73/Ih?=
 =?us-ascii?Q?/mPfObEDdzvVC6Eql/R25J2b8EYWZvndjj8oVxvGEy1b/EsnhfWgG07si4tY?=
 =?us-ascii?Q?2bLj/FVWiwNGEYfCfuKRjFf7nmtYL95y0HYLtdmJHx5QiB93ZtGTk9CUoRFb?=
 =?us-ascii?Q?ucqKW4pQOR4zvc3V9HZktMZvGEXMYM/SNwmlwc7Hi5tVz0Y1iaLgRES6z0JF?=
 =?us-ascii?Q?rg/nrZcv/kFQP9AkQCFnhrldBGB68kogPI4DgscRBDihtRPWiHSd8CVTi8BK?=
 =?us-ascii?Q?I/CqbqhG4JKjsfm2kxcR+8w9Dc6l/XyNJ6/OxV6Nud9FIejLDuKRmFtQyMkV?=
 =?us-ascii?Q?aE6QTb0C4DNj8nIgaqwY8bCGLvMYJ3Pp1Xv+t2XUU5XWKzJ4qjZ1SSslkOCB?=
 =?us-ascii?Q?DXjSDiYsQ1hosQEVTnXw+W1W6Gd/58wmQhIlfzuJltf7bPn0TjCYirJOh5QC?=
 =?us-ascii?Q?sUF/oAnRONN6+/twpIDWhcuEaWjI5+NjRfOYIVvtFX89wdAnCFme/LX9BX5h?=
 =?us-ascii?Q?qUE7Oqy729q5taW70HQlzRg42w9mCqOjgoBM/mtI8DunTEWFtpTv0MDgz/fb?=
 =?us-ascii?Q?AMdpFWYTGigPPPfsg/aVa0eQ9sAAAALzvpeKmTAL6bVHE+X8MlvDSaL4PSyU?=
 =?us-ascii?Q?7MHj/35HO2ImpPL73g3M301JQZbz/FJNQUEljhUkelgDeqPBuE+aGvAZW9jL?=
 =?us-ascii?Q?wDk3wYvMNuNLqNqWoHDxHofQBKhh6ZRObkd4JWns7/SO0+GFqq8T6rwiAUd5?=
 =?us-ascii?Q?X9IzBReA/9IaDWsptxRZHPzZmDDXk1s5cHL0+NQy4fK0v2gWUJPq9md/zrTr?=
 =?us-ascii?Q?aSMD3o42VTeQvnGgCSeKYtUEZkBcWfJJ0N9K3q/sEDovALN00FZ77FOxcbwe?=
 =?us-ascii?Q?FKBNlhfo6widtr6ZWKQmZRH9WdlCvLVKfnTOB2oTfqv6prOuNfveyKUx9JLW?=
 =?us-ascii?Q?FYiY0XvIje2ao5Q0h3RtWm9K0r2ojV/C+9QRlkJpnIB2o/zZgIyd8l9wCn1t?=
 =?us-ascii?Q?V5c5GCix2Fuu79aUGu4DiELdWS8kWVq86GooRrcylFhUnT3AENDwnxVLXm+m?=
 =?us-ascii?Q?9OT0kCB3OytdO2ZtgETFLnPAH4Y22oM95UL1EDCZqqDFuGuHTCRa78LdAy4/?=
 =?us-ascii?Q?ltXP1pMsB/KjLXz8tk7uHJ0OiWZP1KhIJZ5tsZ6mR5G6ZXwcpiDtBGtENNIK?=
 =?us-ascii?Q?34xuNlpy8vvM74HDdO4DQ/QEZIKT95ApgCbYjXGZ778T8XLYXXE+REtJ/M/n?=
 =?us-ascii?Q?73bXdFAa/YW/wM52tk6wmWB4kP8UvdGgTLufFT2DG8K5HhfQcPBX40vZqkwR?=
 =?us-ascii?Q?MnvcL4mLaaTW93vVMGponm7eI2zBWG1tE5Ux/dvcbQlcPPECnSF5hYMcn5X1?=
 =?us-ascii?Q?ej5mkg5HaR5I9SFlLbXfX6H7lqWR9w9QtS5j?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:11:53.8471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4035fb-385a-46d3-0357-08dd785b2c67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836
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

Move some userq fence handling code into amdgpu_userq_fence.c.
This matches the other code in that file.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 26 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 26 -------------------
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a4953d668972a..ee73d7846c2ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -120,6 +120,32 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	return r;
 }
 
+static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
+{
+	struct amdgpu_userq_fence_driver *fence_drv;
+	unsigned long index;
+
+	if (xa_empty(xa))
+		return;
+
+	xa_lock(xa);
+	xa_for_each(xa, index, fence_drv) {
+		__xa_erase(xa, index);
+		amdgpu_userq_fence_driver_put(fence_drv);
+	}
+
+	xa_unlock(xa);
+}
+
+void
+amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
+{
+	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
+	xa_destroy(&userq->fence_drv_xa);
+	/* Drop the fence_drv reference held by user queue */
+	amdgpu_userq_fence_driver_put(userq->fence_drv);
+}
+
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
 {
 	struct amdgpu_userq_fence *userq_fence, *tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index f0a91cc028808..7bbae238cca0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -66,6 +66,7 @@ void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv);
 void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq);
+void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
 void amdgpu_userq_fence_driver_destroy(struct kref *ref);
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index c3873041ec942..79f4df4255c50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -28,32 +28,6 @@
 #include "amdgpu_userqueue.h"
 #include "amdgpu_userq_fence.h"
 
-static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
-{
-	struct amdgpu_userq_fence_driver *fence_drv;
-	unsigned long index;
-
-	if (xa_empty(xa))
-		return;
-
-	xa_lock(xa);
-	xa_for_each(xa, index, fence_drv) {
-		__xa_erase(xa, index);
-		amdgpu_userq_fence_driver_put(fence_drv);
-	}
-
-	xa_unlock(xa);
-}
-
-static void
-amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
-{
-	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
-	xa_destroy(&userq->fence_drv_xa);
-	/* Drop the fence_drv reference held by user queue */
-	amdgpu_userq_fence_driver_put(userq->fence_drv);
-}
-
 static void
 amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 			 struct amdgpu_usermode_queue *queue,
-- 
2.49.0

