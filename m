Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF13C7EE33
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5822210E40C;
	Mon, 23 Jun 2025 16:15:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Dl0Yl6+";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44ABE10E408
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSwjCkhj3yEYr2gedSsu4Rh6SPAtni6aUsctzR3/1ph2PH3ydxGbmB2VsfsRm1I579ON76FsjF2P0JOPm4hknIdKzrcyK37FbzxHpmD439mgo+3fGAFgAjez27jMCH6ycLjqo4US4N+slABNKGxOol2oxWQVgyOi+7MgTMrWvboyiSsG4+3CTtK1MAlXdcxaDtAAjK0Urfz0bOYZK8QgD12PXhu3Hq3QiZe5wx1RCfUTj4AV8og910Zmzm6PBv3HJWla/i70eKmt/JvYEDMsVa3XYggECGFZUDW2cNfLzIlMo3T/wCBb94VdEjDtubQtbw9bFaaR+F4KPckN36j8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+eCtqvGAWiXyIprWvutEg1rK5hAmMZyn12JDWH5rC0=;
 b=DYF1RZivR6ga4IJ13Xfvlg6kcfcWTozJqvBJNfUQ54p2JUpnyS3cDOUz1p3+dfzUC8QPI8w1g21CmwrIXHxacOOPQEwcUUMfrAvqo0Nt1VdZ+p5/i47ybpR7QzLBIkh/nNTgCu/ZMssPhJkhwtjWzj39MiOZuNxwj8v3HssBADi6ApwOPVRmo06R9L39IXho2Vxtuf80A9SMQ2mF6LNWpKxTce2Y0PQmN/a2ac82vdbhD12eocvMOZfzZxcII69UbK49culIggLbzHJ1EwdcHIEwCrNRbTQe8uuQ5E5bPWTaNOIorq9nOGQ9Iu2PC9f5GqFuImsg+yqUAW82411xIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+eCtqvGAWiXyIprWvutEg1rK5hAmMZyn12JDWH5rC0=;
 b=3Dl0Yl6+mlvz22fjQ6ykkQZbensTqdNzURxZDNys2ESQm+D3KC/nBk4DfHs14IVzHQSnF6itOp3/5jOnHgYzDTGP8lAejXQVZMdjqztAGDFV/HcND65Eb/8IXVHB+wcM6EPslp+9hPQ35Y4qqENjSFHTs37ePP0IACSSa+DH4hQ=
Received: from BN9PR03CA0062.namprd03.prod.outlook.com (2603:10b6:408:fc::7)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.35; Mon, 23 Jun
 2025 16:15:01 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::62) by BN9PR03CA0062.outlook.office365.com
 (2603:10b6:408:fc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.32 via Frontend Transport; Mon,
 23 Jun 2025 16:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:14:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/31] drm/amdgpu: move scheduler wqueue handling into
 callbacks
