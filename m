Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262B7CF6497
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 12:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C765110E406;
	Mon, 30 Sep 2024 12:00:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HKBl1Gp4";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3424310E406
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 12:00:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgMW/LZuCwQ1VyeU801nONE1xApDBr3fZl4wv8u0LXNVEKydWxch5R4tCLDPAS9OzF+wdJf6qd1nR6ORfrNMwH27/S2gcey0hAOrQfgx4crt0/8S1VHGyVNBSTwx8YaoodMCO1jgfmZuJqX4sK+U53m76anEmyP1ryizEcEcidSVtd0qw4tzhYrwW80mj5EFzcCHDSm78X3Wp8b0X7qOmh1mFe0pf2iNanmmV4JMAQXPPfD5HtMlMKOTp2xrVs125kd89JMQj7tY25Nm1gOkroN1x39tK6L2oP/xUReyMZxRKwnvl98JluKurj0diIeFuZIP1XDtpcBndClZ+pruQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+KEDa5ANnhbtIcYTmQzKOeMpCw78uI8KF8qWmtuVWE=;
 b=FlbM+DL0U9UYnXSLKspVHfNZft1UWtY4jUP6kgmlEjYhgLgDEZU2+wEsvjJrgV814WcobPTqIZxvNvkOJDjkbetF2yre31AGBuQ+N7PtWpKfxqEQUquxgK3RIlU5b3QaBrFTj6pgNsPUzPK3LurfOtDajITqe/IxatYoKaGGaieZhgqIijzK/M5i/I7mGL4QIWZoM/x8pPBikLbPtuPyfi1I/iQqtbs/GKKMIBOR0+GJEg9r0V1SdYjCnTea+g2pEh9GkKWtK8bMEYC9PhG4kD3JVekNZa6dNvtY3cZa57iJIIucwFsUA3smDLxgIu+A6KLakm5DW/uobeMsj15zVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+KEDa5ANnhbtIcYTmQzKOeMpCw78uI8KF8qWmtuVWE=;
 b=HKBl1Gp4DhQrc/V6x1BNwo4G/uwb4k+7+6WFyKrQApD1BmaFRZgfrKc9JfkKZeE2rXeXLMx/w7Pzk3oUff7jbqcIGkm1fuQM2QeEwya5yLfPgyKtOViMFHWxQ8QkLpqKbqYXhHku+CyD1gtD97AY9J1pVw9bl7cLXG81udULBWo=
Received: from PH7P220CA0174.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::21)
 by SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 12:00:32 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::7e) by PH7P220CA0174.outlook.office365.com
 (2603:10b6:510:33b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 12:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 12:00:31 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 07:00:29 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v3 09/09] drm/amdgpu: Add separate array of read and write for
 BO handles
