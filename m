Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A97C77B73
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 612D610E491;
	Tue, 17 Jun 2025 03:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ozRNEeOH";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFA2F10E485
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKaS9zyriUun4AwG8hKS/WtAcXyHF3CRXVx68UV61FroHyy8gx1Nd/GAaPHTK4bP8sGhBZhuDvKU5w/ODFG/c9AbrgZK5osh2VT04qA4Df1mk/MyX0QQqC50pJPKZjvOSNVoBOpTT38baVfXHnP+GRiqxMPzl4Gt/3P/Sc+MI3K7H+SAAixh9kaH/mv+o5t8U30+xEcWWaC51xYary42maUcwDfaVVDs0K4mph7FuzPQyNDS6wcfb363w8kbAHYT849Fh8LVlSIpG7exh259NKxSvxFRfLI2RUaU5Q6xSSGQEHGSjKMuHpcpnmrISLxhXD8Xn9ChYXXRsPqN65ZhvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoJttPE1WbCiIy4+gh354KeDjThdlxVJUh0roB/zMe0=;
 b=hkiGZMmFeRBLMsLtIrEsbkkF9cuYikw+YYUt8NdzEcZaEuKole4sH89W5I8mw6IpStsjYr4yxK4hVLR7ycnITK8E310cyIR8UK8uoNVzJr1NZBXD0mKTlNQvnhB2OwSmfTwX6Rqfe0iAe6Yi2SXxd2hTXuxT/v6E1mSyKmn32jRJ9Lww1Cc3YnhlugjuvzEPNAIwfNkG1vKO6FETEUw/x4dxfaqD+qM460Ks7eXGjTj96KfjLAZ0jPEn8yUCFmV4jheJNngwUu8xDLwjXlmbWTjsNeY1f73TDZpYKiQttP4+o09PTI9JoJMA0LmQBgNtLomSUt+IJ7X2zG384Hhxog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoJttPE1WbCiIy4+gh354KeDjThdlxVJUh0roB/zMe0=;
 b=ozRNEeOHv3lGcj2iJprKzMbhIq+O8/EQ8DI5c3VnJ4/peRx9W1sgCz3LcXtFZQdh7C6h5xEso1iLs60UchhiCdlDBn0FtbS9FY7+C27r0xbRmn7svFPo8heJpR5r8DUH3CjQtLyCJxSrU+6x6OoLZgTPtlGSR1lrG9yUcZtLn9c=
Received: from MW4PR03CA0002.namprd03.prod.outlook.com (2603:10b6:303:8f::7)
 by MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 03:08:43 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::81) by MW4PR03CA0002.outlook.office365.com
 (2603:10b6:303:8f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 17 Jun 2025 03:08:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/36] drm/amdgpu: move scheduler wqueue handling into
 callbacks
