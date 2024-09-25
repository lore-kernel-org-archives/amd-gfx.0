Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26B0CCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 20:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54BFB10E85A;
	Wed, 25 Sep 2024 20:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uTjlfyfW";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC4CF10E85A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 20:00:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ywrr955W+UG+qQfFph+VlSFSEzOpnElDgQFPGYssmrKbnNmSoAiKQiqHEgx5/EP39QYzrIEGBiGfz8vZmamrFUY9R4I91nS5c7gVoS14CZL4VFv+J7jzqMV9js488MNOqwfXtdtyX308QrP2OdewaRD1tcA5H1xaxxoRqmN0faaWbbZAd//ppDeLEDPyfqoHJLs4ChoUdYsZ+Avkq48KxEoO3PvVOhfFr41abYl4lJEX/bgeQ0/7NDjNx0882ua8THwHHhRZbxhSr9uSCHcsOh/S+a37umpScuHkdyzEx9xfkOwAkFkak4E50kn5MjWyetHSoybtBz+hjESgkA1caA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9QCexCMtHp+QrXVECFInsPc+kdTr3E98OU/n3QqREI=;
 b=yv3fVqLDP5R7g9ka1CdciUjyvGZ4OY773Dy4AcqrYKG6a/ubYkgYTVCpbyQ00PDfDy5Pmlzcoc+cxbtDlFvC7zIn4JkUFgboiTtqYU3Jf7KtjRBF/aNmjKqhaxtGfFADzkfN0ss6sRUxBUzoIPI5kyPwrtvf0HIkh9KpdmSG9Xl+O2WmFlAR21TnTz49nOQk8mhnSR9jJDW3HrZ4own4NRm1Tkepw/UkTjFguOEjt/DEf7nj4MdnRgE74x77TTc5sDREevXT0m3fKQ7f5MXvBBQLOrTEObPAzG2yilNHujeOGC817iM6gLobl/00YIHoMjUCVKx8L4V8n0PLnS1z+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9QCexCMtHp+QrXVECFInsPc+kdTr3E98OU/n3QqREI=;
 b=uTjlfyfWJjZjdREIUzAzW7X9xAW8hbflqwdTTruX9L5S8uuCcLuVgfdVPwHX7hRRsyixfqUvjwLiS1+iBCdR5K0LlqlHmUELeJ5wDsqSoRYIrfTDLnO/cSXBBFPi9mpqmzMl1fGgC43lxaCWtWjD0moPE7t8be3zl4XACDI1VUI=
Received: from BN9PR03CA0105.namprd03.prod.outlook.com (2603:10b6:408:fd::20)
 by CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.29; Wed, 25 Sep
 2024 20:00:11 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::6e) by BN9PR03CA0105.outlook.office365.com
 (2603:10b6:408:fd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20 via Frontend
 Transport; Wed, 25 Sep 2024 20:00:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 20:00:10 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 15:00:08 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2 06/08] drm/amdgpu: Add few optimizations to userq fence
 driver
