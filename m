Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457F0C7EE3A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 064F010E941;
	Fri, 27 Jun 2025 03:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="441NVcKk";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95B5D10E93A
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrTbSFVk4YduHdIhgMpFOykHBbUyxlobhrFdW23nct0Iamj/xiSzSBIFUHNPynK1XNcIQTm/oevjzv680GYmfpZd/euC2bzq8jPY4adP+lxdTH1WvEhoSSaxGbEuo6/xGf3NTQSsARo19yt48BJQSROv8X+ISJFukUjk8Rrs2fxtumqHhJRcqSRF0hyKng6zj1SPdxrqC48eXwhZUd0gkfBG1Yo/7gXDPtH8nxx/LqmsiwVBbAeAe1WsxM3Z9IOCcDg2jDPgeGxLEKMtxdOID9PZbBPHd9BKyIUg9WeZ8bLe5Lk8YerhVofu1FWkz2izq0L5DX0hg1pKnQIU642nJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzMcNteArU2QqRBWk3F6zvgJaIYA+nIZ7RnSeD8jQO0=;
 b=EmOkwAFoIQTSB4HIEF9kTH0YS9KrhUNq+AU/jtFBmYJuRstVYBMaGvJxjHJ4Blt8hTt7kQMCjY6N2VWaH2Yq3SgI6aNMkmrDWbswGMM4sgDZA/OsHmhqjWYuNeOg1wR8XqzwKev/ckbg1RDYEv28NbU7DWO9+1NjmTpGEMzjBTZFB/BBr2rBJMjL9XGylojI8ccXbHA4Hxn0E/1zqLNtwXWKv6yeQGVJcyUspY/Q/isUv4YNh6ft0liCsFo10s9D7d9ldTJBXXVtsBThkkByqHwn0vgX5f5zaDA+bTj54YhQPP+2PYHBdmBlo60BPPxXTfqVV1Xrd0M8v4Buo8ZpZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzMcNteArU2QqRBWk3F6zvgJaIYA+nIZ7RnSeD8jQO0=;
 b=441NVcKkJ7hiH0lZiqcIaSY4nxcJh1arPhOwIV1gLud1qcGZB8xltTWpp1xXr79i26VTVagulty0gNI/8ipD2s8n3UFvUgx89qdjqrebdtY3/W6RQUd1rlldUtUon94CUVBX7geX4n5p5c+6FR5jvdOdxgjkPJx1/lPqzBDlE3I=
Received: from MN2PR08CA0003.namprd08.prod.outlook.com (2603:10b6:208:239::8)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 03:40:24 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::12) by MN2PR08CA0003.outlook.office365.com
 (2603:10b6:208:239::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.18 via Frontend Transport; Fri,
 27 Jun 2025 03:40:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/33] drm/amdgpu/sdma: allow caller to handle kernel rings in
 engine reset