Date: Mon, 30 Sep 2024 17:29:06 +0530
Message-ID: <20240930115906.191060-9-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930115906.191060-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240930115906.191060-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|SJ0PR12MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 697feec6-dafc-46ea-1928-08dce1477c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wXl9D+vKm7Vu9yKgwASxk7vdgdC4l59HB1K//KrDQ6h0fFCPSlOpPKckg1lj?=
 =?us-ascii?Q?f6F+nqYgynKGWByfMRHI+MT4yqgA/gFMvS7KGuvNynHF0qrTvl9gGsvFuhAV?=
 =?us-ascii?Q?OE+sc4YCgkx/vZ355sQM42zMbNvnkkji4h2YxenW6oxvxa9XDpNv3yeLoNUY?=
 =?us-ascii?Q?DWy5zOutL76ToJuQKIi8ZzFIirdUkJSpsc9sDj3pJ5bfog6zKjQFjZOjqDVO?=
 =?us-ascii?Q?uQWe1nwd2QMh8tDQdWbYTUOY5KuRFPgWR5PIFgxRMn0nt5vOHbldpNF7mFaY?=
 =?us-ascii?Q?lwfKT4tZru6CcrwWzRqGV0ICZ1wXyRZqqAFDU661Lm2BTStiMitCh5lbhcG5?=
 =?us-ascii?Q?0q4WY5YRk7noYngscqVFUhVtoxMx56YccS8Q+kjIW49Ae5XUsqdilHz2pxK2?=
 =?us-ascii?Q?7iGR2gLdTVxbFwWE3FfHGtLIUt1kt8cQrZJbyu8ZXYF9aaXAJn7e/82qQ3ya?=
 =?us-ascii?Q?HF2BtP0dfMRa1c/Qi72MExGeaILHdY6/i7L0DrasQdFebJiOCo3axqRT/unk?=
 =?us-ascii?Q?t3HgOldqFa/Ww5/RQ0yD8NA9DrbXc1mjjGKGdQr9YcLWGxewkGr5JvRR8Bp5?=
 =?us-ascii?Q?0ITRpSLMP+DMcOQ5F6QbA4WtjpQaSfjyhqZhK4qUJxqiN3hAYvpFrfJMobVH?=
 =?us-ascii?Q?XHyDmMCRMNQ9Yjf7GbnR1Jkx0GxrLVc+HdUtX7qonEiPfTxo+unNXu+3nduG?=
 =?us-ascii?Q?CefMlEFWpiBICF846RlK/PqzCOr6rxK38jlFOxxESKHiQDg6WqEU4232xd5n?=
 =?us-ascii?Q?eOaNWdehzI5yBon3ocT1Y9HcMesqOcvyNUhrCdr1prgN+CcOyPb35p4MYMFa?=
 =?us-ascii?Q?ACPOfeNe3KdmLmaOFl/bNr1lxAwKg/4NHwXfUT8iyoH7ScoYRFO+r3BXvOdh?=
 =?us-ascii?Q?9xuSt5KCC2z3hJgpnZQkU74w5KnIy+z01W2eBQQU+YKxRsutXKYQ+QRzy9p4?=
 =?us-ascii?Q?aGDScNmM03L1XVTt/bu5UpU6XYyCM+uD9PT8RDtt106SHwPbsjTEaev1ZVlp?=
 =?us-ascii?Q?wylqZryQZddWj0iS8cx7w9Kl1x1SnzgVJrSYgYJI0+6tFT0sPAGaVi+0a07u?=
 =?us-ascii?Q?JO/vYnuiX7/o9jSVCbnmd+NCbVY0uAaoCDCWAM7XGgJXjdW7LsiNaFjytxo6?=
 =?us-ascii?Q?zHDTFYnP18pxVoZJaSPIouehddSVu2zawdGq4TsFy9Iy5ef5Z9auBZpwlyXg?=
 =?us-ascii?Q?tjUUxuiHnRm4140EQdFxtctDyChlcFXdUgmUnNodL3PDQOPK9Bc3/I1EAfeY?=
 =?us-ascii?Q?k5N2ctivPl4GoFq6Z6xU6H3NB8dzImJssLZU3cuwvuZnEpFhMdPDYSEt4TXO?=
 =?us-ascii?Q?BF2OXf5Q920e2X+V0vh0ZV35i8tZGELpRmUqqiEHNPBtbVrMnF2RnFcG6wtN?=
 =?us-ascii?Q?9o+Jy7YgOxOB711xNziJUAYM1otJAvZraeq8hBayQ1RjYx6CmT5Ak2BrwNy9?=
 =?us-ascii?Q?q6XHt2Ff21zR1PAO/qtO/XFmLUNi3zhU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:00:31.9802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 697feec6-dafc-46ea-1928-08dce1477c17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475
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

Drop AMDGPU_USERQ_BO_WRITE as this should not be a global option
of the IOCTL, It should be option per buffer. Hence adding separate
array for read and write BO handles.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 238 +++++++++++++-----
 include/uapi/drm/amdgpu_drm.h                 |  48 ++--
 2 files changed, 206 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 0725f28f3484..aa794f342036 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -386,12 +386,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
 	struct drm_amdgpu_userq_signal *args = data;
+	struct drm_gem_object **gobj_write = NULL;
+	struct drm_gem_object **gobj_read = NULL;
 	struct amdgpu_usermode_queue *queue;
-	struct drm_gem_object **gobj = NULL;
 	struct drm_syncobj **syncobj = NULL;