Date: Mon, 23 Jun 2025 12:14:13 -0400
Message-ID: <20250623161438.124020-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DM6PR12MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9161f4-3522-4b16-8077-08ddb2711b1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U5EvjeN0060f3iVHu2yrgEbmMAmKhp/pAtofoAF72A+Za4pUEgM2xSTEcFF9?=
 =?us-ascii?Q?DZXK2nTw2TfME8XTLGJAOX1lBpUhN3SQYyj0TpSj3TvCQmklFQolasTHQjuj?=
 =?us-ascii?Q?uQJzwU0olKJQUYFEcdtu7tWvlvRTQDtPJc+PUcTCJTNohsLEnuW8UU4oCKL3?=
 =?us-ascii?Q?8y7pwjl7VQ6au2Hy7EVabe6GErBR5IKIIexqx+VagKfAoISvxSI94PAgjDzc?=
 =?us-ascii?Q?CUJv69e4IyIRTPAnvClRWfDbFkuDGOAYfrYGMRiHUQ8Aehmc7+bMbBWajkGU?=
 =?us-ascii?Q?Tn4wUldX9PsaVyywRti05CK1fmkIJ5UuenS5lNpLz5dkNZNAVwd/c3XJddIk?=
 =?us-ascii?Q?qMDL5tUbu7qln8dKupP8ofV+rftuooMLCE+nudMetqJXLHsWq+IgnGrX0dIh?=
 =?us-ascii?Q?mqECaCJbc2p51NB+vLZaxRojJmcnb3oQDY2sNFvhzR+Ky9/zT2EoglY9HL2i?=
 =?us-ascii?Q?oQU+Xz80y2pFbu40JmoUpz5zaZeG9cG87zW4zufkriN3Dezjl3LDMpO3ORRq?=
 =?us-ascii?Q?ezcNYfH8LdhPnM3khbUPOcclTxoXAK/XJJKvXFxhms7vpG0GQdDvecXinCYy?=
 =?us-ascii?Q?gy5MfRi4bXo2Cq6SNpYfNzUSGwqN4afYtrsR6G9opLdNfAWHzGdyE70ofh4A?=
 =?us-ascii?Q?2j4jqhl0ndwicGwK5+2It60WGD4NAZ3ippbJ8XHHML1lSiebm96OZq8rTfFY?=
 =?us-ascii?Q?c+TQjpbNYycUH5L4ZWwOXMCja184xo7jJmgxy12zqupmh0kpUwPuA6k90aDU?=
 =?us-ascii?Q?LZkUwWbwcQSEIeHPa+Eq5GLF4cfFfMGGWv7Ede3I9qlfUREowP73xJ7ZfP++?=
 =?us-ascii?Q?btY5Y4UWObkUaZfEvltK3GE6KiFdQRU/UTO4nwbmbUC3JufYB+VdNyES8iZg?=
 =?us-ascii?Q?sMKEatOSFldHdoVqF3gogBVRaPI0y9d3RVPuxmDz8XTy1RnrCha6R7L+Ein7?=
 =?us-ascii?Q?sGEYcIME4nmZUegrKzGzUu4FYWAJqCY3D1ehOhLHsqO/d7iS1mSVRZTzD/4l?=
 =?us-ascii?Q?QTixIMRfl3PDxv8WZ22W9W8iwf9iL1oyClQUsrCENXRvFgiG1J3hdwkFmpl1?=
 =?us-ascii?Q?RwJQks87KDdrAHYndSq+g8VRg9BSmRYYFEGvStrMWVBo/cYkalN5St8XP6aN?=
 =?us-ascii?Q?HCr7i43PfbVqIq/f0G7ZYEgYPi+gSjaYzx3WHnNeTy/FGDEUBsCrsuFlrBZv?=
 =?us-ascii?Q?3M7R8MkIUSWcIkNVfnj+lvJzvwXJ+g89SQsg0nCzaF6kJdEoIGj7Q7nze6nc?=
 =?us-ascii?Q?6B9SNdwv/BMCg7/mBrrbBnjGodXYz82AZTCVpg9wHOxfyuQe5tVhlqEXymKT?=
 =?us-ascii?Q?XiD4MIJsPm7uRW6OrHS+shy6LjeNUuc3PwhrxwsFcmr/1LkRjTUuuB9I9lgJ?=
 =?us-ascii?Q?0vQwMVdyfrTrayQ375BiFaLNyJrJs/sKryKC3dkFV00ElNqiEogno1q0c3DV?=
 =?us-ascii?Q?ScAxE7FtAMJOdosHwGBNuN8cdTbbwBXfjk5JhQhAghYeo17dlMoQzZvGC4O5?=
 =?us-ascii?Q?1gf1U1DUp2cz1Wv8KiSWE/4Lz8kV9mSDlXY4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:01.2081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9161f4-3522-4b16-8077-08ddb2711b1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
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

Move the scheduler wqueue stopping and starting into
the ring reset callbacks.  On some IPs we have to reset
an engine which may have multiple queues.  Move the wqueue
handling into the backend so we can handle them as needed
based on the type of reset available.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  8 --------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 17 ++++-------------
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  3 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  3 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  2 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  2 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  2 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  3 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  3 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  3 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  2 ++
 19 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 3b7d3844a74bc..f0b7080dccb8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -135,17 +135,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