Date: Thu, 26 Jun 2025 23:39:32 -0400
Message-ID: <20250627034002.5590-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|SA1PR12MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c6bddb-0083-4cb2-0239-08ddb52c594d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KaxxVqDYVwQeF7NaanjWdf8Pdlz32B+pHBRhbVICRdLW2YEpcRhOdN+7vhNm?=
 =?us-ascii?Q?ETOU0WDyT9BP77qxnIrlK8fAt10YPYG4DRj0f+W9rFRV8O5oBYni4zWlDJg6?=
 =?us-ascii?Q?1VEHeZXUqmX3AqALIE/jkIIWALhOEu8+3VrWNbG/ioDG5XpEvmc9eWMFfoGo?=
 =?us-ascii?Q?BrBsVHvHdliW9gxZQcK018ibD5yfiQrnJSjyAkMVlzWXG60q8zx1c4v77ZoA?=
 =?us-ascii?Q?9o6bn1xWmQVIEXQwvf28iZ+oUsYPI3Goz7dYHd0Vsoj9tD3nC+Y3BifIVB/x?=
 =?us-ascii?Q?FBNflA2e1rQkwAJ0I4ycE0+XYQ0RtSjJoYaXm+l071038vZ4Msa2qLUbpyOk?=
 =?us-ascii?Q?pGhDIoazbQdFnw5fpKs7hfOeKM0T5x+Ay/1+5fCUqxGIRVuJDq8NY22mtOkc?=
 =?us-ascii?Q?UzMftLMYt1G7aYFE48WVAIz6Bjvk0Rkg2YJRKHpyVxuCCvaGc2UrrNn93fzP?=
 =?us-ascii?Q?Zf4p9aWkHF7wBBSM28Pev+nuhLdOor+7WDmrwNts9U1+kRADhy26L2I/OH3T?=
 =?us-ascii?Q?d65qXg8hVqqxKhAPcZSr82961OglbI4nZ+f5HdkupWz42QS00cLQRNU0yUZv?=
 =?us-ascii?Q?PXbPPAFkbF14kpQbx08rvohbFPmv93B19u0GA/Kz7s3zwdo9FMOue1F4Nxdu?=
 =?us-ascii?Q?C/3TmNAADD/avN840PxqItakWJU3aPsB6IaInySpQAPFIqGeiQ0v2U5mQtLJ?=
 =?us-ascii?Q?HdwOVGhFEXFk1oDx8BAb+OJsBZgt78tujMPBbXqsoi5zEPuTRhniOgjLMR0z?=
 =?us-ascii?Q?lsX4CIvRckWr0j9kPT19xjdF9seF/pFTudGbbmp7kqSWR5Y8lDrMSlk1IspP?=
 =?us-ascii?Q?p1r78oO7iXoVOZiTbkaf9zxogvIONhl9C5utsDvAMvK6ngInDCvILVt7+GDt?=
 =?us-ascii?Q?X5A1b/DrGmmaBoFavJ7XW+ySjGg8Rj0TBUEbUJj8riv97eH+9ZUtVOB3qzea?=
 =?us-ascii?Q?nidb7RZmug5v8s8InhRf4RAy2eu8sU484+44BlGf10b6fJ2zjhvC4RSpRPx/?=
 =?us-ascii?Q?SGpN5kuwOr/AxK05G1XCXEyDAgzIzjJ2OKepPMrO9MVPaaTFn0cSRm1T2+PM?=
 =?us-ascii?Q?m5qD2BhzS9x8TdY/sKZVu6LL7ujSVyRcg+GbSOOVf/hpUZuAfa/4HqKf8d8l?=
 =?us-ascii?Q?H9p9EiMsWF28tdhjtqHbhZ/gUrBDgoPu2FcF5LaCAr1P4s86ZVQMvLSsRyz1?=
 =?us-ascii?Q?SRSmxT7I/gYUGZQiAm0wb0Ygq6McQy9Ffj6Dbv+YthrLXBEYL/UFEZvL7ZJj?=
 =?us-ascii?Q?25IfffFa9VbQkVNTNRdf1BS8e4P0HLmebDdzz9zEKnSdWIDpiIG1XOxKn3lA?=
 =?us-ascii?Q?6TIWN9Lk49gu7wFp+dAmF/nlaQoylkamXm8B53io2CXvTgvsOOn6sCXXweCY?=
 =?us-ascii?Q?GWtm8WsrKiT/hxj5BXtAHuVprjV1l8D22JwFgID6NBs6ljDuTi3m4/govS/p?=
 =?us-ascii?Q?DvrvYhAZUSZrxjCGv+YI3XsrtPClgLfylz5bHm700xsBWiWoZVr+dIYCHLFF?=
 =?us-ascii?Q?8exoF1gqG//eTNxyiOuhp7T0Uy70sRTKcgI1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:23.7434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c6bddb-0083-4cb2-0239-08ddb52c594d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613
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

Add a parameter to amdgpu_sdma_reset_engine() to let the
caller handle the kernel rings.  This allows the kernel
rings to back up their unprocessed state if the reset comes in
via the drm scheduler rather than KFD.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      | 44 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      |  3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
 6 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 56939bb1d1a95..8b8a04138711c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -545,10 +545,13 @@ static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
  * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
  * @adev: Pointer to the AMDGPU device
  * @instance_id: Logical ID of the SDMA engine instance to reset
+ * @caller_handles_kernel_queues: Skip kernel queue processing. Caller
+ * will handle it.
  *
  * Returns: 0 on success, or a negative error code on failure.
  */