Date: Thu, 26 Sep 2024 01:29:26 +0530
Message-ID: <20240925195928.142001-6-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|CH3PR12MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b4bcbc-58a0-4085-a56a-08dcdd9ca9ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?weWHAt9tvj87MGk846dKuqAW+80B7ybgOYVC3+l845g+YZPLHFuSH3/KIKRV?=
 =?us-ascii?Q?DQ9wD0AH+J+awiof7wvbwWDqKA1zQ5z7LTbZJJRYxI6NAkh007GaJBoVT7IC?=
 =?us-ascii?Q?4NYvloDG77ya739kfuyxmTQg4yPe9F0VfGj+KhMNxrDn2NK7MgDG7AfdTIzV?=
 =?us-ascii?Q?1px+9drcmhbTGQt6v897v9HgsDaBSkHMNIZNQlrynFkRnGp46rOEqblela6e?=
 =?us-ascii?Q?mgUF99dpRx+E+p48b8pj5/kbN1oh7j3OEnfKsvLHNWdgDcibFZ6rSqBk5JYz?=
 =?us-ascii?Q?CZvg7Ahp7B1QfivR+/8iHbcJFH3vyFgUj9riCg8g1KX2MnKt1zqZAsliFwc2?=
 =?us-ascii?Q?gO26K6tVnZOb/i0TERlfkIjG5ckHOXzEeVNCE2SpTbzXhkrNVefubEyxGaNH?=
 =?us-ascii?Q?z81Gfd0F6fluYgr97aRf5vOJOjcTyRFYWA0gEX6+lVEtLM4q9yX1SNT7mtgS?=
 =?us-ascii?Q?JAbngaQ37OSXucJCFpyXJaBnoXnOYA88JeasoUZbf5/2aqD6DqokK8iehQgt?=
 =?us-ascii?Q?uSoX6gp9GZTSBjDHtDSlV8p+ZUmfIdPKeVHtuwWqWDPsx1gLzTxJ8VHoy0aH?=
 =?us-ascii?Q?rSShzZMMzNJhs4rrg2oyRbqDlhlan/k58c0oUNCMiCv5WHbE7+w908/MWvrs?=
 =?us-ascii?Q?F4rb87S9JMAZZtP6xtCZNkO9QbL0vIA+fGnbaQ7Usf7HhWdP+rW8tsvzvUiI?=
 =?us-ascii?Q?BPH04YNmfIu/BeMYsJyDMYPupSHSjblnYy46V6x5HSIuAJ5RUUnSMqkYMM93?=
 =?us-ascii?Q?egis//RsXAcG2pE2Xa1jJ5OdksvlJpdJ7hml5usgRHo145u8qfe/0gpvtOHX?=
 =?us-ascii?Q?NghInyo4oL0aGkqJxjBJn69B/6f7efXQRxze2sCo5FMIkz1VhR0sjqmBWBRf?=
 =?us-ascii?Q?qK284WXQfZTDgmiKGvojEtUIPEQv2kEkymitvTOkHABqUl8z5s956hOTpcWU?=
 =?us-ascii?Q?in/2dr4fi2p25tS2eU/CKk3BAcgm4MJX/P40w2q6K6d4tXnih/5p0vo2ppLq?=
 =?us-ascii?Q?WkpnkCJJkHtCVTJbu9t5VPw5l/MavPPdUwJnF4dpYb9BGLY7fo+FVuWFnhNd?=
 =?us-ascii?Q?nRtSNLzyjbp8ZDXyOIMLH9swGuZ9bvaBcUbKoNc3XBxISPfZmWNcTz6KEvnx?=
 =?us-ascii?Q?McQsjERbbfkHlfQai7+o43WA6fWYi86UTOst5HMrxPECjNCkeNHs5kUZofTK?=
 =?us-ascii?Q?/FSVzr2+V4ZYM9lBSNnRPA0Et/W9tC8YA64Dv4CGOjZX13K5nbd7hiaUYVDW?=
 =?us-ascii?Q?bwbuzRAEYZ2piNimM8cH8dxPlxD7+Wjhi/wB2k5slLYHytlLLrjIfqNfpx1Z?=
 =?us-ascii?Q?CyUFpjAzvViVvNi/G1kIYPtob3wJdLz0d117LuGer+5XF9iHTKSURkTfQTrx?=
 =?us-ascii?Q?x+dji+kg2VS+j3t2iWOuJ8zzVlfhYurKqhGUE3w8/feiiMevJcbZITw8CDEz?=
 =?us-ascii?Q?t0vPi2JCXVzQrauL4QpHjCsrveurPFKH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 20:00:10.9662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b4bcbc-58a0-4085-a56a-08dcdd9ca9ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329
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

Add few optimizations to userq fence driver.

v1:(Christian):
  - Remove unnecessary comments.
  - In drm_exec_init call give num_bo_handles as last parameter it would
    making allocation of the array more efficient
  - Handle return value of __xa_store() and improve the error handling of
    amdgpu_userq_fence_driver_alloc().

v2:(Christian):
   - Revert userq_xa xarray init to XA_FLAGS_LOCK_IRQ.
   - move the xa_unlock before the error check of the call xa_err(__xa_store())
     and moved this change to a separate patch as this is adding a missing error
     handling.
   - Removed the unnecessary comments.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 44 ++++++++++++-------
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  6 +--
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  2 +-
 4 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 8d2a0331cd96..f3576c31428c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -76,7 +76,8 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
 	if (!fence_drv) {
 		DRM_ERROR("Failed to allocate memory for fence driver\n");
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto free_fence_drv;
 	}
 
 	/* Acquire seq64 memory */
@@ -84,7 +85,8 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 			       &fence_drv->cpu_addr);
 	if (r) {
 		kfree(fence_drv);
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto free_seq64;
 	}
 
 	memset(fence_drv->cpu_addr, 0, sizeof(u64));
@@ -94,7 +96,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	spin_lock_init(&fence_drv->fence_list_lock);
 
 	fence_drv->adev = adev;
-	fence_drv->uq_fence_drv_xa_ref = &userq->uq_fence_drv_xa;
+	fence_drv->fence_drv_xa_ptr = &userq->fence_drv_xa;
 	fence_drv->context = dma_fence_context_alloc(1);
 	get_task_comm(fence_drv->timeline_name, current);
 
@@ -106,6 +108,13 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	userq->fence_drv = fence_drv;
 
 	return 0;
+
+free_seq64:
+	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
+free_fence_drv:
+	kfree(fence_drv);
+
+	return r;
 }
 
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
@@ -147,7 +156,7 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 	struct amdgpu_device *adev = fence_drv->adev;
 	struct amdgpu_userq_fence *fence, *tmp;
 	struct xarray *xa = &adev->userq_xa;
-	unsigned long index;
+	unsigned long index, flags;
 	struct dma_fence *f;
 
 	spin_lock(&fence_drv->fence_list_lock);