-
-		/*
-		 * Stop the scheduler to prevent anybody else from touching the
-		 * ring buffer.
-		 */
-		drm_sched_wqueue_stop(&ring->sched);
-
 		r = amdgpu_ring_reset(ring, job->vmid, NULL);
 		if (!r) {
 			atomic_inc(&ring->adev->gpu_reset_counter);
-			drm_sched_wqueue_start(&ring->sched);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
 				ring->sched.name);
 			drm_dev_wedged_event(adev_to_drm(adev),
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index cf5733d5d26dd..7e26a44dcc1fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -554,22 +554,16 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
 	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
 	struct amdgpu_ring *page_ring = &sdma_instance->page;
-	bool gfx_sched_stopped = false, page_sched_stopped = false;
 
 	mutex_lock(&sdma_instance->engine_reset_mutex);
 	/* Stop the scheduler's work queue for the GFX and page rings if they are running.
 	* This ensures that no new tasks are submitted to the queues while
 	* the reset is in progress.
 	*/
-	if (!amdgpu_ring_sched_ready(gfx_ring)) {
-		drm_sched_wqueue_stop(&gfx_ring->sched);
-		gfx_sched_stopped = true;
-	}
+	drm_sched_wqueue_stop(&gfx_ring->sched);
 
-	if (adev->sdma.has_page_queue && !amdgpu_ring_sched_ready(page_ring)) {
+	if (adev->sdma.has_page_queue)
 		drm_sched_wqueue_stop(&page_ring->sched);
-		page_sched_stopped = true;
-	}
 
 	if (sdma_instance->funcs->stop_kernel_queue) {
 		sdma_instance->funcs->stop_kernel_queue(gfx_ring);
@@ -596,12 +590,9 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 	 * to be submitted to the queues after the reset is complete.
 	 */
 	if (!ret) {
-		if (gfx_sched_stopped && amdgpu_ring_sched_ready(gfx_ring)) {
-			drm_sched_wqueue_start(&gfx_ring->sched);
-		}
-		if (page_sched_stopped && amdgpu_ring_sched_ready(page_ring)) {
+		drm_sched_wqueue_start(&gfx_ring->sched);
+		if (adev->sdma.has_page_queue)
 			drm_sched_wqueue_start(&page_ring->sched);
-		}
 	}
 	mutex_unlock(&sdma_instance->engine_reset_mutex);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 4d0ee3ffe9858..8c377ecbb8a75 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9540,6 +9540,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, 5 + 7 + 7 + kiq->pmf->map_queues_size)) {
@@ -9581,6 +9583,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
@@ -9600,6 +9603,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
@@ -9658,6 +9663,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 39f4dd18c277b..37dcec2d07841 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6821,6 +6821,8 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r) {
 
@@ -6846,6 +6848,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
@@ -6989,6 +6992,8 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
@@ -7012,6 +7017,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 964fa3f2e2719..e4fc42470cf3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5317,6 +5317,8 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r) {
 		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
@@ -5341,6 +5343,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
@@ -5437,6 +5440,8 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
@@ -5460,6 +5465,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 95e319974f221..76ba664efecb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7187,6 +7187,8 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
@@ -7247,6 +7249,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 8bfee17a826e2..daed0f187bda5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3567,6 +3567,8 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
@@ -3625,6 +3627,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 6621a7b1f29fc..781a5a8a83614 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -770,12 +770,14 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
+	drm_sched_wqueue_stop(&ring->sched);
 	jpeg_v2_0_stop(ring->adev);
 	jpeg_v2_0_start(ring->adev);
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 44a5c0e82ca43..5be9cdcae32c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -649,12 +649,14 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
+	drm_sched_wqueue_stop(&ring->sched);
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index e813af4eedd21..a24bd833d6442 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -561,12 +561,14 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
+	drm_sched_wqueue_stop(&ring->sched);
 	jpeg_v3_0_stop(ring->adev);
 	jpeg_v3_0_start(ring->adev);
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 190f0742d7016..1d4edd77837d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -729,12 +729,14 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EINVAL;
 
+	drm_sched_wqueue_stop(&ring->sched);
 	jpeg_v4_0_stop(ring->adev);
 	jpeg_v4_0_start(ring->adev);
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 04755b7a62d9b..78441f8fce972 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1152,12 +1152,14 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
+	drm_sched_wqueue_stop(&ring->sched);
 	jpeg_v4_0_3_core_stall_reset(ring);
 	jpeg_v4_0_3_start_jrbc(ring);
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index e7f942dc714a7..6f8a16da9d608 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -843,12 +843,14 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
+	drm_sched_wqueue_stop(&ring->sched);
 	jpeg_v5_0_1_core_stall_reset(ring);
 	jpeg_v5_0_1_init_jrbc(ring);
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 0c8707b18b5cc..ffb90b42a3e34 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1557,6 +1557,8 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
 	if (r)
 		return r;
@@ -1565,6 +1567,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 341695d0afb52..d51833f942427 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -822,6 +822,8 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
 	if (r)
 		return r;
@@ -830,6 +832,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 6c25e9fc4f0f9..eec9133e1b2c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1978,6 +1978,7 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
+	drm_sched_wqueue_stop(&ring->sched);
 	vcn_v4_0_stop(vinst);
 	vcn_v4_0_start(vinst);
 
@@ -1985,6 +1986,7 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 1e1dd61b774ec..d8fd32c1e38ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1609,6 +1609,8 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	vcn_inst = GET_INST(VCN, ring->me);
 	r = amdgpu_dpm_reset_vcn(adev, 1 << vcn_inst);
 
@@ -1626,6 +1628,7 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 9c02446bb1a54..7e37ddea63550 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1476,6 +1476,7 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
+	drm_sched_wqueue_stop(&ring->sched);
 	vcn_v4_0_5_stop(vinst);
 	vcn_v4_0_5_start(vinst);
 
@@ -1483,6 +1484,7 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index c8924f97cf58a..47c0bcc9e7d80 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1203,6 +1203,7 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
+	drm_sched_wqueue_stop(&ring->sched);
 	vcn_v5_0_0_stop(vinst);
 	vcn_v5_0_0_start(vinst);
 
@@ -1210,6 +1211,7 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
-- 
2.49.0