-int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
+int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
+			     bool caller_handles_kernel_queues)
 {
 	int ret = 0;
 	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
@@ -556,14 +559,17 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 	struct amdgpu_ring *page_ring = &sdma_instance->page;
 
 	mutex_lock(&sdma_instance->engine_reset_mutex);
-	/* Stop the scheduler's work queue for the GFX and page rings if they are running.
-	* This ensures that no new tasks are submitted to the queues while
-	* the reset is in progress.
-	*/
-	drm_sched_wqueue_stop(&gfx_ring->sched);
 
-	if (adev->sdma.has_page_queue)
-		drm_sched_wqueue_stop(&page_ring->sched);
+	if (!caller_handles_kernel_queues) {
+		/* Stop the scheduler's work queue for the GFX and page rings if they are running.
+		 * This ensures that no new tasks are submitted to the queues while
+		 * the reset is in progress.
+		 */
+		drm_sched_wqueue_stop(&gfx_ring->sched);
+
+		if (adev->sdma.has_page_queue)
+			drm_sched_wqueue_stop(&page_ring->sched);
+	}
 
 	if (sdma_instance->funcs->stop_kernel_queue) {
 		sdma_instance->funcs->stop_kernel_queue(gfx_ring);
@@ -585,16 +591,18 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 	}
 
 exit:
-	/* Restart the scheduler's work queue for the GFX and page rings
-	 * if they were stopped by this function. This allows new tasks
-	 * to be submitted to the queues after the reset is complete.
-	 */
-	if (!ret) {
-		amdgpu_fence_driver_force_completion(gfx_ring);
-		drm_sched_wqueue_start(&gfx_ring->sched);
-		if (adev->sdma.has_page_queue) {
-			amdgpu_fence_driver_force_completion(page_ring);
-			drm_sched_wqueue_start(&page_ring->sched);
+	if (!caller_handles_kernel_queues) {
+		/* Restart the scheduler's work queue for the GFX and page rings
+		 * if they were stopped by this function. This allows new tasks
+		 * to be submitted to the queues after the reset is complete.
+		 */
+		if (!ret) {
+			amdgpu_fence_driver_force_completion(gfx_ring);
+			drm_sched_wqueue_start(&gfx_ring->sched);
+			if (adev->sdma.has_page_queue) {
+				amdgpu_fence_driver_force_completion(page_ring);
+				drm_sched_wqueue_start(&page_ring->sched);
+			}
 		}
 	}
 	mutex_unlock(&sdma_instance->engine_reset_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index e5f8951bbb6f4..34311f32be4c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -172,7 +172,8 @@ struct amdgpu_buffer_funcs {
 				 uint32_t byte_count);
 };
 
-int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id);
+int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
+			     bool caller_handles_kernel_queues);
 
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
 #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 572d105420ec3..c0c418aa2c299 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1668,7 +1668,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 		return -EOPNOTSUPP;
 
 	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, id);
+	r = amdgpu_sdma_reset_engine(adev, id, false);
 	amdgpu_amdkfd_resume(adev, true);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index ed1706da7deec..5a1098bdd8256 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1548,7 +1548,7 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
 	int r;
 
 	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, inst_id);
+	r = amdgpu_sdma_reset_engine(adev, inst_id, false);
 	amdgpu_amdkfd_resume(adev, true);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index b87a4b44fa939..6843c2c3d71f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1461,7 +1461,7 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
 	int r;
 
 	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, inst_id);
+	r = amdgpu_sdma_reset_engine(adev, inst_id, false);
 	amdgpu_amdkfd_resume(adev, true);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 76359c6a3f3a4..f0d19f6ed9ba8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2312,7 +2312,7 @@ static int reset_hung_queues_sdma(struct device_queue_manager *dqm)
 				continue;
 
 			/* Reset engine and check. */
-			if (amdgpu_sdma_reset_engine(dqm->dev->adev, i) ||
+			if (amdgpu_sdma_reset_engine(dqm->dev->adev, i, false) ||
 			    dqm->dev->kfd2kgd->hqd_sdma_get_doorbell(dqm->dev->adev, i, j) ||
 			    !set_sdma_queue_as_reset(dqm, doorbell_off)) {
 				r = -ENOTRECOVERABLE;
-- 
2.50.0

