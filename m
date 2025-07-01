Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D372C7EE30
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3FF910E2E0;
	Tue,  1 Jul 2025 18:45:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SUWSd5Yu";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A2B610E2D8
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSHh3kapXfQKEqClmDWydzPv9IqrUavrdFtb4VdAzJugzJRXj+Ya+D8hJZeBeJjWXjH580pjD7kx8MNRuV25zHiKLhx42QRt9gzKXuL0j6HJ7BtslDIvS3/lnBi3YgG0KuU9zNO5BIHwEIkI8k+r7hXoZO13L6veh56mzQvzktnGGrfk6rx9acRYdJp/VMjV4T3N5Z30OqAAc/5hYiG1/Vl0WQe2caYIDispp12O2LRNZd2upyUayUjpheYIVDss3XnC3/cE1lsUCxdGjlASY7IbkhcjojMgIZp8ClQwEtYvtbUjTTpFMd4DN3aPdtssO5IhkO3tEIuqrpI3DIWOeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytHx/cIhAhD2/7dcMoShfqtMt6iQj2JRYJws10tn9OA=;
 b=Op4OR/QBKIaMLsdVj9aaJ/5OCHxjzdJWHIjnOxu5AcTbywlP/iIW9ZBwGcVwntN045wOPespDRCzb6P2Ly9ZJUk6VssrUmZj2OWZ9FnCmrJaZdqqsD/9VTYdKkeRunTxDATNsZFPunnRvwMyNHya+39gKMfVei63Q0YxcleYRqwextBABGOVmLbJyw3HpWQbQgx48KUI7xYd+kTcVjZICfy/ZZf3XEXKm/Jexi9lLAa92QC7r2cwbRGK536D/L26Co6yFGLOH4wyDnaP8c7wqb1DFDz6/JQ3yJ/MAQrXBcLkfAYia81CEXXy9MaBjigMOOxPZxncITXuTidw7z/xjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytHx/cIhAhD2/7dcMoShfqtMt6iQj2JRYJws10tn9OA=;
 b=SUWSd5Yu4baF1MYj9IEZyJISZ8iDQTNNMfBSrA1I0hxVEe9HI8DeW8JGsEbGChdBqxJ92Okckoq/ZcFuqcllfo/3Bg7nc3sJLTCdHLa+PKnH/FhqFyRay4aK5i7zPJlA7EIU8LoBPD1rhjayiypaJH3p/UCf1yrTLooAlLeG1fw=
Received: from BL1PR13CA0392.namprd13.prod.outlook.com (2603:10b6:208:2c2::7)
 by BN7PPFFC4F04B28.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ea) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Tue, 1 Jul
 2025 18:45:08 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::1b) by BL1PR13CA0392.outlook.office365.com
 (2603:10b6:208:2c2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.18 via Frontend Transport; Tue,
 1 Jul 2025 18:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/28] drm/amdgpu/sdma: allow caller to handle kernel rings in
 engine reset