+	u32 *bo_handles_write, num_write_bo_handles;
 	u32 *syncobj_handles, num_syncobj_handles;
-	u32 *bo_handles, num_bo_handles;
-	int r, i, entry, boentry;
+	u32 *bo_handles_read, num_read_bo_handles;
+	int r, i, entry, rentry, wentry;
 	struct dma_fence *fence;
 	struct drm_exec exec;
 	u64 wptr;
@@ -417,32 +419,59 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	num_bo_handles = args->num_bo_handles;
-	bo_handles = memdup_user(u64_to_user_ptr(args->bo_handles_array),
-				 sizeof(u32) * num_bo_handles);
-	if (IS_ERR(bo_handles))
+	num_read_bo_handles = args->num_read_bo_handles;
+	bo_handles_read = memdup_user(u64_to_user_ptr(args->bo_handles_read_array),
+				      sizeof(u32) * num_read_bo_handles);
+	if (IS_ERR(bo_handles_read))
 		goto free_syncobj;
 
-	/* Array of pointers to the GEM objects */
-	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
-	if (!gobj) {
+	/* Array of pointers to the GEM read objects */
+	gobj_read = kmalloc_array(num_read_bo_handles, sizeof(*gobj_read), GFP_KERNEL);
+	if (!gobj_read) {
 		r = -ENOMEM;
-		goto free_bo_handles;
+		goto free_bo_handles_read;
 	}
 
-	for (boentry = 0; boentry < num_bo_handles; boentry++) {
-		gobj[boentry] = drm_gem_object_lookup(filp, bo_handles[boentry]);
-		if (!gobj[boentry]) {
+	for (rentry = 0; rentry < num_read_bo_handles; rentry++) {
+		gobj_read[rentry] = drm_gem_object_lookup(filp, bo_handles_read[rentry]);
+		if (!gobj_read[rentry]) {
 			r = -ENOENT;
-			goto put_gobj;
+			goto put_gobj_read;
 		}
 	}
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, num_bo_handles);
+	num_write_bo_handles = args->num_write_bo_handles;
+	bo_handles_write = memdup_user(u64_to_user_ptr(args->bo_handles_write_array),
+				       sizeof(u32) * num_write_bo_handles);
+	if (IS_ERR(bo_handles_write))
+		goto put_gobj_read;
+
+	/* Array of pointers to the GEM write objects */
+	gobj_write = kmalloc_array(num_write_bo_handles, sizeof(*gobj_write), GFP_KERNEL);
+	if (!gobj_write) {
+		r = -ENOMEM;
+		goto free_bo_handles_write;
+	}
+
+	for (wentry = 0; wentry < num_write_bo_handles; wentry++) {
+		gobj_write[wentry] = drm_gem_object_lookup(filp, bo_handles_write[wentry]);
+		if (!gobj_write[wentry]) {
+			r = -ENOENT;
+			goto put_gobj_write;
+		}
+	}
+
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
+		      (num_read_bo_handles + num_write_bo_handles));
 
 	/* Lock all BOs with retry handling */
 	drm_exec_until_all_locked(&exec) {
-		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 1);
+		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (r)
+			goto exec_fini;
+
+		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
 		drm_exec_retry_on_contention(&exec);
 		if (r)
 			goto exec_fini;
@@ -468,13 +497,20 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	dma_fence_put(queue->last_fence);
 	queue->last_fence = dma_fence_get(fence);
 
-	for (i = 0; i < num_bo_handles; i++) {
-		if (!gobj || !gobj[i]->resv)
+	for (i = 0; i < num_read_bo_handles; i++) {
+		if (!gobj_read || !gobj_read[i]->resv)
 			continue;
 
-		dma_resv_add_fence(gobj[i]->resv, fence,
-				   dma_resv_usage_rw(args->bo_flags &
-				   AMDGPU_USERQ_BO_WRITE));
+		dma_resv_add_fence(gobj_read[i]->resv, fence,
+				   DMA_RESV_USAGE_READ);
+	}
+
+	for (i = 0; i < num_write_bo_handles; i++) {
+		if (!gobj_write || !gobj_write[i]->resv)
+			continue;
+
+		dma_resv_add_fence(gobj_read[i]->resv, fence,
+				   DMA_RESV_USAGE_WRITE);
 	}
 
 	/* Add the created fence to syncobj/BO's */
@@ -486,12 +522,18 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 
 exec_fini:
 	drm_exec_fini(&exec);
-put_gobj:
-	while (boentry-- > 0)
-		drm_gem_object_put(gobj[boentry]);
-	kfree(gobj);
-free_bo_handles:
-	kfree(bo_handles);
+put_gobj_write:
+	while (wentry-- > 0)
+		drm_gem_object_put(gobj_write[wentry]);
+	kfree(gobj_write);
+free_bo_handles_write:
+	kfree(bo_handles_write);
+put_gobj_read:
+	while (rentry-- > 0)
+		drm_gem_object_put(gobj_read[rentry]);
+	kfree(gobj_read);
+free_bo_handles_read:
+	kfree(bo_handles_read);
 free_syncobj:
 	while (entry-- > 0)
 		if (syncobj[entry])
@@ -506,28 +548,35 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *filp)
 {
-	u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_handles;
-	u32 num_syncobj, num_bo_handles, num_points;
+	u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_handles_read, *bo_handles_write;
+	u32 num_syncobj, num_read_bo_handles, num_write_bo_handles, num_points;
 	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
 	struct drm_amdgpu_userq_wait *wait_info = data;
+	struct drm_gem_object **gobj_write;
+	struct drm_gem_object **gobj_read;
 	struct dma_fence **fences = NULL;
-	struct drm_gem_object **gobj;
+	int r, i, rentry, wentry, cnt;
 	struct drm_exec exec;
-	int r, i, entry, cnt;
 	u64 num_fences = 0;
 
-	num_bo_handles = wait_info->num_bo_handles;
-	bo_handles = memdup_user(u64_to_user_ptr(wait_info->bo_handles_array),
-				 sizeof(u32) * num_bo_handles);
-	if (IS_ERR(bo_handles))
-		return PTR_ERR(bo_handles);
+	num_read_bo_handles = wait_info->num_read_bo_handles;
+	bo_handles_read = memdup_user(u64_to_user_ptr(wait_info->bo_handles_read_array),
+				      sizeof(u32) * num_read_bo_handles);
+	if (IS_ERR(bo_handles_read))
+		return PTR_ERR(bo_handles_read);
+
+	num_write_bo_handles = wait_info->num_write_bo_handles;
+	bo_handles_write = memdup_user(u64_to_user_ptr(wait_info->bo_handles_write_array),
+				       sizeof(u32) * num_write_bo_handles);
+	if (IS_ERR(bo_handles_write))
+		goto free_bo_handles_read;
 
 	num_syncobj = wait_info->num_syncobj_handles;
 	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles_array),
 				      sizeof(u32) * num_syncobj);
 	if (IS_ERR(syncobj_handles)) {
 		r = PTR_ERR(syncobj_handles);
-		goto free_bo_handles;
+		goto free_bo_handles_write;
 	}
 
 	num_points = wait_info->num_points;