Date: Mon, 16 Jun 2025 23:07:51 -0400
Message-ID: <20250617030815.5785-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|MN2PR12MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d7d009-1da4-4a4b-657d-08ddad4c4409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8c3B7/Yvphuj7qUlQ3TFWveBPKFuW/itQtAnGeKqyPfOM1w5VmLEb6ai+scC?=
 =?us-ascii?Q?+AeyaMdyYd6PoheT1LK4K4jAPNzYkqSUDN7BBGDoLcWvac7aUysEy4k0TKSX?=
 =?us-ascii?Q?aNcfQ3X8jM6K1HnqogrkYaTfO9FyYJFV/nhjnM02XouESVpRetHsq1S4TMaE?=
 =?us-ascii?Q?fqpCuSWLRNmqXWXI7zNwcesS/SAH13CJWsQPccqsAR2Ovrp8C6wYETHwO2ld?=
 =?us-ascii?Q?s3euUGKkSkAcGvkR1GGWwFWfDI1NxdXA96JOMV9MeSM9VHLci/lRsmiNed06?=
 =?us-ascii?Q?ZqCcTFLMt/NDJSttzEsUWRPTPzvH3yJ8c7kiVrIHMwmFilw60o9w3667ak85?=
 =?us-ascii?Q?0BQ8VdadjrnVO9EIm9VQdbHbc80cg7ijTZhjozEy2xQBKommiEY1x/omnrqs?=
 =?us-ascii?Q?eBCexsjZsHPndjHxsgopUYa6Uq+7q1CzNZ4ma1FZKtTVFbXxuxwgSRgqZrZb?=
 =?us-ascii?Q?pOrMiHBxcoKKpAIVgavxZvLk9OPlhulfIcYpM8v58jVo8jdj3cjAIaeXQVlZ?=
 =?us-ascii?Q?eeyd6eCWkvo7VHeWUx/CxKqHDxd4hfdNdiZxQsZKAsGFb/F+Uwjlu4H20ZJn?=
 =?us-ascii?Q?F22RRGmOyECIVAjRlEbxTy9Q/gdHtTEGbQKQvGOtaBIq2YuDjja4PlPFhgPc?=
 =?us-ascii?Q?Cp8/Eoegn3WSzeO3D76ZX07AdTLptWR78wqbKJYtR1hvHWrW3zRIkDZ8jdBW?=
 =?us-ascii?Q?jiybPC+ej+J+QZtsHzHrq2jgDthKcXRYoUz8EE50lAm/NNduKzjUQnrQB2Mf?=
 =?us-ascii?Q?VbmIlRRb/jPno/yryTmexYZJxHORla13T2NfSJ4J9JlMtPxOzopHcuPMOxEw?=
 =?us-ascii?Q?mI396WCgH8OUP85CTprEx88YY7zwPQ8DgRTO7LUq50rh8EHJeuYyD+e2vlqb?=
 =?us-ascii?Q?9X3yMHiPE1R9r/Y9SOA8c86oc+AhGewI4upZTMLPXYC3IgxZ27UiXy2BhQW8?=
 =?us-ascii?Q?hr1fkWXeA1ToT9mx/xTnAgbJJSDMgLKQ7EUG4ReebXi1PxKaIqQ1lRQqWGCa?=
 =?us-ascii?Q?4JZ7+9Uh1ghkYbvaEF0kxwtgF2I+4HtYsLBbQB/UTpMlRErOTW6zvDHWThaS?=
 =?us-ascii?Q?KGhZP6vJb0TK4+kTndARz7bPev4yv+wkaLUeNlsZMxdHaF9FRYXKp1rJnj1W?=
 =?us-ascii?Q?wytY+p1/CeOMVO7jMvYK1hCQcEsgAi/JAXVBKyzqu6luKp3hKsM7Q+gvCe6W?=
 =?us-ascii?Q?GKsI7SHBjWS0LcEhFikBXt7xjTXwtl7gQdjF9xaYmYiIN81kiDfgBdJRTv/k?=
 =?us-ascii?Q?NRjwHmhy62CFEKqxEtcV/PSM02cmSKhB+VKyMSbgP5+WBwKqCWY8smfrqJfq?=
 =?us-ascii?Q?l+EC8J7UdThoP3+apswdm3J3LRt8UP3EfglqOIEfSDLWEK0gX2EAgPCt8yei?=
 =?us-ascii?Q?MIGgkK01FpjU8FJPZ2D+PpWzR9I17J5dsCj4/wMxUNtOdPZl3EJyG1uaC8Ld?=
 =?us-ascii?Q?NNYdJ6iD17w56BGlMS1/UZEJgQbV69RpUxUjpidOF8oMuqV/wnbgYPdvBiXE?=
 =?us-ascii?Q?RD6dQWvH89qq3sw8yreZeTkOnFNKsWegSBZ6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:42.5705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d7d009-1da4-4a4b-657d-08ddad4c4409
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
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
index b4f4ad966db82..120d0d4f03a56 100644
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
index 5707ce7dd5c82..75196c0ba84b9 100644
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
index 259a83c3acb5d..543429054bfcd 100644
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
index e0dec946b7cdc..fd43c047991e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7168,6 +7168,8 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	drm_sched_wqueue_stop(&ring->sched);
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
@@ -7228,6 +7230,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
+	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index e5fcc63cd99df..08f01f64e1c24 100644
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
index 0b1fa35a441ae..2b02ecb94eeae 100644
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
index 7a9e91f6495de..d8ab2a96d445e 100644
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
index 81ee1ba4c0a3c..60ab0f2afeeff 100644
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
index 06f75091e1304..fad64d5cccd1f 100644
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
index 10a7b990b0adf..82ccab9cf0895 100644
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
index 88dea7a47a1e5..3ffc2a61e6bf0 100644
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
index 746f14862d9ff..6ba8cb5995779 100644
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
index 2e4c658598001..40416f2d03238 100644
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
index 0d73b2bd4aad6..1532e9d63e132 100644
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
index bf9edfef2107e..31cd27721782f 100644
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
index 3a3ed600e15f0..aefa2d77a73c4 100644
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
index c7953116ad532..1de81a7541bf8 100644
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