Date: Tue, 1 Jul 2025 14:44:25 -0400
Message-ID: <20250701184451.11868-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|BN7PPFFC4F04B28:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac3bfb3-ac1a-409e-2dfd-08ddb8cf6730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N5hprcvyPYVXiphcS6NVBsI3uWDIG88K/VssFS2qEqecpvwlms2NN6oSHpf+?=
 =?us-ascii?Q?ivZZa9gI8Wpi4pMjriOR50ovEtVSyQexrHzLLvs2YatT7ewezC9X2NBIOuLw?=
 =?us-ascii?Q?VKMtquQRI11IsgfqNcRI1rReoe+yvhWLPrrob7CYWpKbaWs+yhzsSVQMsgRs?=
 =?us-ascii?Q?bghI2nAGGwLVnOUPRTDrYendrVLs0roSFEk3k4so629mOfQk1+4oJJOXCZum?=
 =?us-ascii?Q?xxHwoGQ+X44WW7d9Sbz+MQtKZl/lmE9PQIEHmYKY6A2znrskhsvzSGYKTsN1?=
 =?us-ascii?Q?MVrR1CSJe5EpkkQ/7XhaoTc+DL37cFIKbgcHgSZCBP768zTcq7AHkd0HHyon?=
 =?us-ascii?Q?/xFPqwqGRxWhpCM/HJk+vGwKxuGVmH9uxDg2yIjbPU9qBVTxS9NHzapYZ9tH?=
 =?us-ascii?Q?a+1WK7tSxge4CDfIXqoMsZ6nMpZgVVK07fhMneX6NPdUmZGrlhlz4qAEwdCf?=
 =?us-ascii?Q?ApQsbdL4IqL7O5BB34S0KyEtb8kC2gWUcZGdsRaK1+gopSpi+dQxJ5wpfoff?=
 =?us-ascii?Q?5u7ByoKz/08geX+I/D0kgfGtEqa7yYu9fBuADcBF7wvCc98wQzr0ARHtd4Jh?=
 =?us-ascii?Q?3Q7DfzEFoIrZfWsU/hzoeBMu8SD0TVWv2cHh+yWdhHfv2xTliFUpaSvGxEx/?=
 =?us-ascii?Q?+Fp3Vn8g6uUg/Zi+giFAXMnPdmyxocH72Qin5LQblWE02BFysPmBwSKS7QCE?=
 =?us-ascii?Q?L9/UxPV0Ps7whgIXBOUEJceFSjoL433AQELz8f98H84dSXcd7jSOqeksCnya?=
 =?us-ascii?Q?mtvumiLMLN6fxyq9hp//dL+n1xoHOnzV7uuF4pKnlUIPB65NrdJ0lHmIa98p?=
 =?us-ascii?Q?dL3XbvJJ/Yq5DkhZZ70FsARUSkE2spcuMwYor3L+95hqz6omWWfPpEAA8vdq?=
 =?us-ascii?Q?QbiVflB0dMNTHsstwNCEmoAdkUr/iQnlBZHhE2Jr6b1bXlXr30RUADZunhqJ?=
 =?us-ascii?Q?2QFi6F2xGJQMBPdQAzd9IHI+zk+zQ3cRO3AeLE9khbmKdqmg344HAbo/2LUL?=
 =?us-ascii?Q?vYzYjQcdzc87unafK9NDYJfvOizEbsjNx1VPhZ/dCulN0/WILdmBAEGwxhSC?=
 =?us-ascii?Q?w6ZJqjpfg02WDBL5WI+Fr6mghh57cg5BdnuVpmwm/0u2lR0lGSbdIkyiv7e3?=
 =?us-ascii?Q?JY3Wq/NT28lQVpCL63jxrpB1O6JONZrk2kZkO2uYFsrplzL19rTSvOU3MvDi?=
 =?us-ascii?Q?Azhn+5sUpokuWNdoRY0PIDuClWEHuo2zM3a+tNOZx6iw75WaQj19j19M++t+?=
 =?us-ascii?Q?gAjhTBAAAHKR/nTcqP6f5jWpc27jtawK7hYOg9x+l7H2hwSzGguh9cDxm+ps?=
 =?us-ascii?Q?w1+8aWpYp5HPRTaRgYILa1voE4vlOptYSSYNJsbQYIJxQDBjOq5AfLA/jl34?=
 =?us-ascii?Q?sPH3Oqvxgp5xFCqKZIfC0SSp6RimAcot7BiVAzgnoPAvkhhykimmVA0LzjBK?=
 =?us-ascii?Q?bzBws4+aSXDqqlhapBsgX0/rPB24jTXc7t+Y/1ApcIBWnVDL2HC8AR/B0Hu8?=
 =?us-ascii?Q?k1qGzexqXnemNFkZQPzeFKXpGNBzq+F1/5A1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:08.4994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac3bfb3-ac1a-409e-2dfd-08ddb8cf6730
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFC4F04B28
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
index 91e8f45fe886e..4f98d4920f5cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -528,10 +528,13 @@ static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
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
@@ -539,14 +542,17 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
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
@@ -568,16 +574,18 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
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