@@ -545,29 +594,51 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		goto free_timeline_handles;
 	}
 
-	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
-	if (!gobj) {
+	gobj_read = kmalloc_array(num_read_bo_handles, sizeof(*gobj_read), GFP_KERNEL);
+	if (!gobj_read) {
 		r = -ENOMEM;
 		goto free_timeline_points;
 	}
 
-	for (entry = 0; entry < num_bo_handles; entry++) {
-		gobj[entry] = drm_gem_object_lookup(filp, bo_handles[entry]);
-		if (!gobj[entry]) {
+	for (rentry = 0; rentry < num_read_bo_handles; rentry++) {
+		gobj_read[rentry] = drm_gem_object_lookup(filp, bo_handles_read[rentry]);
+		if (!gobj_read[rentry]) {
+			r = -ENOENT;
+			goto put_gobj_read;
+		}
+	}
+
+	gobj_write = kmalloc_array(num_write_bo_handles, sizeof(*gobj_write), GFP_KERNEL);
+	if (!gobj_write) {
+		r = -ENOMEM;
+		goto put_gobj_read;
+	}
+
+	for (wentry = 0; wentry < num_write_bo_handles; wentry++) {
+		gobj_write[wentry] = drm_gem_object_lookup(filp, bo_handles_write[wentry]);
+		if (!gobj_write[wentry]) {
 			r = -ENOENT;
-			goto put_gobj;
+			goto put_gobj_write;
 		}
 	}
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, num_bo_handles);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
+		      (num_read_bo_handles + num_write_bo_handles));
 
 	/* Lock all BOs with retry handling */
 	drm_exec_until_all_locked(&exec) {
-		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 0);
+		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 0);
+		drm_exec_retry_on_contention(&exec);
+		if (r) {
+			drm_exec_fini(&exec);
+			goto put_gobj_write;
+		}
+
+		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 0);
 		drm_exec_retry_on_contention(&exec);
 		if (r) {
 			drm_exec_fini(&exec);
-			goto put_gobj;
+			goto put_gobj_write;
 		}
 	}
 