@@ -164,11 +173,11 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 	}
 	spin_unlock(&fence_drv->fence_list_lock);
 
-	xa_lock(xa);
+	xa_lock_irqsave(xa, flags);
 	xa_for_each(xa, index, xa_fence_drv)
 		if (xa_fence_drv == fence_drv)
 			__xa_erase(xa, index);
-	xa_unlock(xa);
+	xa_unlock_irqrestore(xa, flags);
 
 	/* Free seq64 memory */
 	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
@@ -212,12 +221,12 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 	amdgpu_userq_fence_driver_get(fence_drv);
 	dma_fence_get(fence);
 
-	if (!xa_empty(&userq->uq_fence_drv_xa)) {
+	if (!xa_empty(&userq->fence_drv_xa)) {
 		struct amdgpu_userq_fence_driver *stored_fence_drv;
 		unsigned long index, count = 0;
 		int i = 0;
 
-		xa_for_each(&userq->uq_fence_drv_xa, index, stored_fence_drv)
+		xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
 			count++;
 
 		userq_fence->fence_drv_array =
@@ -226,9 +235,9 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 				       GFP_KERNEL);
 
 		if (userq_fence->fence_drv_array) {
-			xa_for_each(&userq->uq_fence_drv_xa, index, stored_fence_drv) {
+			xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv) {
 				userq_fence->fence_drv_array[i] = stored_fence_drv;
-				xa_erase(&userq->uq_fence_drv_xa, index);
+				xa_erase(&userq->fence_drv_xa, index);
 				i++;
 			}
 		}
@@ -378,7 +387,6 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	struct drm_exec exec;
 	u64 wptr;
 
-	/* Array of syncobj handles */
 	num_syncobj_handles = args->num_syncobj_handles;
 	syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles_array),
 				      sizeof(u32) * num_syncobj_handles);
@@ -400,7 +408,6 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	/* Array of bo handles */
 	num_bo_handles = args->num_bo_handles;
 	bo_handles = memdup_user(u64_to_user_ptr(args->bo_handles_array),
 				 sizeof(u32) * num_bo_handles);
@@ -422,7 +429,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, num_bo_handles);
+
+	/* Lock all BOs with retry handling */
 	drm_exec_until_all_locked(&exec) {
 		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 1);
 		drm_exec_retry_on_contention(&exec);
@@ -527,7 +536,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		goto free_timeline_handles;
 	}
 
-	/* Array of GEM object handles */
 	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
 	if (!gobj) {
 		r = -ENOMEM;
@@ -542,7 +550,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, num_bo_handles);
+
+	/* Lock all BOs with retry handling */
 	drm_exec_until_all_locked(&exec) {
 		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 0);
 		drm_exec_retry_on_contention(&exec);
@@ -702,8 +712,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			 * Otherwise, we would gather those references until we don't
 			 * have any more space left and crash.
 			 */
-			if (fence_drv->uq_fence_drv_xa_ref) {
-				r = xa_alloc(fence_drv->uq_fence_drv_xa_ref, &index, fence_drv,
+			if (fence_drv->fence_drv_xa_ptr) {
+				r = xa_alloc(fence_drv->fence_drv_xa_ptr, &index, fence_drv,
 					     xa_limit_32b, GFP_KERNEL);
 				if (r)
 					goto free_fences;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index f72424248cc5..89c82ba38b50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -54,7 +54,7 @@ struct amdgpu_userq_fence_driver {
 	spinlock_t fence_list_lock;
 	struct list_head fences;
 	struct amdgpu_device *adev;
-	struct xarray *uq_fence_drv_xa_ref;
+	struct xarray *fence_drv_xa_ptr;
 	char timeline_name[TASK_COMM_LEN];
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index e7f7354e0c0e..9b24218f7ad2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -48,8 +48,8 @@ static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
 static void
 amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
 {
-	amdgpu_userq_walk_and_drop_fence_drv(&userq->uq_fence_drv_xa);
-	xa_destroy(&userq->uq_fence_drv_xa);
+	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
+	xa_destroy(&userq->fence_drv_xa);
 	/* Drop the fence_drv reference held by user queue */
 	amdgpu_userq_fence_driver_put(userq->fence_drv);
 }
@@ -348,7 +348,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 	queue->doorbell_index = index;
 
-	xa_init_flags(&queue->uq_fence_drv_xa, XA_FLAGS_ALLOC);
+	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
 	r = amdgpu_userq_fence_driver_alloc(adev, queue);
 	if (r) {
 		DRM_ERROR("Failed to alloc fence driver\n");
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index d035b5c2b14b..6eb094a54f4b 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -52,7 +52,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_userq_obj	db_obj;
 	struct amdgpu_userq_obj fw_obj;
 	struct amdgpu_userq_obj wptr_obj;
-	struct xarray		uq_fence_drv_xa;
+	struct xarray		fence_drv_xa;
 	struct amdgpu_userq_fence_driver *fence_drv;
 	struct dma_fence	*last_fence;
 };
-- 
2.34.1