@@ -611,13 +682,21 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		}
 
 		/* Count GEM objects fence */
-		for (i = 0; i < num_bo_handles; i++) {
+		for (i = 0; i < num_read_bo_handles; i++) {
 			struct dma_resv_iter resv_cursor;
 			struct dma_fence *fence;
 
-			dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
-						dma_resv_usage_rw(wait_info->bo_wait_flags &
-						AMDGPU_USERQ_BO_WRITE), fence)
+			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
+						DMA_RESV_USAGE_READ, fence)
+				num_fences++;
+		}
+
+		for (i = 0; i < num_write_bo_handles; i++) {
+			struct dma_resv_iter resv_cursor;
+			struct dma_fence *fence;
+
+			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
+						DMA_RESV_USAGE_WRITE, fence)
 				num_fences++;
 		}
 
@@ -643,14 +722,30 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			goto free_fence_info;
 		}
 
-		/* Retrieve GEM objects fence */
-		for (i = 0; i < num_bo_handles; i++) {
+		/* Retrieve GEM read objects fence */
+		for (i = 0; i < num_read_bo_handles; i++) {
 			struct dma_resv_iter resv_cursor;
 			struct dma_fence *fence;
 
-			dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
-						dma_resv_usage_rw(wait_info->bo_wait_flags &
-						AMDGPU_USERQ_BO_WRITE), fence) {
+			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
+						DMA_RESV_USAGE_READ, fence) {
+				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
+					r = -EINVAL;
+					goto free_fences;
+				}
+
+				fences[num_fences++] = fence;
+				dma_fence_get(fence);
+			}
+		}
+
+		/* Retrieve GEM write objects fence */
+		for (i = 0; i < num_write_bo_handles; i++) {
+			struct dma_resv_iter resv_cursor;
+			struct dma_fence *fence;
+
+			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
+						DMA_RESV_USAGE_WRITE, fence) {
 				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
 					r = -EINVAL;
 					goto free_fences;
@@ -771,14 +866,19 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	}
 
 	drm_exec_fini(&exec);
-	for (i = 0; i < num_bo_handles; i++)
-		drm_gem_object_put(gobj[i]);
-	kfree(gobj);
+	for (i = 0; i < num_read_bo_handles; i++)
+		drm_gem_object_put(gobj_read[i]);
+	kfree(gobj_read);
+
+	for (i = 0; i < num_write_bo_handles; i++)
+		drm_gem_object_put(gobj_write[i]);
+	kfree(gobj_write);
 
 	kfree(timeline_points);
 	kfree(timeline_handles);
 	kfree(syncobj_handles);
-	kfree(bo_handles);
+	kfree(bo_handles_write);
+	kfree(bo_handles_read);
 
 	return 0;
 
@@ -790,18 +890,24 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	kfree(fence_info);
 exec_fini:
 	drm_exec_fini(&exec);
-put_gobj:
-	while (entry-- > 0)
-		drm_gem_object_put(gobj[entry]);
-	kfree(gobj);
+put_gobj_write:
+	while (wentry-- > 0)
+		drm_gem_object_put(gobj_write[wentry]);
+	kfree(gobj_write);
+put_gobj_read:
+	while (rentry-- > 0)
+		drm_gem_object_put(gobj_read[rentry]);
+	kfree(gobj_read);
 free_timeline_points:
 	kfree(timeline_points);
 free_timeline_handles:
 	kfree(timeline_handles);
 free_syncobj_handles:
 	kfree(syncobj_handles);
-free_bo_handles:
-	kfree(bo_handles);
+free_bo_handles_write:
+	kfree(bo_handles_write);
+free_bo_handles_read:
+	kfree(bo_handles_read);
 
 	return r;
 }
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index eeb345ddbf57..8d21e765094b 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -443,9 +443,6 @@ struct drm_amdgpu_userq_mqd_compute_gfx_v11 {
 	__u64   eop_va;
 };
 
-/* dma_resv usage flag */
-#define AMDGPU_USERQ_BO_WRITE	1
-
 /* userq signal/wait ioctl */
 struct drm_amdgpu_userq_signal {
 	/**
@@ -475,20 +472,32 @@ struct drm_amdgpu_userq_signal {
 	 */
 	__u64	syncobj_point;
 	/**
-	 * @bo_handles_array: An array of GEM BO handles used by the userq fence creation
-	 * IOCTL to install the created dma_fence object which can be utilized by
+	 * @bo_handles_read_array: An array of GEM read BO handles used by the userq fence
+	 * creation IOCTL to install the created dma_fence object which can be utilized by
+	 * userspace to synchronize the BO usage between user processes.
+	 */
+	__u64	bo_handles_read_array;
+	/**
+	 * @bo_handles_write_array: An array of GEM write BO handles used by the userq fence
+	 * creation IOCTL to install the created dma_fence object which can be utilized by
 	 * userspace to synchronize the BO usage between user processes.
 	 */
-	__u64	bo_handles_array;
+	__u64	bo_handles_write_array;
+	/**
+	 * @num_read_bo_handles: A count that represents the number of GEM read BO handles in
+	 * @bo_handles_read_array.
+	 */
+	__u32	num_read_bo_handles;
 	/**
-	 * @num_bo_handles: A count that represents the number of GEM BO handles in
-	 * @bo_handles_array.
+	 * @num_write_bo_handles: A count that represents the number of GEM write BO handles in
+	 * @bo_handles_write_array.
 	 */
-	__u32	num_bo_handles;
+	__u32	num_write_bo_handles;
 	/**
 	 * @bo_flags: flags to indicate BOs synchronize for READ or WRITE
 	 */
 	__u32	bo_flags;
+	__u32	pad;
 };
 
 struct drm_amdgpu_userq_fence_info {
@@ -542,20 +551,31 @@ struct drm_amdgpu_userq_wait {
 	 */
 	__u64	syncobj_timeline_points;
 	/**
-	 * @bo_handles_array: An array of GEM BO handles defined to fetch the fence
+	 * @bo_handles_read_array: An array of GEM read BO handles defined to fetch the fence
 	 * wait information of every BO handles in the array.
 	 */
-	__u64	bo_handles_array;
+	__u64	bo_handles_read_array;
+	/**
+	 * @bo_handles_write_array: An array of GEM write BO handles defined to fetch the fence
+	 * wait information of every BO handles in the array.
+	 */
+	__u64	bo_handles_write_array;
 	/**
 	 * @num_syncobj_handles: A count that represents the number of syncobj handles in
 	 * @syncobj_handles_array.
 	 */
 	__u32	num_syncobj_handles;
 	/**
-	 * @num_bo_handles: A count that represents the number of GEM BO handles in
-	 * @bo_handles_array.
+	 * @num_read_bo_handles: A count that represents the number of GEM BO handles in
+	 * @bo_handles_read_array.
+	 */
+	__u32	num_read_bo_handles;
+	/**
+	 * @num_write_bo_handles: A count that represents the number of GEM BO handles in
+	 * @bo_handles_write_array.
 	 */
-	__u32	num_bo_handles;
+	__u32	num_write_bo_handles;
+	__u32	pad;
 	/**
 	 * @userq_fence_info: An array of fence information (va and value) pair of each
 	 * objects stored in @syncobj_handles_array and @bo_handles_array.
-- 
2.34.1

